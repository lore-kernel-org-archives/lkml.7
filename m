Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8ACC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7904F20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hee1O7Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfDJTr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:47:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wYRnxZ4X3MWHGsmlbchCyx5PURfPTwp21+dPhouVSuU=; b=hee1O7Yjy44gQGD0fv4KJO3sF
        xhkxPsZrclwxi8CE3uJTURUHHWZ5XdDwuZv6+JIy4GayEHmNQVSiJfWESr7x2TIzD5S8CKddaKTZh
        cBw13Ytc6atHnCEqUv2rGpRnrDGWOPCwiduBMxaw7hor3jdTipAI1P1TkPABBiPRncb0qdvHsc4Bq
        1JPL93ZPj4CWjKkiUwpf02mbZxkDKfwo0HJBTmSD4mcuF6iyWeI6K6nIuZLREycTtek8EaOrApnKw
        fzYdfWgib24sH9gn05jzWlm1aqgUHlGhLgjv/QGFvRth5ySr7gvX9hdLCHZlrPfAm9qgKXHMxx4bp
        5lD2b1zCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEJBq-0004MQ-8z; Wed, 10 Apr 2019 19:47:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDBC02029E066; Wed, 10 Apr 2019 21:47:20 +0200 (CEST)
Date:   Wed, 10 Apr 2019 21:47:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
Message-ID: <20190410194720.GC11158@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
 <20190408150654.GV12232@hirez.programming.kicks-ass.net>
 <4ff8fec9-fb41-b11d-b7ed-4c716b558adc@linux.intel.com>
 <688804aa-b6eb-0f19-828c-99b901bbe554@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688804aa-b6eb-0f19-828c-99b901bbe554@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:22:21PM -0400, Liang, Kan wrote:
> > > That is, are there really bits we want to mask in there?
> > 
> > For instruction event, right, we don't need mask it.
> > I will change it.
> > 
> 
> Actually, we have to mask some bits here, e.g. ARCH_PERFMON_EVENTSEL_INT,
> ARCH_PERFMON_EVENTSEL_USR and ARCH_PERFMON_EVENTSEL_OS. Those bits will be
> set in hw_config().

Ah, bah, You're right. I misread and though we were comparing against
the user provided raw config.

> 
> Also, other filds, e.g the INV, ANY, E, or CMASK fields are not allowed for
> reduced Skid PEBS.

Sure, those are actually forced 0 with the existing thing.

I'll go fold smething like back in. Thanks!

> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index dae3d84..3fa36c9 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3463,6 +3463,9 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc,
> int idx,
>  	return c;
>  }
> 
> +#define EVENT_CONFIG(config)		\
> +	(config & (X86_ALL_EVENT_FLAGS | INTEL_ARCH_EVENT_MASK))
> +
>  static struct event_constraint *
>  icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  			  struct perf_event *event)
> @@ -3472,7 +3475,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc,
> int idx,
>  	 * Force instruction:ppp in Fixed counter 0
>  	 */
>  	if ((event->attr.precise_ip == 3) &&
> -	    (event->hw.config == X86_CONFIG(.event=0xc0)))
> +	    (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0)))
>  		return &fixed_counter0_constraint;
> 
>  	return hsw_get_event_constraints(cpuc, idx, event);
> 
> Thanks,
> Kan
