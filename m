Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13242C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D868E217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfC0XhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:37:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51901 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0XhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:37:19 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9I6b-0004fr-1k; Thu, 28 Mar 2019 00:37:13 +0100
Date:   Thu, 28 Mar 2019 00:37:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
In-Reply-To: <20190307123254.348-2-omosnace@redhat.com>
Message-ID: <alpine.DEB.2.21.1903280020390.1789@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-2-omosnace@redhat.com>
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

On Thu, 7 Mar 2019, Ondrej Mosnacek wrote:
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2512,6 +2512,14 @@ void __audit_fanotify(unsigned int response)
>  		AUDIT_FANOTIFY,	"resp=%u", response);
>  }
>  
> +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> + * called while holding the timekeeping lock: */

Audit is no justification for doing ATOMIC allocations just because it's
convenient in the middle of code which blocks every concurrent reader. 

Please find a place outside of the timekeeper lock to do that audit
logging. Either that or allocate your buffer upfront in a preemptible
section and commit after the critical section.

/*
 * Aside of that please use proper multiline comment style and not this
 * horrible other one.
 */

> +void __audit_tk_injoffset(struct timespec64 offset)
> +{
> +	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> +		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> +}
> +
> @@ -1250,6 +1251,9 @@ out:
>  	/* signal hrtimers about time change */
>  	clock_was_set();
>  
> +	if (!ret)
> +		audit_tk_injoffset(ts_delta);

This one does not need GFP_ATOMIC at all.

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(do_settimeofday64);
> @@ -2322,6 +2326,8 @@ int do_adjtimex(struct timex *txc)
>  		ret = timekeeping_inject_offset(&delta);
>  		if (ret)
>  			return ret;
> +
> +		audit_tk_injoffset(delta);
>  	}
>  
>  	ktime_get_real_ts64(&ts);

This can be done at the end of do_adjtimex() quite nicely in preemptible
context.

Thanks,

	tglx
