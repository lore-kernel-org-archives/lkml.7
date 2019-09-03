Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DC0233A1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfICUs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:48:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbfICUs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9AAA2A09B5;
        Tue,  3 Sep 2019 20:48:25 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE061001B08;
        Tue,  3 Sep 2019 20:48:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/27] drm/dp_mst: Refactor drm_dp_mst_handle_down_rep()
Date:   Tue,  3 Sep 2019 16:45:51 -0400
Message-Id: <20190903204645.25487-14-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 03 Sep 2019 20:48:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove the big ugly have_eomt conditional
* Store &mgr->down_rep_recv.initial_hdr in a var to make line wrapping
  easier
* Remove duplicate memset() calls
* Actually wrap lines

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 102 +++++++++++++-------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 64487098158a..74161f442584 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3179,68 +3179,66 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
 
 static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 {
-	int ret = 0;
+	struct drm_dp_sideband_msg_tx *txmsg;
+	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_sideband_msg_hdr *hdr = &mgr->down_rep_recv.initial_hdr;
+	int slot = -1;
+
+	if (!drm_dp_get_one_sb_msg(mgr, false))
+		goto clear_down_rep_recv;
 
-	if (!drm_dp_get_one_sb_msg(mgr, false)) {
-		memset(&mgr->down_rep_recv, 0,
-		       sizeof(struct drm_dp_sideband_msg_rx));
+	if (!mgr->down_rep_recv.have_eomt)
 		return 0;
+
+	mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
+	if (!mstb) {
+		DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
+			      hdr->lct);
+		goto clear_down_rep_recv;
 	}
 
-	if (mgr->down_rep_recv.have_eomt) {
-		struct drm_dp_sideband_msg_tx *txmsg;
-		struct drm_dp_mst_branch *mstb;
-		int slot = -1;
-		mstb = drm_dp_get_mst_branch_device(mgr,
-						    mgr->down_rep_recv.initial_hdr.lct,
-						    mgr->down_rep_recv.initial_hdr.rad);
+	/* find the message */
+	slot = hdr->seqno;
+	mutex_lock(&mgr->qlock);
+	txmsg = mstb->tx_slots[slot];
+	/* remove from slots */
+	mutex_unlock(&mgr->qlock);
 
-		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->down_rep_recv.initial_hdr.lct);
-			memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-			return 0;
-		}
+	if (!txmsg) {
+		DRM_DEBUG_KMS("Got MST reply with no msg %p %d %d %02x %02x\n",
+			      mstb, hdr->seqno, hdr->lct, hdr->rad[0],
+			      mgr->down_rep_recv.msg[0]);
+		goto no_msg;
+	}
 
-		/* find the message */
-		slot = mgr->down_rep_recv.initial_hdr.seqno;
-		mutex_lock(&mgr->qlock);
-		txmsg = mstb->tx_slots[slot];
-		/* remove from slots */
-		mutex_unlock(&mgr->qlock);
-
-		if (!txmsg) {
-			DRM_DEBUG_KMS("Got MST reply with no msg %p %d %d %02x %02x\n",
-			       mstb,
-			       mgr->down_rep_recv.initial_hdr.seqno,
-			       mgr->down_rep_recv.initial_hdr.lct,
-				      mgr->down_rep_recv.initial_hdr.rad[0],
-				      mgr->down_rep_recv.msg[0]);
-			drm_dp_mst_topology_put_mstb(mstb);
-			memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-			return 0;
-		}
+	drm_dp_sideband_parse_reply(&mgr->down_rep_recv, &txmsg->reply);
 
-		drm_dp_sideband_parse_reply(&mgr->down_rep_recv, &txmsg->reply);
+	if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
+		DRM_DEBUG_KMS("Got NAK reply: req 0x%02x (%s), reason 0x%02x (%s), nak data 0x%02x\n",
+			      txmsg->reply.req_type,
+			      drm_dp_mst_req_type_str(txmsg->reply.req_type),
+			      txmsg->reply.u.nak.reason,
+			      drm_dp_mst_nak_reason_str(txmsg->reply.u.nak.reason),
+			      txmsg->reply.u.nak.nak_data);
 
-		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
-			DRM_DEBUG_KMS("Got NAK reply: req 0x%02x (%s), reason 0x%02x (%s), nak data 0x%02x\n",
-				      txmsg->reply.req_type,
-				      drm_dp_mst_req_type_str(txmsg->reply.req_type),
-				      txmsg->reply.u.nak.reason,
-				      drm_dp_mst_nak_reason_str(txmsg->reply.u.nak.reason),
-				      txmsg->reply.u.nak.nak_data);
-
-		memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
-		drm_dp_mst_topology_put_mstb(mstb);
+	memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
+	drm_dp_mst_topology_put_mstb(mstb);
 
-		mutex_lock(&mgr->qlock);
-		txmsg->state = DRM_DP_SIDEBAND_TX_RX;
-		mstb->tx_slots[slot] = NULL;
-		mutex_unlock(&mgr->qlock);
+	mutex_lock(&mgr->qlock);
+	txmsg->state = DRM_DP_SIDEBAND_TX_RX;
+	mstb->tx_slots[slot] = NULL;
+	mutex_unlock(&mgr->qlock);
 
-		wake_up_all(&mgr->tx_waitq);
-	}
-	return ret;
+	wake_up_all(&mgr->tx_waitq);
+
+	return 0;
+
+no_msg:
+	drm_dp_mst_topology_put_mstb(mstb);
+clear_down_rep_recv:
+	memset(&mgr->down_rep_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
+
+	return 0;
 }
 
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
-- 
2.21.0

