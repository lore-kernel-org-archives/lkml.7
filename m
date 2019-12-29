Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6179C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03A022525
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642065;
	bh=Qi68X8EwhjNhQItLrrrp7bt6hKwH5qQyWhw0sntgeU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=boufUtOo8SBGfHtzmXJgvChe7oEMP/k0MMA8sqeZ2HkxKJJh/5j5Mk3q+HpZ7APL6
	 9KgRcnk1oMiN/O8GJJnXQDs4f6+M6rENQgkJSLfLI4bNxfN/Dx0TJXJMmUKkegG+iF
	 7gK6CSscaC4Fwf+Tjpp0zQbxfuuR/5eW3d+GsKXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfL2RyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732674AbfL2RyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C645920748;
        Sun, 29 Dec 2019 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642060;
        bh=Qi68X8EwhjNhQItLrrrp7bt6hKwH5qQyWhw0sntgeU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qh6BdGJv68B/ttquu+HJ1i+WwcE/OLB7BbKHU0/w9u1XjiiyQ6JNXAOMuQPLrCABd
         dZcfiibEJBhrodomRkFmr3idypRnRWdZ5Kf0QW+j3T64dEzHWyg469t7R/VW/efXnR
         btGC43PWHkYOYT8bKAWeCwkrRGJ7ZIeNySl7Md9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 323/434] perf/core: Fix the mlock accounting, again
Date:   Sun, 29 Dec 2019 18:26:16 +0100
Message-Id: <20191229172723.424194731@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 36b3db03b4741b8935b68fffc7e69951d8d70a89 ]

Commit:

  5e6c3c7b1ec2 ("perf/aux: Fix tracking of auxiliary trace buffer allocation")

tried to guess the correct combination of arithmetic operations that would
undo the AUX buffer's mlock accounting, and failed, leaking the bottom part
when an allocation needs to be charged partially to both user->locked_vm
and mm->pinned_vm, eventually leaving the user with no locked bonus:

  $ perf record -e intel_pt//u -m1,128 uname
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.061 MB perf.data ]

  $ perf record -e intel_pt//u -m1,128 uname
  Permission error mapping pages.
  Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
  or try again with a smaller value of -m/--mmap_pages.
  (current value: 1,128)

Fix this by subtracting both locked and pinned counts when AUX buffer is
unmapped.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 00a014670ed0..8f66a4833ded 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5607,10 +5607,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		if (!rb->aux_mmap_locked)
-			atomic_long_sub(rb->aux_nr_pages, &mmap_user->locked_vm);
-		else
-			atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
-- 
2.20.1



