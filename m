Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A8C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012434;
	bh=1kUZmJ5c/ZU1IkB5c8DiYV2raYgJ0M6PbYEXTBu8A64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2YPoU0i6ezXf60zROOaFXQb1tvyNzrtcbMEcQrhbwVhWwAYGaPXcT7ERFuWgQ5fv5
	 cB4tTCX1aciM/GClalzd/qMuTeYCQTUdXnSWQAaMT++MWs3xNlFXoVAfKSuO8IthlF
	 7JOiGpcq3lRSxXCU1/9fimLwSmgTq2t7G8BNPLbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfLJVNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfLJVNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CD821D7D;
        Tue, 10 Dec 2019 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012423;
        bh=1kUZmJ5c/ZU1IkB5c8DiYV2raYgJ0M6PbYEXTBu8A64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1wrqen4pWyK2zZffDdppRb1GG+XChdLCDVgcmBpX7Ztcpi0t5Ndv562OczyfDgsO
         hsbnjjoD/YIGTY698ZPZrIDJ0dXC3L/H6w9TiDWWmBd4TxXlSBnc4xjpnybKq83tpF
         rTD2Q62Y/65I6L+lf4HzcKRW6OycOZZcslSkbSHs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 338/350] ice: Only disable VF state when freeing each VF resources
Date:   Tue, 10 Dec 2019 16:07:23 -0500
Message-Id: <20191210210735.9077-299-sashal@kernel.org>
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

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

[ Upstream commit 1f9639d2fb9188a59acafae9dea626391c442a8d ]

It is wrong to set PF disable state flag for all VFs when freeing VF
resources - Instead, we should set VF disable state flag for each VF with
its resources being returned to the device. Right now, all VF opcodes,
mailbox communication to clear its resources as well fails - since we
already indicate that PF is in disable state, with all VFs not active. In
addition, we don't need to notify VF that PF is intending to reset it, if
it is already in disabled state.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index b45797f39b2fc..c0637a0cbfe82 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -317,8 +317,9 @@ void ice_free_vfs(struct ice_pf *pf)
 	pf->num_alloc_vfs = 0;
 	for (i = 0; i < tmp; i++) {
 		if (test_bit(ICE_VF_STATE_INIT, pf->vf[i].vf_states)) {
-			/* disable VF qp mappings */
+			/* disable VF qp mappings and set VF disable state */
 			ice_dis_vf_mappings(&pf->vf[i]);
+			set_bit(ICE_VF_STATE_DIS, pf->vf[i].vf_states);
 			ice_free_vf_res(&pf->vf[i]);
 		}
 	}
@@ -1287,9 +1288,12 @@ static void ice_vc_notify_vf_reset(struct ice_vf *vf)
 	if (!vf || vf->vf_id >= vf->pf->num_alloc_vfs)
 		return;
 
-	/* verify if the VF is in either init or active before proceeding */
-	if (!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
-	    !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
+	/* Bail out if VF is in disabled state, neither initialized, nor active
+	 * state - otherwise proceed with notifications
+	 */
+	if ((!test_bit(ICE_VF_STATE_INIT, vf->vf_states) &&
+	     !test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) ||
+	    test_bit(ICE_VF_STATE_DIS, vf->vf_states))
 		return;
 
 	pfe.event = VIRTCHNL_EVENT_RESET_IMPENDING;
-- 
2.20.1

