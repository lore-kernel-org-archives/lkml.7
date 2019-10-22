Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE53FCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A57C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3pOLUTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfJVCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:39:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730962AbfJVCjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571711978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SoC8BThus+lmRGVf3qI752PYilZyM0Pa30gkQ7jCOKI=;
        b=X3pOLUTKV4RhXJgaPT1u2Q4XcdfTeLRO7uhDzCKGxsSiCmPYbTw67KIw+MCQMM9yT3tNuE
        wqXHyEFJrG0fkYYsYsWJVWHSTi2CGTsIi1o6mfFMDqM0oiRwV4uhsMDpv5Rcvi0IslQPZj
        1yd1CcMKl1l63/xBK6AX6muMuscmwl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-DuY4PqQ5NwqPr5PTpQygBA-1; Mon, 21 Oct 2019 22:39:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1D480183E;
        Tue, 22 Oct 2019 02:39:33 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCC4B60126;
        Tue, 22 Oct 2019 02:39:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/14] drm/dp_mst: Add probe_lock
Date:   Mon, 21 Oct 2019 22:36:00 -0400
Message-Id: <20191022023641.8026-6-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DuY4PqQ5NwqPr5PTpQygBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, MST lacks locking in a lot of places that really should have
some sort of locking. Hotplugging and link address code paths are some
of the offenders here, as there is actually nothing preventing us from
running a link address probe while at the same time handling a
connection status update request - something that's likely always been
possible but never seen in the wild because hotplugging has been broken
for ages now (with the exception of amdgpu, for reasons I don't think
are worth digging into very far).

Note: I'm going to start using the term "in-memory topology layout" here
to refer to drm_dp_mst_port->mstb and drm_dp_mst_branch->ports.

Locking in these places is a little tougher then it looks though.
Generally we protect anything having to do with the in-memory topology
layout under &mgr->lock. But this becomes nearly impossible to do from
the context of link address probes due to the fact that &mgr->lock is
usually grabbed under random various modesetting locks, meaning that
there's no way we can just invert the &mgr->lock order and keep it
locked throughout the whole process of updating the topology.

Luckily there are only two workers which can modify the in-memory
topology layout: drm_dp_mst_up_req_work() and
drm_dp_mst_link_probe_work(), meaning as long as we prevent these two
workers from traveling the topology layout in parallel with the intent
of updating it we don't need to worry about grabbing &mgr->lock in these
workers for reads. We only need to grab &mgr->lock in these workers for
writes, so that readers outside these two workers are still protected
from the topology layout changing beneath them.

So, add the new &mgr->probe_lock and use it in both
drm_dp_mst_link_probe_work() and drm_dp_mst_up_req_work(). Additionally,
add some more detailed explanations for how this locking is intended to
work to drm_dp_mst_port->mstb and drm_dp_mst_branch->ports.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 28 ++++++++++++++---------
 include/drm/drm_dp_mst_helper.h       | 32 +++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 08c316a727df..11d842f0bff5 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2147,37 +2147,40 @@ static void drm_dp_check_and_send_link_address(stru=
ct drm_dp_mst_topology_mgr *m
 =09=09=09=09=09       struct drm_dp_mst_branch *mstb)
 {
 =09struct drm_dp_mst_port *port;
-=09struct drm_dp_mst_branch *mstb_child;
+
 =09if (!mstb->link_address_sent)
 =09=09drm_dp_send_link_address(mgr, mstb);
=20
 =09list_for_each_entry(port, &mstb->ports, next) {
-=09=09if (port->input)
-=09=09=09continue;
+=09=09struct drm_dp_mst_branch *mstb_child =3D NULL;
=20
-=09=09if (!port->ddps)
+=09=09if (port->input || !port->ddps)
 =09=09=09continue;
=20
 =09=09if (!port->available_pbn)
 =09=09=09drm_dp_send_enum_path_resources(mgr, mstb, port);
=20
-=09=09if (port->mstb) {
+=09=09if (port->mstb)
 =09=09=09mstb_child =3D drm_dp_mst_topology_get_mstb_validated(
 =09=09=09    mgr, port->mstb);
-=09=09=09if (mstb_child) {
-=09=09=09=09drm_dp_check_and_send_link_address(mgr, mstb_child);
-=09=09=09=09drm_dp_mst_topology_put_mstb(mstb_child);
-=09=09=09}
+
+=09=09if (mstb_child) {
+=09=09=09drm_dp_check_and_send_link_address(mgr, mstb_child);
+=09=09=09drm_dp_mst_topology_put_mstb(mstb_child);
 =09=09}
 =09}
 }
=20
 static void drm_dp_mst_link_probe_work(struct work_struct *work)
 {
-=09struct drm_dp_mst_topology_mgr *mgr =3D container_of(work, struct drm_d=
p_mst_topology_mgr, work);
+=09struct drm_dp_mst_topology_mgr *mgr =3D
+=09=09container_of(work, struct drm_dp_mst_topology_mgr, work);
+=09struct drm_device *dev =3D mgr->dev;
 =09struct drm_dp_mst_branch *mstb;
 =09int ret;
=20
+=09mutex_lock(&mgr->probe_lock);
+
 =09mutex_lock(&mgr->lock);
 =09mstb =3D mgr->mst_primary;
 =09if (mstb) {
@@ -2190,6 +2193,7 @@ static void drm_dp_mst_link_probe_work(struct work_st=
ruct *work)
 =09=09drm_dp_check_and_send_link_address(mgr, mstb);
 =09=09drm_dp_mst_topology_put_mstb(mstb);
 =09}
+=09mutex_unlock(&mgr->probe_lock);
 }
=20
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
@@ -3313,6 +3317,7 @@ static void drm_dp_mst_up_req_work(struct work_struct=
 *work)
 =09=09=09     up_req_work);
 =09struct drm_dp_pending_up_req *up_req;
=20
+=09mutex_lock(&mgr->probe_lock);
 =09while (true) {
 =09=09mutex_lock(&mgr->up_req_lock);
 =09=09up_req =3D list_first_entry_or_null(&mgr->up_req_list,
@@ -3328,6 +3333,7 @@ static void drm_dp_mst_up_req_work(struct work_struct=
 *work)
 =09=09drm_dp_mst_process_up_req(mgr, up_req);
 =09=09kfree(up_req);
 =09}
+=09mutex_unlock(&mgr->probe_lock);
 }
=20
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
@@ -4349,6 +4355,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_to=
pology_mgr *mgr,
 =09mutex_init(&mgr->payload_lock);
 =09mutex_init(&mgr->delayed_destroy_lock);
 =09mutex_init(&mgr->up_req_lock);
+=09mutex_init(&mgr->probe_lock);
 =09INIT_LIST_HEAD(&mgr->tx_msg_downq);
 =09INIT_LIST_HEAD(&mgr->destroy_port_list);
 =09INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
@@ -4414,6 +4421,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09mutex_destroy(&mgr->qlock);
 =09mutex_destroy(&mgr->lock);
 =09mutex_destroy(&mgr->up_req_lock);
+=09mutex_destroy(&mgr->probe_lock);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
=20
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index 7d80c38ee00e..bccb5514e0ef 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -55,8 +55,6 @@ struct drm_dp_vcpi {
  * @num_sdp_stream_sinks: Number of stream sinks
  * @available_pbn: Available bandwidth for this port.
  * @next: link to next port on this branch device
- * @mstb: branch device on this port, protected by
- * &drm_dp_mst_topology_mgr.lock
  * @aux: i2c aux transport to talk to device connected to this port, prote=
cted
  * by &drm_dp_mst_topology_mgr.lock
  * @parent: branch device parent of this port
@@ -92,7 +90,17 @@ struct drm_dp_mst_port {
 =09u8 num_sdp_stream_sinks;
 =09uint16_t available_pbn;
 =09struct list_head next;
-=09struct drm_dp_mst_branch *mstb; /* pointer to an mstb if this port has =
one */
+=09/**
+=09 * @mstb: the branch device connected to this port, if there is one.
+=09 * This should be considered protected for reading by
+=09 * &drm_dp_mst_topology_mgr.lock. There are two exceptions to this:
+=09 * &drm_dp_mst_topology_mgr.up_req_work and
+=09 * &drm_dp_mst_topology_mgr.work, which do not grab
+=09 * &drm_dp_mst_topology_mgr.lock during reads but are the only
+=09 * updaters of this list and are protected from writing concurrently
+=09 * by &drm_dp_mst_topology_mgr.probe_lock.
+=09 */
+=09struct drm_dp_mst_branch *mstb;
 =09struct drm_dp_aux aux; /* i2c bus for this port? */
 =09struct drm_dp_mst_branch *parent;
=20
@@ -118,7 +126,6 @@ struct drm_dp_mst_port {
  * @lct: Link count total to talk to this branch device.
  * @num_ports: number of ports on the branch.
  * @msg_slots: one bit per transmitted msg slot.
- * @ports: linked list of ports on this branch.
  * @port_parent: pointer to the port parent, NULL if toplevel.
  * @mgr: topology manager for this branch device.
  * @tx_slots: transmission slots for this device.
@@ -156,6 +163,16 @@ struct drm_dp_mst_branch {
 =09int num_ports;
=20
 =09int msg_slots;
+=09/**
+=09 * @ports: the list of ports on this branch device. This should be
+=09 * considered protected for reading by &drm_dp_mst_topology_mgr.lock.
+=09 * There are two exceptions to this:
+=09 * &drm_dp_mst_topology_mgr.up_req_work and
+=09 * &drm_dp_mst_topology_mgr.work, which do not grab
+=09 * &drm_dp_mst_topology_mgr.lock during reads but are the only
+=09 * updaters of this list and are protected from updating the list
+=09 * concurrently by @drm_dp_mst_topology_mgr.probe_lock
+=09 */
 =09struct list_head ports;
=20
 =09/* list of tx ops queue for this port */
@@ -502,6 +519,13 @@ struct drm_dp_mst_topology_mgr {
 =09 */
 =09struct mutex lock;
=20
+=09/**
+=09 * @probe_lock: Prevents @work and @up_req_work, the only writers of
+=09 * &drm_dp_mst_port.mstb and &drm_dp_mst_branch.ports, from racing
+=09 * while they update the topology.
+=09 */
+=09struct mutex probe_lock;
+
 =09/**
 =09 * @mst_state: If this manager is enabled for an MST capable port. Fals=
e
 =09 * if no MST sink/branch devices is connected.
--=20
2.21.0

