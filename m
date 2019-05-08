Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82290C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574BE204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfEHURY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:17:24 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35793 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfEHURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:17:24 -0400
Received: by mail-ot1-f51.google.com with SMTP id g24so174190otq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M13siEu+g10Eyf72ko5YRm3P5jSDytOXC9psBac97xQ=;
        b=s8Qqq20nbuHGjUsLEOvwf7XPk2Q110iwNqw0wXxdsYXtS0kxl+UdQoGGOR/qqa1ni+
         WEnLH510dZ1fgLcYl1B70kxHSBkOk6EuU6GkcX9wP52a+oFzoyhN+s0i4FAJTLg1me5V
         mSPtUcZCSKHMt/7DmynPE+LmqSxqPmCCbmWSbtSuwikpGP71L6LngMo1hvC8tEUygld9
         MzfdTzOqMIbGgfTuvXgb5bGu9RBPpVUAZrZJOApcHEYTU/cV/aiv/vMr7RROJQvwQxaI
         ybslnUwzv7roOG1454rJsfPg3pRezeX8FFOrN/qf05ZeeZYwcNrCFnm9jkg81xE59xBw
         jIZA==
X-Gm-Message-State: APjAAAWWMSF2r3rSOb2Dr6hSWEMaxu4x7cF/8eQ7Cv8tvNPvXY0cY8oF
        IODcKa6sj902qwRJEVxqas2xO++dfYxWEj0dC2hpWA==
X-Google-Smtp-Source: APXvYqwSWGUNTGH2G86hxTfu40xvKgy0wCqrVfneJnSvUzw3Yu8TSikFVN7lIOFZ7TE029cKTDMP3egLTajjHZ5G1Vw=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr476227otf.332.1557346643306;
 Wed, 08 May 2019 13:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
 <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com> <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
In-Reply-To: <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 8 May 2019 22:17:12 +0200
Message-ID: <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
Subject: Re: GFS2: Pull Request
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Wed, 8 May 2019 at 20:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, May 8, 2019 at 10:55 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > See what I'm saying? You would ask me to pull the un-merged state, but
> > then say "I noticed a few merge conflicts when I did my test merge,
> > and this is what I did" kind of aside.
>
> Side note: this is more important if you know of a merge issue that
> doesn't cause a conflict, and that I won't see in my simple build
> tests.
>
> For example, in this case, the merge issue doesn't cause a conflict
> (because it's a totally new user of bio_for_each_segment_all() and the
> syntax changed in another branch), but I see it trivially when I do a
> test build, since the compiler spews out lots of warnings, and so I
> can trivially fix it up (and you _mentioning_ the issue gives me the
> heads up that you knew about it and what it's all about).
>
> But if it's other architectures, or only happens under special config
> options etc, I might not have seen the merge issue at all. And then
> it's really good if the maintainer talks about it and shows that yes,
> the maintainer knows what he's doing.
>
> Now I'm in the situation where I have actually done the merge the way
> I *like* doing them, and without your superfluous merge commit. But if
> I use my merge, I'll lose the signature from your tag, because you
> signed *your* merge that I didn't actually want to use at all.
>
> See? Your "helpful" merge actually caused me extra work, and made me
> have to pick one of two *worse* situations than if you had just tagged
> your own development tree. Either my tree has a extra pointless merge
> commit, or my tree lacks your signature on your work.

Ok, got it.

Would it make sense to describe how to deal with merge conflicts in
Documentation/maintainer/pull-requests.rst to stop people from getting
this wrong over and over again?

Thanks,
Andreas
