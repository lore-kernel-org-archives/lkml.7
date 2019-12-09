Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DB320692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oKkKM8vX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLIQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:17:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yTSggCUrDnLDOq0j19tc29s50NlGdHpCrc0hkMGDCws=; b=oKkKM8vX6ltfuE7C/RHqu7s45
        2R0H1nP6XZlEUXWu6zUV/lka8GDXccwYSLYAaJ+Xm5Z4iAG21GtfyFXkw2NfuHmzWFkHeYQtnb0k/
        KjRBKIjY/BLVVhrv7d5owpPEXe8TZ0Wg0KQRQDWwxIVWBF+T3J1yfN3mObxnnPmXEG4vpox1X5TFN
        Ly4v6yA2jH9xJ6H1bi3XIizSM1XM8fhCIiiuK/yhAqG4AbrLv7CNWqYgfwP4MDtxgT1ic4SshlbY5
        rESHN3OhCjLLALp+9JWgc60UrBAyHS4mFCjGNO9gztcEPk7R5f+r0pWo8waFclQJMjkfqMoRpFi6f
        WSZIIreKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieLi3-0003jH-0b; Mon, 09 Dec 2019 16:16:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7748430025A;
        Mon,  9 Dec 2019 17:15:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84C8928719325; Mon,  9 Dec 2019 17:16:27 +0100 (CET)
Date:   Mon, 9 Dec 2019 17:16:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Wang <rocking@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schied/fair: Skip updating "contrib" without load
Message-ID: <20191209161627.GJ2810@hirez.programming.kicks-ass.net>
References: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575648862-12095-1-git-send-email-rocking@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 12:14:22AM +0800, Peng Wang wrote:
> We only update load_sum/runnable_load_sum/util_sum with
> decayed old sum when load is clear.

What you're saying is that because of the:

	if (!load)
		runnable = running = 0;

clause in ___update_load_sum(), all the actual users of @contrib in
accumulate_sum():

	if (load)
		sa->load_sum += load * contrib;
	if (runnable)
		sa->runnable_load_sum += runnable * contrib;
	if (running)
		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;

don't happen, and therefore we don't care what @contrib actually is and
calculating it is pointless.

I suppose that is so. did you happen to have performance numbers? Also,
I'm thinking this wants a comment.

> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>  kernel/sched/pelt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..4392953 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -129,8 +129,9 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>  		 * Step 2
>  		 */
>  		delta %= 1024;
> -		contrib = __accumulate_pelt_segments(periods,
> -				1024 - sa->period_contrib, delta);
> +		if (load)
> +			contrib = __accumulate_pelt_segments(periods,
> +					1024 - sa->period_contrib, delta);
>  	}
>  	sa->period_contrib = delta;
>  
> -- 
> 1.8.3.1
> 
