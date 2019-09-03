Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF48C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DED230F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfICUsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfICUse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C1DD10C6973;
        Tue,  3 Sep 2019 20:48:34 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F19861001B11;
        Tue,  3 Sep 2019 20:48:32 +0000 (UTC)
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
Subject: [PATCH v2 17/27] drm/dp_mst: Rename drm_dp_add_port and drm_dp_update_port
Date:   Tue,  3 Sep 2019 16:45:55 -0400
Message-Id: <20190903204645.25487-18-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 03 Sep 2019 20:48:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The names for these functions are rather confusing. drm_dp_add_port()
sounds like a function that would simply create a port and add it to a
topology, and do nothing more. Similarly, drm_dp_update_port() would be
assumed to be the function that should be used to update port
information after initial creation.

While those assumptions are currently correct in how these functions are
used, a quick glance at drm_dp_add_port() reveals that drm_dp_add_port()
can also update the information on a port, and seems explicitly designed
to do so. This can be explained pretty simply by the fact that there's
more situations that would involve updating the port information based
on a link address response as opposed to a connection status
notification than the driver's initial topology probe. Case in point:
reprobing link addresses after suspend/resume.

Since we're about to start using drm_dp_add_port() differently for
suspend/resume reprobing, let's rename both functions to clarify what
they actually do.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 9944ef2ce885..cfaf9eb7ace9 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1900,9 +1900,10 @@ void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
 
-static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
-			    struct drm_device *dev,
-			    struct drm_dp_link_addr_reply_port *port_msg)
+static void
+drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
+				    struct drm_device *dev,
+				    struct drm_dp_link_addr_reply_port *port_msg)
 {
 	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
 	struct drm_dp_mst_port *port;
@@ -2011,8 +2012,9 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
 	drm_dp_mst_topology_put_port(port);
 }
 
-static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
-			       struct drm_dp_connection_status_notify *conn_stat)
+static void
+drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
+			    struct drm_dp_connection_status_notify *conn_stat)
 {
 	struct drm_dp_mst_port *port;
 	int old_ddps;
@@ -2464,7 +2466,8 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	drm_dp_check_mstb_guid(mstb, reply->guid);
 
 	for (i = 0; i < reply->nports; i++)
-		drm_dp_add_port(mstb, mgr->dev, &reply->ports[i]);
+		drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
+						    &reply->ports[i]);
 
 	drm_kms_helper_hotplug_event(mgr->dev);
 
@@ -3324,7 +3327,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	}
 
 	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		drm_dp_update_port(mstb, &msg.u.conn_stat);
+		drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
 
 		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
 			      msg.u.conn_stat.port_number,
-- 
2.21.0

