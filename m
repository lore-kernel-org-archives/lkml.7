Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F94204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256088;
	bh=i5Tnf8GKc+T5DsogbNov/8sOh0Xgi8yse5m3alSW6wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONgC4SssC1Ob6ut+UDhnRYFxwNp9tsWaflkd5CI5OG0rwCBdloAWB3xPVRkbWOaT6
	 Ut9vmbSRJNY9wn20Wb69tATgyqk26QRfQGP6UPhEbtP5I6lGJxe4a+YjPwoxAYI9Yf
	 hM6X35b7C4kaPAxzMpszCydvMsNT3CquaU6TG6K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbfCVMB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730498AbfCVMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DCF204FD;
        Fri, 22 Mar 2019 12:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256082;
        bh=i5Tnf8GKc+T5DsogbNov/8sOh0Xgi8yse5m3alSW6wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUk9mw0t6K4fP+ZVWnuTLlTATV832q/5Iwdsq8Gz/rpjmRULstraXYXTrycYxriL2
         HFpvJHnkX3WJ8nQkh66IqzCt1rG7t4bUg3a35dJPhBZFeJgFQyWhZQDa/CjVjO1+27
         CwI6jfiR+YYoSfHfqlS55Izh9tLajvKa0nzgmilI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/280] qed: Fix iWARP buffer size provided for syn packet processing.
Date:   Fri, 22 Mar 2019 12:14:00 +0100
Message-Id: <20190322111311.325181153@linuxfoundation.org>
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
index e860bdf0f752..3c932f79a02e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2606,7 +2606,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	struct qed_iwarp_info *iwarp_info;
 	struct qed_ll2_acquire_data data;
 	struct qed_ll2_cbs cbs;
-	u32 mpa_buff_size;
+	u32 buff_size;
 	u16 n_ooo_bufs;
 	int rc = 0;
 	int i;
@@ -2633,7 +2633,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 
 	memset(&data, 0, sizeof(data));
 	data.input.conn_type = QED_LL2_TYPE_IWARP;
-	data.input.mtu = QED_IWARP_MAX_SYN_PKT_SIZE;
+	data.input.mtu = params->max_mtu;
 	data.input.rx_num_desc = QED_IWARP_LL2_SYN_RX_SIZE;
 	data.input.tx_num_desc = QED_IWARP_LL2_SYN_TX_SIZE;
 	data.input.tx_max_bds_per_packet = 1;	/* will never be fragmented */
@@ -2655,9 +2655,10 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
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
@@ -2711,10 +2712,9 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
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
@@ -2727,7 +2727,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 
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



