Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06AF21925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKKWha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:37:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:33642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKKWha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:37:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAEA9AC8B;
        Mon, 11 Nov 2019 22:37:28 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: ep93xx: Avoid soc_device_to_device()
Date:   Mon, 11 Nov 2019 23:37:22 +0100
Message-Id: <20191111223722.2364-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ep93xx_init_soc() uses soc_device_to_device() to return a device
to ep93xx_init_devices(), where it is passed on to its callers,
who all ignore the return value. As this helper is deprecated,
change the return type of ep93xx_init_devices() to void and
have ep93xx_init_soc() return the soc_device instead.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/mach-ep93xx/core.c     | 12 ++++--------
 arch/arm/mach-ep93xx/platform.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6fb19a393fd2..7a0c82b30564 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -937,7 +937,7 @@ static const char __init *ep93xx_get_machine_name(void)
 	return kasprintf(GFP_KERNEL,"%s", machine_desc->name);
 }
 
-static struct device __init *ep93xx_init_soc(void)
+static struct soc_device __init *ep93xx_init_soc(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
@@ -958,13 +958,11 @@ static struct device __init *ep93xx_init_soc(void)
 		return NULL;
 	}
 
-	return soc_device_to_device(soc_dev);
+	return soc_dev;
 }
 
-struct device __init *ep93xx_init_devices(void)
+void __init ep93xx_init_devices(void)
 {
-	struct device *parent;
-
 	/* Disallow access to MaverickCrunch initially */
 	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_CPENA);
 
@@ -975,7 +973,7 @@ struct device __init *ep93xx_init_devices(void)
 			       EP93XX_SYSCON_DEVCFG_GONIDE |
 			       EP93XX_SYSCON_DEVCFG_HONIDE);
 
-	parent = ep93xx_init_soc();
+	ep93xx_init_soc();
 
 	/* Get the GPIO working early, other devices need it */
 	platform_device_register(&ep93xx_gpio_device);
@@ -989,8 +987,6 @@ struct device __init *ep93xx_init_devices(void)
 	platform_device_register(&ep93xx_wdt_device);
 
 	gpio_led_register_device(-1, &ep93xx_led_data);
-
-	return parent;
 }
 
 void ep93xx_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-ep93xx/platform.h b/arch/arm/mach-ep93xx/platform.h
index b4045a186239..8a3a2be50f11 100644
--- a/arch/arm/mach-ep93xx/platform.h
+++ b/arch/arm/mach-ep93xx/platform.h
@@ -34,7 +34,7 @@ void ep93xx_register_ac97(void);
 void ep93xx_register_ide(void);
 void ep93xx_register_adc(void);
 
-struct device *ep93xx_init_devices(void);
+void ep93xx_init_devices(void);
 extern void ep93xx_timer_init(void);
 
 void ep93xx_restart(enum reboot_mode, const char *);
-- 
2.16.4

