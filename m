Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2691C208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDBKrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:47:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfDBKrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:47:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7841688;
        Tue,  2 Apr 2019 03:47:16 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56A583F59C;
        Tue,  2 Apr 2019 03:47:15 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:47:12 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ben Gainey <Ben.Gainey@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: BUG in "perf: Suppress AUX/OVERWRITE records"?
Message-ID: <20190402104712.GD26171@fuggles.cambridge.arm.com>
References: <ca9bbbdfada4c02eacb5064fce5d187d0f13f4f0.camel@arm.com>
 <87k1gm86en.fsf@ashishki-desk.ger.corp.intel.com>
 <3f04004a48a4b5bece9d277d5c51661f4eca7e97.camel@arm.com>
 <87wokk7k20.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wokk7k20.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:17:43AM +0200, Alexander Shishkin wrote:
> Ben Gainey <Ben.Gainey@arm.com> writes:
> 
> >> It was an unintentional side effect that it also
> >> happened to coincide with context switches in the overwrite mode.
> >
> > I'm not using overwrite mode, I'm opening the mmap with PROT_WRITE
> > (i.e. in truncate mode).
> 
> Now I get it. Does the below fix the problem for you?
> 
> From bf52320cce0e74a2c0d987db7bd571f7687b4f4f Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Wed, 27 Mar 2019 11:05:53 +0200
> Subject: [PATCH] perf: Fix AUX record suppression
> 
> Commit 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records") has an
> unintended side-effect of also suppressing all AUX records with no flags
> and non-zero size, so all the regular records in the full trace mode.
> This breaks some use cases for people.
> 
> Fix this by restoring "regular" AUX records to their former glory.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Fixes: 1627314fb54a33e ("perf: Suppress AUX/OVERWRITE records")
> Reported-by: Ben Gainey <Ben.Gainey@arm.com>
> CC: stable@vger.kernel.org # v4.20+
> ---
>  kernel/events/ring_buffer.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 678ccec60d8f..626256dc26c1 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -455,24 +455,21 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>  		rb->aux_head += size;
>  	}
>  
> -	if (size || handle->aux_flags) {
> -		/*
> -		 * Only send RECORD_AUX if we have something useful to communicate
> -		 *
> -		 * Note: the OVERWRITE records by themselves are not considered
> -		 * useful, as they don't communicate any *new* information,
> -		 * aside from the short-lived offset, that becomes history at
> -		 * the next event sched-in and therefore isn't useful.
> -		 * The userspace that needs to copy out AUX data in overwrite
> -		 * mode should know to use user_page::aux_head for the actual
> -		 * offset. So, from now on we don't output AUX records that
> -		 * have *only* OVERWRITE flag set.
> -		 */
> -
> -		if (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE)
> -			perf_event_aux_event(handle->event, aux_head, size,
> -			                     handle->aux_flags);
> -	}
> +	/*
> +	 * Only send RECORD_AUX if we have something useful to communicate
> +	 *
> +	 * Note: the OVERWRITE records by themselves are not considered
> +	 * useful, as they don't communicate any *new* information,
> +	 * aside from the short-lived offset, that becomes history at
> +	 * the next event sched-in and therefore isn't useful.
> +	 * The userspace that needs to copy out AUX data in overwrite
> +	 * mode should know to use user_page::aux_head for the actual
> +	 * offset. So, from now on we don't output AUX records that
> +	 * have *only* OVERWRITE flag set.
> +	 */
> +	if (size || (handle->aux_flags & ~(u64)PERF_AUX_FLAG_OVERWRITE))
> +		perf_event_aux_event(handle->event, aux_head, size,
> +				     handle->aux_flags);

Acked-by: Will Deacon <will.deacon@arm.com>

Assuming this will make it into 5.1 as a fix?

Will
