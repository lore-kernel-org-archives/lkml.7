Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71793C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528E921897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfICUsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfICUsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A39A63018FC5;
        Tue,  3 Sep 2019 20:48:12 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EAF51001956;
        Tue,  3 Sep 2019 20:48:08 +0000 (UTC)
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
Subject: [PATCH v2 08/27] drm/dp_mst: Remove PDT teardown in drm_dp_destroy_port() and refactor
Date:   Tue,  3 Sep 2019 16:45:46 -0400
Message-Id: <20190903204645.25487-9-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 20:48:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to add some locking for port->* members, in
particular the PDT and ->connector, which can't be done from
drm_dp_destroy_port() since we don't know what locks the caller might be
holding.

Changes since v2:
* Clarify commit message

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 40 +++++++++++----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index f5f1d8b50fb6..af3189df28aa 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1511,31 +1511,22 @@ static void drm_dp_destroy_port(struct kref *kref)
 		container_of(kref, struct drm_dp_mst_port, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
 
-	if (!port->input) {
-		kfree(port->cached_edid);
+	/* There's nothing that needs locking to destroy an input port yet */
+	if (port->input) {
+		drm_dp_mst_put_port_malloc(port);
+		return;
+	}
 
-		/*
-		 * The only time we don't have a connector
-		 * on an output port is if the connector init
-		 * fails.
-		 */
-		if (port->connector) {
-			/* we can't destroy the connector here, as
-			 * we might be holding the mode_config.mutex
-			 * from an EDID retrieval */
+	kfree(port->cached_edid);
 
-			mutex_lock(&mgr->delayed_destroy_lock);
-			list_add(&port->next, &mgr->destroy_port_list);
-			mutex_unlock(&mgr->delayed_destroy_lock);
-			schedule_work(&mgr->delayed_destroy_work);
-			return;
-		}
-		/* no need to clean up vcpi
-		 * as if we have no connector we never setup a vcpi */
-		drm_dp_port_teardown_pdt(port, port->pdt);
-		port->pdt = DP_PEER_DEVICE_NONE;
-	}
-	drm_dp_mst_put_port_malloc(port);
+	/*
+	 * we can't destroy the connector here, as we might be holding the
+	 * mode_config.mutex from an EDID retrieval
+	 */
+	mutex_lock(&mgr->delayed_destroy_lock);
+	list_add(&port->next, &mgr->destroy_port_list);
+	mutex_unlock(&mgr->delayed_destroy_lock);
+	schedule_work(&mgr->delayed_destroy_work);
 }
 
 /**
@@ -3998,7 +3989,8 @@ static void drm_dp_tx_work(struct work_struct *work)
 static inline void
 drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+	if (port->connector)
+		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
 
 	drm_dp_port_teardown_pdt(port, port->pdt);
 	port->pdt = DP_PEER_DEVICE_NONE;
-- 
2.21.0

