Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1D8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD12067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qM+Mr9vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfD2Sq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:46:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfD2Sqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:46:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIjjYU1031121
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:45:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIjjYU1031121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563547;
        bh=n959JXnlnzgMMELO7dGUaAVzvyrdlr/lYYqJFzXlbaw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qM+Mr9vknVB7gpr/HGzZgQKo4xwDHpFnJ/1gyibsoqgma+L49LhInQGOjaXXHAL8q
         MPmmQEvO8rAnxXGjkTNRexdxzBpZFAPFtzs9cXgGVLZtFos/PcW2NUuBx1A701D0Md
         e1xS0ydyYWNbx3bt78j2YaAUAuT13akD47bxbajCeC0yKCCS/rsflUjX7zIYLoKEW6
         D96JyUFCCA6TNLJ4425+AfGDcuS/vAuj/XuikQwyQjHmgguqD0nt6oE5jv+bU5iKoH
         QNhsf8Rlc6mwoo1peElCGCVVGzyIOj0YGrUsR/clhr0rEgYOuWd5p0HVh7AdZ+8Lgo
         LA9pHv19J3Maw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIjjUV1031117;
        Mon, 29 Apr 2019 11:45:45 -0700
Date:   Mon, 29 Apr 2019 11:45:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c438f140cc16d47fac808d893f5017f6d641cb46@git.kernel.org>
Cc:     penberg@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com, clm@fb.com,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        josef@toxicpanda.com, rientjes@google.com, akinobu.mita@gmail.com,
        mbenes@suse.cz, daniel@ffwll.ch, tglx@linutronix.de,
        dsterba@suse.com, airlied@linux.ie, dvyukov@google.com,
        hpa@zytor.com, akpm@linux-foundation.org,
        jani.nikula@linux.intel.com, glider@google.com, hch@lst.de,
        rppt@linux.vnet.ibm.com, catalin.marinas@arm.com,
        snitzer@redhat.com, agk@redhat.com, rodrigo.vivi@intel.com,
        adobriyan@gmail.com, joonas.lahtinen@linux.intel.com,
        robin.murphy@arm.com, m.szyprowski@samsung.com,
        tom.zanussi@linux.intel.com, jthumshirn@suse.de, cl@linux.com,
        maarten.lankhorst@linux.intel.com
Reply-To: maarten.lankhorst@linux.intel.com, cl@linux.com,
          jthumshirn@suse.de, tom.zanussi@linux.intel.com,
          m.szyprowski@samsung.com, robin.murphy@arm.com,
          joonas.lahtinen@linux.intel.com, adobriyan@gmail.com,
          rodrigo.vivi@intel.com, agk@redhat.com, catalin.marinas@arm.com,
          snitzer@redhat.com, rppt@linux.vnet.ibm.com, hch@lst.de,
          jani.nikula@linux.intel.com, glider@google.com,
          akpm@linux-foundation.org, hpa@zytor.com, dvyukov@google.com,
          airlied@linux.ie, dsterba@suse.com, tglx@linutronix.de,
          daniel@ffwll.ch, mbenes@suse.cz, akinobu.mita@gmail.com,
          rientjes@google.com, josef@toxicpanda.com, luto@kernel.org,
          jpoimboe@redhat.com, mingo@kernel.org, aryabinin@virtuozzo.com,
          clm@fb.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          penberg@kernel.org
In-Reply-To: <20190425094803.162400595@linutronix.de>
References: <20190425094803.162400595@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Make ftrace_trace_userstack() static
 and conditional
Git-Commit-ID: c438f140cc16d47fac808d893f5017f6d641cb46
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

Commit-ID:  c438f140cc16d47fac808d893f5017f6d641cb46
Gitweb:     https://git.kernel.org/tip/c438f140cc16d47fac808d893f5017f6d641cb46
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:55 +0200

tracing: Make ftrace_trace_userstack() static and conditional

It's only used in trace.c and there is absolutely no point in compiling it
in when user space stack traces are not supported.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
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
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094803.162400595@linutronix.de

---
 kernel/trace/trace.c | 14 ++++++++------
 kernel/trace/trace.h |  8 --------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4fc93004feab..d8369d27c1af 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -159,6 +159,8 @@ static union trace_eval_map_item *trace_eval_maps;
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
 static int tracing_set_tracer(struct trace_array *tr, const char *buf);
+static void ftrace_trace_userstack(struct ring_buffer *buffer,
+				   unsigned long flags, int pc);
 
 #define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
@@ -2905,9 +2907,10 @@ void trace_dump_stack(int skip)
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
+#ifdef CONFIG_USER_STACKTRACE_SUPPORT
 static DEFINE_PER_CPU(int, user_stack_count);
 
-void
+static void
 ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
 {
 	struct trace_event_call *call = &event_user_stack;
@@ -2958,13 +2961,12 @@ ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags, int pc)
  out:
 	preempt_enable();
 }
-
-#ifdef UNUSED
-static void __trace_userstack(struct trace_array *tr, unsigned long flags)
+#else /* CONFIG_USER_STACKTRACE_SUPPORT */
+static void ftrace_trace_userstack(struct ring_buffer *buffer,
+				   unsigned long flags, int pc)
 {
-	ftrace_trace_userstack(tr, flags, preempt_count());
 }
-#endif /* UNUSED */
+#endif /* !CONFIG_USER_STACKTRACE_SUPPORT */
 
 #endif /* CONFIG_STACKTRACE */
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..639047b259d7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -782,17 +782,9 @@ void update_max_tr_single(struct trace_array *tr,
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 #ifdef CONFIG_STACKTRACE
-void ftrace_trace_userstack(struct ring_buffer *buffer, unsigned long flags,
-			    int pc);
-
 void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
 		   int pc);
 #else
-static inline void ftrace_trace_userstack(struct ring_buffer *buffer,
-					  unsigned long flags, int pc)
-{
-}
-
 static inline void __trace_stack(struct trace_array *tr, unsigned long flags,
 				 int skip, int pc)
 {
