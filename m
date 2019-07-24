Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B426C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ADA2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998917;
	bh=DQtB6ZPjk3Dv4VIyCVItFwygJ3J3xRlKQFFSM/g2vtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTMG3rad0eoBGc/G3y+1TXdTAo4TGR1GvHQxp71s/yn0CrAgwonoocSefJ7sOTRbq
	 a8Asxr+9LMGoL3UGXGDrUoJjWMLOZtS9PtCmgThkNLd23Z2RjCaDVebumUsu+WDQ9b
	 kIO26fhA8CAq2oXmpiVwDYF8qGe2J7V2a0ltxfh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405453AbfGXUCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405025AbfGXUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3C22147A;
        Wed, 24 Jul 2019 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998525;
        bh=DQtB6ZPjk3Dv4VIyCVItFwygJ3J3xRlKQFFSM/g2vtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3B0ZtG2ifHn0KHzleSJmbpl2haQ4WBzpk2IRrLQ1GNS4I2DCLMwRHdO2YgdwlszB
         b2Sl3aUTGgoiRjkzGQheVvnPo/sFc8t671x/BLUJE6omwrizB4LfjX1zNO2wAqJX87
         QUYN6ETMlX2+5yBLrTWqOxn/dD54M8Qk/O2DguRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/271] qed: Set the doorbell address correctly
Date:   Wed, 24 Jul 2019 21:18:13 +0200
Message-Id: <20190724191657.280828166@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 4dd82a1612aa..a6a9688db307 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -3096,6 +3096,7 @@ static void qed_nvm_info_free(struct qed_hwfn *p_hwfn)
 static int qed_hw_prepare_single(struct qed_hwfn *p_hwfn,
 				 void __iomem *p_regview,
 				 void __iomem *p_doorbells,
+				 u64 db_phys_addr,
 				 enum qed_pci_personality personality)
 {
 	int rc = 0;
@@ -3103,6 +3104,7 @@ static int qed_hw_prepare_single(struct qed_hwfn *p_hwfn,
 	/* Split PCI bars evenly between hwfns */
 	p_hwfn->regview = p_regview;
 	p_hwfn->doorbells = p_doorbells;
+	p_hwfn->db_phys_addr = db_phys_addr;
 
 	if (IS_VF(p_hwfn->cdev))
 		return qed_vf_hw_prepare(p_hwfn);
@@ -3198,7 +3200,9 @@ int qed_hw_prepare(struct qed_dev *cdev,
 	/* Initialize the first hwfn - will learn number of hwfns */
 	rc = qed_hw_prepare_single(p_hwfn,
 				   cdev->regview,
-				   cdev->doorbells, personality);
+				   cdev->doorbells,
+				   cdev->db_phys_addr,
+				   personality);
 	if (rc)
 		return rc;
 
@@ -3207,22 +3211,25 @@ int qed_hw_prepare(struct qed_dev *cdev,
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



