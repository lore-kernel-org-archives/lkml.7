Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416ACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1080B21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfICUtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfICUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:49:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD18E3086228;
        Tue,  3 Sep 2019 20:49:18 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CE0F1001B0B;
        Tue,  3 Sep 2019 20:49:17 +0000 (UTC)
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
Subject: [PATCH v2 27/27] drm/dp_mst: Add topology ref history tracking for debugging
Date:   Tue,  3 Sep 2019 16:46:05 -0400
Message-Id: <20190903204645.25487-28-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 20:49:18 +0000 (UTC)
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

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/Kconfig               |  14 ++
 drivers/gpu/drm/drm_dp_mst_topology.c | 233 +++++++++++++++++++++++++-
 include/drm/drm_dp_mst_helper.h       |  45 +++++
 3 files changed, 288 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e67c194c2aca..44fc2c2a6e2c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -93,6 +93,20 @@ config DRM_KMS_FB_HELPER
 	help
 	  FBDEV helpers for KMS drivers.
 
+config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
+        bool "Enable refcount backtrace history in the DP MST helpers"
+        select STACKDEPOT
+        depends on DRM_KMS_HELPER
+        depends on DEBUG_KERNEL
+        depends on EXPERT
+        help
+          Enables debug tracing for topology refs in DRM's DP MST helpers. A
+          history of each topology reference/dereference will be printed to the
+          kernel log once a port or branch device's topology refcount reaches 0.
+
+          This has the potential to use a lot of memory and print some very
+          large kernel messages. If in doubt, say "N".
+
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 5b5c0b3b3c0e..18f9a02927d9 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -28,6 +28,13 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
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
@@ -1405,12 +1412,189 @@ drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
 }
 EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
 
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+
+#define STACK_DEPTH 8
+
+static noinline void
+__topology_ref_save(struct drm_dp_mst_topology_mgr *mgr,
+		    struct drm_dp_mst_topology_ref_history *history,
+		    enum drm_dp_mst_topology_ref_type type)
+{
+	struct drm_dp_mst_topology_ref_entry *entry = NULL;
+	depot_stack_handle_t backtrace;
+	ulong stack_entries[STACK_DEPTH];
+	uint n;
+	int i;
+
+	n = stack_trace_save(stack_entries, ARRAY_SIZE(stack_entries), 1);
+	backtrace = stack_depot_save(stack_entries, n, GFP_KERNEL);
+	if (!backtrace)
+		goto fail_alloc;
+
+	/* Try to find an existing entry for this backtrace */
+	for (i = 0; i < history->len; i++) {
+		if (history->entries[i].backtrace == backtrace) {
+			entry = &history->entries[i];
+			break;
+		}
+	}
+
+	/* Otherwise add one */
+	if (!entry) {
+		struct drm_dp_mst_topology_ref_entry *new;
+		int new_len = history->len + 1;
+
+		new = krealloc(history->entries, sizeof(*new) * new_len,
+			       GFP_KERNEL);
+		if (!new)
+			goto fail_alloc;
+
+		entry = &new[history->len];
+		history->len = new_len;
+		history->entries = new;
+
+		entry->backtrace = backtrace;
+		entry->type = type;
+		entry->count = 0;
+	}
+	entry->count++;
+	entry->ts_nsec = ktime_get_ns();
+
+	return;
+fail_alloc:
+	DRM_WARN_ONCE("Failed to allocate memory for topology refcount backtrace\n");
+}
+
+static int
+topology_ref_history_cmp(const void *a, const void *b)
+{
+	const struct drm_dp_mst_topology_ref_entry *entry_a = a, *entry_b = b;
+
+	if (entry_a->ts_nsec > entry_b->ts_nsec)
+		return 1;
+	else if (entry_a->ts_nsec < entry_b->ts_nsec)
+		return -1;
+	else
+		return 0;
+}
+
+static inline const char *
+topology_ref_type_to_str(enum drm_dp_mst_topology_ref_type type)
+{
+	if (type == DRM_DP_MST_TOPOLOGY_REF_GET)
+		return "get";
+	else
+		return "put";
+}
+
+static void
+__dump_topology_ref_history(struct drm_dp_mst_topology_ref_history *history,
+			    void *ptr, const char *type_str)
+{
+	struct drm_printer p = drm_debug_printer(DBG_PREFIX);
+	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	int i;
+
+	if (!buf)
+		return;
+
+	if (!history->len)
+		goto out;
+
+	/* First, sort the list so that it goes from oldest to newest
+	 * reference entry
+	 */
+	sort(history->entries, history->len, sizeof(*history->entries),
+	     topology_ref_history_cmp, NULL);
+
+	drm_printf(&p,
+		   "%s (%p/%px) topology count reached 0, dumping history:\n",
+		   type_str, ptr, ptr);
+
+	for (i = 0; i < history->len; i++) {
+		const struct drm_dp_mst_topology_ref_entry *entry =
+			&history->entries[i];
+		ulong *entries;
+		uint nr_entries;
+		u64 ts_nsec = entry->ts_nsec;
+		u64 rem_nsec = do_div(ts_nsec, 1000000000);
+
+		nr_entries = stack_depot_fetch(entry->backtrace, &entries);
+		stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 4);
+
+		drm_printf(&p, "  %d %ss (last at %5llu.%06llu):\n%s",
+			   entry->count,
+			   topology_ref_type_to_str(entry->type),
+			   ts_nsec, rem_nsec / 1000, buf);
+	}
+
+	/* Now free the history, since this is the only time we expose it */
+	kfree(history->entries);
+out:
+	kfree(buf);
+}
+
+static __always_inline void
+drm_dp_mst_dump_mstb_topology_history(struct drm_dp_mst_branch *mstb)
+{
+	__dump_topology_ref_history(&mstb->topology_ref_history, mstb,
+				    "MSTB");
+}
+
+static __always_inline void
+drm_dp_mst_dump_port_topology_history(struct drm_dp_mst_port *port)
+{
+	__dump_topology_ref_history(&port->topology_ref_history, port,
+				    "Port");
+}
+
+static __always_inline void
+save_mstb_topology_ref(struct drm_dp_mst_branch *mstb,
+		       enum drm_dp_mst_topology_ref_type type)
+{
+	__topology_ref_save(mstb->mgr, &mstb->topology_ref_history, type);
+}
+
+static __always_inline void
+save_port_topology_ref(struct drm_dp_mst_port *port,
+		       enum drm_dp_mst_topology_ref_type type)
+{
+	__topology_ref_save(port->mgr, &port->topology_ref_history, type);
+}
+
+static inline void
+topology_ref_history_lock(struct drm_dp_mst_topology_mgr *mgr)
+{
+	mutex_lock(&mgr->topology_ref_history_lock);
+}
+
+static inline void
+topology_ref_history_unlock(struct drm_dp_mst_topology_mgr *mgr)
+{
+	mutex_unlock(&mgr->topology_ref_history_lock);
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
 	struct drm_dp_mst_branch *mstb =
 		container_of(kref, struct drm_dp_mst_branch, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
 
+	drm_dp_mst_dump_mstb_topology_history(mstb);
+
 	INIT_LIST_HEAD(&mstb->destroy_next);
 
 	/*
@@ -1448,11 +1632,18 @@ static void drm_dp_destroy_mst_branch_device(struct kref *kref)
 static int __must_check
 drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
 {
-	int ret = kref_get_unless_zero(&mstb->topology_kref);
+	int ret;
 
-	if (ret)
+	topology_ref_history_lock(mstb->mgr);
+	ret = kref_get_unless_zero(&mstb->topology_kref);
+
+	if (ret) {
 		DRM_DEBUG("mstb %p/%px (%d)\n",
 			  mstb, mstb, kref_read(&mstb->topology_kref));
+		save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
+	}
+
+	topology_ref_history_unlock(mstb->mgr);
 
 	return ret;
 }
@@ -1473,10 +1664,15 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
  */
 static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
 {
+	topology_ref_history_lock(mstb->mgr);
+
+	save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_GET);
 	WARN_ON(kref_read(&mstb->topology_kref) == 0);
 	kref_get(&mstb->topology_kref);
 	DRM_DEBUG("mstb %p/%px (%d)\n",
 		  mstb, mstb, kref_read(&mstb->topology_kref));
+
+	topology_ref_history_unlock(mstb->mgr);
 }
 
 /**
@@ -1494,9 +1690,14 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
 static void
 drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
 {
+	topology_ref_history_lock(mstb->mgr);
+
 	DRM_DEBUG("mstb %p/%px (%d)\n",
 		  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
+	save_mstb_topology_ref(mstb, DRM_DP_MST_TOPOLOGY_REF_PUT);
 	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
+
+	topology_ref_history_unlock(mstb->mgr);
 }
 
 static void drm_dp_destroy_port(struct kref *kref)
@@ -1505,6 +1706,8 @@ static void drm_dp_destroy_port(struct kref *kref)
 		container_of(kref, struct drm_dp_mst_port, topology_kref);
 	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
 
+	drm_dp_mst_dump_port_topology_history(port);
+
 	/* There's nothing that needs locking to destroy an input port yet */
 	if (port->input) {
 		drm_dp_mst_put_port_malloc(port);
@@ -1548,12 +1751,18 @@ static void drm_dp_destroy_port(struct kref *kref)
 static int __must_check
 drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
 {
-	int ret = kref_get_unless_zero(&port->topology_kref);
+	int ret;
+
+	topology_ref_history_lock(port->mgr);
+	ret = kref_get_unless_zero(&port->topology_kref);
 
-	if (ret)
+	if (ret) {
 		DRM_DEBUG("port %p/%px (%d)\n",
 			  port, port, kref_read(&port->topology_kref));
+		save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
+	}
 
+	topology_ref_history_unlock(port->mgr);
 	return ret;
 }
 
@@ -1572,10 +1781,15 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
  */
 static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
 {
+	topology_ref_history_lock(port->mgr);
+
 	WARN_ON(kref_read(&port->topology_kref) == 0);
 	kref_get(&port->topology_kref);
 	DRM_DEBUG("port %p/%px (%d)\n",
 		  port, port, kref_read(&port->topology_kref));
+	save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_GET);
+
+	topology_ref_history_unlock(port->mgr);
 }
 
 /**
@@ -1591,9 +1805,14 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
  */
 static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
 {
+	topology_ref_history_lock(port->mgr);
+
 	DRM_DEBUG("port %p/%px (%d)\n",
 		  port, port, kref_read(&port->topology_kref) - 1);
+	save_port_topology_ref(port, DRM_DP_MST_TOPOLOGY_REF_PUT);
 	kref_put(&port->topology_kref, drm_dp_destroy_port);
+
+	topology_ref_history_unlock(port->mgr);
 }
 
 static struct drm_dp_mst_branch *
@@ -4548,6 +4767,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_init(&mgr->payload_lock);
 	mutex_init(&mgr->delayed_destroy_lock);
 	mutex_init(&mgr->up_req_lock);
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+	mutex_init(&mgr->topology_ref_history_lock);
+#endif
 	INIT_LIST_HEAD(&mgr->tx_msg_downq);
 	INIT_LIST_HEAD(&mgr->destroy_port_list);
 	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
@@ -4613,6 +4835,9 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
 	mutex_destroy(&mgr->qlock);
 	mutex_destroy(&mgr->lock);
 	mutex_destroy(&mgr->up_req_lock);
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+	mutex_destroy(&mgr->topology_ref_history_lock);
+#endif
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
 
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 1bdee5ee6dcd..75b8fba6f399 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -26,6 +26,26 @@
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+#include <linux/stackdepot.h>
+#include <linux/timekeeping.h>
+
+enum drm_dp_mst_topology_ref_type {
+	DRM_DP_MST_TOPOLOGY_REF_GET,
+	DRM_DP_MST_TOPOLOGY_REF_PUT,
+};
+
+struct drm_dp_mst_topology_ref_history {
+	struct drm_dp_mst_topology_ref_entry {
+		enum drm_dp_mst_topology_ref_type type;
+		int count;
+		ktime_t ts_nsec;
+		depot_stack_handle_t backtrace;
+	} *entries;
+	int len;
+};
+#endif /* IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS) */
+
 struct drm_dp_mst_branch;
 
 /**
@@ -92,6 +112,14 @@ struct drm_dp_mst_port {
 	 */
 	struct kref malloc_kref;
 
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+	/**
+	 * @topology_ref_history: A history of each topology
+	 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
+	 */
+	struct drm_dp_mst_topology_ref_history topology_ref_history;
+#endif
+
 	u8 port_num;
 	bool input;
 	bool mcs;
@@ -162,6 +190,14 @@ struct drm_dp_mst_branch {
 	 */
 	struct kref malloc_kref;
 
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+	/**
+	 * @topology_ref_history: A history of each topology
+	 * reference/dereference. See CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
+	 */
+	struct drm_dp_mst_topology_ref_history topology_ref_history;
+#endif
+
 	/**
 	 * @destroy_next: linked-list entry used by
 	 * drm_dp_delayed_destroy_work()
@@ -630,6 +666,15 @@ struct drm_dp_mst_topology_mgr {
 	 * transmissions.
 	 */
 	struct work_struct up_req_work;
+
+#if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
+	/**
+	 * @topology_ref_history_lock: protects
+	 * &drm_dp_mst_port.topology_ref_history and
+	 * &drm_dp_mst_branch.topology_ref_history.
+	 */
+	struct mutex topology_ref_history_lock;
+#endif
 };
 
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.21.0

