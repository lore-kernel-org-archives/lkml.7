Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8DFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9263C233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566481766;
	bh=1gRIfAcx+/4JswiFhMH16t8/HiubqDkzIJ+NMkkZLkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UXQW9lxf9jRoV0omYTboBq6w5hY+MwrlSdza4LyMRw/ICRUGbytAzDkYwYVR9WoAs
	 VK9cGk8ydFCI+dXLxN8mH5qdBf/ShjibUoP4HsXxJBVMKgX1F1mtqUExk75o70Gckm
	 NB5VrvR8Ec6B0vDV6yOsJxbu5NhzT/nig6cDsRMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfHVNtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfHVNtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:49:25 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB33233FC;
        Thu, 22 Aug 2019 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566481764;
        bh=1gRIfAcx+/4JswiFhMH16t8/HiubqDkzIJ+NMkkZLkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH1BBm9U0Nz7h+beb2z2VOadMHtPrwof6VTfIT9kq5MOVRNKdn547u+/TjwVA3zfI
         oVBZ7RJg/UiTiRXrMfmaJK+V4qj76HqcTES0BFGM4vtrGYHo5bxIoY/is9mGOVf9S0
         ybMde71nUjCHA24FcVuegovYgd+KFL4tnIdf90LQ=
Date:   Thu, 22 Aug 2019 15:49:21 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 08/38] posix-cpu-timers: Consolidate thread group
 sample code
Message-ID: <20190822134920.GL22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.960966884@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.960966884@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:55PM +0200, Thomas Gleixner wrote:
> cpu_clock_sample_group() and cpu_timer_sample_group() are almost the
> same. Before the rename one called thread_group_cputimer() and the other
> thread_group_cputime(). Really intuitive function names.
> 
> Consolidate the functions and also avoid the thread traversal when
> the thread group's accounting is already active.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
[snip]
> @@ -755,7 +736,7 @@ static void posix_cpu_timer_get(struct k
>  			timer->it.cpu.expires = 0;
>  			return;
>  		} else {
> -			cpu_timer_sample_group(timer->it_clock, p, &now);
> +			cpu_clock_sample_group(timer->it_clock, p, &now, false);

We might want to warn here if !cputimer->running.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
