Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B3ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6D72084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GffoRzk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfJWGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:49:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34306 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWGtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:49:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so11013841qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kvpjxtScXgXjfdUkU4TdG5xrgeslRCzjrCl+So6ijK0=;
        b=GffoRzk85s4gzEnNGrEuNLLealKCdTMGkfhw9aBrWgOECrJwtnhn2eE/n+OnrDy8Jh
         5XqxN6+Ho6bL6Ud3oJRhNw1dYIMhP4RNcVCowrIdqFnea904/rJVTtRot4bnX4IS8ncz
         0AWx0os2UW6b69sH8hdeaxPKAjQq9WSUqcqcXVV9QHfphDoRDkWQT4ESKlkZwlkIqDKK
         w8OD90AfYFhmdVrpEARIDEm4oi2uO2dwFAgS7DwG45MIMWN2sr73L4drSuKgtTBa5YOT
         R1caMRE29agTzgDKaUJHKPyUQj+o0BaJXG5HSMVJcqZCA9s9h/j3PMLxB638q3PFBwtv
         Ivdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kvpjxtScXgXjfdUkU4TdG5xrgeslRCzjrCl+So6ijK0=;
        b=iMdnxewwIOzESFtUQHNt8insnD6hztL7kKD6RZakUhrZUfzqChgGwiKB4LX6FppXRP
         Jfo/09UJD86If6fIOgZCIoDiHmsxYtQM/b3xZyfO7x11wP7/5HM/pPrXWGkpwJm4mOOu
         P/wN8o4BzZGVV1QkTQnZzJltieR6MhtYhuQo4+RuFnMmir9LFTu11CixQGA3jqIvYPVf
         LQfN3YdI2xtL4SFikVNNWr/rymIz/iS1fT5BZONKuUANbce8hg5W9cI+JyIJkBnSoCQ0
         TnIz41KNS+QrBGriXo1BN+QQzjZ83qQdAZaGfOEw/KMsKW6QDIxjHPfvuf5C3qUVv49m
         vCnA==
X-Gm-Message-State: APjAAAUXgMeVuCUY0HnQITijbFrV4p1oBs7wTIrch5LxaCjeQUsvsmM0
        sbaye1Zq2/6HVI/r6D2eqzhkEA==
X-Google-Smtp-Source: APXvYqxSMXYVdzqMGxUGCqPoW6dmW+edXWvsmS8YXC8pKkUTaJq/xBnl3xXbQzGVKbe9WEp/dSPbjQ==
X-Received: by 2002:ac8:89c:: with SMTP id v28mr7535979qth.156.1571813377114;
        Tue, 22 Oct 2019 23:49:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id d126sm8134132qkc.93.2019.10.22.23.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 23:49:36 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:49:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 1/6] perf cs-etm: Fix unsigned variable comparison to
 zero
Message-ID: <20191023064926.GB29009@leoy-ThinkPad-X240s>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-2-leo.yan@linaro.org>
 <20191011201606.GC13688@xps15>
 <20191022051020.GC32731@leoy-ThinkPad-X240s>
 <CAJ9a7VgLevM0mZV7tR=Uq8k5-9ZbrwCGM2KoetU8B4V-WFfTsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgLevM0mZV7tR=Uq8k5-9ZbrwCGM2KoetU8B4V-WFfTsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Oct 23, 2019 at 12:36:39AM +0100, Mike Leach wrote:
> Hi Leo,
> 
> Two points here - both related.
> 
> On Tue, 22 Oct 2019 at 06:10, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Hi Mathieu,
> >
> > On Fri, Oct 11, 2019 at 02:16:06PM -0600, Mathieu Poirier wrote:
> > > On Sat, Oct 05, 2019 at 05:16:09PM +0800, Leo Yan wrote:
> > > > If the u64 variable 'offset' is a negative integer, comparison it with
> > > > bigger than zero is always going to be true because it is unsigned.
> > > > Fix this by using s64 type for variable 'offset'.
> > > >
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  tools/perf/util/cs-etm.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > > index 4ba0f871f086..4bc2d9709d4f 100644
> > > > --- a/tools/perf/util/cs-etm.c
> > > > +++ b/tools/perf/util/cs-etm.c
> > > > @@ -940,7 +940,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
> > > >  static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> > > >                                  u64 trace_chan_id,
> > > >                                  const struct cs_etm_packet *packet,
> > > > -                                u64 offset)
> > > > +                                s64 offset)
> > >
> Issue 1:
> 
> OK - it appears that cs_etm__instr_addr() is supposed to be returning
> the address within the current trace sample of the instruction related
> to offset.
> For T32 - then if offset < 0, packet->start_addr is returned - not
> good but at least within the current trace range
> For A32/A64 - if offset < 0 then an address _before_
> packet->start_addr is returned - clearly wrong and possibly a
> completely invalid address that was never actually traced.

Exactly, if offset < 0 it might output the incorrect trace.

> > > In Suzuki's reply there was two choices, 1) move the while(offset > 0) to
> > > while (offset) or change the type of @offset to an s64.  Here we know offset
> > > can't be negative because of the
> > >         tidq->period_instructions >= etm->instructions_sample_period
> > >
> > > in function cs_etm__sample().  As such I think option #1 is the right way to
> > > deal with this rather than changing the type of the variable.
> >
> > I took sometime to use formulas to prove that 'offset' is possible to
> > be a negative value :)
> >
> > Just paste the updated commit log at here for review:
> >
> >   Pi: period_instructions
> >   Ie: instrs_executed
> >   Io: instrs_over
> >   Ip: instructions_sample_period
> >
> >   Pi' = Pi + Ie   -> New period_instructions equals to the old
> >                      period_instructions + instrs_executed
> >   Io  = Pi' - Ip  -> period_instructions - instructions_sample_period
> >
> >   offset = Ie - Io - 1
> >          = Ie - (Pi' - Ip) -1
> >          = Ie - (Pi + Ie - Ip) -1
> >          = Ip - Pi - 1
> >
> > In theory, if Ip (instructions_sample_period) is small enough and Pi
> > (period_instructions) is bigger than Ip, then it will lead to the
> > negative value for 'offset'.
> >
> > So let's see below command:
> >
> >   perf inject --itrace=i1il128 -i perf.data -o perf.data.new
> >
> > With this command, 'offset' is very easily to be a negative value when
> > handling packets; this is because if use the inject option 'i1', then
> > instructions_sample_period equals to 1; so:
> >
> >   offset = 1 - Pi - 1
> >          = -Pi
> >
> > Any Pi bigger than zero leads 'offset' to a negative value.
> >
> > Thanks,
> > Leo Yan
> >
> 
> Issue 2:
> 
> Assuming I have understood the logic of this code correctly - there is
> an issue were sample_period < period_instructions as you say -
> but I believe the problem is in the logic of the sampling function itself.
> 
> Suppose we have a sample_period of 4.
> 
> Now on an initial pass through the function, period_instructions must
> be 0. (i.e. none left over from the previous pass.)
> Suppose also that the number of instructions executed in this sample
> is 10 - thus updating period_instructions.
> Therefore:
> instr_over = 10 - 4 -> 6
> offset = 10 - 6 - 1 -> 3.
> We therefore call cs_etm_instr_addr to find the address an offset of 3
> instructions from the start of the trace sample and synthesize the
> sample.
> After this we set period_instructions to the instr_over value of 6.
> 
> Next pass, assume 10 instructions in the trace sample again.
> period_instructions = 6 + 10 -> 16
> instr_over = 16 - 4 -> 12
> offset = 10 - 12 - 1 -> -3  - the negative value your formulae predict.
> 
> This implies that the sample we want is actually in the previous trace
> packet - which I believe is in fact the case - as explained below.
> 
> My reading of the code is that cs_etm__sample() is called once per
> trace range packet extracted from the decoder - and a trace range
> packet represents N instructions_executed.
> Further I am assuming that instructions_sample_period represents the
> desired periodicity of the instruction samples - i.e. 1 sample every
> instructions_sample_period number of instructions.

Good point.  Yeah, this is the root cause.

> Thus my conclusion here is that where M = instructions_executed +
> period_instructions, the function should generate quotient ( M /
> instructions_sample_period ) samples and set period_instructions to M
> mod instructions_sample_period on exit, ensuring period_instructions
> is never larger than the sample_period.

Totally agree with this; we should generate synthetic samples without
dropping trace data.

> i.e. loop to generate multiple samples until instr_over and therefore
> the output value of period_instructions is less than the value of
> instructions_sample_period - for the example above, with 10
> instructions and a periodicity of 4, we generate 2 samples with a
> remainder of 2 instructions carried forwards.
> 
> In short leave offset as unsigned and fix the logic of the
> cs_etm__sample() function.

Will follow up this suggestion.

Very appreciate your time to review and gave out much reasonable
solution!

Thanks,
Leo Yan

> > > >  {
> > > >     if (packet->isa == CS_ETM_ISA_T32) {
> > > >             u64 addr = packet->start_addr;
> > > > @@ -1372,7 +1372,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> > > >              * sample is reported as though instruction has just been
> > > >              * executed, but PC has not advanced to next instruction)
> > > >              */
> > > > -           u64 offset = (instrs_executed - instrs_over - 1);
> > > > +           s64 offset = (instrs_executed - instrs_over - 1);
> > > >             u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > > >                                           tidq->packet, offset);
> > > >
> > > > --
> > > > 2.17.1
> > > >
> 
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
