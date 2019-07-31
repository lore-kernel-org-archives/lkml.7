Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E39C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfGaPZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfGaPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:25:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65E420659;
        Wed, 31 Jul 2019 15:25:41 +0000 (UTC)
Date:   Wed, 31 Jul 2019 11:25:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 00/12] tracing/probe: Add multi-probes per event
 support
Message-ID: <20190731112539.1efac604@gandalf.local.home>
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 00:07:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This is the 2nd version of multi-probes per event support on ftrace
> and perf-tools.
> 
> Previous version is here;
> https://lkml.org/lkml/2019/5/31/573
> 
> >From this version, I omitted first 9 patches which has been picked  
> to Steve's tree.
> In this version, I've fixed some bugs and hardened some unexpected
> error cases according to Steve's comment.
> Here are changes in this version:
> 
>  - [1/12] This have below changes. 
>     - Warn if the primary trace_probe does not exist.
>     - Fix enable_trace_kprobe() to not return error if the any probes
>       are "gone" state. If all probes have gone or any other error
>       reason, the event can not be enabled and return error.
>     - Fix trace_probe_enable() to roll back all enabled uprobe if
>       any one of uprobe is failed to enable.
>  - [7/12] Swap the checking order of filename for avoiding unexpected
>      memory access.
> 
> 
> ====
> For trace-event, we can insert same trace-event on several places
> on the code, and those can record similar information as a same event
> with same format.
> 
> This series implements similar feature on probe-event. Since the probe
> event is based on the compiled binary, sometimes we find that the target
> source line is complied into several different addresses, e.g. inlined
> function, unrolled loop, etc. In those cases, it is useful to put a
> same probe-event on different addresses.
> 
> With this series, we can append multi probes on one event as below
> 
>   # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
>   # echo p:testevent fork_idle r1=%ax r2=%cx >> kprobe_events
>   # kprobe_events
>   p:kprobes/testevent _do_fork r1=%ax r2=%dx
>   p:kprobes/testevent fork_idle r1=%ax r2=%cx
> 
> This means testevent is hit on both of _do_fork and fork_idle.
> As you can see, the appended event must have same number of arguments
> and those must have same 'type' and 'name' as original one. This is like
> a function signature, it checks whether the appending event has the same
> type and name of event arguments and same probe type, but doesn't care
> about the assignment.
> 
> So, below appending commands will be rejected.
> 
>   # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
>   # echo p:testevent fork_idle r1=%ax >> kprobe_events
>   (No 2nd argument)
>   # echo p:testevent fork_idle r1=%ax r2=%ax:x8 >> kprobe_events
>   (The type of 2nd argument is different)
> 
> If one inlined code has an argument on a register, but another
> inlined code has fixed value (as a result of optimization),
> you can also specify the fixed immediate value, e.g.
> 
>   # echo p:testevent _do_fork r1=%ax r2=%dx > kprobe_events
>   # echo p:testevent fork_idle r1=%ax r2=\1 >> kprobe_events
> 
> 


Hi Masami,

I applied this patch set to my queue. Nice feature! I'll probably be
testing it a bit more. I wont be pushing it to my repo until v5.3-rc3
comes out, as I'll plan on rebasing my for-next branch on that.

Thanks!

-- Steve
