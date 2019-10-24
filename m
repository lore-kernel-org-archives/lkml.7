Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65BCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B904320679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YymXEMEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393688AbfJXNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:41:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57606 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbfJXNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OAutKv7rGXnkE1j1DaVotv1AkngiHVnTMwQ9RDX6DQo=; b=YymXEMEd9zGGXFwJBxUDcZs1P
        AbpTjgsiYGx9pTMY9m/pgaxFVLlUUjJl6FV4JNrln2Rja0tgWs6a9h9eGkiP1mJZzKcTayvj4eqYx
        Uf1l4IZETORw7Thd1AWC5NiXodt/I8+LLGAutX00NR6j0MYTalpf1xnxMb0GN/ovJCY+3jGG4w4F2
        OL8V0N1b/e/9adDVCWU+9F6jK/ecg/lTMASLz0OFCkfJ0A70bIFvYjOjOYBVZ/+ykjyORyzZ7/aWK
        jmrU18Oc0+Za60o4epbz5rpOGibX44DKb9IeBxSNdIe9WuRI9M3ip7MtGs3mdfPCd73KblSwqGu/9
        +TIOD2q5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdMv-0008JZ-KD; Thu, 24 Oct 2019 13:41:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 815BF303DDD;
        Thu, 24 Oct 2019 15:40:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE9A42B1EE1A2; Thu, 24 Oct 2019 15:41:33 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:41:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com, eranian@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V3 01/13] perf/core: Add new branch sample type for LBR
 TOS
Message-ID: <20191024134133.GC4114@hirez.programming.kicks-ass.net>
References: <20191022171136.4022-1-kan.liang@linux.intel.com>
 <20191022171136.4022-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022171136.4022-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:11:24AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> In LBR call stack mode, the depth of reconstructed LBR call stack limits
> to the number of LBR registers. With LBR Top-of-Stack (TOS) information,
> perf tool may stitch the stacks of two samples. The reconstructed LBR
> call stack can break the HW limitation.
> 
> Add a new branch sample type to retrieve LBR TOS.
> 
> Only when the new branch sample type is set, the TOS information is
> dumped into the PERF_SAMPLE_BRANCH_STACK output.
> Perf tool should check the attr.branch_sample_type, and apply the
> corresponding format for PERF_SAMPLE_BRANCH_STACK samples.
> Otherwise, some user case may be broken. For example, users may parse a
> perf.data, which include the new branch sample type, with an old version
> perf tool (without the check). Users probably get incorrect information
> without any warning.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h      |  2 ++
>  include/uapi/linux/perf_event.h | 10 +++++++++-
>  kernel/events/core.c            | 11 +++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 61448c19a132..2b229ea1cc15 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -92,6 +92,7 @@ struct perf_raw_record {
>  /*
>   * branch stack layout:
>   *  nr: number of taken branches stored in entries[]
> + *  tos: Top-of-Stack (TOS) information. PMU specific data.
>   *
>   * Note that nr can vary from sample to sample
>   * branches (to, from) are stored from most recent
> @@ -100,6 +101,7 @@ struct perf_raw_record {
>   */
>  struct perf_branch_stack {
>  	__u64				nr;
> +	__u64				tos; /* PMU specific data */
>  	struct perf_branch_entry	entries[0];
>  };
>  
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..b1f022190571 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -180,6 +180,8 @@ enum perf_branch_sample_type_shift {
>  
>  	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
>  
> +	PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT	= 17, /* save LBR TOS */

I think I prefer not having LBR here either, who knows what other
hardware can make use of that.

On that, you've completely failed to Cc the other architecture that
implement PERF_SAMPLE_BRANCH.

Aside from that I can live with this version.

> +
>  	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
>  };
>  
> @@ -207,6 +209,8 @@ enum perf_branch_sample_type {
>  	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
>  		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>  
> +	PERF_SAMPLE_BRANCH_LBR_TOS	= 1U << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
> +
>  	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
>  };
>  
> @@ -849,7 +853,11 @@ enum perf_event_type {
>  	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>  	 *
>  	 *	{ u64                   nr;
> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
> +	 *        { u64 from, to, flags } lbr[nr];
> +	 *
> +	 *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
> +	 *        u64			tos;
> +	 *      } && PERF_SAMPLE_BRANCH_STACK
>  	 *
>  	 * 	{ u64			abi; # enum perf_sample_regs_abi
>  	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9ec0b0bfddbd..18b0a7d2c67e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6343,6 +6343,11 @@ static void perf_output_read(struct perf_output_handle *handle,
>  		perf_output_read_one(handle, event, enabled, running);
>  }
>  
> +static inline bool perf_sample_save_lbr_tos(struct perf_event *event)
> +{
> +	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
> +}
> +
>  void perf_output_sample(struct perf_output_handle *handle,
>  			struct perf_event_header *header,
>  			struct perf_sample_data *data,
> @@ -6432,6 +6437,8 @@ void perf_output_sample(struct perf_output_handle *handle,
>  
>  			perf_output_put(handle, data->br_stack->nr);
>  			perf_output_copy(handle, data->br_stack->entries, size);
> +			if (perf_sample_save_lbr_tos(event))
> +				perf_output_put(handle, data->br_stack->tos);
>  		} else {
>  			/*
>  			 * we always store at least the value of nr
> @@ -6619,7 +6626,11 @@ void perf_prepare_sample(struct perf_event_header *header,
>  		if (data->br_stack) {
>  			size += data->br_stack->nr
>  			      * sizeof(struct perf_branch_entry);
> +
> +			if (perf_sample_save_lbr_tos(event))
> +				size += sizeof(u64);
>  		}
> +
>  		header->size += size;
>  	}
>  
> -- 
> 2.17.1
> 
