Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CACA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2920882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QilF5EDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfJVCmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:42:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfJVCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NzST84UVP7UqSrxt1t/UMMPijv4/JY92KueGM0g9gA=;
        b=QilF5EDu86gJkp2AV2lQ4lpTES1+QZyi8afdUuW2xnSy5Ms0wK1M01rCGO1MTbDg3OFwQ7
        T+Lnzo1wGc4x87EhHORx+EWbAiAax77d3YyAGIBjl0P8qQLB1QPJgWi8/QGXX3BGNZNgTa
        CWOaWplVhKGVYv8UOJ+GA+zHrZMJcpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-gjcSJMpeMYCymoAyWoOlMA-1; Mon, 21 Oct 2019 22:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A7D1005500;
        Tue, 22 Oct 2019 02:41:57 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C94560126;
        Tue, 22 Oct 2019 02:41:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/14] drm/dp_mst: Add basic topology reprobing when resuming
Date:   Mon, 21 Oct 2019 22:36:08 -0400
Message-Id: <20191022023641.8026-14-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gjcSJMpeMYCymoAyWoOlMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Changes since v4:
* Split indenting changes in drm_dp_mst_topology_mgr_resume() into a
  separate patch
* Only fire hotplugs when something has actually changed after a link
  address probe
* Don't try to change port->connector at all on ports, just throw out
  ports that need their connectors removed to make things easier.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/drm_dp_mst_topology.c         | 182 ++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp.c       |   3 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   6 +-
 include/drm/drm_dp_mst_helper.h               |   3 +-
 5 files changed, 156 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f67d301ad81..6c34f640f419 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -974,7 +974,7 @@ static void s3_handle_mst(struct drm_device *dev, bool =
suspend)
 =09=09if (suspend) {
 =09=09=09drm_dp_mst_topology_mgr_suspend(mgr);
 =09=09} else {
-=09=09=09ret =3D drm_dp_mst_topology_mgr_resume(mgr);
+=09=09=09ret =3D drm_dp_mst_topology_mgr_resume(mgr, true);
 =09=09=09if (ret < 0) {
 =09=09=09=09drm_dp_mst_topology_mgr_set_mst(mgr, false);
 =09=09=09=09need_hotplug =3D true;
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index d486d15aa002..428160270482 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -67,8 +67,8 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topol=
ogy_mgr *mgr,
 =09=09=09=09  struct drm_dp_mst_port *port,
 =09=09=09=09  int offset, int size, u8 *bytes);
=20
-static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
-=09=09=09=09     struct drm_dp_mst_branch *mstb);
+static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
+=09=09=09=09    struct drm_dp_mst_branch *mstb);
 static int drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr =
*mgr,
 =09=09=09=09=09   struct drm_dp_mst_branch *mstb,
 =09=09=09=09=09   struct drm_dp_mst_port *port);
@@ -1977,7 +1977,7 @@ drm_dp_mst_add_port(struct drm_device *dev,
 =09return port;
 }
=20
-static void
+static int
 drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 =09=09=09=09    struct drm_device *dev,
 =09=09=09=09    struct drm_dp_link_addr_reply_port *port_msg)
@@ -1986,33 +1986,45 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 =09struct drm_dp_mst_port *port;
 =09int old_ddps =3D 0, ret;
 =09u8 new_pdt =3D DP_PEER_DEVICE_NONE;
-=09bool created =3D false, send_link_addr =3D false;
+=09bool created =3D false, send_link_addr =3D false, changed =3D false;
=20
 =09port =3D drm_dp_get_port(mstb, port_msg->port_number);
 =09if (!port) {
 =09=09port =3D drm_dp_mst_add_port(dev, mgr, mstb,
 =09=09=09=09=09   port_msg->port_number);
 =09=09if (!port)
-=09=09=09return;
+=09=09=09return -ENOMEM;
 =09=09created =3D true;
-=09} else if (port_msg->input_port && !port->input && port->connector) {
-=09=09/* Destroying the connector is impossible in this context, so
-=09=09 * replace the port with a new one
+=09=09changed =3D true;
+=09} else if (!port->input && port_msg->input_port && port->connector) {
+=09=09/* Since port->connector can't be changed here, we create a
+=09=09 * new port if input_port changes from 0 to 1
 =09=09 */
 =09=09drm_dp_mst_topology_unlink_port(mgr, port);
 =09=09drm_dp_mst_topology_put_port(port);
-
 =09=09port =3D drm_dp_mst_add_port(dev, mgr, mstb,
 =09=09=09=09=09   port_msg->port_number);
 =09=09if (!port)
-=09=09=09return;
+=09=09=09return -ENOMEM;
+=09=09changed =3D true;
 =09=09created =3D true;
-=09} else {
-=09=09/* Locking is only needed when the port has a connector
-=09=09 * exposed to userspace
+=09} else if (port->input && !port_msg->input_port) {
+=09=09changed =3D true;
+=09} else if (port->connector) {
+=09=09/* We're updating a port that's exposed to userspace, so do it
+=09=09 * under lock
 =09=09 */
 =09=09drm_modeset_lock(&mgr->base.lock, NULL);
+
 =09=09old_ddps =3D port->ddps;
+=09=09changed =3D port->ddps !=3D port_msg->ddps ||
+=09=09=09(port->ddps &&
+=09=09=09 (port->ldps !=3D port_msg->legacy_device_plug_status ||
+=09=09=09  port->dpcd_rev !=3D port_msg->dpcd_revision ||
+=09=09=09  port->mcs !=3D port_msg->mcs ||
+=09=09=09  port->pdt !=3D port_msg->peer_device_type ||
+=09=09=09  port->num_sdp_stream_sinks !=3D
+=09=09=09  port_msg->num_sdp_stream_sinks));
 =09}
=20
 =09port->input =3D port_msg->input_port;
@@ -2054,23 +2066,38 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_m=
st_branch *mstb,
 =09=09goto fail;
 =09}
=20
-=09if (!created)
+=09/*
+=09 * If this port wasn't just created, then we're reprobing because
+=09 * we're coming out of suspend. In this case, always resend the link
+=09 * address if there's an MSTB on this port
+=09 */
+=09if (!created && port->pdt =3D=3D DP_PEER_DEVICE_MST_BRANCHING)
+=09=09send_link_addr =3D true;
+
+=09if (port->connector)
 =09=09drm_modeset_unlock(&mgr->base.lock);
-=09else if (!port->connector && !port->input)
+=09else if (!port->input)
 =09=09drm_dp_mst_port_add_connector(mstb, port);
=20
-=09if (send_link_addr && port->mstb)
-=09=09drm_dp_send_link_address(mgr, port->mstb);
+=09if (send_link_addr && port->mstb) {
+=09=09ret =3D drm_dp_send_link_address(mgr, port->mstb);
+=09=09if (ret =3D=3D 1) /* MSTB below us changed */
+=09=09=09changed =3D true;
+=09=09else if (ret < 0)
+=09=09=09goto fail_put;
+=09}
=20
 =09/* put reference to this port */
 =09drm_dp_mst_topology_put_port(port);
-=09return;
+=09return changed;
=20
 fail:
 =09drm_dp_mst_topology_unlink_port(mgr, port);
-=09drm_dp_mst_topology_put_port(port);
-=09if (!created)
+=09if (port->connector)
 =09=09drm_modeset_unlock(&mgr->base.lock);
+fail_put:
+=09drm_dp_mst_topology_put_port(port);
+=09return ret;
 }
=20
 static void
@@ -2230,13 +2257,20 @@ drm_dp_get_mst_branch_device_by_guid(struct drm_dp_=
mst_topology_mgr *mgr,
 =09return mstb;
 }
=20
-static void drm_dp_check_and_send_link_address(struct drm_dp_mst_topology_=
mgr *mgr,
+static int drm_dp_check_and_send_link_address(struct drm_dp_mst_topology_m=
gr *mgr,
 =09=09=09=09=09       struct drm_dp_mst_branch *mstb)
 {
 =09struct drm_dp_mst_port *port;
+=09int ret;
+=09bool changed =3D false;
=20
-=09if (!mstb->link_address_sent)
-=09=09drm_dp_send_link_address(mgr, mstb);
+=09if (!mstb->link_address_sent) {
+=09=09ret =3D drm_dp_send_link_address(mgr, mstb);
+=09=09if (ret =3D=3D 1)
+=09=09=09changed =3D true;
+=09=09else if (ret < 0)
+=09=09=09return ret;
+=09}
=20
 =09list_for_each_entry(port, &mstb->ports, next) {
 =09=09struct drm_dp_mst_branch *mstb_child =3D NULL;
@@ -2248,6 +2282,7 @@ static void drm_dp_check_and_send_link_address(struct=
 drm_dp_mst_topology_mgr *m
 =09=09=09drm_modeset_lock(&mgr->base.lock, NULL);
 =09=09=09drm_dp_send_enum_path_resources(mgr, mstb, port);
 =09=09=09drm_modeset_unlock(&mgr->base.lock);
+=09=09=09changed =3D true;
 =09=09}
=20
 =09=09if (port->mstb)
@@ -2255,10 +2290,17 @@ static void drm_dp_check_and_send_link_address(stru=
ct drm_dp_mst_topology_mgr *m
 =09=09=09    mgr, port->mstb);
=20
 =09=09if (mstb_child) {
-=09=09=09drm_dp_check_and_send_link_address(mgr, mstb_child);
+=09=09=09ret =3D drm_dp_check_and_send_link_address(mgr,
+=09=09=09=09=09=09=09=09 mstb_child);
 =09=09=09drm_dp_mst_topology_put_mstb(mstb_child);
+=09=09=09if (ret =3D=3D 1)
+=09=09=09=09changed =3D true;
+=09=09=09else if (ret < 0)
+=09=09=09=09return ret;
 =09=09}
 =09}
+
+=09return changed;
 }
=20
 static void drm_dp_mst_link_probe_work(struct work_struct *work)
@@ -2284,11 +2326,12 @@ static void drm_dp_mst_link_probe_work(struct work_=
struct *work)
 =09=09return;
 =09}
=20
-=09drm_dp_check_and_send_link_address(mgr, mstb);
+=09ret =3D drm_dp_check_and_send_link_address(mgr, mstb);
 =09drm_dp_mst_topology_put_mstb(mstb);
=20
 =09mutex_unlock(&mgr->probe_lock);
-=09drm_kms_helper_hotplug_event(dev);
+=09if (ret)
+=09=09drm_kms_helper_hotplug_event(dev);
 }
=20
 static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
@@ -2534,16 +2577,18 @@ drm_dp_dump_link_address(struct drm_dp_link_address=
_ack_reply *reply)
 =09}
 }
=20
-static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
+static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 =09=09=09=09     struct drm_dp_mst_branch *mstb)
 {
 =09struct drm_dp_sideband_msg_tx *txmsg;
 =09struct drm_dp_link_address_ack_reply *reply;
-=09int i, len, ret;
+=09struct drm_dp_mst_port *port, *tmp;
+=09int i, len, ret, port_mask =3D 0;
+=09bool changed =3D false;
=20
 =09txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
 =09if (!txmsg)
-=09=09return;
+=09=09return -ENOMEM;
=20
 =09txmsg->dst =3D mstb;
 =09len =3D build_link_address(txmsg);
@@ -2569,14 +2614,39 @@ static void drm_dp_send_link_address(struct drm_dp_=
mst_topology_mgr *mgr,
=20
 =09drm_dp_check_mstb_guid(mstb, reply->guid);
=20
-=09for (i =3D 0; i < reply->nports; i++)
-=09=09drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
-=09=09=09=09=09=09    &reply->ports[i]);
+=09for (i =3D 0; i < reply->nports; i++) {
+=09=09port_mask |=3D BIT(reply->ports[i].port_number);
+=09=09ret =3D drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
+=09=09=09=09=09=09=09  &reply->ports[i]);
+=09=09if (ret =3D=3D 1)
+=09=09=09changed =3D true;
+=09=09else if (ret < 0)
+=09=09=09goto out;
+=09}
+
+=09/* Prune any ports that are currently a part of mstb in our in-memory
+=09 * topology, but were not seen in this link address. Usually this
+=09 * means that they were removed while the topology was out of sync,
+=09 * e.g. during suspend/resume
+=09 */
+=09mutex_lock(&mgr->lock);
+=09list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
+=09=09if (port_mask & BIT(port->port_num))
+=09=09=09continue;
+
+=09=09DRM_DEBUG_KMS("port %d was not in link address, removing\n",
+=09=09=09      port->port_num);
+=09=09list_del(&port->next);
+=09=09drm_dp_mst_topology_put_port(port);
+=09=09changed =3D true;
+=09}
+=09mutex_unlock(&mgr->lock);
=20
 out:
 =09if (ret <=3D 0)
 =09=09mstb->link_address_sent =3D false;
 =09kfree(txmsg);
+=09return ret < 0 ? ret : changed;
 }
=20
 static int
@@ -3181,6 +3251,23 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_ms=
t_topology_mgr *mgr, bool ms
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_set_mst);
=20
+static void
+drm_dp_mst_topology_mgr_invalidate_mstb(struct drm_dp_mst_branch *mstb)
+{
+=09struct drm_dp_mst_port *port;
+
+=09/* The link address will need to be re-sent on resume */
+=09mstb->link_address_sent =3D false;
+
+=09list_for_each_entry(port, &mstb->ports, next) {
+=09=09/* The PBN for each port will also need to be re-probed */
+=09=09port->available_pbn =3D 0;
+
+=09=09if (port->mstb)
+=09=09=09drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
+=09}
+}
+
 /**
  * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
  * @mgr: manager to suspend
@@ -3197,20 +3284,36 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_=
mst_topology_mgr *mgr)
 =09flush_work(&mgr->up_req_work);
 =09flush_work(&mgr->work);
 =09flush_work(&mgr->delayed_destroy_work);
+
+=09mutex_lock(&mgr->lock);
+=09if (mgr->mst_state && mgr->mst_primary)
+=09=09drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
+=09mutex_unlock(&mgr->lock);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
=20
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
+ * During system resume (where it is assumed that the driver will be calli=
ng
+ * drm_atomic_helper_resume()) this function should be called beforehand w=
ith
+ * @sync set to true. In contexts like runtime resume where the driver is =
not
+ * expected to be calling drm_atomic_helper_resume(), this function should=
 be
+ * called with @sync set to false in order to avoid deadlocking.
+ *
+ * Returns: -1 if the MST topology was removed while we were suspended, 0
+ * otherwise.
  */
-int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
+int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
+=09=09=09=09   bool sync)
 {
 =09int ret;
 =09u8 guid[16];
@@ -3243,8 +3346,19 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst=
_topology_mgr *mgr)
 =09}
 =09drm_dp_check_mstb_guid(mgr->mst_primary, guid);
=20
+=09/*
+=09 * For the final step of resuming the topology, we need to bring the
+=09 * state of our in-memory topology back into sync with reality. So,
+=09 * restart the probing process as if we're probing a new hub
+=09 */
+=09queue_work(system_long_wq, &mgr->work);
 =09mutex_unlock(&mgr->lock);
=20
+=09if (sync) {
+=09=09DRM_DEBUG_KMS("Waiting for link probe work to finish re-syncing topo=
logy...\n");
+=09=09flush_work(&mgr->work);
+=09}
+
 =09return 0;
=20
 out_fail:
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915=
/display/intel_dp.c
index 5eeafa45831a..403b593a3eb4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7625,7 +7625,8 @@ void intel_dp_mst_resume(struct drm_i915_private *dev=
_priv)
 =09=09if (!intel_dp->can_mst)
 =09=09=09continue;
=20
-=09=09ret =3D drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
+=09=09ret =3D drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr,
+=09=09=09=09=09=09     true);
 =09=09if (ret) {
 =09=09=09intel_dp->is_mst =3D false;
 =09=09=09drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouv=
eau/dispnv50/disp.c
index a9d6aa110cfd..549486f1d937 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1309,14 +1309,14 @@ nv50_mstm_fini(struct nv50_mstm *mstm)
 }
=20
 static void
-nv50_mstm_init(struct nv50_mstm *mstm)
+nv50_mstm_init(struct nv50_mstm *mstm, bool runtime)
 {
 =09int ret;
=20
 =09if (!mstm || !mstm->mgr.mst_state)
 =09=09return;
=20
-=09ret =3D drm_dp_mst_topology_mgr_resume(&mstm->mgr);
+=09ret =3D drm_dp_mst_topology_mgr_resume(&mstm->mgr, !runtime);
 =09if (ret =3D=3D -1) {
 =09=09drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, false);
 =09=09drm_kms_helper_hotplug_event(mstm->mgr.dev);
@@ -2263,7 +2263,7 @@ nv50_display_init(struct drm_device *dev, bool resume=
, bool runtime)
 =09=09if (encoder->encoder_type !=3D DRM_MODE_ENCODER_DPMST) {
 =09=09=09struct nouveau_encoder *nv_encoder =3D
 =09=09=09=09nouveau_encoder(encoder);
-=09=09=09nv50_mstm_init(nv_encoder->dp.mstm);
+=09=09=09nv50_mstm_init(nv_encoder->dp.mstm, runtime);
 =09=09}
 =09}
=20
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index fd142db42cb0..144027e27464 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -706,7 +706,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
=20
 void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
 int __must_check
-drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
+drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
+=09=09=09       bool sync);
=20
 ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux *aux,
 =09=09=09     unsigned int offset, void *buffer, size_t size);
--=20
2.21.0

