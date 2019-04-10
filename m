Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9FD20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfDJGYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:24:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:24:36 -0400
Received: from 135.red-80-26-73.staticip.rima-tde.net ([80.26.73.135] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hE6es-0007J7-3r; Wed, 10 Apr 2019 08:24:30 +0200
Date:   Wed, 10 Apr 2019 08:24:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ghak10 v7 2/2] ntp: Audit NTP parameters adjustment
In-Reply-To: <20190409123134.19350-3-omosnace@redhat.com>
Message-ID: <alpine.DEB.2.21.1904100819290.2020@nanos.tec.linutronix.de>
References: <20190409123134.19350-1-omosnace@redhat.com> <20190409123134.19350-3-omosnace@redhat.com>
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
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 2c62c0468888..1c372ad7ebe9 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -86,6 +86,26 @@ struct audit_field {
>  	u32				op;
>  };
>  
> +#define AUDIT_NTP_OFFSET	0
> +#define AUDIT_NTP_FREQ		1
> +#define AUDIT_NTP_STATUS	2
> +#define AUDIT_NTP_TAI		3
> +#define AUDIT_NTP_TICK		4
> +#define AUDIT_NTP_ADJUST	5
> +#define AUDIT_NTP_NVALS		6 /* count */

That should be an named enum and the id argument should be the same type.

> @@ -720,14 +721,29 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
>  			/* adjtime() is independent from ntp_adjtime() */
>  			time_adjust = txc->offset;
>  			ntp_update_frequency();
> +
> +			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
> +			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
>  		}
>  		txc->offset = save_adjust;
>  	} else {
> -
>  		/* If there are input parameters, then process them: */
> -		if (txc->modes)
> +		if (txc->modes) {
> +			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
> +			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
> +			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
> +			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
> +			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	tick_usec);
> +
>  			process_adjtimex_modes(txc, time_tai);
>  
> +			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
> +			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
> +			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
> +			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
> +			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	tick_usec);
> +		}

Yes, that looks much more palatable! Nice work!

With the above addressed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


