Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3300AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510C204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfDBPDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:03:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45477 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfDBPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:03:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so12264338otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUfVvLNJ8XEZ8yqYZ/FSJWf93tZXQEWYNsJ7QWWfbeE=;
        b=nVCgbJ3mH9H1lygTABv0P0i3aODw0h1H4e63l4zYWKwyLghPIq/hjVQ7IW8flp52MP
         PAqVkipl7CK5AcmsWyiVNrtZ3CKEeyjCicgD3DudJkwU5iKCBrzI6UZxI8fYjcIekqQn
         9NQWuRyvhBtKHELAJ/FQr838tDHh16MKgb7VKhKS6+Fp8SBOnU/YrYHpb8Ot0F4H4AKm
         Zb8IdgdrBheICoRkmE1pjYqASaJgnw8L5H7wkFDj1LvIqq0HtugT+p2dRUjxjcCBeflu
         fJ6Y5PRXWQn+uKnpFtIQjT/06PnL21xsL/G1Fzh84Y61DUSedOdY/moKL+KBU4TaWXOc
         k+qg==
X-Gm-Message-State: APjAAAWpEfAwvxNGIrUx8/9/Zx55XeFNeTILgfsWZ2nQ+xExhZ9uU0n9
        ixC8LrWWry9+ujDFv5oovOhIRA1ar7diHoofzHCHFw==
X-Google-Smtp-Source: APXvYqxEjtpjVeg7P+/Oam6bSEdFkBhoBL8IOvYOpXmSVtGv1TkAu6DGu3COzQcjNMAq1j06YG2ISi8fJ1Cq0T2VOSw=
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr13400968otb.206.1554217383379;
 Tue, 02 Apr 2019 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-3-omosnace@redhat.com>
 <alpine.DEB.2.21.1903280039530.1789@nanos.tec.linutronix.de>
 <CAFqZXNvQioPGUiU0q5R4nQLW7pQDsViNH-DR=SF4Fec+-CwksA@mail.gmail.com> <alpine.DEB.2.21.1904021100410.1676@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904021100410.1676@nanos.tec.linutronix.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 2 Apr 2019 17:02:52 +0200
Message-ID: <CAFqZXNuh9nVh+6JSQzsEBcoa75R97P+69u5Gz=_FvMc_UC9qHg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 11:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 1 Apr 2019, Ondrej Mosnacek wrote:
> > On Thu, Mar 28, 2019 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Thu, 7 Mar 2019, Ondrej Mosnacek wrote:
> > > >                       /* adjtime() is independent from ntp_adjtime() */
> > > >                       time_adjust = txc->offset;
> > > >                       ntp_update_frequency();
> > > > +
> > > > +                     audit_ntp_adjust("adjust", save_adjust, txc->offset);
> > > >               }
> > > >               txc->offset = save_adjust;
> > > >       } else {
> > >
> > > Not going to happen. We are not reshuffling all that code just to
> > > accomodate random audit log invocations in a critical section plus having a
> > > gazillion of GFP_ATOMIC allocation in the critical section just because.
> >
> > OK, seems I underestimated the consequences of putting the logging
> > calls directly in there. While I was offline over the weekend I
> > already came up with a cleaner version that collects the changes in a
> > structure and does the logging outside of the critical section. I
> > currently does a few unnecessary writes into memory under
> > CONFIG_AUDIT=n, but if that is an issue I can boost the abstraction or
> > just add some #ifdefs to avoid that.
>
> No ifdefs please.

Yep, no worries, I already found a clean way to make all the audit
operations a no-op under CONFIG_AUDITSYSCALL=n that keeps all the
#ifdefs contained within <linux/audit.h>.

> Aside of that, why do you need all those details of the
> ntp internals in the first place? The changelog does not give me an answer
> to that.

Yeah, the changelog should be more explanatory, I'll try to improve
that in the next revision. I actually stated the justification in the
RFE page [1] (paragraphs 3-4) linked from the cover letter (I don't
blame you for not finding it...). The idea is that it is (or at least
seems) possible to do some evil changes to the clock indirectly by
modifying these parameters as well. Maybe it is a bit overkill, but
it's better to be safe than sorry... If anyone doesn't want the extra
records, they can be easily filtered out by adding a simple audit
rule.

[1] https://github.com/linux-audit/audit-kernel/wiki/RFE-More-detailed-auditing-of-changes-to-system-clock#feature-design

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
