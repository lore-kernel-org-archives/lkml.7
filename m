Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8C02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555052126;
	bh=sWwFMbMlwUh3a7PmpdAhRw/QzGh5TtgwlCiofBGc500=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J2Hm+i9uKEJJV/LWdt7MHf0JqfrGkb2vWTTtbZrTsRHt557ObWkaelNsVD7S77Kcd
	 g4WEySd/6/03R10L7G/6cDLAQSFmYjvqy7JwBrbEXJfyc+zMA6UvVEv3wEnvf/j4VI
	 BSRhRdXApKT/ogS2Drt+m35B3NCdm9UYu8WeO+TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLGzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:55:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfDLGzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:55:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so10422173wra.12;
        Thu, 11 Apr 2019 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bzyhkICqGHQeDXjdyXKR8GIAjHDmOnBFQx3za/b+cpM=;
        b=rHR0LFU6r5D6WN8xnT7/urNBSJWJIwd4MMr1fsPpFY1W2SkJs7M+aQ6RPGy4uhsG6k
         wgZUChyqX5GfWf2tAZpnm9YazCn0qRjztJcs16Gt8b8qWgBPNEQQkj4ctsVXcCSckirL
         Xn7xSVH/SpkLunNm0riMWz6fABWdsBYggbE6oKLqKvJd1xXom2pVabUPlcyK2Ii7GuML
         2NqDs9+i4lTHRPZG4WsTm95tLVo9THmz+/iDm4XcYSLObTSCq6lIlDwe5z+Fprc2KBuZ
         zd5GCGtuy+E9NBfuVDRSvSGIlfX7VVPMUV0qURxvm9nwAFTzSQH2FLj3uGNtYoxl/qqt
         leUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bzyhkICqGHQeDXjdyXKR8GIAjHDmOnBFQx3za/b+cpM=;
        b=XaW95cEQ/YXfKWct275czPmdWFeUsAwREw7Tw7gzHgfOWr44opq6YvFnpWlmsL+HLB
         YGuwENv7Jf3NbiyjXAA/pKthbCOeIq9u4qd3wmRwc4y1qxiU4IkglGVZJ5b4K/nwtdF4
         xpvjZo4/Xm2w4YNta83Z+uQpw/FBtE0JsNFCFLCigDpxVSqO+yFp2EYX406S3qFbBWxF
         r9KwkY/jp/OSdlR6MQgM8EljTkV/OA+BC/tEFiexla+o/XF6gBqZYiM2AQVE9EXhClwB
         Rd2WjalVlafrtnd95FEyItp4hHCOEFbzpiy9Yy0BxjKnPNVAcPXhiDkU1F3QzvpfenWZ
         yVKg==
X-Gm-Message-State: APjAAAWiH+/o1sM8VibdYOAAMsN9+Z8Tez/Iw+AS3DByZJDbVjUjFZiG
        jZzdgFtcg0qxa47+8YZ71wo=
X-Google-Smtp-Source: APXvYqzrh8Gz6qbA8N9tzipWxv8COiaiJeawl6eF/5lBUXP+5C5sIhzo2dip04L8GtfeW7BbeQfUEw==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr37081457wrn.29.1555052122960;
        Thu, 11 Apr 2019 23:55:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u17sm13444988wmu.36.2019.04.11.23.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 23:55:22 -0700 (PDT)
Date:   Fri, 12 Apr 2019 08:55:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mark.rutland@arm.com, acme@redhat.com, tglx@linutronix.de,
        brueckner@linux.ibm.com, torvalds@linux-foundation.org,
        alexander.shishkin@linux.intel.com, heiko.carstens@de.ibm.com,
        tmricht@linux.ibm.com, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jolsa@redhat.com, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/core: Fix perf_event_disable_inatomic()
 race
Message-ID: <20190412065519.GA129493@gmail.com>
References: <tip-86071b11317550d994b55ce5e31aa06bcad783b5@git.kernel.org>
 <20190411130434.GD11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411130434.GD11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 10, 2019 at 05:13:54AM -0700, tip-bot for Peter Zijlstra wrote:
> > Commit-ID:  86071b11317550d994b55ce5e31aa06bcad783b5
> > Gitweb:     https://git.kernel.org/tip/86071b11317550d994b55ce5e31aa06bcad783b5
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Thu, 4 Apr 2019 15:03:00 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Wed, 10 Apr 2019 13:47:09 +0200
> > 
> > perf/core: Fix perf_event_disable_inatomic() race
> > 
> > Thomas-Mich Richter reported he triggered a WARN()ing from event_function_local()
> > on his s390. The problem boils down to:
> > 
> > 	CPU-A				CPU-B
> > 
> > 	perf_event_overflow()
> > 	  perf_event_disable_inatomic()
> > 	    @pending_disable = 1
> > 	    irq_work_queue();
> > 
> > 	sched-out
> > 	  event_sched_out()
> > 	    @pending_disable = 0
> > 
> > 					sched-in
> > 					perf_event_overflow()
> > 					  perf_event_disable_inatomic()
> > 					    @pending_disable = 1;
> > 					    irq_work_queue(); // FAILS
> > 
> > 	irq_work_run()
> > 	  perf_pending_event()
> > 	    if (@pending_disable)
> > 	      perf_event_disable_local(); // WHOOPS
> > 
> > The problem exists in generic, but s390 is particularly sensitive
> > because it doesn't implement arch_irq_work_raise(), nor does it call
> > irq_work_run() from it's PMU interrupt handler (nor would that be
> > sufficient in this case, because s390 also generates
> > perf_event_overflow() from pmu::stop). Add to that the fact that s390
> > is a virtual architecture and (virtual) CPU-A can stall long enough
> > for the above race to happen, even if it would self-IPI.
> > 
> > Adding a irq_work_sync() to event_sched_in() would work for all hardare
> > PMUs that properly use irq_work_run() but fails for software PMUs.
> > 
> > Instead encode the CPU number in @pending_disable, such that we can
> > tell which CPU requested the disable. This then allows us to detect
> > the above scenario and even redirect the IPI to make up for the failed
> > queue.
> 
> Ingo, could you please fold in the below delta? It turns out I
> overlooked two insteances :-(
> 
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -392,7 +392,7 @@ void *perf_aux_output_begin(struct perf_
>  		 * store that will be enabled on successful return
>  		 */
>  		if (!handle->size) { /* A, matches D */
> -			event->pending_disable = 1;
> +			event->pending_disable = smp_processor_id();
>  			perf_output_wakeup(handle);
>  			local_set(&rb->aux_nest, 0);
>  			goto err_put;
> @@ -480,7 +480,7 @@ void perf_aux_output_end(struct perf_out
>  
>  	if (wakeup) {
>  		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
> -			handle->event->pending_disable = 1;
> +			handle->event->pending_disable = smp_processor_id();
>  		perf_output_wakeup(handle);
>  	}

Sure, done!

Thanks,

	Ingo
