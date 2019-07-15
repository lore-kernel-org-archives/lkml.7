Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4689C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9F62083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199749;
	bh=WWSyR7ZkWOULUbOIOZcSxR4qgjOH/WofWi+q0Fjb8OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDANXShqwAvvwI39APxufU+sN+jxj6RpiOctdwVIgAdlaggscy07H6xgUCy5F6nIc
	 qC6D2TKPbdLmT4ZdtF1KIoMQ5lBBIMC4kehVUNFlHVS+oVrcmmo/S69w2cynwJXK6v
	 KRy7K0WLay7pmmKAF2IjpAzsVBNJaRhQocA6F7Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbfGOOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbfGOOJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:09:04 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5127212F5;
        Mon, 15 Jul 2019 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199744;
        bh=WWSyR7ZkWOULUbOIOZcSxR4qgjOH/WofWi+q0Fjb8OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzQvDIj3zfqOA+g/FGrPdj1AYpQ3HgU5d9RukjBY4/QI3LRKuapErFcvDKH+Knt83
         DSO08gdWOepY4S1XRdJF8ERsDaelkpSp7TccK//Su2BTA+EwG9jWG/7mTETizFuZq5
         p+csxAkK3pkH2P8BtK8mdhtY/tLKGh//cOy5pP98=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 091/219] qed: iWARP - Fix tc for MPA ll2 connection
Date:   Mon, 15 Jul 2019 10:01:32 -0400
Message-Id: <20190715140341.6443-91-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit cb94d52b93c74fe1f2595734fabeda9f8ae891ee ]

The driver needs to assign a lossless traffic class for the MPA ll2
connection to ensure no packets are dropped when returning from the
driver as they will never be re-transmitted by the peer.

Fixes: ae3488ff37dc ("qed: Add ll2 connection for processing unaligned MPA packets")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index ded556b7bab5..eeea8683d99b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2708,6 +2708,8 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	data.input.rx_num_desc = n_ooo_bufs * 2;
 	data.input.tx_num_desc = data.input.rx_num_desc;
 	data.input.tx_max_bds_per_packet = QED_IWARP_MAX_BDS_PER_FPDU;
+	data.input.tx_tc = PKT_LB_TC;
+	data.input.tx_dest = QED_LL2_TX_DEST_LB;
 	data.p_connection_handle = &iwarp_info->ll2_mpa_handle;
 	data.input.secondary_queue = true;
 	data.cbs = &cbs;
-- 
2.20.1

