Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783B5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C182184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Dl+ME5YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDKWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:01:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:01:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so8632757wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNpnhysGNBYBU9vZbHTKcY8UQNku4HVmL3x6AsvBeB4=;
        b=Dl+ME5YNZFahF/2igCGYWogD/O/0Gd3bQea5s/0xjbTfm9BIuXFheqWl1O+VWnobKp
         njy4xCKs88mG2WRT7KBBdmUoiol97+QcOiz/7ocz9pBT4yFKSbMGie8LYSm5mkn5FQ2F
         j44Phia/Ko+czhZgjQCaCHFQCxx93EyjC9eY8/dXDMGoky5AbMS9zwLrx4Tp4IP1j93f
         vTPUVfXj7jk8vbvwoNl4TMwUxF2nXalNmz4ogOl/bEESUCKc+SDkQ9QDzM4iBbp1uQZb
         nLVkQtuZe6MllvRAUKp5OBnAODevz58LqLo86auklRd9M1H7bpjVKCEfRXhnmgPuCXKl
         PfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNpnhysGNBYBU9vZbHTKcY8UQNku4HVmL3x6AsvBeB4=;
        b=tt3n/dUoIsfYpXAqou2jqvJIHs8gHC09gBJ+U1eyoLfQjww/8sLsOsVYSzBPdu0vL6
         MjhN183vgk+xISdYtcrGp6MnLzhnLspIBBWM0yfdqshbXerS6i9mtQBXuGUfk+zZMj3b
         4y4Bmz5PGgliAWy7SbxyO05QUMoUN06sT+ImYMHsQGDLMW3QklSvp9yj1Eu9sGPj3CAF
         XJKkM/KQz0s7Ba2C4Wko8nQUj/8lD3ekxfYfeKXZAr5acSvTJ5KJHD5ikZffJoQs9FMh
         obi4Nvyov4jmU6YIOOjgIOkitiKSPqeeGPQz3sxHw7p2iYSvuw1lfCqgYKpnyWxduCck
         2InQ==
X-Gm-Message-State: APjAAAVhTt8uB1XsjSBKDoout84rdKwq/h288iXY4+fw6gJlBfQ8mb15
        6Mvbgcx6PQ92UKFvZWIw1Rc=
X-Google-Smtp-Source: APXvYqz35ooInE1ZKyccYGGGO9VGmdSKB2QtHLGDBX83aWFKO0k452TWykwlq54bD8TUpyg33NUcMQ==
X-Received: by 2002:a1c:2348:: with SMTP id j69mr7827582wmj.35.1555020082569;
        Thu, 11 Apr 2019 15:01:22 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0009F15067C8D22C31.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:9f1:5067:c8d2:2c31])
        by smtp.googlemail.com with ESMTPSA id s189sm13266186wmf.45.2019.04.11.15.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:01:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     liang.yang@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        jianxin.pan@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] mtd: rawnand: meson: use of_property_count_elems_of_size helper
Date:   Fri, 12 Apr 2019 00:00:54 +0200
Message-Id: <20190411220056.19109-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the of_property_count_elems_of_size() helper instead of open-coding
it's logic. As a bonus this will now error out if the "reg" property
values use an incorrect size (anything other than sizeof(u32)).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index c1a6af57dab5..9a6023638101 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1233,10 +1233,7 @@ meson_nfc_nand_chip_init(struct device *dev,
 	int ret, i;
 	u32 tmp, nsels;
 
-	if (!of_get_property(np, "reg", &nsels))
-		return -EINVAL;
-
-	nsels /= sizeof(u32);
+	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
 	if (!nsels || nsels > MAX_CE_NUM) {
 		dev_err(dev, "invalid register property size\n");
 		return -EINVAL;
-- 
2.21.0

