Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981472077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfKGI4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:56:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfKGI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:56:23 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSdaU-0001WD-DO; Thu, 07 Nov 2019 09:56:18 +0100
Date:   Thu, 7 Nov 2019 09:56:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Stancek <jstancek@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
Message-ID: <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

The subsystem prefix for acct is surely not 'kernel.'. Try:

 git log --oneline kernel/acct.c

On Sat, 2 Nov 2019, Jan Stancek wrote:
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 81f9831a7859..991c898160cd 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -417,6 +417,7 @@ static void fill_ac(acct_t *ac)
>  	struct pacct_struct *pacct = &current->signal->pacct;
>  	u64 elapsed, run_time;
>  	struct tty_struct *tty;
> +	struct timespec64 ts;
>  
>  	/*
>  	 * Fill the accounting struct with the needed info as recorded
> @@ -448,7 +449,8 @@ static void fill_ac(acct_t *ac)
>  	}
>  #endif
>  	do_div(elapsed, AHZ);
> -	ac->ac_btime = get_seconds() - elapsed;
> +	ktime_get_real_ts64(&ts);
> +	ac->ac_btime = ts.tv_sec - elapsed;

So the calculation goes like this:

   runtime = ktime_get_ns() - current->...->start_time;

   elapsed = ns_to_ahz(runtime)
   
   elapsed /= AHZ	-> runtime in seconds
   
And then you retrieve the current wall time and just use the seconds
portion for building the delta. That still can fail in corner cases when
the runtime to seconds conversion does not have truncation in the
conversions and the timespec nanoseconds part is close to 1e9.

There is another issue related to suspend. If the system suspends then
runtime is accurate vs. clock MONOTONIC, but the offset between clock
MONOTONIC and clock REALTIME is not longer the same due to the
suspend/resume which has the same issue as what you are trying to solve
because

   runtime = totaltime - time_in_suspend

so your ac_btime will be off by time_in_suspend.

Something like this should work:

   runtime = ktime_get_ns() - current->...->start_time;
   ....
   runtime_boot = ktime_get_boot_ns() - current->...->real_start_time;
   start_ns = ktime_get_real_ns() - runtime_boot;
   start_s = startns / NSEC_PER_SEC;

current->...->real_start_time is clearly a misnomer as it suggests
CLOCK_REALTIME at first sight ...

But it would be way simpler just to store the CLOCK_REALTIME start time
along with BOOT and MONOTONIC and just get rid of all these horrible
calculations which are bound to be wrong.

Peter?

Thanks,

	tglx

   


