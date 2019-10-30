Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B36CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636A620874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWxQxvtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfJ3PBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:01:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41889 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfJ3PBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:01:11 -0400
Received: by mail-qk1-f194.google.com with SMTP id m125so3021295qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ok0GZpzbJMnJy29NWO9E2UiJdhKBDU6UkiE31Air6UE=;
        b=cWxQxvtV3ia3/nHm2h7X2lYvK7iw3DHU0osyEesFN4VDy97GL/InA63xQlsaXUoCiZ
         TUP3hbJVZaD5BgDTO1THosI0/TZZtULDxZDp23evWolU/cHkK9JLm1Pwx7AnK+MHa5pW
         7n/3+NPAD9IXF2TYdVzkVESk1bVBrOGF3Llb3NRmhBrCNbgYwa3C5xG5M2cNPufG+H4p
         OelxGZRF8M628x78ecEtTno3ileBO5UhDej6/LsmVOOq/wlbRiUBH1xVyEStosxw+u53
         wMsGjaZOKAi6b0LUl76XkP9308UeVPqtV/+cwjjnW4LH7GwSfNttzLHrCoi9s85xZG35
         un9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ok0GZpzbJMnJy29NWO9E2UiJdhKBDU6UkiE31Air6UE=;
        b=ih6yd9HN9g3jUiL7Djt4qNYrh8dOT/RZ90uVK4ZAT36t3Q/pWHmxau34H850LoCMTf
         ZRXzkBhsdJZGakuobGmeQn73OioF/VrBOjrOrVx6CsTJGkrOJEMg96aKfg9fCR2vgqao
         lrO/Gba3KwX9x7yPj0WAmzUuV6SEJZ3COevNcimjDMayl453zMlaLLw+kQMT/dLIaX+q
         tdsb6I4mJRxJvDboKO5AF+Z7hkO1lUm38boZAJpBIq3KkxsoTfVkW4Hzkj1dFsEAsjTA
         Q4fVPpxx6AtdT1HO7r1hyEba1VItfFp3lH/60bnK0AAZZllLgaL6VYgJ7iRlltoeOgJb
         NLpw==
X-Gm-Message-State: APjAAAX/U0XUn80NI5FPJrUQ4HQDaMLCpy9vdMX93Q28+cRTB4w1f1GB
        syVBSFQF4+thgA/ac/p/yGnROlDI8N3qTdKfJ9/mOA==
X-Google-Smtp-Source: APXvYqxOKOvb1f9qMXdEaY2o9CDIi7Y2wMxwzYWlIL0lDrZ7uXeIj8opoLHmWQnS4+KObQNlCsre9dsM7/k8l6kGA4A=
X-Received: by 2002:a37:70c2:: with SMTP id l185mr258556qkc.445.1572447670129;
 Wed, 30 Oct 2019 08:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com> <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net> <20191030141950.GB21153@leoy-ThinkPad-X240s>
In-Reply-To: <20191030141950.GB21153@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 30 Oct 2019 15:00:58 +0000
Message-ID: <CAJ9a7VhOETGwoDPDu0cU+pCSA1ZGMM8b88HVLeuGNPt=DciSWw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Wed, 30 Oct 2019 at 14:20, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Peter,
>
> [ + Mike Leach ]
>
> On Wed, Oct 30, 2019 at 01:46:59PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 30, 2019 at 06:47:47PM +0800, Leo Yan wrote:
> > > Hi Adrian,
> > >
> > > On Fri, Oct 25, 2019 at 03:59:55PM +0300, Adrian Hunter wrote:
> > > > Record changes to kernel text (i.e. self-modifying code) in order to
> > > > support tracers like Intel PT decoding through jump labels.
> > > >
> > > > A copy of the running kernel code is needed as a reference point
> > > > (e.g. from /proc/kcore). The text poke event records the old bytes
> > > > and the new bytes so that the event can be processed forwards or backwards.
> > > >
> > > > The text poke event has 'flags' to describe when the event is sent. At
> > > > present the only flag is PERF_TEXT_POKE_UPDATE which indicates the
> > > > point at which tools should update their reference kernel executable to
> > > > change the old bytes to the new bytes.
> > > >
> > > > Other architectures may wish to emit a pair of text poke events. One before
> > > > and one after a text poke. In that case, PERF_TEXT_POKE_UPDATE flag would
> > > > be set on only one of the pair.
> > >
> > > Thanks a lot for the patch set.
> > >
> > > Below is my understanding for implementation 'emit a pair of text poke
> > > events' as you mentioned:
> > >
> > > Since Arm64 instruction is fixed size, it doesn't need to rely on INT3
> > > liked mechanism to replace instructions and directly uses two operations
> > > to alter instruction (modify instruction and flush icache line).  So
> > > Arm64 has no chance to send perf event in the middle of altering
> > > instruction.
> >
> > Right.
> >
> > > Thus we can send pair of text poke events in the kernel:
> > >
> > >   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_PREV)
> > >
> > >     Change instruction
> > >     Flush icache
> > >
> > >   perf_event_text_poke(PERF_TEXT_POKE_UPDATE_POST)
> > >
> > > In the userspace, if perf tool detects the instruction is changed
> > > from nop to branch,
> >
> > There is _far_ more text poking than just jump_label's NOP/JMP
> > transitions. Ftrace also does NOP/CALL, CALL/CALL, and the static_call
> > infrastructure that I posted here:
> >
> >   https://lkml.kernel.org/r/20191007082708.013939311@infradead.org
> >
> > Has: JMP/RET, JMP/JMP and if it has inline patching support: NOP/CALL,
> > CALL/CALL, patching.
>
> Thanks for the info.  I took a bit time to look your patch set and
> Steven's patch set for dynamic function, though don't completely
> understand, but get more sense for the context.
>
> > Anyway, the below argument doesn't care much, it works for NOP/JMP just
> > fine.
>
> We can support NOP/JMP case as the first step, but later should can
> extend to support other transitions.
>
> > > we need to update dso cache for the
> > > 'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
> > > changed from branch to nop, we need to update dso cache for
> > > 'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
> > > branch instructions can be safely contained in the dso file and any
> > > branch samples can read out correct branch instruction.
> > >
> > > Could you confirm this is the same with your understanding?  Or I miss
> > > anything?  I personally even think the pair events can be used for
> > > different arches (e.g. the solution can be reused on Arm64/x86, etc).
> >
> > So the problem we have with PT is that it is a bit-stream of
> > branch taken/not-taken decisions. In order to decode that we need to
> > have an accurate view of the unconditional code flow.
> >
> > Both NOP/JMP are unconditional and we need to exactly know which of the
> > two was encountered.
>
> If I understand correctly, PT decoder needs to read out instructions
> from dso and decide the instruction type (NOP or JMP), and finally
> generate the accurate code flow.
>
> So PT decoder relies on (cached) DSO for decoding.  As I know, this
> might be different from Arm CS, since Arm CS decoder is merely
> generate packets and it doesn't need to rely on DSO for decoding.
>
> I think my answer is not very convinced, in case I mislead, loop Mike
> to confirm for this.
>
The CoreSight decoder needs the same information. When a branch / call
instruction is traced an atom is generated in the trace to determine
if that call as taken or not.
During the decode process the decoder walks the code image to match up
atoms to call / branch instructions - which means for correct trace
decode we must have an accurate code image as executed, as otherwise
trace decode will go wrong.
Within perf, the OpenCSD decoder will call back into perf to ask for
the memory image for a given address - which perf will supply from the
list of .so / executable files it has in the .debug directory.

Self modifying code presents an issue in this respect.

Correlation of the modification information with the captured trace
becomes the primary concern.

Regards

Mike


> > With your scheme, I don't see how we can ever actually know that. When
> > we get the PRE event, all we really know is that we're going to change
> > a specific instruction into another. And at the POST event we know it
> > has been done. But in between these two events, we have no clue which of
> > the two instructions is live on which CPU (two CPUs might in fact have a
> > different live instruction at the same time).
> >
> > This means we _cannot_ unambiguously decode a taken/not-taken decision
> > stream.
> >
> > Does CS have this same problem, and how would the PRE/POST events help
> > with that?
>
> My purpose is to use PRE event and POST event to update cached DSO,
> thus perf tool can read out 'correct' instructions and fill them into
> instruction/branch samples.  On the other hand, as mentioned, I don't
> aware the instruction read out from DSO will be used for Arm CS decoder;
> Arm CS also reads the instructions from DSO, usually it's used to decide
> instruction size or decide the sample flags (flags for CALL/RETURN/hw
> int, etc...), but it isn't used for decoder.
>
> @Mike, please help confirm for this as well, from Arm CoreSight's
> decoder pespective.
>
> > So our (x86) horrible (variable instruction length induced) complexity
> > for text poking is actually in our advantage this one time. The
> > exception and exception-return paths allow us to unambiguously know what
> > happens around the time of poking.
>
> Thanks a lot for the info!
> Leo.



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
