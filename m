Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF3720657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505539;
	bh=cDoCzvKMYVJaHbEs2UZyyXf+MUS7wuGz0oKLbeBVYNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWzfO62wjyGc5jo8Xooxrga1ww5tSgYvJON84EOZcn7OxLacJzsvtEtK3dTKvLqh/
	 ohB1wEMT/7+23gKPqmqUL819gEOQCieOldCQmLA4FT3KWhwrAjhpN3eIQA0EXi5xuA
	 xdzu+ofhm6ZKVJ24JLjhHgnje9p5v27BsXoPapFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCMTcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfCMTLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567112173C;
        Wed, 13 Mar 2019 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504273;
        bh=cDoCzvKMYVJaHbEs2UZyyXf+MUS7wuGz0oKLbeBVYNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMeLt5E3yfN9sNkpyGTPrBMMvaJYsEsu5OSLr6GYjhpccluR/qHb1/OnyzA0Qgxg0
         1BrUP4hV2vNSJpGGiWXh7OV9MX7wmCYCJT87/QrMQwWkxjbndeilc9nP4ehgag6FX+
         gpklPdIbyVMB8Z46QRA9RFn4lvy/kLogDQr5x+J8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 25/60] qed: Fix iWARP buffer size provided for syn packet processing.
Date:   Wed, 13 Mar 2019 15:09:46 -0400
Message-Id: <20190313191021.158171-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 9addc92730df55e2c05e8d3f69267a89d65bcba8 ]

The assumption that the maximum size of a syn packet is 128 bytes
is wrong. Tunneling headers were not accounted for.
Allocate buffers large enough for mtu.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 12 ++++++------
 drivers/net/ethernet/qlogic/qed/qed_iwarp.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index beb8e5d6401a..e84fb01b91fd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2605,7 +2605,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	struct qed_iwarp_info *iwarp_info;
 	struct qed_ll2_acquire_data data;
 	struct qed_ll2_cbs cbs;
-	u32 mpa_buff_size;
+	u32 buff_size;
 	u16 n_ooo_bufs;
 	int rc = 0;
 	int i;
@@ -2632,7 +2632,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 
 	memset(&data, 0, sizeof(data));
 	data.input.conn_type = QED_LL2_TYPE_IWARP;
-	data.input.mtu = QED_IWARP_MAX_SYN_PKT_SIZE;
+	data.input.mtu = params->max_mtu;
 	data.input.rx_num_desc = QED_IWARP_LL2_SYN_RX_SIZE;
 	data.input.tx_num_desc = QED_IWARP_LL2_SYN_TX_SIZE;
 	data.input.tx_max_bds_per_packet = 1;	/* will never be fragmented */
@@ -2654,9 +2654,10 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 		goto err;
 	}
 
+	buff_size = QED_IWARP_MAX_BUF_SIZE(params->max_mtu);
 	rc = qed_iwarp_ll2_alloc_buffers(p_hwfn,
 					 QED_IWARP_LL2_SYN_RX_SIZE,
-					 QED_IWARP_MAX_SYN_PKT_SIZE,
+					 buff_size,
 					 iwarp_info->ll2_syn_handle);
 	if (rc)
 		goto err;
@@ -2710,10 +2711,9 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	if (rc)
 		goto err;
 
-	mpa_buff_size = QED_IWARP_MAX_BUF_SIZE(params->max_mtu);
 	rc = qed_iwarp_ll2_alloc_buffers(p_hwfn,
 					 data.input.rx_num_desc,
-					 mpa_buff_size,
+					 buff_size,
 					 iwarp_info->ll2_mpa_handle);
 	if (rc)
 		goto err;
@@ -2726,7 +2726,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 
 	iwarp_info->max_num_partial_fpdus = (u16)p_hwfn->p_rdma_info->num_qps;
 
-	iwarp_info->mpa_intermediate_buf = kzalloc(mpa_buff_size, GFP_KERNEL);
+	iwarp_info->mpa_intermediate_buf = kzalloc(buff_size, GFP_KERNEL);
 	if (!iwarp_info->mpa_intermediate_buf)
 		goto err;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.h b/drivers/net/ethernet/qlogic/qed/qed_iwarp.h
index b8f612d00241..7ac959038324 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.h
@@ -46,7 +46,6 @@ enum qed_iwarp_qp_state qed_roce2iwarp_state(enum qed_roce_qp_state state);
 
 #define QED_IWARP_LL2_SYN_TX_SIZE       (128)
 #define QED_IWARP_LL2_SYN_RX_SIZE       (256)
-#define QED_IWARP_MAX_SYN_PKT_SIZE      (128)
 
 #define QED_IWARP_LL2_OOO_DEF_TX_SIZE   (256)
 #define QED_IWARP_MAX_OOO		(16)
-- 
2.19.1

