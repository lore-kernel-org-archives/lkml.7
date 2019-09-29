Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C22C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F1207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="GJrC4f9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfI2J7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 05:59:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36315 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2J7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 05:59:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so3861465pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeRS0GoLkKgv4d/TcQs5tTBQaLtEUhmc3nWIhpoYfd8=;
        b=GJrC4f9ohfOuNQdPUt//FcvxufzqDki+yuufUdcl//wyAGb28s6PzgJ9vYPCbxcAEX
         gBwuZWSxTdUFM2PV7v+/zsWKBBxG6QOyDrnFIrjaWTR2W2/qV5bV/RYtiNJAmDXoNUmE
         AYtDtK4zAwZkFVtzX/8WBK35si9XDk1qSx7XLGNsvBxpWLToLdNs3DdR292Xej1CIVHs
         Vh5ReVsA9qnVdLzOVLaSiblJ1LswofIwwi6CAXLUEomAQADkRVQ+c6oCpOtgJ6FoaOZN
         bmnd4QnVc/TYGFOj0/Cdt0PX7fbC+jDgi3tb/qgItNFz2EOK3ixmBdGpnPsN6hhXYFSl
         BOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeRS0GoLkKgv4d/TcQs5tTBQaLtEUhmc3nWIhpoYfd8=;
        b=HVLL+HB9vmVvCdN0Rmwu4Kq7jFXDBDLBplFgbYLUA5CZdvsi8co8RWfjdAnrTRu6Rv
         gODXinlwS83ctzVol9QpxKgi2fRoidTGUhSkD9mGL4UqXuz4o83D1fJf2VDo5baLJhem
         nJFi7zJV8uHieRvYJ+bYNJ2GBQDhQIXQxsiLAsmGwXu0vBl2gOq09ZDBuLzTMiBZg1Z8
         JsEvB2UETguFg++PXy0xv9sf7Sk4EzIENPXa0LkigrYL5NhzyX556YYT3VuE3w50jNY3
         OwNoIHEflLlYJy1m5p7VC9e2bgPb+HM6+BmeOI+F6wMzuca/N+lLx7p5lI+idPmsEzRn
         3wxA==
X-Gm-Message-State: APjAAAXIRRVbB2LGBYZqX07lt24l1yU0f+yScMOZ/NyKcG2DUCj9gfsD
        yy05vn4y102yWyBB7knC0AA9Zw==
X-Google-Smtp-Source: APXvYqzxDuIuv162ZbvV0KFghMtSRDGLn1uBxz1imxG5o/0Jqbhf5iuHcaTBUoCcWDVM3oeEMXS6tw==
X-Received: by 2002:a17:90a:3ae7:: with SMTP id b94mr20459543pjc.63.1569751154549;
        Sun, 29 Sep 2019 02:59:14 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id w14sm21337343pge.56.2019.09.29.02.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 02:59:13 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>,
        "Andrii . Tseglytskyi" <andrii.tseglytskyi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: ti-abb: Fix timeout in ti_abb_wait_txdone/ti_abb_clear_all_txdone
Date:   Sun, 29 Sep 2019 17:58:48 +0800
Message-Id: <20190929095848.21960-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti_abb_wait_txdone() may return -ETIMEDOUT when ti_abb_check_txdone()
returns true in the latest iteration of the while loop because the timeout
value is abb->settling_time + 1. Similarly, ti_abb_clear_all_txdone() may
return -ETIMEDOUT when ti_abb_check_txdone() returns false in the latest
iteration of the while loop. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ti-abb-regulator.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index cced1ffb896c..89b9314d64c9 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -173,19 +173,14 @@ static int ti_abb_wait_txdone(struct device *dev, struct ti_abb *abb)
 	while (timeout++ <= abb->settling_time) {
 		status = ti_abb_check_txdone(abb);
 		if (status)
-			break;
+			return 0;
 
 		udelay(1);
 	}
 
-	if (timeout > abb->settling_time) {
-		dev_warn_ratelimited(dev,
-				     "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
-				     __func__, timeout, readl(abb->int_base));
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	dev_warn_ratelimited(dev, "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
+			     __func__, timeout, readl(abb->int_base));
+	return -ETIMEDOUT;
 }
 
 /**
@@ -205,19 +200,14 @@ static int ti_abb_clear_all_txdone(struct device *dev, const struct ti_abb *abb)
 
 		status = ti_abb_check_txdone(abb);
 		if (!status)
-			break;
+			return 0;
 
 		udelay(1);
 	}
 
-	if (timeout > abb->settling_time) {
-		dev_warn_ratelimited(dev,
-				     "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
-				     __func__, timeout, readl(abb->int_base));
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	dev_warn_ratelimited(dev, "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
+			     __func__, timeout, readl(abb->int_base));
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.20.1

