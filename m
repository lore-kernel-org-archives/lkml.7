Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA358C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727E720731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419923;
	bh=1QkygwHLgUK427ey0VFiRVmTUIOw5qNV4Wt+zMKwblg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vj4n6sFZED2oIB1+hP8CQsQ/MR/RbzZUEWoaugekLe7MizA+J7oCcaKYDcdk5Etl/
	 mPH6uXTXTveweqc1L9T5infpUmORTCLky9k2fnVG52ZTWSJzcBL6zhWkMQ2+MHUcRl
	 DPg3T3op7IJkz708ZECuXb8AwRy+J7xnL+ZL2+1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfKVKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbfKVKv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:51:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152AB20637;
        Fri, 22 Nov 2019 10:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419918;
        bh=1QkygwHLgUK427ey0VFiRVmTUIOw5qNV4Wt+zMKwblg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLy8AGNTG2nXw2dolRYaNSXjpTDpzbFrevKmA+syQCnIG8NzW7Oi3qrNvYKeuzZFU
         SYilSV3VGkseb/BkWXRovsRS/8vc4f5BiINi9uC1BPsXzbeNr2/sUKkYwkBK/6o7Xw
         wKjQY4s4po9MP4Rty1jFQedMMYdfG6iXYWs1nHF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/122] IB/mthca: Fix error return code in __mthca_init_one()
Date:   Fri, 22 Nov 2019 11:28:26 +0100
Message-Id: <20191122100758.496108606@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 39f2495618c5e980d2873ea3f2d1877dd253e07a ]

Fix to return a negative error code from the mthca_cmd_init() error
handling case instead of 0, as done elsewhere in this function.

Fixes: 80fd8238734c ("[PATCH] IB/mthca: Encapsulate command interface init")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mthca/mthca_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index e36a9bc52268d..ccf50dafce9ca 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -986,7 +986,8 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
 		goto err_free_dev;
 	}
 
-	if (mthca_cmd_init(mdev)) {
+	err = mthca_cmd_init(mdev);
+	if (err) {
 		mthca_err(mdev, "Failed to init command interface, aborting.\n");
 		goto err_free_dev;
 	}
-- 
2.20.1



