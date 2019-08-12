Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64090C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC3F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WCSxhklf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfHLKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:52:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54539 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfHLKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:52:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so11717264wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O++uRsHIpORfNijsJuAZCfYZu5AagOJx1j5KC3QdVcw=;
        b=WCSxhklfkSzS5/+kkOkukSkT1h+mFwRUtmjfny6WJSaaYvw0v6fTvhSsW6r6hAzwVC
         5BgJtJT3vVGXk9r5T4lsxbDqI2LCyF2h6Fu7shSOjvhpwREZycWrzvbQS+m3Ml/ewaTz
         +0UDCMfv3zAJNsMTO2IA3M7RXV/wp2tgbMPZ4xNSiysltMtC1gg4hLbu0Tm2+PFmyquF
         e2DYyadblv3GIEFppUCdnxKa9mEhj+z70SgrdT81PHqMvSYRkCQ389pY9f1hAd9MIdki
         WIC2EqA0miWwN9r+myF/979nOF72hXNpzSmRVx/FtLLWpUhlSHfBWHZkCd7eXV2jeID5
         DnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O++uRsHIpORfNijsJuAZCfYZu5AagOJx1j5KC3QdVcw=;
        b=g+srMdyzPyMwTdEhvjw7HTZHcf6Unx9FP3lvUqkAwPLkEyLIohs5Za5VDo638epeGX
         Wf4Fos4msaeKU/AgAX55dlg4AeikBVjvP1A+boqtC8a7VoeftjPdBRvoi33x+emiO6tL
         c0EBvCFkEdAqehFqY695/KN9JGQazaRrZ7MeUOE+N5lmHgAZb2tq8ftnTDSTaEtvHxpZ
         sZCmu+hpHfIZLWNsZ+B9q7vmdZ9gdl0lHq7yAo59SqLpcuBkpVpCN+xWqBmWy1xf4VCl
         rJed3n6kEptsdgP79kyshjMzprKyN8UIuH5NdiqdToYTTFyPd9033Dw45a/XBU4xewED
         iS2w==
X-Gm-Message-State: APjAAAXCTnBKgN9wpvKURaLj0Twlc5vgVAkJ393MlmBT7su1R4uqnAgY
        2bMQRzkNuoQKS1Eym7MDZHmpiA==
X-Google-Smtp-Source: APXvYqxdhoDzzqMbFWiHpr3b23pn8q93eGI6N4yLdQ3P0IvYGe4x45TxERM+VierDtKsKWPruWT1ZQ==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr13043785wmm.12.1565607119705;
        Mon, 12 Aug 2019 03:51:59 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id 74sm5169675wma.15.2019.08.12.03.51.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:51:59 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH 4.4.y] IB/mlx5: Fix leaking stack memory to userspace
Date:   Mon, 12 Aug 2019 11:51:36 +0100
Message-Id: <20190812105136.151840-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812104843.150191-1-balsini@android.com>
References: <20190812104843.150191-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

mlx5_ib_create_qp_resp was never initialized and only the first 4 bytes
were written.

Fixes: 41d902cb7c32 ("RDMA/mlx5: Fix definition of mlx5_ib_create_qp_resp")
Cc: <stable@vger.kernel.org>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Alessio Balsini <balsini@android.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 43d277a931c2..c035abfe8c55 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -865,7 +865,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_ib_create_qp_resp resp;
+	struct mlx5_ib_create_qp_resp resp = {};
 	struct mlx5_create_qp_mbox_in *in;
 	struct mlx5_ib_create_qp ucmd;
 	int inlen = sizeof(*in);
-- 
2.23.0.rc1.153.gdeed80330f-goog

