Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53908C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A54217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfDAJRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:17:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44428 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAJRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:17:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so7846168otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+oLSmWs9QxUqdsB5rde/qXE+3wWFB5/ZGcVSlmjCb8=;
        b=S8JBeb53/blhPSzaHxV3dms29S6P4F6t5b4HY7tHr5WHpMe0aaoOYLZ08bjow6grM5
         SORSZ4HHK6YjSQQai58YlaaEwk1vgVXYjMe1RyO3mHpcSITx78SMEacJR15orLR1sIw4
         9QMaYlu3S+mESzlJss8OjeidFxe4nM0HkMI8P7mCdvP8mrAAU7ruT78V+ZXKpguANiB9
         xB8NncQKZfnGJOJSo6j7vj/ZG3p3jGeq/G+B/o8FK3BLsedrbLzxWxsu2r6RSduvSh52
         5TLse8H2W1fV3RlaR3S2a8fovyD/+1AjJxz+cEP+Wfe9CmXnW3E7qkawcHbqGSD5t6rv
         0BCg==
X-Gm-Message-State: APjAAAVbtncGOJSmsd9/A0QEtZOjPR4B0P68XSWeBKfCupS8CA5P88T2
        CEKjKyg6zTixJImu+T5vhNzTshWbJPQbNOHsAfZelQ==
X-Google-Smtp-Source: APXvYqzTLdg5cEvk1jUgMod0ZsU/OSVLU8QrVyubyZyGQt932eS9KuPXVFpfh3AYxiwIqrLG04eY0Wl6S77jIm5feWE=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr14460185otl.86.1554110219669;
 Mon, 01 Apr 2019 02:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-2-omosnace@redhat.com>
 <alpine.DEB.2.21.1903280020390.1789@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903280020390.1789@nanos.tec.linutronix.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Apr 2019 11:16:48 +0200
Message-ID: <CAFqZXNtHxt6Huv2ufU-gp-0Y4WfyQSJkYVS0cmd0o+G=D1A-UQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v6 1/2] timekeeping: Audit clock adjustments
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 7 Mar 2019, Ondrej Mosnacek wrote:
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2512,6 +2512,14 @@ void __audit_fanotify(unsigned int response)
> >               AUDIT_FANOTIFY, "resp=%u", response);
> >  }
> >
> > +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> > + * called while holding the timekeeping lock: */
>
> Audit is no justification for doing ATOMIC allocations just because it's
> convenient in the middle of code which blocks every concurrent reader.
>
> Please find a place outside of the timekeeper lock to do that audit
> logging. Either that or allocate your buffer upfront in a preemptible
> section and commit after the critical section.
>
> /*
>  * Aside of that please use proper multiline comment style and not this
>  * horrible other one.
>  */

Oh, sorry, I wrote that code last summer, when I didn't quite have the
kernel coding style in my blood yet :) But fortunately I shouldn't
need that comment at all in the next version...

>
> > +void __audit_tk_injoffset(struct timespec64 offset)
> > +{
> > +     audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> > +               "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> > +}
> > +
> > @@ -1250,6 +1251,9 @@ out:
> >       /* signal hrtimers about time change */
> >       clock_was_set();
> >
> > +     if (!ret)
> > +             audit_tk_injoffset(ts_delta);
>
> This one does not need GFP_ATOMIC at all.
>
> > +
> >       return ret;
> >  }
> >  EXPORT_SYMBOL(do_settimeofday64);
> > @@ -2322,6 +2326,8 @@ int do_adjtimex(struct timex *txc)
> >               ret = timekeeping_inject_offset(&delta);
> >               if (ret)
> >                       return ret;
> > +
> > +             audit_tk_injoffset(delta);
> >       }
> >
> >       ktime_get_real_ts64(&ts);
>
> This can be done at the end of do_adjtimex() quite nicely in preemptible
> context.

But wait, isn't this call outside of the critical section as well? (I
must have been moving the call around when I was writing the code and
didn't realize that this function actually doesn't need GFP_ATOMIC at
all...) Or am I missing something?


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
