Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5001C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B378C206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivsIs+Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfEQIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:47:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEQIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qYyTW+u0uH6BS/vH/FDpbmo0AX8q63BcKgO+wcvhh6A=; b=ivsIs+VhHjfUO5TfOAnQ4la4z
        AlGlBPznHk20Y7eScgnkjBDqe3XSqKdLSEm4p0pVYXIMeD/GtsK/A4a8fEcbcazkQOXLCcGYiDPgN
        /arWk35Hk1qv3w5pDfx/pE/UxKNvfEeDEEqynaH6K+yJorG5T9O60F4FAuMUu5l0CiSbIqrqrNW6e
        xggCfGSHI3GoXPXvGTCt1T5MUK2xszJES0cFFus2SOfUhH6be9lEnPZH0UZaOrJBpbNrApWTDyN/Y
        Ktq4fobDnQQ2Z5pfJUPuA7nINplnZ09Pspso6djcvfHVH/OoaHrxbOxpSy97GYvaU99vFLks34EHE
        pVHFeRcBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRYWI-000206-6p; Fri, 17 May 2019 08:47:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5F112029B0A3; Fri, 17 May 2019 10:47:12 +0200 (CEST)
Date:   Fri, 17 May 2019 10:47:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yabin Cui <yabinc@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/ring_buffer: Fix exposing a temporarily
 decreased data_head.
Message-ID: <20190517084712.GL2623@hirez.programming.kicks-ass.net>
References: <20190515003059.23920-1-yabinc@google.com>
 <20190516184010.167903-1-yabinc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516184010.167903-1-yabinc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 11:40:10AM -0700, Yabin Cui wrote:
> In perf_output_put_handle(), an IRQ/NMI can happen in below location and
> write records to the same ring buffer:
> 	...
> 	local_dec_and_test(&rb->nest)
> 	...                          <-- an IRQ/NMI can happen here
> 	rb->user_page->data_head = head;
> 	...
> 
> In this case, a value A is written to data_head in the IRQ, then a value
> B is written to data_head after the IRQ. And A > B. As a result,
> data_head is temporarily decreased from A to B. And a reader may see
> data_head < data_tail if it read the buffer frequently enough, which
> creates unexpected behaviors.
> 
> This can be fixed by moving dec(&rb->nest) to after updating data_head,
> which prevents the IRQ/NMI above from updating data_head.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> 
> v1 -> v2: change rb->nest from local_t to unsigned int, and add barriers.
> 
> ---
>  kernel/events/internal.h    |  2 +-
>  kernel/events/ring_buffer.c | 24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 79c47076700a..0a8c003b9bcf 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -24,7 +24,7 @@ struct ring_buffer {
>  	atomic_t			poll;		/* POLL_ for wakeups */
>  
>  	local_t				head;		/* write position    */
> -	local_t				nest;		/* nested writers    */
> +	unsigned int			nest;		/* nested writers    */
>  	local_t				events;		/* event limit       */
>  	local_t				wakeup;		/* wakeup stamp      */
>  	local_t				lost;		/* nr records lost   */
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 674b35383491..c677beb01fb1 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -38,7 +38,8 @@ static void perf_output_get_handle(struct perf_output_handle *handle)
>  	struct ring_buffer *rb = handle->rb;
>  
>  	preempt_disable();
> -	local_inc(&rb->nest);
> +	rb->nest++;
> +	barrier();

Urgh; almost but not quite. You just lost the 'volatile' qualifier and
now the compiler can mess things up for you.

>  	handle->wakeup = local_read(&rb->wakeup);
>  }

What I'm going to do is split this into two patches, one fixes the
problem and marked for backport, and one changing away from local_t.

