Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED752087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y7UJ5d8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfD2SoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:44:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2SoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:44:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIh7Bn1029077
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:43:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIh7Bn1029077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563388;
        bh=5x7RgpC5xVV3Sp9l8OUMDoq1riFwDMHdbJZ9xKnZIkM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y7UJ5d8X6Fkigen72e/k9xfFLLnkzAxjgSYc3ltTDOwBGPDVAcsmOOtO5cMGvEwEb
         38HnmXs+o6mSYC3/DS9e9CIaZ8ogJ7N1qKDJC6j0zeMRNbrxWvEYhvmKscvaqPMjjP
         EjdpzIOFCoEPAfHwHuoPCYPERGR++78Qwsw7iJ/dLgBDnBqHnEPbvnbSZ0FbbQk9Nm
         WqcD/lSMj5diVYztCRozprJ3UcQ2eTm8iF5a3iBMa6U84X/sy/BnzZarVaN0yQx5VA
         6+00/EZsEFHmcfxWQSGfeAzVpSU+iO85wycZtfd8Wtis2fOxcKkhDq3eiXiYR4Bc2b
         f86NVjtlhcFiw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIh6811029073;
        Mon, 29 Apr 2019 11:43:06 -0700
Date:   Mon, 29 Apr 2019 11:43:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-76b14436b4d98903fef723365170bedd6f28ab2c@git.kernel.org>
Cc:     josef@toxicpanda.com, m.szyprowski@samsung.com,
        tom.zanussi@linux.intel.com, jthumshirn@suse.de, luto@kernel.org,
        mbenes@suse.cz, adobriyan@gmail.com, dsterba@suse.com,
        maarten.lankhorst@linux.intel.com, dvyukov@google.com,
        aryabinin@virtuozzo.com, rientjes@google.com,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        mingo@kernel.org, daniel@ffwll.ch, robin.murphy@arm.com,
        hpa@zytor.com, clm@fb.com, catalin.marinas@arm.com,
        jani.nikula@linux.intel.com, glider@google.com,
        akpm@linux-foundation.org, jpoimboe@redhat.com, agk@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        penberg@kernel.org, tglx@linutronix.de, cl@linux.com,
        akinobu.mita@gmail.com, peterz@infradead.org, rostedt@goodmis.org,
        airlied@linux.ie, hch@lst.de, snitzer@redhat.com
Reply-To: daniel@ffwll.ch, mingo@kernel.org,
          joonas.lahtinen@linux.intel.com, robin.murphy@arm.com,
          hpa@zytor.com, clm@fb.com, tom.zanussi@linux.intel.com,
          m.szyprowski@samsung.com, josef@toxicpanda.com, mbenes@suse.cz,
          adobriyan@gmail.com, dsterba@suse.com, luto@kernel.org,
          jthumshirn@suse.de, rientjes@google.com, aryabinin@virtuozzo.com,
          dvyukov@google.com, maarten.lankhorst@linux.intel.com,
          rodrigo.vivi@intel.com, rppt@linux.vnet.ibm.com,
          jpoimboe@redhat.com, agk@redhat.com, penberg@kernel.org,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          peterz@infradead.org, akinobu.mita@gmail.com, cl@linux.com,
          tglx@linutronix.de, snitzer@redhat.com, hch@lst.de,
          airlied@linux.ie, catalin.marinas@arm.com,
          akpm@linux-foundation.org, glider@google.com,
          jani.nikula@linux.intel.com
In-Reply-To: <20190425094802.803362058@linutronix.de>
References: <20190425094802.803362058@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lockdep: Remove save argument from
 check_prev_add()
Git-Commit-ID: 76b14436b4d98903fef723365170bedd6f28ab2c
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

Commit-ID:  76b14436b4d98903fef723365170bedd6f28ab2c
Gitweb:     https://git.kernel.org/tip/76b14436b4d98903fef723365170bedd6f28ab2c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:53 +0200

lockdep: Remove save argument from check_prev_add()

There is only one caller which hands in save_trace as function pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
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
Link: https://lkml.kernel.org/r/20190425094802.803362058@linutronix.de

---
 kernel/locking/lockdep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d7615d299d08..3603893d5bbd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2158,8 +2158,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next,
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance, struct stack_trace *trace,
-	       int (*save)(struct stack_trace *trace))
+	       struct held_lock *next, int distance, struct stack_trace *trace)
 {
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
@@ -2199,11 +2198,11 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	if (unlikely(!ret)) {
 		if (!trace->entries) {
 			/*
-			 * If @save fails here, the printing might trigger
-			 * a WARN but because of the !nr_entries it should
-			 * not do bad things.
+			 * If save_trace fails here, the printing might
+			 * trigger a WARN but because of the !nr_entries it
+			 * should not do bad things.
 			 */
-			save(trace);
+			save_trace(trace);
 		}
 		return print_circular_bug(&this, target_entry, next, prev);
 	}
@@ -2253,7 +2252,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return print_bfs_bug(ret);
 
 
-	if (!trace->entries && !save(trace))
+	if (!trace->entries && !save_trace(trace))
 		return 0;
 
 	/*
@@ -2318,7 +2317,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		 * added:
 		 */
 		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance, &trace, save_trace);
+			int ret = check_prev_add(curr, hlock, next, distance,
+						 &trace);
 			if (!ret)
 				return 0;
 
