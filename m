Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030AC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D62121951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfGYB24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGYB24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:28:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA4521901;
        Thu, 25 Jul 2019 01:28:54 +0000 (UTC)
Date:   Wed, 24 Jul 2019 21:28:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] trace: fix header include guards
Message-ID: <20190724212852.070641d4@oasis.local.home>
In-Reply-To: <20190720103943.16982-1-yamada.masahiro@socionext.com>
References: <20190720103943.16982-1-yamada.masahiro@socionext.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2019 19:39:43 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> These include guards are broken.
> 
> Match the #if !define() and #define lines so that they work correctly.

Thanks, this all looks legit to me. I'll pull this in through my tree.

-- Steve

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  include/trace/events/dma_fence.h     | 2 +-
>  include/trace/events/napi.h          | 4 ++--
>  include/trace/events/qdisc.h         | 4 ++--
>  include/trace/events/tegra_apb_dma.h | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
> index 2212adda8f77..64e92d56c6a8 100644
> --- a/include/trace/events/dma_fence.h
> +++ b/include/trace/events/dma_fence.h
> @@ -2,7 +2,7 @@
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM dma_fence
>  
> -#if !defined(_TRACE_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#if !defined(_TRACE_DMA_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_DMA_FENCE_H
>  
>  #include <linux/tracepoint.h>
> diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
> index f3a12566bed0..6678cf8b235b 100644
> --- a/include/trace/events/napi.h
> +++ b/include/trace/events/napi.h
> @@ -3,7 +3,7 @@
>  #define TRACE_SYSTEM napi
>  
>  #if !defined(_TRACE_NAPI_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _TRACE_NAPI_H_
> +#define _TRACE_NAPI_H
>  
>  #include <linux/netdevice.h>
>  #include <linux/tracepoint.h>
> @@ -38,7 +38,7 @@ TRACE_EVENT(napi_poll,
>  
>  #undef NO_DEV
>  
> -#endif /* _TRACE_NAPI_H_ */
> +#endif /* _TRACE_NAPI_H */
>  
>  /* This part must be outside protection */
>  #include <trace/define_trace.h>
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index 60d0d8bd336d..0d1a9ebf55ba 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -2,7 +2,7 @@
>  #define TRACE_SYSTEM qdisc
>  
>  #if !defined(_TRACE_QDISC_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _TRACE_QDISC_H_
> +#define _TRACE_QDISC_H
>  
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
> @@ -44,7 +44,7 @@ TRACE_EVENT(qdisc_dequeue,
>  		  __entry->txq_state, __entry->packets, __entry->skbaddr )
>  );
>  
> -#endif /* _TRACE_QDISC_H_ */
> +#endif /* _TRACE_QDISC_H */
>  
>  /* This part must be outside protection */
>  #include <trace/define_trace.h>
> diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
> index 0818f6286110..971cd02d2daf 100644
> --- a/include/trace/events/tegra_apb_dma.h
> +++ b/include/trace/events/tegra_apb_dma.h
> @@ -1,5 +1,5 @@
>  #if !defined(_TRACE_TEGRA_APB_DMA_H) || defined(TRACE_HEADER_MULTI_READ)
> -#define _TRACE_TEGRA_APM_DMA_H
> +#define _TRACE_TEGRA_APB_DMA_H
>  
>  #include <linux/tracepoint.h>
>  #include <linux/dmaengine.h>
> @@ -55,7 +55,7 @@ TRACE_EVENT(tegra_dma_isr,
>  	TP_printk("%s: irq %d\n",  __get_str(chan), __entry->irq)
>  );
>  
> -#endif /*  _TRACE_TEGRADMA_H */
> +#endif /* _TRACE_TEGRA_APB_DMA_H */
>  
>  /* This part must be outside protection */
>  #include <trace/define_trace.h>

