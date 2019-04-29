Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92432C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BB42087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uiD/Ctab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfD2SiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:38:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfD2SiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:38:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIasuu1027946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:36:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIasuu1027946
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563016;
        bh=Yv9s1qpvy0g1poUHMCc65+CrVmj3owy9Ycioxh9MJ/A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uiD/CtabshMknphkd0HuWvFmvdgMQTrfRCDE8iYRlm/dcqQlBom/6gTdVzs7d5wrT
         7gjZjeT+TXWwm8jZnpnRAAUq5vYqWgoCLytLWHXrKHb7/2HCkVLsF40DFg3R1EQ6EK
         DCkssBMvpEbE+e7kDFpWZP2AsCVKaLtoDKQzvMUPyOVoDtpre7U0s7rNkk/ipLS7yM
         zAkAJkNCJcWhn9hGabQqk+qxiS9Rk7vrWkcXUHH1zKI2wFz1qeaPxGv56wnQhz7IVb
         KiJlu/l+vUIpC1zocjtLjIB7vr7Upq5x7aLXS/6UGvc3O/FPPLktmaXIfiYrjzmxJU
         KdM1m9a2sT1ew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIasaS1027942;
        Mon, 29 Apr 2019 11:36:54 -0700
Date:   Mon, 29 Apr 2019 11:36:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-880e049c9ce9020384ce305c71375aa1cb54addb@git.kernel.org>
Cc:     agk@redhat.com, jani.nikula@linux.intel.com, rostedt@goodmis.org,
        dsterba@suse.com, mbenes@suse.cz, joonas.lahtinen@linux.intel.com,
        jthumshirn@suse.de, rodrigo.vivi@intel.com, clm@fb.com,
        adobriyan@gmail.com, airlied@linux.ie, rientjes@google.com,
        mingo@kernel.org, cl@linux.com, rppt@linux.vnet.ibm.com,
        aryabinin@virtuozzo.com, hpa@zytor.com, tglx@linutronix.de,
        dvyukov@google.com, tom.zanussi@linux.intel.com, luto@kernel.org,
        hch@lst.de, akpm@linux-foundation.org, robin.murphy@arm.com,
        catalin.marinas@arm.com, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch, penberg@kernel.org, m.szyprowski@samsung.com,
        akinobu.mita@gmail.com, glider@google.com, josef@toxicpanda.com,
        snitzer@redhat.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Reply-To: rientjes@google.com, mingo@kernel.org, airlied@linux.ie,
          adobriyan@gmail.com, tglx@linutronix.de, hpa@zytor.com,
          cl@linux.com, aryabinin@virtuozzo.com, rppt@linux.vnet.ibm.com,
          rostedt@goodmis.org, mbenes@suse.cz, dsterba@suse.com,
          agk@redhat.com, jani.nikula@linux.intel.com,
          rodrigo.vivi@intel.com, clm@fb.com,
          joonas.lahtinen@linux.intel.com, jthumshirn@suse.de,
          akinobu.mita@gmail.com, m.szyprowski@samsung.com,
          penberg@kernel.org, daniel@ffwll.ch,
          maarten.lankhorst@linux.intel.com, snitzer@redhat.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          glider@google.com, josef@toxicpanda.com, dvyukov@google.com,
          luto@kernel.org, tom.zanussi@linux.intel.com, hch@lst.de,
          catalin.marinas@arm.com, robin.murphy@arm.com,
          akpm@linux-foundation.org
In-Reply-To: <20190425094801.963261479@linutronix.de>
References: <20190425094801.963261479@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/kasan: Simplify stacktrace handling
Git-Commit-ID: 880e049c9ce9020384ce305c71375aa1cb54addb
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

Commit-ID:  880e049c9ce9020384ce305c71375aa1cb54addb
Gitweb:     https://git.kernel.org/tip/880e049c9ce9020384ce305c71375aa1cb54addb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:49 +0200

mm/kasan: Simplify stacktrace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
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
Link: https://lkml.kernel.org/r/20190425094801.963261479@linutronix.de

---
 mm/kasan/common.c | 30 ++++++++++++------------------
 mm/kasan/report.c |  7 ++++---
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 38e5f20a775a..303a7379d2a3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -48,34 +48,28 @@ static inline int in_irqentry_text(unsigned long ptr)
 		 ptr < (unsigned long)&__softirqentry_text_end);
 }
 
-static inline void filter_irq_stacks(struct stack_trace *trace)
+static inline unsigned int filter_irq_stacks(unsigned long *entries,
+					     unsigned int nr_entries)
 {
-	int i;
+	unsigned int i;
 
-	if (!trace->nr_entries)
-		return;
-	for (i = 0; i < trace->nr_entries; i++)
-		if (in_irqentry_text(trace->entries[i])) {
+	for (i = 0; i < nr_entries; i++) {
+		if (in_irqentry_text(entries[i])) {
 			/* Include the irqentry function into the stack. */
-			trace->nr_entries = i + 1;
-			break;
+			return i + 1;
 		}
+	}
+	return nr_entries;
 }
 
 static inline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = KASAN_STACK_DEPTH,
-		.skip = 0
-	};
-
-	save_stack_trace(&trace);
-	filter_irq_stacks(&trace);
+	unsigned int nr_entries;
 
-	return depot_save_stack(&trace, flags);
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	nr_entries = filter_irq_stacks(entries, nr_entries);
+	return stack_depot_save(entries, nr_entries, flags);
 }
 
 static inline void set_track(struct kasan_track *track, gfp_t flags)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ca9418fe9232..882d77568e7e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -100,10 +100,11 @@ static void print_track(struct kasan_track *track, const char *prefix)
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
 	if (track->stack) {
-		struct stack_trace trace;
+		unsigned long *entries;
+		unsigned int nr_entries;
 
-		depot_fetch_stack(track->stack, &trace);
-		print_stack_trace(&trace, 0);
+		nr_entries = stack_depot_fetch(track->stack, &entries);
+		stack_trace_print(entries, nr_entries, 0);
 	} else {
 		pr_err("(stack is not available)\n");
 	}
