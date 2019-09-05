Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131702137B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567700438;
	bh=SCYw6dMnCqQgzpAyjiWkixoGMK8c4b6kGb1Y/jf7Z6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LLmGWm8Fha9P4Kj+ZS74LGm33nDWDu9jmkIYcnU+08td2upSXRP1TVPzT/EbE0oE0
	 g2K0LyQQwN7TwXFTpxTjAyA7bsZVz3QEHBHO6YbaPQlAgYx5DKGfATurorlt3kxQS2
	 Eb9okzRxpAxXdWPDu7vjWJfgBd9Zq76lK+C8u04o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfIEQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:20:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42664 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfIEQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:20:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so3124390lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skj/g6oI6dabfQCpUUc6UBPVoF5aAw3D1EkLoYv5aGM=;
        b=dAeCR5atGe5w1X5iRAO1B4+ZEuHNKoKyZ9C5iFeqNWytBiNaQXx25ttFaeOzuire+V
         uAG2P3uQnj0g012k0rh9UsuhLmIHx9D6cpl4Z4xbKJNAVgo2gxcChtkI8ATisZpFuMRQ
         turD2jy3tEjQKnr27iHENSiLzWM20us23E8ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skj/g6oI6dabfQCpUUc6UBPVoF5aAw3D1EkLoYv5aGM=;
        b=o7155bA+nB3I/K10tO5EwhOEWeCvqNTDwc8tRVXNar/1gNdjMI2xpb/80QUoFomLbr
         mBYnXNQ20MDNonBiWqHfW6l65j+k/toz9Wter0Yw99xZtfA6/aJy33vnd6giL+kQa3OW
         +WQyI0jzkcuc9JxZVheGVjJIwl+8dZ5d/7FGdInITeIvuYZWa+pAfObXO+yzOPVOU5u9
         l6dJFSdqwAnsbP4HC7uLjyQ6Y2rfEaTPWx0DpUWpN2fS2j2eLYWEfOQOJmxoi8gtTT11
         vh7oTYFBQO9B8lYHPSFxK67mdVyKELmZFn7/hbbCeUgAKLSasJSrxgY//LQhW2JN0JpY
         R2OA==
X-Gm-Message-State: APjAAAWHtAcDqwTbE0J92yvpoovQT+eHZilTcMYGFP0X3toIVKWbRiOV
        ssZSYEuDaJiloZB9v7oFR3UnI9ma+a8=
X-Google-Smtp-Source: APXvYqyKjwRdqaEUbW6bKoy9EwXN6OpMutMfIad45JwjpPTxs0ClIoIyK38Mes6NRJFDX5jHBiF4DQ==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr2726366ljg.144.1567700432856;
        Thu, 05 Sep 2019 09:20:32 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id p22sm456936ljp.69.2019.09.05.09.20.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:20:32 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id y23so2806938ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:20:31 -0700 (PDT)
X-Received: by 2002:a2e:814d:: with SMTP id t13mr2767373ljg.72.1567700431469;
 Thu, 05 Sep 2019 09:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com>
In-Reply-To: <20190904181740.GA19688@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 09:20:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
Message-ID: <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Wed, Sep 4, 2019 at 11:18 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I was going to send this for 5.4 since it is not that trivial, but since
> you are doing an -rc8, and it fixes an oops, please consider pulling it.

I looked at this, and while it seems safe, I end up worrying.

Macro stringification isn't entirely obvious, and an unquoted string
could become corrupted if the stringification ends up not happening
immediately.

It does seem safe just because we do

  #define __section(S)   __attribute__((__section__(#S)))

but I had to go _check_ that we do, because it wouldn't have been safe
if there had been another level of macro expansion, because then the
argument in turn could have been expanded before it was stringified.

So sometimes you actually _want_ to pass in a string to be
stringified, because it's safer. I realize it then gets string-quoted,
but this has worked for gcc. Even if I suspect nobody really _thought_
about it.

So I'm not unhappy about the patch, but it's the kind of thing I'd
really prefer not to do at this stage.

Particularly since it seems to do other things too than just fix
double quoting. As far as I can tell, it doesn't just fix double
string quoting, it changes a lot of singly-quoted strings to use the
macro and unquotes them, ie

  - __attribute__((__section__(".arch.info.init"))) = {   \
  + __section(.arch.info.init) = {        \

doesn't actually "fix" anything that I can see, it just uses the simpler form.

               Linus
