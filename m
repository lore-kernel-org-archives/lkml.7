Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C16DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F722087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TycfkZor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfD2SnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:43:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfD2SnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:43:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIflTo1028667
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:41:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIflTo1028667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563309;
        bh=PMdREJg1WMpV+hP2zxMZsYKdiGZN9LGo/wO162TcVwI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TycfkZori0NML3vhK4cIt+4tF0z9gwpbPYi42CrT3aZKUbycY/PaAufyrqknSx+aC
         hXAIAR0QfiBOK+C3N2JPGpAJud348+dNq1ekaXBnyeBka71shj/pvcbI5Qv5fVnncs
         bf/t5JdXKR/OsF8wn55VNC8zK68RW6j30ujuNv1lnu9dEK4NES5iG7L92tPmsXBj0W
         GE3u+6P/p8njzwPSHzfXLh5MTy3ZTSsk50DQn8+v6CcNrRy74bHIAhxkGutULrdg7q
         /l8Y2iQMVtxktfsuhoedldD4pvLyo5f8pVFygZIi6sfGB/LPvJQlCKEZPh/22ktsYr
         fGG7iwozZoz4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIflta1028663;
        Mon, 29 Apr 2019 11:41:47 -0700
Date:   Mon, 29 Apr 2019 11:41:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-487f3c7fb1a07ceff78bb18688eb8538a4775227@git.kernel.org>
Cc:     rodrigo.vivi@intel.com, dsterba@suse.com,
        tom.zanussi@linux.intel.com, akinobu.mita@gmail.com,
        maarten.lankhorst@linux.intel.com, adobriyan@gmail.com,
        jthumshirn@suse.de, daniel@ffwll.ch, mbenes@suse.cz, hpa@zytor.com,
        glider@google.com, rppt@linux.vnet.ibm.com, snitzer@redhat.com,
        akpm@linux-foundation.org, hch@lst.de, jpoimboe@redhat.com,
        joonas.lahtinen@linux.intel.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, rientjes@google.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, mingo@kernel.org, penberg@kernel.org,
        clm@fb.com, tglx@linutronix.de, agk@redhat.com,
        josef@toxicpanda.com, luto@kernel.org, m.szyprowski@samsung.com,
        cl@linux.com, dvyukov@google.com, rostedt@goodmis.org,
        jani.nikula@linux.intel.com, aryabinin@virtuozzo.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, airlied@linux.ie,
          rientjes@google.com, catalin.marinas@arm.com,
          joonas.lahtinen@linux.intel.com, robin.murphy@arm.com,
          clm@fb.com, agk@redhat.com, tglx@linutronix.de,
          penberg@kernel.org, luto@kernel.org, josef@toxicpanda.com,
          aryabinin@virtuozzo.com, dvyukov@google.com, rostedt@goodmis.org,
          jani.nikula@linux.intel.com, m.szyprowski@samsung.com,
          cl@linux.com, akinobu.mita@gmail.com,
          maarten.lankhorst@linux.intel.com, tom.zanussi@linux.intel.com,
          rodrigo.vivi@intel.com, dsterba@suse.com, jthumshirn@suse.de,
          adobriyan@gmail.com, glider@google.com, mbenes@suse.cz,
          hpa@zytor.com, daniel@ffwll.ch, jpoimboe@redhat.com, hch@lst.de,
          akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
          snitzer@redhat.com
In-Reply-To: <20190425094802.622094226@linutronix.de>
References: <20190425094802.622094226@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] drm: Simplify stacktrace handling
Git-Commit-ID: 487f3c7fb1a07ceff78bb18688eb8538a4775227
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  487f3c7fb1a07ceff78bb18688eb8538a4775227
Gitweb:     https://git.kernel.org/tip/487f3c7fb1a07ceff78bb18688eb8538a4775227
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:53 +0200

drm: Simplify stacktrace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

The original code in all printing functions is really wrong. It allocates a
storage array on stack which is unused because depot_fetch_stack() does not
store anything in it. It overwrites the entries pointer in the stack_trace
struct so it points to the depot storage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094802.622094226@linutronix.de

---
 drivers/gpu/drm/drm_mm.c                | 22 +++++++---------------
 drivers/gpu/drm/i915/i915_vma.c         | 11 ++++-------
 drivers/gpu/drm/i915/intel_runtime_pm.c | 21 +++++++--------------
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 69552777e13a..8b4cd31ce7bd 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -106,22 +106,19 @@
 static noinline void save_stack(struct drm_mm_node *node)
 {
 	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = STACKDEPTH,
-		.skip = 1
-	};
+	unsigned int n;
 
-	save_stack_trace(&trace);
+	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 
 	/* May be called under spinlock, so avoid sleeping */
-	node->stack = depot_save_stack(&trace, GFP_NOWAIT);
+	node->stack = stack_depot_save(entries, n, GFP_NOWAIT);
 }
 
 static void show_leaks(struct drm_mm *mm)
 {
 	struct drm_mm_node *node;
-	unsigned long entries[STACKDEPTH];
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char *buf;
 
 	buf = kmalloc(BUFSZ, GFP_KERNEL);
@@ -129,19 +126,14 @@ static void show_leaks(struct drm_mm *mm)
 		return;
 
 	list_for_each_entry(node, drm_mm_nodes(mm), node_list) {
-		struct stack_trace trace = {
-			.entries = entries,
-			.max_entries = STACKDEPTH
-		};
-
 		if (!node->stack) {
 			DRM_ERROR("node [%08llx + %08llx]: unknown owner\n",
 				  node->start, node->size);
 			continue;
 		}
 
-		depot_fetch_stack(node->stack, &trace);
-		snprint_stack_trace(buf, BUFSZ, &trace, 0);
+		nr_entries = stack_depot_fetch(node->stack, &entries);
+		stack_trace_snprint(buf, BUFSZ, entries, nr_entries, 0);
 		DRM_ERROR("node [%08llx + %08llx]: inserted at\n%s",
 			  node->start, node->size, buf);
 	}
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index b713bed20c38..41b5bcb803cb 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -36,11 +36,8 @@
 
 static void vma_print_allocator(struct i915_vma *vma, const char *reason)
 {
-	unsigned long entries[12];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-	};
+	unsigned long *entries;
+	unsigned int nr_entries;
 	char buf[512];
 
 	if (!vma->node.stack) {
@@ -49,8 +46,8 @@ static void vma_print_allocator(struct i915_vma *vma, const char *reason)
 		return;
 	}
 
-	depot_fetch_stack(vma->node.stack, &trace);
-	snprint_stack_trace(buf, sizeof(buf), &trace, 0);
+	nr_entries = stack_depot_fetch(vma->node.stack, &entries);
+	stack_trace_snprint(buf, sizeof(buf), entries, nr_entries, 0);
 	DRM_DEBUG_DRIVER("vma.node [%08llx + %08llx] %s: inserted at %s\n",
 			 vma->node.start, vma->node.size, reason, buf);
 }
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 1f8acbb332c9..20c4434474e3 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -60,27 +60,20 @@
 static noinline depot_stack_handle_t __save_depot_stack(void)
 {
 	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-		.skip = 1,
-	};
+	unsigned int n;
 
-	save_stack_trace(&trace);
-	return depot_save_stack(&trace, GFP_NOWAIT | __GFP_NOWARN);
+	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
+	return stack_depot_save(entries, n, GFP_NOWAIT | __GFP_NOWARN);
 }
 
 static void __print_depot_stack(depot_stack_handle_t stack,
 				char *buf, int sz, int indent)
 {
-	unsigned long entries[STACKDEPTH];
-	struct stack_trace trace = {
-		.entries = entries,
-		.max_entries = ARRAY_SIZE(entries),
-	};
+	unsigned long *entries;
+	unsigned int nr_entries;
 
-	depot_fetch_stack(stack, &trace);
-	snprint_stack_trace(buf, sz, &trace, indent);
+	nr_entries = stack_depot_fetch(stack, &entries);
+	stack_trace_snprint(buf, sz, entries, nr_entries, indent);
 }
 
 static void init_intel_runtime_pm_wakeref(struct drm_i915_private *i915)
