Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0453C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712172173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLJvXkfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfEUOvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:51:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51741 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:51:22 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so5477054itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jgJdmE1Zbg3qhV5EulwxdNH0JzQK7bdAiz1rSW14UKM=;
        b=WLJvXkfSurKA/hBm3R5otskQBCeCLH/GjbB6e/+cMCGYo/+WSP8B3eESzP/FhbL6/X
         Tg30c0WtnWkYjdW0ZuYhirOU66gcStN0rqX9J5j49YQ3DgCqKyXGVgsuJP4pN4kG/uJy
         1Rqqp0whbHK7nb5tmW5Bp9KL+ZqcjZ1dvlv3ySoBNz1GJimIqb7/ACcGi+bat+x+OmNn
         FoWuJTCo0qPiRk3yq2CAGyyA+N232lW3CgpAOfiPX2Iej37gH0LGYMx5bBREdaZcvEzV
         RZjqBRDqMaqSLiplo4t6EfPQm+gAnNZyelO00Ep+eKb2YT/NzGzyCEORB0VpkGrMpwVY
         Woyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jgJdmE1Zbg3qhV5EulwxdNH0JzQK7bdAiz1rSW14UKM=;
        b=SlRUD/yKQ4H1oBjzUfLriOpRUWe6XeoOIvcfRA5Im8lcYCW/vRY4V+LU+2YR98iY5V
         riKH/3HMdf7/5llp3mAkDH1J/ovoakRIrYnxEtYNBaER6PL+U1tpjnr38LVdugBgvpXo
         Vvz5HDeCXxPOfcCyhg1i5E2QsDitV+eGWpwplppmNCv3Y3NsB83xGT5SJgBuwCXN2piO
         AnsuMkYCBxZf6NImV7guSxwDTwTDC/vLiSsQb1bcm+ZZimTUF2pWU49Q9ZyAI5VCGqXP
         7UtzAq6ZMQoxh7zyQgkBokFPjtVgX3PIV3hEjylPXIhikUnJ9gJjCxtfiSxDLuWixMSf
         DTDA==
X-Gm-Message-State: APjAAAWuE8V0J58Zm0qSxWEOEqbpPYZCx4F0AqC5rKs69VrUwJThgmyX
        FfxEsB95Rbw/uaCSkqEds7LYR36c
X-Google-Smtp-Source: APXvYqy+tWqthA1EUdSvG0qJ/9jqC5fB3CtGEZkCu/3tOdCJ4/YM6d1DWzdmTLf2kCnR5aizdavl4A==
X-Received: by 2002:a24:7610:: with SMTP id z16mr4114515itb.3.1558450281188;
        Tue, 21 May 2019 07:51:21 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id m67sm1666083itc.22.2019.05.21.07.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:51:20 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: fieldbus: anybuss: force address space conversion
Date:   Tue, 21 May 2019 10:51:16 -0400
Message-Id: <20190521145116.24378-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap's context (stored as 'void *') consists of a pointer to
__iomem. Mixing __iomem and non-__iomem addresses generates
sparse warnings.

Fix by using __force when converting to/from 'void __iomem *' and
the regmap's context.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index a167fb68e355..8126e5535ada 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -114,7 +114,7 @@ static void export_reset_1(struct device *dev, bool assert)
 static int read_reg_bus(void *context, unsigned int reg,
 			unsigned int *val)
 {
-	void __iomem *base = context;
+	void __iomem *base = (__force void __iomem *)context;
 
 	*val = readb(base + reg);
 	return 0;
@@ -123,7 +123,7 @@ static int read_reg_bus(void *context, unsigned int reg,
 static int write_reg_bus(void *context, unsigned int reg,
 			 unsigned int val)
 {
-	void __iomem *base = context;
+	void __iomem *base = (__force void __iomem *)context;
 
 	writeb(val, base + reg);
 	return 0;
@@ -153,7 +153,7 @@ static struct regmap *create_parallel_regmap(struct platform_device *pdev,
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return ERR_CAST(base);
-	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+	return devm_regmap_init(dev, NULL, (__force void *)base, &regmap_cfg);
 }
 
 static struct anybuss_host *
-- 
2.17.1

