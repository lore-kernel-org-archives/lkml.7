Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D8BC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D08208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmsu+hX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLJUcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:32:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36403 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfLJUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so8786107pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DeuPvEztiSd7kwjPtC2mIn2agkbYJRYt91C1Dr0gXE0=;
        b=rmsu+hX/vtvPaWJCq4ljOZUIP/cy9yN52b7v/ouD0Lh2irVI2MBDIZc4axiNpaklzQ
         tA4uM7Hz+jvc7llrhG/UZDyK2O4vTkMOHK9T9ozJVuIRkIWV6BXQW2iMJN0JYpihdN0A
         ee1mgMWjdlolzMH+VSdLEwHtep8kltmatJWWXItL6j0HaW4qSR3pdbd2mG64hiCRKR50
         UbSD1PcRFjjokwgE9nqeytHDcxtwWdPgmE48NLJ/eL0mvM5KAF8bYHGRyjU1CFU5NAao
         X9mp6hnQO3YF3o9T7rRrJTlUpDUYPUX1JvFF8IRJz80gwH7TfaBaI2tVJOkaSAke3u+7
         BD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DeuPvEztiSd7kwjPtC2mIn2agkbYJRYt91C1Dr0gXE0=;
        b=ZWJvwFj/Nl/Q/F1RGgOGH82fSWcVdCMp7dl9RS/uPmpwPCJ9U2Kq8P0l+PsEOGpbPf
         3Bp8094NvoZaGNIamT6swCehFEery5t+xtyw4aOd6wS15dppn5WOcv33NKbo1DMvAxM5
         x5M/LHU7VzEvIhnlhD8QcbXjMpnV6x1y/94fxjzw12IG/+kMMuZL4VzUU8g7RUA+nnqR
         5AHkXARhTnEY3uAeEMColuu8RauO0TPxKlHV7H3AV47iuUstB64/EYp9dBVA4TK/5uZy
         NQ2GtN2JqDtVw3UAzg8SBYo6Khm4JYl+Tg8l05kKtlJogqmQkot/A3VVE3j/IWsNNulf
         /p6g==
X-Gm-Message-State: APjAAAUSZ7NmPfMCTuHJdPL1QTDLrDXmNBNE6bJrKwlI6oBoI+200Xl+
        qGrjIsHOBjD/A89PW6DVFqY=
X-Google-Smtp-Source: APXvYqw7AoFbBg2zwdq2kcqlhEL98Zy/ORPpibsdgJWtVjsbOp7kvJtHC0tBmKZiEZAgIMFoZm00rg==
X-Received: by 2002:a63:c207:: with SMTP id b7mr26754619pgd.422.1576009920632;
        Tue, 10 Dec 2019 12:32:00 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id gc1sm3621984pjb.20.2019.12.10.12.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:32:00 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/5] nvmem: lpc18xx_otp: convert to devm_platform_ioremap_resource
Date:   Tue, 10 Dec 2019 20:31:47 +0000
Message-Id: <20191210203149.7115-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210203149.7115-1-tiny.windzz@gmail.com>
References: <20191210203149.7115-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/lpc18xx_otp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 16c92ea85d49..8faed05e3cbe 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -68,14 +68,12 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct lpc18xx_otp *otp;
-	struct resource *res;
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	otp->base = devm_ioremap_resource(&pdev->dev, res);
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-- 
2.17.1

