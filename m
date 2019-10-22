Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D17CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6542E21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPNVYnvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfJVEvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:51:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37539 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJVEvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:51:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id u184so15103759qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhE0BiOWbSotl8PTLN0fddcL2KciWl/t4dXV2oBgdnU=;
        b=oPNVYnvNqR8oa84B3inhDRmoM01TIeAMqjjHZFXk4JsSurZpnvtKOkh4b98IKFBB2f
         lvsTNTHM3bRCLiDgMnYDiYp/D9HLkIPmH3I5hFyyND96z3LsmNNCmuYlHc5F315F0dBg
         Z1TnWwx9GDWE8CpV/YAMhfqhZPkz+5MFCddSiES6l7LjmFAJ73ekLir3cedR6v2HVern
         grmFHxQozZdPjYrQRkxYvfYUVZCfsWAuAn5j7g/njhcDpwrpdGoI/RH47QzGCnxdvtl8
         b6hqUtKIHFfyn+h2oTYkeCFX9M5txN/lnY1vuxJ0TjMagrE+eman5AI1Q8BfRSnjc4yP
         n3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhE0BiOWbSotl8PTLN0fddcL2KciWl/t4dXV2oBgdnU=;
        b=CYpQ+zfUhFJ6LV9jtrw5SO24N60rF+c8TvfKNaIccTsOKZripspDCBV+PxTF7dZvbJ
         IpHqRFsEZ0VW2BBaK7+1Js182xynuxHk5D2oeeKX0TlgVVilMXyfpwSkGnVjQVLSQUbe
         9N512J4AFdUvbQGeCfWK13I3muEwCZhmuA6etQawnmIsJ5h82IrOZNfMoJ0+Ke+n4lzg
         RaopgR9szYWAfN3bvSCjq1Ri8W5SMfT4NJDVAj33ua52keBFU4vqNmTxWXqnVzvQWrzX
         /o20d5HSrqI2+1pTzGJ6Ig8Og+fEj7DZgL/4yjxGG/GYpS5CufN05oYgX/PS7fnt1600
         77og==
X-Gm-Message-State: APjAAAXpsalrRv3QoJ+8hZ2AnFZYj2Azvwc1DRs0mGekV2+8Y9yL9HrB
        iYMU5D/dWYvza5mzIb0cbemLAw==
X-Google-Smtp-Source: APXvYqxX/mdwzdRA1MhUwGtathV624q7bOnwC2Utu+mJ/Te5PKIfaJbNB5xbuQ0Wj/Hq/ahA0rEQKw==
X-Received: by 2002:a37:98c1:: with SMTP id a184mr1186077qke.119.1571719869348;
        Mon, 21 Oct 2019 21:51:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id c18sm8377191qkk.17.2019.10.21.21.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 21:51:08 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:50:59 +0800
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
Message-ID: <20191022045059.GA32731@leoy-ThinkPad-X240s>
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

Hi Mathieu,

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

After some testing, I can confirm this patch set can works well for
CPU-wide trace; the reason is in the arch/arm/util/cs-etm.c, function
cs_etm_recording_options() has enabled option 'ETM_OPT_CTXTID' for
CPU-wide trace:

         /*
          * In the case of per-cpu mmaps, we need the CPU on the
          * AUX event.  We also need the contextID in order to be notified
          * when a context switch happened.
          */
         if (!perf_cpu_map__empty(cpus)) {
                 perf_evsel__set_sample_bit(cs_etm_evsel, CPU);

                 err = cs_etm_set_option(itr, cs_etm_evsel,
                                         ETM_OPT_CTXTID | ETM_OPT_TS);
                 if (err)
                         goto out;
         }

As result, we don't need to specify extra option to enable CTXID
configuration.  So below two commands have the same behaviour:

  # perf record -e cs_etm/@tmc_etr0/ -a -- sh test.sh
  # perf record -e cs_etm/@tmc_etr0,config=0x4000/ -a -- sh test.sh
                                       `-> bit 14: for ETM_OPT_CTXTID

Since the decoding will set tid when receive the packet
'OCSD_GEN_TRC_ELEM_PE_CONTEXT', thus it can give the correct tid/pid
info for threads.  This allows to generate per thread stack base on
thread->tid and avoid mixing info cross different threads.

Thanks,
Leo Yan

> >  
> >  		ret = cs_etm__synth_instruction_sample(
> >  			etmq, tidq, addr, etm->instructions_sample_period);
> > -- 
> > 2.17.1
> > 
