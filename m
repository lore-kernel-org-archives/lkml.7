Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 04:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB7222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 04:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSEbH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 23:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfLSEbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 23:31:07 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A11B2082E;
        Thu, 19 Dec 2019 04:31:04 +0000 (UTC)
Date:   Wed, 18 Dec 2019 23:31:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: "ftrace: Rework event_create_dir()" triggers boot error
 messages
Message-ID: <20191218233101.73044ce3@rorschach.local.home>
In-Reply-To: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
References: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 22:58:23 -0500
Qian Cai <cai@lca.pw> wrote:

> The linux-next commit "ftrace: Rework event_create_dir()” [1] triggers boot warnings
> for Clang-build (Clang version 8.0.1) kernels (reproduced on both arm64 and powerpc).
> Reverted it (with trivial conflict fixes) on the top of today’s linux-next fixed the issue.
> 
> configs:
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> [1] https://lore.kernel.org/lkml/20191111132458.342979914@infradead.org/
> 
> [  115.799327][    T1] Registered efivars operations
> [  115.849770][    T1] clocksource: Switched to clocksource arch_sys_counter
> [  115.901145][    T1] Could not initialize trace point events/sys_enter_rt_sigreturn
> [  115.908854][    T1] Could not create directory for event sys_enter_rt_sigreturn
> [  115.998949][    T1] Could not initialize trace point events/sys_enter_restart_syscall
> [  116.006802][    T1] Could not create directory for event sys_enter_restart_syscall
> [  116.062702][    T1] Could not initialize trace point events/sys_enter_getpid
> [  116.069828][    T1] Could not create directory for event sys_enter_getpid
> [  116.078058][    T1] Could not initialize trace point events/sys_enter_gettid
> [  116.085181][    T1] Could not create directory for event sys_enter_gettid
> [  116.093405][    T1] Could not initialize trace point events/sys_enter_getppid
> [  116.100612][    T1] Could not create directory for event sys_enter_getppid
> [  116.108989][    T1] Could not initialize trace point events/sys_enter_getuid
> [  116.116058][    T1] Could not create directory for event sys_enter_getuid
> [  116.124250][    T1] Could not initialize trace point events/sys_enter_geteuid
> [  116.131457][    T1] Could not create directory for event sys_enter_geteuid
> [  116.139840][    T1] Could not initialize trace point events/sys_enter_getgid
> [  116.146908][    T1] Could not create directory for event sys_enter_getgid
> [  116.155163][    T1] Could not initialize trace point events/sys_enter_getegid
> [  116.162370][    T1] Could not create directory for event sys_enter_getegid
> [  116.178015][    T1] Could not initialize trace point events/sys_enter_setsid
> [  116.185138][    T1] Could not create directory for event sys_enter_setsid
> [  116.269307][    T1] Could not initialize trace point events/sys_enter_sched_yield
> [  116.276811][    T1] Could not create directory for event sys_enter_sched_yield
> [  116.527652][    T1] Could not initialize trace point events/sys_enter_munlockall
> [  116.535126][    T1] Could not create directory for event sys_enter_munlockall
> [  116.622096][    T1] Could not initialize trace point events/sys_enter_vhangup
> [  116.629307][    T1] Could not create directory for event sys_enter_vhangup
> [  116.783867][    T1] Could not initialize trace point events/sys_enter_sync
> [  116.790819][    T1] Could not create directory for event sys_enter_sync
> [  117.723402][    T1] pnp: PnP ACPI init

I noticed that all of the above have zero parameters. Does the
following patch fix it?

(note, I prefer "ret" and "i" on different lines anyway)

-- Steve

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 53935259f701..abb70c71fe60 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -269,7 +269,8 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	struct syscall_trace_enter trace;
 	struct syscall_metadata *meta = call->data;
 	int offset = offsetof(typeof(trace), args);
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	for (i = 0; i < meta->nb_args; i++) {
 		ret = trace_define_field(call, meta->types[i],
