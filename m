Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ACB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013335;
	bh=dEYdNzA7sCJZoAWIs+glPqeh02jENtriAG4jZL0kQbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POIvVH/B6oYGaCn9F7FOJkOrLWlwaZDlCHyTqX7nX20SyrJssJ0h3Ctpex1s7Xz3k
	 LFQoX5BcJQEYiV8NzLhSXG2VUhmN99YhNhdjI8KZnPqEoqn8uuy/VquEtGoQBMa6oT
	 WVb2Hp8kjE5QCqJ10cnBfKSIIjPtV0UYtKU5f9b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfLJVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfLJVKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99446246AF;
        Tue, 10 Dec 2019 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012209;
        bh=dEYdNzA7sCJZoAWIs+glPqeh02jENtriAG4jZL0kQbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xt4Xfaqkgn6L2U1WUYUNepDdvxuXnIfWYoW2LRdX6ZjapUlvMB84rQpHoI4Vao52M
         4qmfkg742DoCANxKQFpy4q6kNYySFcb6k8+QSfofm8UtDpZSkchlmH85acNVG1s2tK
         mwhL+OP0F7O/yUJxRFO0uelAnHFOYbd/lljvOZf0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Nunley <nicholas.d.nunley@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 161/350] i40e: initialize ITRN registers with correct values
Date:   Tue, 10 Dec 2019 16:04:26 -0500
Message-Id: <20191210210735.9077-122-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

[ Upstream commit 998e5166e604fd37afe94352f7b8c2d816b11049 ]

Since commit 92418fb14750 ("i40e/i40evf: Use usec value instead of reg
value for ITR defines") the driver tracks the interrupt throttling
intervals in single usec units, although the actual ITRN/ITR0 registers are
programmed in 2 usec units. Most register programming flows in the driver
correctly handle the conversion, although it is currently not applied when
the registers are initialized to their default values. Most of the time
this doesn't present a problem since the default values are usually
immediately overwritten through the standard adaptive throttling mechanism,
or updated manually by the user, but if adaptive throttling is disabled and
the interval values are left alone then the incorrect value will persist.

Since the intended default interval of 50 usecs (vs. 100 usecs as
programmed) performs better for most traffic workloads, this can lead to
performance regressions.

This patch adds the correct conversion when writing the initial values to
the ITRN registers.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6031223eafab8..339925af02062 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3534,14 +3534,14 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 		q_vector->rx.target_itr =
 			ITR_TO_REG(vsi->rx_rings[i]->itr_setting);
 		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, vector - 1),
-		     q_vector->rx.target_itr);
+		     q_vector->rx.target_itr >> 1);
 		q_vector->rx.current_itr = q_vector->rx.target_itr;
 
 		q_vector->tx.next_update = jiffies + 1;
 		q_vector->tx.target_itr =
 			ITR_TO_REG(vsi->tx_rings[i]->itr_setting);
 		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, vector - 1),
-		     q_vector->tx.target_itr);
+		     q_vector->tx.target_itr >> 1);
 		q_vector->tx.current_itr = q_vector->tx.target_itr;
 
 		wr32(hw, I40E_PFINT_RATEN(vector - 1),
@@ -3646,11 +3646,11 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
 	/* set the ITR configuration */
 	q_vector->rx.next_update = jiffies + 1;
 	q_vector->rx.target_itr = ITR_TO_REG(vsi->rx_rings[0]->itr_setting);
-	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), q_vector->rx.target_itr);
+	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), q_vector->rx.target_itr >> 1);
 	q_vector->rx.current_itr = q_vector->rx.target_itr;
 	q_vector->tx.next_update = jiffies + 1;
 	q_vector->tx.target_itr = ITR_TO_REG(vsi->tx_rings[0]->itr_setting);
-	wr32(hw, I40E_PFINT_ITR0(I40E_TX_ITR), q_vector->tx.target_itr);
+	wr32(hw, I40E_PFINT_ITR0(I40E_TX_ITR), q_vector->tx.target_itr >> 1);
 	q_vector->tx.current_itr = q_vector->tx.target_itr;
 
 	i40e_enable_misc_int_causes(pf);
@@ -11396,7 +11396,7 @@ static int i40e_setup_misc_vector(struct i40e_pf *pf)
 
 	/* associate no queues to the misc vector */
 	wr32(hw, I40E_PFINT_LNKLST0, I40E_QUEUE_END_OF_LIST);
-	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), I40E_ITR_8K);
+	wr32(hw, I40E_PFINT_ITR0(I40E_RX_ITR), I40E_ITR_8K >> 1);
 
 	i40e_flush(hw);
 
-- 
2.20.1

