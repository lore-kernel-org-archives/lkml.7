Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D7C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4157204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfGRBoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbfGRBoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 761DDC049E23;
        Thu, 18 Jul 2019 01:44:00 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00F7C19C78;
        Thu, 18 Jul 2019 01:43:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/26] drm/dp_mst: Move link address dumping into a function
Date:   Wed, 17 Jul 2019 21:42:24 -0400
Message-Id: <20190718014329.8107-2-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 18 Jul 2019 01:44:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to be calling this from multiple places. Also it makes
things easier to read!

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0984b9a34d55..998081b9b205 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2013,6 +2013,28 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_unlock(&mgr->qlock);
 }
 
+static void
+drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
+{
+	struct drm_dp_link_addr_reply_port *port_reply;
+	int i;
+
+	for (i = 0; i < reply->nports; i++) {
+		port_reply = &reply->ports[i];
+		DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n",
+			      i,
+			      port_reply->input_port,
+			      port_reply->peer_device_type,
+			      port_reply->port_number,
+			      port_reply->dpcd_revision,
+			      port_reply->mcs,
+			      port_reply->ddps,
+			      port_reply->legacy_device_plug_status,
+			      port_reply->num_sdp_streams,
+			      port_reply->num_sdp_stream_sinks);
+	}
+}
+
 static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 				     struct drm_dp_mst_branch *mstb)
 {
@@ -2038,18 +2060,7 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 			DRM_DEBUG_KMS("link address nak received\n");
 		} else {
 			DRM_DEBUG_KMS("link address reply: %d\n", txmsg->reply.u.link_addr.nports);
-			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++) {
-				DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n", i,
-				       txmsg->reply.u.link_addr.ports[i].input_port,
-				       txmsg->reply.u.link_addr.ports[i].peer_device_type,
-				       txmsg->reply.u.link_addr.ports[i].port_number,
-				       txmsg->reply.u.link_addr.ports[i].dpcd_revision,
-				       txmsg->reply.u.link_addr.ports[i].mcs,
-				       txmsg->reply.u.link_addr.ports[i].ddps,
-				       txmsg->reply.u.link_addr.ports[i].legacy_device_plug_status,
-				       txmsg->reply.u.link_addr.ports[i].num_sdp_streams,
-				       txmsg->reply.u.link_addr.ports[i].num_sdp_stream_sinks);
-			}
+			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
 
 			drm_dp_check_mstb_guid(mstb, txmsg->reply.u.link_addr.guid);
 
-- 
2.21.0

