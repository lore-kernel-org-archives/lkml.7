Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A378C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F55821848
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfGRBo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfGRBo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7F2744BCD;
        Thu, 18 Jul 2019 01:44:25 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C20619C78;
        Thu, 18 Jul 2019 01:44:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/26] drm/dp_mst: Move PDT teardown for ports into destroy_connector_work
Date:   Wed, 17 Jul 2019 21:42:29 -0400
Message-Id: <20190718014329.8107-7-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 18 Jul 2019 01:44:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to add some locking for port PDTs, which can't be
done from drm_dp_destroy_port() since we don't know what locks the
caller might be holding. Also, this gets rid of a good bit of unneeded
code.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 42 +++++++++++----------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index defc5e09fb9a..0295e007c836 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1509,31 +1509,22 @@ static void drm_dp_destroy_port(struct kref *kref)
 		container_of(kref, struct drm_dp_mst_port, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
 
-	if (!port->input) {
-		kfree(port->cached_edid);
-
-		/*
-		 * The only time we don't have a connector
-		 * on an output port is if the connector init
-		 * fails.
-		 */
-		if (port->connector) {
-			/* we can't destroy the connector here, as
-			 * we might be holding the mode_config.mutex
-			 * from an EDID retrieval */
-
-			mutex_lock(&mgr->destroy_connector_lock);
-			list_add(&port->next, &mgr->destroy_connector_list);
-			mutex_unlock(&mgr->destroy_connector_lock);
-			schedule_work(&mgr->destroy_connector_work);
-			return;
-		}
-		/* no need to clean up vcpi
-		 * as if we have no connector we never setup a vcpi */
-		drm_dp_port_teardown_pdt(port, port->pdt);
-		port->pdt = DP_PEER_DEVICE_NONE;
+	/* There's nothing that needs locking to destroy an input port yet */
+	if (port->input) {
+		drm_dp_mst_put_port_malloc(port);
+		return;
 	}
-	drm_dp_mst_put_port_malloc(port);
+
+	kfree(port->cached_edid);
+
+	/*
+	 * we can't destroy the connector here, as we might be holding the
+	 * mode_config.mutex from an EDID retrieval
+	 */
+	mutex_lock(&mgr->destroy_connector_lock);
+	list_add(&port->next, &mgr->destroy_connector_list);
+	mutex_unlock(&mgr->destroy_connector_lock);
+	schedule_work(&mgr->destroy_connector_work);
 }
 
 /**
@@ -3881,7 +3872,8 @@ drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
 {
 	INIT_LIST_HEAD(&port->next);
 
-	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+	if (port->connector)
+		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
 
 	drm_dp_port_teardown_pdt(port, port->pdt);
 	port->pdt = DP_PEER_DEVICE_NONE;
-- 
2.21.0

