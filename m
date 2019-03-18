Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C24C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B990204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902405;
	bh=9en1prLfTBlPd6bboJ3/JkxVtL3cCCFeR3Z/SayerCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJWrDCfJXR5Yr5ZycXGqUfxwBdgzeEQpw+C3cIcP9Twnbm3mKX8E3N5Q26HPIp9xD
	 zC4YE8fw3lsuhGQMw14zfNqCSdPXM+i/llxyz06rlGCHvKWQLPptutFqPgyLrz/1Qs
	 kG23mzj3t40d0o5ODVyFJuDLT8kBtCDYMTaanHj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfCRJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfCRJ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:30 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8B82075C;
        Mon, 18 Mar 2019 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901309;
        bh=9en1prLfTBlPd6bboJ3/JkxVtL3cCCFeR3Z/SayerCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfRVL/fYMVuK1wwCsgI+U2/szlI+3/xi+Nd2bfLROhTzh/m5a8O6OxiQmVpG8GZ1K
         Lg2RffbIEJvc/5FJ7tuZuAQrJvzkTlKHDhPue2kN5ZfCgKcsXXBYEoBVuc9/Xho1IB
         dHqXowUxivJzqXgZqgrgDqxV+4gC8SSlCL5dz8kI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 08/43] net: hns3: add dma_rmb() for rx description
Date:   Mon, 18 Mar 2019 10:24:00 +0100
Message-Id: <20190318083716.120853452@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit d394d33bee22421b39a0bcdc51ca6d68ba308625 ]

HW can not guarantee complete write desc->rx.size, even though
HNS3_RXD_VLD_B has been set. Driver needs to add dma_rmb()
instruction to make sure desc->rx.size is always valid.

Fixes: e55970950556 ("net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2476,6 +2476,8 @@ static int hns3_add_frag(struct hns3_ene
 		desc = &ring->desc[ring->next_to_clean];
 		desc_cb = &ring->desc_cb[ring->next_to_clean];
 		bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
+		/* make sure HW write desc complete */
+		dma_rmb();
 		if (!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))
 			return -ENXIO;
 


