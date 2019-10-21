Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B675ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F3C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJUJfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:35:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJUJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:35:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMU5h-0005uz-5H; Mon, 21 Oct 2019 11:35:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C7EF1C0092;
        Mon, 21 Oct 2019 11:35:04 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:35:04 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Fix tracking of auxiliary trace buffer
 allocation
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        gor@linux.ibm.com, hechaol@fb.com, heiko.carstens@de.ibm.com,
        linux-perf-users@vger.kernel.org, songliubraving@fb.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191021083354.67868-1-tmricht@linux.ibm.com>
References: <20191021083354.67868-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157165050422.29376.10692255781840811810.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5e6c3c7b1ec217c1c4c95d9148182302b9969b97
Gitweb:        https://git.kernel.org/tip/5e6c3c7b1ec217c1c4c95d9148182302b9969b97
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Mon, 21 Oct 2019 10:33:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 11:31:24 +02:00

perf/aux: Fix tracking of auxiliary trace buffer allocation

The following commit from the v5.4 merge window:

  d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")

... breaks auxiliary trace buffer tracking.

If I run command 'perf record -e rbd000' to record samples and saving
them in the **auxiliary** trace buffer then the value of 'locked_vm' becomes
negative after all trace buffers have been allocated and released:

During allocation the values increase:

  [52.250027] perf_mmap user->locked_vm:0x87 pinned_vm:0x0 ret:0
  [52.250115] perf_mmap user->locked_vm:0x107 pinned_vm:0x0 ret:0
  [52.250251] perf_mmap user->locked_vm:0x188 pinned_vm:0x0 ret:0
  [52.250326] perf_mmap user->locked_vm:0x208 pinned_vm:0x0 ret:0
  [52.250441] perf_mmap user->locked_vm:0x289 pinned_vm:0x0 ret:0
  [52.250498] perf_mmap user->locked_vm:0x309 pinned_vm:0x0 ret:0
  [52.250613] perf_mmap user->locked_vm:0x38a pinned_vm:0x0 ret:0
  [52.250715] perf_mmap user->locked_vm:0x408 pinned_vm:0x2 ret:0
  [52.250834] perf_mmap user->locked_vm:0x408 pinned_vm:0x83 ret:0
  [52.250915] perf_mmap user->locked_vm:0x408 pinned_vm:0x103 ret:0
  [52.251061] perf_mmap user->locked_vm:0x408 pinned_vm:0x184 ret:0
  [52.251146] perf_mmap user->locked_vm:0x408 pinned_vm:0x204 ret:0
  [52.251299] perf_mmap user->locked_vm:0x408 pinned_vm:0x285 ret:0
  [52.251383] perf_mmap user->locked_vm:0x408 pinned_vm:0x305 ret:0
  [52.251544] perf_mmap user->locked_vm:0x408 pinned_vm:0x386 ret:0
  [52.251634] perf_mmap user->locked_vm:0x408 pinned_vm:0x406 ret:0
  [52.253018] perf_mmap user->locked_vm:0x408 pinned_vm:0x487 ret:0
  [52.253197] perf_mmap user->locked_vm:0x408 pinned_vm:0x508 ret:0
  [52.253374] perf_mmap user->locked_vm:0x408 pinned_vm:0x589 ret:0
  [52.253550] perf_mmap user->locked_vm:0x408 pinned_vm:0x60a ret:0
  [52.253726] perf_mmap user->locked_vm:0x408 pinned_vm:0x68b ret:0
  [52.253903] perf_mmap user->locked_vm:0x408 pinned_vm:0x70c ret:0
  [52.254084] perf_mmap user->locked_vm:0x408 pinned_vm:0x78d ret:0
  [52.254263] perf_mmap user->locked_vm:0x408 pinned_vm:0x80e ret:0

The value of user->locked_vm increases to a limit then the memory
is tracked by pinned_vm.

During deallocation the size is subtracted from pinned_vm until
it hits a limit. Then a larger value is subtracted from locked_vm
leading to a large number (because of type unsigned):

  [64.267797] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x78d
  [64.267826] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x70c
  [64.267848] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x68b
  [64.267869] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x60a
  [64.267891] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x589
  [64.267911] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x508
  [64.267933] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x487
  [64.267952] perf_mmap_close mmap_user->locked_vm:0x408 pinned_vm:0x406
  [64.268883] perf_mmap_close mmap_user->locked_vm:0x307 pinned_vm:0x406
  [64.269117] perf_mmap_close mmap_user->locked_vm:0x206 pinned_vm:0x406
  [64.269433] perf_mmap_close mmap_user->locked_vm:0x105 pinned_vm:0x406
  [64.269536] perf_mmap_close mmap_user->locked_vm:0x4 pinned_vm:0x404
  [64.269797] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff84 pinned_vm:0x303
  [64.270105] perf_mmap_close mmap_user->locked_vm:0xffffffffffffff04 pinned_vm:0x202
  [64.270374] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe84 pinned_vm:0x101
  [64.270628] perf_mmap_close mmap_user->locked_vm:0xfffffffffffffe04 pinned_vm:0x0

This value sticks for the user until system is rebooted, causing
follow-on system calls using locked_vm resource limit to fail.

Note: There is no issue using the normal trace buffer.

In fact the issue is in perf_mmap_close(). During allocation auxiliary
trace buffer memory is either traced as 'extra' and added to 'pinned_vm'
or trace as 'user_extra' and added to 'locked_vm'. This applies for
normal trace buffers and auxiliary trace buffer.

However in function perf_mmap_close() all auxiliary trace buffer is
subtraced from 'locked_vm' and never from 'pinned_vm'. This breaks the
ballance.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: gor@linux.ibm.com
Cc: hechaol@fb.com
Cc: heiko.carstens@de.ibm.com
Cc: linux-perf-users@vger.kernel.org
Cc: songliubraving@fb.com
Fixes: d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")
Link: https://lkml.kernel.org/r/20191021083354.67868-1-tmricht@linux.ibm.com
[ Minor readability edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0b..f5d7950 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5607,8 +5607,10 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		if (!rb->aux_mmap_locked)
+			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
+		else
+			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
