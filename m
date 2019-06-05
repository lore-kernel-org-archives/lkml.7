Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D432070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcR+MIOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEBKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44107 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfFEBKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id w187so4125465qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1CgGNmT41gdKkbcLTzL9G1FcUp7/mgA73pnl43Phi8=;
        b=GcR+MIOLnaiQUoIFQyd1aL+z7yikowSZrJfCvqygTTLiXhVXCI3+icoPLO485FJz1d
         hb423kZ5oSQGYUy6Xs8ZnjkUMd9v80POPPTGN68seD7ncR9JilCIuAa5meto+y+oF1N/
         MdrnoSHzTsztIT6IX606D5OpEHT5sEZcK3nu/shIXvPZnjOaxUkP/Y4u6T5LsomMGF2j
         HiZnE4eh8RzcH2HP04Ra3X1etIOAdWTqv/SYCW1E+WsEyrBediC+crAXKTCQy/KI8hGn
         9XvVu2fy5FuLP+Gxfgu3Mj+kvjtXW/A/hEOjy4jNtxzPbKqEsYssxJ8VAsnSPGWUk0YE
         9/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1CgGNmT41gdKkbcLTzL9G1FcUp7/mgA73pnl43Phi8=;
        b=pRFPPryv2kt+waW7/0HmQzUerwSqrkKDLJgdGT5RgDzfoFUaoF5Z91wsJ+blvtPDcr
         kv7Lf0vTVHERqCwigzKoqqOUb3fNHwkaIU/beXlXxTHBAdVcNNV6XpAKTJGIStcgmlbY
         lPOKC2Vz0wPy47sFtlhH74gWZ/GCD19KtOuj4+GPQQAZNSdYctJR+NWCa94jv6bCkmRJ
         DQZMaslNm4i4MeQOm/bZRjpESK7JVIyIt2/ysjhYS27kZju+XFmH02KVI2OWr6ugd5VT
         Kj1UlRUeRWxZmcFvrKqTVVbrtAdbLcG51m5R5qaFB6znnxZvcz0Hw0gJHrN7zb97gCin
         PNzQ==
X-Gm-Message-State: APjAAAUOFIAyzqDxnaZx0B2qx+VOygeNU0PcxGXeqhCRoTZZj4wLoHH2
        /0L9CvpZSgZb5sFHr0yOLd8=
X-Google-Smtp-Source: APXvYqyW7sJM4G+Uq1TE53I7+IRyPcKZECBTQFnNF5AsXY3c1kDZs+NamfZ99VCjGuKcKmcv57dIag==
X-Received: by 2002:a37:505:: with SMTP id 5mr13022676qkf.277.1559697009537;
        Tue, 04 Jun 2019 18:10:09 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:08 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] staging: kpc2000: kpc_spi: remove unnecessary ulong repr of i/o addr
Date:   Wed,  5 Jun 2019 01:09:12 +0000
Message-Id: <15f12ed247c7911619adb3445579ce13394a5ddd.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_spi driver stashes off an unsigned long representation of the
i/o mapping returned by devm_ioremap_nocache(). This is unnecessary, as
the only use of the unsigned long repr is to eventually be re-cast to
an (u64 __iomem *). Instead of casting the (void __iomem *) to an
(unsigned long) then a (u64 __iomem *), just remove this intermediate
step. As this intermediary is no longer used, also remove it from its
structure.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 07b0327d8bef..4f517afc6239 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -103,7 +103,6 @@ static struct spi_board_info p2kr0_board_info[] = {
 struct kp_spi {
 	struct spi_master  *master;
 	u64 __iomem        *base;
-	unsigned long       phys;
 	struct device      *dev;
 };
 
@@ -462,9 +461,8 @@ kp_spi_probe(struct platform_device *pldev)
 		goto free_master;
 	}
 
-	kpspi->phys = (unsigned long)devm_ioremap_nocache(&pldev->dev, r->start,
-							  resource_size(r));
-	kpspi->base = (u64 __iomem *)kpspi->phys;
+	kpspi->base = devm_ioremap_nocache(&pldev->dev, r->start,
+					   resource_size(r));
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.21.0

