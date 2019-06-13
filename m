Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EFEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B73121743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfFMPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfFMNXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 010313003A59;
        Thu, 13 Jun 2019 13:23:35 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D270C541C7;
        Thu, 13 Jun 2019 13:23:33 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH 1/9] perf/x86: Always store regs->ip in perf_callchain_kernel()
Date:   Thu, 13 Jun 2019 08:20:58 -0500
Message-Id: <3fc9271e95c87a4c31d8184514b8667007cb9540.1560431531.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1560431531.git.jpoimboe@redhat.com>
References: <cover.1560431531.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Jun 2019 13:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

The stacktrace_map_raw_tp BPF selftest is failing because the RIP saved
by perf_arch_fetch_caller_regs() isn't getting saved by
perf_callchain_kernel().

This was broken by the following commit:

  d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")

With that change, when starting with non-HW regs, the unwinder starts
with the current stack frame and unwinds until it passes up the frame
which called perf_arch_fetch_caller_regs().  So regs->ip needs to be
saved deliberately.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f0e4804515d8..6a7cfcadfc1e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2328,13 +2328,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
-	if (perf_hw_regs(regs)) {
-		if (perf_callchain_store(entry, regs->ip))
-			return;
+	if (perf_callchain_store(entry, regs->ip))
+		return;
+
+	if (perf_hw_regs(regs))
 		unwind_start(&state, current, regs, NULL);
-	} else {
+	else
 		unwind_start(&state, current, NULL, (void *)regs->sp);
-	}
 
 	for (; !unwind_done(&state); unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-- 
2.20.1

