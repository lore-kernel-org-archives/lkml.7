Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E62C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5320726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518651;
	bh=QncCh4pQTgUhpPvU4k9NamkWDYyRUhFGs+V6hZtJi64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hcx738gjJ3P2PnVFLXIm+S6k6JIWX/X4f8tSZkW10gqyNKxDVDM8bRyYBSc8GkAsN
	 CHhTp6VLnbhpmkndjyUgffg5tBFaF0xPK5AMqahyiWz2DkSHWaag7/TBbH19TKDkmJ
	 IWmxvZSR+N3N8WWHbL7I4Hx4p3jf8dcRH3GqB+Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfLPRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfLPRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:50:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAD920700;
        Mon, 16 Dec 2019 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518648;
        bh=QncCh4pQTgUhpPvU4k9NamkWDYyRUhFGs+V6hZtJi64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJE3FrHr82CcwgwbYdQjnqVbrfnhBKK4vthEiR/zu0VZ87knSTP3Vc2kz4Wtgh2Yy
         lKBn9CdlA4gndBegtOA6kq8jcgprevcxPHoIsJzBFKMUNxeazazP2Uq4pxnUPm3iDx
         Ubvq8WoZ1Vg8IA0+tgtDPISx69KfWyeXs/j8TS5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sirong Wang <wangsirong@huawei.com>,
        Weihang Li <liweihang@hisilicon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 010/267] RDMA/hns: Correct the value of HNS_ROCE_HEM_CHUNK_LEN
Date:   Mon, 16 Dec 2019 18:45:36 +0100
Message-Id: <20191216174849.991213168@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sirong Wang <wangsirong@huawei.com>

[ Upstream commit 531eb45b3da4267fc2a64233ba256c8ffb02edd2 ]

Size of pointer to buf field of struct hns_roce_hem_chunk should be
considered when calculating HNS_ROCE_HEM_CHUNK_LEN, or sg table size will
be larger than expected when allocating hem.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Link: https://lore.kernel.org/r/1572575610-52530-2-git-send-email-liweihang@hisilicon.com
Signed-off-by: Sirong Wang <wangsirong@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 435748858252d..8e8917ebb013b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -52,7 +52,7 @@ enum {
 
 #define HNS_ROCE_HEM_CHUNK_LEN	\
 	 ((256 - sizeof(struct list_head) - 2 * sizeof(int)) /	 \
-	 (sizeof(struct scatterlist)))
+	 (sizeof(struct scatterlist) + sizeof(void *)))
 
 enum {
 	 HNS_ROCE_HEM_PAGE_SHIFT = 12,
-- 
2.20.1



