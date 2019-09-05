Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE09C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F44D20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdxnRRAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfIERSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:18:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfIERSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:18:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so1761488pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6E/jdqx5yvxD+dBch8iFfgicvMUor5p5VuDHpWaSQk=;
        b=GdxnRRAnkzCqpPGZ4tyRiPeYXpZcyBfZHxASg8zQRPiBPXXddkT8OGJxFjAqMyDNNc
         HrGFU9VxZ9ep7pvA7IpCXg4EHA9E+6tXZWE5JBC3EHerejM0l21AYcnpWrMuM3fzz4m1
         TA/Fj7aANMHURAUZNIVWxAaTH1Mru+0ySGoMKOLKXc5puzP2KAqG8J/Ju4KJYgD0uuIA
         XiFwgqr7QtisHePYLZeKcynhpomQT55ND4q9agYPzJM4gqGBRRGiCWF9oo/iz1O1IGjY
         Q/QHy/EM5gCE1mEB3CQYtqQ5+EKr3NdfL6JuiHat11C0t7WuQMKhq0/K6IMKIOn7Bzl8
         KqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6E/jdqx5yvxD+dBch8iFfgicvMUor5p5VuDHpWaSQk=;
        b=Vz+NNdJG/YN1Xf+7KOAJOCj0uTsRmH7R5kKtHoO5l4ALMgF5ClfGeacUHoZidctNp5
         B19LDxgqJjNRLaURK9l3wn1ZreGN0H7VNM7VPRYF2i8+FaCkFbQ030/HOYmH7ObA+cY5
         190ysTh3dgQNPtH5FqLxbsjuVvE0uzss4w+J5qLw3+AFLkoUQBq7ofZpkDNLYc8VpqVI
         pbvDiEBhABkj0Ku8TUJGquYTSuKvMtLP/jhnOgjtYO4+byw4P0xD9YYDN9MmfFFjROf1
         KU0GPl59K+J2YCXVSJYj4mZywZVmkBRszzbomCu/smsd3PxEDE4VL9AewOM+rW1KqfDY
         zmsw==
X-Gm-Message-State: APjAAAWh0FsGmriSEbeHnd4JyYBIIw1lZEVl4d8NHT5xGxUA9HiEZ1C7
        Ci3tEfQ+b6Cn+W5RPpaTh+3Cba9Z7ey0wwU414Ce2g==
X-Google-Smtp-Source: APXvYqz+TwqquVyjr+UJa4p3V/xCVWf0lJ/UQlbjEbCSUDis/OUAVFrXmjExz+xckpV+hl5YShcuAFjuUrx9vdwy7Ps=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr5205861pfg.84.1567703932781;
 Thu, 05 Sep 2019 10:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
In-Reply-To: <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Sep 2019 10:18:41 -0700
Message-ID: <CAKwvOdm3CbZ1Uad4b8+9HU8qDgTwSFw2oqjcAvFkR8jaQQN-5g@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 9:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 4, 2019 at 11:18 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I was going to send this for 5.4 since it is not that trivial, but since
> > you are doing an -rc8, and it fixes an oops, please consider pulling it.
>
> I looked at this, and while it seems safe, I end up worrying.
>
> Macro stringification isn't entirely obvious, and an unquoted string
> could become corrupted if the stringification ends up not happening
> immediately.
>
> It does seem safe just because we do
>
>   #define __section(S)   __attribute__((__section__(#S)))
>
> but I had to go _check_ that we do, because it wouldn't have been safe
> if there had been another level of macro expansion, because then the
> argument in turn could have been expanded before it was stringified.
>
> So sometimes you actually _want_ to pass in a string to be
> stringified, because it's safer. I realize it then gets string-quoted,
> but this has worked for gcc. Even if I suspect nobody really _thought_
> about it.
>
> So I'm not unhappy about the patch, but it's the kind of thing I'd
> really prefer not to do at this stage.
>
> Particularly since it seems to do other things too than just fix
> double quoting. As far as I can tell, it doesn't just fix double
> string quoting, it changes a lot of singly-quoted strings to use the
> macro and unquotes them, ie
>
>   - __attribute__((__section__(".arch.info.init"))) = {   \
>   + __section(.arch.info.init) = {        \
>
> doesn't actually "fix" anything that I can see, it just uses the simpler form.

Please consider picking up just:
https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755
That lone patch is the one that fixes the particularly observed Oops.
The rest are just cleanup; if I made that change in the more important
patch, why not clean up the rest of the instances in the kernel?
-- 
Thanks,
~Nick Desaulniers
