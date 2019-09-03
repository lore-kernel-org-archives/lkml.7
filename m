Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71CE21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfICUsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfICUsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:48:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1582F30860BD;
        Tue,  3 Sep 2019 20:48:31 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA44F1001B08;
        Tue,  3 Sep 2019 20:48:29 +0000 (UTC)
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
Subject: [PATCH v2 15/27] drm/dp_mst: Cleanup drm_dp_send_link_address() a bit
Date:   Tue,  3 Sep 2019 16:45:53 -0400
Message-Id: <20190903204645.25487-16-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 03 Sep 2019 20:48:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare local pointer to the drm_dp_link_address_ack_reply struct
instead of constantly dereferencing it through the union in
txmsg->reply. Then, invert the order of conditionals so we don't have to
do the bulk of the work inside them, and can wrap lines even less. Then
finally, rearrange variable declarations a bit.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 42 +++++++++++++++------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 2f88cc173500..d1610434a0cb 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2398,9 +2398,9 @@ drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
 static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 				     struct drm_dp_mst_branch *mstb)
 {
-	int len;
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int ret;
+	struct drm_dp_link_address_ack_reply *reply;
+	int i, len, ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
@@ -2412,28 +2412,32 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	mstb->link_address_sent = true;
 	drm_dp_queue_down_tx(mgr, txmsg);
 
+	/* FIXME: Actually do some real error handling here */
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret > 0) {
-		int i;
+	if (ret <= 0) {
+		DRM_ERROR("Sending link address failed with %d\n", ret);
+		goto out;
+	}
+	if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
+		DRM_ERROR("link address NAK received\n");
+		ret = -EIO;
+		goto out;
+	}
 
-		if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {
-			DRM_DEBUG_KMS("link address nak received\n");
-		} else {
-			DRM_DEBUG_KMS("link address reply: %d\n", txmsg->reply.u.link_addr.nports);
-			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
+	reply = &txmsg->reply.u.link_addr;
+	DRM_DEBUG_KMS("link address reply: %d\n", reply->nports);
+	drm_dp_dump_link_address(reply);
 
-			drm_dp_check_mstb_guid(mstb, txmsg->reply.u.link_addr.guid);
+	drm_dp_check_mstb_guid(mstb, reply->guid);
 
-			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++) {
-				drm_dp_add_port(mstb, mgr->dev, &txmsg->reply.u.link_addr.ports[i]);
-			}
-			drm_kms_helper_hotplug_event(mgr->dev);
-		}
-	} else {
-		mstb->link_address_sent = false;
-		DRM_DEBUG_KMS("link address failed %d\n", ret);
-	}
+	for (i = 0; i < reply->nports; i++)
+		drm_dp_add_port(mstb, mgr->dev, &reply->ports[i]);
+
+	drm_kms_helper_hotplug_event(mgr->dev);
 
+out:
+	if (ret <= 0)
+		mstb->link_address_sent = false;
 	kfree(txmsg);
 }
 
-- 
2.21.0

