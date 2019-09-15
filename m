Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A05BC4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5E20830
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568575924;
	bh=lvlWNQSUZDgdvDwOtOBqaafDyHRgWvKyjYyW2nEtz5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xjip4z6NySM4Gz1XjtiBapHTNwyGwEb05SkfmW472U+HICei8BTUOefa3/Kua35H6
	 YHRaDql9HAxcZImpUJqyadzJbmlKD4rr+7Xg4VKMr1iFL2Wgd3XAPvyNWMUXA5wEFR
	 plW2QTJL5bntK6xTtx30v+tZ1etmvHnBkDbNGw2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfIOTcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 15:32:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39884 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIOTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 15:32:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id u26so8037878lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcwTblzMoitlkG90oc3RIazOAIPv3CGshIK8wAijmDI=;
        b=TLbSa6seE1kBg0lI8CGXqWg2q0IZHoaE8aPo+wMvNk+p7Yf2/dfEZOHO5J2fqja4RK
         yR9WsdJ5+HeLVL8ZdUnax5HeVBZfGlx0wU3aVJOynzvJGDEs+15V2Mx6QyMNLTDUPVX3
         SqDg7rOoNzoYjpLIZZwGhi5HfhOrYNe4A7ggk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcwTblzMoitlkG90oc3RIazOAIPv3CGshIK8wAijmDI=;
        b=LedSHe3WR9u59LXRGTACzz4cG5ONlmkCXzdxOaO8uREwvUw5Rcih3NILFMN7moo1X6
         Vik4LbbuRWMOyNepfT4+jymJq2s6qPeRIrVuzqkxdqwNg3JP5q4yLz9rDJndnDwMrflq
         qSQQJr9EMd/dj5iVa+shEna8nHf2GJ1UaLmXQ730+WHaBp3gt3b1jqsn6LkAaeOiNO6Y
         JMaSoYyfyKclhj/hw1YJwD3tB6ib/+GvPifLjqNbJ7wOHQ4obO/7fQmnihhrNamtGPrM
         5E55d4Hf2Y5j5rDcYl4XKrDq62uS6vS0TtgjGIbkHF0tg0mJlW9K0c+Q1zY3CUPgeIMl
         tYzQ==
X-Gm-Message-State: APjAAAU0YNJEoxoqjP07ZWmaPwuz31xy+0Tv3ZRPAi2uBt35UxVm47z4
        oxpFeXiL/jqxEwQqvkxgy2QGirK5CDY=
X-Google-Smtp-Source: APXvYqxUc/ix7RH0VfH15XAqjju1b7DXXr9xzThIGaDtZY0ATmCW6SxzPVtMeme4k/Tiu7GbAczjVg==
X-Received: by 2002:a19:f111:: with SMTP id p17mr1335982lfh.187.1568575920354;
        Sun, 15 Sep 2019 12:32:00 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z26sm1380623ljz.62.2019.09.15.12.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 12:31:59 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t8so25714266lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 12:31:59 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr37106479lfp.61.1568575918864;
 Sun, 15 Sep 2019 12:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190915183240.GA23155@1wt.eu> <20190915183659.GA23179@1wt.eu>
 <CAHk-=wgFrRCL3WP7vyuZ-92xyqb97ADc=JNyyVCucZ1Q9oh8TA@mail.gmail.com> <20190915191814.GB23212@1wt.eu>
In-Reply-To: <20190915191814.GB23212@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 12:31:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSdJ1ECOVz+T5iYc132m+XVVGi2nEiCQcT=+O-8FYUqA@mail.gmail.com>
Message-ID: <CAHk-=wiSdJ1ECOVz+T5iYc132m+XVVGi2nEiCQcT=+O-8FYUqA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2019 at 12:18 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Oh no I definitely don't want this behavior at all for urandom, what
> I'm saying is that as long as getrandom() will have a lower quality
> of service than /dev/urandom for non-important randoms

Ahh, here you're talking about the fact that it can block at all being
"lower quality".

I do agree that getrandom() is doing some odd things. It has the
"total blocking mode" of /dev/random (if you pass it GRND_RANDOM), but
it has no mode of replacing /dev/urandom.

So if you want the /dev/urandom bvehavior, then no, getrandom() simply
has never given you that.

Use /dev/urandom if you want that.

Sad, but there it is. We could have a new flag (GRND_URANDOM) that
actually gives the /dev/urandom behavior. But the ostensible reason
for getrandom() was the blocking for entropy. See commit c6e9d6f38894
("random: introduce getrandom(2) system call") from back in 2014.

The fact that it took five years to hit this problem is probably due
to two reasons:

 (a) we're actually pretty good about initializing the entropy pool
fairly quickly most of the time

 (b) people who started using 'getrandom()' and hit this issue
presumably then backed away from it slowly and just used /dev/urandom
instead.

So it needed an actual "oops, we don't get as much entropy from the
filesystem accesses" situation to actually turn into a problem. And
presumably the people who tried out things like nvdimm filesystems
never used Arch, and never used a sufficiently new systemd to see the
"oh, without disk interrupts you don't get enough randomness to boot".

One option is to just say that GRND_URANDOM is the default (ie never
block, do the one-liner log entry to warn) and add a _new_ flag that
says "block for entropy". But if we do that, then I seriously think
that the new behavior should have that timeout limiter.

For 5.3, I'll just revert the ext4 change, stupid as that is. That
avoids the regression, even if it doesn't avoid the fundamental
problem. And gives us time to discuss it.

                 Linus
