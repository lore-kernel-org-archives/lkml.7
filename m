Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D6920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na8SMkum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfFFSum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:50:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42247 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfFFSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:50:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so3900976qtk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPjIDaSr6FkA7bqc7rZDNYmItArE1JLkVlpY4cmTAkA=;
        b=na8SMkumgsCGR2JK3U8mr4k0O63d4h0Ssmx10pw5PTxRcU3CAAtTLpZAWYwlW8IcKT
         uOVsQd7NmhyU15+qW7CMieNLGGJlOpSBesTOEmozLOpavoTSnjo2QNV+vlHlaS0YxbOY
         4WJxsxeC3lLP/QBUrQSmy13ecpcuuVoCRiUq4vmsSIr1D9Lhs5FfuK3rzmiXYl8wpXOC
         tvMppHEdl+WuD0Xj9EsKdEQkpVNIBxXSuGYpsQQQkVRe/aQBwfpPE2xGv+RtcDW03AFm
         5IuR41pS43IMWOJZio87fVAoS9XIcD03fpJwN7HkgXbD4jAI4yJ8UyvmhgZ1iutYqJkI
         6JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPjIDaSr6FkA7bqc7rZDNYmItArE1JLkVlpY4cmTAkA=;
        b=dJbukshjtI8mJ9eS9DsFt+aZjDww+SQNsbeSC3ZXbhb26lpSrcPBIfgvUAAyDS56aY
         Ff51FO5DKjtGhWfmCEBxmcFau9nKjLDWWu2GKYFyHAQ9bv+xT9J/OQOxNiUO6NFxtrqx
         EvwAh+rZPYfOh47I8Kv9I/4MICChZwGV7pqqcqv/XXaEtyaF4waUiftxwiLtVnCtt/xl
         3GQ/QAW9bTk3za2Xdr0UNN9XXvE0uouMaTLhrGPvzSlFhGzl0RP42XPDQEHuPFvFmxrd
         C/pgD+R1g0TL5N7kgG5R5/RZoq2i+Rh2JbJCgTm1GUl5Jx3fX97aa1WeLNznGvCV25Lt
         siww==
X-Gm-Message-State: APjAAAWHIvZF+Hf0fPNQaJJSuyWLe3I/5+M6Wt3pTiIHwfT4sF7eEUOW
        lK61ZKMN8J9QTZG4xBGaFLI=
X-Google-Smtp-Source: APXvYqxEd/gKGrAO7AJBX28cYvPIk+h4rrhWpxU6HFbtOydmBD48nkMsSjbOKFoEX0KVJf3cK9t1ZA==
X-Received: by 2002:ac8:2c6a:: with SMTP id e39mr43314506qta.179.1559847040459;
        Thu, 06 Jun 2019 11:50:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.167])
        by smtp.gmail.com with ESMTPSA id q37sm1649431qtj.94.2019.06.06.11.50.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 11:50:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12FBB41149; Thu,  6 Jun 2019 15:50:28 -0300 (-03)
Date:   Thu, 6 Jun 2019 15:50:27 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 16/17] perf tools: Add notion of time to decoding code
Message-ID: <20190606185027.GF21245@kernel.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
 <20190524173508.29044-17-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524173508.29044-17-mathieu.poirier@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 24, 2019 at 11:35:07AM -0600, Mathieu Poirier escreveu:
> This patch deals with timestamp packets received from the decoding library
> in order to give the front end packet processing loop a handle on the time
> instruction conveyed by range packets have been executed at.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 112 +++++++++++++++++-
>  tools/perf/util/cs-etm.c                      |  19 +++
>  tools/perf/util/cs-etm.h                      |  17 +++
>  3 files changed, 144 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index ce85e52f989c..33e975c8d11b 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -269,6 +269,76 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
>  						     trace_config);
>  }
>  
> +static ocsd_datapath_resp_t
> +cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
> +				  struct cs_etm_packet_queue *packet_queue,
> +				  const uint8_t trace_chan_id)
> +{
> +	/* No timestamp packet has been received, nothing to do */
> +	if (!packet_queue->timestamp)
> +		return OCSD_RESP_CONT;
> +
> +	packet_queue->timestamp = packet_queue->next_timestamp;
> +
> +	/* Estimate the timestamp for the next range packet */
> +	packet_queue->next_timestamp += packet_queue->instr_count;
> +	packet_queue->instr_count = 0;
> +
> +	/* Tell the front end which traceid_queue needs attention */
> +	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
> +
> +	return OCSD_RESP_WAIT;
> +}
> +
> +static ocsd_datapath_resp_t
> +cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
> +				  const ocsd_generic_trace_elem *elem,
> +				  const uint8_t trace_chan_id)
> +{
> +	struct cs_etm_packet_queue *packet_queue;
> +
> +	/* First get the packet queue for this traceID */
> +	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
> +	if (!packet_queue)
> +		return OCSD_RESP_FATAL_SYS_ERR;
> +
> +	/*
> +	 * We've seen a timestamp packet before - simply record the new value.
> +	 * Function do_soft_timestamp() will report the value to the front end,
> +	 * hence asking the decoder to keep decoding rather than stopping.
> +	 */
> +	if (packet_queue->timestamp) {
> +		packet_queue->next_timestamp = elem->timestamp;
> +		return OCSD_RESP_CONT;
> +	}
> +
> +	/*
> +	 * This is the first timestamp we've seen since the beginning of traces
> +	 * or a discontinuity.  Since timestamps packets are generated *after*
> +	 * range packets have been generated, we need to estimate the time at
> +	 * which instructions started by substracting the number of instructions
> +	 * executed to the timestamp.
> +	 */
> +	packet_queue->timestamp = elem->timestamp -
> +						packet_queue->instr_count;

No need to break lines like that, in this case it even wouldn't pass the
width used for the comments right above it :-)

I'm fixing it up this time.

Something else, all the patches in this series, so far, needed to have
as the subject prefix "perf cs-etm: ...", not the generic one "perf
tools: ...". I'm fixing it up as well, no need to resend.

- Arnaldo

> +	packet_queue->next_timestamp = elem->timestamp;
> +	packet_queue->instr_count = 0;
> +
> +	/* Tell the front end which traceid_queue needs attention */
> +	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
> +
> +	/* Halt processing until we are being told to proceed */
> +	return OCSD_RESP_WAIT;
> +}
> +
> +static void
> +cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
> +{
> +	packet_queue->timestamp = 0;
> +	packet_queue->next_timestamp = 0;
> +	packet_queue->instr_count = 0;
> +}
> +
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
>  			      const u8 trace_chan_id,
> @@ -310,7 +380,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
>  }
>  
>  static ocsd_datapath_resp_t
> -cs_etm_decoder__buffer_range(struct cs_etm_packet_queue *packet_queue,
> +cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
> +			     struct cs_etm_packet_queue *packet_queue,
>  			     const ocsd_generic_trace_elem *elem,
>  			     const uint8_t trace_chan_id)
>  {
> @@ -365,6 +436,23 @@ cs_etm_decoder__buffer_range(struct cs_etm_packet_queue *packet_queue,
>  
>  	packet->last_instr_size = elem->last_instr_sz;
>  
> +	/* per-thread scenario, no need to generate a timestamp */
> +	if (cs_etm__etmq_is_timeless(etmq))
> +		goto out;
> +
> +	/*
> +	 * The packet queue is full and we haven't seen a timestamp (had we
> +	 * seen one the packet queue wouldn't be full).  Let the front end
> +	 * deal with it.
> +	 */
> +	if (ret == OCSD_RESP_WAIT)
> +		goto out;
> +
> +	packet_queue->instr_count += elem->num_instr_range;
> +	/* Tell the front end we have a new timestamp to process */
> +	ret = cs_etm_decoder__do_soft_timestamp(etmq, packet_queue,
> +						trace_chan_id);
> +out:
>  	return ret;
>  }
>  
> @@ -372,6 +460,11 @@ static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
>  				     const uint8_t trace_chan_id)
>  {
> +	/*
> +	 * Something happened and who knows when we'll get new traces so
> +	 * reset time statistics.
> +	 */
> +	cs_etm_decoder__reset_timestamp(queue);
>  	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
>  					     CS_ETM_DISCONTINUITY);
>  }
> @@ -404,6 +497,7 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
>  
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
> +			struct cs_etm_packet_queue *packet_queue,
>  			const ocsd_generic_trace_elem *elem,
>  			const uint8_t trace_chan_id)
>  {
> @@ -417,6 +511,12 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>  	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
>  		return OCSD_RESP_FATAL_SYS_ERR;
>  
> +	/*
> +	 * A timestamp is generated after a PE_CONTEXT element so make sure
> +	 * to rely on that coming one.
> +	 */
> +	cs_etm_decoder__reset_timestamp(packet_queue);
> +
>  	return OCSD_RESP_CONT;
>  }
>  
> @@ -446,7 +546,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  							    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
> -		resp = cs_etm_decoder__buffer_range(packet_queue, elem,
> +		resp = cs_etm_decoder__buffer_range(etmq, packet_queue, elem,
>  						    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> @@ -457,11 +557,15 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
>  							    trace_chan_id);
>  		break;
> +	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> +		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
> +							 trace_chan_id);
> +		break;
>  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> -		resp = cs_etm_decoder__set_tid(etmq, elem, trace_chan_id);
> +		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> +					       elem, trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> -	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
>  	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
>  	case OCSD_GEN_TRC_ELEM_EVENT:
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 17adf554b679..91496a3a2209 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -80,6 +80,7 @@ struct cs_etm_queue {
>  	struct cs_etm_decoder *decoder;
>  	struct auxtrace_buffer *buffer;
>  	unsigned int queue_nr;
> +	u8 pending_timestamp;
>  	u64 offset;
>  	const unsigned char *buf;
>  	size_t buf_len, buf_used;
> @@ -133,6 +134,19 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
>  	return 0;
>  }
>  
> +void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> +					      u8 trace_chan_id)
> +{
> +	/*
> +	 * Wnen a timestamp packet is encountered the backend code
> +	 * is stopped so that the front end has time to process packets
> +	 * that were accumulated in the traceID queue.  Since there can
> +	 * be more than one channel per cs_etm_queue, we need to specify
> +	 * what traceID queue needs servicing.
> +	 */
> +	etmq->pending_timestamp = trace_chan_id;
> +}
> +
>  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
>  {
>  	int i;
> @@ -942,6 +956,11 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>  	return 0;
>  }
>  
> +bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
> +{
> +	return !!etmq->etm->timeless_decoding;
> +}
> +
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
>  					    u64 addr, u64 period)
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index b2a7628620bf..33b57e748c3d 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -150,6 +150,9 @@ struct cs_etm_packet_queue {
>  	u32 packet_count;
>  	u32 head;
>  	u32 tail;
> +	u32 instr_count;
> +	u64 timestamp;
> +	u64 next_timestamp;
>  	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
>  };
>  
> @@ -183,6 +186,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
>  int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>  			 pid_t tid, u8 trace_chan_id);
> +bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
> +void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> +					      u8 trace_chan_id);
>  struct cs_etm_packet_queue
>  *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
>  #else
> @@ -207,6 +213,17 @@ static inline int cs_etm__etmq_set_tid(
>  	return -1;
>  }
>  
> +static inline bool cs_etm__etmq_is_timeless(
> +				struct cs_etm_queue *etmq __maybe_unused)
> +{
> +	/* What else to return? */
> +	return true;
> +}
> +
> +static inline void cs_etm__etmq_set_traceid_queue_timestamp(
> +				struct cs_etm_queue *etmq __maybe_unused,
> +				u8 trace_chan_id __maybe_unused) {}
> +
>  static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
>  				struct cs_etm_queue *etmq __maybe_unused,
>  				u8 trace_chan_id __maybe_unused)
> -- 
> 2.17.1

-- 

- Arnaldo
