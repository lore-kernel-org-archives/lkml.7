Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCE720820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XgvPjH/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfHLKzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:55:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfHLKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:55:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so11336049wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 03:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nj+3s2yrWseVcLh3wJxjh5wTreHAkZAnG1J6avSid7E=;
        b=XgvPjH/MwveIgl8aFYjN+Tttzua/lbqCtjlfe6yz+ELv8B4/KvQK6LfwVTSkVLDyW0
         NZz78c0d8/FlvJPMTc+9oA77npKJrLUzY4s/XfLdum7uydS32UWT8/kGatjfyHP3wgvW
         2WqwAWkzu4HwUPcnH4YdyFOQQZEOnhl6Gf7oUJG8K/7CwQLVlJwLPw9BB0gpzrW504HA
         +7DRL9sd7B/2cXjVWnQ+P5flClhXZSRvE42vsx/iDDxs0PuE2BTk8+tUG8JgKcXX0L3G
         TiUqbdYyDQu3sca6YNOtC914X7eStNpJcPv27tCvpEes63VeBLSbrcgnX/vBjafQu+Yi
         Hrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nj+3s2yrWseVcLh3wJxjh5wTreHAkZAnG1J6avSid7E=;
        b=BQr65C8OH2zJmTi05U9XO2qIi8iTy67W+qKjI1apOWEAPGRKkkWdlHqZoXvU9emmNh
         d8qxjq0f0liIdFfDQ/fA/XbjtnWTDiwLwdcG50Fu/O4+ITMc+mIQuIGZY2kgNt39gaRW
         u3+4/FlyKRaTE9j8UqO/F3l8/MyU2gfwxirvi4YoO+B2zTBHDBGU0mvTPwPBeAl+3qRW
         6iuIqRlSo/RZ39anSNdXOmN1VLFE9DWsrsYgE1IcpfqTNBPIbIzfjEz6o1orNjZVVHSI
         uR4NFxC2eg/gkmlZ+2onmkxqoviLvDbjxihflCCA0L8K/8PMfMVyI2OQyNU3DdM4ZOd0
         ixAQ==
X-Gm-Message-State: APjAAAUlfBPBdLwi3hP3CKy8sej+fUcaSX1RO09RzjhqnXuPP8rPBJ1P
        78+jXEaiQanF143TW/vJAd1rWw==
X-Google-Smtp-Source: APXvYqwMNLd879rWEsOClegptD2DrDBCGSZK5Crb2bIkJDlKgEfyXjeFtl+KB0crwiYwgc9wBzKong==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr27108992wmh.42.1565607321113;
        Mon, 12 Aug 2019 03:55:21 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id 20sm8375472wmk.34.2019.08.12.03.55.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:55:20 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH 4.9.y 4.14.y] IB/mlx5: Fix leaking stack memory to userspace
Date:   Mon, 12 Aug 2019 11:55:03 +0100
Message-Id: <20190812105503.153253-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812105136.151840-1-balsini@android.com>
References: <20190812105136.151840-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit 0625b4ba1a5d4703c7fb01c497bd6c156908af00 upstream.

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
index a7bc89f5dae7..89357d9e489d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1515,7 +1515,7 @@ static int create_qp_common(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	struct mlx5_ib_resources *devr = &dev->devr;
 	int inlen = MLX5_ST_SZ_BYTES(create_qp_in);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct mlx5_ib_create_qp_resp resp;
+	struct mlx5_ib_create_qp_resp resp = {};
 	struct mlx5_ib_cq *send_cq;
 	struct mlx5_ib_cq *recv_cq;
 	unsigned long flags;
-- 
2.23.0.rc1.153.gdeed80330f-goog

