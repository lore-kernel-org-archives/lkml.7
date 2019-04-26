Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2248208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+ofXdAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfDZQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37975 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfDZQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so3515478ljg.5;
        Fri, 26 Apr 2019 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmiljxR0tDKc7rqpSkSKqbQb6AAiPA5Nk+pPD2f3A2k=;
        b=o+ofXdAw4bIKSWuAYjDkmrfetZ07r0OreqSlGTEMAMWBtEpVMIrW6Cie1qcLcZruuw
         KSY0p3WWaDhq+GF63/PLKUB0osQ8ArtEtdlOARK/7w1Ik1DD00Y1YbzAyHbn6nAw1Nzo
         iS4ftTuer8CLtOu8l+2J819dnOJ7TF4yvUOIpACmiBCasZ7opq1/SL5vOxBVXak//40L
         bR/w7Dvm+/wXRHOWa5t3B3yKXeZO8IQdfB85Xl4cO37nqg+9PXKnKrvIGOEDsrgRJmVt
         krUl2k26Q8Cq4qXyZegCCSH4UZji6rVCbCoKlCHnaPSqVEw6Y3gdRe5JVqHOa+e4wQEG
         1oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmiljxR0tDKc7rqpSkSKqbQb6AAiPA5Nk+pPD2f3A2k=;
        b=qXDgzSDKNQap5W8wcHTMdHMpteLot+zqUCR+gM3me6i6P1l3h788a7jfzCyWBEa44b
         86qDCuyA/wygEB2H4I7jT5+8G1JHji8nwR9hB9e6HfIaCVo87gG8oLGUwIs4cD7JTzUi
         mz/E1ZgTm5S+bNlmNr5crujiOqlD1Im9w+srKiLEqgErCb92eXueUpdqbvjcd826ImJ1
         7cqwbG7RtjEJAX8oFZg7p+6NnDHApT4f7vegKaR+pCNhCD7fcCLgYq+krLOhH7MXld+2
         y9N+UYMekJMMliGb5OPZ+9dZ1VgNwdbEhY89Cu5N+rnyRP2gFVoUoCM5fkv8yEx414PQ
         X/Zw==
X-Gm-Message-State: APjAAAWrgnKWnBl17v2KouNDj4WkPFbLynzMzPVToTXq5bM0WDJ/ABv/
        Lnp3Uy5Syd8WRmElOcMpsnM=
X-Google-Smtp-Source: APXvYqyXGvtR+Aq5jipLArRTQrWAcOARjHVWJn/3Jnmr11sInDW/lKSKycYh6xsZ2phrW6D1l94JCA==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr24865433ljg.87.1556296959733;
        Fri, 26 Apr 2019 09:42:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:39 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 5/5] mtd: onenand/samsung: Set name field of mtd_info struct
Date:   Fri, 26 Apr 2019 18:42:24 +0200
Message-Id: <20190426164224.11327-6-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds initialization of .name field of mtd_info struct to
avoid printing "(null)" in kernel log messages, such as:

[    1.942519] 1 ofpart partitions found on MTD device (null)
[    1.949708] Creating 1 MTD partitions on "(null)":

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/mtd/nand/onenand/samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
index 0f450604412f..1fda1f324cc6 100644
--- a/drivers/mtd/nand/onenand/samsung.c
+++ b/drivers/mtd/nand/onenand/samsung.c
@@ -886,6 +886,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	this = (struct onenand_chip *) &mtd[1];
+	mtd->name = dev_name(&pdev->dev);
 	mtd->priv = this;
 	mtd->dev.of_node = np;
 	mtd->dev.parent = &pdev->dev;
-- 
2.20.1

