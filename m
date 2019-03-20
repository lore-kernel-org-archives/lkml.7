Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A445218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhvZzEBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCTWoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:44:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52168 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfCTWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:44:01 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so1547586itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4+a/5JHlT/sDlQcCOXC1KgzYcp4fkhfEGjcyXNTq50=;
        b=OhvZzEBNYwuQff9stfVfRKeq5eFD6BLwWvLJBYxlTgJrJwOyfFQi27emUxeifdd1Wm
         0K5KU0j1lq3Y9OFP/V29dImiiitoUiKRs9f1LBgNmK7nO2ynEGKXj0snu4fhlSVu+RY4
         3CgZwGNm1Y+myKOw1SxzSyqMLfQ9zHNrqnh3/XsdantAZvL6Qx7a+Yq37MTCD2LUT82c
         HheayY+kZddd6RSyFXbNXSZXkZuKryd9jmH6XK9xZ6k9MeBBDjojPGDsSdqA0yGQv51W
         uQGblqWbyYxtz49/mHK7kWP5DsorjhxjtPJZlzw9+M3DGQYzdgiM6DRHKUyAY58Qoojj
         9tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4+a/5JHlT/sDlQcCOXC1KgzYcp4fkhfEGjcyXNTq50=;
        b=cKu8xZGLcWX8mkLCsgq9GvOjQr5BHyZUc2NrMmCR9dfNnkxsoSYNtCNXLunHxOA8n2
         rZHKrN0vkZQU42Fv+PbRNL9eq6s+61cuKfaCLAXT5LGWzroXMkSNmFL0aukQe6CvckKJ
         TCdGgsxOHJ/Py5rcXM1+UHSeozFb3sWoJ5rk3VOYYAsZrc+9MkAlGvBmf9lbwk56+Xlc
         jd51rbt5owuamm3nbY9ZMzHKZ2JOAzDCuuCzHL9ZSj44LnH9J2m410uJfK5jSGV9HoIZ
         2TkiMjaBYsrmMjxeegDRA0F7eP2ibuvRSTEfsfIc48URdzCGtKOuBH1v7e0fRBQOYZzP
         p3Eg==
X-Gm-Message-State: APjAAAUjgEGIluQStVU6s3FCeF9aFA5HjqUPmYgQbd/laHEOMauymJpP
        TnCD7LM2k/dkwU+nO72AQ655COctrLw5hg==
X-Google-Smtp-Source: APXvYqziiSlL1yzGtGKzBOgKbW7YrEtp4v2Aa5mKUTupGMPW6t2pF3dwkwZdyRcId91PfhNfpsf2bg==
X-Received: by 2002:a05:660c:9c3:: with SMTP id i3mr501255itl.168.1553121839711;
        Wed, 20 Mar 2019 15:43:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id 139sm1805554itk.28.2019.03.20.15.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:43:59 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v3 3/3] staging: mt7621-mmc: Check for nonzero number of scatterlist entries
Date:   Wed, 20 Mar 2019 16:42:05 -0600
Message-Id: <20190320224204.10243-4-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320224204.10243-1-thirtythreeforty@gmail.com>
References: <20190320224204.10243-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer descriptor setup loop is correct only if it is setting up at
least one bd struct.  Besides, there is an error if dma_map_sg() returns
0, which is possible and must be handled.

Additionally, remove the BUG_ON() checking sglen, which is unnecessary
because we configure DMA with that constraint during init.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v2: Rebased v1
v3: Remove existing and added BUG_ON() in v2, and handle dma_map_sg
    failure gracefully.

 drivers/staging/mt7621-mmc/sd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 139533606863..cf2ad06112eb 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -593,8 +593,6 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	struct bd *bd;
 	u32 j;
 
-	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
-
 	gpd = dma->gpd;
 	bd  = dma->bd;
 
@@ -687,6 +685,13 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		data->sg_count = dma_map_sg(mmc_dev(mmc), data->sg,
 					    data->sg_len,
 					    mmc_get_dma_dir(data));
+
+		if (data->sg_count == 0) {
+			dev_err(mmc_dev(host->mmc), "failed to map DMA for transfer\n");
+			data->error = -ENOMEM;
+			goto done;
+		}
+
 		msdc_dma_setup(host, &host->dma, data->sg,
 			       data->sg_count);
 
-- 
2.21.0

