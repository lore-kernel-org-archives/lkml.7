Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108BCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE120833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfDIPFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:05:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33060 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfDIPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:05:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so13864837oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1HuW9YLnEnMz8tserQMgKGS9dsMWN5Ltt0ANXmLvmM=;
        b=Vq3eeu6nx+vsNrMV1JsOBNuY7To4TQKQc10Je6LYv5JP87q/Hd56h9X3K6W8XIcc7l
         3MnRrjYDg2yHjsBoMP2hHwgon8mfuUqnwsFuPf6iH8B9wCOBMNPkMWNMGkuCsrKon66z
         HiCdIg1GqTOjDNS9R91AXWjXR/z9H3B4TKW5NAKzEDHvrUsSj+34glt7uFFDdIX7zGdM
         KB4tuPPYR7qXakzrdQ5wbPRREVszYAwVokvVAQwSfcQn37pGaUBj84lBICeuxxGCuHNX
         q2kN1bbz2Bif0dBd5U4LLydqVHSysz34icvhEe1ntP9IrUSAkm0quZ0JPOXMT6yYQM6w
         RiKg==
X-Gm-Message-State: APjAAAUSslfkw2F37GZtwyJWTAZs1eBaPDEGem+pN8dTTQc+f44G7iWr
        2qVaGxh8MGxHQXGOizFUMrcqXGhxSUbf7vGbNG5eMQ==
X-Google-Smtp-Source: APXvYqwnB1x3SmE27hLE1Q/4mwLDqH3j70iJly41N+B1OIgqkWfFgsDMhlz4y5fBMBWAafacJ5X4APLm/3vi5rVfo3Q=
X-Received: by 2002:aca:aa14:: with SMTP id t20mr19688585oie.166.1554822349194;
 Tue, 09 Apr 2019 08:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190409123134.19350-1-omosnace@redhat.com> <20190409123134.19350-2-omosnace@redhat.com>
 <20190409142647.oijxnedqf2dicxbi@madcap2.tricolour.ca>
In-Reply-To: <20190409142647.oijxnedqf2dicxbi@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 9 Apr 2019 17:05:39 +0200
Message-ID: <CAFqZXNuxbzKifFm-dcgaUMojqNZtLipfsztrbR1RLfMG0RJwaA@mail.gmail.com>
Subject: Re: [PATCH ghak10 v7 1/2] timekeeping: Audit clock adjustments
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-04-09 14:31, Ondrej Mosnacek wrote:
> > Emit an audit record whenever the system clock is changed (i.e. shifted
> > by a non-zero offset) by a syscall from userspace. The syscalls than can
> > (at the time of writing) trigger such record are:
> >   - settimeofday(2), stime(2), clock_settime(2) -- via
> >     do_settimeofday64()
> >   - adjtimex(2), clock_adjtime(2) -- via do_adjtimex()
> >
> > The new records have type AUDIT_TIME_INJOFFSET and contain the following
> > fields:
> >   - sec -- the 'seconds' part of the offset
> >   - nsec -- the 'nanoseconds' part of the offset
> >
> > Example record (time was shifted backwards by ~16.125 seconds):
> >
> > type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145
>
> I have a minor nit about the interpretation of these values.  I realize
> the values printed are the ones that are supplied.  When the sec
> value is negative, does that imply that the nsec value has the same
> sign?  IOW, are the two values added with a multiplier to the nsec
> value, or are they concatenated with a decimal in the middle?  I expect
> the latter.  In the current userspace support, there is no explicit type
> support included yet for interpreted fields.  This is just a minor
> documentation issue to me.

Good point! I wrote the sentence too quickly without thinking about
it... I actually had to find this out for the tests (and looking at it
again, I got it wrong there as well, although in a different way...) -
it is actually the former variant (multiplier + addition). So the
"~16.125" should actually be "~15.875" (and I need to fix the
testsuite pull request...).

> > The records of this type will be associated with the corresponding
> > syscall records.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
>
> > ---
> >  include/linux/audit.h      | 14 ++++++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           |  6 ++++++
> >  kernel/time/timekeeping.c  |  6 ++++++
> >  4 files changed, 27 insertions(+)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 1e69d9fe16da..2c62c0468888 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -365,6 +365,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> >  extern void __audit_mmap_fd(int fd, int flags);
> >  extern void __audit_log_kern_module(char *name);
> >  extern void __audit_fanotify(unsigned int response);
> > +extern void __audit_tk_injoffset(struct timespec64 offset);
> >
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -467,6 +468,16 @@ static inline void audit_fanotify(unsigned int response)
> >               __audit_fanotify(response);
> >  }
> >
> > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > +{
> > +     /* ignore no-op events */
> > +     if (offset.tv_sec == 0 && offset.tv_nsec == 0)
> > +             return;
> > +
> > +     if (!audit_dummy_context())
> > +             __audit_tk_injoffset(offset);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -580,6 +591,9 @@ static inline void audit_log_kern_module(char *name)
> >  static inline void audit_fanotify(unsigned int response)
> >  { }
> >
> > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > +{ }
> > +
> >  static inline void audit_ptrace(struct task_struct *t)
> >  { }
> >  #define audit_n_rules 0
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 3901c51c0b93..ab58d67baf4d 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -114,6 +114,7 @@
> >  #define AUDIT_REPLACE                1329    /* Replace auditd if this packet unanswerd */
> >  #define AUDIT_KERN_MODULE    1330    /* Kernel Module events */
> >  #define AUDIT_FANOTIFY               1331    /* Fanotify access decision */
> > +#define AUDIT_TIME_INJOFFSET 1332    /* Timekeeping offset injected */
> >
> >  #define AUDIT_AVC            1400    /* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR    1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 51a2ceb3a1ca..80dfe0cdc636 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2512,6 +2512,12 @@ void __audit_fanotify(unsigned int response)
> >               AUDIT_FANOTIFY, "resp=%u", response);
> >  }
> >
> > +void __audit_tk_injoffset(struct timespec64 offset)
> > +{
> > +     audit_log(audit_context(), GFP_KERNEL, AUDIT_TIME_INJOFFSET,
> > +               "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> > +}
> > +
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> >       kuid_t auid, uid;
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index f986e1918d12..3d24be4cd607 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/stop_machine.h>
> >  #include <linux/pvclock_gtod.h>
> >  #include <linux/compiler.h>
> > +#include <linux/audit.h>
> >
> >  #include "tick-internal.h"
> >  #include "ntp_internal.h"
> > @@ -1250,6 +1251,9 @@ out:
> >       /* signal hrtimers about time change */
> >       clock_was_set();
> >
> > +     if (!ret)
> > +             audit_tk_injoffset(ts_delta);
> > +
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(do_settimeofday64);
> > @@ -2322,6 +2326,8 @@ int do_adjtimex(struct __kernel_timex *txc)
> >               ret = timekeeping_inject_offset(&delta);
> >               if (ret)
> >                       return ret;
> > +
> > +             audit_tk_injoffset(delta);
> >       }
> >
> >       ktime_get_real_ts64(&ts);
> > --
> > 2.20.1
> >
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635



--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
