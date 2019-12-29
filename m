Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD52C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F020748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbTaJKNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfL2HEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 02:04:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35673 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2HEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 02:04:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so13481576plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 23:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n1ZIretUuwYS27kF3v+Hp7RCwHfW0a5srfNpI7eKUKM=;
        b=DbTaJKNmHjR8pHoCYz8lSyJ2JF9yLGmVHKl95Ek9hyUYXRRy0qGtX45vDJpwpfBSO4
         stxzKrebhMBw7k8YGUMnmRJqbcV2pP4/s5Vy+L7HudtP+kZ/tuZlqdR/UOjispYVb1H9
         FQKO1pB1VFVOypzeNx64mOBnnXodtCQjSRCC0jyDZc9+KirRboLZyv6jeowcGeA6qjWR
         MiTcICIxWt6LgcMQu3MZSSsiShGHMrt/TUxQLZkHLgQZKvqnenhm6vPwXXrvCq9NzAE7
         dXSJIr0UDR5anpm11DKX74itBrpkuANPCShJdF7eo0X3cQ9RxTwe/BSrRxsXddb1w5fy
         h55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n1ZIretUuwYS27kF3v+Hp7RCwHfW0a5srfNpI7eKUKM=;
        b=ia0DckmGGcLDLcivWRucz1RIFasrUdC9bJCGxnhrHo2AUsVGHz8MMCMpErai8BTl74
         Y8QnCh88xcvonCBOFTsq54Qk/kFwfwtl1Z+I32W9TMe3Ig0SVLTvZ5ffMhk2tnmpqfgA
         2DQ41zkURIJw96D1RzWwV22PrW9d0GtVJ7S9ZCe4faXDxMM+/vFLQc7/fqlMK3xE0CRf
         LtkWcIzMEvJCXrY4S6NpyBWptlmW/YgkQyybwbQA703hinon8cr1nm3ylV4A1G7/Onpu
         x1F5bNlpwS+YG7hd1PqYJMTgb2peibThaEIqGckwX0Vq9tj6gJldyIZlMgi6wFvU8jot
         2o2w==
X-Gm-Message-State: APjAAAVRaSTBV3sngKqMU/O6mM6G6RMNvrhuA0Xz1zS47Orutelv3SNw
        ZEAUgRFKdSJLJjMx+E1Yqi8=
X-Google-Smtp-Source: APXvYqyY4qsfUkk0mpCiCwhKOw49rlsTMICZf4xOFqTB7uss+cL58fqvOzq8fH+gk2cikOBdOGLB3w==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr46780422plk.47.1577603062666;
        Sat, 28 Dec 2019 23:04:22 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s21sm25211778pfe.20.2019.12.28.23.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 23:04:22 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     paulburton@kernel.org, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] auxdisplay: img-ascii-lcd: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 07:04:19 +0000
Message-Id: <20191229070419.5429-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/auxdisplay/img-ascii-lcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index efb928e25aef..1cce409ce5ca 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -356,7 +356,6 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct img_ascii_lcd_config *cfg;
 	struct img_ascii_lcd_ctx *ctx;
-	struct resource *res;
 	int err;
 
 	match = of_match_device(img_ascii_lcd_matches, &pdev->dev);
@@ -378,8 +377,7 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
 					 &ctx->offset))
 			return -EINVAL;
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		ctx->base = devm_ioremap_resource(&pdev->dev, res);
+		ctx->base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(ctx->base))
 			return PTR_ERR(ctx->base);
 	}
-- 
2.17.1

