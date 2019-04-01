Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1172086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDAJNg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:13:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43731 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDAJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:13:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so6608780oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4s4Yomw9BuDg6a9e//IEwzLl7T+Fra+SK55D5AJXvrM=;
        b=bU2SMhfhosMa7pCq0dNJpUMqKhrh+U1LfR7UTxMvqYrIOef1De+J2+l/BVk2m1wYDN
         z6fl1oSJ4LnaWg5yEu6AEg32IM8z+TlAhHCf65vy88InWigowoyyRAJoU83IzXRKr2RK
         NyiejIPcJ19ZO/p0UmU+hnTCFjaQdD38jaR34b/QNiqUNExIcv97AwuTKIVdbiHAzrDF
         C6crwo02FM9lXWSUS6496LCQh5lv/Zpo7MOwPkBgBsDMnx40XwCXF3FiF0HNUbehXA7w
         bU5AqrFl57Qvd1sr5oLwa3psirNPw4TxdU2w6Pi1GOECLXdSPHwkI3A8U9ZWOkJEdDXp
         hysg==
X-Gm-Message-State: APjAAAVcNMMVXNfojOolJur5e+le/ycsij8VMny12atyH+LYmMGr0CG+
        wrnR79UbL9jQ34HRhI46lZQdFQx7j6FgKm73dTfjFQ==
X-Google-Smtp-Source: APXvYqwhhIBnE0BWrpGrS8WAAO+WG3MVQUgOQJyPmgiprET7MHR+FNcnRkGLhMqsW74iv+e64jRkCpZ9f9g7ex/A1vo=
X-Received: by 2002:aca:c4d6:: with SMTP id u205mr12350139oif.26.1554110014864;
 Mon, 01 Apr 2019 02:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-3-omosnace@redhat.com>
 <alpine.DEB.2.21.1903280039530.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903280039530.1789@nanos.tec.linutronix.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Apr 2019 11:13:23 +0200
Message-ID: <CAFqZXNvQioPGUiU0q5R4nQLW7pQDsViNH-DR=SF4Fec+-CwksA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 2/2] ntp: Audit NTP parameters adjustment
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 7 Mar 2019, Ondrej Mosnacek wrote:
>
> > Emit an audit record every time selected NTP parameters are modified
> > from userspace (via adjtimex(2) or clock_adjtime(2)).
> >
> > Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
> > containing the following fields:
> >   - op -- which value was adjusted:
> >     - offset -- corresponding to the time_offset variable
> >     - freq   -- corresponding to the time_freq variable
> >     - status -- corresponding to the time_status variable
> >     - adjust -- corresponding to the time_adjust variable
> >     - tick   -- corresponding to the tick_usec variable
> >     - tai    -- corresponding to the timekeeping's TAI offset
> >   - old -- the old value
> >   - new -- the new value
> >
> > For reference, running the following commands:
> >
> >     auditctl -D
> >     auditctl -a exit,always -F arch=b64 -S adjtimex
> >     chronyd -q
> >
> > produces audit records like this:
> >
> > type=SYSCALL msg=audit(1530616044.507:5): arch=c000003e syscall=159 success=yes exit=5 a0=7fff57e78c00 a1=0 a2=4 a3=7f754ae28c0a items=0 ppid=626 pid=629 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=1 comm="chronyd" exe="/usr/sbin/chronyd" subj=system_u:system_r:kernel_t:s0 key=(null)
>
> <SNIP gazillions of lines of unparseable garbage>
>
> Is it really necessary to put this into the changelog?

Yeah, sorry, I went a bit overboard with the record examples... I'll
try to provide simpler and less verbose examples in the next version.

>
> >
> > +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > +{
> > +     audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
>
> No.
>
> > +               "op=%s old=%lli new=%lli", type,
> > +               (long long)oldval, (long long)newval);
> > +}
> > +
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> >       kuid_t auid, uid;
> > diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> > index 36a2bef00125..5f456a84151a 100644
> > --- a/kernel/time/ntp.c
> > +++ b/kernel/time/ntp.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/rtc.h>
> > +#include <linux/audit.h>
> >
> >  #include "ntp_internal.h"
> >  #include "timekeeping_internal.h"
> > @@ -293,6 +294,8 @@ static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
> >
> >  static void ntp_update_offset(long offset)
> >  {
> > +     s64 old_offset = time_offset;
> > +     s64 old_freq = time_freq;
> >       s64 freq_adj;
> >       s64 offset64;
> >       long secs;
> > @@ -341,6 +344,9 @@ static void ntp_update_offset(long offset)
> >       time_freq   = max(freq_adj, -MAXFREQ_SCALED);
> >
> >       time_offset = div_s64(offset64 << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
> > +
> > +     audit_ntp_adjust("offset", old_offset, time_offset);
> > +     audit_ntp_adjust("freq", old_freq, time_freq);
> >  }
> >
> >  /**
> > @@ -658,21 +664,31 @@ static inline void process_adj_status(const struct timex *txc)
> >
> >  static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
> >  {
> > -     if (txc->modes & ADJ_STATUS)
> > -             process_adj_status(txc);
> > +     if (txc->modes & (ADJ_STATUS | ADJ_NANO | ADJ_MICRO)) {
> > +             int old_status = time_status;
> > +
> > +             if (txc->modes & ADJ_STATUS)
> > +                     process_adj_status(txc);
> > -     if (txc->modes & ADJ_NANO)
> > -             time_status |= STA_NANO;
> > +             if (txc->modes & ADJ_NANO)
> > +                     time_status |= STA_NANO;
> >
> > -     if (txc->modes & ADJ_MICRO)
> > -             time_status &= ~STA_NANO;
> > +             if (txc->modes & ADJ_MICRO)
> > +                     time_status &= ~STA_NANO;
> > +
> > +             audit_ntp_adjust("status", old_status, time_status);
> > +     }
> >
> >       if (txc->modes & ADJ_FREQUENCY) {
> > +             s64 old_freq = time_freq;
> > +
> >               time_freq = txc->freq * PPM_SCALE;
> >               time_freq = min(time_freq, MAXFREQ_SCALED);
> >               time_freq = max(time_freq, -MAXFREQ_SCALED);
> >               /* update pps_freq */
> >               pps_set_freq(time_freq);
> > +
> > +             audit_ntp_adjust("freq", old_freq, time_freq);
> >       }
> >
> >       if (txc->modes & ADJ_MAXERROR)
> > @@ -689,14 +705,18 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
> >               time_constant = max(time_constant, 0l);
> >       }
> >
> > -     if (txc->modes & ADJ_TAI && txc->constant > 0)
> > +     if (txc->modes & ADJ_TAI && txc->constant > 0) {
> > +             audit_ntp_adjust("tai", *time_tai, txc->constant);
> >               *time_tai = txc->constant;
> > +     }
> >
> >       if (txc->modes & ADJ_OFFSET)
> >               ntp_update_offset(txc->offset);
> >
> > -     if (txc->modes & ADJ_TICK)
> > +     if (txc->modes & ADJ_TICK) {
> > +             audit_ntp_adjust("tick", tick_usec, txc->tick);
> >               tick_usec = txc->tick;
> > +     }
> >
> >       if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
> >               ntp_update_frequency();
> > @@ -718,6 +738,8 @@ int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
> >                       /* adjtime() is independent from ntp_adjtime() */
> >                       time_adjust = txc->offset;
> >                       ntp_update_frequency();
> > +
> > +                     audit_ntp_adjust("adjust", save_adjust, txc->offset);
> >               }
> >               txc->offset = save_adjust;
> >       } else {
>
> Not going to happen. We are not reshuffling all that code just to
> accomodate random audit log invocations in a critical section plus having a
> gazillion of GFP_ATOMIC allocation in the critical section just because.

OK, seems I underestimated the consequences of putting the logging
calls directly in there. While I was offline over the weekend I
already came up with a cleaner version that collects the changes in a
structure and does the logging outside of the critical section. I
currently does a few unnecessary writes into memory under
CONFIG_AUDIT=n, but if that is an issue I can boost the abstraction or
just add some #ifdefs to avoid that.

>
> The whole information can be reconstructed after the fact:
>
>    1) Copy the user space supplied struct timex to a buffer
>
>    2) Retrieve the current timex information _before_ invoking
>       do_adjtimex().
>
>    3) Look at the ret value and the resulting struct timex which is going
>       to be copied back to user space and figure out with the help of #1
>       and #2 what you need to log.
>
> That does not even need a single line of change in the NTP code and almost
> everything happens in fully preemptible context.

I worry that extracting everything from the timex structures might get
a little too complicated... Hopefully you'll be OK with the solution I
am preparing for v8 - it still adds a bit of code to ntp.c, but it's
much less intrusive.

Thanks a lot for the review!


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
