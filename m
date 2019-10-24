Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C76CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OFeOLH4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409358AbfJXOJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:09:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389658AbfJXOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lKm45370EhrH8zZ54o5/PLqtFk0+iVXt+l8pnOZZmpQ=; b=OFeOLH4zOtHPY7V/OhqklOhC+
        87yER8lXEp9nRYndHoU//ASyXzhJa72HswKTcm9o412MHF930mrFXeHte8Qg0nfR4cpvTCPoIz3bk
        q+sCK08K4J8Oa7Z2s+fND8Gh/2l0CRzYfR95JMQXNil7PM9+FCO4Dea4fvbfoYjGNwi3+aZw4By3p
        PoA/Aou3Je1LkOkLeeMjI2LGbdwSIyjh1sdK2kDI/eAEJKzlUqt/DVoqHWlmFasw3ghMGD3TVspqf
        VtbX2ZmyK5n3KeTFHz2bLBwqA2bf/rB3WL10Ws1jg9GXYvdFC2AO/0x1AT+pySpKRSjEOLZ/8vBJ6
        /yQl3eJCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNdnv-0000Ey-VK; Thu, 24 Oct 2019 14:09:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F333300489;
        Thu, 24 Oct 2019 16:08:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 812062B1D7CA5; Thu, 24 Oct 2019 16:09:30 +0200 (CEST)
Date:   Thu, 24 Oct 2019 16:09:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] perf: Allow using AUX data in perf samples
Message-ID: <20191024140930.GH4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
 <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022095812.67071-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:58:09PM +0300, Alexander Shishkin wrote:
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index bb7b271397a6..84dbd1499a24 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> +	PERF_SAMPLE_AUX				= 1U << 20,
>  
> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -424,7 +425,7 @@ struct perf_event_attr {
>  	 */
>  	__u32	aux_watermark;
>  	__u16	sample_max_stack;
> -	__u16	__reserved_2;	/* align to __u64 */
> +	__u16	aux_sample_size;
>  };

While I understand; would it not be better to make that a u32 (like
sample_stack_user) ? That way we only have to ref the output format and
not also the config format to get more output.

>  /*
> @@ -864,6 +865,8 @@ enum perf_event_type {
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>  	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> +	 *	{ u64			size;
> +	 *	  char			data[size]; } && PERF_SAMPLE_AUX
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
