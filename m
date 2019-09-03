Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E32168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfICUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfICUrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:47:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2184C058CBD;
        Tue,  3 Sep 2019 20:47:42 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B48781001956;
        Tue,  3 Sep 2019 20:47:41 +0000 (UTC)
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
Subject: [PATCH v2 03/27] drm/dp_mst: Destroy MSTBs asynchronously
Date:   Tue,  3 Sep 2019 16:45:41 -0400
Message-Id: <20190903204645.25487-4-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 20:47:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reprobing an MST topology during resume, we have to account for the
fact that while we were suspended it's possible that mstbs may have been
removed from any ports in the topology. Since iterating downwards in the
topology requires that we hold &mgr->lock, destroying MSTBs from this
context would result in attempting to lock &mgr->lock a second time and
deadlocking.

So, fix this by first moving destruction of MSTBs into
destroy_connector_work, then rename destroy_connector_work and friends
to reflect that they now destroy both ports and mstbs.

Changes since v1:
* s/destroy_connector_list/destroy_port_list/
  s/connector_destroy_lock/delayed_destroy_lock/
  s/connector_destroy_work/delayed_destroy_work/
  s/drm_dp_finish_destroy_branch_device/drm_dp_delayed_destroy_mstb/
  s/drm_dp_finish_destroy_port/drm_dp_delayed_destroy_port/
  - danvet
* Use two loops in drm_dp_delayed_destroy_work() - danvet
* Better explain why we need to do this - danvet
* Use cancel_work_sync() instead of flush_work() - flush_work() doesn't
  account for work requeing

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 162 +++++++++++++++++---------
 include/drm/drm_dp_mst_helper.h       |  26 +++--
 2 files changed, 127 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 3054ec622506..738f260d4b15 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1113,34 +1113,17 @@ static void drm_dp_destroy_mst_branch_device(struct kref *kref)
 	struct drm_dp_mst_branch *mstb =
 		container_of(kref, struct drm_dp_mst_branch, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
-	struct drm_dp_mst_port *port, *tmp;
-	bool wake_tx = false;
 
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
+	INIT_LIST_HEAD(&mstb->destroy_next);
 
-	if (wake_tx)
-		wake_up_all(&mstb->mgr->tx_waitq);
-
-	drm_dp_mst_put_mstb_malloc(mstb);
+	/*
+	 * This can get called under mgr->mutex, so we need to perform the
+	 * actual destruction of the mstb in another worker
+	 */
+	mutex_lock(&mgr->delayed_destroy_lock);
+	list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
+	mutex_unlock(&mgr->delayed_destroy_lock);
+	schedule_work(&mgr->delayed_destroy_work);
 }
 
 /**
@@ -1255,10 +1238,10 @@ static void drm_dp_destroy_port(struct kref *kref)
 			 * we might be holding the mode_config.mutex
 			 * from an EDID retrieval */
 
-			mutex_lock(&mgr->destroy_connector_lock);
-			list_add(&port->next, &mgr->destroy_connector_list);
-			mutex_unlock(&mgr->destroy_connector_lock);
-			schedule_work(&mgr->destroy_connector_work);
+			mutex_lock(&mgr->delayed_destroy_lock);
+			list_add(&port->next, &mgr->destroy_port_list);
+			mutex_unlock(&mgr->delayed_destroy_lock);
+			schedule_work(&mgr->delayed_destroy_work);
 			return;
 		}
 		/* no need to clean up vcpi
@@ -2792,7 +2775,7 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
 			   DP_MST_EN | DP_UPSTREAM_IS_SRC);
 	mutex_unlock(&mgr->lock);
 	flush_work(&mgr->work);
-	flush_work(&mgr->destroy_connector_work);
+	flush_work(&mgr->delayed_destroy_work);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
 
@@ -3740,34 +3723,104 @@ static void drm_dp_tx_work(struct work_struct *work)
 	mutex_unlock(&mgr->qlock);
 }
 
-static void drm_dp_destroy_connector_work(struct work_struct *work)
+static inline void
+drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, destroy_connector_work);
-	struct drm_dp_mst_port *port;
-	bool send_hotplug = false;
+	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+
+	drm_dp_port_teardown_pdt(port, port->pdt);
+	port->pdt = DP_PEER_DEVICE_NONE;
+
+	drm_dp_mst_put_port_malloc(port);
+}
+
+static inline void
+drm_dp_delayed_destroy_mstb(struct drm_dp_mst_branch *mstb)
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
+static void drm_dp_delayed_destroy_work(struct work_struct *work)
+{
+	struct drm_dp_mst_topology_mgr *mgr =
+		container_of(work, struct drm_dp_mst_topology_mgr,
+			     delayed_destroy_work);
+	bool send_hotplug = false, go_again;
+
 	/*
 	 * Not a regular list traverse as we have to drop the destroy
-	 * connector lock before destroying the connector, to avoid AB->BA
+	 * connector lock before destroying the mstb/port, to avoid AB->BA
 	 * ordering between this lock and the config mutex.
 	 */
-	for (;;) {
-		mutex_lock(&mgr->destroy_connector_lock);
-		port = list_first_entry_or_null(&mgr->destroy_connector_list, struct drm_dp_mst_port, next);
-		if (!port) {
-			mutex_unlock(&mgr->destroy_connector_lock);
-			break;
+	do {
+		go_again = false;
+
+		for (;;) {
+			struct drm_dp_mst_branch *mstb;
+
+			mutex_lock(&mgr->delayed_destroy_lock);
+			mstb = list_first_entry_or_null(&mgr->destroy_branch_device_list,
+							struct drm_dp_mst_branch,
+							destroy_next);
+			if (mstb)
+				list_del(&mstb->destroy_next);
+			mutex_unlock(&mgr->delayed_destroy_lock);
+
+			if (!mstb)
+				break;
+
+			drm_dp_delayed_destroy_mstb(mstb);
+			go_again = true;
 		}
-		list_del(&port->next);
-		mutex_unlock(&mgr->destroy_connector_lock);
 
-		mgr->cbs->destroy_connector(mgr, port->connector);
+		for (;;) {
+			struct drm_dp_mst_port *port;
 
-		drm_dp_port_teardown_pdt(port, port->pdt);
-		port->pdt = DP_PEER_DEVICE_NONE;
+			mutex_lock(&mgr->delayed_destroy_lock);
+			port = list_first_entry_or_null(&mgr->destroy_port_list,
+							struct drm_dp_mst_port,
+							next);
+			if (port)
+				list_del(&port->next);
+			mutex_unlock(&mgr->delayed_destroy_lock);
+
+			if (!port)
+				break;
+
+			drm_dp_delayed_destroy_port(port);
+			send_hotplug = true;
+			go_again = true;
+		}
+	} while (go_again);
 
-		drm_dp_mst_put_port_malloc(port);
-		send_hotplug = true;
-	}
 	if (send_hotplug)
 		drm_kms_helper_hotplug_event(mgr->dev);
 }
@@ -3957,12 +4010,13 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_init(&mgr->lock);
 	mutex_init(&mgr->qlock);
 	mutex_init(&mgr->payload_lock);
-	mutex_init(&mgr->destroy_connector_lock);
+	mutex_init(&mgr->delayed_destroy_lock);
 	INIT_LIST_HEAD(&mgr->tx_msg_downq);
-	INIT_LIST_HEAD(&mgr->destroy_connector_list);
+	INIT_LIST_HEAD(&mgr->destroy_port_list);
+	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
 	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
 	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
-	INIT_WORK(&mgr->destroy_connector_work, drm_dp_destroy_connector_work);
+	INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
 	init_waitqueue_head(&mgr->tx_waitq);
 	mgr->dev = dev;
 	mgr->aux = aux;
@@ -4005,7 +4059,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
 {
 	drm_dp_mst_topology_mgr_set_mst(mgr, false);
 	flush_work(&mgr->work);
-	flush_work(&mgr->destroy_connector_work);
+	cancel_work_sync(&mgr->delayed_destroy_work);
 	mutex_lock(&mgr->payload_lock);
 	kfree(mgr->payloads);
 	mgr->payloads = NULL;
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index fc349204a71b..4a4507fe928d 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
 	 */
 	struct kref malloc_kref;
 
+	/**
+	 * @destroy_next: linked-list entry used by
+	 * drm_dp_delayed_destroy_work()
+	 */
+	struct list_head destroy_next;
+
 	u8 rad[8];
 	u8 lct;
 	int num_ports;
@@ -575,18 +581,24 @@ struct drm_dp_mst_topology_mgr {
 	struct work_struct tx_work;
 
 	/**
-	 * @destroy_connector_list: List of to be destroyed connectors.
+	 * @destroy_port_list: List of to be destroyed connectors.
+	 */
+	struct list_head destroy_port_list;
+	/**
+	 * @destroy_branch_device_list: List of to be destroyed branch
+	 * devices.
 	 */
-	struct list_head destroy_connector_list;
+	struct list_head destroy_branch_device_list;
 	/**
-	 * @destroy_connector_lock: Protects @connector_list.
+	 * @delayed_destroy_lock: Protects @destroy_port_list and
+	 * @destroy_branch_device_list.
 	 */
-	struct mutex destroy_connector_lock;
+	struct mutex delayed_destroy_lock;
 	/**
-	 * @destroy_connector_work: Work item to destroy connectors. Needed to
-	 * avoid locking inversion.
+	 * @delayed_destroy_work: Work item to destroy MST port and branch
+	 * devices, needed to avoid locking inversion.
 	 */
-	struct work_struct destroy_connector_work;
+	struct work_struct delayed_destroy_work;
 };
 
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.21.0

