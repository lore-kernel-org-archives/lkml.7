Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD2C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A44F2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eDnM5Smr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfFYQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:49:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40554 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFYQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:49:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so3662622wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpBEtYSgqrBi7j4SiCT1m6YSPtNFJxDP5oog1k2Dp/E=;
        b=eDnM5SmroyDBRGWomt4zm7VTbV4K8ugQm9G7mQkVjtkKKrgpPXvluSKc0vRgU+BNb1
         VpUb13atGzKgtE48uLL+hhQvMBm9nrkO/hshQUUBPnbzeI7eO2oFXOu/PfLFTvmUSWv+
         x7u4OqYLiuvEApl5clWFxy/edonhHNOkVcoa6DL6GKCw3W95w+/vY9iMBQZEbF4R2QRS
         lLKqTq8JHXN2kSAZndjbq6Wix02hiVIb2mJT5MSoSkAUY3hR43RXrZcC4LYzVLDMMY5A
         1zedhzJ1Y2ZuXVSUI//I5AgEyxzZ5K9tcypa/cdU1QDNyLXJkXuoQLX+foMyOZZwbDMF
         CA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpBEtYSgqrBi7j4SiCT1m6YSPtNFJxDP5oog1k2Dp/E=;
        b=cbnZmO8dW/E9HsPKda9BLtIOSmXegEiHB0RceL0wJ/zck5O7upX5WmZ6iRs25ohBMe
         GYgfRrr7jCQLfv6dBgRiVEX3/RFHb4ZO+1GfyZ65sSGUtfAN9cwAXL1BvfO4/AgXEeyC
         TYKBNLaJUFBZRrw1kTWtFyECzZG6Bk8O/JjtXCHxWH3ylDDTjMvA1lsyY8iYT36ExRBB
         fW6fIyftQgLSXCB8+ZMIOhheT5TJCyh29sEcyrWnoHLWinetER4l27osp9f87eB6DAvX
         icawtC6q4JU3FwyvEL+tOoMFkLGzzusribZ9g5xWauZg2z6wvGT66Ij0n/4kq5f9YhfU
         jM+Q==
X-Gm-Message-State: APjAAAUsOk9zNMcPhvQu/qxW4QbsP5l6uMEgQsWBMwP35PlUPK7WyniX
        bins2wpg4pDJYCPHEeejQs+ArA==
X-Google-Smtp-Source: APXvYqyVBBSlo04QiVVJZul9HxR3AfR32ezyhijOC6RrdMyx1+Q4KkR7gbPOK8c8SM4hhdG5xjAAig==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr20851213wmj.176.1561481363562;
        Tue, 25 Jun 2019 09:49:23 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h14sm3078652wro.30.2019.06.25.09.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:49:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] ARM: davinci: omapl138-hawk: add missing regulator constraints for OHCI
Date:   Tue, 25 Jun 2019 18:49:15 +0200
Message-Id: <20190625164915.30242-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164915.30242-1-brgl@bgdev.pl>
References: <20190625164915.30242-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We need to enable status changes for the fixed power supply for the USB
controller.

Fixes: 1d272894ec4f ("ARM: davinci: omapl138-hawk: add a fixed regulator for ohci-da8xx")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index db177a6a7e48..5390a8630cf0 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -306,6 +306,9 @@ static struct regulator_consumer_supply hawk_usb_supplies[] = {
 static struct regulator_init_data hawk_usb_vbus_data = {
 	.consumer_supplies	= hawk_usb_supplies,
 	.num_consumer_supplies	= ARRAY_SIZE(hawk_usb_supplies),
+	.constraints    = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
 };
 
 static struct fixed_voltage_config hawk_usb_vbus = {
-- 
2.21.0

