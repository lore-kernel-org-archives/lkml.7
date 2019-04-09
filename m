Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEBAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FC120833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDIO06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:26:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIO06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:26:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A61673018ECF;
        Tue,  9 Apr 2019 14:26:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F605D962;
        Tue,  9 Apr 2019 14:26:50 +0000 (UTC)
Date:   Tue, 9 Apr 2019 10:26:47 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ghak10 v7 1/2] timekeeping: Audit clock adjustments
Message-ID: <20190409142647.oijxnedqf2dicxbi@madcap2.tricolour.ca>
References: <20190409123134.19350-1-omosnace@redhat.com>
 <20190409123134.19350-2-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409123134.19350-2-omosnace@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Apr 2019 14:26:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-09 14:31, Ondrej Mosnacek wrote:
> Emit an audit record whenever the system clock is changed (i.e. shifted
> by a non-zero offset) by a syscall from userspace. The syscalls than can
> (at the time of writing) trigger such record are:
>   - settimeofday(2), stime(2), clock_settime(2) -- via
>     do_settimeofday64()
>   - adjtimex(2), clock_adjtime(2) -- via do_adjtimex()
> 
> The new records have type AUDIT_TIME_INJOFFSET and contain the following
> fields:
>   - sec -- the 'seconds' part of the offset
>   - nsec -- the 'nanoseconds' part of the offset
> 
> Example record (time was shifted backwards by ~16.125 seconds):
> 
> type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145

I have a minor nit about the interpretation of these values.  I realize
the values printed are the ones that are supplied.  When the sec
value is negative, does that imply that the nsec value has the same
sign?  IOW, are the two values added with a multiplier to the nsec
value, or are they concatenated with a decimal in the middle?  I expect
the latter.  In the current userspace support, there is no explicit type
support included yet for interpreted fields.  This is just a minor
documentation issue to me.  

> The records of this type will be associated with the corresponding
> syscall records.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  include/linux/audit.h      | 14 ++++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           |  6 ++++++
>  kernel/time/timekeeping.c  |  6 ++++++
>  4 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 1e69d9fe16da..2c62c0468888 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -365,6 +365,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_log_kern_module(char *name);
>  extern void __audit_fanotify(unsigned int response);
> +extern void __audit_tk_injoffset(struct timespec64 offset);
>  
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -467,6 +468,16 @@ static inline void audit_fanotify(unsigned int response)
>  		__audit_fanotify(response);
>  }
>  
> +static inline void audit_tk_injoffset(struct timespec64 offset)
> +{
> +	/* ignore no-op events */
> +	if (offset.tv_sec == 0 && offset.tv_nsec == 0)
> +		return;
> +
> +	if (!audit_dummy_context())
> +		__audit_tk_injoffset(offset);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -580,6 +591,9 @@ static inline void audit_log_kern_module(char *name)
>  static inline void audit_fanotify(unsigned int response)
>  { }
>  
> +static inline void audit_tk_injoffset(struct timespec64 offset)
> +{ }
> +
>  static inline void audit_ptrace(struct task_struct *t)
>  { }
>  #define audit_n_rules 0
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 3901c51c0b93..ab58d67baf4d 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -114,6 +114,7 @@
>  #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
>  #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
>  #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
> +#define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 51a2ceb3a1ca..80dfe0cdc636 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2512,6 +2512,12 @@ void __audit_fanotify(unsigned int response)
>  		AUDIT_FANOTIFY,	"resp=%u", response);
>  }
>  
> +void __audit_tk_injoffset(struct timespec64 offset)
> +{
> +	audit_log(audit_context(), GFP_KERNEL, AUDIT_TIME_INJOFFSET,
> +		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>  	kuid_t auid, uid;
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index f986e1918d12..3d24be4cd607 100644
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
> -- 
> 2.20.1
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
