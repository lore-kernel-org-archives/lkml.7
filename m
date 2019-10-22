Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9AECA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928F420882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H259MJcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfJVCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:42:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729573AbfJVCmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571712127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrcURt96aE5EHVhNmaVNmOBVnWTfjuiDFNgRlZ76m00=;
        b=H259MJcBlvzfVtvDtqPVr0mD6ufGeMLCnYuACF2mgcXIU3QvdKeagKTUaNj6VQyC/IGgya
        7XgKAJE+OJOuHFz/7+Jeu9dQPGieDFC1ae2u9AszpexqQ8/SuUzrj7F1ibSplxJmsQuO3Z
        uriXOxhcqHfLXLEhKnMAog8bmmDjGag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-nK0cvsgiNnaIyuCaZEGfBQ-1; Mon, 21 Oct 2019 22:42:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 617EB800D41;
        Tue, 22 Oct 2019 02:42:01 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B8660126;
        Tue, 22 Oct 2019 02:41:58 +0000 (UTC)
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
Subject: [PATCH v5 14/14] drm/dp_mst: Add topology ref history tracking for debugging
Date:   Mon, 21 Oct 2019 22:36:09 -0400
Message-Id: <20191022023641.8026-15-lyude@redhat.com>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nK0cvsgiNnaIyuCaZEGfBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For very subtle mistakes with topology refs, it can be rather difficult
to trace them down with the debugging info that we already have. I had
one such issue recently while trying to implement suspend/resume
reprobing for MST, and ended up coming up with this.

Inspired by Chris Wilson's wakeref tracking for i915, this adds a very
similar feature to the DP MST helpers, which allows for partial tracking
of topology refs for both ports and branch devices. This is a lot less
advanced then wakeref tracking: we merely keep a count of all of the
spots where a topology ref has been grabbed or dropped, then dump out
that history in chronological order when a port or branch device's
topology refcount reaches 0. So far, I've found this incredibly useful
for debugging topology refcount errors.

Since this has the potential to be somewhat slow and loud, we add an
expert kernel config option to enable or disable this feature,
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.

Changes since v1:
* Don't forget to destroy topology_ref_history_lock
Changes since v4:
* Correct order of kref_put()/topology_ref_history_unlock - we can't
  unlock the history after kref_put() since the memory might have been
  freed by that point
* Don't print message on allocation error failures, the kernel already
  does this for us

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/Kconfig               |  14 ++
 drivers/gpu/drm/drm_dp_mst_topology.c | 241 ++++++++++++++++++++++++--
 include/drm/drm_dp_mst_helper.h       |  45 +++++
 3 files changed, 290 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 36357a36a281..f3f5910743d4 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -93,6 +93,20 @@ config DRM_KMS_FB_HELPER
 =09help
 =09  FBDEV helpers for KMS drivers.
=20
+config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
+        bool "Enable refcount backtrace history in the DP MST helpers"
+        select STACKDEPOT
+        depends on DRM_KMS_HELPER
+        depends on DEBUG_KERNEL
+        depends on EXPERT
+        help
+          Enables debug tracing for topology refs in DRM's DP MST helpers.=
 A
+          history of each topology reference/dereference will be printed t=
o the
+          kernel log once a port or branch device's topology refcount reac=
hes 0.
+
+          This has the potential to use a lot of memory and print some ver=
y
+          large kernel messages. If in doubt, say "N".
+
 config DRM_FBDEV_EMULATION
 =09bool "Enable legacy fbdev support for your modesetting driver"
 =09depends on DRM
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 428160270482..cedfa281a22e 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -28,6 +28,13 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
=20
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+#include <linux/stackdepot.h>
+#include <linux/sort.h>
+#include <linux/timekeeping.h>
+#include <linux/math64.h>
+#endif
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_dp_mst_helper.h>
@@ -1399,12 +1406,187 @@ drm_dp_mst_put_port_malloc(struct drm_dp_mst_port =
*port)
 }
 EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
=20
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+
+#define STACK_DEPTH 8
+
+static noinline void
+__topology_ref_save(struct drm_dp_mst_topology_mgr *mgr,
+=09=09    struct drm_dp_mst_topology_ref_history *history,
+=09=09    enum drm_dp_mst_topology_ref_type type)
+{
+=09struct drm_dp_mst_topology_ref_entry *entry =3D NULL;
+=09depot_stack_handle_t backtrace;
+=09ulong stack_entries[STACK_DEPTH];
+=09uint n;
+=09int i;
+
+=09n =3D stack_trace_save(stack_entries, ARRAY_SIZE(stack_entries), 1);
+=09backtrace =3D stack_depot_save(stack_entries, n, GFP_KERNEL);
+=09if (!backtrace)
+=09=09return;
+
+=09/* Try to find an existing entry for this backtrace */
+=09for (i =3D 0; i < history->len; i++) {
+=09=09if (history->entries[i].backtrace =3D=3D backtrace) {
+=09=09=09entry =3D &history->entries[i];
+=09=09=09break;
+=09=09}
+=09}
+
+=09/* Otherwise add one */
+=09if (!entry) {
+=09=09struct drm_dp_mst_topology_ref_entry *new;
+=09=09int new_len =3D history->len + 1;
+
+=09=09new =3D krealloc(history->entries, sizeof(*new) * new_len,
+=09=09=09       GFP_KERNEL);
+=09=09if (!new)
+=09=09=09return;
+
+=09=09entry =3D &new[history->len];
+=09=09history->len =3D new_len;
+=09=09history->entries =3D new;
+
+=09=09entry->backtrace =3D backtrace;
+=09=09entry->type =3D type;
+=09=09entry->count =3D 0;
+=09}
+=09entry->count++;
+=09entry->ts_nsec =3D ktime_get_ns();
+
+=09return;
+}
+
+static int
+topology_ref_history_cmp(const void *a, const void *b)
+{
+=09const struct drm_dp_mst_topology_ref_entry *entry_a =3D a, *entry_b =3D=
 b;
+
+=09if (entry_a->ts_nsec > entry_b->ts_nsec)
+=09=09return 1;
+=09else if (entry_a->ts_nsec < entry_b->ts_nsec)
+=09=09return -1;
+=09else
+=09=09return 0;
+}
+
+static inline const char *
+topology_ref_type_to_str(enum drm_dp_mst_topology_ref_type type)
+{
+=09if (type =3D=3D DRM_DP_MST_TOPOLOGY_REF_GET)
+=09=09return "get";
+=09else
+=09=09return "put";
+}
+
+static void
+__dump_topology_ref_history(struct drm_dp_mst_topology_ref_history *histor=
y,
+=09=09=09    void *ptr, const char *type_str)
+{
+=09struct drm_printer p =3D drm_debug_printer(DBG_PREFIX);
+=09char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+=09int i;
+
+=09if (!buf)
+=09=09return;
+
+=09if (!history->len)
+=09=09goto out;
+
+=09/* First, sort the list so that it goes from oldest to newest
+=09 * reference entry
+=09 */
+=09sort(history->entries, history->len, sizeof(*history->entries),
+=09     topology_ref_history_cmp, NULL);
+
+=09drm_printf(&p,
+=09=09   "%s (%p/%px) topology count reached 0, dumping history:\n",
+=09=09   type_str, ptr, ptr);
+
+=09for (i =3D 0; i < history->len; i++) {
+=09=09const struct drm_dp_mst_topology_ref_entry *entry =3D
+=09=09=09&history->entries[i];
+=09=09ulong *entries;
+=09=09uint nr_entries;
+=09=09u64 ts_nsec =3D entry->ts_nsec;
+=09=09u64 rem_nsec =3D do_div(ts_nsec, 1000000000);
+
+=09=09nr_entries =3D stack_depot_fetch(entry->backtrace, &entries);
+=09=09stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 4);
+
+=09=09drm_printf(&p, "  %d %ss (last at %5llu.%06llu):\n%s",
+=09=09=09   entry->count,
+=09=09=09   topology_ref_type_to_str(entry->type),
+=09=09=09   ts_nsec, rem_nsec / 1000, buf);
+=09}
+
+=09/* Now free the history, since this is the only time we expose it */
+=09kfree(history->entries);
+out:
+=09kfree(buf);
+}
+
+static __always_inline void
+drm_dp_mst_dump_mstb_topology_history(struct drm_dp_mst_branch *mstb)
+{
+=09__dump_topology_ref_history(&mstb->topology_ref_history, mstb,
+=09=09=09=09    "MSTB");
+}
+
+static __always_inline void
+drm_dp_mst_dump_port_topology_history(struct drm_dp_mst_port *port)
+{
+=09__dump_topology_ref_history(&port->topology_ref_history, port,
+=09=09=09=09    "Port");
+}
+
+static __always_inline void
+save_mstb_topology_ref(struct drm_dp_mst_branch *mstb,
+=09=09       enum drm_dp_mst_topology_ref_type type)
+{
+=09__topology_ref_save(mstb->mgr, &mstb->topology_ref_history, type);
+}
+
+static __always_inline void
+save_port_topology_ref(struct drm_dp_mst_port *port,
+=09=09       enum drm_dp_mst_topology_ref_type type)
+{
+=09__topology_ref_save(port->mgr, &port->topology_ref_history, type);
+}
+
+static inline void
+topology_ref_history_lock(struct drm_dp_mst_topology_mgr *mgr)
+{
+=09mutex_lock(&mgr->topology_ref_history_lock);
+}
+
+static inline void
+topology_ref_history_unlock(struct drm_dp_mst_topology_mgr *mgr)
+{
+=09mutex_unlock(&mgr->topology_ref_history_lock);
+}
+#else
+static inline void
+topology_ref_history_lock(struct drm_dp_mst_topology_mgr *mgr) {}
+static inline void
+topology_ref_history_unlock(struct drm_dp_mst_topology_mgr *mgr) {}
+static inline void
+drm_dp_mst_dump_mstb_topology_history(struct drm_dp_mst_branch *mstb) {}
+static inline void
+drm_dp_mst_dump_port_topology_history(struct drm_dp_mst_port *port) {}
+#define save_mstb_topology_ref(mstb, type)
+#define save_port_topology_ref(port, type)
+#endif
+
 static void drm_dp_destroy_mst_branch_device(struct kref *kref)
 {
 =09struct drm_dp_mst_branch *mstb =3D
 =09=09container_of(kref, struct drm_dp_mst_branch, topology_kref);
 =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
=20
+=09drm_dp_mst_dump_mstb_topology_history(mstb);
+
 =09INIT_LIST_HEAD(&mstb->destroy_next);
=20
 =09/*
@@ -1442,11 +1624,17 @@ static void drm_dp_destroy_mst_branch_device(struct=
 kref *kref)
 static int __must_check
 drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
 {
-=09int ret =3D kref_get_unless_zero(&mstb->topology_kref);
+=09int ret;
=20
-=09if (ret)
-=09=09DRM_DEBUG("mstb %p (%d)\n", mstb,
-=09=09=09  kref_read(&mstb->topology_kref));
+=09topology_ref_history_lock(mstb->mgr);
+=09ret =3D kref_get_unless_zero(&mstb->topology_kref);
+=09if (ret) {
+=09=09DRM_DEBUG("mstb %p (%d)\n",
+=09=09=09  mstb, kref_read(&mstb->topology_kref));
+=09=09save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
+=09}
+
+=09topology_ref_history_unlock(mstb->mgr);
=20
 =09return ret;
 }
@@ -1467,9 +1655,14 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_b=
ranch *mstb)
  */
 static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
 {
+=09topology_ref_history_lock(mstb->mgr);
+
+=09save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
 =09WARN_ON(kref_read(&mstb->topology_kref) =3D=3D 0);
 =09kref_get(&mstb->topology_kref);
 =09DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->topology_kref));
+
+=09topology_ref_history_unlock(mstb->mgr);
 }
=20
 /**
@@ -1487,8 +1680,13 @@ static void drm_dp_mst_topology_get_mstb(struct drm_=
dp_mst_branch *mstb)
 static void
 drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
 {
+=09topology_ref_history_lock(mstb->mgr);
+
 =09DRM_DEBUG("mstb %p (%d)\n",
 =09=09  mstb, kref_read(&mstb->topology_kref) - 1);
+=09save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_PUT);
+
+=09topology_ref_history_unlock(mstb->mgr);
 =09kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
 }
=20
@@ -1498,6 +1696,8 @@ static void drm_dp_destroy_port(struct kref *kref)
 =09=09container_of(kref, struct drm_dp_mst_port, topology_kref);
 =09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
=20
+=09drm_dp_mst_dump_port_topology_history(port);
+
 =09/* There's nothing that needs locking to destroy an input port yet */
 =09if (port->input) {
 =09=09drm_dp_mst_put_port_malloc(port);
@@ -1541,12 +1741,17 @@ static void drm_dp_destroy_port(struct kref *kref)
 static int __must_check
 drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
 {
-=09int ret =3D kref_get_unless_zero(&port->topology_kref);
+=09int ret;
=20
-=09if (ret)
-=09=09DRM_DEBUG("port %p (%d)\n", port,
-=09=09=09  kref_read(&port->topology_kref));
+=09topology_ref_history_lock(port->mgr);
+=09ret =3D kref_get_unless_zero(&port->topology_kref);
+=09if (ret) {
+=09=09DRM_DEBUG("port %p (%d)\n",
+=09=09=09  port, kref_read(&port->topology_kref));
+=09=09save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
+=09}
=20
+=09topology_ref_history_unlock(port->mgr);
 =09return ret;
 }
=20
@@ -1565,9 +1770,14 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_p=
ort *port)
  */
 static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
 {
+=09topology_ref_history_lock(port->mgr);
+
 =09WARN_ON(kref_read(&port->topology_kref) =3D=3D 0);
 =09kref_get(&port->topology_kref);
 =09DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->topology_kref));
+=09save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
+
+=09topology_ref_history_unlock(port->mgr);
 }
=20
 /**
@@ -1583,8 +1793,13 @@ static void drm_dp_mst_topology_get_port(struct drm_=
dp_mst_port *port)
  */
 static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
 {
-=09DRM_DEBUG("port %p (%d)\n",
-=09=09  port, kref_read(&port->topology_kref) - 1);
+=09topology_ref_history_lock(port->mgr);
+
+=09DRM_DEBUG("port %p/%px (%d)\n",
+=09=09  port, port, kref_read(&port->topology_kref) - 1);
+=09save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_PUT);
+
+=09topology_ref_history_unlock(port->mgr);
 =09kref_put(&port->topology_kref, drm_dp_destroy_port);
 }
=20
@@ -4577,6 +4792,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_to=
pology_mgr *mgr,
 =09mutex_init(&mgr->delayed_destroy_lock);
 =09mutex_init(&mgr->up_req_lock);
 =09mutex_init(&mgr->probe_lock);
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+=09mutex_init(&mgr->topology_ref_history_lock);
+#endif
 =09INIT_LIST_HEAD(&mgr->tx_msg_downq);
 =09INIT_LIST_HEAD(&mgr->destroy_port_list);
 =09INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
@@ -4643,6 +4861,9 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09mutex_destroy(&mgr->lock);
 =09mutex_destroy(&mgr->up_req_lock);
 =09mutex_destroy(&mgr->probe_lock);
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+=09mutex_destroy(&mgr->topology_ref_history_lock);
+#endif
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
=20
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index 144027e27464..d5fc90b30487 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -26,6 +26,26 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
=20
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+#include <linux/stackdepot.h>
+#include <linux/timekeeping.h>
+
+enum drm_dp_mst_topology_ref_type {
+=09DRM_DP_MST_TOPOLOGY_REF_GET,
+=09DRM_DP_MST_TOPOLOGY_REF_PUT,
+};
+
+struct drm_dp_mst_topology_ref_history {
+=09struct drm_dp_mst_topology_ref_entry {
+=09=09enum drm_dp_mst_topology_ref_type type;
+=09=09int count;
+=09=09ktime_t ts_nsec;
+=09=09depot_stack_handle_t backtrace;
+=09} *entries;
+=09int len;
+};
+#endif /* IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS) */
+
 struct drm_dp_mst_branch;
=20
 /**
@@ -89,6 +109,14 @@ struct drm_dp_mst_port {
 =09 */
 =09struct kref malloc_kref;
=20
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+=09/**
+=09 * @topology_ref_history: A history of each topology
+=09 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
+=09 */
+=09struct drm_dp_mst_topology_ref_history topology_ref_history;
+#endif
+
 =09u8 port_num;
 =09bool input;
 =09bool mcs;
@@ -162,6 +190,14 @@ struct drm_dp_mst_branch {
 =09 */
 =09struct kref malloc_kref;
=20
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+=09/**
+=09 * @topology_ref_history: A history of each topology
+=09 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
+=09 */
+=09struct drm_dp_mst_topology_ref_history topology_ref_history;
+#endif
+
 =09/**
 =09 * @destroy_next: linked-list entry used by
 =09 * drm_dp_delayed_destroy_work()
@@ -647,6 +683,15 @@ struct drm_dp_mst_topology_mgr {
 =09 * transmissions.
 =09 */
 =09struct work_struct up_req_work;
+
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+=09/**
+=09 * @topology_ref_history_lock: protects
+=09 * &drm_dp_mst_port.topology_ref_history and
+=09 * &drm_dp_mst_branch.topology_ref_history.
+=09 */
+=09struct mutex topology_ref_history_lock;
+#endif
 };
=20
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
--=20
2.21.0

