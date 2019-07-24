Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800AF229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996296;
	bh=ZlQrevqVxc84cddOpeGoAobSvayuwpStagSYQwjfh9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kKASTUhWyusT4htJFEPKEzybrUjFWCKCI/qmUMnyL7zZKdr28DWj5+bbILpt6vfqM
	 lKZ0euu588OBVDNzIP2wLjQwD6JGk9pC3tt/rzD81Ij7bBd3xChDi7nZFErSHW124X
	 Tqx6Dp8eABYFZl41C6t8UL+U6NC46sUBzUNHD1qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbfGXTYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfGXTYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:24:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C8721951;
        Wed, 24 Jul 2019 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996288;
        bh=ZlQrevqVxc84cddOpeGoAobSvayuwpStagSYQwjfh9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxUC7px+OtzwcTVvYdenGXR4JGd7IGXQSlDxZvnBdwXPTBmi896HyG1q5U14RAkAC
         5Jy3Ry0ClO+n7Ve9RntxAtbWIP5uD2+wJhs7vhtBWhlA7fwEdWj4fyNMjPxqGu8XgR
         NqO6KqG5r/z976MKs5hBNlG7pq5VGOTeMcEZjXpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitch Williams <mitch.a.williams@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 046/413] ice: Check all VFs for MDD activity, dont disable
Date:   Wed, 24 Jul 2019 21:15:37 +0200
Message-Id: <20190724191738.846144340@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 23c0112246b454e408fb0579b3f9089353d4d327 ]

Don't use the mdd_detected variable as an exit condition for this loop;
the first VF to NOT have an MDD event will cause the loop to terminate.

Instead just look at all of the VFs, but don't disable them. This
prevents proper release of resources if the VFs are rebooted or the VF
driver reloaded. Instead, just log a message and call out repeat
offenders.

To make it clear what we are doing, use a differently-named variable in
the loop.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dbf3d39ad8b1..1c803106e301 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1161,16 +1161,16 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		}
 	}
 
-	/* see if one of the VFs needs to be reset */
-	for (i = 0; i < pf->num_alloc_vfs && mdd_detected; i++) {
+	/* check to see if one of the VFs caused the MDD */
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
 		struct ice_vf *vf = &pf->vf[i];
 
-		mdd_detected = false;
+		bool vf_mdd_detected = false;
 
 		reg = rd32(hw, VP_MDET_TX_PQM(i));
 		if (reg & VP_MDET_TX_PQM_VALID_M) {
 			wr32(hw, VP_MDET_TX_PQM(i), 0xFFFF);
-			mdd_detected = true;
+			vf_mdd_detected = true;
 			dev_info(&pf->pdev->dev, "TX driver issue detected on VF %d\n",
 				 i);
 		}
@@ -1178,7 +1178,7 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		reg = rd32(hw, VP_MDET_TX_TCLAN(i));
 		if (reg & VP_MDET_TX_TCLAN_VALID_M) {
 			wr32(hw, VP_MDET_TX_TCLAN(i), 0xFFFF);
-			mdd_detected = true;
+			vf_mdd_detected = true;
 			dev_info(&pf->pdev->dev, "TX driver issue detected on VF %d\n",
 				 i);
 		}
@@ -1186,7 +1186,7 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		reg = rd32(hw, VP_MDET_TX_TDPU(i));
 		if (reg & VP_MDET_TX_TDPU_VALID_M) {
 			wr32(hw, VP_MDET_TX_TDPU(i), 0xFFFF);
-			mdd_detected = true;
+			vf_mdd_detected = true;
 			dev_info(&pf->pdev->dev, "TX driver issue detected on VF %d\n",
 				 i);
 		}
@@ -1194,19 +1194,18 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		reg = rd32(hw, VP_MDET_RX(i));
 		if (reg & VP_MDET_RX_VALID_M) {
 			wr32(hw, VP_MDET_RX(i), 0xFFFF);
-			mdd_detected = true;
+			vf_mdd_detected = true;
 			dev_info(&pf->pdev->dev, "RX driver issue detected on VF %d\n",
 				 i);
 		}
 
-		if (mdd_detected) {
+		if (vf_mdd_detected) {
 			vf->num_mdd_events++;
-			dev_info(&pf->pdev->dev,
-				 "Use PF Control I/F to re-enable the VF\n");
-			set_bit(ICE_VF_STATE_DIS, vf->vf_states);
+			if (vf->num_mdd_events > 1)
+				dev_info(&pf->pdev->dev, "VF %d has had %llu MDD events since last boot\n",
+					 i, vf->num_mdd_events);
 		}
 	}
-
 }
 
 /**
-- 
2.20.1



