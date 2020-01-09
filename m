Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A68C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C94620678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jdjv0vum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgAIRm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:42:29 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33476 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgAIRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:42:29 -0500
Received: by mail-ot1-f47.google.com with SMTP id b18so8131001otp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJQU304VHQkkMGXJtC4nL1fGnD1E/KBCjfdV3OkjqvE=;
        b=Jdjv0vumGKpoWvbhDWnOYKT+r59dphPUdtZSJO+DpyW86Et0F9M1LiWghsUG4FyL0m
         U7DeXekNc4KmZppbSf+4H9Ilr3Jd3XAnwJwMaq02llFrzRM+Ns0Wo5Q78PZf2x0kBmon
         8QStIbwrywUl7/x88A3nAWAlLrIaJdmPZhMIfXWIJVWPSIgCGdlOjXRPRSp1GImhEJ/z
         jHOID0XSe19SJb5AKTKfjDpY8r5bh6AnFIitKtfVAPwCgsRRqHd+bpKgg8i9ltCCe6+f
         IrN75sxKirfMujc3f4F4F1u/VCqoyDc4jGFfAdnuWPLmP87jxfm4pcSR0Fnu1A0BU2yV
         jCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJQU304VHQkkMGXJtC4nL1fGnD1E/KBCjfdV3OkjqvE=;
        b=PZA/pwtNZMh1pGzPAiORS5Miss+QGOZB/4s0+Qej0EBqx3pvyTpQE92tpFaIyUx3b/
         IQSbcuLShztyWYxvNvEfX4L/L2XhEPxC2KGs4IwDq6Xmwxnx08WeZA89X7CUbJtSdzY7
         UQ0fqs6bN8F5JqQVufanITDPnifSnFfEzb2CO29ZQwqkb4ECOsJTy7h7NkTJ74z90PAM
         IiB6AMglv/UF4HXkQaJKDRmtGSRmKlmHFFnUZrhvYOvEgd9NFtjaVfBBRiE4gwDGbp3S
         TEQevkhji7gyUFIVbMLkx1RsI9TfVI2bulgCjGSyFFJJ7L7G5viElejQZxhF/SnVY5Gm
         ixpw==
X-Gm-Message-State: APjAAAUTfde9xUA03yff+0wSRbIbG554/fUESJzBS+zN5p8GmFRBdsNm
        HktVvXx3FYZppl/vodtGYVdGFDAztMz/LiY+QPI3HA==
X-Google-Smtp-Source: APXvYqzaK1XUgBGCRWkdnqBb5GMv5jiVMA9a2b83aw2Rpd12IJH5G/xkFbGqJ7MyCXSVl2seyYbRvCPDN3lR5pPzmx8=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr9858656oti.233.1578591748089;
 Thu, 09 Jan 2020 09:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20200109152322.104466-1-elver@google.com> <20200109162739.GS13449@paulmck-ThinkPad-P72>
 <CANpmjNOR4oT+yuGsjajMjWduKjQOGg9Ybd97L2jwY2ZJN8hgqg@mail.gmail.com> <20200109173127.GU13449@paulmck-ThinkPad-P72>
In-Reply-To: <20200109173127.GU13449@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jan 2020 18:42:16 +0100
Message-ID: <CANpmjNP=8cfqgXkz7f8D6STTn1-2h9qzUery4qMHeTTeNJOdxQ@mail.gmail.com>
Subject: Re: [PATCH -rcu 0/2] kcsan: Improvements to reporting
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 at 18:31, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 09, 2020 at 06:03:39PM +0100, Marco Elver wrote:
> > On Thu, 9 Jan 2020 at 17:27, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Jan 09, 2020 at 04:23:20PM +0100, Marco Elver wrote:
> > > > Improvements to KCSAN data race reporting:
> > > > 1. Show if access is marked (*_ONCE, atomic, etc.).
> > > > 2. Rate limit reporting to avoid spamming console.
> > > >
> > > > Marco Elver (2):
> > > >   kcsan: Show full access type in report
> > > >   kcsan: Rate-limit reporting per data races
> > >
> > > Queued and pushed, thank you!  I edited the commit logs a bit, so could
> > > you please check to make sure that I didn't mess anything up?
> >
> > Looks good to me, thank you.
> >
> > > At some point, boot-time-allocated per-CPU arrays might be needed to
> > > avoid contention on large systems, but one step at a time.  ;-)
> >
> > I certainly hope the rate of fixing/avoiding data races will not be
> > eclipsed by the rate at which new ones are introduced. :-)
>
> Me too!
>
> However, on a large system, duplicate reports might happen quite
> frequently, which might cause slowdowns given the single global
> array.  Or maybe not -- I guess we will find out soon enough. ;-)
>
> But I must confess that I am missing how concurrent access to the
> report_times[] array is handled.  I would have expected that
> rate_limit_report() would choose a random starting entry and
> search circularly.  And I would expect that the code at the end
> of that function would instead look something like this:
>
>         if (ktime_before(oldtime, invalid_before) &&
>             cmpxchg(&use_entry->time, oldtime, now) == oldtime) {
>                 use_entry->frame1 = frame1;
>                 use_entry->frame2 = frame2;
>         } else {
>                 // Too bad, next duplicate report won't be suppressed.
>         }
>
> Where "oldtime" is captured from the entry during the scan, and from the
> first entry scanned.  This cmpxchg() approach is of course vulnerable
> to the ->frame1 and ->frame2 assignments taking more than three seconds
> (by default), but if that becomes a problem, a WARN_ON() could be added:
>
>         if (ktime_before(oldtime, invalid_before) &&
>             cmpxchg(&use_entry->time, oldtime, now) == oldtime) {
>                 use_entry->frame1 = frame1;
>                 use_entry->frame2 = frame2;
>                 WARN_ON_ONCE(use_entry->time != now);
>         } else {
>                 // Too bad, next duplicate report won't be suppressed.
>         }
>
> So what am I missing here?

Ah right, sorry, I should have clarified or commented in the code that
all of this is happening under 'report_lock' (taken in prepare_report,
held in print_report->rate_limit_report, released in release_report).
That also means that any optimization here won't matter until
report_lock is removed.

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> > Thanks,
> > -- Marco
> >
> > >                                                         Thanx, Paul
> > >
> > > >  kernel/kcsan/core.c   |  15 +++--
> > > >  kernel/kcsan/kcsan.h  |   2 +-
> > > >  kernel/kcsan/report.c | 153 +++++++++++++++++++++++++++++++++++-------
> > > >  lib/Kconfig.kcsan     |  10 +++
> > > >  4 files changed, 148 insertions(+), 32 deletions(-)
> > > >
> > > > --
> > > > 2.25.0.rc1.283.g88dfdc4193-goog
> > > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200109162739.GS13449%40paulmck-ThinkPad-P72.
