Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52213C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1CD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfGRBpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbfGRBom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F20C130917A8;
        Thu, 18 Jul 2019 01:44:41 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23AB119C67;
        Thu, 18 Jul 2019 01:44:39 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/26] drm/dp_mst: Cleanup drm_dp_send_link_address() a bit
Date:   Wed, 17 Jul 2019 21:42:37 -0400
Message-Id: <20190718014329.8107-15-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Jul 2019 01:44:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare local pointer to the drm_dp_link_address_ack_reply struct
instead of constantly dereferencing it through the union in
txmsg->reply. Then, invert the order of conditionals so we don't have to
do the bulk of the work inside them, and can wrap lines even less. Then
finally, rearrange variable declarations a bit.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 42 +++++++++++++++------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 26541af47d91..13adfb77bf00 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2311,9 +2311,9 @@ drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
 static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 				     struct drm_dp_mst_branch *mstb)
 {
-	int len;
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int ret;
+	struct drm_dp_link_address_ack_reply *reply;
+	int i, len, ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
@@ -2325,28 +2325,32 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	mstb->link_address_sent = true;
 	drm_dp_queue_down_tx(mgr, txmsg);
 
+	/* FIXME: Actually do some real error handling here */
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret > 0) {
-		int i;
+	if (ret <= 0) {
+		DRM_ERROR("Sending link address failed with %d\n", ret);
+		goto out;
+	}
+	if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
+		DRM_ERROR("link address NAK received\n");
+		ret = -EIO;
+		goto out;
+	}
 
-		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
-			DRM_DEBUG_KMS("link address nak received\n");
-		} else {
-			DRM_DEBUG_KMS("link address reply: %d\n", txmsg->reply.u.link_addr.nports);
-			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
+	reply = &txmsg->reply.u.link_addr;
+	DRM_DEBUG_KMS("link address reply: %d\n", reply->nports);
+	drm_dp_dump_link_address(reply);
 
-			drm_dp_check_mstb_guid(mstb, txmsg->reply.u.link_addr.guid);
+	drm_dp_check_mstb_guid(mstb, reply->guid);
 
-			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++) {
-				drm_dp_add_port(mstb, mgr->dev, &txmsg->reply.u.link_addr.ports[i]);
-			}
-			drm_kms_helper_hotplug_event(mgr->dev);
-		}
-	} else {
-		mstb->link_address_sent = false;
-		DRM_DEBUG_KMS("link address failed %d\n", ret);
-	}
+	for (i = 0; i < reply->nports; i++)
+		drm_dp_add_port(mstb, mgr->dev, &reply->ports[i]);
+
+	drm_kms_helper_hotplug_event(mgr->dev);
 
+out:
+	if (ret <= 0)
+		mstb->link_address_sent = false;
 	kfree(txmsg);
 }
 
-- 
2.21.0

