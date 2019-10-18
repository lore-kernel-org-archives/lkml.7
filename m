Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71782CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2BB21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1CsJy5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442254AbfJRI4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:56:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37673 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:56:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id n17so8042854qtr.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmDzTeY3CiACq15/Bx/rwtvcb3Fz1hiuxWty6anzD54=;
        b=v1CsJy5ZeASy786vCf6HHlz7oLFg3UVvKEFm/RVhb0CExXVXw1CopZem87PYLnPmRl
         7ijznXPsyC4Ry7yhh+Et6tRPEccPHBxYpRvKBCnupSXE59r5XftU4dKtPP2k19t9wFpt
         kYZInbvlu2ycsefybi04TGAyQQAheQSEITk0L4dbl45z18S1mTjXyb5Xe+U2M21/p1zI
         6pitk9736k1Vzr4/ZpMsyb10cqRDXHV7SWjYK9Eyu9emJiayf53yVjcjc62Fn6BP4/pT
         /b0AxeUjXrm95pDBIL4iQOZWZa8O3I0kATFLalqzS1tbTXFCmm5+Yxty2xgi57NkNN3f
         2bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmDzTeY3CiACq15/Bx/rwtvcb3Fz1hiuxWty6anzD54=;
        b=uWtukTh2+ZXUSRzaKOEXjZS23MKT5TY66xV8XDTTRKFCAS16ASRWiKVRrZGNZLTepP
         2m6p4mw/D31wXN8LWjJBZdpMOru1z7jQGj+INxycz4hGCGrpaXC+rLPauqnis9X6/jtZ
         AvLE/3sUX5LSPPXtb1ZzxaJD7giWY+3vcVe+SiPE+AKAWsPtyneeluYtJbCukO3XroKR
         gtQomsxX1vQSFaeSMQ8n5y+1tHqP7I06BLtdqwxA0eSDQJ+/5xHbs6/afBCpTxr1FkqE
         vtaXz4MdhLOy54htDhOHDhxr3O2lhsqy+jYR4dm4LJcALLEwWXcNO+Cs6DhGBjqwWNR3
         Fw2A==
X-Gm-Message-State: APjAAAVu7b7sbt+bw2RJWOM8r5IewHvakYtbo83di4ZcT2lwSyDy3Vo3
        o/fpb5k7petuhog9CNCI52gV9A==
X-Google-Smtp-Source: APXvYqyKVHxcg7Cni1o7nhNxktnAXbHi42IuCaA4fCfqPOf/12Z7qnTJERpJVBUJ1+te6zYnDqtkHw==
X-Received: by 2002:a0c:c3c4:: with SMTP id p4mr8762728qvi.178.1571388996362;
        Fri, 18 Oct 2019 01:56:36 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id a134sm3076571qkc.95.2019.10.18.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:56:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/3] perf tests: Disable bp_signal testing for arm64
Date:   Fri, 18 Oct 2019 16:55:31 +0800
Message-Id: <20191018085531.6348-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018085531.6348-1-leo.yan@linaro.org>
References: <20191018085531.6348-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there have several discussions for enabling Perf breakpoint signal
testing on arm64 platform; arm64 needs to rely on single-step to execute
the breakpointed instruction and then reinstall the breakpoint exception
handler.  But if hook the breakpoint with a signal, the signal handler
will do the stepping rather than the breakpointed instruction, this
causes infinite loops as below:

         Kernel space              |            Userspace
-----------------------------------|--------------------------------
                                   |  __test_function() -> hit
				   |                       breakpoint
  breakpoint_handler()             |
    `-> user_enable_single_step()  |
  do_signal()                      |
                                   |  sig_handler() -> Step one
				   |                instruction and
				   |                trap to kernel
  single_step_handler()            |
    `-> reinstall_suspended_bps()  |
                                   |  __test_function() -> hit
				   |     breakpoint again and
				   |     repeat up flow infinitely

As Will Deacon mentioned [1]: "that we require the overflow handler to
do the stepping on arm/arm64, which is relied upon by GDB/ptrace. The
hw_breakpoint code is a complete disaster so my preference would be to
rip out the perf part and just implement something directly in ptrace,
but it's a pretty horrible job".  Though Will commented this on arm
architecture, but the comment also can apply on arm64 architecture.

For complete information, I searched online and found a few years back,
Wang Nan sent one patch 'arm64: Store breakpoint single step state into
pstate' [2]; the patch tried to resolve this issue by avoiding single
stepping in signal handler and defer to enable the signal stepping when
return to __test_function().  The fixing was not merged due to the
concern for missing to handle different usage cases.

Based on the info, the most feasible way is to skip Perf breakpoint
signal testing for arm64 and this could avoid the duplicate
investigation efforts when people see the failure.  This patch skips
this case on arm64 platform, which is same with arm architecture.

[1] https://lkml.org/lkml/2018/11/15/205
[2] https://lkml.org/lkml/2015/12/23/477

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/bp_signal.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index c1c2c13de254..166f411568a5 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -49,14 +49,6 @@ asm (
 	"__test_function:\n"
 	"incq (%rdi)\n"
 	"ret\n");
-#elif defined (__aarch64__)
-extern void __test_function(volatile long *ptr);
-asm (
-	".globl __test_function\n"
-	"__test_function:\n"
-	"str x30, [x0]\n"
-	"ret\n");
-
 #else
 static void __test_function(volatile long *ptr)
 {
@@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
 	 * stepping into the SIGIO handler and getting stuck on the
 	 * breakpointed instruction.
 	 *
+	 * Since arm64 has the same issue with arm for the single-step
+	 * handling, this case also gets suck on the breakpointed
+	 * instruction.
+	 *
 	 * Just disable the test for these architectures until these
 	 * issues are resolved.
 	 */
-#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || \
+    defined(__aarch64__)
 	return false;
 #else
 	return true;
-- 
2.17.1

