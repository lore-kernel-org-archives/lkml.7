Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10015C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA79F2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920399;
	bh=+Bq+1OUrbIMMls5ArfRU3FchkR5hnXbKHBa0wWxYGWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cja3vTAGpwFzWFon7aNasc5f6a0y5hpx/iVyvtJrEt/UlxWzFBEURif3+RDtZbvhA
	 BKeCQMzq/Nxk1lwC8tgVZUbst0MXsqI1/0DP6V6GK72DRcrxyYvRuV6JUzSUQNNi6X
	 Ak6738J+rsQB1lAzOojXIczyMoivPkzw0yJo2hZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfEOL37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbfEOL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:29:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C189216F4;
        Wed, 15 May 2019 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919789;
        bh=+Bq+1OUrbIMMls5ArfRU3FchkR5hnXbKHBa0wWxYGWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jn83hj8cPFzhWxVIGEMPwlM4YfzKxZs9BiqrZ4EjSs2S2jz2ltcPaG96h2lUbhYMk
         xUbbx6nJR8UfEeQ7tLXfvs3k3uzOtEMHnEiTWtk7R2zqxlZRrICGyg7zFW8Uwt58E3
         q//qphPzhba8D6uUsoLOItSFDZqCDz5Ay8a7VBlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 094/137] RDMA/hns: Bugfix for mapping user db
Date:   Wed, 15 May 2019 12:56:15 +0200
Message-Id: <20190515090700.360688224@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2557fabd6e29f349bfa0ac13f38ac98aa5eafc74 ]

When the maximum send wr delivered by the user is zero, the qp does not
have a sq.

When allocating the sq db buffer to store the user sq pi pointer and map
it to the kernel mode, max_send_wr is used as the trigger condition, while
the kernel does not consider the max_send_wr trigger condition when
mapmping db. It will cause sq record doorbell map fail and create qp fail.

The failed print information as follows:

 hns3 0000:7d:00.1: Send cmd: tail - 418, opcode - 0x8504, flag - 0x0011, retval - 0x0000
 hns3 0000:7d:00.1: Send cmd: 0xe59dc000 0x00000000 0x00000000 0x00000000 0x00000116 0x0000ffff
 hns3 0000:7d:00.1: sq record doorbell map failed!
 hns3 0000:7d:00.1: Create RC QP failed

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 54031c5b53fa9..89dd2380fc812 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -517,7 +517,7 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_qp_has_sq(struct ib_qp_init_attr *attr)
 {
-	if (attr->qp_type == IB_QPT_XRC_TGT)
+	if (attr->qp_type == IB_QPT_XRC_TGT || !attr->cap.max_send_wr)
 		return 0;
 
 	return 1;
-- 
2.20.1



