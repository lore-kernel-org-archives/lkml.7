Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C37C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437F12183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfC1ACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:02:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51956 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfC1ACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:02:43 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9IVB-0005gG-DL; Thu, 28 Mar 2019 01:02:37 +0100
Date:   Thu, 28 Mar 2019 01:02:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH ghak10 v6 2/2] ntp: Audit NTP parameters adjustment
In-Reply-To: <20190307123254.348-3-omosnace@redhat.com>
Message-ID: <alpine.DEB.2.21.1903280039530.1789@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-3-omosnace@redhat.com>
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

> Emit an audit record every time selected NTP parameters are modified
> from userspace (via adjtimex(2) or clock_adjtime(2)).
> 
> Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
> containing the following fields:
>   - op -- which value was adjusted:
>     - offset -- corresponding to the time_offset variable
>     - freq   -- corresponding to the time_freq variable
>     - status -- corresponding to the time_status variable
>     - adjust -- corresponding to the time_adjust variable
>     - tick   -- corresponding to the tick_usec variable
>     - tai    -- corresponding to the timekeeping's TAI offset
>   - old -- the old value
>   - new -- the new value
> 
> For reference, running the following commands:
> 
>     auditctl -D
>     auditctl -a exit,always -F arch=b64 -S adjtimex
>     chronyd -q
> 
> produces audit records like this:
> 
> type=SYSCALL msg=audit(1530616044.507:5): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=0 a2=4 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)

<SNIP gazillions of lines of unparseable garbage>

Is it really necessary to put this into the changelog?

>  
> +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> +{
> +	audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,

No.

> +		  "op=%s old=%lli new=%lli", type,
> +		  (long long)oldval, (long long)newval);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 36a2bef00125..5f456a84151a 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -17,6 +17,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/rtc.h>
> +#include <linux/audit.h>
>  
>  #include "ntp_internal.h"
>  #include "timekeeping_internal.h"
> @@ -293,6 +294,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
>  
>  static void ntp_update_offset(long offset)
>  {
> +	s64 old_offset = time_offset;
> +	s64 old_freq = time_freq;
>  	s64 freq_adj;
>  	s64 offset64;
>  	long secs;
> @@ -341,6 +344,9 @@ static void ntp_update_offset(long offset)
>  	time_freq   = max(freq_adj, -MAXFREQ_SCALED);
>  
>  	time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
> +
> +	audit_ntp_adjust("offset", old_offset, time_offset);
> +	audit_ntp_adjust("freq", old_freq, time_freq);
>  }
>  
>  /**
> @@ -658,21 +664,31 @@ static inline void process_adj_status(const struct timex *txc)
>  
>  static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
>  {
> -	if (txc->modes & ADJ_STATUS)
> -		process_adj_status(txc);
> +	if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
> +		int old_status = time_status;
> +
> +		if (txc->modes & ADJ_STATUS)
> +			process_adj_status(txc);
> -	if (txc->modes & ADJ_NANO)
> -		time_status |= STA_NANO;
> +		if (txc->modes & ADJ_NANO)
> +			time_status |= STA_NANO;
>  
> -	if (txc->modes & ADJ_MICRO)
> -		time_status &= ~STA_NANO;
> +		if (txc->modes & ADJ_MICRO)
> +			time_status &= ~STA_NANO;
> +
> +		audit_ntp_adjust("status", old_status, time_status);
> +	}
>  
>  	if (txc->modes & ADJ_FREQUENCY) {
> +		s64 old_freq = time_freq;
> +
>  		time_freq = txc->freq * PPM_SCALE;
>  		time_freq = min(time_freq, MAXFREQ_SCALED);
>  		time_freq = max(time_freq, -MAXFREQ_SCALED);
>  		/* update pps_freq */
>  		pps_set_freq(time_freq);
> +
> +		audit_ntp_adjust("freq", old_freq, time_freq);
>  	}
>  
>  	if (txc->modes & ADJ_MAXERROR)
> @@ -689,14 +705,18 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
>  		time_constant = max(time_constant, 0l);
>  	}
>  
> -	if (txc->modes & ADJ_TAI && txc->constant > 0)
> +	if (txc->modes & ADJ_TAI && txc->constant > 0) {
> +		audit_ntp_adjust("tai", *time_tai, txc->constant);
>  		*time_tai = txc->constant;
> +	}
>  
>  	if (txc->modes & ADJ_OFFSET)
>  		ntp_update_offset(txc->offset);
>  
> -	if (txc->modes & ADJ_TICK)
> +	if (txc->modes & ADJ_TICK) {
> +		audit_ntp_adjust("tick", tick_usec, txc->tick);
>  		tick_usec = txc->tick;
> +	}
>  
>  	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
>  		ntp_update_frequency();
> @@ -718,6 +738,8 @@ int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
>  			/* adjtime() is independent from ntp_adjtime() */
>  			time_adjust = txc->offset;
>  			ntp_update_frequency();
> +
> +			audit_ntp_adjust("adjust", save_adjust, txc->offset);
>  		}
>  		txc->offset = save_adjust;
>  	} else {

Not going to happen. We are not reshuffling all that code just to
accomodate random audit log invocations in a critical section plus having a
gazillion of GFP_ATOMIC allocation in the critical section just because.

The whole information can be reconstructed after the fact:

   1) Copy the user space supplied struct timex to a buffer

   2) Retrieve the current timex information _before_ invoking
      do_adjtimex().

   3) Look at the ret value and the resulting struct timex which is going
      to be copied back to user space and figure out with the help of #1
      and #2 what you need to log.

That does not even need a single line of change in the NTP code and almost
everything happens in fully preemptible context.

Thanks,

	tglx
