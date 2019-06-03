Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F0FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDB926875
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559589825;
	bh=zSUCZi9f3ute9Iirc/j4KUANDwmTf9ovEvKzD92Z9Bw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=r0cEnJuXUjzCLE6VE/umyCkK0vGE5F7yNxgWru8nkiFUgqT10iOS3tTX9AMYypv1s
	 yOBNoqJmOMH5GfHLLvF4dn7RXQvDgKn6Ghx1+EyYpgFVelpn57eMoZgYVPni11hUwG
	 tvSZ4ft+sqJgEWfHpvilIhXgCvzJm0+3KtWZsFR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfFCTXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCTXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:23:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF1A72673F;
        Mon,  3 Jun 2019 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589823;
        bh=zSUCZi9f3ute9Iirc/j4KUANDwmTf9ovEvKzD92Z9Bw=;
        h=From:To:Cc:Subject:Date:From;
        b=T8PjXzzg1SsDfZCLz0MQmPvO3vIgdW+Udfpi4RFDHcWOFQF0yb0K4jMMcMQGMSNLn
         6XlCgTdIvta9rRjbcyuIL3jzEoupRY+LJJ20EjwJXC0nV552BkRcbo9UXF1S7/mTXH
         lvRF9WJp0kPt1mR9paKvil00fI3n4c5Uo5sq067g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Sinan Kaya <okaya@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] platform/x86: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Mon,  3 Jun 2019 21:23:38 +0200
Message-Id: <20190603192338.30836-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5d5cc6111081..bd15b47abcb4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -906,7 +906,6 @@ config TOSHIBA_WMI
 config ACPI_CMPC
 	tristate "CMPC Laptop Extras"
 	depends on ACPI && INPUT
-	depends on BACKLIGHT_LCD_SUPPORT
 	depends on RFKILL || RFKILL=n
 	select BACKLIGHT_CLASS_DEVICE
 	help
@@ -1130,7 +1129,6 @@ config INTEL_OAKTRAIL
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
 	depends on ACPI
-	depends on BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.17.1

