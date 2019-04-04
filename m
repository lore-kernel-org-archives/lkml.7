Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A252B2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDDADV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:03:21 -0400
Received: from muru.com ([72.249.23.125]:44216 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDADU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:03:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C241803A;
        Thu,  4 Apr 2019 00:03:34 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:03:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
Message-ID: <20190404000316.GV49658@atomide.com>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321142838.22985-2-dmurphy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dan Murphy <dmurphy@ti.com> [190321 14:29]:
> Update the properties for the lm3532 device node for droid4.
> With this change the backlight LED string and the keypad
> LED strings will be controlled separately.

We also need the following incremental change to prevent
panel-dsi-cm trying to use of_find_backlight_by_node().
We have ledtrig-backlight use FB_EVENT_BLANK, and I
guess more events can be added there as needed.

There should be no dependency to the driver changes with
this patch, so it's probably best that I queue this dts
patch separately. I'll fold in the following change too
assuming no more comments.

Regards,

Tony

8< -----------------
diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -214,7 +214,6 @@
 
 		width-mm = <50>;
 		height-mm = <89>;
-		backlight = <&lcd_backlight>;
 
 		panel-timing {
 			clock-frequency = <0>;		/* Calculated by dsi */
