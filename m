Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F275AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA42B206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642124;
	bh=fsAlUN/G6n68DhtQhTV/M/YPqQwOFu4GkGS865YO4OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsZXMl2hgKiqCyD/BG4yaeQmrfbZWsx3HGgHgKdgRJ/raDJ/ugI8mpQipOY6dKpgB
	 tLyd7g9f96H1Wt3KdN85obS5k1p9E19px7Bv/NVfOPLJ7p3Qsn2g7RgcXKWlcf995j
	 Z4VBOxnXz6P/AX80+zwicvCFvpoOYF8PEN3mu8f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfL2RzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732879AbfL2RzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2855222C3;
        Sun, 29 Dec 2019 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642120;
        bh=fsAlUN/G6n68DhtQhTV/M/YPqQwOFu4GkGS865YO4OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3a/IkRYxpcZcYJaMPntskD3zo3YTXZt3AFR70M/qaSr4pANJUjaWYFwCk4f0tEhG
         aSzU8PFvoESx62xUlgwdYm1Eidb5B2+lNWIiL769bxQAiMWO2BH5FJndJzoyqfnGiz
         /OGKbSwr8j8VmvPtF3MEP3kCJQmDaDph9BGT/dOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 350/434] ice: Only disable VF state when freeing each VF resources
Date:   Sun, 29 Dec 2019 18:26:43 +0100
Message-Id: <20191229172725.220428240@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b45797f39b2f..c0637a0cbfe8 100644
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



