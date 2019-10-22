Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238DBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D694321783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPa2bTbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfJVCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:39:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729573AbfJVCjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571711974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVmsEL0RgTImPJjh23raq9UBGUzn/diPt9aV1LHsdrQ=;
        b=BPa2bTbnmbnyqCiGDptjaYw3Y3OWqHK+AC9ez3m5giuHznw4TSNtJNGLiFqMO2q9aN5mH5
        5wMu7wCYC5VyOFuWbHjbT9xa+n6Rj4yiLYtVJYWvSMDyeMv1Uufuqbflqs+mfoEUJwiqVh
        kGq2IH17EIOhPNlqx2414S1g3zsHwx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-BIs0Ti7bPwGpe3gSVauWKw-1; Mon, 21 Oct 2019 22:39:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E59B800D41;
        Tue, 22 Oct 2019 02:39:29 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5942C60126;
        Tue, 22 Oct 2019 02:39:26 +0000 (UTC)
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
Subject: [PATCH v5 04/14] drm/dp_mst: Handle UP requests asynchronously
Date:   Mon, 21 Oct 2019 22:35:59 -0400
Message-Id: <20191022023641.8026-5-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BIs0Ti7bPwGpe3gSVauWKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 146 +++++++++++++++++++-------
 include/drm/drm_dp_mst_helper.h       |  16 +++
 2 files changed, 122 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 3f16c0cb094b..08c316a727df 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -45,6 +45,12 @@
  * protocol. The helpers contain a topology manager and bandwidth manager.
  * The helpers encapsulate the sending and received of sideband msgs.
  */
+struct drm_dp_pending_up_req {
+=09struct drm_dp_sideband_msg_hdr hdr;
+=09struct drm_dp_sideband_msg_req_body msg;
+=09struct list_head next;
+};
+
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 =09=09=09=09  char *buf);
=20
@@ -3091,6 +3097,7 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 =09=09=09   DP_MST_EN | DP_UPSTREAM_IS_SRC);
 =09mutex_unlock(&mgr->lock);
+=09flush_work(&mgr->up_req_work);
 =09flush_work(&mgr->work);
 =09flush_work(&mgr->delayed_destroy_work);
 }
@@ -3263,12 +3270,70 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp=
_mst_topology_mgr *mgr)
 =09return 0;
 }
=20
+static inline void
+drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
+=09=09=09  struct drm_dp_pending_up_req *up_req)
+{
+=09struct drm_dp_mst_branch *mstb =3D NULL;
+=09struct drm_dp_sideband_msg_req_body *msg =3D &up_req->msg;
+=09struct drm_dp_sideband_msg_hdr *hdr =3D &up_req->hdr;
+
+=09if (hdr->broadcast) {
+=09=09const u8 *guid =3D NULL;
+
+=09=09if (msg->req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY)
+=09=09=09guid =3D msg->u.conn_stat.guid;
+=09=09else if (msg->req_type =3D=3D DP_RESOURCE_STATUS_NOTIFY)
+=09=09=09guid =3D msg->u.resource_stat.guid;
+
+=09=09mstb =3D drm_dp_get_mst_branch_device_by_guid(mgr, guid);
+=09} else {
+=09=09mstb =3D drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
+=09}
+
+=09if (!mstb) {
+=09=09DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
+=09=09=09      hdr->lct);
+=09=09return;
+=09}
+
+=09/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
+=09if (msg->req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
+=09=09drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
+=09=09drm_kms_helper_hotplug_event(mgr->dev);
+=09}
+
+=09drm_dp_mst_topology_put_mstb(mstb);
+}
+
+static void drm_dp_mst_up_req_work(struct work_struct *work)
+{
+=09struct drm_dp_mst_topology_mgr *mgr =3D
+=09=09container_of(work, struct drm_dp_mst_topology_mgr,
+=09=09=09     up_req_work);
+=09struct drm_dp_pending_up_req *up_req;
+
+=09while (true) {
+=09=09mutex_lock(&mgr->up_req_lock);
+=09=09up_req =3D list_first_entry_or_null(&mgr->up_req_list,
+=09=09=09=09=09=09  struct drm_dp_pending_up_req,
+=09=09=09=09=09=09  next);
+=09=09if (up_req)
+=09=09=09list_del(&up_req->next);
+=09=09mutex_unlock(&mgr->up_req_lock);
+
+=09=09if (!up_req)
+=09=09=09break;
+
+=09=09drm_dp_mst_process_up_req(mgr, up_req);
+=09=09kfree(up_req);
+=09}
+}
+
 static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 {
-=09struct drm_dp_sideband_msg_req_body msg;
 =09struct drm_dp_sideband_msg_hdr *hdr =3D &mgr->up_req_recv.initial_hdr;
-=09struct drm_dp_mst_branch *mstb =3D NULL;
-=09const u8 *guid;
+=09struct drm_dp_pending_up_req *up_req;
 =09bool seqno;
=20
 =09if (!drm_dp_get_one_sb_msg(mgr, true))
@@ -3277,56 +3342,53 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_m=
st_topology_mgr *mgr)
 =09if (!mgr->up_req_recv.have_eomt)
 =09=09return 0;
=20
-=09if (!hdr->broadcast) {
-=09=09mstb =3D drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
-=09=09if (!mstb) {
-=09=09=09DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
-=09=09=09=09      hdr->lct);
-=09=09=09goto out;
-=09=09}
+=09up_req =3D kzalloc(sizeof(*up_req), GFP_KERNEL);
+=09if (!up_req) {
+=09=09DRM_ERROR("Not enough memory to process MST up req\n");
+=09=09return -ENOMEM;
 =09}
+=09INIT_LIST_HEAD(&up_req->next);
=20
 =09seqno =3D hdr->seqno;
-=09drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
+=09drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
=20
-=09if (msg.req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY)
-=09=09guid =3D msg.u.conn_stat.guid;
-=09else if (msg.req_type =3D=3D DP_RESOURCE_STATUS_NOTIFY)
-=09=09guid =3D msg.u.resource_stat.guid;
-=09else
+=09if (up_req->msg.req_type !=3D DP_CONNECTION_STATUS_NOTIFY &&
+=09    up_req->msg.req_type !=3D DP_RESOURCE_STATUS_NOTIFY) {
+=09=09DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
+=09=09=09      up_req->msg.req_type);
+=09=09kfree(up_req);
 =09=09goto out;
-
-=09drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno,
-=09=09=09=09 false);
-
-=09if (!mstb) {
-=09=09mstb =3D drm_dp_get_mst_branch_device_by_guid(mgr, guid);
-=09=09if (!mstb) {
-=09=09=09DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
-=09=09=09=09      hdr->lct);
-=09=09=09goto out;
-=09=09}
 =09}
=20
-=09if (msg.req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
-=09=09drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
+=09drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, up_req->msg.req_type,
+=09=09=09=09 seqno, false);
+
+=09if (up_req->msg.req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
+=09=09const struct drm_dp_connection_status_notify *conn_stat =3D
+=09=09=09&up_req->msg.u.conn_stat;
=20
 =09=09DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: =
%d\n",
-=09=09=09      msg.u.conn_stat.port_number,
-=09=09=09      msg.u.conn_stat.legacy_device_plug_status,
-=09=09=09      msg.u.conn_stat.displayport_device_plug_status,
-=09=09=09      msg.u.conn_stat.message_capability_status,
-=09=09=09      msg.u.conn_stat.input_port,
-=09=09=09      msg.u.conn_stat.peer_device_type);
+=09=09=09      conn_stat->port_number,
+=09=09=09      conn_stat->legacy_device_plug_status,
+=09=09=09      conn_stat->displayport_device_plug_status,
+=09=09=09      conn_stat->message_capability_status,
+=09=09=09      conn_stat->input_port,
+=09=09=09      conn_stat->peer_device_type);
+=09} else if (up_req->msg.req_type =3D=3D DP_RESOURCE_STATUS_NOTIFY) {
+=09=09const struct drm_dp_resource_status_notify *res_stat =3D
+=09=09=09&up_req->msg.u.resource_stat;
=20
-=09=09drm_kms_helper_hotplug_event(mgr->dev);
-=09} else if (msg.req_type =3D=3D DP_RESOURCE_STATUS_NOTIFY) {
 =09=09DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
-=09=09=09      msg.u.resource_stat.port_number,
-=09=09=09      msg.u.resource_stat.available_pbn);
+=09=09=09      res_stat->port_number,
+=09=09=09      res_stat->available_pbn);
 =09}
=20
-=09drm_dp_mst_topology_put_mstb(mstb);
+=09up_req->hdr =3D *hdr;
+=09mutex_lock(&mgr->up_req_lock);
+=09list_add_tail(&up_req->next, &mgr->up_req_list);
+=09mutex_unlock(&mgr->up_req_lock);
+=09queue_work(system_long_wq, &mgr->up_req_work);
+
 out:
 =09memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
 =09return 0;
@@ -4286,12 +4348,15 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_=
topology_mgr *mgr,
 =09mutex_init(&mgr->qlock);
 =09mutex_init(&mgr->payload_lock);
 =09mutex_init(&mgr->delayed_destroy_lock);
+=09mutex_init(&mgr->up_req_lock);
 =09INIT_LIST_HEAD(&mgr->tx_msg_downq);
 =09INIT_LIST_HEAD(&mgr->destroy_port_list);
 =09INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
+=09INIT_LIST_HEAD(&mgr->up_req_list);
 =09INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
 =09INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
 =09INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
+=09INIT_WORK(&mgr->up_req_work, drm_dp_mst_up_req_work);
 =09init_waitqueue_head(&mgr->tx_waitq);
 =09mgr->dev =3D dev;
 =09mgr->aux =3D aux;
@@ -4348,6 +4413,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09mutex_destroy(&mgr->payload_lock);
 =09mutex_destroy(&mgr->qlock);
 =09mutex_destroy(&mgr->lock);
+=09mutex_destroy(&mgr->up_req_lock);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
=20
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index 8ba2a01324bb..7d80c38ee00e 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -597,6 +597,22 @@ struct drm_dp_mst_topology_mgr {
 =09 * devices, needed to avoid locking inversion.
 =09 */
 =09struct work_struct delayed_destroy_work;
+
+=09/**
+=09 * @up_req_list: List of pending up requests from the topology that
+=09 * need to be processed, in chronological order.
+=09 */
+=09struct list_head up_req_list;
+=09/**
+=09 * @up_req_lock: Protects @up_req_list
+=09 */
+=09struct mutex up_req_lock;
+=09/**
+=09 * @up_req_work: Work item to process up requests received from the
+=09 * topology. Needed to avoid blocking hotplug handling and sideband
+=09 * transmissions.
+=09 */
+=09struct work_struct up_req_work;
 };
=20
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
--=20
2.21.0

