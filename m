Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEC2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0EC20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJ6DV7q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbgAIRDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:03:52 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37958 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387821AbgAIRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:03:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so6471703oii.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMx6vW+NjpB+ZzfdSbqjjcW3Neq3wFHEeHMe7FuFhBA=;
        b=ZJ6DV7q423gDjoUKdWM66o5EZrOhvSX8oOMpMmT+dLghf3n7rzhh+vOP32D1eEbaVa
         FiYDULBwfXGcRDVApzeNu9cMg0lfapFl6Nc8UtuPs7XS8QrBJPHqo3inUA6UjdTU3/bs
         KZszkXMdHRa35yZR2l8ZbeANUnzSVaM4SGcHjLFMHRd++8DM54Bm1reCZff+sA4HJUFn
         p1wg8+YMkwEO+BBTRG6lAUbhhIIhy+UlqSPTympsM9GULVhyFLohm3YoXdEj0Ido8eao
         KPHscMdOTLSUSS2oorJACsr3i2ExrD4FxY3PU7uGX+l4CLZp4yQk6esay5Yng+P3TaJj
         M/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMx6vW+NjpB+ZzfdSbqjjcW3Neq3wFHEeHMe7FuFhBA=;
        b=O2DfKzPRapahfJxRFBkX7u9e3lqv06Mle5bBFCUIWJz9UKNLqgpq3dM7AfSEENiJpj
         HYyj68hm/oAXQglLxM5cel8pV1/Kr/E5EN85cKLfosmmj7gYGVONCDy5N4WDb1XWIwwy
         5dKHhybUKO/2+tt+odgBA0VieUuIELQ9Zpjy3DxfCuslkTx+9WER40PPI0zoP0WytlJG
         C9rYmRg6rTRiWKc6ak/uASrWZmMoWVMACpijM8tpwA6hrCtclMx+mZ+/gfJwDbj6Dl8P
         AbBimPqBNfRJuS1yM9vo20ID+ymV8qOG5fztjghITWxCP3f8Q3buvwz5VdcSPwx1sGHv
         PLeQ==
X-Gm-Message-State: APjAAAXnNpyS60lp4vhOQJW+EiiYxfoWUVDzQS+4rI58kaaONmam84In
        cn4MryehazywDbRZ0kgPp/mqCXdpEJE8m6FEegHVZg==
X-Google-Smtp-Source: APXvYqyFE4T3xhLKLwqwclKWaKNgQE4HgnkiPzxpoEpcdhDJKNeue00EFINCnoe8AXO4FyU2wAGpr1fJXb/cZ5NOSRo=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr4065405oig.172.1578589430440;
 Thu, 09 Jan 2020 09:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20200109152322.104466-1-elver@google.com> <20200109162739.GS13449@paulmck-ThinkPad-P72>
In-Reply-To: <20200109162739.GS13449@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jan 2020 18:03:39 +0100
Message-ID: <CANpmjNOR4oT+yuGsjajMjWduKjQOGg9Ybd97L2jwY2ZJN8hgqg@mail.gmail.com>
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

On Thu, 9 Jan 2020 at 17:27, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 09, 2020 at 04:23:20PM +0100, Marco Elver wrote:
> > Improvements to KCSAN data race reporting:
> > 1. Show if access is marked (*_ONCE, atomic, etc.).
> > 2. Rate limit reporting to avoid spamming console.
> >
> > Marco Elver (2):
> >   kcsan: Show full access type in report
> >   kcsan: Rate-limit reporting per data races
>
> Queued and pushed, thank you!  I edited the commit logs a bit, so could
> you please check to make sure that I didn't mess anything up?

Looks good to me, thank you.

> At some point, boot-time-allocated per-CPU arrays might be needed to
> avoid contention on large systems, but one step at a time.  ;-)

I certainly hope the rate of fixing/avoiding data races will not be
eclipsed by the rate at which new ones are introduced. :-)

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> >  kernel/kcsan/core.c   |  15 +++--
> >  kernel/kcsan/kcsan.h  |   2 +-
> >  kernel/kcsan/report.c | 153 +++++++++++++++++++++++++++++++++++-------
> >  lib/Kconfig.kcsan     |  10 +++
> >  4 files changed, 148 insertions(+), 32 deletions(-)
> >
> > --
> > 2.25.0.rc1.283.g88dfdc4193-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200109162739.GS13449%40paulmck-ThinkPad-P72.
