Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F116C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECACE218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqaumRs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfGCQjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:39:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42865 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:39:49 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so6285726ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbDcTo4F8dXvZfSLbaTtza62bmr8qH9H1r6LEOl+lHU=;
        b=NqaumRs/9r4N+LLQZVW7EKfaaKJYqiFXNQS0FREyFBH2dA5dQe+xDeHSF8h0f4HvVD
         ZpP8PimJIp+5sU4npv4xahYwMV9fygG58x2bwWCGYHMgA8d9jsiTXdEjgjXy50uJ8PsW
         TEbw48ERxWv8d1V3mw3vCrwh3vLxHeL0fTrQR+MYMu9XRa8KDsArTcgvh9andjUd2RP+
         5woe4LfbhzoeKMgNBcJVBChrKTb8DDZ1RbCyrhk++x3Je98AMpNOduXga2w48ITbLxqT
         5lCWRmkcHTJKIQBXr5u7Wu9Iwq41eXIyXnTqbszIjP3xokx9W176FvHXk2RhCqMaUmCV
         qGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbDcTo4F8dXvZfSLbaTtza62bmr8qH9H1r6LEOl+lHU=;
        b=TYUDnhihWtoMkQd8L3J17mIFNWugdvqb7UYiUlx4/xawjAKQZfifpS89+6hthtKjO+
         ROPxXWaFjiAfxbRsPUsHp6q6UYXXqi5lci2Oe990qN14RnJ6itFQ12UtedVph0sTwOO2
         ZGIpFQt5Ug6SU6jyyuW5VpBJ62zFMKvU8rh4Ft3mmwZV4GbHLirE5ntAJiHUp7sqDW4B
         r0BzuJukvYwRF6b4SPnU9u7eQezlnDwPi1wDCKVhZ4KGQYze0UsijpgYNSpawGsLNQ1Q
         RIlwHoL2zVnbUV6ZX7JaCuMlFgHoIkSdIX+SczGrZIpWcFzCqj1Ig8xE3TAFF3WAea57
         AnAg==
X-Gm-Message-State: APjAAAUzbg64jcYPsuZkRmoTjHFfQb8KGqM01KBFT9ZQXPnVPz2pXK3B
        WC53HChxQVVh7RFXP61eS81L/+Z29+qVCi0D67FzCQ==
X-Google-Smtp-Source: APXvYqzQyMYWqIT3Qfzpzptk3frJruzBTwW4rOb6aZvmElpX2SgWPwSUu0Enx4gwy/J+gJai0zJoUGBZgjWzPFk+Uh8=
X-Received: by 2002:a5d:81c6:: with SMTP id t6mr15956036iol.86.1562171988733;
 Wed, 03 Jul 2019 09:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com> <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
 <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
 <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
 <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com>
 <20190702152409.21c6c3787d125d61fb47840a@linux-foundation.org> <CAMJBoFOhXP36L6pZEA-7p24mJweDGe9iYb2fo1nNCxadYHcPzQ@mail.gmail.com>
In-Reply-To: <CAMJBoFOhXP36L6pZEA-7p24mJweDGe9iYb2fo1nNCxadYHcPzQ@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Wed, 3 Jul 2019 09:39:12 -0700
Message-ID: <CAGQXPTgRC23SHoKZTctkJsEJORu7GHDYNz_+9HaDu9ntffrzig@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 10:54 PM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> On Wed, Jul 3, 2019 at 12:24 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 2 Jul 2019 15:17:47 -0700 Henry Burns <henryburns@google.com> wrote:
> >
> > > > > > > +       if (can_sleep) {
> > > > > > > +               lock_page(page);
> > > > > > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > > > > > +               unlock_page(page);
> > > > > > > +       } else {
> > > > > > > +               if (!WARN_ON(!trylock_page(page))) {
> > > > > > > +                       __SetPageMovable(page, pool->inode->i_mapping);
> > > > > > > +                       unlock_page(page);
> > > > > > > +               } else {
> > > > > > > +                       pr_err("Newly allocated z3fold page is locked\n");
> > > > > > > +                       WARN_ON(1);
> >
> > The WARN_ON will have already warned in this case.
> >
> > But the whole idea of warning in this case may be undesirable.  We KNOW
> > that the warning will sometimes trigger (yes?).  So what's the point in
> > scaring users?
>
> Well, normally a newly allocated page that we own should not be locked
> by someone else so this is worth a warning IMO. With that said, the
> else branch here appears to be redundant.
The else branch has been removed, and I think it's possible (albeit unlikely)
that the trylock could fail due to either compaction or kstaled
(In which case the page just won't be movable).

Also Vitaly, do you have a preference between the two emails? I'm not sure which
one to include.
