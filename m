Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61321738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JgIPY+dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfDWLfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:35:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47948 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6rBI7PHc5YdcJ73QAsnbPgyOmLDrCsr5wLMdGKq6ogg=; b=JgIPY+dyIcUanQ3/Dj8Fth0Aw
        rnLuaE9GPlBhpeLx3eBDcQ9P66VcCw5uOblDW11DTzM13NJPA9Wj5mcQaL1z5fqh/uS9TOikckF4o
        paAg+7S63cXg+bwBso2PYWJL3iIIrkrCp7CHbQjK1yFFxNe2pSLb6ZqqPkP52b8mVDPeelciVO548
        pJNv2gQdODHK5AoxAlGad8y+hYVb1L7DZj+h+zwShP0p6uEzu7UMvIxMp7yYUp4H/7/Sv2AoFYDPW
        XEM9Um+5B16J2IVye5ZkxaThQ3apyufEbc+cTlwOuonq+5VYUtUTiEjNKWxpqR5/WWgWmhdJgP/+N
        Du0RPN0Jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIthW-0003Pz-R5; Tue, 23 Apr 2019 11:35:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94A7529B8F6FE; Tue, 23 Apr 2019 13:35:01 +0200 (CEST)
Date:   Tue, 23 Apr 2019 13:35:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190423113501.GN11158@hirez.programming.kicks-ass.net>
References: <20190422162652.15483-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422162652.15483-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:26:52AM +0800, Kairui Song wrote:
> Currently perf callchain doesn't work well with ORC unwinder
> when sampling from trace point. We'll get useless in kernel callchain
> like this:
> 
> perf  6429 [000]    22.498450:             kmem:mm_page_alloc: page=0x176a17 pfn=1534487 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>     ffffffffbe23e32e __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
> 	7efdf7f7d3e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> 	5651468729c1 [unknown] (/usr/bin/perf)
> 	5651467ee82a main+0x69a (/usr/bin/perf)
> 	7efdf7eaf413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>     5541f689495641d7 [unknown] ([unknown])
> 
> The root cause is that, for trace point events, it doesn't provide a
> real snapshot of the hardware registers. Instead perf tries to get
> required caller's registers and compose a fake register snapshot
> which suppose to contain enough information for start a unwinding.
> However without CONFIG_FRAME_POINTER, if failed to get caller's BP as the
> frame pointer, so current frame pointer is returned instead. We get
> a invalid register combination which confuse the unwinder, and end the
> stacktrace early.
> 
> So in such case just don't try dump BP, and let the unwinder start
> directly when the register is not a real snapshot. And Use SP
> as the skip mark, unwinder will skip all the frames until it meet
> the frame of the trace point caller.
> 
> Tested with frame pointer unwinder and ORC unwinder, this make perf
> callchain get the full kernel space stacktrace again like this:
> 
> perf  6503 [000]  1567.570191:             kmem:mm_page_alloc: page=0x16c904 pfn=1493252 order=0 migratetype=0 gfp_flags=GFP_KERNEL
>     ffffffffb523e2ae __alloc_pages_nodemask+0x22e (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52383bd __get_free_pages+0xd (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52fd28a __pollwait+0x8a (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb521426f perf_poll+0x2f (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52fe3e2 do_sys_poll+0x252 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb52ff027 __x64_sys_poll+0x37 (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb500418b do_syscall_64+0x5b (/lib/modules/5.1.0-rc3+/build/vmlinux)
>     ffffffffb5a0008c entry_SYSCALL_64_after_hwframe+0x44 (/lib/modules/5.1.0-rc3+/build/vmlinux)
> 	7f71e92d03e8 __poll+0x18 (/usr/lib64/libc-2.28.so)
> 	55a22960d9c1 [unknown] (/usr/bin/perf)
> 	55a22958982a main+0x69a (/usr/bin/perf)
> 	7f71e9202413 __libc_start_main+0xf3 (/usr/lib64/libc-2.28.so)
>     5541f689495641d7 [unknown] ([unknown])
> 
> Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>

Thanks!

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e47ef764f613..ab135abe62e0 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1059,7 +1059,7 @@ static inline void perf_arch_fetch_caller_regs(struct pt_regs *regs, unsigned lo
>   * the nth caller. We only need a few of the regs:
>   * - ip for PERF_SAMPLE_IP
>   * - cs for user_mode() tests
> - * - bp for callchains
> + * - sp for callchains
>   * - eflags, for future purposes, just in case
>   */
>  static inline void perf_fetch_caller_regs(struct pt_regs *regs)

I've extended that like so:

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1058,12 +1058,18 @@ static inline void perf_arch_fetch_calle
 #endif
 
 /*
- * Take a snapshot of the regs. Skip ip and frame pointer to
- * the nth caller. We only need a few of the regs:
+ * When generating a perf sample in-line, instead of from an interrupt /
+ * exception, we lack a pt_regs. This is typically used from software events
+ * like: SW_CONTEXT_SWITCHES, SW_MIGRATIONS and the tie-in with tracepoints.
+ *
+ * We typically don't need a full set, but (for x86) do require:
  * - ip for PERF_SAMPLE_IP
  * - cs for user_mode() tests
- * - sp for callchains
- * - eflags, for future purposes, just in case
+ * - sp for PERF_SAMPLE_CALLCHAIN
+ * - eflags for MISC bits and CALLCHAIN (see: perf_hw_regs())
+ *
+ * NOTE: assumes @regs is otherwise already 0 filled; this is important for
+ * things like PERF_SAMPLE_REGS_INTR.
  */
 static inline void perf_fetch_caller_regs(struct pt_regs *regs)
 {
