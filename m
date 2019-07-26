Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73A0C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88321842
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfGZR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:59:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38194 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfGZR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:59:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D02E28023F; Fri, 26 Jul 2019 19:59:07 +0200 (CEST)
Date:   Fri, 26 Jul 2019 19:59:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, acme@kernel.org,
        eranian@google.com, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 078/271] perf/x86/intel/uncore: Handle invalid event
 coding for free-running counter
Message-ID: <20190726175917.GC5945@xo-6d-61-c0.localdomain>
References: <20190724191655.268628197@linuxfoundation.org>
 <20190724191701.880558315@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724191701.880558315@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-07-24 21:19:07, Greg Kroah-Hartman wrote:

> [ Upstream commit 543ac280b3576c0009e8c0fcd4d6bfc9978d7bd0 ]
> 
> Counting with invalid event coding for free-running counter may cause
> OOPs, e.g. uncore_iio_free_running_0/event=1/.
> 
> Current code only validate the event with free-running event format,
> event=0xff,umask=0xXY. Non-free-running event format never be checked
> for the PMU with free-running counters.
> 
> Add generic hw_config() to check and reject the invalid event coding
> for free-running PMU.

So this is interesting. "static inline", but it is never really inlined because
the only use is for taking pointer.

Best regards,
									Pavel

> +++ b/arch/x86/events/intel/uncore.h
> @@ -402,6 +402,16 @@ static inline bool is_freerunning_event(struct perf_event *event)
>  	       (((cfg >> 8) & 0xff) >= UNCORE_FREERUNNING_UMASK_START);
>  }
>  
> +/* Check and reject invalid config */
> +static inline int uncore_freerunning_hw_config(struct intel_uncore_box *box,
> +					       struct perf_event *event)
> +{
> +	if (is_freerunning_event(event))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  static inline void uncore_disable_box(struct intel_uncore_box *box)
>  {
>  	if (box->pmu->type->ops->disable_box)
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index b10e04387f38..8e4e8e423839 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3585,6 +3585,7 @@ static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
>  
>  static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
>  	.read_counter		= uncore_msr_read_counter,
> +	.hw_config		= uncore_freerunning_hw_config,
>  };
>  
>  static struct attribute *skx_uncore_iio_freerunning_formats_attr[] = {
> -- 
> 2.20.1
> 
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
