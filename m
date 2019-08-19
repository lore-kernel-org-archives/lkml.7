Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F197C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FA220651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMzxpQTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSOX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:23:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46154 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfHSOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:23:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id j15so2034639qtl.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NoobpusK4yG5cX6tMUa8vsNXDOHEAtCqla6w11qGBeg=;
        b=YMzxpQTKGZcMHNMrPYnJbtwdRME/HfddMnPIrqi68D+3I52i+gKYc//iY/6PaXWHSi
         0tQ7/xQOewlgmzjyEiz/+NsVDVKUir2VGfF0oopVcyt5s7nUniRX+tG+oGl3aGIRZZA5
         9WboJGRC0cH6N92HaOF2Lf3r0exPpv2YP/jjsgOss/xQC6cI0R3eALwXB1X6IzS8d/2O
         w/54HvyejDwoJNtlZ0tog2dJRT54bCqG76IhgxyhuJ3LXzHnRMsAuSoslaqLDMs3NbCi
         k00CtRqnaJxZHu5FMEH0cZ2LAhi9xUj8XszWHQmYzjJLFU5zjRY3oHH5hI6hf3PerrwZ
         Pk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NoobpusK4yG5cX6tMUa8vsNXDOHEAtCqla6w11qGBeg=;
        b=W3mrAWTc3frmULlse/MYH3xEHJPAJnKWJ9IrEwSp8NnY5ZtwdDT4X3QAy+W8p1UyuK
         dYoAkrrAcVyda2H6mNQENFCTI2h/ofRnRUWRQPotPbDQJbmql6nByWj9U8qfq5nN2lvB
         KN9FTGWO9BECo2D2lYzAJT1RThSemrgKIk81SEXj9oNkatzc4PtxCfpCNaKM6t+SOrU2
         gqVET81Jrmbx6VjaubYoqO2ZhTR5U4wbG6YxR0pD+0QoJTYPlawJ3D2PQGMhLAjwrRpi
         EzZUoRTk9MiGN0MxfkQduJFpR/uhN7gcdQcDOJZaD9gZk7RRq7mKeclSB0AwkTZZX2fx
         EI3A==
X-Gm-Message-State: APjAAAV0Vs97xskelYIUhS8ovwAMWuFGs8X71f08tqsVa7l8DDcoRXwh
        P9FplPfUTlRItIJqS+IyqhJUof6r
X-Google-Smtp-Source: APXvYqyyFX1YRAjLAeY4vLs7OQCJWItqPaXpUsXb8rupeWJMsmaorF3PVx+/vyfO2xc3u+8s3d0ngQ==
X-Received: by 2002:aed:3e6f:: with SMTP id m44mr21158845qtf.220.1566224605229;
        Mon, 19 Aug 2019 07:23:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m38sm8416659qta.43.2019.08.19.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:23:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 732DB40340; Mon, 19 Aug 2019 11:23:21 -0300 (-03)
Date:   Mon, 19 Aug 2019 11:23:21 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and
 'insnlen'
Message-ID: <20190819142321.GB29674@kernel.org>
References: <20190815082854.18191-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815082854.18191-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 15, 2019 at 04:28:54PM +0800, Leo Yan escreveu:
> The synthetic branch and instruction samples are missed to set
> instruction related info, thus perf tool fails to display samples with
> flags '-F,+insn,+insnlen'.
> 
> CoreSight trace decoder has provided sufficient information to decide
> the instruction size based on the isa type: A64/A32 instruction are
> 32-bit size, but one exception is the T32 instruction size, which might
> be 32-bit or 16-bit.
> 
> This patch handles for these cases and it reads the instruction values
> from DSO file; thus can support flags '-F,+insn,+insnlen'.

Mathieu, can I have your Acked-by/Reviewed-by?

- Arnaldo
 
> Before:
> 
>   # perf script -F,insn,insnlen,ip,sym
>                 0 [unknown] ilen: 0
>      ffff97174044 _start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
> 
>   [...]
> 
> After:
> 
>   # perf script -F,insn,insnlen,ip,sym
>                 0 [unknown] ilen: 0
>      ffff97174044 _start ilen: 4 insn: 2f 02 00 94
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> 
>   [...]
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ed6f7fd5b90b..b3a5daaf1a8f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1076,6 +1076,35 @@ bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
>  	return !!etmq->etm->timeless_decoding;
>  }
>  
> +static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> +			      u64 trace_chan_id,
> +			      const struct cs_etm_packet *packet,
> +			      struct perf_sample *sample)
> +{
> +	/*
> +	 * It's pointless to read instructions for the CS_ETM_DISCONTINUITY
> +	 * packet, so directly bail out with 'insn_len' = 0.
> +	 */
> +	if (packet->sample_type == CS_ETM_DISCONTINUITY) {
> +		sample->insn_len = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> +	 * cs_etm__t32_instr_size().
> +	 */
> +	if (packet->isa == CS_ETM_ISA_T32)
> +		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> +							  sample->ip);
> +	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +	else
> +		sample->insn_len = 4;
> +
> +	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> +			   sample->insn_len, (void *)sample->insn);
> +}
> +
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
>  					    u64 addr, u64 period)
> @@ -1097,9 +1126,10 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	sample.period = period;
>  	sample.cpu = tidq->packet->cpu;
>  	sample.flags = tidq->prev_packet->flags;
> -	sample.insn_len = 1;
>  	sample.cpumode = event->sample.header.misc;
>  
> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +
>  	if (etm->synth_opts.last_branch) {
>  		cs_etm__copy_last_branch_rb(etmq, tidq);
>  		sample.branch_stack = tidq->last_branch;
> @@ -1159,6 +1189,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	sample.flags = tidq->prev_packet->flags;
>  	sample.cpumode = event->sample.header.misc;
>  
> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet,
> +			  &sample);
> +
>  	/*
>  	 * perf report cannot handle events without a branch stack
>  	 */
> -- 
> 2.17.1

-- 

- Arnaldo
