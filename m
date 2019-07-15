Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9AD205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563217250;
	bh=lkYvPu5F7RxZBTeDLigT1oa3ITmpMYigqyxdmHWTrUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GlTQpuxmGiekoIZOevYQkIaDEYnkRQ4kcLr20mqFdhBVJSStjcLqOlsgKjqynfsD1
	 95AaPPzvKd7QYnwD/oo+jF05l6CDQzd0KQ5ZWPV56FI3pZSq9Ypwp8EAIzEsHd8WtT
	 fXA6XQ9bl0VQtzcNrn5Wp7bLqgWdAGEvNK6VIrrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfGOTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:00:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41531 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfGOTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:00:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so17364340ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpIdpoGiHes6mc2LinoXCKJJD9MlyiAFmH9AZOOOeHI=;
        b=Wb2cga1SJPgKwZTnU9NbM8DzlnLPO9eDXvY/K+0d4vdG1JGfpMPnXCznlzcBy5RNQB
         FS/S11uVWwNWGBZAZ6Hn4eLuL6NmCbcLwDDdFxBbY9ig0N8X9lHEI0070XzLd2Rd90uA
         jLc/WZwR2T9sZ8IDBc89f96QfjnLc11Riz63Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpIdpoGiHes6mc2LinoXCKJJD9MlyiAFmH9AZOOOeHI=;
        b=I8ytTrWxs0UIDD66nuE9Y+mMJppgOTHAfLfjNlZZBdW6F2sMJ0MEOtr1TFRlG33oND
         sz9i5wztxpbR6dEeaxntoeHHVmIxxwQ1Re7ZkdGBMyncH6amgjhqq6BCWKPVYiwgG3zt
         6YcPAWdt6C77xV/peAWzrQIs1YJ3JytgJf2l9L+XJU/2aWyfe2MO824ajfDCeYvu01Cb
         QAHtovFYgR0cjTWipzoPO9bnWbMKTiJnhHMOj6g3zpERApI9eU7pWcjyS0kDJ711NtgU
         UGrLlCyUMD1xr8MsJinrqB+SkxJjtBxQ5jMkxYbhFstwZOFTu+8BMwbzLfH5ymRKy8+d
         chsQ==
X-Gm-Message-State: APjAAAU22/jqdlowfX3NV5V7XXKPrQeTkOFQGv6jEA59+onCWDwMMR9I
        2xKfuui2/fPknI9dgRwjbLCoLPFuIIs=
X-Google-Smtp-Source: APXvYqx3T4rSweJWiCPyhqozIdh7AxKrWejy406tjRbFJulzNSrMSCBy5XFgZwA4Mu4jjog8qZ6kDQ==
X-Received: by 2002:a2e:860d:: with SMTP id a13mr15028903lji.215.1563217246229;
        Mon, 15 Jul 2019 12:00:46 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s24sm3266703lje.58.2019.07.15.12.00.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:00:45 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 16so17344755ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:00:45 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr15117345ljk.72.1563217244925;
 Mon, 15 Jul 2019 12:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com> <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
In-Reply-To: <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 12:00:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZ6kGFJyfXEeOzmw_eZDqvcaZ=FnFpR_c3eUmPS5M5EQ@mail.gmail.com>
Message-ID: <CAHk-=wjZ6kGFJyfXEeOzmw_eZDqvcaZ=FnFpR_c3eUmPS5M5EQ@mail.gmail.com>
Subject: Re: DRM pull for v5.3-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 5:29 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > The 'hmm' tree is something I ran to try and help workflow issues like
> > this, as it could be merged to DRM as a topic branch - maybe consider
> > this flow in future?
> >
> > Linus, do you have any advice on how best to handle sharing mm
> > patches?
>
> I don't have a lot of advice except for "very very carefully".
>
> I think the hmm tree worked really well this merge window, at least
> from my standpoint.

Side note: I suspect that having a separate branch maintained by a
separate person actually does help the "very carefully" part.

I think the hmm branch ended up getting more "incidental review"
simply because of how it was done. So even if the original reason for
the separate branch was to resolve some quilt/git integration issues,
I would not be at all surprised if just the extra indirection through
another person ended up making both the sending and receiving side
think more about each patch and think more about the abstraction.

The hmm branch didn't actually seem to have any of the core VM people
reviewing it either, but it did have reviewers across companies for
all the patches, and I do think that that makes a difference.

It's _soo_ easy for a patch series to be developed inside one company
by a couple of people who are probably in the same group, and have the
exact same objectives, to be a lot more biased (and likely biased not
towards the mm goals, but the goals of the code _outside_ the mm).

This is just a long-winded way to say "I do think that the separate
and external branch with multiple interested parties" can have some
inherent advantages, when you actually have multiple people looking at
it with care and intent.

(And here the fact that you have multiple subsystems looking at the
code is very much part of what makes it a good model - if it was just
an external branch for one single user - the vmware gfx driver - you
wouldn't get the same kind of advantages. So it's not the "external
branch" part itself, it's the "multiple users who care" part that
likely causes people to think more about the end result)

Again - maybe I'm rationalizing, and the hmm branch just randomly
happened to work well this time. I do like having multiple people from
different groups look at things, though.

                    Linus
