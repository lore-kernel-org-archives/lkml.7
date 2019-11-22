Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4834AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2058820715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419628;
	bh=7Oz3PQNUNgCniA01lkUK3vBCs4s5pP39V23TBiRS1qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9qgNJZe35en5/n1iuPdrFHI4nvvbhs/IycOWYJMjnB+E6b30wvhbql/utlsV79N1
	 hDJtZUi7NIDWMrqn4iBxSHYydcg27rMhH8y6dlPwkCZ1KRxaj9bMHmESx3LCrq5JRW
	 O/XuOId+haK+x/3q9XP3evFNqVFfpPZamOrsQMTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfKVKrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfKVKrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:47:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E6FB20637;
        Fri, 22 Nov 2019 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419620;
        bh=7Oz3PQNUNgCniA01lkUK3vBCs4s5pP39V23TBiRS1qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2nUF9aDHCtutWgQUASCCRUfMnaDWld6uwVv0Tu9xj+rHXrOq+ZZoTftgxdTqx+dOC
         FIsSV4JqzGDkPq1O4R24NsMn3BDS0iM6KKU3WXUl9wu6XP48YNzxpt8OXxu6at5CPn
         TDM8XRvicl/2iwpxpK+ZPaUiCbkqr0SbDU3x+2fU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 176/222] IB/mthca: Fix error return code in __mthca_init_one()
Date:   Fri, 22 Nov 2019 11:28:36 +0100
Message-Id: <20191122100915.152256811@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
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
index ded76c101dde3..834b06aacc2bf 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -989,7 +989,8 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
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



