Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4917F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420381;
	bh=iHrSDbtmO6iDPDxEj/3JzV833eWtqf2Bv0P7k8m6R14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oj+Yt3e2t2KaOWq/vnkifgsevOngccRxatjxb6qWxOGminzS7oGMiRaL1ziL7lW2G
	 YE6pfbC0NoRPJ0/LLv1eDZWWnoadVo1gVsSRjy8N9BnW6tVgILV/wtVnSEgiN/eOxC
	 uCFh4Hihkd5n/6UnG98WCLhL7xb58H2GRXUyqUWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfKVK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbfKVK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:59:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E11720706;
        Fri, 22 Nov 2019 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420377;
        bh=iHrSDbtmO6iDPDxEj/3JzV833eWtqf2Bv0P7k8m6R14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXu/dg5aW1uaD2ei0JFD7VHWMD+C/Vyf07mVRgDyGWvqybBFNPu1Ws1Ht5NAA/yty
         FH8+aSApAvsvxhqHQuDFN9ue0SfT7SDiEil1T0ict80xMtHZ9QT6JSEGV2zcoCv4qA
         MYhcoAxhWfpc5+FZs7FPpciEa4LajMu0zRNkS0Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/220] RDMA/hns: Bugfix for CM test
Date:   Fri, 22 Nov 2019 11:27:32 +0100
Message-Id: <20191122100918.844138442@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 15fc056fba7b17b9abfbe80a12f188403fc949fb ]

It will print the warning when the MSB bit of SLID is not zero running
cm_req_handler function that test CM. It needs to fixed zero when test
RoCE device.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c8a3864f19122..7a7232927b126 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2268,6 +2268,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		wc->src_qp = (u8)roce_get_field(cqe->byte_32,
 						V2_CQE_BYTE_32_RMT_QPN_M,
 						V2_CQE_BYTE_32_RMT_QPN_S);
+		wc->slid = 0;
 		wc->wc_flags |= (roce_get_bit(cqe->byte_32,
 					      V2_CQE_BYTE_32_GRH_S) ?
 					      IB_WC_GRH : 0);
-- 
2.20.1



