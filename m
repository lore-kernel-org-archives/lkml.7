Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346B0217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199535;
	bh=HpAbu3A6Jvf24y3EwjviCDineI4pRIVpAxvEnBhYvKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+7oy9SeNVFzUvVk8THPl+qzVg1MJ3HTZ3k2n1OCsUXoPEoeLVVKd98UP2MsLHQ5/
	 HzRlmUNkLh1c+wWT1L35xRE9METT9M9PwvOVLxF89h9eoUvvPYq8DHDPV7gFbg5RGM
	 crZyM/efhNU/KcPKwwd/m03U5GoQuSWIM+3fVLC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbfGOOFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387652AbfGOOFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:05:24 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8577E206B8;
        Mon, 15 Jul 2019 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199523;
        bh=HpAbu3A6Jvf24y3EwjviCDineI4pRIVpAxvEnBhYvKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/lIP1P7PefVVZM1eZqqmpa0gWo898D/m7PElnJN85sAM7u2Qsof9QpT5fQwX2suQ
         F6L6JjDLd4avzgpnG47yKGrsEtUSwHSBvww7N91hN5FfbOtGoHnxX0m8Y+xGFFOC/X
         7pb+2CNF+imCXM02aWLhwXnhJ/wUBP7IbRiuRKR4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 032/219] qed: Set the doorbell address correctly
Date:   Mon, 15 Jul 2019 10:00:33 -0400
Message-Id: <20190715140341.6443-32-sashal@kernel.org>
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

[ Upstream commit 8366d520019f366fabd6c7a13032bdcd837e18d4 ]

In 100g mode the doorbell bar is united for both engines. Set
the correct offset in the hwfn so that the doorbell returned
for RoCE is in the affined hwfn.

Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Denis Bolotin <denis.bolotin@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c  | 29 ++++++++++++++--------
 drivers/net/ethernet/qlogic/qed/qed_rdma.c |  2 +-
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 866cdc86a3f2..08045fd69fad 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -3441,6 +3441,7 @@ static void qed_nvm_info_free(struct qed_hwfn *p_hwfn)
 static int qed_hw_prepare_single(struct qed_hwfn *p_hwfn,
 				 void __iomem *p_regview,
 				 void __iomem *p_doorbells,
+				 u64 db_phys_addr,
 				 enum qed_pci_personality personality)
 {
 	struct qed_dev *cdev = p_hwfn->cdev;
@@ -3449,6 +3450,7 @@ static int qed_hw_prepare_single(struct qed_hwfn *p_hwfn,
 	/* Split PCI bars evenly between hwfns */
 	p_hwfn->regview = p_regview;
 	p_hwfn->doorbells = p_doorbells;
+	p_hwfn->db_phys_addr = db_phys_addr;
 
 	if (IS_VF(p_hwfn->cdev))
 		return qed_vf_hw_prepare(p_hwfn);
@@ -3544,7 +3546,9 @@ int qed_hw_prepare(struct qed_dev *cdev,
 	/* Initialize the first hwfn - will learn number of hwfns */
 	rc = qed_hw_prepare_single(p_hwfn,
 				   cdev->regview,
-				   cdev->doorbells, personality);
+				   cdev->doorbells,
+				   cdev->db_phys_addr,
+				   personality);
 	if (rc)
 		return rc;
 
@@ -3553,22 +3557,25 @@ int qed_hw_prepare(struct qed_dev *cdev,
 	/* Initialize the rest of the hwfns */
 	if (cdev->num_hwfns > 1) {
 		void __iomem *p_regview, *p_doorbell;
-		u8 __iomem *addr;
+		u64 db_phys_addr;
+		u32 offset;
 
 		/* adjust bar offset for second engine */
-		addr = cdev->regview +
-		       qed_hw_bar_size(p_hwfn, p_hwfn->p_main_ptt,
-				       BAR_ID_0) / 2;
-		p_regview = addr;
+		offset = qed_hw_bar_size(p_hwfn, p_hwfn->p_main_ptt,
+					 BAR_ID_0) / 2;
+		p_regview = cdev->regview + offset;
 
-		addr = cdev->doorbells +
-		       qed_hw_bar_size(p_hwfn, p_hwfn->p_main_ptt,
-				       BAR_ID_1) / 2;
-		p_doorbell = addr;
+		offset = qed_hw_bar_size(p_hwfn, p_hwfn->p_main_ptt,
+					 BAR_ID_1) / 2;
+
+		p_doorbell = cdev->doorbells + offset;
+
+		db_phys_addr = cdev->db_phys_addr + offset;
 
 		/* prepare second hw function */
 		rc = qed_hw_prepare_single(&cdev->hwfns[1], p_regview,
-					   p_doorbell, personality);
+					   p_doorbell, db_phys_addr,
+					   personality);
 
 		/* in case of error, need to free the previously
 		 * initiliazed hwfn 0.
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 7873d6dfd91f..13802b825d65 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -803,7 +803,7 @@ static int qed_rdma_add_user(void *rdma_cxt,
 				     dpi_start_offset +
 				     ((out_params->dpi) * p_hwfn->dpi_size));
 
-	out_params->dpi_phys_addr = p_hwfn->cdev->db_phys_addr +
+	out_params->dpi_phys_addr = p_hwfn->db_phys_addr +
 				    dpi_start_offset +
 				    ((out_params->dpi) * p_hwfn->dpi_size);
 
-- 
2.20.1

