Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A38B224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575574401;
	bh=TfN9lsi9RJ8PjUq9ieRhqBt+mR00g8pKWzEwHPi0IHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4OiQazlPGeW70YkUEvYfUkOV1nIrEZuNBP4Yc/XX3UVtz+fxDg0TTbezVyUzMkpa
	 Ie4NZxgO43CjJwRorpDUGFAxPNZHZJF6jeM6Ev9m0CbuRzTijCQfgnYZTwqMFZpKXU
	 6Am3bP2YuhDDVHBoSuPQIOn81MlV2oIsUISBtNqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfLETdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLETdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:33:20 -0500
Received: from quaco.ghostprotocols.net (179-240-141-74.3g.claro.net.br [179.240.141.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442DD24648;
        Thu,  5 Dec 2019 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575574398;
        bh=TfN9lsi9RJ8PjUq9ieRhqBt+mR00g8pKWzEwHPi0IHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4zerZiNrXoluxUOqt5UyH/q7ZDUXSwr34LqIJnrW6YTIF5BDcfTa/s8YYUuIfoSC
         QkX3iX1TdSXetGbMwq/MFaWDlHBwe391If7dHJ8ZohNM21ThSENXsiqpPP9+R3DxEF
         IC1x/gyChKIKabMbcJKZYiTJ5DkYXUpVlPPgBj5g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Subject: [PATCH 5/6] tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
Date:   Thu,  5 Dec 2019 16:32:23 -0300
Message-Id: <20191205193224.24629-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
References: <20191205193224.24629-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  a0e047156cde ("drm/i915/gem: Make context persistence optional")
  9cd20ef7803c ("drm/i915/perf: allow holding preemption on filtered ctx")
  7831e9a965ea ("drm/i915/perf: Allow dynamic reconfiguration of the OA stream")
  4f6ccc74a85c ("drm/i915: add support for perf configuration queries")
  b8d49f28aa03 ("drm/i915/perf: introduce a versioning of the i915-perf uapi")
  601734f7aabd ("drm/i915/tgl: s/ss/eu fuse reading support")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qwzjrgwj55y3g6rjdf9spkpr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 128 +++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 469dc512cca3..5400d7e057f1 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -611,6 +611,13 @@ typedef struct drm_i915_irq_wait {
  * See I915_EXEC_FENCE_OUT and I915_EXEC_FENCE_SUBMIT.
  */
 #define I915_PARAM_HAS_EXEC_SUBMIT_FENCE 53
+
+/*
+ * Revision of the i915-perf uAPI. The value returned helps determine what
+ * i915-perf features are available. See drm_i915_perf_property_id.
+ */
+#define I915_PARAM_PERF_REVISION	54
+
 /* Must be kept compact -- no holes and well documented */
 
 typedef struct drm_i915_getparam {
@@ -1565,6 +1572,21 @@ struct drm_i915_gem_context_param {
  *   i915_context_engines_bond (I915_CONTEXT_ENGINES_EXT_BOND)
  */
 #define I915_CONTEXT_PARAM_ENGINES	0xa
+
+/*
+ * I915_CONTEXT_PARAM_PERSISTENCE:
+ *
+ * Allow the context and active rendering to survive the process until
+ * completion. Persistence allows fire-and-forget clients to queue up a
+ * bunch of work, hand the output over to a display server and then quit.
+ * If the context is marked as not persistent, upon closing (either via
+ * an explicit DRM_I915_GEM_CONTEXT_DESTROY or implicitly from file closure
+ * or process termination), the context and any outstanding requests will be
+ * cancelled (and exported fences for cancelled requests marked as -EIO).
+ *
+ * By default, new contexts allow persistence.
+ */
+#define I915_CONTEXT_PARAM_PERSISTENCE	0xb
 /* Must be kept compact -- no holes and well documented */
 
 	__u64 value;
@@ -1844,23 +1866,31 @@ enum drm_i915_perf_property_id {
 	 * Open the stream for a specific context handle (as used with
 	 * execbuffer2). A stream opened for a specific context this way
 	 * won't typically require root privileges.
+	 *
+	 * This property is available in perf revision 1.
 	 */
 	DRM_I915_PERF_PROP_CTX_HANDLE = 1,
 
 	/**
 	 * A value of 1 requests the inclusion of raw OA unit reports as
 	 * part of stream samples.
+	 *
+	 * This property is available in perf revision 1.
 	 */
 	DRM_I915_PERF_PROP_SAMPLE_OA,
 
 	/**
 	 * The value specifies which set of OA unit metrics should be
 	 * be configured, defining the contents of any OA unit reports.
+	 *
+	 * This property is available in perf revision 1.
 	 */
 	DRM_I915_PERF_PROP_OA_METRICS_SET,
 
 	/**
 	 * The value specifies the size and layout of OA unit reports.
+	 *
+	 * This property is available in perf revision 1.
 	 */
 	DRM_I915_PERF_PROP_OA_FORMAT,
 
@@ -1870,9 +1900,22 @@ enum drm_i915_perf_property_id {
 	 * from this exponent as follows:
 	 *
 	 *   80ns * 2^(period_exponent + 1)
+	 *
+	 * This property is available in perf revision 1.
 	 */
 	DRM_I915_PERF_PROP_OA_EXPONENT,
 
+	/**
+	 * Specifying this property is only valid when specify a context to
+	 * filter with DRM_I915_PERF_PROP_CTX_HANDLE. Specifying this property
+	 * will hold preemption of the particular context we want to gather
+	 * performance data about. The execbuf2 submissions must include a
+	 * drm_i915_gem_execbuffer_ext_perf parameter for this to apply.
+	 *
+	 * This property is available in perf revision 3.
+	 */
+	DRM_I915_PERF_PROP_HOLD_PREEMPTION,
+
 	DRM_I915_PERF_PROP_MAX /* non-ABI */
 };
 
@@ -1901,6 +1944,8 @@ struct drm_i915_perf_open_param {
  * to close and re-open a stream with the same configuration.
  *
  * It's undefined whether any pending data for the stream will be lost.
+ *
+ * This ioctl is available in perf revision 1.
  */
 #define I915_PERF_IOCTL_ENABLE	_IO('i', 0x0)
 
@@ -1908,9 +1953,24 @@ struct drm_i915_perf_open_param {
  * Disable data capture for a stream.
  *
  * It is an error to try and read a stream that is disabled.
+ *
+ * This ioctl is available in perf revision 1.
  */
 #define I915_PERF_IOCTL_DISABLE	_IO('i', 0x1)
 
+/**
+ * Change metrics_set captured by a stream.
+ *
+ * If the stream is bound to a specific context, the configuration change
+ * will performed inline with that context such that it takes effect before
+ * the next execbuf submission.
+ *
+ * Returns the previously bound metrics set id, or a negative error code.
+ *
+ * This ioctl is available in perf revision 2.
+ */
+#define I915_PERF_IOCTL_CONFIG	_IO('i', 0x2)
+
 /**
  * Common to all i915 perf records
  */
@@ -1984,6 +2044,7 @@ struct drm_i915_query_item {
 	__u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO    1
 #define DRM_I915_QUERY_ENGINE_INFO	2
+#define DRM_I915_QUERY_PERF_CONFIG      3
 /* Must be kept compact -- no holes and well documented */
 
 	/*
@@ -1995,9 +2056,18 @@ struct drm_i915_query_item {
 	__s32 length;
 
 	/*
-	 * Unused for now. Must be cleared to zero.
+	 * When query_id == DRM_I915_QUERY_TOPOLOGY_INFO, must be 0.
+	 *
+	 * When query_id == DRM_I915_QUERY_PERF_CONFIG, must be one of the
+	 * following :
+	 *         - DRM_I915_QUERY_PERF_CONFIG_LIST
+	 *         - DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID
+	 *         - DRM_I915_QUERY_PERF_CONFIG_FOR_UUID
 	 */
 	__u32 flags;
+#define DRM_I915_QUERY_PERF_CONFIG_LIST          1
+#define DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID 2
+#define DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_ID   3
 
 	/*
 	 * Data will be written at the location pointed by data_ptr when the
@@ -2033,8 +2103,10 @@ struct drm_i915_query {
  *           (data[X / 8] >> (X % 8)) & 1
  *
  * - the subslice mask for each slice with one bit per subslice telling
- *   whether a subslice is available. The availability of subslice Y in slice
- *   X can be queried with the following formula :
+ *   whether a subslice is available. Gen12 has dual-subslices, which are
+ *   similar to two gen11 subslices. For gen12, this array represents dual-
+ *   subslices. The availability of subslice Y in slice X can be queried
+ *   with the following formula :
  *
  *           (data[subslice_offset +
  *                 X * subslice_stride +
@@ -2123,6 +2195,56 @@ struct drm_i915_query_engine_info {
 	struct drm_i915_engine_info engines[];
 };
 
+/*
+ * Data written by the kernel with query DRM_I915_QUERY_PERF_CONFIG.
+ */
+struct drm_i915_query_perf_config {
+	union {
+		/*
+		 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_LIST, i915 sets
+		 * this fields to the number of configurations available.
+		 */
+		__u64 n_configs;
+
+		/*
+		 * When query_id == DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_ID,
+		 * i915 will use the value in this field as configuration
+		 * identifier to decide what data to write into config_ptr.
+		 */
+		__u64 config;
+
+		/*
+		 * When query_id == DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID,
+		 * i915 will use the value in this field as configuration
+		 * identifier to decide what data to write into config_ptr.
+		 *
+		 * String formatted like "%08x-%04x-%04x-%04x-%012x"
+		 */
+		char uuid[36];
+	};
+
+	/*
+	 * Unused for now. Must be cleared to zero.
+	 */
+	__u32 flags;
+
+	/*
+	 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_LIST, i915 will
+	 * write an array of __u64 of configuration identifiers.
+	 *
+	 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_DATA, i915 will
+	 * write a struct drm_i915_perf_oa_config. If the following fields of
+	 * drm_i915_perf_oa_config are set not set to 0, i915 will write into
+	 * the associated pointers the values of submitted when the
+	 * configuration was created :
+	 *
+	 *         - n_mux_regs
+	 *         - n_boolean_regs
+	 *         - n_flex_regs
+	 */
+	__u8 data[];
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.21.0

