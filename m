Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D09C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30945204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256094;
	bh=Gkn/eUFoFGVQL9DFiC5Fh0FXzYrUuKNlZN3SgpcYppU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjgn+xdptmObkNKJ2Qv2jgag7alUVmcepjSH8re8o9blVD6+zHWlwQEcfYQzyhRWx
	 ukd4Yv62V4LVDLVKHHzdzx8CODDu8D3S4Gv1vxujmftyMn+/XuJmD/bC9h/fPkHLLA
	 tZM2ioupfmxwn6P2KMNql0J7aRmRBCp7FNl1lVgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbfCVMBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388206AbfCVMBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59AD204FD;
        Fri, 22 Mar 2019 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256085;
        bh=Gkn/eUFoFGVQL9DFiC5Fh0FXzYrUuKNlZN3SgpcYppU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZqfzmml1eHhdcna0UDTrmHZrMHuzgF3jShcgU1SPOqnUFoPcDdrIaRmjPUljEoCC
         184FUK5SQY/X+epgqBo8XfXjYjSXpgZelJj3BHp5mG/1SOcprvakFGN6eK1YXrtukN
         aeZASUBCfAlovoO3eoVLYxw6Tjga3W9btXdt91FA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/280] qed: Fix iWARP syn packet mac address validation.
Date:   Fri, 22 Mar 2019 12:14:01 +0100
Message-Id: <20190322111311.400830022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8be3dadf04050c2907760ec1955ca1c8fbc25585 ]

The ll2 forwards all syn packets to the driver without validating the mac
address. Add validation check in the driver's iWARP listener flow and drop
the packet if it isn't intended for the device.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 3c932f79a02e..b7471e48db7b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1689,6 +1689,15 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
 	eth_hlen = ETH_HLEN + (vlan_valid ? sizeof(u32) : 0);
 
+	if (!ether_addr_equal(ethh->h_dest,
+			      p_hwfn->p_rdma_info->iwarp.mac_addr)) {
+		DP_VERBOSE(p_hwfn,
+			   QED_MSG_RDMA,
+			   "Got unexpected mac %pM instead of %pM\n",
+			   ethh->h_dest, p_hwfn->p_rdma_info->iwarp.mac_addr);
+		return -EINVAL;
+	}
+
 	ether_addr_copy(remote_mac_addr, ethh->h_source);
 	ether_addr_copy(local_mac_addr, ethh->h_dest);
 
-- 
2.19.1



