Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED6C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1915C21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfGRBod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387934AbfGRBob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F990C06511B;
        Thu, 18 Jul 2019 01:44:31 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A77C719C67;
        Thu, 18 Jul 2019 01:44:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/26] drm/dp_mst: Refactor drm_dp_send_enum_path_resources
Date:   Wed, 17 Jul 2019 21:42:31 -0400
Message-Id: <20190718014329.8107-9-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 18 Jul 2019 01:44:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more pointers so we don't have to write out
txmsg->reply.u.path_resources each time. Also, fix line wrapping +
rearrange local variables.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ec6865e1af75..57c9c605ee17 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2350,12 +2350,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	kfree(txmsg);
 }
 
-static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
-					   struct drm_dp_mst_branch *mstb,
-					   struct drm_dp_mst_port *port)
+static int
+drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
+				struct drm_dp_mst_branch *mstb,
+				struct drm_dp_mst_port *port)
 {
-	int len;
+	struct drm_dp_enum_path_resources_ack_reply *path_res;
 	struct drm_dp_sideband_msg_tx *txmsg;
+	int len;
 	int ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
@@ -2369,14 +2371,20 @@ static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
 
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
 	if (ret > 0) {
+		path_res = &txmsg->reply.u.path_resources;
+
 		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
 			DRM_DEBUG_KMS("enum path resources nak received\n");
 		} else {
-			if (port->port_num != txmsg->reply.u.path_resources.port_number)
+			if (port->port_num != path_res->port_number)
 				DRM_ERROR("got incorrect port in response\n");
-			DRM_DEBUG_KMS("enum path resources %d: %d %d\n", txmsg->reply.u.path_resources.port_number, txmsg->reply.u.path_resources.full_payload_bw_number,
-			       txmsg->reply.u.path_resources.avail_payload_bw_number);
-			port->available_pbn = txmsg->reply.u.path_resources.avail_payload_bw_number;
+
+			DRM_DEBUG_KMS("enum path resources %d: %d %d\n",
+				      path_res->port_number,
+				      path_res->full_payload_bw_number,
+				      path_res->avail_payload_bw_number);
+			port->available_pbn =
+				path_res->avail_payload_bw_number;
 		}
 	}
 
-- 
2.21.0

