Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F65C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF692339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfIDKnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:43:39 -0400
Received: from foss.arm.com ([217.140.110.172]:51628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfIDKni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:43:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B573B337;
        Wed,  4 Sep 2019 03:43:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE6D33F246;
        Wed,  4 Sep 2019 03:43:35 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:43:33 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?utf-8?Q?Hladk=C3=BD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904042310.GA159235@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/19 00:23, Joel Fernandes wrote:
> On Tue, Sep 03, 2019 at 05:05:47PM +0100, Valentin Schneider wrote:
> > On 03/09/2019 16:43, Radim Krčmář wrote:
> > > The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
> > > custom data gathering points to better understand what was going on in
> > > the scheduler.
> > > Red Hat adapted one of them for the tracepoint framework and created a
> > > tool to plot a heatmap of nr_running, where the sched_update_nr_running
> > > tracepoint is being used for fine grained monitoring of scheduling
> > > imbalance.
> > > The tool is available from https://github.com/jirvoz/plot-nr-running.
> > > 
> > > The best place for the tracepoints is inside the add/sub_nr_running,
> > > which requires some shenanigans to make it work as they are defined
> > > inside sched.h.
> > > The tracepoints have to be included from sched.h, which means that
> > > CREATE_TRACE_POINTS has to be defined for the whole header and this
> > > might cause problems if tree-wide headers expose tracepoints in sched.h
> > > dependencies, but I'd argue it's the other side's misuse of tracepoints.
> > > 
> > > Moving the import sched.h line lower would require fixes in s390 and ppc
> > > headers, because they don't include dependecies properly and expect
> > > sched.h to do it, so it is simpler to keep sched.h there and
> > > preventively undefine CREATE_TRACE_POINTS right after.
> > > 
> > > Exports of the pelt tracepoints remain because they don't need to be
> > > protected by CREATE_TRACE_POINTS and moving them closer would be
> > > unsightly.
> > > 
> > 
> > Pure trace events are frowned upon in scheduler world, try going with
> > trace points. Qais did something very similar recently:
> > 
> > https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/
> > 
> > You'll have to implement the associated trace events in a module, which
> > lets you define your own event format and doesn't form an ABI :).
> 
> Is that really true? eBPF programs loaded from userspace can access
> tracepoints through BPF_RAW_TRACEPOINT_OPEN, which is UAPI:
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L103
> 
> I don't have a strong opinion about considering tracepoints as ABI / API or
> not, but just want to get the facts straight :)

It is actually true. But you need to make the distinction between a tracepoint
and a trace event first. What Valentin is talking about here is the *bare*
tracepoint without any event associated with them like the one I added to the
scheduler recently. These ones are not accessible via eBPF, unless something
has changed since I last tried.

The current infrastructure needs to be expanded to allow eBPF to attach these
bare tracepoints. Something similar to what I have in [1] is needed - but
instead of creating a new macro it needs to expand the current macro. [2] might
give full context of when I was trying to come up with alternatives to using
trace events.

[1] https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
[2] https://lore.kernel.org/lkml/20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com/

HTH

--
Qais Yousef
