Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10EDC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4C52071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402163;
	bh=SX2sF24SxxN0DTRfvAZ+p3qN/yPB1GS57zgjqYDAA+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rENkDKGU0zXUyDOR/f6L3y3JrVZX1QMbXCqkt5c2jlZVCjER3hIUsmg4xWmiJBK1
	 nNYVZAt/Fdw5SHZU+2nT0rtXk+1vvtNtWGQDvJsfc2D6KCdG+k4K96RG6jfsOH9+OZ
	 NID0rJZcqjIRhTdyEO7ln7wXIQQm99dS0UqVNgbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfKVF4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKVFz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:55:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA6620717;
        Fri, 22 Nov 2019 05:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402155;
        bh=SX2sF24SxxN0DTRfvAZ+p3qN/yPB1GS57zgjqYDAA+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzAj0Vc9yar85tYggVzWTDW15L/YtAPvrKz8cPCe+eMqfpDxaVdSzcW0iPJJzoKCZ
         dxKm4VkjU9kbEvBSxt4eKvmbkYglwe50XGF++yn6/1k0yrc18i1Enraod39ptHVR74
         0XaAWDf8APZ548kICWAdTlIfQXC0uxA4N0YokuJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 010/127] ARM: OMAP1: fix USB configuration for device-only setups
Date:   Fri, 22 Nov 2019 00:53:48 -0500
Message-Id: <20191122055544.3299-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

