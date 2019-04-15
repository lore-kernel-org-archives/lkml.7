Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D04C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfDOOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:49:51 -0400
Received: from foss.arm.com ([217.140.101.70]:36240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDOOtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:49:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30405374;
        Mon, 15 Apr 2019 07:49:50 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8C4E3F68F;
        Mon, 15 Apr 2019 07:49:48 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:49:45 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     rostedt@goodmis.org, peterz@infradead.org
Cc:     dietmar.eggemann@arm.com, quentin.perret@arm.com,
        bristot@redhat.com, juri.lelli@redhat.com, williams@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Tracehooks in scheduler
Message-ID: <20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com>
References: <20190407175235.5c2livciovwgq7mm@e107158-lin.cambridge.arm.com>
 <20190409082450.mkcobfbmohhxqk6k@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409082450.mkcobfbmohhxqk6k@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Peter

> On 04/07/19 18:52, Qais Yousef wrote:
> > Hi Steve, Peter
> > 
> > I know the topic has sprung up in the past but I couldn't find anything that
> > points into any conclusion.
> > 
> > As far as I understand new TRACE_EVENTS() in the scheduler (and probably other
> > subsystems) isn't desirable as it intorduces a sort of ABI that can be painful
> > to maintain.
> > 
> > But for us to be able to test various aspect of EAS, we rely on some events
> > that track load_avg, util_avg and some other metrics in the scheduler.
> > Example of such patches that are in android and we maintain out of tree can be
> > found here:
> > 
> > https://android.googlesource.com/kernel/common/+/42903694913697da88a4ac627a92bbfdf44f0a2e
> > https://android.googlesource.com/kernel/common/+/6dfaed989ea4ca223f0913dfc11cdafd9664fc1c
> > 
> > Dietmar and Quentin pointed me to a discussion you guys had with Daniel Bristot
> > in the last LPC when he had a similar need. So it is something that could
> > benefit other users as well.
> > 
> > What is the best way forward to be able to add tracehooks into the scheduler
> > and any other subsystem for that matters?
> > 
> > We tried using DECLARE_TRACE() to create a tracepoint which doesn't export
> > anything in /sys/kernel/debug/tracing/events and hoped that we can use eBPF or
> > a kernel module to attach to this tracepoint and access the args to inject our
> > own trace_printks() but this didn't work. The glue logic necessary to attach
> > to this tracepoint in a similar manner to how RAW_TRACEPOINT() in eBPF works
> > isn't there AFAICT.
> > 
> > I can post the full example if the above doesn't make sense. I am still
> > familiarizing myself with the different aspects of this code as well. There
> > might be support for what we want but I failed to figure out the magic
> > combination to get it to work.
> > 
> > If I got this glue logic done, would this be an acceptable solution? If not, do
> > you have any suggestions on how to progress?

I have written some patches in hope it'll clarify further what we are trying to
achieve here and what would be the best possible approach about it.

I have taken two approaches to solve the problem.


1.

	https://github.com/qais-yousef/linux/commit/e7d0aa7ff1328195f314b0730c4cc744dec4261e

	In this approach everything we need is already available and we just
	need to create new tracepoints as described in
	Documentation/trace/tracepoints.rst and export it with
	EXPORT_TRACEPOINT_SYMBOL_GPL().

	A user then can have an out of tree module to probe this tp and
	manipulate it as they like.

	Example of such a module is here, the pelt_se tp is to demo the
	approach:

	https://github.com/qais-yousef/tracepoints-helpers/blob/master/module-pelt-se/probe_tp_pelt_se.c

	Googling around I can see that the use of
	EXPORT_TRACEPOINT_SYMBOL_GPL() is not desired unless the module is
	in-tree which I doubt will be the case here.

	https://lore.kernel.org/lkml/20150422130052.4996e231@gandalf.local.home/

2.
	https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
	https://github.com/qais-yousef/linux/commit/edd2498c5bbfca1a26acd151a4e3323e511f3455

	In this approach I try to allow attaching to a TP using eBPF. Sadly the
	current infrastructure is lacking so I hacked the above up to create a
	new DECLARE_TRACE_HOOK() macro which will allow using eBPF but without
	exporting anything in debugfs that can constitute an ABI.

	The following eBPF program can be used then to attach and access some
	info at the TP:

	https://github.com/qais-yousef/tracepoints-helpers/blob/master/bpf/tp_trace_printk_pelt_se


Does any of the above approaches make sense?

Thanks

--
Qais Yousef
