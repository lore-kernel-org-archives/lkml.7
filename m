Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30DC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71C020B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hoNbf0R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGCBDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:03:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38069 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfGCBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:03:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so439846wmj.3;
        Tue, 02 Jul 2019 18:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXVTCCtxl9em2owyf8s4bbeO9mK7cEItEViXYHsj0G0=;
        b=hoNbf0R4ebAsKTyC94FICS46RhUJwXy760CSyolqQmHWjfgvYUIWg5IS3nEkx+8yqg
         2McJS5dz80Lx1Z8oQHRILpdxY/WV3qVwOAcR9VZAvoL436zIfIg01KmG880yxrQ449/L
         S8axGKbf3+YMdw1kO4aOMgd/l9/+xOjqhSOPYyEUxNdnR4WmSHu+y9WNQ5/NJ87Pwi2k
         72zJViGmWtXNnJC/4wj653REAKkPBVmC97f/79s85uerpY4hc1j8Nu8s4zQS/ix3IJcK
         mu1pdj8lspLgoUDgtvxbsP6gSR+UhV3NQEcLBBiDH3Fdl+5aRxvIg3MlsrUS9beWx+Xs
         YL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXVTCCtxl9em2owyf8s4bbeO9mK7cEItEViXYHsj0G0=;
        b=nEyQM+5aj88m+2F6ngRglGC0SHf82jZyIRUBWf/uD/CW3uHqsbRc2zfKujEc1buchh
         qCr2CE5TojKedOqPp5vHPp/SGZtlSGzlQ9VzpBRkuCQuj5MS3LgcEGBjIs+EkcEEPgDg
         ipdx0gIIXAwWdrl348S3oUG5p9BYPN3yIuFChxNhFBIVyE9mXo7KIms56qTV2Vf8EzJk
         bLRUZyrDi3/ujXp6bIf9qUJXB9+9tcsugxLQqhY1XJS1iM2W6+3WzE9pU8nXKvGcPHdk
         XgajEIfeIeKhX+a7xYv67RRiHeLze1pzBpL40tLNiamMzPBa+Z/f63IXSemcErFksmnZ
         7mFg==
X-Gm-Message-State: APjAAAX570SoGII8FnCrH27//R7aaWalR1fTxTHKVtVe+2jvsw1o6iKv
        GiEV0Y2YP0VL1My6xVSSZ4xHK19K
X-Google-Smtp-Source: APXvYqy+6ZeFmLvkHjQcUHqawZp5G5et8V7h/rxdioXafSpBMRoBFLtKq+pDRm7nmKAwmRvg6p4Ykw==
X-Received: by 2002:a1c:c305:: with SMTP id t5mr4631536wmf.163.1562106789299;
        Tue, 02 Jul 2019 15:33:09 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133D62000A09003363445C98E.dip0.t-ipconnect.de. [2003:f1:33d6:2000:a090:336:3445:c98e])
        by smtp.googlemail.com with ESMTPSA id 18sm253513wmg.43.2019.07.02.15.33.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 15:33:08 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     blogic@openwrt.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org
Cc:     dev@kresin.me, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] gpio: stp-xway: simplify error handling in xway_stp_probe()
Date:   Wed,  3 Jul 2019 00:32:45 +0200
Message-Id: <20190702223248.31934-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702223248.31934-1-martin.blumenstingl@googlemail.com>
References: <20190702223248.31934-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return early if devm_gpiochip_add_data() returns an error instead of
having two consecutive "if (!ret) ..." statements.

Also make xway_stp_hw_init() return void because it unconditionally
returns 0. While here also update the kerneldoc comment for
xway_stp_hw_init().

These changes makes the error handling within the driver consistent.
No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpio/gpio-stp-xway.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 24c478392394..a3326255ce3c 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -156,9 +156,9 @@ static int xway_stp_request(struct gpio_chip *gc, unsigned gpio)
 
 /**
  * xway_stp_hw_init() - Configure the STP unit and enable the clock gate
- * @virt: pointer to the remapped register range
+ * @chip: Pointer to the xway_stp chip structure
  */
-static int xway_stp_hw_init(struct xway_stp *chip)
+static void xway_stp_hw_init(struct xway_stp *chip)
 {
 	/* sane defaults */
 	xway_stp_w32(chip->virt, 0, XWAY_STP_AR);
@@ -201,8 +201,6 @@ static int xway_stp_hw_init(struct xway_stp *chip)
 	if (chip->reserved)
 		xway_stp_w32_mask(chip->virt, XWAY_STP_UPD_MASK,
 			XWAY_STP_UPD_FPI, XWAY_STP_CON1);
-
-	return 0;
 }
 
 static int xway_stp_probe(struct platform_device *pdev)
@@ -265,14 +263,15 @@ static int xway_stp_probe(struct platform_device *pdev)
 	}
 	clk_enable(clk);
 
-	ret = xway_stp_hw_init(chip);
-	if (!ret)
-		ret = devm_gpiochip_add_data(&pdev->dev, &chip->gc, chip);
+	xway_stp_hw_init(chip);
 
-	if (!ret)
-		dev_info(&pdev->dev, "Init done\n");
+	ret = devm_gpiochip_add_data(&pdev->dev, &chip->gc, chip);
+	if (ret)
+		return ret;
 
-	return ret;
+	dev_info(&pdev->dev, "Init done\n");
+
+	return 0;
 }
 
 static const struct of_device_id xway_stp_match[] = {
-- 
2.22.0

