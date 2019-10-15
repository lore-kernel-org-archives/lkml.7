Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF97C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F4920872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXk34FGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfJODoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:44:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35987 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfJODoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:44:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so17932471qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 20:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=voz4i+v+frHsSQ8PRqlMxILgaKVhYjtinkOnPqt0d44=;
        b=wXk34FGCnDMKI8b3FXI7D9xaCgxD/y6Q9rbb36RCr0LZKiYrzCuPXbqv2Bv6VGoRuU
         bTe3ibnOMobN28LsH8Edn1hWcSPokpkncM7Dfgp1cAHTl7lYafygzCv7MlgbicKd/89a
         8fFFaCKGPceBmTMcYN/tocdizAYPV1VH1Cff0XEMQxaBspzTFgl9KHg0KoWB9nWhOod3
         tixOZVKvgzY3bMsxjury0RRAHv27CTPbiJI5//IXsThoIofDeEaMSWOuLhBsPnkzIk1s
         E3L8BRiamiDUaBRL9UP8ZcNv5CQJvGstxAO05J1za86dfWVGFd+OVPPWaEHkq0HAPnqi
         1vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=voz4i+v+frHsSQ8PRqlMxILgaKVhYjtinkOnPqt0d44=;
        b=mSf9NY1LtdjYyKQnLDu3y70NPbfL4NANqJ+mV5BUvbrOtJjWB3BZuGwA0+QJ1Fx/SW
         rnhBAgzSlGCGi6jY02YF62JtPSbErRhwwuxVDItIuUibsKnTAzx1zSpY+MRs01Uqa6tP
         FSy2X4nb8b9rSheLCJ2oidWx8sAS5VhXvgjGGScKjLZMDnbZoZpZHnTzeGwK8nz1Qca2
         APkMx2vPxnEhe2Nnp9l21weOj865jCoGw7iAfoVTcSlfFzXUqv/YMWO+rKrOzSvoxUm9
         mo/B21q5bV+7mlhqHCSmczEyyMkmBN15xrgqajQoGnbgFEK5V/NbGQ0oLPo58eVj2B1C
         gN9w==
X-Gm-Message-State: APjAAAX7MIAYQDZ6XDkgRVdmW69XizB/bhdmD7KceGNqfxDNKIqo7skP
        pWXJjJqwnsmFSKO45dsRJVq0LQ==
X-Google-Smtp-Source: APXvYqxl07qVjJTJXXP4+zknqXS+FKQmmzKDInMZVbg9FIyNlsJ+TQJsQjGD31aO1KIAXnprEVjLmw==
X-Received: by 2002:ae9:f50a:: with SMTP id o10mr33521733qkg.372.1571111048572;
        Mon, 14 Oct 2019 20:44:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id g194sm9801676qke.46.2019.10.14.20.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 20:44:07 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:44:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 6/6] perf cs-etm: Synchronize instruction sample with
 the thread stack
Message-ID: <20191015034400.GC6336@leoy-ThinkPad-X240s>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-7-leo.yan@linaro.org>
 <20191011201750.GD13688@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011201750.GD13688@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:17:50PM -0600, Mathieu Poirier wrote:
> On Sat, Oct 05, 2019 at 05:16:14PM +0800, Leo Yan wrote:
> > The synthesized flow use 'tidq->packet' for instruction samples; on the
> > other hand, 'tidp->prev_packet' is used to generate the thread stack and
> > the branch samples, this results in the instruction samples using one
> > packet ahead than thread stack and branch samples ('tidp->prev_packet'
> > vs 'tidq->packet').
> > 
> > This leads to an instruction's callchain error as shows in below
> > example:
> > 
> >   main  1579        100      instructions:
> >   	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> >   	ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
> >   	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> >   	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> >   	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> >   	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> >   	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> > 
> > In the callchain log, for the two continuous lines the up line contains
> > one child function info and the followed line contains the caller
> > function info, and so forth.  So the first two lines are:
> > 
> >   perf_event_update_userpage+0x4c  => the sampled instruction
> >   perf_event_update_userpage+0x48  => the parent function's calling
> > 
> > The child function and parent function both are the same function
> > perf_event_update_userpage(), but this isn't a recursive function, thus
> > the sequence for perf_event_update_userpage() calling itself shouldn't
> > never happen.  This callchain error is caused by the instruction sample
> > using an ahead packet than the thread stack, the thread stack is deferred
> > to process the new packet and misses to pop stack if it is just a return
> > packet.
> > 
> > To fix this issue, we can simply change to use 'tidq->prev_packet' to
> > generate the instruction samples, this allows the thread stack to push
> > and pop synchronously with instruction sample.  Finally, the callchain
> > can be displayed correctly as below:
> > 
> >   main  1579        100      instructions:
> > 	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> > 	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> > 	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> > 	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> > 	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> > 	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 56e501cd2f5f..fa969dcb45d2 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1419,7 +1419,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >  	struct cs_etm_packet *tmp;
> >  	int ret;
> >  	u8 trace_chan_id = tidq->trace_chan_id;
> > -	u64 instrs_executed = tidq->packet->instr_count;
> > +	u64 instrs_executed = tidq->prev_packet->instr_count;
> >  
> >  	tidq->period_instructions += instrs_executed;
> >  
> > @@ -1450,7 +1450,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >  		 */
> >  		s64 offset = (instrs_executed - instrs_over - 1);
> >  		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > -					      tidq->packet, offset);
> > +					      tidq->prev_packet, offset);
> 
> I have tested this set in --per-thread mode and things are working as
> advertised. Did you see how things look like in CPU-wide scenarios?

I am not sure I checked the callchain for CPU-wide scenarios, but I
didn't pay attention for the case when the trace data is switching
between CPUs, especially if connect with your comment in patch 03,
with wrong buffer ID it might cause the wrong callchain for CPU-wide
scenarios.

Will do more testing for CPU-wide scenarios in next spin.

Thanks for the suggestions.
Leo Yan

> Thanks,
> Mathieu
> 
> >  
> >  		ret = cs_etm__synth_instruction_sample(
> >  			etmq, tidq, addr, etm->instructions_sample_period);
> > -- 
> > 2.17.1
> > 
