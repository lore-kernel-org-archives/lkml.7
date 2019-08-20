Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44ABC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BAC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566343737;
	bh=spRwrFE/mHSDWJVaA2nwyU/Ql66pRt+Ixez2Gn9Q2cI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v4+YuuT7y0Cqif2q53pLF0UpzYEyRjAFDocRLcCBHhCJmJMgmRqhxq49bglqF5dPs
	 dhkV/gkq8qfGqO3NXucDw328VQfQlKS3nBlTaW8pauchZEDu4xPCMg1R98ZhpYy2sl
	 kYad9tv2jWhSSpLy9v6NtGv3XPwHiXP4K54IDqY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfHTX24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:28:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37955 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:28:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so351131lfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMlMUEKr5XRMEcS7O2CjglWq7iJta7ZlUj0ydKdkNX0=;
        b=iHh8YbqJQq/qqg3MN7n649EblEqXoT6lv/jNvF13p1Io12yotnNW5VDOJQVPXyJ/w1
         JaSOZsSrO52CAp1T+Wotk0juqAvaieKA809jbwzdvgdw+gNCyA/AE5ttYg9tcWp2I3XA
         9/R87UNQ/J+HKwDYreUrt6rqcLPdnyTqkY9kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMlMUEKr5XRMEcS7O2CjglWq7iJta7ZlUj0ydKdkNX0=;
        b=eZekWbr+NXKeEiFApYItqURKf4ZhRY01VJlrseo1/Fps7ls/BmRhCk3UqIuPacYFz0
         RGML0axbnqVgFhkC3A4K2cuxOjFW+UEuU4q1OejZJO70LFupoFBWK91x+8yg6Aph1UeT
         /+xJPuS7v04GSA0MCH8QwkjLOuV1/0JK0g0NaUdvn/7Kzu2fqPIryBm0/mdKubMEV45N
         gFDAgi+Rpy9ueXxXLmE7+WEciMOV7EVKG3cek1ID/dCgaBsQXTe6UsVcbdgKajtbcxRJ
         0pVw45zigBv7Xh3EE+oLVQnbq7Z8Ebh8k9CLHnTu0/KH+79kHs9vhPNiUsEBfktSoY75
         EJsQ==
X-Gm-Message-State: APjAAAU6Espwufn7dYzAUjRWZ0Zt88z77vZ5OlxRELX8pnbx6Qw20t4X
        2AsNKE6sBcEw9Uozu//xnM+54BRW8A0=
X-Google-Smtp-Source: APXvYqw6NFxt51uNwMEs8rFVM+sgRvHj1s98r+ncgAl+6v8yhDqWj3S69h+c439r7nXEa955MceXPw==
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr16487055lfp.116.1566343733271;
        Tue, 20 Aug 2019 16:28:53 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j22sm3021281ljg.17.2019.08.20.16.28.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 16:28:52 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m24so358521ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:28:52 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr5487770lji.52.1566343731704;
 Tue, 20 Aug 2019 16:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <4398924f28a58fca296d101dae11e7accce80656.camel@perches.com>
 <ad42da450ccafcb571cca9289dcf52840dbb53d3.camel@perches.com>
 <20190820092451.791c85e5@canb.auug.org.au> <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
In-Reply-To: <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Aug 2019 16:28:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com>
Message-ID: <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com>
Subject: Re: rfc: treewide scripted patch mechanism? (was: Re: [PATCH]
 Makefile: Convert -Wimplicit-fallthrough=3 to just -Wimplicit-fallthrough for clang)QUILT
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 5:08 PM Joe Perches <joe@perches.com> wrote:
>
> 2: would be Julia Lawall's stracpy change done
> with coccinelle: (attached)

I'm not actually convinced about stracpy() and friends.

It seems to be yet another badly thought out string interface, and
there are now so many of them that no human being can keep track of
them.

The "badly thought out" part is that it (like the original strlcpy
garbage from BSD) thinks that there is only one size that matters -
the destination.

Yes, we fixed part of the "source is also limited" with strscpy(). It
didn't fix the problem with different size limits, but at least it
fixed the fundamentally broken assumption that the source has no size
limit at all.

Honestly, I really really REALLY don't want yet another broken string
handling function, when we still have a lot of the old strlcpy() stuff
in the tree from previous broken garbage.

The fact is, when you copy strings, both the destination *AND* the
source may have size limits. They may be the same. Or they may not be.

This is particularly noticeable in the "str*_pad()" versions. It's
simply absolutely and purely wrong. I will note that we currently have
not a single user or strscpy_pad() in the whole kernel outside of the
testing code.

And yes, we actually *do* have real and present cases of "source and
destination have different sizes". They aren't common, but they do
exist.

So I'm putting my foot down on yet another broken string copy
interface from people who do not understand this fundamental issue.

              Linus
