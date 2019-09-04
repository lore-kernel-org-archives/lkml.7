Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FDC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662E722CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfIDOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:20:25 -0400
Received: from foss.arm.com ([217.140.110.172]:56308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbfIDOUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:20:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3284E28;
        Wed,  4 Sep 2019 07:20:22 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4D13F59C;
        Wed,  4 Sep 2019 07:20:20 -0700 (PDT)
Date:   Wed, 4 Sep 2019 15:20:17 +0100
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
Message-ID: <20190904142017.kz7dj2cc43wvs4ve@e107158-lin.cambridge.arm.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904130628.GE144846@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/19 09:06, Joel Fernandes wrote:
> > 
> > It is actually true.
> >
> > But you need to make the distinction between a tracepoint
> > and a trace event first.
> 
> I know this distinction well.
> 
> > What Valentin is talking about here is the *bare*
> > tracepoint without any event associated with them like the one I added to the
> > scheduler recently. These ones are not accessible via eBPF, unless something
> > has changed since I last tried.
> 
> Can this tracepoint be registered on with tracepoint_probe_register()?
> Quickly looking at these new tracepoint, they can be otherwise how would they
> even work right? If so, then eBPF can very well access it. Look at
> __bpf_probe_register() and bpf_raw_tracepoint_open() which implement the
> BPF_RAW_TRACEPOINT_OPEN.

Humm okay. I tried to use raw tracepoint with bcc but failed to attach. But
maybe I missed something on the way it should be used. AFAICT it was missing
the bits that I implemented in [1]. Maybe the method you mention is lower level
than bcc.

> 
> > The current infrastructure needs to be expanded to allow eBPF to attach these
> > bare tracepoints. Something similar to what I have in [1] is needed - but
> > instead of creating a new macro it needs to expand the current macro. [2] might
> > give full context of when I was trying to come up with alternatives to using
> > trace events.
> > 
> > [1] https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > [2] https://lore.kernel.org/lkml/20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com/
> 
> 
> As I was mentioning, tracepoints, not "trace events" can already be opened
> directly with BPF. I don't see how these new tracepoints are different.
> 
> I wonder if this distinction of "tracepoint" being non-ABI can be documented
> somewhere. I would be happy to do that if there is a place for the same. I
> really want some general "policy" in the kernel on where we draw a line in
> the sand with respect to tracepoints and ABI :).
> 
> For instance, perhaps VFS can also start having non-ABI tracepoints for the
> benefit of people tracing the VFS.

Good question. I did consider that but failed to come up with a place. AFAIU
the history moved from tracepoints to trace events and now moving back to
tracepoints. Something Steve is not very enthusiastic about.

LPC is coming, sounds like a good venue to discuss this :-)

Cheers

--
Qais Yousef
