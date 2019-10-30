Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE74CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6125C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsSorIn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJ3MrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:47:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50706 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfJ3MrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/m49eZ61fGR01vML73iup+AhH6sl213r3BQETPC+rI8=; b=GsSorIn9gaIxPHvdTLOwabIb4
        193uAmQXvz+BnKDc/c5VRfZsdn94yhejQHPet5n8WE8ETynBayC+6PivwlfpYHAntbwOHq7b9ZDK5
        vRbVBWIV/GZiucp2RdIxdPf6lhT9eARpclKiOGkHWTzXLP7RA9zEWixywygwpR6VW75Mbmvxern5u
        VgvlosCbLwqQ2VwD5/gN89eosBsOmsg7PcgLs1mzkAxmiShOzhWSfWOD2e5qhjXr0XsH9Zbxzw3s7
        5B75/O3xvYu8Q82ObKXF1DuVZAf/CB71WkS3Ofklisw1qfl8C1n1UDETCm0kcUovVvqbsyS4MK8ds
        io71IBiig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPnNP-0003Yn-8d; Wed, 30 Oct 2019 12:47:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31C7F3006D0;
        Wed, 30 Oct 2019 13:45:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61B4B2B435A44; Wed, 30 Oct 2019 13:46:59 +0100 (CET)
Date:   Wed, 30 Oct 2019 13:46:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030104747.GA21153@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:47:47PM +0800, Leo Yan wrote:
> Hi Adrian,
> 
> On Fri, Oct 25, 2019 at 03:59:55PM +0300, Adrian Hunter wrote:
> > Record changes to kernel text (i.e. self-modifying code) in order to
> > support tracers like Intel PT decoding through jump labels.
> > 
> > A copy of the running kernel code is needed as a reference point
> > (e.g. from /proc/kcore). The text poke event records the old bytes
> > and the new bytes so that the event can be processed forwards or backwards.
> > 
> > The text poke event has 'flags' to describe when the event is sent. At
> > present the only flag is PERF_TEXT_POKE_UPDATE which indicates the
> > point at which tools should update their reference kernel executable to
> > change the old bytes to the new bytes.
> > 
> > Other architectures may wish to emit a pair of text poke events. One before
> > and one after a text poke. In that case, PERF_TEXT_POKE_UPDATE flag would
> > be set on only one of the pair.
> 
> Thanks a lot for the patch set.
> 
> Below is my understanding for implementation 'emit a pair of text poke
> events' as you mentioned:
> 
> Since Arm64 instruction is fixed size, it doesn't need to rely on INT3
> liked mechanism to replace instructions and directly uses two operations
> to alter instruction (modify instruction and flush icache line).  So
> Arm64 has no chance to send perf event in the middle of altering
> instruction.

Right.

> Thus we can send pair of text poke events in the kernel:
> 
>   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_PREV)
> 
>     Change instruction
>     Flush icache
> 
>   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_POST)
> 
> In the userspace, if perf tool detects the instruction is changed
> from nop to branch,

There is _far_ more text poking than just jump_label's NOP/JMP
transitions. Ftrace also does NOP/CALL, CALL/CALL, and the static_call
infrastructure that I posted here:

  https://lkml.kernel.org/r/20191007082708.013939311@infradead.org

Has: JMP/RET, JMP/JMP and if it has inline patching support: NOP/CALL,
CALL/CALL, patching.

Anyway, the below argument doesn't care much, it works for NOP/JMP just
fine.

> we need to update dso cache for the
> 'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
> changed from branch to nop, we need to update dso cache for
> 'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
> branch instructions can be safely contained in the dso file and any
> branch samples can read out correct branch instruction.
> 
> Could you confirm this is the same with your understanding?  Or I miss
> anything?  I personally even think the pair events can be used for
> different arches (e.g. the solution can be reused on Arm64/x86, etc).

So the problem we have with PT is that it is a bit-stream of
branch taken/not-taken decisions. In order to decode that we need to
have an accurate view of the unconditional code flow.

Both NOP/JMP are unconditional and we need to exactly know which of the
two was encountered.

With your scheme, I don't see how we can ever actually know that. When
we get the PRE event, all we really know is that we're going to change
a specific instruction into another. And at the POST event we know it
has been done. But in between these two events, we have no clue which of
the two instructions is live on which CPU (two CPUs might in fact have a
different live instruction at the same time).

This means we _cannot_ unambiguously decode a taken/not-taken decision
stream.

Does CS have this same problem, and how would the PRE/POST events help
with that?

So our (x86) horrible (variable instruction length induced) complexity
for text poking is actually in our advantage this one time. The
exception and exception-return paths allow us to unambiguously know what
happens around the time of poking.
