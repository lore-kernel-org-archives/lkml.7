Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D202087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TxqDVCqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfD2SgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:36:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfD2SgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:36:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIY4xt1027426
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:34:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIY4xt1027426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562846;
        bh=uGhRrBEi1YNNPN8TxqtJSVK34cBbivGWjFJpud1Vm1c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TxqDVCqh2N7q15VWeqFjdvUHlBWXLphe1suKh2bbUVmf8WTUxozz6moySYFjbn54d
         zaUKr5zdy0ctoRwsjRolJNMOqHifYGgMlizfB8Ob7iBmGAOKe1oKET6/i3261vUWTP
         MPrReanYnmHGp1u7buTQaHUuJt923fij37n3rUIUEID48HtgMSkrdE1HU6UG6xcAob
         W5tSrqwciea1OsytlFZG6Xk0g9hAwD70Z1Fu8PKd9Bq7S7qW19dw3pJI6ng04my8/w
         mgs7sRIWYL4nyaimeFlSINk5NEOm7aaErLiVR0Vf02n+7grJWOFthSAbvDe0bJuZi0
         IVMB2tnZV6RGg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIY3jV1027422;
        Mon, 29 Apr 2019 11:34:03 -0700
Date:   Mon, 29 Apr 2019 11:34:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e988e5ec18d6081efbef645fc2690298ee23a8db@git.kernel.org>
Cc:     tglx@linutronix.de, tom.zanussi@linux.intel.com,
        robin.murphy@arm.com, mingo@kernel.org, snitzer@redhat.com,
        clm@fb.com, luto@kernel.org, jthumshirn@suse.de, hpa@zytor.com,
        josef@toxicpanda.com, aryabinin@virtuozzo.com, hch@lst.de,
        linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com,
        rientjes@google.com, catalin.marinas@arm.com, rostedt@goodmis.org,
        dsterba@suse.com, penberg@kernel.org, mbenes@suse.cz,
        akpm@linux-foundation.org, joonas.lahtinen@linux.intel.com,
        daniel@ffwll.ch, jpoimboe@redhat.com, agk@redhat.com,
        rppt@linux.vnet.ibm.com, cl@linux.com, airlied@linux.ie,
        akinobu.mita@gmail.com, adobriyan@gmail.com,
        jani.nikula@linux.intel.com, glider@google.com,
        maarten.lankhorst@linux.intel.com, m.szyprowski@samsung.com,
        dvyukov@google.com
Reply-To: joonas.lahtinen@linux.intel.com, daniel@ffwll.ch,
          jpoimboe@redhat.com, akpm@linux-foundation.org,
          catalin.marinas@arm.com, rostedt@goodmis.org, dsterba@suse.com,
          penberg@kernel.org, mbenes@suse.cz, linux-kernel@vger.kernel.org,
          rientjes@google.com, rodrigo.vivi@intel.com, dvyukov@google.com,
          jani.nikula@linux.intel.com, glider@google.com,
          maarten.lankhorst@linux.intel.com, m.szyprowski@samsung.com,
          airlied@linux.ie, akinobu.mita@gmail.com, adobriyan@gmail.com,
          agk@redhat.com, rppt@linux.vnet.ibm.com, cl@linux.com,
          clm@fb.com, robin.murphy@arm.com, snitzer@redhat.com,
          mingo@kernel.org, tglx@linutronix.de,
          tom.zanussi@linux.intel.com, hch@lst.de, josef@toxicpanda.com,
          aryabinin@virtuozzo.com, luto@kernel.org, hpa@zytor.com,
          jthumshirn@suse.de
In-Reply-To: <20190425094801.589304463@linutronix.de>
References: <20190425094801.589304463@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] proc: Simplify task stack retrieval
Git-Commit-ID: e988e5ec18d6081efbef645fc2690298ee23a8db
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

Commit-ID:  e988e5ec18d6081efbef645fc2690298ee23a8db
Gitweb:     https://git.kernel.org/tip/e988e5ec18d6081efbef645fc2690298ee23a8db
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:48 +0200

proc: Simplify task stack retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
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
Link: https://lkml.kernel.org/r/20190425094801.589304463@linutronix.de

---
 fs/proc/base.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5569f215fc54..f179568b4c76 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -407,7 +407,6 @@ static void unlock_trace(struct task_struct *task)
 static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	struct stack_trace trace;
 	unsigned long *entries;
 	int err;
 
@@ -430,20 +429,17 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
 	if (!entries)
 		return -ENOMEM;
 
-	trace.nr_entries	= 0;
-	trace.max_entries	= MAX_STACK_TRACE_DEPTH;
-	trace.entries		= entries;
-	trace.skip		= 0;
-
 	err = lock_trace(task);
 	if (!err) {
-		unsigned int i;
+		unsigned int i, nr_entries;
 
-		save_stack_trace_tsk(task, &trace);
+		nr_entries = stack_trace_save_tsk(task, entries,
+						  MAX_STACK_TRACE_DEPTH, 0);
 
-		for (i = 0; i < trace.nr_entries; i++) {
+		for (i = 0; i < nr_entries; i++) {
 			seq_printf(m, "[<0>] %pB\n", (void *)entries[i]);
 		}
+
 		unlock_trace(task);
 	}
 	kfree(entries);
