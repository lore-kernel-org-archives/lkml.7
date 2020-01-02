Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359F121655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577995700;
	bh=u8TLozKgZTv2XCYHNNRwZ+d0hbnTh5rThslEK5lC0z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VS1c/3tcwPbjHaSdxP6s+fIFYIpOoIo1GImB/Vjd2pchun6aef8Dd/EuMz8pUjLOR
	 hPJdHG+K3sYqZBagrwYZgvfmLevcCcsqTurKK1/dKNN3z2ejNwRrsXqp/Cs5vwCCfl
	 hXcyXp2dCFfKF7kVjauzNgM1OV7nq9ueIH/kI8Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgABUIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgABUIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:08:18 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0EFD21582;
        Thu,  2 Jan 2020 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577995698;
        bh=u8TLozKgZTv2XCYHNNRwZ+d0hbnTh5rThslEK5lC0z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QUbZ2zXREjcwAaCpA6iyvMgik2HvMhSG9Bgh8SvTScxbgdZY/r4STNHI4xkvdJVKR
         nBpwu55Dmrq7ACMZN5RQ4SOleCwwCDsXtTGtoker1TsmZzJbKo0t3i7WiJaJ5b40fO
         enHGmoxR88SIB6JhX0Egbu7ye8GvqDYzR/itM6Ww=
Date:   Thu, 2 Jan 2020 12:08:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: Fix possible soft lockup warning at bootup
Message-Id: <20200102120817.d1c289313747cfde7270076f@linux-foundation.org>
In-Reply-To: <20200102154149.7564-1-longman@redhat.com>
References: <20200102154149.7564-1-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jan 2020 10:41:49 -0500 Waiman Long <longman@redhat.com> wrote:

> It was found that watchdog soft lockup warning was displayed on some
> arm64 server systems at bootup time:
> 
> ...
>
> Further analysis of the situation revealed that the smp_init() call
> itself took more than 20s for that 2-socket 56-core and 224-thread
> server.
> 
>  [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
>    :
>  [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]
> 
> By adding some instrumentation code, it was found that for cpu 14,
> watchdog_enable() was called early with a timestamp of 1. The first
> watchdog timer callback for that cpu, however, happened really late at
> the above 25s timestamp mark causing the watchdog logic to treat the
> delay as a soft lockup.
> 
> On another arm64 system that doesn't show the soft lockup warning, the
> watchdog timer callback happened earlier at the 5s timestamp mark with
> the watchdog thread invoked shortly after that.
> 
> The reason why there was such a delay in the first watchdog timer
> callback for that particular system wasn't fully known yet.

Mysteries are unwelcome.  Are you continuing to investigate this?

> Given
> the fact that smp_init() can run for a long time on some systems,
> it is probably more appropriate to enable the watchdog function after
> smp_init() instead of before it.
> 
> Another way is to leave watchdog_touch_ts at 0 in watchdog_enable()
> while the system is at the booting stage. Either one of those should
> be able to eliminate the soft lockup warning on bootup.
> 
> ...
>
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -496,7 +496,9 @@ static void watchdog_enable(unsigned int cpu)
>  		      HRTIMER_MODE_REL_PINNED_HARD);
>  
>  	/* Initialize timestamp */
> -	__touch_watchdog();
> +	if (system_state != SYSTEM_BOOTING)
> +		__touch_watchdog();

A comment which explains the system_state test would be appropriate
here.

>  	/* Enable the perf event */
>  	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
>  		watchdog_nmi_enable(cpu);

