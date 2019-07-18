Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5906BC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340CC204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbfGRBoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbfGRBoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C65430BDE49;
        Thu, 18 Jul 2019 01:44:02 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA75719C67;
        Thu, 18 Jul 2019 01:44:00 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/26] drm/dp_mst: Destroy mstbs from destroy_connector_work
Date:   Wed, 17 Jul 2019 21:42:25 -0400
Message-Id: <20190718014329.8107-3-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 18 Jul 2019 01:44:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we remove MST branch devices from the in-memory topology
immediately when their topology refcount reaches 0. This works just fine
at the moment, but since we're about to add suspend/resume reprobing for
MST topologies we're going to need to be able to travel through the
topology and drop topology refs on branch devices while holding
mgr->mutex. Since we currently can't do this due to the circular locking
dependencies that would incur, move all of the actual work for
drm_dp_destroy_mst_branch_device() into drm_dp_destroy_connector_work()
so we can drop topology refs on MSTBs in any locking context.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 121 +++++++++++++++++---------
 include/drm/drm_dp_mst_helper.h       |  10 +++
 2 files changed, 90 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 998081b9b205..d7c3d9233834 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1108,34 +1108,17 @@ static void drm_dp_destroy_mst_branch_device(struct kref *kref)
 	struct drm_dp_mst_branch *mstb =
 		container_of(kref, struct drm_dp_mst_branch, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
-	struct drm_dp_mst_port *port, *tmp;
-	bool wake_tx = false;
-
-	mutex_lock(&mgr->lock);
-	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
-		list_del(&port->next);
-		drm_dp_mst_topology_put_port(port);
-	}
-	mutex_unlock(&mgr->lock);
-
-	/* drop any tx slots msg */
-	mutex_lock(&mstb->mgr->qlock);
-	if (mstb->tx_slots[0]) {
-		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
-		mstb->tx_slots[0] = NULL;
-		wake_tx = true;
-	}
-	if (mstb->tx_slots[1]) {
-		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
-		mstb->tx_slots[1] = NULL;
-		wake_tx = true;
-	}
-	mutex_unlock(&mstb->mgr->qlock);
 
-	if (wake_tx)
-		wake_up_all(&mstb->mgr->tx_waitq);
+	INIT_LIST_HEAD(&mstb->destroy_next);
 
-	drm_dp_mst_put_mstb_malloc(mstb);
+	/*
+	 * This can get called under mgr->mutex, so we need to perform the
+	 * actual destruction of the mstb in another worker
+	 */
+	mutex_lock(&mgr->destroy_connector_lock);
+	list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
+	mutex_unlock(&mgr->destroy_connector_lock);
+	schedule_work(&mgr->destroy_connector_work);
 }
 
 /**
@@ -3618,10 +3601,56 @@ static void drm_dp_tx_work(struct work_struct *work)
 	mutex_unlock(&mgr->qlock);
 }
 
+static inline void
+drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
+{
+	INIT_LIST_HEAD(&port->next);
+
+	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+
+	drm_dp_port_teardown_pdt(port, port->pdt);
+	port->pdt = DP_PEER_DEVICE_NONE;
+
+	drm_dp_mst_put_port_malloc(port);
+}
+
+static inline void
+drm_dp_finish_destroy_mst_branch_device(struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
+	struct drm_dp_mst_port *port, *tmp;
+	bool wake_tx = false;
+
+	mutex_lock(&mgr->lock);
+	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
+		list_del(&port->next);
+		drm_dp_mst_topology_put_port(port);
+	}
+	mutex_unlock(&mgr->lock);
+
+	/* drop any tx slots msg */
+	mutex_lock(&mstb->mgr->qlock);
+	if (mstb->tx_slots[0]) {
+		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
+		mstb->tx_slots[0] = NULL;
+		wake_tx = true;
+	}
+	if (mstb->tx_slots[1]) {
+		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
+		mstb->tx_slots[1] = NULL;
+		wake_tx = true;
+	}
+	mutex_unlock(&mstb->mgr->qlock);
+
+	if (wake_tx)
+		wake_up_all(&mstb->mgr->tx_waitq);
+
+	drm_dp_mst_put_mstb_malloc(mstb);
+}
+
 static void drm_dp_destroy_connector_work(struct work_struct *work)
 {
 	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, destroy_connector_work);
-	struct drm_dp_mst_port *port;
 	bool send_hotplug = false;
 	/*
 	 * Not a regular list traverse as we have to drop the destroy
@@ -3629,24 +3658,33 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
 	 * ordering between this lock and the config mutex.
 	 */
 	for (;;) {
+		struct drm_dp_mst_branch *mstb = NULL;
+		struct drm_dp_mst_port *port = NULL;
+
+		/* Destroy any MSTBs first, and then their ports second */
 		mutex_lock(&mgr->destroy_connector_lock);
-		port = list_first_entry_or_null(&mgr->destroy_connector_list, struct drm_dp_mst_port, next);
-		if (!port) {
-			mutex_unlock(&mgr->destroy_connector_lock);
-			break;
+		mstb = list_first_entry_or_null(&mgr->destroy_branch_device_list,
+						struct drm_dp_mst_branch,
+						destroy_next);
+		if (mstb) {
+			list_del(&mstb->destroy_next);
+		} else {
+			port = list_first_entry_or_null(&mgr->destroy_connector_list,
+							struct drm_dp_mst_port,
+							next);
+			if (port)
+				list_del(&port->next);
 		}
-		list_del(&port->next);
 		mutex_unlock(&mgr->destroy_connector_lock);
 
-		INIT_LIST_HEAD(&port->next);
-
-		mgr->cbs->destroy_connector(mgr, port->connector);
-
-		drm_dp_port_teardown_pdt(port, port->pdt);
-		port->pdt = DP_PEER_DEVICE_NONE;
-
-		drm_dp_mst_put_port_malloc(port);
-		send_hotplug = true;
+		if (mstb) {
+			drm_dp_finish_destroy_mst_branch_device(mstb);
+		} else if (port) {
+			drm_dp_finish_destroy_port(port);
+			send_hotplug = true;
+		} else {
+			break;
+		}
 	}
 	if (send_hotplug)
 		drm_kms_helper_hotplug_event(mgr->dev);
@@ -3840,6 +3878,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_init(&mgr->destroy_connector_lock);
 	INIT_LIST_HEAD(&mgr->tx_msg_downq);
 	INIT_LIST_HEAD(&mgr->destroy_connector_list);
+	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
 	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
 	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
 	INIT_WORK(&mgr->destroy_connector_work, drm_dp_destroy_connector_work);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 8c97a5f92c47..c01f3ea72756 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
 	 */
 	struct kref malloc_kref;
 
+	/**
+	 * @destroy_next: linked-list entry used by
+	 * drm_dp_destroy_connector_work()
+	 */
+	struct list_head destroy_next;
+
 	u8 rad[8];
 	u8 lct;
 	int num_ports;
@@ -578,6 +584,10 @@ struct drm_dp_mst_topology_mgr {
 	 * @destroy_connector_list: List of to be destroyed connectors.
 	 */
 	struct list_head destroy_connector_list;
+	/**
+	 * @destroy_branch_device_list: List of to be destroyed branch devices
+	 */
+	struct list_head destroy_branch_device_list;
 	/**
 	 * @destroy_connector_lock: Protects @connector_list.
 	 */
-- 
2.21.0

