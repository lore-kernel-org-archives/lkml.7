Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27ADC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBA02173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TKNaXcgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEIKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:16:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52709 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:16:48 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so2639663itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIlULqxElJ1UVkE3nskm96wPdXbmsrmyS+2BEAOEbgA=;
        b=TKNaXcgtz8qYEpIJukTzgb1p/hYDziVtcRMnhldabv9IEZDEmmTt6GQ0b32MdOp/Fw
         ezNjxHfzLcgAjU8NOmJ1J4l22ulRC/LF75pwJkpb8H9286c1K3NokoOjR5I3cDesGGOO
         7j8dariqP5gQI1oJ8E544TNYLpNorg0/ZRmHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIlULqxElJ1UVkE3nskm96wPdXbmsrmyS+2BEAOEbgA=;
        b=ZyISqmPhP2vOHF6towNH7DfhgJmfq0hxdQVWPehhMLqGb3bIZQ+uvnWyPfQ1+G5p5K
         0FBu2/SLaodJ/7yZqJRsI656bCnCO8lpaOXF5jnXU70TtGLqhPq8Bj1h2LpRuBRxK6GP
         U8CU+YEoGRpPhZFHVteBC2V03sQ8lYN5aFMcz49hjvI79msKv+1zvpj7aXtHSGD3Zbxv
         J+DctOw4e2SNP/1F+swCFJgrjeEuHrVSmdNFo3Gn/fKm+M5C8/Dcn2RcF4WLOCuj1RNc
         mxclvVC7UKspdwwAIYe1zoIsjOs9/8jFS1VObgXo9zjqzRAib65SduFAZwW91kb7RnYe
         BnhA==
X-Gm-Message-State: APjAAAXl/kVQ7GtWgnEmy12DZOG4SXbwv/mczf4/fQaBfX3tdApoSjz9
        wkz43kfzjnZuaTE0a599iFzccjjMBazguwNrvvuaUg==
X-Google-Smtp-Source: APXvYqyZlmQcMPgQ+QkSHFT6+ztPhQmc+dytbArYoVbadg3EgiCWpUn4c2dBNw1rJluViMtD20lPN8dtBf56VOQz0Zg=
X-Received: by 2002:a05:660c:6c8:: with SMTP id z8mr1111816itk.51.1557397007880;
 Thu, 09 May 2019 03:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch> <20190502194208.3535-2-daniel.vetter@ffwll.ch>
 <20190509092449.GA10828@jagdpanzerIV>
In-Reply-To: <20190509092449.GA10828@jagdpanzerIV>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 9 May 2019 12:16:36 +0200
Message-ID: <CAKMK7uGXyvnvq4ZVN+ps8ua5vaT13a2h+sjep7PgKeVxZU=qug@mail.gmail.com>
Subject: Re: [PATCH 2/2] RFC: soft/hardlookup: taint kernel
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Don Zickus <dzickus@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:24 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (05/02/19 21:42), Daniel Vetter wrote:
> [..]
> > @@ -469,6 +469,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >               add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> >               if (softlockup_panic)
> >                       panic("softlockup: hung tasks");
> > +             else
> > +                     add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> >               __this_cpu_write(soft_watchdog_warn, true);
>
> Soft lockup sets TAINT_SOFTLOCKUP bit. Would it be enough for your CI?

I'm blind :-/ Yes this is totally useful.

> [..]
> > @@ -154,6 +154,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
> >
> >               if (hardlockup_panic)
> >                       nmi_panic(regs, "Hard LOCKUP");
> > +             else
> > +                     add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>
> Maybe you can mirror what soft lockup does. Add a HARDLOCKUP taint bit

We'd also want a taint for hung tasks (separate patch, same idea), not
sure it's a good idea to use a new taint bit for all of them? Atm we
don't check for all taint bits (some of them are set because of things
our testcases do, like module reload or setting unsafe kernel options
meant for testing only, so picking one of the bits we check already
was least resistance.

> +++ b/include/linux/kernel.h
> @@ -571,7 +571,8 @@ extern enum system_states {
>  #define TAINT_LIVEPATCH                        15
>  #define TAINT_AUX                      16
>  #define TAINT_RANDSTRUCT               17
> -#define TAINT_FLAGS_COUNT              18
> +#define TAINT_HARDLOCKUP               18
> +#define TAINT_FLAGS_COUNT              19
>
> and then set TAINT_HARDLOCKUP in watchdog_overflow_callback().
>
> Just a small idea, I'll leave this to more experienced people.

The hung_tasks taint wasn't all that positively received, I feels like
this will stay a hack private to our CI. Except if someone else pipes
up who wants this, then I'm happy to polish.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
