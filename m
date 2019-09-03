Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32637C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA90221897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfICUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfICUtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CE37189DADE;
        Tue,  3 Sep 2019 20:49:15 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9694100195C;
        Tue,  3 Sep 2019 20:49:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 25/27] drm/dp_mst: Add basic topology reprobing when resuming
Date:   Tue,  3 Sep 2019 16:46:03 -0400
Message-Id: <20190903204645.25487-26-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 20:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally! For a very long time, our MST helpers have had one very
annoying issue: They don't know how to reprobe the topology state when
coming out of suspend. This means that if a user has a machine connected
to an MST topology and decides to suspend their machine, we lose all
topology changes that happened during that period. That can be a big
problem if the machine was connected to a different topology on the same
port before resuming, as we won't bother reprobing any of the ports and
likely cause the user's monitors not to come back up as expected.

So, we start fixing this by teaching our MST helpers how to reprobe the
link addresses of each connected topology when resuming. As it turns
out, the behavior that we want here is identical to the behavior we want
when initially probing a newly connected MST topology, with a couple of
important differences:

- We need to be more careful about handling the potential races between
  events from the MST hub that could change the topology state as we're
  performing the link address reprobe
- We need to be more careful about handling unlikely state changes on
  ports - such as an input port turning into an output port, something
  that would be far more likely to happen in situations like the MST hub
  we're connected to being changed while we're suspend

Both of which have been solved by previous commits. That leaves one
requirement:

- We need to prune any MST ports in our in-memory topology state that
  were present when suspending, but have not appeared in the post-resume
  link address response from their parent branch device

Which we can now handle in this commit by modifying
drm_dp_send_link_address(). We then introduce suspend/resume reprobing
by introducing drm_dp_mst_topology_mgr_invalidate_mstb(), which we call
in drm_dp_mst_topology_mgr_suspend() to traverse the in-memory topology
state to indicate that each mstb needs it's link address resent and PBN
resources reprobed.

On resume, we start back up &mgr->work and have it reprobe the topology
in the same way we would on a hotplug, removing any leftover ports that
no longer appear in the topology state.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c         | 138 +++++++++++++-----
 drivers/gpu/drm/i915/display/intel_dp.c       |   3 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   6 +-
 include/drm/drm_dp_mst_helper.h               |   3 +-
 5 files changed, 112 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d3c8bff77da..27ee3e045b86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -973,7 +973,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 		if (suspend) {
 			drm_dp_mst_topology_mgr_suspend(mgr);
 		} else {
-			ret = drm_dp_mst_topology_mgr_resume(mgr);
+			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
 			if (ret < 0) {
 				drm_dp_mst_topology_mgr_set_mst(mgr, false);
 				need_hotplug = true;
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index e407aba1fbd2..2fe24e366925 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2020,6 +2020,14 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 		goto fail_unlock;
 	}
 
+	/*
+	 * If this port wasn't just created, then we're reprobing because
+	 * we're coming out of suspend. In this case, always resend the link
+	 * address if there's an MSTB on this port
+	 */
+	if (!created && port->pdt == DP_PEER_DEVICE_MST_BRANCHING)
+		send_link_addr = true;
+
 	if (send_link_addr) {
 		mutex_lock(&mgr->lock);
 		if (port->mstb) {
@@ -2530,7 +2538,8 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
 	struct drm_dp_link_address_ack_reply *reply;
-	int i, len, ret;
+	struct drm_dp_mst_port *port, *tmp;
+	int i, len, ret, port_mask = 0;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
@@ -2560,9 +2569,28 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 
 	drm_dp_check_mstb_guid(mstb, reply->guid);
 
-	for (i = 0; i < reply->nports; i++)
+	for (i = 0; i < reply->nports; i++) {
+		port_mask |= BIT(reply->ports[i].port_number);
 		drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
 						    &reply->ports[i]);
+	}
+
+	/* Prune any ports that are currently a part of mstb in our in-memory
+	 * topology, but were not seen in this link address. Usually this
+	 * means that they were removed while the topology was out of sync,
+	 * e.g. during suspend/resume
+	 */
+	mutex_lock(&mgr->lock);
+	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
+		if (port_mask & BIT(port->port_num))
+			continue;
+
+		DRM_DEBUG_KMS("port %d was not in link address, removing\n",
+			      port->port_num);
+		list_del(&port->next);
+		drm_dp_mst_topology_put_port(port);
+	}
+	mutex_unlock(&mgr->lock);
 
 	drm_kms_helper_hotplug_event(mgr->dev);
 
@@ -3191,6 +3219,23 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_set_mst);
 
+static void
+drm_dp_mst_topology_mgr_invalidate_mstb(struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_mst_port *port;
+
+	/* The link address will need to be re-sent on resume */
+	mstb->link_address_sent = false;
+
+	list_for_each_entry(port, &mstb->ports, next) {
+		/* The PBN for each port will also need to be re-probed */
+		port->available_pbn = 0;
+
+		if (port->mstb)
+			drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
+	}
+}
+
 /**
  * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
  * @mgr: manager to suspend
@@ -3207,60 +3252,85 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
 	flush_work(&mgr->up_req_work);
 	flush_work(&mgr->work);
 	flush_work(&mgr->delayed_destroy_work);
+
+	mutex_lock(&mgr->lock);
+	if (mgr->mst_state && mgr->mst_primary)
+		drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
+	mutex_unlock(&mgr->lock);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
 
 /**
  * drm_dp_mst_topology_mgr_resume() - resume the MST manager
  * @mgr: manager to resume
+ * @sync: whether or not to perform topology reprobing synchronously
  *
  * This will fetch DPCD and see if the device is still there,
  * if it is, it will rewrite the MSTM control bits, and return.
  *
- * if the device fails this returns -1, and the driver should do
+ * If the device fails this returns -1, and the driver should do
  * a full MST reprobe, in case we were undocked.
+ *
+ * During system resume (where it is assumed that the driver will be calling
+ * drm_atomic_helper_resume()) this function should be called beforehand with
+ * @sync set to true. In contexts like runtime resume where the driver is not
+ * expected to be calling drm_atomic_helper_resume(), this function should be
+ * called with @sync set to false in order to avoid deadlocking.
+ *
+ * Returns: -1 if the MST topology was removed while we were suspended, 0
+ * otherwise.
  */
-int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
+int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
+				   bool sync)
 {
-	int ret = 0;
+	int ret;
+	u8 guid[16];
 
 	mutex_lock(&mgr->lock);
+	if (!mgr->mst_primary)
+		goto out_fail;
 
-	if (mgr->mst_primary) {
-		int sret;
-		u8 guid[16];
+	ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
+			       DP_RECEIVER_CAP_SIZE);
+	if (ret != DP_RECEIVER_CAP_SIZE) {
+		DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
 
-		sret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
-		if (sret != DP_RECEIVER_CAP_SIZE) {
-			DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-			ret = -1;
-			goto out_unlock;
-		}
+	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
+				 DP_MST_EN |
+				 DP_UP_REQ_EN |
+				 DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
+		goto out_fail;
+	}
 
-		ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-					 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
-		if (ret < 0) {
-			DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
-			ret = -1;
-			goto out_unlock;
-		}
+	/* Some hubs forget their guids after they resume */
+	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
+	if (ret != 16) {
+		DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+		goto out_fail;
+	}
+	drm_dp_check_mstb_guid(mgr->mst_primary, guid);
 
-		/* Some hubs forget their guids after they resume */
-		sret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
-		if (sret != 16) {
-			DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-			ret = -1;
-			goto out_unlock;
-		}
-		drm_dp_check_mstb_guid(mgr->mst_primary, guid);
+	/* For the final step of resuming the topology, we need to bring the
+	 * state of our in-memory topology back into sync with reality. So,
+	 * restart the probing process as if we're probing a new hub
+	 */
+	queue_work(system_long_wq, &mgr->work);
+	mutex_unlock(&mgr->lock);
 
-		ret = 0;
-	} else
-		ret = -1;
+	if (sync) {
+		DRM_DEBUG_KMS("Waiting for link probe work to finish re-syncing topology...\n");
+		flush_work(&mgr->work);
+	}
 
-out_unlock:
+	return 0;
+
+out_fail:
 	mutex_unlock(&mgr->lock);
-	return ret;
+	return -1;
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_resume);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 5673ed75e428..b78364dcdef9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7400,7 +7400,8 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
 		if (!intel_dp->can_mst)
 			continue;
 
-		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
+		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr,
+						     true);
 		if (ret) {
 			intel_dp->is_mst = false;
 			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 307584107d77..e459e2a79d78 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1309,14 +1309,14 @@ nv50_mstm_fini(struct nv50_mstm *mstm)
 }
 
 static void
-nv50_mstm_init(struct nv50_mstm *mstm)
+nv50_mstm_init(struct nv50_mstm *mstm, bool runtime)
 {
 	int ret;
 
 	if (!mstm || !mstm->mgr.mst_state)
 		return;
 
-	ret = drm_dp_mst_topology_mgr_resume(&mstm->mgr);
+	ret = drm_dp_mst_topology_mgr_resume(&mstm->mgr, !runtime);
 	if (ret == -1) {
 		drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, false);
 		drm_kms_helper_hotplug_event(mstm->mgr.dev);
@@ -2262,7 +2262,7 @@ nv50_display_init(struct drm_device *dev, bool resume, bool runtime)
 		if (encoder->encoder_type != DRM_MODE_ENCODER_DPMST) {
 			struct nouveau_encoder *nv_encoder =
 				nouveau_encoder(encoder);
-			nv50_mstm_init(nv_encoder->dp.mstm);
+			nv50_mstm_init(nv_encoder->dp.mstm, runtime);
 		}
 	}
 
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 1efbb086f7ac..1bdee5ee6dcd 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -685,7 +685,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
-drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
+drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
+			       bool sync);
 
 ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux *aux,
 			     unsigned int offset, void *buffer, size_t size);
-- 
2.21.0

