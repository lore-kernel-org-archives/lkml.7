Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F822C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E99218A4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbfGRBo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389216AbfGRBov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A21EA811D8;
        Thu, 18 Jul 2019 01:44:50 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 683F019C78;
        Thu, 18 Jul 2019 01:44:49 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/26] drm/dp_mst: Handle UP requests asynchronously
Date:   Wed, 17 Jul 2019 21:42:41 -0400
Message-Id: <20190718014329.8107-19-lyude@redhat.com>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Jul 2019 01:44:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, hotplugging devices on MST branches actually worked in
DRM. Now, it only works in amdgpu (likely because of how it's hotplug
handlers are implemented). On both i915 and nouveau, hotplug
notifications from MST branches are noticed - but trying to respond to
them causes messaging timeouts and causes the whole topology state to go
out of sync with reality, usually resulting in the user needing to
replug the entire topology in hopes that it actually fixes things.

The reason for this is because the way we currently handle UP requests
in MST is completely bogus. drm_dp_mst_handle_up_req() is called from
drm_dp_mst_hpd_irq(), which is usually called from the driver's hotplug
handler. Because we handle sending the hotplug event from this function,
we actually cause the driver's hotplug handler (and in turn, all
sideband transactions) to block on
drm_device->mode_config.connection_mutex. This makes it impossible to
send any sideband messages from the driver's connector probing
functions, resulting in the aforementioned sideband message timeout.

There's even more problems with this beyond breaking hotplugging on MST
branch devices. It also makes it almost impossible to protect
drm_dp_mst_port struct members under a lock because we then have to
worry about dealing with all of the lock dependency issues that ensue.

So, let's finally actually fix this issue by handling the processing of
up requests asyncronously. This way we can send sideband messages from
most contexts without having to deal with getting blocked if we hold
connection_mutex. This also fixes MST branch device hotplugging on i915,
finally!

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 148 +++++++++++++++++++-------
 include/drm/drm_dp_mst_helper.h       |  16 +++
 2 files changed, 123 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 35ced8514e18..ee28b372afa4 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -45,6 +45,12 @@
  * protocol. The helpers contain a topology manager and bandwidth manager.
  * The helpers encapsulate the sending and received of sideband msgs.
  */
+struct drm_dp_pending_up_req {
+	struct drm_dp_sideband_msg_hdr hdr;
+	struct drm_dp_sideband_msg_req_body msg;
+	struct list_head next;
+};
+
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 				  char *buf);
 
@@ -1178,7 +1184,7 @@ static int drm_dp_mst_wait_tx_reply(struct drm_dp_mst_branch *mstb,
 		}
 	}
 out:
-	if (unlikely(ret == -EIO && drm_debug & (DRM_UT_DP | DRM_UT_KMS))) {
+	if (ret == -EIO && unlikely(drm_debug & (DRM_UT_DP | DRM_UT_KMS))) {
 		struct drm_printer p = drm_debug_printer(DBG_PREFIX);
 
 		drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
@@ -2990,6 +2996,7 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 			   DP_MST_EN | DP_UPSTREAM_IS_SRC);
 	mutex_unlock(&mgr->lock);
+	flush_work(&mgr->up_req_work);
 	flush_work(&mgr->work);
 	flush_work(&mgr->destroy_connector_work);
 }
@@ -3162,12 +3169,70 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 	return 0;
 }
 
+static inline void
+drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
+			  struct drm_dp_pending_up_req *up_req)
+{
+	struct drm_dp_mst_branch *mstb = NULL;
+	struct drm_dp_sideband_msg_req_body *msg = &up_req->msg;
+	struct drm_dp_sideband_msg_hdr *hdr = &up_req->hdr;
+
+	if (hdr->broadcast) {
+		const u8 *guid = NULL;
+
+		if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY)
+			guid = msg->u.conn_stat.guid;
+		else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
+			guid = msg->u.resource_stat.guid;
+
+		mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
+	} else {
+		mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
+	}
+
+	if (!mstb) {
+		DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
+			      hdr->lct);
+		return;
+	}
+
+	/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
+	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
+		drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
+		drm_kms_helper_hotplug_event(mgr->dev);
+	}
+
+	drm_dp_mst_topology_put_mstb(mstb);
+}
+
+static void drm_dp_mst_up_req_work(struct work_struct *work)
+{
+	struct drm_dp_mst_topology_mgr *mgr =
+		container_of(work, struct drm_dp_mst_topology_mgr,
+			     up_req_work);
+	struct drm_dp_pending_up_req *up_req;
+
+	while (true) {
+		mutex_lock(&mgr->up_req_lock);
+		up_req = list_first_entry_or_null(&mgr->up_req_list,
+						  struct drm_dp_pending_up_req,
+						  next);
+		if (up_req)
+			list_del(&up_req->next);
+		mutex_unlock(&mgr->up_req_lock);
+
+		if (!up_req)
+			break;
+
+		drm_dp_mst_process_up_req(mgr, up_req);
+		kfree(up_req);
+	}
+}
+
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
-	struct drm_dp_sideband_msg_req_body msg;
 	struct drm_dp_sideband_msg_hdr *hdr = &mgr->up_req_recv.initial_hdr;
-	struct drm_dp_mst_branch *mstb = NULL;
-	const u8 *guid;
+	struct drm_dp_pending_up_req *up_req;
 	bool seqno;
 
 	if (!drm_dp_get_one_sb_msg(mgr, true))
@@ -3176,56 +3241,53 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	if (!mgr->up_req_recv.have_eomt)
 		return 0;
 
-	if (!hdr->broadcast) {
-		mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
-		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
-				      hdr->lct);
-			goto out;
-		}
+	up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
+	if (!up_req) {
+		DRM_ERROR("Not enough memory to process MST up req\n");
+		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&up_req->next);
 
 	seqno = hdr->seqno;
-	drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
+	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
 
-	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY)
-		guid = msg.u.conn_stat.guid;
-	else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY)
-		guid = msg.u.resource_stat.guid;
-	else
+	if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
+	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
+		DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
+			      up_req->msg.req_type);
+		kfree(up_req);
 		goto out;
-
-	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno,
-				 false);
-
-	if (!mstb) {
-		mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
-		if (!mstb) {
-			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
-				      hdr->lct);
-			goto out;
-		}
 	}
 
-	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
+	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, up_req->msg.req_type,
+				 seqno, false);
+
+	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
+		const struct drm_dp_connection_status_notify *conn_stat =
+			&up_req->msg.u.conn_stat;
 
 		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
-			      msg.u.conn_stat.port_number,
-			      msg.u.conn_stat.legacy_device_plug_status,
-			      msg.u.conn_stat.displayport_device_plug_status,
-			      msg.u.conn_stat.message_capability_status,
-			      msg.u.conn_stat.input_port,
-			      msg.u.conn_stat.peer_device_type);
+			      conn_stat->port_number,
+			      conn_stat->legacy_device_plug_status,
+			      conn_stat->displayport_device_plug_status,
+			      conn_stat->message_capability_status,
+			      conn_stat->input_port,
+			      conn_stat->peer_device_type);
+	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
+		const struct drm_dp_resource_status_notify *res_stat =
+			&up_req->msg.u.resource_stat;
 
-		drm_kms_helper_hotplug_event(mgr->dev);
-	} else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
-			      msg.u.resource_stat.port_number,
-			      msg.u.resource_stat.available_pbn);
+			      res_stat->port_number,
+			      res_stat->available_pbn);
 	}
 
-	drm_dp_mst_topology_put_mstb(mstb);
+	up_req->hdr = *hdr;
+	mutex_lock(&mgr->up_req_lock);
+	list_add_tail(&up_req->next, &mgr->up_req_list);
+	mutex_unlock(&mgr->up_req_lock);
+	queue_work(system_long_wq, &mgr->up_req_work);
+
 out:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
 	return 0;
@@ -4186,12 +4248,15 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_init(&mgr->qlock);
 	mutex_init(&mgr->payload_lock);
 	mutex_init(&mgr->destroy_connector_lock);
+	mutex_init(&mgr->up_req_lock);
 	INIT_LIST_HEAD(&mgr->tx_msg_downq);
 	INIT_LIST_HEAD(&mgr->destroy_connector_list);
 	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
+	INIT_LIST_HEAD(&mgr->up_req_list);
 	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
 	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
 	INIT_WORK(&mgr->destroy_connector_work, drm_dp_destroy_connector_work);
+	INIT_WORK(&mgr->up_req_work, drm_dp_mst_up_req_work);
 	init_waitqueue_head(&mgr->tx_waitq);
 	mgr->dev = dev;
 	mgr->aux = aux;
@@ -4248,6 +4313,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_destroy(&mgr->payload_lock);
 	mutex_destroy(&mgr->qlock);
 	mutex_destroy(&mgr->lock);
+	mutex_destroy(&mgr->up_req_lock);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
 
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 8e04a1bd2e9d..ac1a68574a1a 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -595,6 +595,22 @@ struct drm_dp_mst_topology_mgr {
 	 * avoid locking inversion.
 	 */
 	struct work_struct destroy_connector_work;
+
+	/**
+	 * @up_req_list: List of pending up requests from the topology that
+	 * need to be processed, in chronological order.
+	 */
+	struct list_head up_req_list;
+	/**
+	 * @up_req_lock: Protects @up_req_list
+	 */
+	struct mutex up_req_lock;
+	/**
+	 * @up_req_work: Work item to process up requests received from the
+	 * topology. Needed to avoid blocking hotplug handling and sideband
+	 * transmissions.
+	 */
+	struct work_struct up_req_work;
 };
 
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.21.0

