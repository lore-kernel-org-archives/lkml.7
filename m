Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F132CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C762341E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfICUso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfICUsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82C9A7BDA5;
        Tue,  3 Sep 2019 20:48:40 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400791001956;
        Tue,  3 Sep 2019 20:48:39 +0000 (UTC)
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
Subject: [PATCH v2 21/27] drm/dp_mst: Don't forget to update port->input in drm_dp_mst_handle_conn_stat()
Date:   Tue,  3 Sep 2019 16:45:59 -0400
Message-Id: <20190903204645.25487-22-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 03 Sep 2019 20:48:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This probably hasn't caused any problems up until now since it's
probably nearly impossible to encounter this in the wild, however if we
were to receive a connection status notification from the MST hub after
resume while we're in the middle of reprobing the link addresses for a
topology then there's a much larger chance that a port could have
changed from being an output port to input port (or vice versa). If we
forget to update this bit of information, we'll potentially ignore a
valid PDT change on a downstream port because we think it's an input
port.

So, make sure we read the input_port field in connection status
notifications in drm_dp_mst_handle_conn_stat() to prevent this from
happening once we've implemented suspend/resume reprobing.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 51 +++++++++++++++++++--------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 259634c5d6dc..e407aba1fbd2 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2078,18 +2078,23 @@ static void
 drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 			    struct drm_dp_connection_status_notify *conn_stat)
 {
-	struct drm_device *dev = mstb->mgr->dev;
+	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
+	struct drm_device *dev = mgr->dev;
 	struct drm_dp_mst_port *port;
-	int old_ddps;
-	bool dowork = false;
+	struct drm_connector *connector_to_destroy = NULL;
+	int old_ddps, ret;
+	u8 new_pdt;
+	bool dowork = false, create_connector = false;
 
 	port = drm_dp_get_port(mstb, conn_stat->port_number);
 	if (!port)
 		return;
 
+	mutex_lock(&port->lock);
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
 	old_ddps = port->ddps;
+	port->input = conn_stat->input_port;
 	port->mcs = conn_stat->message_capability_status;
 	port->ldps = conn_stat->legacy_device_plug_status;
 	port->ddps = conn_stat->displayport_device_plug_status;
@@ -2102,23 +2107,41 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
 		}
 	}
 
-	if (!port->input) {
-		int ret = drm_dp_port_set_pdt(port,
-					      conn_stat->peer_device_type);
-		if (ret == 1) {
-			dowork = true;
-		} else if (ret < 0) {
-			DRM_ERROR("Failed to change PDT for port %p: %d\n",
-				  port, ret);
-			dowork = false;
-		}
+	new_pdt = port->input ? DP_PEER_DEVICE_NONE : conn_stat->peer_device_type;
+
+	ret = drm_dp_port_set_pdt(port, new_pdt);
+	if (ret == 1) {
+		dowork = true;
+	} else if (ret < 0) {
+		DRM_ERROR("Failed to change PDT for port %p: %d\n",
+			  port, ret);
+		dowork = false;
+	}
+
+	/*
+	 * We unset port->connector before dropping connection_mutex so that
+	 * there's no chance any of the atomic MST helpers can accidentally
+	 * associate a to-be-destroyed connector with a port.
+	 */
+	if (port->connector && port->input) {
+		connector_to_destroy = port->connector;
+		port->connector = NULL;
+	} else if (!port->connector && !port->input) {
+		create_connector = true;
 	}
 
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	if (connector_to_destroy)
+		mgr->cbs->destroy_connector(mgr, connector_to_destroy);
+	else if (create_connector)
+		drm_dp_mst_port_add_connector(mstb, port);
+
+	mutex_unlock(&port->lock);
+
 	drm_dp_mst_topology_put_port(port);
 	if (dowork)
 		queue_work(system_long_wq, &mstb->mgr->work);
-
 }
 
 static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.21.0

