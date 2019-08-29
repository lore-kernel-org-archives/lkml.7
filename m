Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BCF217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfH2AKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38871 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfH2AKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03E3E821C3;
        Thu, 29 Aug 2019 00:10:11 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70B9719D7A;
        Thu, 29 Aug 2019 00:10:03 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/dp_mst: Clear all payload id tables downstream when initializing
Date:   Wed, 28 Aug 2019 20:09:44 -0400
Message-Id: <20190829000944.20722-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 29 Aug 2019 00:10:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

It seems that on certain MST hubs, namely the CableMatters USB-C 2x DP
hub, using the DP_PAYLOAD_ALLOCATE_SET and DP_PAYLOAD_TABLE_UPDATE_STATUS
register ranges to clear any pre-existing payload allocations on the hub isn't
always enough to reset things if the source device has been reset unexpectedly.

Or at least, that's the current running theory. The precise behavior appears to
be that when the source device gets reset unexpectedly, the hub begins reporting
an available_pbn value of 0 for all of its ports. This is a bit inconsistent
with the our theory, since this seems to happen even if previously set PBN
allocations should have resulted in a non-zero available_pbn value. So, it's
possible that something else may be going on here.

Strangely though, sending a CLEAR_PAYLOAD_ID_TABLE broadcast request when
initializing the MST topology seems to bring things into working order and make
available_pbn work again. Since this is a pretty safe solution, let's go ahead
and implement it.

Changes since v1:
* Change indenting on drm_dp_send_clear_payload_id_table() prototype
* Remove some braces in drm_dp_send_clear_payload_id_table()
* Reorganize some variable declarations in drm_dp_send_clear_payload_id_table()
* Don't forget to handle DP_CLEAR_PAYLOAD_ID_TABLE in
  drm_dp_sideband_parse_reply()
* Move drm_dp_send_clear_payload_id_table() call into
  drm_dp_mst_link_probe_work(), since we can't send sideband messages
  while under lock in drm_dp_mst_topology_mgr_set_mst()
* Change commit message

Change-Id: I2c763e8dae3844eca76033a41f264080052fbbfc
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---

A heads up to anyone looking at this patch: it's quite possible this
won't be the final solution that we go with. Me and Sean would like to
do a bit more investigation to try to figure out what exactly is
happening here before we go ahead and push it, and hopefully figure out
why available_pbn is being set to 0 instead of some other leftover
non-zero allocation.

 drivers/gpu/drm/drm_dp_mst_topology.c | 63 +++++++++++++++++++++++++--
 include/drm/drm_dp_mst_helper.h       | 16 +++++--
 2 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 82add736e17d..969e43b7eb4c 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -64,6 +64,11 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
 
 static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 				     struct drm_dp_mst_branch *mstb);
+
+static void
+drm_dp_send_clear_payload_id_table(struct drm_dp_mst_topology_mgr *mgr,
+				   struct drm_dp_mst_branch *mstb);
+
 static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
 					   struct drm_dp_mst_branch *mstb,
 					   struct drm_dp_mst_port *port);
@@ -657,6 +662,8 @@ static bool drm_dp_sideband_parse_reply(struct drm_dp_sideband_msg_rx *raw,
 	case DP_POWER_DOWN_PHY:
 	case DP_POWER_UP_PHY:
 		return drm_dp_sideband_parse_power_updown_phy_ack(raw, msg);
+	case DP_CLEAR_PAYLOAD_ID_TABLE:
+		return true; /* since there's nothing to parse */
 	default:
 		DRM_ERROR("Got unknown reply 0x%02x (%s)\n", msg->req_type,
 			  drm_dp_mst_req_type_str(msg->req_type));
@@ -755,6 +762,15 @@ static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
 	return 0;
 }
 
+static int build_clear_payload_id_table(struct drm_dp_sideband_msg_tx *msg)
+{
+	struct drm_dp_sideband_msg_req_body req;
+
+	req.req_type = DP_CLEAR_PAYLOAD_ID_TABLE;
+	drm_dp_encode_sideband_req(&req, msg);
+	return 0;
+}
+
 static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int port_num)
 {
 	struct drm_dp_sideband_msg_req_body req;
@@ -1877,8 +1893,12 @@ static void drm_dp_mst_link_probe_work(struct work_struct *work)
 	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, work);
 	struct drm_dp_mst_branch *mstb;
 	int ret;
+	bool clear_payload_id_table;
 
 	mutex_lock(&mgr->lock);
+	clear_payload_id_table = !mgr->payload_id_table_cleared;
+	mgr->payload_id_table_cleared = true;
+
 	mstb = mgr->mst_primary;
 	if (mstb) {
 		ret = drm_dp_mst_topology_try_get_mstb(mstb);
@@ -1886,10 +1906,24 @@ static void drm_dp_mst_link_probe_work(struct work_struct *work)
 			mstb = NULL;
 	}
 	mutex_unlock(&mgr->lock);
-	if (mstb) {
-		drm_dp_check_and_send_link_address(mgr, mstb);
-		drm_dp_mst_topology_put_mstb(mstb);
+	if (!mstb)
+		return;
+
+	/*
+	 * Certain branch devices seem to incorrectly report an available_pbn
+	 * of 0 on downstream sinks, even after clearing the
+	 * DP_PAYLOAD_ALLOCATE_* registers in
+	 * drm_dp_mst_topology_mgr_set_mst(). Namely, the CableMatters USB-C
+	 * 2x DP hub. Sending a CLEAR_PAYLOAD_ID_TABLE message seems to make
+	 * things work again.
+	 */
+	if (clear_payload_id_table) {
+		DRM_DEBUG_KMS("Clearing payload ID table\n");
+		drm_dp_send_clear_payload_id_table(mgr, mstb);
 	}
+
+	drm_dp_check_and_send_link_address(mgr, mstb);
+	drm_dp_mst_topology_put_mstb(mstb);
 }
 
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
@@ -2156,6 +2190,28 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	kfree(txmsg);
 }
 
+void drm_dp_send_clear_payload_id_table(struct drm_dp_mst_topology_mgr *mgr,
+					struct drm_dp_mst_branch *mstb)
+{
+	struct drm_dp_sideband_msg_tx *txmsg;
+	int len, ret;
+
+	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
+	if (!txmsg)
+		return;
+
+	txmsg->dst = mstb;
+	len = build_clear_payload_id_table(txmsg);
+
+	drm_dp_queue_down_tx(mgr, txmsg);
+
+	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
+	if (ret > 0 && txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
+		DRM_DEBUG_KMS("clear payload table id nak received\n");
+
+	kfree(txmsg);
+}
+
 static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
 					   struct drm_dp_mst_branch *mstb,
 					   struct drm_dp_mst_port *port)
@@ -2756,6 +2812,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		mgr->payload_mask = 0;
 		set_bit(0, &mgr->payload_mask);
 		mgr->vcpi_mask = 0;
+		mgr->payload_id_table_cleared = false;
 	}
 
 out_unlock:
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 2ba6253ea6d3..ee4093c1bba3 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -494,15 +494,23 @@ struct drm_dp_mst_topology_mgr {
 	struct drm_dp_sideband_msg_rx up_req_recv;
 
 	/**
-	 * @lock: protects mst state, primary, dpcd.
+	 * @lock: protects @mst_state, @mst_primary, @dpcd, and
+	 * @payload_id_table_cleared.
 	 */
 	struct mutex lock;
 
 	/**
-	 * @mst_state: If this manager is enabled for an MST capable port. False
-	 * if no MST sink/branch devices is connected.
+	 * @mst_state: If this manager is enabled for an MST capable port.
+	 * False if no MST sink/branch devices is connected.
 	 */
-	bool mst_state;
+	bool mst_state : 1;
+
+	/**
+	 * @payload_id_table_cleared: Whether or not we've cleared the payload
+	 * ID table for @mst_primary. Protected by @lock.
+	 */
+	bool payload_id_table_cleared : 1;
+
 	/**
 	 * @mst_primary: Pointer to the primary/first branch device.
 	 */
-- 
2.21.0

