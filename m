Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D173320989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFAnvvhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCSCFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:05:35 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36457 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCSCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:05:34 -0400
Received: by mail-yw1-f68.google.com with SMTP id 189so14622926ywi.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tRnoribyFXUwLNjP21+A3IUeby6d1UM4ncRrwBaNsY4=;
        b=eFAnvvhpEGwvW/sozrN5yUUpdA7O0a+gpPVrfkA/bVinOBxYcD61r5UTbh+Xa1fhJG
         aJGT6DUJq37O0QWjCFbGTZhSh8ansLcaOdcp4+T/5IaOsZnE/KNRTsrSs7PeP5ZFEVlT
         vZajH5GUhTBQspYkqRyVTDp/algbp8H3E/aS2130P8EQlnf6GtpCEMp1WMZBQz1ADDwG
         OgTMGpPTu7gScx/ILMw4B2s2aIMjK5PQ0dToKkB0xZNsO3CD/WoO5nwi4wFXLd7U/g/i
         aZtOig8SoJLBsW9w8Uh+mixTAcz4vUZjwaYUQmUFeZj7GW1Jgw08y+buzzS4NEBg7Yif
         nq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tRnoribyFXUwLNjP21+A3IUeby6d1UM4ncRrwBaNsY4=;
        b=MezZ5st4oDsxAHqarfvDutDzBEeRvHWG0IbDqdpV+l7ZDJ8CPKQMNCF3f4IsMVCxDm
         BqEPiNhZoAxZEMdFfiIzfcfFl1x3R69Td/9L9/+mMGNgWdpB5JrD8mkOulagJL/QJr09
         knlwNsB4PUAfmpttc20MZwsxI9fNQSLPOiYM6DkUtGTbWOJ5KI0ZmosUz7D9plXoLl71
         l3mFlI6Y8uFrKTIlJf/uPPJh67mj573+JpVHzFcqnpSpIUq5JnyhjijyAj4kB8LnEk4P
         6L6udcbKwXIp/uqvdW9Gy4KYlpV2Dij/5GvCgJUV06CGnstNoM2RatDD10CDGUn1NSZO
         lodw==
X-Gm-Message-State: APjAAAXsszhYi9BErDzILdiGleIq4ztB+EzOJQKWwAv0jGG5W66MAtPT
        M1NAWv0ANCHa3K3YTh4e8As=
X-Google-Smtp-Source: APXvYqxB9PJSvtpNZ4DHfplkdcNTd/m4Ci3SWXRn5Q1BzLe8H0BLy42t0/KKNRtioyMuQgwCu1W4iw==
X-Received: by 2002:a25:1341:: with SMTP id 62mr17142ybt.402.1552961134033;
        Mon, 18 Mar 2019 19:05:34 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id p7sm1277516ywl.17.2019.03.18.19.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:05:33 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Cc:     Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH] misc/fastrpc: add checked value for dma_set_mask
Date:   Mon, 18 Mar 2019 22:05:19 -0400
Message-Id: <20190319020519.15209-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There be should check return value from dma_set_mask to throw some infos
if fail to set dma mask.

Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)

Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 39f832d27288..36d0d5c9cfba 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1184,6 +1184,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
 	int i, sessions = 0;
+	int rc;
 
 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
@@ -1213,7 +1214,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	}
 	cctx->sesscount++;
 	spin_unlock(&cctx->lock);
-	dma_set_mask(dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(dev, "32-bit DMA enable failed\n");
+		return rc;
+	}
 
 	return 0;
 }
-- 
2.11.0

