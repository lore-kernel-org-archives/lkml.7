Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA859C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907AF2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414403;
	bh=SX2sF24SxxN0DTRfvAZ+p3qN/yPB1GS57zgjqYDAA+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pq2RPQXTnHRJEBEiMvGho7k295J9EeyUfP38cAp9GK77ACnhHJxdF0LIXllgs6lbl
	 YOW32KdCX1einnOpt3FjclLu/e3/HQ8mu3ZqHyWEPp72FYJIVL2fd4XsR65mnJz50c
	 6daBzjMZk5pXUgfcVhrUGThHevfkmVRiA/Nuqbmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfLCWs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbfLCWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F682084B;
        Tue,  3 Dec 2019 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413301;
        bh=SX2sF24SxxN0DTRfvAZ+p3qN/yPB1GS57zgjqYDAA+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHUDNhreEJDwCDV00pagPZKaNOv3u5PA+Oz4p99KhrTt5Y/JA7665wpgc/kyZAZ/W
         G/CIh7X2CeuM69rjlEvFE1EZSFpFmuICPUvuraNgSEmahc2CV3gKfrwPJNVZgAhdTo
         MHe8HCkfe7r/43HdzhZ49NczMspvEcW7V5uvKgpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/321] ARM: OMAP1: fix USB configuration for device-only setups
Date:   Tue,  3 Dec 2019 23:32:21 +0100
Message-Id: <20191203223431.063871371@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit c7b7b5cbd0c859b1546a5a3455d457708bdadf4c ]

Currently we do USB configuration only if the host mode (CONFIG_USB)
is enabled. But it should be done also in the case of device-only setups,
so change the condition to CONFIG_USB_SUPPORT. This allows to use
omap_udc on Palm Tungsten E.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/Makefile           | 2 +-
 arch/arm/mach-omap1/include/mach/usb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index e8ccf51c6f292..ec0235899de20 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -25,7 +25,7 @@ obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
 
 led-y := leds.o
 
-usb-fs-$(CONFIG_USB)			:= usb.o
+usb-fs-$(CONFIG_USB_SUPPORT)		:= usb.o
 obj-y					+= $(usb-fs-m) $(usb-fs-y)
 
 # Specific board support
diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 77867778d4ec7..5429d86c7190d 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/usb-omap1.h>
 
-#if IS_ENABLED(CONFIG_USB)
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 void omap1_usb_init(struct omap_usb_config *pdata);
 #else
 static inline void omap1_usb_init(struct omap_usb_config *pdata)
-- 
2.20.1



