Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FEDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C564A2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfICUrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfICUrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:47:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2F2510F09;
        Tue,  3 Sep 2019 20:47:39 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A13E81001B02;
        Tue,  3 Sep 2019 20:47:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/27] drm/dp_mst: Move link address dumping into a function
Date:   Tue,  3 Sep 2019 16:45:39 -0400
Message-Id: <20190903204645.25487-2-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 03 Sep 2019 20:47:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes things easier to read.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 82add736e17d..36db66a0ddb1 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2103,6 +2103,28 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
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
@@ -2128,18 +2150,7 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
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

