Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964952082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQYOyZFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfC0X1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:27:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfC0X1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:27:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so12890151wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Lt5TVh5MU0d2cp8puyfpebNIyB3NvyiWzTqut/fJ9I=;
        b=BQYOyZFWS2ESn0GzsZHeiNYTWdgeGa7idQbBBzduH538wb3FEdmjDFdD47hww2r+aM
         rwbhtlaAUT4mex3fKn0FDMht8QXg3gLq1fLA5VmuqCx+aKk+CHpYut6swC1PaY10Ojjc
         QhRCMNlmweMHfKfo1O1KzvVM7qQc4GG0qFF+SWVHbzl/u4bz27xr2fkdBYjv7M6Rdi9P
         rRbq3zlkn+Y9pJ/6EDDdE3c5HdoMs0a5su1sxzpaUHPeH4q/IvuK1N58HaT5iQl421fh
         J2UTEEZpSgLYBM93nUPTVYOyTWWpOaUoowi+ZIrq5e7NLgH5Uf3u0uWwHWuN/3AxoFs9
         DQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Lt5TVh5MU0d2cp8puyfpebNIyB3NvyiWzTqut/fJ9I=;
        b=IxsJkftNSqUvRormYfpPjtGJPsFIxW88g3BfXz8XJZAiMV3Qd/VgaClT3mFf2Tjzfy
         B8NY320boLE28CFhYpK/o5sFsrSnUJUUI5isTAqIOZu0fZTIHemhZj2ALA0YMK7JpVrh
         f4kARMZMDUDUWYYfUutnjANFhqmgs04/RReul+ObLhdVZNRgjsF0BNkKFKntVa2SGZPk
         xu1E8v9RFXh7gVDLPxnib+RFHZ1sTrUDArexI6E8m5UEPs43+4nyvtyj5uBUCXb0dWUq
         D9TyH/n5FjKQXcTIXdTA0bqmdjimdBvkbbuL5AoimoWwlCYPe41SIZbQy+PPxwES2+gH
         dTog==
X-Gm-Message-State: APjAAAXa0Yf4zKKUWEvFJGyiSk8p+5RBafYqdLXhft9upYmhqYgfbPht
        JCPT9J8piIrkpJAP0ZdcbxLYldMK2XQW/B5FPY2GbfKi5xM=
X-Google-Smtp-Source: APXvYqweMuZgvSOqL3BJbFAsuL5+uUYOy5/4CLtCLZudUBP8XHdkvw7A3p03WgBKZaiV97/rUZTpYV7PSGEWwYjKYRU=
X-Received: by 2002:a5d:6050:: with SMTP id j16mr25530523wrt.253.1553729230185;
 Wed, 27 Mar 2019 16:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-2-omosnace@redhat.com>
In-Reply-To: <20190307123254.348-2-omosnace@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 27 Mar 2019 16:26:57 -0700
Message-ID: <CALAqxLUi3xnRJ2fpoNnwDwQ=6mddPSBt0BtXMrq-12W5j9KCxA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:33 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
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
> For reference, running the following commands:
>
>     auditctl -D
>     auditctl -a exit,always -F arch=3Db64 -S adjtimex
>     chronyd -q
>
> triggers (among others) a syscall that produces audit records like this:
>
> type=3DTIME_INJOFFSET msg=3Daudit(1530616049.652:13): sec=3D-16 nsec=3D12=
4887145
> type=3DSYSCALL msg=3Daudit(1530616049.652:13): arch=3Dc000003e syscall=3D=
159 success=3Dyes exit=3D5 a0=3D7fff57e78270 a1=3D1 a2=3Dfffffffffffffff0 a=
3=3D137b828205ca12 items=3D0 ppid=3D626 pid=3D629 auid=3D0 uid=3D385 gid=3D=
382 euid=3D385 suid=3D385 fsuid=3D385 egid=3D382 sgid=3D382 fsgid=3D382 tty=
=3D(none) ses=3D1 comm=3D"chronyd" exe=3D"/usr/sbin/chronyd" subj=3Dsystem_=
u:system_r:kernel_t:s0 key=3D(null)
> type=3DPROCTITLE msg=3Daudit(1530616049.652:13): proctitle=3D6368726F6E79=
64002D71 cd /home/omosnace/Dokumenty/Kernel/worktrees/audit/src/kernel/time
> s

Hrm.  Ugly log spam aside (I get it sort of goes with the territory
:), I could imagine someone looking at this and wanting to also know
when the injection was applied. Obviously the whole point of the
offset injection is we don't really care about the when, we only want
a fixed offset to be made atomically.  That said, if someone did try
to add such a timestamp on the log, there's the problem of trying to
calculate the time while holding the timekeeping locks.   So, are you
certain the next request won't be to try to to also calculate a
timestamp and push it into the audit_log() call as well?

Also, we have to be careful with anything we call from the timekeeping
code, its really easy for some corner case to trip something that then
tries to read the time and we deadlock, particularly with rare cases
like time adjustments.  I'm not familiar with the audit subsystem, but
from a maintenance point of view, can we make sure there's enough
documentation so that audit_log() and everything it calls will never
in the future call back into the timekeeping code?   I suspect this is
already covered, so apologies for the boilerplate concern, but I want
to be sure.


> The above records have been produced by the following syscall from
> chronyd (as per strace output):
>
> adjtimex({modes=3DADJ_SETOFFSET|ADJ_NANO, offset=3D0, freq=3D750433, maxe=
rror=3D16000000, esterror=3D16000000, status=3DSTA_UNSYNC|STA_NANO, constan=
t=3D2, precision=3D1, tolerance=3D32768000, time=3D{tv_sec=3D1530616033, tv=
_usec=3D778717675}, tick=3D10000, ppsfreq=3D0, jitter=3D0, shift=3D0, stabi=
l=3D0, jitcnt=3D0, calcnt=3D0, errcnt=3D0, stbcnt=3D0, tai=3D0}) =3D 5 (TIM=
E_ERROR)
>
> (The struct timex fields above are from *after* the syscall was
> executed, so they contain the current (new) values as set from the
> kernel, except of the 'modes' field, which contains the original value
> sent by the caller.)
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h      | 15 +++++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/auditsc.c           |  8 ++++++++
>  kernel/time/timekeeping.c  |  6 ++++++
>  4 files changed, 30 insertions(+)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 1e69d9fe16da..43a60fbe74be 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -27,6 +27,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/namei.h>  /* LOOKUP_* */
>  #include <uapi/linux/audit.h>
> +#include <uapi/linux/timex.h>
>
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
>  #define AUDIT_DEV_UNSET ((dev_t)-1)
> @@ -365,6 +366,7 @@ extern void __audit_log_capset(const struct cred *new=
, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_log_kern_module(char *name);
>  extern void __audit_fanotify(unsigned int response);
> +extern void __audit_tk_injoffset(struct timespec64 offset);
>
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -467,6 +469,16 @@ static inline void audit_fanotify(unsigned int respo=
nse)
>                 __audit_fanotify(response);
>  }
>
> +static inline void audit_tk_injoffset(struct timespec64 offset)
> +{
> +       /* ignore no-op events */
> +       if (offset.tv_sec =3D=3D 0 && offset.tv_nsec =3D=3D 0)
> +               return;
> +
> +       if (!audit_dummy_context())
> +               __audit_tk_injoffset(offset);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -580,6 +592,9 @@ static inline void audit_log_kern_module(char *name)
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
> index 36a7e3f18e69..2167d55bc800 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -114,6 +114,7 @@
>  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet =
unanswerd */
>  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
>  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> +#define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant *=
/
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1eab1d4a930..781336d0f2de 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2512,6 +2512,14 @@ void __audit_fanotify(unsigned int response)
>                 AUDIT_FANOTIFY, "resp=3D%u", response);
>  }
>
> +/* We need to allocate with GFP_ATOMIC here, since these two functions w=
ill be
> + * called while holding the timekeeping lock: */
> +void __audit_tk_injoffset(struct timespec64 offset)
> +{
> +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> +                 "sec=3D%lli nsec=3D%li", (long long)offset.tv_sec, offs=
et.tv_nsec);
> +}
> +
>  static void audit_log_task(struct audit_buffer *ab)
>  {
>         kuid_t auid, uid;
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index ac5dbf2cd4a2..0f0b566afe61 100644
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
>         /* signal hrtimers about time change */
>         clock_was_set();
>
> +       if (!ret)
> +               audit_tk_injoffset(ts_delta);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL(do_settimeofday64);
> @@ -2322,6 +2326,8 @@ int do_adjtimex(struct timex *txc)
>                 ret =3D timekeeping_inject_offset(&delta);
>                 if (ret)
>                         return ret;
> +
> +               audit_tk_injoffset(delta);
>         }
>
>         ktime_get_real_ts64(&ts);

Ignoring my worry above, from a quick read over, the code here looks
ok to me. Though I've not actually applied and tinkered with it.

Acked-by: John Stultz <john.stultz@linaro.org>
