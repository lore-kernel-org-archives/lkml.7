Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA94C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F48821835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxMZB8aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfI2UG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:06:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2UG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:06:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so8679496wrv.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mT9ftoA5wWDdYwyTtIXi6V3u3yJIxYq3zwgrONn+Tc4=;
        b=jxMZB8aSLiOwuPNsX304DJ6OL2djgwusWv0qyTm1Gy7gxjJpkneyriO57P9SvRJl2w
         EXEVdsBNFHIqwMTMo3+IrKOwqtfpvPyv6Fwux2F/KSPbyN78giTyTyiUmAhl8B/WZcsj
         saydtcpws2nzwSaOO7ag2wp8J466rLPYWW5ANxhcwsYhVfOkxUbtPySaWnMZ0Eoeka39
         YfXwYTO03KylIdfCkM/vnXpFoLPecl/anLeOH3zPY9tap6XVGhrr9lnTSwu4CedfeAFZ
         XLs6wYCXH1VFPbsBJo6+juNV3EM57kSV/nPfSDl74fSfKP5MAf4bHhrbuzy3qhCb5bMS
         44Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mT9ftoA5wWDdYwyTtIXi6V3u3yJIxYq3zwgrONn+Tc4=;
        b=J4xft5B15PFXZoh6JWmDtVs0kv9OM22WcSZlprxLGmVJ8R1B6nMU3j57PcbgydPzFi
         6gWSinlyfv5Eq3HuPXuLY9Vo3QU9PRquWWICz0ubTQ/AOeX1bTpf7DeVqVBVvPRx+qLL
         jNbR9Z2srNJ5eqvtVNxdXHTZZhdiNLT1EGNOu1R3WWfz0CbunwcxW62iqR07GMiGQ7V7
         ch+PKR0nPpDtDeizb/y2PlUwknktR+DGWo5LRMosC+quqCEDpZPi4Q4kFS9r1A2JCHd9
         qF9CCxbF32po3odxS+N+VsQO3OcgpQj3nA1EantwMNypofRPX/S0swJAR83oAaJUiEDu
         rqrA==
X-Gm-Message-State: APjAAAXEKWMUblVFeaFuTdFNvgXJcaEKrSGOJX8eENZmnSvu/oi6UbAw
        o/vVkcJjN/oUcK4jQwy4SLjzdWQ=
X-Google-Smtp-Source: APXvYqwFsxftjaJG8XtiM5xeBw4tzkZaFG55Fn0OGCmE451zX5OVZFYczKiVAMCvkM+Bgsp3iBoOMw==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr10871657wrx.161.1569787582036;
        Sun, 29 Sep 2019 13:06:22 -0700 (PDT)
Received: from avx2 ([46.53.250.203])
        by smtp.gmail.com with ESMTPSA id p85sm25860899wme.23.2019.09.29.13.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 13:06:21 -0700 (PDT)
Date:   Sun, 29 Sep 2019 23:06:19 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, rostedt@goodmis.org,
        mingo@redhat.com, linux@rasmusvillemoes.dk
Subject: [PATCH] Make is_signed_type() simpler
Message-ID: <20190929200619.GA12851@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Simply compare -1 with 0,
* Drop unnecessary parenthesis sets

New macro leaves pointer as "unsigned type" but gives a warning,
which should be fine because asking whether a pointer is signed is
strange question.

I'm not sure what's going on in the i915 driver, it is shipping kernel
pointers to userspace.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/gpu/drm/i915/i915_trace.h |   86 +++++++++++++++++++-------------------
 include/linux/overflow.h          |    2 
 include/linux/trace_events.h      |    2 
 tools/include/linux/overflow.h    |    2 
 4 files changed, 46 insertions(+), 46 deletions(-)

--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -419,16 +419,16 @@ TRACE_EVENT(i915_gem_object_create,
 	    TP_ARGS(obj),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
+			     __field(unsigned long, obj)
 			     __field(u64, size)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = obj;
+			   __entry->obj = (unsigned long)obj;
 			   __entry->size = obj->base.size;
 			   ),
 
-	    TP_printk("obj=%p, size=0x%llx", __entry->obj, __entry->size)
+	    TP_printk("obj=%p, size=0x%llx", (void *)__entry->obj, __entry->size)
 );
 
 TRACE_EVENT(i915_gem_shrink,
@@ -456,25 +456,25 @@ TRACE_EVENT(i915_vma_bind,
 	    TP_ARGS(vma, flags),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
-			     __field(struct i915_address_space *, vm)
+			     __field(unsigned long, obj)
+			     __field(unsigned long, vm)
 			     __field(u64, offset)
 			     __field(u64, size)
 			     __field(unsigned, flags)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = vma->obj;
-			   __entry->vm = vma->vm;
+			   __entry->obj = (unsigned long)vma->obj;
+			   __entry->vm = (unsigned long)vma->vm;
 			   __entry->offset = vma->node.start;
 			   __entry->size = vma->node.size;
 			   __entry->flags = flags;
 			   ),
 
 	    TP_printk("obj=%p, offset=0x%016llx size=0x%llx%s vm=%p",
-		      __entry->obj, __entry->offset, __entry->size,
+		      (void *)__entry->obj, __entry->offset, __entry->size,
 		      __entry->flags & PIN_MAPPABLE ? ", mappable" : "",
-		      __entry->vm)
+		      (void *)__entry->vm)
 );
 
 TRACE_EVENT(i915_vma_unbind,
@@ -482,21 +482,21 @@ TRACE_EVENT(i915_vma_unbind,
 	    TP_ARGS(vma),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
-			     __field(struct i915_address_space *, vm)
+			     __field(unsigned long, obj)
+			     __field(unsigned long, vm)
 			     __field(u64, offset)
 			     __field(u64, size)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = vma->obj;
-			   __entry->vm = vma->vm;
+			   __entry->obj = (unsigned long)vma->obj;
+			   __entry->vm = (unsigned long)vma->vm;
 			   __entry->offset = vma->node.start;
 			   __entry->size = vma->node.size;
 			   ),
 
 	    TP_printk("obj=%p, offset=0x%016llx size=0x%llx vm=%p",
-		      __entry->obj, __entry->offset, __entry->size, __entry->vm)
+		      (void *)__entry->obj, __entry->offset, __entry->size, (void *)__entry->vm)
 );
 
 TRACE_EVENT(i915_gem_object_pwrite,
@@ -504,19 +504,19 @@ TRACE_EVENT(i915_gem_object_pwrite,
 	    TP_ARGS(obj, offset, len),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
+			     __field(unsigned long, obj)
 			     __field(u64, offset)
 			     __field(u64, len)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = obj;
+			   __entry->obj = (unsigned long)obj;
 			   __entry->offset = offset;
 			   __entry->len = len;
 			   ),
 
 	    TP_printk("obj=%p, offset=0x%llx, len=0x%llx",
-		      __entry->obj, __entry->offset, __entry->len)
+		      (void *)__entry->obj, __entry->offset, __entry->len)
 );
 
 TRACE_EVENT(i915_gem_object_pread,
@@ -524,19 +524,19 @@ TRACE_EVENT(i915_gem_object_pread,
 	    TP_ARGS(obj, offset, len),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
+			     __field(unsigned long, obj)
 			     __field(u64, offset)
 			     __field(u64, len)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = obj;
+			   __entry->obj = (unsigned long)obj;
 			   __entry->offset = offset;
 			   __entry->len = len;
 			   ),
 
 	    TP_printk("obj=%p, offset=0x%llx, len=0x%llx",
-		      __entry->obj, __entry->offset, __entry->len)
+		      (void *)__entry->obj, __entry->offset, __entry->len)
 );
 
 TRACE_EVENT(i915_gem_object_fault,
@@ -544,21 +544,21 @@ TRACE_EVENT(i915_gem_object_fault,
 	    TP_ARGS(obj, index, gtt, write),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
+			     __field(unsigned long, obj)
 			     __field(u64, index)
 			     __field(bool, gtt)
 			     __field(bool, write)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = obj;
+			   __entry->obj = (unsigned long)obj;
 			   __entry->index = index;
 			   __entry->gtt = gtt;
 			   __entry->write = write;
 			   ),
 
 	    TP_printk("obj=%p, %s index=%llu %s",
-		      __entry->obj,
+		      (void *)__entry->obj,
 		      __entry->gtt ? "GTT" : "CPU",
 		      __entry->index,
 		      __entry->write ? ", writable" : "")
@@ -569,14 +569,14 @@ DECLARE_EVENT_CLASS(i915_gem_object,
 	    TP_ARGS(obj),
 
 	    TP_STRUCT__entry(
-			     __field(struct drm_i915_gem_object *, obj)
+			     __field(unsigned long, obj)
 			     ),
 
 	    TP_fast_assign(
-			   __entry->obj = obj;
+			   __entry->obj = (unsigned long)obj;
 			   ),
 
-	    TP_printk("obj=%p", __entry->obj)
+	    TP_printk("obj=%p", (void *)__entry->obj)
 );
 
 DEFINE_EVENT(i915_gem_object, i915_gem_object_clflush,
@@ -595,7 +595,7 @@ TRACE_EVENT(i915_gem_evict,
 
 	    TP_STRUCT__entry(
 			     __field(u32, dev)
-			     __field(struct i915_address_space *, vm)
+			     __field(unsigned long, vm)
 			     __field(u64, size)
 			     __field(u64, align)
 			     __field(unsigned int, flags)
@@ -603,14 +603,14 @@ TRACE_EVENT(i915_gem_evict,
 
 	    TP_fast_assign(
 			   __entry->dev = vm->i915->drm.primary->index;
-			   __entry->vm = vm;
+			   __entry->vm = (unsigned long)vm;
 			   __entry->size = size;
 			   __entry->align = align;
 			   __entry->flags = flags;
 			  ),
 
 	    TP_printk("dev=%d, vm=%p, size=0x%llx, align=0x%llx %s",
-		      __entry->dev, __entry->vm, __entry->size, __entry->align,
+		      __entry->dev, (void *)__entry->vm, __entry->size, __entry->align,
 		      __entry->flags & PIN_MAPPABLE ? ", mappable" : "")
 );
 
@@ -620,7 +620,7 @@ TRACE_EVENT(i915_gem_evict_node,
 
 	    TP_STRUCT__entry(
 			     __field(u32, dev)
-			     __field(struct i915_address_space *, vm)
+			     __field(unsigned long, vm)
 			     __field(u64, start)
 			     __field(u64, size)
 			     __field(unsigned long, color)
@@ -629,7 +629,7 @@ TRACE_EVENT(i915_gem_evict_node,
 
 	    TP_fast_assign(
 			   __entry->dev = vm->i915->drm.primary->index;
-			   __entry->vm = vm;
+			   __entry->vm = (unsigned long)vm;
 			   __entry->start = node->start;
 			   __entry->size = node->size;
 			   __entry->color = node->color;
@@ -637,7 +637,7 @@ TRACE_EVENT(i915_gem_evict_node,
 			  ),
 
 	    TP_printk("dev=%d, vm=%p, start=0x%llx size=0x%llx, color=0x%lx, flags=%x",
-		      __entry->dev, __entry->vm,
+		      __entry->dev, (void *)__entry->vm,
 		      __entry->start, __entry->size,
 		      __entry->color, __entry->flags)
 );
@@ -648,15 +648,15 @@ TRACE_EVENT(i915_gem_evict_vm,
 
 	    TP_STRUCT__entry(
 			     __field(u32, dev)
-			     __field(struct i915_address_space *, vm)
+			     __field(unsigned long, vm)
 			    ),
 
 	    TP_fast_assign(
 			   __entry->dev = vm->i915->drm.primary->index;
-			   __entry->vm = vm;
+			   __entry->vm = (unsigned long)vm;
 			  ),
 
-	    TP_printk("dev=%d, vm=%p", __entry->dev, __entry->vm)
+	    TP_printk("dev=%d, vm=%p", __entry->dev, (void *)__entry->vm)
 );
 
 TRACE_EVENT(i915_request_queue,
@@ -922,16 +922,16 @@ DECLARE_EVENT_CLASS(i915_ppgtt,
 	TP_ARGS(vm),
 
 	TP_STRUCT__entry(
-			__field(struct i915_address_space *, vm)
+			__field(unsigned long, vm)
 			__field(u32, dev)
 	),
 
 	TP_fast_assign(
-			__entry->vm = vm;
+			__entry->vm = (unsigned long)vm;
 			__entry->dev = vm->i915->drm.primary->index;
 	),
 
-	TP_printk("dev=%u, vm=%p", __entry->dev, __entry->vm)
+	TP_printk("dev=%u, vm=%p", __entry->dev, (void *)__entry->vm)
 )
 
 DEFINE_EVENT(i915_ppgtt, i915_ppgtt_create,
@@ -957,20 +957,20 @@ DECLARE_EVENT_CLASS(i915_context,
 
 	TP_STRUCT__entry(
 			__field(u32, dev)
-			__field(struct i915_gem_context *, ctx)
+			__field(unsigned long, ctx)
 			__field(u32, hw_id)
-			__field(struct i915_address_space *, vm)
+			__field(unsigned long, vm)
 	),
 
 	TP_fast_assign(
 			__entry->dev = ctx->i915->drm.primary->index;
-			__entry->ctx = ctx;
+			__entry->ctx = (unsigned long)ctx;
 			__entry->hw_id = ctx->hw_id;
-			__entry->vm = ctx->vm;
+			__entry->vm = (unsigned long)ctx->vm;
 	),
 
 	TP_printk("dev=%u, ctx=%p, ctx_vm=%p, hw_id=%u",
-		  __entry->dev, __entry->ctx, __entry->vm, __entry->hw_id)
+		  __entry->dev, (void *)__entry->ctx, (void *)__entry->vm, __entry->hw_id)
 )
 
 DEFINE_EVENT(i915_context, i915_context_create,
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -31,7 +31,7 @@
  * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
  * credit to Christian Biere.
  */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
+#define is_signed_type(type)       ((type)-1 < 0)
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -546,7 +546,7 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-#define is_signed_type(type)	(((type)(-1)) < (type)1)
+#define is_signed_type(type)	((type)-1 < 0)
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
--- a/tools/include/linux/overflow.h
+++ b/tools/include/linux/overflow.h
@@ -31,7 +31,7 @@
  * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
  * credit to Christian Biere.
  */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
+#define is_signed_type(type)       ((type)-1 < 0)
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
