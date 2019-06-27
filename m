Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A0C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC58D2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DP1H8WGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF0WXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:23:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:23:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMM20M474297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:22:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMM20M474297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561674122;
        bh=ZeyvB4LFyjvlaOlXgO/EO++131ZgvyCNUdJVBPCe35s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DP1H8WGKHAKzhFwjNdjuekq3kI2uJ/FiGWO7ogstevfeHlwnLmbijd9dlNHKJHIKL
         cbO54/jKZlsFXhyaNWsYGr7LpbQVhEXhFa0dA0haN8Vg/Aq3inIS7+gYX6NfdYHdMf
         HHDoX243rMGSuXSFJe3m039g2LQFSmqDY80lU6IVWFy2fAMyTpDA+LDGtQVu/72cZm
         k97koBVziSFnxf/p5qyTxzjfEnjOGOdkKLM8Efb0c31/oNkqFOcsA90GDy9FI9EhCC
         4ZHF8u+xTpM01GG01Oc4SK3SoHA6Q9jn2NtdwE03WuMydLGAGkbvk5lRn0Qw0v9PVm
         UCishPIaNaNtQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMM17R474294;
        Thu, 27 Jun 2019 15:22:01 -0700
Date:   Thu, 27 Jun 2019 15:22:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-83f44ae0f8afcc9da659799db8693f74847e66b3@git.kernel.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de, songliubraving@fb.com,
        kasong@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        bp@alien8.de, mingo@kernel.org
Reply-To: mingo@kernel.org, bp@alien8.de, rostedt@goodmis.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, kasong@redhat.com, songliubraving@fb.com,
          tglx@linutronix.de, jpoimboe@redhat.com
In-Reply-To: <3975a298fa52b506fea32666d8ff6a13467eee6d.1561595111.git.jpoimboe@redhat.com>
References: <3975a298fa52b506fea32666d8ff6a13467eee6d.1561595111.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] perf/x86: Always store regs->ip in
 perf_callchain_kernel()
Git-Commit-ID: 83f44ae0f8afcc9da659799db8693f74847e66b3
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

Commit-ID:  83f44ae0f8afcc9da659799db8693f74847e66b3
Gitweb:     https://git.kernel.org/tip/83f44ae0f8afcc9da659799db8693f74847e66b3
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Wed, 26 Jun 2019 19:33:52 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:11:20 +0200

perf/x86: Always store regs->ip in perf_callchain_kernel()

The stacktrace_map_raw_tp BPF selftest is failing because the RIP saved by
perf_arch_fetch_caller_regs() isn't getting saved by perf_callchain_kernel().

This was broken by the following commit:

  d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")

With that change, when starting with non-HW regs, the unwinder starts
with the current stack frame and unwinds until it passes up the frame
which called perf_arch_fetch_caller_regs().  So regs->ip needs to be
saved deliberately.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kairui Song <kasong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/3975a298fa52b506fea32666d8ff6a13467eee6d.1561595111.git.jpoimboe@redhat.com

---
 arch/x86/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..4fb3ca1e699d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2402,13 +2402,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
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
