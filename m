Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF80C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934572081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996776;
	bh=RdtpVDqZ6YMSv9O14Ttk0eDb5t5CL/953BP1+juGe2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2eHPKqUmoTrOa4744hrDad6i9wwLcU1Y9TjmJVOArDR4mUG1CT+jrLrYECndFePie
	 SC835cb67QeRCpo+jc0ty2xhfAux6X9kMXoaSDlHpLva3MK525Z4k5TG65M/hfZfk6
	 M24pdf8AU+A7cr7+/jSHOmHxxpLRvAkUNBSb+riA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfE0Wjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfE0Wje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:39:34 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DCCB20859;
        Mon, 27 May 2019 22:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996772;
        bh=RdtpVDqZ6YMSv9O14Ttk0eDb5t5CL/953BP1+juGe2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIoeWL+2O/J9LBHYZfJUoLEFrW3gPPM0pLRfVYCJB+mHhF3bA4OrAqjxkdLIYBLJN
         7XQ14zZt5Jz9HYhD56FyMeapIE4LWSVHtp1aw0ZKDqlcWvfe4P2BAQGzipfGblfVdh
         dgmxaWZaWIqdg3ZhYjYs0InaQzOA4Ibt+sGkErpg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 24/44] tools headers UAPI: Sync drm/i915_drm.h with the kernel
Date:   Mon, 27 May 2019 19:37:10 -0300
Message-Id: <20190527223730.11474-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  d1172ab3d443 ("drm/i915: Introduce struct class_instance for engines across the uAPI")
  96fd2c6633b0 ("drm/i915: Drop new chunks of context creation ABI (for now)")
  ea593dbba4c8 ("drm/i915: Allow contexts to share a single timeline across all engines")
  b91715417244 ("drm/i915: Extend CONTEXT_CREATE to set parameters upon construction")
  e0695db7298e ("drm/i915: Create/destroy VM (ppGTT) for use with contexts")
  9d1305ef80b9 ("drm/i915: Introduce the i915_user_extension_method")
  c8b502422bfe ("drm/i915: Remove last traces of exec-id (GEM_BUSY)")
  d90c06d57027 ("drm/i915: Fix I915_EXEC_RING_MASK")
  e88619646971 ("drm/i915: Use HW semaphores for inter-engine synchronisation on gen8+")
  be03564bd7b6 ("drm/i915: Include reminders about leaving no holes in uAPI enums")
  ba4fda620a5f ("drm/i915: Optionally disable automatic recovery after a GPU reset")

We still don't take into account the _IOC_SIZE() to differentiate ioctl cmds,
so more work is needed to support the extension mechanism that is being used
here so that we can differentiate DRM_IOCTL_I915_GEM_CONTEXT_CREATE from the
newly introduced DRM_IOCTL_I915_GEM_CONTEXT_CREATE_EXT cmd.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://lkml.kernel.org/n/tip-csn0vanmc7pevyka5qcg0xyw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 254 +++++++++++++++++++++---------
 1 file changed, 181 insertions(+), 73 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 397810fa2d33..3a73f5316766 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -62,6 +62,28 @@ extern "C" {
 #define I915_ERROR_UEVENT		"ERROR"
 #define I915_RESET_UEVENT		"RESET"
 
+/*
+ * i915_user_extension: Base class for defining a chain of extensions
+ *
+ * Many interfaces need to grow over time. In most cases we can simply
+ * extend the struct and have userspace pass in more data. Another option,
+ * as demonstrated by Vulkan's approach to providing extensions for forward
+ * and backward compatibility, is to use a list of optional structs to
+ * provide those extra details.
+ *
+ * The key advantage to using an extension chain is that it allows us to
+ * redefine the interface more easily than an ever growing struct of
+ * increasing complexity, and for large parts of that interface to be
+ * entirely optional. The downside is more pointer chasing; chasing across
+ * the __user boundary with pointers encapsulated inside u64.
+ */
+struct i915_user_extension {
+	__u64 next_extension;
+	__u32 name;
+	__u32 flags; /* All undefined bits must be zero. */
+	__u32 rsvd[4]; /* Reserved for future use; must be zero. */
+};
+
 /*
  * MOCS indexes used for GPU surfaces, defining the cacheability of the
  * surface data and the coherency for this data wrt. CPU vs. GPU accesses.
@@ -99,9 +121,23 @@ enum drm_i915_gem_engine_class {
 	I915_ENGINE_CLASS_VIDEO		= 2,
 	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
 
+	/* should be kept compact */
+
 	I915_ENGINE_CLASS_INVALID	= -1
 };
 
+/*
+ * There may be more than one engine fulfilling any role within the system.
+ * Each engine of a class is given a unique instance number and therefore
+ * any engine can be specified by its class:instance tuplet. APIs that allow
+ * access to any engine in the system will use struct i915_engine_class_instance
+ * for this identification.
+ */
+struct i915_engine_class_instance {
+	__u16 engine_class; /* see enum drm_i915_gem_engine_class */
+	__u16 engine_instance;
+};
+
 /**
  * DOC: perf_events exposed by i915 through /sys/bus/event_sources/drivers/i915
  *
@@ -319,6 +355,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_I915_PERF_ADD_CONFIG	0x37
 #define DRM_I915_PERF_REMOVE_CONFIG	0x38
 #define DRM_I915_QUERY			0x39
+/* Must be kept compact -- no holes */
 
 #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
 #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
@@ -367,6 +404,7 @@ typedef struct _drm_i915_sarea {
 #define DRM_IOCTL_I915_GET_SPRITE_COLORKEY DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GET_SPRITE_COLORKEY, struct drm_intel_sprite_colorkey)
 #define DRM_IOCTL_I915_GEM_WAIT		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_WAIT, struct drm_i915_gem_wait)
 #define DRM_IOCTL_I915_GEM_CONTEXT_CREATE	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create)
+#define DRM_IOCTL_I915_GEM_CONTEXT_CREATE_EXT	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create_ext)
 #define DRM_IOCTL_I915_GEM_CONTEXT_DESTROY	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_DESTROY, struct drm_i915_gem_context_destroy)
 #define DRM_IOCTL_I915_REG_READ			DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_REG_READ, struct drm_i915_reg_read)
 #define DRM_IOCTL_I915_GET_RESET_STATS		DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GET_RESET_STATS, struct drm_i915_reset_stats)
@@ -476,6 +514,7 @@ typedef struct drm_i915_irq_wait {
 #define   I915_SCHEDULER_CAP_ENABLED	(1ul << 0)
 #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
 #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
+#define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
 
 #define I915_PARAM_HUC_STATUS		 42
 
@@ -559,6 +598,8 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_MMAP_GTT_COHERENT	52
 
+/* Must be kept compact -- no holes and well documented */
+
 typedef struct drm_i915_getparam {
 	__s32 param;
 	/*
@@ -574,6 +615,7 @@ typedef struct drm_i915_getparam {
 #define I915_SETPARAM_TEX_LRU_LOG_GRANULARITY             2
 #define I915_SETPARAM_ALLOW_BATCHBUFFER                   3
 #define I915_SETPARAM_NUM_USED_FENCES                     4
+/* Must be kept compact -- no holes */
 
 typedef struct drm_i915_setparam {
 	int param;
@@ -972,7 +1014,7 @@ struct drm_i915_gem_execbuffer2 {
 	 * struct drm_i915_gem_exec_fence *fences.
 	 */
 	__u64 cliprects_ptr;
-#define I915_EXEC_RING_MASK              (7<<0)
+#define I915_EXEC_RING_MASK              (0x3f)
 #define I915_EXEC_DEFAULT                (0<<0)
 #define I915_EXEC_RENDER                 (1<<0)
 #define I915_EXEC_BSD                    (2<<0)
@@ -1120,32 +1162,34 @@ struct drm_i915_gem_busy {
 	 * as busy may become idle before the ioctl is completed.
 	 *
 	 * Furthermore, if the object is busy, which engine is busy is only
-	 * provided as a guide. There are race conditions which prevent the
-	 * report of which engines are busy from being always accurate.
-	 * However, the converse is not true. If the object is idle, the
-	 * result of the ioctl, that all engines are idle, is accurate.
+	 * provided as a guide and only indirectly by reporting its class
+	 * (there may be more than one engine in each class). There are race
+	 * conditions which prevent the report of which engines are busy from
+	 * being always accurate.  However, the converse is not true. If the
+	 * object is idle, the result of the ioctl, that all engines are idle,
+	 * is accurate.
 	 *
 	 * The returned dword is split into two fields to indicate both
-	 * the engines on which the object is being read, and the
-	 * engine on which it is currently being written (if any).
+	 * the engine classess on which the object is being read, and the
+	 * engine class on which it is currently being written (if any).
 	 *
 	 * The low word (bits 0:15) indicate if the object is being written
 	 * to by any engine (there can only be one, as the GEM implicit
 	 * synchronisation rules force writes to be serialised). Only the
-	 * engine for the last write is reported.
+	 * engine class (offset by 1, I915_ENGINE_CLASS_RENDER is reported as
+	 * 1 not 0 etc) for the last write is reported.
 	 *
-	 * The high word (bits 16:31) are a bitmask of which engines are
-	 * currently reading from the object. Multiple engines may be
+	 * The high word (bits 16:31) are a bitmask of which engines classes
+	 * are currently reading from the object. Multiple engines may be
 	 * reading from the object simultaneously.
 	 *
-	 * The value of each engine is the same as specified in the
-	 * EXECBUFFER2 ioctl, i.e. I915_EXEC_RENDER, I915_EXEC_BSD etc.
-	 * Note I915_EXEC_DEFAULT is a symbolic value and is mapped to
-	 * the I915_EXEC_RENDER engine for execution, and so it is never
+	 * The value of each engine class is the same as specified in the
+	 * I915_CONTEXT_SET_ENGINES parameter and via perf, i.e.
+	 * I915_ENGINE_CLASS_RENDER, I915_ENGINE_CLASS_COPY, etc.
 	 * reported as active itself. Some hardware may have parallel
 	 * execution engines, e.g. multiple media engines, which are
-	 * mapped to the same identifier in the EXECBUFFER2 ioctl and
-	 * so are not separately reported for busyness.
+	 * mapped to the same class identifier and so are not separately
+	 * reported for busyness.
 	 *
 	 * Caveat emptor:
 	 * Only the boolean result of this query is reliable; that is whether
@@ -1412,65 +1456,17 @@ struct drm_i915_gem_wait {
 };
 
 struct drm_i915_gem_context_create {
-	/*  output: id of new context*/
-	__u32 ctx_id;
-	__u32 pad;
-};
-
-struct drm_i915_gem_context_destroy {
-	__u32 ctx_id;
+	__u32 ctx_id; /* output: id of new context*/
 	__u32 pad;
 };
 
-struct drm_i915_reg_read {
-	/*
-	 * Register offset.
-	 * For 64bit wide registers where the upper 32bits don't immediately
-	 * follow the lower 32bits, the offset of the lower 32bits must
-	 * be specified
-	 */
-	__u64 offset;
-#define I915_REG_READ_8B_WA (1ul << 0)
-
-	__u64 val; /* Return value */
-};
-/* Known registers:
- *
- * Render engine timestamp - 0x2358 + 64bit - gen7+
- * - Note this register returns an invalid value if using the default
- *   single instruction 8byte read, in order to workaround that pass
- *   flag I915_REG_READ_8B_WA in offset field.
- *
- */
-
-struct drm_i915_reset_stats {
-	__u32 ctx_id;
-	__u32 flags;
-
-	/* All resets since boot/module reload, for all contexts */
-	__u32 reset_count;
-
-	/* Number of batches lost when active in GPU, for this context */
-	__u32 batch_active;
-
-	/* Number of batches lost pending for execution, for this context */
-	__u32 batch_pending;
-
-	__u32 pad;
-};
-
-struct drm_i915_gem_userptr {
-	__u64 user_ptr;
-	__u64 user_size;
+struct drm_i915_gem_context_create_ext {
+	__u32 ctx_id; /* output: id of new context*/
 	__u32 flags;
-#define I915_USERPTR_READ_ONLY 0x1
-#define I915_USERPTR_UNSYNCHRONIZED 0x80000000
-	/**
-	 * Returned handle for the object.
-	 *
-	 * Object handles are nonzero.
-	 */
-	__u32 handle;
+#define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
+#define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
+	(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
+	__u64 extensions;
 };
 
 struct drm_i915_gem_context_param {
@@ -1491,6 +1487,28 @@ struct drm_i915_gem_context_param {
 	 * drm_i915_gem_context_param_sseu.
 	 */
 #define I915_CONTEXT_PARAM_SSEU		0x7
+
+/*
+ * Not all clients may want to attempt automatic recover of a context after
+ * a hang (for example, some clients may only submit very small incremental
+ * batches relying on known logical state of previous batches which will never
+ * recover correctly and each attempt will hang), and so would prefer that
+ * the context is forever banned instead.
+ *
+ * If set to false (0), after a reset, subsequent (and in flight) rendering
+ * from this context is discarded, and the client will need to create a new
+ * context to use instead.
+ *
+ * If set to true (1), the kernel will automatically attempt to recover the
+ * context by skipping the hanging batch and executing the next batch starting
+ * from the default context state (discarding the incomplete logical context
+ * state lost due to the reset).
+ *
+ * On creation, all new contexts are marked as recoverable.
+ */
+#define I915_CONTEXT_PARAM_RECOVERABLE	0x8
+/* Must be kept compact -- no holes and well documented */
+
 	__u64 value;
 };
 
@@ -1519,8 +1537,7 @@ struct drm_i915_gem_context_param_sseu {
 	/*
 	 * Engine class & instance to be configured or queried.
 	 */
-	__u16 engine_class;
-	__u16 engine_instance;
+	struct i915_engine_class_instance engine;
 
 	/*
 	 * Unused for now. Must be cleared to zero.
@@ -1553,6 +1570,96 @@ struct drm_i915_gem_context_param_sseu {
 	__u32 rsvd;
 };
 
+struct drm_i915_gem_context_create_ext_setparam {
+#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
+	struct i915_user_extension base;
+	struct drm_i915_gem_context_param param;
+};
+
+struct drm_i915_gem_context_destroy {
+	__u32 ctx_id;
+	__u32 pad;
+};
+
+/*
+ * DRM_I915_GEM_VM_CREATE -
+ *
+ * Create a new virtual memory address space (ppGTT) for use within a context
+ * on the same file. Extensions can be provided to configure exactly how the
+ * address space is setup upon creation.
+ *
+ * The id of new VM (bound to the fd) for use with I915_CONTEXT_PARAM_VM is
+ * returned in the outparam @id.
+ *
+ * No flags are defined, with all bits reserved and must be zero.
+ *
+ * An extension chain maybe provided, starting with @extensions, and terminated
+ * by the @next_extension being 0. Currently, no extensions are defined.
+ *
+ * DRM_I915_GEM_VM_DESTROY -
+ *
+ * Destroys a previously created VM id, specified in @id.
+ *
+ * No extensions or flags are allowed currently, and so must be zero.
+ */
+struct drm_i915_gem_vm_control {
+	__u64 extensions;
+	__u32 flags;
+	__u32 vm_id;
+};
+
+struct drm_i915_reg_read {
+	/*
+	 * Register offset.
+	 * For 64bit wide registers where the upper 32bits don't immediately
+	 * follow the lower 32bits, the offset of the lower 32bits must
+	 * be specified
+	 */
+	__u64 offset;
+#define I915_REG_READ_8B_WA (1ul << 0)
+
+	__u64 val; /* Return value */
+};
+
+/* Known registers:
+ *
+ * Render engine timestamp - 0x2358 + 64bit - gen7+
+ * - Note this register returns an invalid value if using the default
+ *   single instruction 8byte read, in order to workaround that pass
+ *   flag I915_REG_READ_8B_WA in offset field.
+ *
+ */
+
+struct drm_i915_reset_stats {
+	__u32 ctx_id;
+	__u32 flags;
+
+	/* All resets since boot/module reload, for all contexts */
+	__u32 reset_count;
+
+	/* Number of batches lost when active in GPU, for this context */
+	__u32 batch_active;
+
+	/* Number of batches lost pending for execution, for this context */
+	__u32 batch_pending;
+
+	__u32 pad;
+};
+
+struct drm_i915_gem_userptr {
+	__u64 user_ptr;
+	__u64 user_size;
+	__u32 flags;
+#define I915_USERPTR_READ_ONLY 0x1
+#define I915_USERPTR_UNSYNCHRONIZED 0x80000000
+	/**
+	 * Returned handle for the object.
+	 *
+	 * Object handles are nonzero.
+	 */
+	__u32 handle;
+};
+
 enum drm_i915_oa_format {
 	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
 	I915_OA_FORMAT_A29,	    /* HSW only */
@@ -1714,6 +1821,7 @@ struct drm_i915_perf_oa_config {
 struct drm_i915_query_item {
 	__u64 query_id;
 #define DRM_I915_QUERY_TOPOLOGY_INFO    1
+/* Must be kept compact -- no holes and well documented */
 
 	/*
 	 * When set to zero by userspace, this is filled with the size of the
-- 
2.20.1

