Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21928ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97BF206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFAmu9vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfJKRx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:53:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42632 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKRx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:53:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so4785795pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qgzfqj6sxvLl+nWKisyq4PH5jXle+OPHl08Pk/Xlhsw=;
        b=XFAmu9vxP7eFOCLOKNj/NHpDOwxfNt71RntEp2l7ofcGL52eyVuwXsCIe8ZERMlkfQ
         BGtkhO//mpmTcmlEzHJyXNui8FBxQl9p1yvwiEI5NDFlYn2fGOQ6n1kPknpZ0hMdWjuG
         pMFTXnvP8tPLmV5lthtkug0clYn9CHVij7ElmoSNCfFFZq3A8P4Mu8byVBpkZQlw0lpZ
         f20FWuVGBJirlRVIwfk+bMPm2rilNqHPMi4wDuV64/JJBBvdfmcw6kMff/oCfTGYKupr
         FD2EsPNy3KBqn+BIZWN342L8v1Lwd62u49kB66L3gN4+5keoOFBZfkOWLa3rnnJJ0Yju
         X0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qgzfqj6sxvLl+nWKisyq4PH5jXle+OPHl08Pk/Xlhsw=;
        b=PLKfdE755OOd4187950ee9q/srK/34CAb+rUisF905c9RHyBHQQmW6lQfXOdixdKF7
         oX0VJ/Z+kkx85y1+ISorOOTpIBBgCZ1MNH018jcP0ODwBgAgvy+d4ho9suOe7WVpp8PM
         Ym8xF4k/R58Eizcc1dVG3p0AqO4CjPDVoFKm4izDnwIyflrs1np+RAbz4KNkLwoWtFE/
         T6092jt0EEueBA4uTm3atB3cCHqgWySMoHLtlWALuGMybtgS6fzXoQHodFChIkz7hrkC
         67TELIZ1p0R7gufbuPZv/pt5PcfnG/p4xN+JKCw0AifcfY4flRWxTVl+P7DC1qzj6em5
         FelA==
X-Gm-Message-State: APjAAAWUuDhcG2KcbIVGeAHwdLdKxaOG8ARH5OSptwDROQnZUz83CKwz
        uSW+TDN+ggByCGh5DoW1E73Z3w==
X-Google-Smtp-Source: APXvYqwXraISadvG5/9oA2Hw4IVHCd6smGm+dh76RTLray/g6iCvl+deoh/FyzRpWEFCwmXB3EjjUw==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr15426654plt.187.1570816436891;
        Fri, 11 Oct 2019 10:53:56 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s97sm13598540pjc.4.2019.10.11.10.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 10:53:56 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:53:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20191011175353.GA13688@xps15>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005091614.11635-4-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 05:16:11PM +0800, Leo Yan wrote:
> Since Arm CoreSight doesn't support thread stack, the decoding cannot
> display symbols with indented spaces to reflect the stack depth.
> 
> This patch adds support thread stack for Arm CoreSight, this allows
> 'perf script' to display properly for option '-F,+callindent'.
> 
> Before:
> 
>   # perf script -F,+callindent
>             main  2808          1          branches: coresight_test1                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
>             main  2808          1          branches: printf@plt                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
>             main  2808          1          branches: printf@plt                           aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
>             main  2808          1          branches: _init                                aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
>             main  2808          1          branches: _dl_fixup                            ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.so)
>             main  2808          1          branches: _dl_lookup_symbol_x                  ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
>   [...]
> 
> After:
> 
>   # perf script -F,+callindent
>             main  2808          1          branches:                 coresight_test1                                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
>             main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
>             main  2808          1          branches:                     printf@plt                                       aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
>             main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
>             main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
>             main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
>   [...]
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 58ceba7b91d5..780abbfd1833 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1117,6 +1117,45 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>  			   sample->insn_len, (void *)sample->insn);
>  }
>  
> +static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
> +				    struct cs_etm_traceid_queue *tidq)
> +{
> +	struct cs_etm_auxtrace *etm = etmq->etm;
> +	u8 trace_chan_id = tidq->trace_chan_id;
> +	int insn_len;
> +	u64 from_ip, to_ip;
> +
> +	if (etm->synth_opts.thread_stack) {
> +		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
> +		to_ip = cs_etm__first_executed_instr(tidq->packet);
> +
> +		insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> +					      tidq->prev_packet->isa, from_ip);
> +
> +		/*
> +		 * Create thread stacks by keeping track of calls and returns;
> +		 * any call pushes thread stack, return pops the stack, and
> +		 * flush stack when the trace is discontinuous.
> +		 */
> +		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
> +				    tidq->prev_packet->flags,
> +				    from_ip, to_ip, insn_len,
> +				    etmq->buffer->buffer_nr);

Details are a little fuzzy in my head but I'm pretty sure
we want trace_chan_id here.  


> +	} else {
> +		/*
> +		 * The thread stack can be output via thread_stack__process();
> +		 * thus the detailed information about paired calls and returns
> +		 * will be facilitated by Python script for the db-export.
> +		 *
> +		 * Need to set trace buffer number and flush thread stack if the
> +		 * trace buffer number has been alternate.
> +		 */
> +		thread_stack__set_trace_nr(tidq->thread,
> +					   tidq->prev_packet->cpu,
> +					   etmq->buffer->buffer_nr);

Same here.

> +	}
> +}
> +
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
>  					    u64 addr, u64 period)
> @@ -1393,6 +1432,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  		tidq->period_instructions = instrs_over;
>  	}
>  
> +	if (tidq->prev_packet->last_instr_taken_branch)
> +		cs_etm__add_stack_event(etmq, tidq);
> +
>  	if (etm->sample_branches) {
>  		bool generate_sample = false;
>  
> @@ -2593,6 +2635,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  		itrace_synth_opts__set_default(&etm->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
>  		etm->synth_opts.callchain = false;
> +		etm->synth_opts.thread_stack =
> +				session->itrace_synth_opts->thread_stack;
>  	}
>  
>  	err = cs_etm__synth_events(etm, session);
> -- 
> 2.17.1
> 
