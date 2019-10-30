Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E5CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF9720578
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIWmn7Wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJ3OUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:20:14 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45652 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfJ3OUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:20:14 -0400
Received: by mail-yb1-f196.google.com with SMTP id q143so931771ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YdDHQkvc3nm46k6RW2UhzbVV1mmNYMcJxWHU6Fp2X8=;
        b=rIWmn7Wp43dejRZeSMbeRfNZ43MoYkmu69JiPoyApBD6PbIoFgAcEsHAtCNVRoy1/6
         ng5mn530gmTLsXjQEdMYnvSyXs9/BMRY5DvfA0Rgis4V6eoMvwNFl/WaIn0++9HsH1S2
         Rfp16fWPJtuWeLOkVXKLIb4lsmn70WMAaFzXC/vNPccBk6yG16tx4uzrjFDf2nEwgn+C
         aF2dlvFOqMR2NginbZOvnQPm46g1sAt+847Lgu98seJKkCRBZK02UXFVj70NLnBLvzCO
         KG2D9zbxr5ZFIKI8ESUoaK050NXX8qTLcuZHCFNcxzZCYV1NnpipGKbCJcKWfMlofgtF
         msAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YdDHQkvc3nm46k6RW2UhzbVV1mmNYMcJxWHU6Fp2X8=;
        b=p5PZb6xAZOUVUB+MSFqoDDnw8OVAoSKEZ5J035YctjNeNLC4lIc+y4bPwVC2VnpyCp
         TkErwTzpR0xscVdJeQOq1qlgnwLbBKlxTRYcqfspTpF1Qe3qNqEQzZMtuEzeXtXMHyip
         oHIEGZzoa32t5p7yexAeMA2qJm+LtBFRQrpU+UXYfSIbU5x4T8tiqwHLH9vrbVVLPBB1
         728A1Rl+etOqBuIXnBTm0MPz8aj6LYL5cvyKMubtjI0Z+GOqHWlxXSiBir+MlebK5Qq/
         MEkVgM1M3uxSEhRfhXVCBjzwrREPNW3APJ0PxAs48ds5v4gpSP1Th7piInwI4fL+bApb
         nlFg==
X-Gm-Message-State: APjAAAUgHXYXB4HiZMLWDuTgwEMVdtD1cJFAUl9U+HVB6WGLu9NtNsOx
        eZDXjvGRt+WhnM1cYCvizB9dbg==
X-Google-Smtp-Source: APXvYqyZbT22V0MhBZgq7xR+b2UAdEsYwd5xMhiZEbK6SU25nGz+aLttscM+Slk/V62Bx3wxWFVHrA==
X-Received: by 2002:a25:908c:: with SMTP id t12mr3584308ybl.278.1572445211699;
        Wed, 30 Oct 2019 07:20:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li72-186.members.linode.com. [74.207.230.186])
        by smtp.gmail.com with ESMTPSA id q198sm149059ywg.18.2019.10.30.07.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 07:20:10 -0700 (PDT)
Date:   Wed, 30 Oct 2019 22:19:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191030141950.GB21153@leoy-ThinkPad-X240s>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

[ + Mike Leach ]

On Wed, Oct 30, 2019 at 01:46:59PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 30, 2019 at 06:47:47PM +0800, Leo Yan wrote:
> > Hi Adrian,
> > 
> > On Fri, Oct 25, 2019 at 03:59:55PM +0300, Adrian Hunter wrote:
> > > Record changes to kernel text (i.e. self-modifying code) in order to
> > > support tracers like Intel PT decoding through jump labels.
> > > 
> > > A copy of the running kernel code is needed as a reference point
> > > (e.g. from /proc/kcore). The text poke event records the old bytes
> > > and the new bytes so that the event can be processed forwards or backwards.
> > > 
> > > The text poke event has 'flags' to describe when the event is sent. At
> > > present the only flag is PERF_TEXT_POKE_UPDATE which indicates the
> > > point at which tools should update their reference kernel executable to
> > > change the old bytes to the new bytes.
> > > 
> > > Other architectures may wish to emit a pair of text poke events. One before
> > > and one after a text poke. In that case, PERF_TEXT_POKE_UPDATE flag would
> > > be set on only one of the pair.
> > 
> > Thanks a lot for the patch set.
> > 
> > Below is my understanding for implementation 'emit a pair of text poke
> > events' as you mentioned:
> > 
> > Since Arm64 instruction is fixed size, it doesn't need to rely on INT3
> > liked mechanism to replace instructions and directly uses two operations
> > to alter instruction (modify instruction and flush icache line).  So
> > Arm64 has no chance to send perf event in the middle of altering
> > instruction.
> 
> Right.
> 
> > Thus we can send pair of text poke events in the kernel:
> > 
> >   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_PREV)
> > 
> >     Change instruction
> >     Flush icache
> > 
> >   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_POST)
> > 
> > In the userspace, if perf tool detects the instruction is changed
> > from nop to branch,
> 
> There is _far_ more text poking than just jump_label's NOP/JMP
> transitions. Ftrace also does NOP/CALL, CALL/CALL, and the static_call
> infrastructure that I posted here:
> 
>   https://lkml.kernel.org/r/20191007082708.013939311@infradead.org
> 
> Has: JMP/RET, JMP/JMP and if it has inline patching support: NOP/CALL,
> CALL/CALL, patching.

Thanks for the info.  I took a bit time to look your patch set and
Steven's patch set for dynamic function, though don't completely
understand, but get more sense for the context.

> Anyway, the below argument doesn't care much, it works for NOP/JMP just
> fine.

We can support NOP/JMP case as the first step, but later should can
extend to support other transitions.

> > we need to update dso cache for the
> > 'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
> > changed from branch to nop, we need to update dso cache for
> > 'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
> > branch instructions can be safely contained in the dso file and any
> > branch samples can read out correct branch instruction.
> > 
> > Could you confirm this is the same with your understanding?  Or I miss
> > anything?  I personally even think the pair events can be used for
> > different arches (e.g. the solution can be reused on Arm64/x86, etc).
> 
> So the problem we have with PT is that it is a bit-stream of
> branch taken/not-taken decisions. In order to decode that we need to
> have an accurate view of the unconditional code flow.
> 
> Both NOP/JMP are unconditional and we need to exactly know which of the
> two was encountered.

If I understand correctly, PT decoder needs to read out instructions
from dso and decide the instruction type (NOP or JMP), and finally
generate the accurate code flow.

So PT decoder relies on (cached) DSO for decoding.  As I know, this
might be different from Arm CS, since Arm CS decoder is merely
generate packets and it doesn't need to rely on DSO for decoding.

I think my answer is not very convinced, in case I mislead, loop Mike
to confirm for this.

> With your scheme, I don't see how we can ever actually know that. When
> we get the PRE event, all we really know is that we're going to change
> a specific instruction into another. And at the POST event we know it
> has been done. But in between these two events, we have no clue which of
> the two instructions is live on which CPU (two CPUs might in fact have a
> different live instruction at the same time).
>
> This means we _cannot_ unambiguously decode a taken/not-taken decision
> stream.
> 
> Does CS have this same problem, and how would the PRE/POST events help
> with that?

My purpose is to use PRE event and POST event to update cached DSO,
thus perf tool can read out 'correct' instructions and fill them into
instruction/branch samples.  On the other hand, as mentioned, I don't
aware the instruction read out from DSO will be used for Arm CS decoder;
Arm CS also reads the instructions from DSO, usually it's used to decide
instruction size or decide the sample flags (flags for CALL/RETURN/hw
int, etc...), but it isn't used for decoder.

@Mike, please help confirm for this as well, from Arm CoreSight's
decoder pespective.

> So our (x86) horrible (variable instruction length induced) complexity
> for text poking is actually in our advantage this one time. The
> exception and exception-return paths allow us to unambiguously know what
> happens around the time of poking.

Thanks a lot for the info!
Leo.
