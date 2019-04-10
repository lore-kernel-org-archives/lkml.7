Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA773C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfDJGZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:25:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfDJGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:25:57 -0400
Received: from 135.red-80-26-73.staticip.rima-tde.net ([80.26.73.135] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hE6gC-0007MA-8t; Wed, 10 Apr 2019 08:25:52 +0200
Date:   Wed, 10 Apr 2019 08:25:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ghak10 v7 1/2] timekeeping: Audit clock adjustments
In-Reply-To: <20190409123134.19350-2-omosnace@redhat.com>
Message-ID: <alpine.DEB.2.21.1904100825200.2020@nanos.tec.linutronix.de>
References: <20190409123134.19350-1-omosnace@redhat.com> <20190409123134.19350-2-omosnace@redhat.com>
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

On Tue, 9 Apr 2019, Ondrej Mosnacek wrote:
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -21,6 +21,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/pvclock_gtod.h>
>  #include <linux/compiler.h>
> +#include <linux/audit.h>
>  
>  #include "tick-internal.h"
>  #include "ntp_internal.h"
> @@ -1250,6 +1251,9 @@ out:
>  	/* signal hrtimers about time change */
>  	clock_was_set();
>  
> +	if (!ret)
> +		audit_tk_injoffset(ts_delta);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(do_settimeofday64);
> @@ -2322,6 +2326,8 @@ int do_adjtimex(struct __kernel_timex *txc)
>  		ret = timekeeping_inject_offset(&delta);
>  		if (ret)
>  			return ret;
> +
> +		audit_tk_injoffset(delta);
>  	}
>  
>  	ktime_get_real_ts64(&ts);

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
