Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29FECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711220872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r364D0CX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfJODdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:33:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42570 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJODdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:33:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so28525426qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 20:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IoqlYSn6f47iVl1XpzbZCGv/lzEESLkqVt79Fah3kvU=;
        b=r364D0CXUs/RIyg+BE17NPnWLo7+lJLvcslcFTnRlcBnQ15kuedlF4dvMOOBlAt7w0
         wQZLONeWcT+PqpWNjjdOgMdnNDTILLcVWJV1eI8+0VinCSriBxSV7UhF0JTnOmNhYITQ
         AUWtX/7PTApLH/QlyvGlsfwTDm9ZdYcQ6bHzw2T09dZLRRd9+b716K7i6N/+uAJQqf3B
         J52NG9bCO82Zt65nvxDtuXVlRx8kPM50d+aZaUtIz15J16RJUil4WdpnTGBoRXPMxs/F
         /ZUIWjgGN/wW9GTUu8uyjEw1IvuORXMPZFZjbrHcr4hgr//V8hnN4Gds/UMW6FbhjtEp
         lfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IoqlYSn6f47iVl1XpzbZCGv/lzEESLkqVt79Fah3kvU=;
        b=muIMYO1EIOPpG1V8NFpd3V1bNcvbKGpf3h5UbTK8NJsCvanz3aXJfJj/GTaYkUuxeB
         Unn/WdF4Jylwz4ZuQZfXsDJzJlNDdkokn445CundlCPOGVogYflesiI9T5J7YToXy1jH
         nL3mmCzZWVwDcayevKfGwYJWoOw2ZpBIvzZHKqKuvq+BlKyt4KvaIzJvZBTyq+FBPSsb
         a9QI8dlyVBF+OACu8UCE2rfj59D4zAb9aBxGIsnO/anqa72ct51zuL4BUOHsE0LE6143
         wqtmTSB71Mvc8ql+GU7+nSG5I5lmME71p3uR4jpV1SuEqSO+JUrsEh0a6XaTBnmaL7m6
         vPuw==
X-Gm-Message-State: APjAAAWzEDMFvjJkWQXXUONEm52j0x0nZL+NA9KhHKl+szLpSc1zxxQ/
        OulVOPAGX2Z5ToHqRGUIChPq6A==
X-Google-Smtp-Source: APXvYqwF0LiIAkUb+Pei6jRulZDB2CLozJpjxik4oEXpRN60Qj+NAFS0aBAdJXYSXLMlJ0gA3tBStw==
X-Received: by 2002:a0c:95a5:: with SMTP id s34mr16780251qvs.72.1571110417517;
        Mon, 14 Oct 2019 20:33:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id w85sm9460755qkb.57.2019.10.14.20.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 20:33:36 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:33:27 +0800
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
Subject: Re: [PATCH v3 3/6] perf cs-etm: Support thread stack
Message-ID: <20191015033327.GB6336@leoy-ThinkPad-X240s>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-4-leo.yan@linaro.org>
 <20191011175353.GA13688@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011175353.GA13688@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Oct 11, 2019 at 11:53:53AM -0600, Mathieu Poirier wrote:
> On Sat, Oct 05, 2019 at 05:16:11PM +0800, Leo Yan wrote:
> > Since Arm CoreSight doesn't support thread stack, the decoding cannot
> > display symbols with indented spaces to reflect the stack depth.
> > 
> > This patch adds support thread stack for Arm CoreSight, this allows
> > 'perf script' to display properly for option '-F,+callindent'.
> > 
> > Before:
> > 
> >   # perf script -F,+callindent
> >             main  2808          1          branches: coresight_test1                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
> >             main  2808          1          branches: printf@plt                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
> >             main  2808          1          branches: printf@plt                           aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
> >             main  2808          1          branches: _init                                aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
> >             main  2808          1          branches: _dl_fixup                            ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.so)
> >             main  2808          1          branches: _dl_lookup_symbol_x                  ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
> >   [...]
> > 
> > After:
> > 
> >   # perf script -F,+callindent
> >             main  2808          1          branches:                 coresight_test1                                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
> >             main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
> >             main  2808          1          branches:                     printf@plt                                       aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
> >             main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
> >             main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
> >             main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
> >   [...]
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 58ceba7b91d5..780abbfd1833 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1117,6 +1117,45 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> >  			   sample->insn_len, (void *)sample->insn);
> >  }
> >  
> > +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> > +				    struct cs_etm_traceid_queue *tidq)
> > +{
> > +	struct cs_etm_auxtrace *etm = etmq->etm;
> > +	u8 trace_chan_id = tidq->trace_chan_id;
> > +	int insn_len;
> > +	u64 from_ip, to_ip;
> > +
> > +	if (etm->synth_opts.thread_stack) {
> > +		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
> > +		to_ip = cs_etm__first_executed_instr(tidq->packet);
> > +
> > +		insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > +					      tidq->prev_packet->isa, from_ip);
> > +
> > +		/*
> > +		 * Create thread stacks by keeping track of calls and returns;
> > +		 * any call pushes thread stack, return pops the stack, and
> > +		 * flush stack when the trace is discontinuous.
> > +		 */
> > +		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
> > +				    tidq->prev_packet->flags,
> > +				    from_ip, to_ip, insn_len,
> > +				    etmq->buffer->buffer_nr);
> 
> Details are a little fuzzy in my head but I'm pretty sure
> we want trace_chan_id here.  

Thanks a lot for reviewing!

This is good point.  After a quick look for the code, seems
TO_CS_QUEUE_NR() is the right thing to use at here for buffer
number.

Will look more closely to the code and apply changes in next
version.

Thanks,
Leo Yan

> > +	} else {
> > +		/*
> > +		 * The thread stack can be output via thread_stack__process();
> > +		 * thus the detailed information about paired calls and returns
> > +		 * will be facilitated by Python script for the db-export.
> > +		 *
> > +		 * Need to set trace buffer number and flush thread stack if the
> > +		 * trace buffer number has been alternate.
> > +		 */
> > +		thread_stack__set_trace_nr(tidq->thread,
> > +					   tidq->prev_packet->cpu,
> > +					   etmq->buffer->buffer_nr);
> 
> Same here.
> 
> > +	}
> > +}
> > +
> >  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >  					    struct cs_etm_traceid_queue *tidq,
> >  					    u64 addr, u64 period)
> > @@ -1393,6 +1432,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >  		tidq->period_instructions = instrs_over;
> >  	}
> >  
> > +	if (tidq->prev_packet->last_instr_taken_branch)
> > +		cs_etm__add_stack_event(etmq, tidq);
> > +
> >  	if (etm->sample_branches) {
> >  		bool generate_sample = false;
> >  
> > @@ -2593,6 +2635,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  		itrace_synth_opts__set_default(&etm->synth_opts,
> >  				session->itrace_synth_opts->default_no_sample);
> >  		etm->synth_opts.callchain = false;
> > +		etm->synth_opts.thread_stack =
> > +				session->itrace_synth_opts->thread_stack;
> >  	}
> >  
> >  	err = cs_etm__synth_events(etm, session);
> > -- 
> > 2.17.1
> > 
