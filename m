Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97A820740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 02:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2dPTR2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfL0Cjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 21:39:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53793 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfL0Cjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:39:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so7087591wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 18:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lNlw2hvCqhTrh/hZvwaoyx35sWfAeV4bWBqxx7AGW0w=;
        b=F2dPTR2AStguUI0ZR5BTvAtM2jM+BLo5sQxmbXTSSJlXPEQQ3GktJ6lkZ5oYt89sOV
         zB3Ni790ffOppqiBjBCnN/Hg3BkMX4Xlw0drIGqguSuIriiMYFxGllaetqKDkZsYspTI
         YYJS571HnR+MNI6xs/xYaeOqgnPfdnj2h8PdNjmdJcrcHAwujiu8/VV6SpS3/wy/sMAv
         ZCvGGSnfBWFGEb4hHSXKAaBXzaHoJ5f1MoWLNKmcUfgVlyEnFa8wahVAOn/S0sA5zgKK
         EI6my1UCUKT3/xv81m48pJXo/4LUdFtmfe98hTijeCe+DVhlzhmDQZQRlYy8iWhQmAhP
         tA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lNlw2hvCqhTrh/hZvwaoyx35sWfAeV4bWBqxx7AGW0w=;
        b=b+7tcbaqZsZG/slACE/uhxMFjGDAxVuSD1SHuUm2FADfB66L/dPFolrl5cis+tVewU
         XAGFv/JjETCRaM2Evyg4pGcTU8qny+AhEnATLqUHe2cs4pJJMuEtd95s6i/YIBimwPMu
         TvuoDOSf4YQdQZlHHPjZetIzANafEX6KJnIARjNuSHWNeREE34JqJPhRkmcZFKOSTwkz
         hkfKde49pjYbfmV2paXKRPWQK+/qvHnpTl52AI06ssgGH4NhQgGlfNXhCcLHGGqumWN5
         GYmZJrnRvV6Z3PEJYqV4j4NnaH2wKo2K1lEqOoKhy0Z2GTFX0lXq7a9On2OxPJA9IJG9
         KW5A==
X-Gm-Message-State: APjAAAVEjXjHLDGZmlBeSbRtj/j0y8jh1zuWPkA4ZDvAg2ehGlZl8OQh
        29RRZpWgYV+uIatZ33WQgWs=
X-Google-Smtp-Source: APXvYqx5WlxQynErEfGANcFG7+r9Q10F6BhK86BjHYn2T+iVZVD9jxFpM5SEG6hdH91wW3UV673v7A==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr16595270wmi.137.1577414370684;
        Thu, 26 Dec 2019 18:39:30 -0800 (PST)
Received: from zhanggen-UX430UQ ([95.179.219.143])
        by smtp.gmail.com with ESMTPSA id p18sm9733931wmb.8.2019.12.26.18.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 18:39:30 -0800 (PST)
Date:   Fri, 27 Dec 2019 10:39:21 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     nsekhar@ti.com, bgolaszewski@baylibre.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] board-dm644x-evm: fix 2 missing-check bugs in evm_led_setup()
Message-ID: <20191227023921.GA21233@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In evm_led_setup(), the allocation result of platform_device_alloc() and 
platform_device_add_data() should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 9d87d4e..9cd2785 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -352,15 +352,20 @@ evm_led_setup(struct i2c_client *client, int gpio, unsigned ngpio, void *c)
 	 * device unregistration ...
 	 */
 	evm_led_dev = platform_device_alloc("leds-gpio", 0);
-	platform_device_add_data(evm_led_dev,
+	if (!evm_led_dev)
+		return -ENOMEM;
+	status = platform_device_add_data(evm_led_dev,
 			&evm_led_data, sizeof evm_led_data);
+	if (status)
+		goto err;
 
 	evm_led_dev->dev.parent = &client->dev;
 	status = platform_device_add(evm_led_dev);
-	if (status < 0) {
-		platform_device_put(evm_led_dev);
-		evm_led_dev = NULL;
-	}
+	if (status)
+		goto err;
+err:
+	platform_device_put(evm_led_dev);
+	evm_led_dev = NULL;
 	return status;
 }
 
