Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D218C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9442184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498726;
	bh=vELGTQFUBuwI83rHbdvGe4VziEK4+jgtdTI0njCWLMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2HvtY1IkWyChH+BwXzZqchiPUHE5LxTnsQr7Wl1dfTGy8zxLrwcDbkEPthzJJ6uE
	 5zik3PVpIyvctm8cuky4G68EYvzXBYQn9BOO/ILkZ9dph6hf6k3l0Fe4yjyXfcABRN
	 i7R/jk+Ni51j1KFRQejV87+RAlVSOeQchBsk5D5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfKKS6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbfKKS6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:58:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6456C21655;
        Mon, 11 Nov 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498723;
        bh=vELGTQFUBuwI83rHbdvGe4VziEK4+jgtdTI0njCWLMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poF59CtWvbfwLKiYCoJQCxCt39xK+pjm8hwNhDH0Mx/UgfPH8sN+QNDT0rlfZPbKU
         5TdMgL/dFFdEY7QtCYv4K0l+JU3RyTapTp44+WUXGWgA0xoSmVNIJYa7IQYpZV9c5B
         H5x12/2I4SEv1eUjYjDVnp3uhR5oNQ7OZ6a/oecE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 151/193] RDMA/hns: Prevent memory leaks of eq->buf_list
Date:   Mon, 11 Nov 2019 19:28:53 +0100
Message-Id: <20191111181512.285677496@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit b681a0529968d2261aa15d7a1e78801b2c06bb07 ]

eq->buf_list->buf and eq->buf_list should also be freed when eqe_hop_num
is set to 0, or there will be memory leaks.

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
Link: https://lore.kernel.org/r/1572072995-11277-3-git-send-email-liweihang@hisilicon.com
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b76e3beeafb8f..854898433916b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5268,9 +5268,9 @@ static void hns_roce_v2_free_eq(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	if (eq->buf_list)
-		dma_free_coherent(hr_dev->dev, buf_chk_sz,
-				  eq->buf_list->buf, eq->buf_list->map);
+	dma_free_coherent(hr_dev->dev, buf_chk_sz, eq->buf_list->buf,
+			  eq->buf_list->map);
+	kfree(eq->buf_list);
 }
 
 static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
-- 
2.20.1



