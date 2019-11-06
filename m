Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D89FC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897FB217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEu6GhMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfKFW7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:59:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46600 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfKFW7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:59:49 -0500
Received: by mail-il1-f194.google.com with SMTP id m16so23235713iln.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHPMaxlZf+iGhM1WM76319OcCFkWQEtpxYutU0G9cJw=;
        b=iEu6GhMWKGPqDdROZouQTym9Q9mYeBlBHPK+wMf5Jjgyv8+GM3AcDGzbrL384Bdlj0
         42T8rNPK9zoNw8E1ls5Xp+9k2TClXGVOjNIm5NKUAPb+Qr172nOOfK2nE2Qn4kVqQ+cQ
         tTuJJP0khcgz4UIaZoYhgubAp2yRU+79WvUPTtKKIWe5TLE+t3aEGLnulUnR3soGkBzj
         huWb6mpQvbQK+Ax3gR3ThIR4y+tDj3u9RvYCPNO9cVM+YNlNgf1YcBlRIc3exBuIuG6A
         0ovL27GT7hJ0xPeEgwkgPva+XONkIK7uzqwCRPHMoNayG12B8zH3TnKF+5uHNEhfSIZT
         7vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHPMaxlZf+iGhM1WM76319OcCFkWQEtpxYutU0G9cJw=;
        b=d6GHWW8QgrQ7Ubh9jy0pHv1NxEzOZgsSQeVl1DVqzQqZEVzGophfypWQ7eN1mknLMI
         GhHvzGFNmNQNhCt7LF/aTlxCwD9RmHePBb8IHkO7MswMXmbzuH3BawWx48ocz1oijDoK
         Lu3yEZNfvUn+t3ONORWde/EVd8vH09Y3ZzRGzT6VDpIi+M/lfPM/x/dew/aTxe+r1Lyv
         rLtdLGNOtl76iZHuaAVjqa/IBfSGXtEIaRAt1hwAuySmcRvBtVz5S02mzxYdpKu5zz31
         TBijQAC0gw90psiOtJmDa5xwnsG08jUTWNf+7PD2j/6vn9+yUejJvB3dw/1b93p6vVS/
         Uctw==
X-Gm-Message-State: APjAAAVPrwo6qkDrYC+1Oum9z1E+8agA/qxVdwwTFhLzJUST9FWyDt35
        6bHdgTik7ZFRujs0m6OolpbeIveMN+eYd5Ab0FgzNjKo+dw=
X-Google-Smtp-Source: APXvYqwRlkwl+v6Wp7sQEggmeJvHEXOHwciMoehv4q2IiT26uzaSaja/7l372WrN9H5SZ6Cg0wK3AS/BitbRtuaosIQ=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr353370ilc.168.1573081187621;
 Wed, 06 Nov 2019 14:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
 <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
In-Reply-To: <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:59:36 -0800
Message-ID: <CANn89iL=xPxejRPC=wHY7q27fLOvFBK-7HtqU_HJo+go3S9UXA@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
> <tip-bot2@linutronix.de> wrote:
> >
> > The following commit has been merged into the timers/core branch of tip:
> >
> > Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> > Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> > Author:        Eric Dumazet <edumazet@google.com>
> > AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
> >
> > hrtimer: Annotate lockless access to timer->state
> >
>
> I guess we also need to fix timer_pending(), since timer->entry.pprev
> could change while we read it.
>

It is interesting seeing hlist_add_head() has a WRITE_ONCE(h->first, n);,
but no WRITE_ONCE() for the pprev change.

The WRITE_ONCE() was added in commit 1c97be677f72b3c338312aecd36d8fff20322f32
("list: Use WRITE_ONCE() when adding to lists and hlists")
