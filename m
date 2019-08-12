Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F52C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261752085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FUFyk0OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfHLKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:49:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43120 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfHLKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:49:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so29559712wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdFcpRX51nTJgSYeh6YwoFQsGKr/8XxEpuqMCCI0TMA=;
        b=FUFyk0OXJt9AVBPVL0bewi/ZDRrfXTmeiOu/O9xHQICm6YE2z2AQ5/Q4M+vH/y/vS4
         btUFDCIj4Y4r5Gs1mDEz+8lE/UrRmGgTamgetmJtOQ9MDlpPR2+0UR9Kg0l2FUfJWZMQ
         GNKxGjkaXMqTqQNkdB6xkthtiun6tWeywwZ8m4J3GEK5o1GosqJ/M68SNKkhhF2tUjmF
         l7UMS8MS/my6K3WhrOb1A36naP1DH+RLSpxbMBCFcrzB+ljAnq1X1S/EEYi30a1x1qqS
         ycDhydgYPGDcB/07vc6FRJumvCqSOvs+URk01aglo5NegQJnFjU1Yl5mzt+fnJuaxjs8
         x9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdFcpRX51nTJgSYeh6YwoFQsGKr/8XxEpuqMCCI0TMA=;
        b=MF2VZDpl2Nct27QWapgzk/FwW52q+ryiIV1PtQKEx0ILmquS1+Bn1W6aXVRDa7WlFl
         yeRURKhoryRJx7AY9R6B+nNH3+jcKGMnGrBBYqhdBRUMDFLKJkaagVQNgmr7doyBwdq6
         Nz2TBWFqLLaTNSq5n4sHAAduV5nWiCCwy7f6q/ExGtu8Sh6aJROvBy7+V04M6ql3C6Qk
         ND6LsLqtYnOIV076vwrR+tJ1hskSS1IxT90NvN/Vi+LH+fxBIBDGjgY+Yr6iOUNiCWJo
         L8r8jQkWsnv/IOiK7EtoTR3CBPiXj3cu9zWLvHsMGwYpd613oRaGbMPC7fhEwFmVjpGi
         Icig==
X-Gm-Message-State: APjAAAWpjQCt64zL2zn4xPXVPhYcb0iSHj4E8PGWZFbu2xwTQJz6+3QG
        /MkQzEpLLyjbDfXmL6UayadrEg==
X-Google-Smtp-Source: APXvYqydkRjPp0cw1dNKy/JKTL6ZcK7VSUfljff+XkY2B/KtSlMeD7PmsI/XLbJSO2jN5NETGOm7IA==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr41532651wrx.17.1565606977391;
        Mon, 12 Aug 2019 03:49:37 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id p13sm37637661wrw.90.2019.08.12.03.49.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:49:36 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH 3.18.y] IB/mlx5: Fix leaking stack memory to userspace
Date:   Mon, 12 Aug 2019 11:48:43 +0100
Message-Id: <20190812104843.150191-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
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
index 5edb09e674a6..82c4e29c1213 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -811,7 +811,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			    struct ib_udata *udata, struct mlx5_ib_qp *qp)
 {
 	struct mlx5_ib_resources *devr = &dev->devr;
-	struct mlx5_ib_create_qp_resp resp;
+	struct mlx5_ib_create_qp_resp resp = {};
 	struct mlx5_create_qp_mbox_in *in;
 	struct mlx5_general_caps *gen;
 	struct mlx5_ib_create_qp ucmd;
-- 
2.23.0.rc1.153.gdeed80330f-goog

