Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C33206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDKMGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:06:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:50556 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:06:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 05:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="133368944"
Received: from unknown (HELO localhost) ([10.237.72.178])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2019 05:06:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
In-Reply-To: <20190410143348.GG2490@worktop.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com> <20190403104103.GE4038@hirez.programming.kicks-ass.net> <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com> <20190404110909.GY4038@hirez.programming.kicks-ass.net> <20190404130300.GF14281@hirez.programming.kicks-ass.net> <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com> <20190408082229.GI4038@hirez.programming.kicks-ass.net> <20190408095031.GG14281@hirez.programming.kicks-ass.net> <20190409085327.GA21979@lakrids.cambridge.arm.com> <a24a2dca-72f3-ff56-5004-97c6ce86f6af@linux.ibm.com> <20190410143348.GG2490@worktop.programming.kicks-ass.net>
Date:   Thu, 11 Apr 2019 15:06:42 +0300
Message-ID: <87pnpsd9v1.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 10, 2019 at 03:51:24PM +0200, Thomas-Mich Richter wrote:
>> Thanks for the fix with commit id 86071b11317550d994b55ce5e31aa06bcad783b5.
>> 
>> However doing an fgrep on the pending_disable member of struct perf_event
>> reveals two more hits in file kernel/events/ringbuffer.c when events
>> have auxiliary data.
>> 
>> Not sure if this needs to be addresses too, just wanted to let you know.
>
> *groan* indeed, and yes that would need fixing too. I completely missed
> the AUX stuff using that too.
>
> I think we can simply do the below on top, Alexander?

Looks good. FWIW, renaming pending_disable in the first place to match
the fact that it's a cpu# now, would have probably caught all these.

> ---
>  kernel/events/ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 678ccec60d8f..ab2b7b38adc5 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -392,7 +392,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
>  		 * store that will be enabled on successful return
>  		 */
>  		if (!handle->size) { /* A, matches D */
> -			event->pending_disable = 1;
> +			event->pending_disable = smp_processor_id();
>  			perf_output_wakeup(handle);
>  			local_set(&rb->aux_nest, 0);
>  			goto err_put;
> @@ -480,7 +480,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>
>  	if (wakeup) {
>  		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> -			handle->event->pending_disable = 1;
> +			handle->event->pending_disable = smp_processor_id();
>  		perf_output_wakeup(handle);
>  	}

Thanks,
--
Alex
