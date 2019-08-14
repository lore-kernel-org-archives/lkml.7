Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5546DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5572084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:40:04 -0400
Received: from foss.arm.com ([217.140.110.172]:57154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHNQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:40:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21311344;
        Wed, 14 Aug 2019 09:40:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9643F694;
        Wed, 14 Aug 2019 09:40:01 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:39:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de, bp@suse.de,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 3/9] kmemleak: correctly check for kthreads
Message-ID: <20190814163959.GB54611@arrakis.emea.arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814104131.20190-4-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:41:25AM +0100, Mark Rutland wrote:
> In general, a non-NULL current->mm doesn't imply that current is a
> kthread, as kthreads can install an mm via use_mm(), and so it's
> preferable to use is_kthread() to determine whether a thread is a
> kthread.
> 
> For consistency, let's use is_kthread() here.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  mm/kmemleak.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> index 6e9e8cca663e..42ea3c14b577 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1290,10 +1290,10 @@ static int scan_should_stop(void)
>  	 * This function may be called from either process or kthread context,
>  	 * hence the need to check for both stop conditions.
>  	 */
> -	if (current->mm)
> -		return signal_pending(current);
> -	else
> +	if (is_kthread(current))
>  		return kthread_should_stop();
> +	else
> +		return signal_pending(current);

While you are at it, you can drop the 'else' as well (occasionally
checkpatch complains about 'else' after return).

Thanks.

-- 
Catalin
