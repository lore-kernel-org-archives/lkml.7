Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0786C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A664A21835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRzO3jLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJOHjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:39:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36884 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:39:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so13682579lff.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uCnJe4OS4PmiAnx5U5+vuST11DJd/WAfBYWSy4Jhz0g=;
        b=hRzO3jLACHZPBKE26DyiG4/GPKih57vYOa/WKvCWuCYx8poS7TAt+aUG/e1UVw0LPt
         5t7/+el+H1mhzc4Z+gAtCwskaROvYTom1na2uKJRJGpyv0inrxTCKal1TcDQpUErHyxG
         OM7lERaagShNYGEd6k8fNhviXFjIYFCQtrnU/aMbFATyk4ssAQG1uux5fY4ErvuGJalS
         EM0+4hz5spPOdLq57r0DvFv8zRphgOACIP/bOYm0T5XOojMA1lafAQaWMJOMyLZNXIda
         M3rDLjkWRrUbvxq8vcmu0z8UehCAtGN71yg83MXEtPFp2kvDsSIMQVZiG20VvYUj8NH8
         k4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uCnJe4OS4PmiAnx5U5+vuST11DJd/WAfBYWSy4Jhz0g=;
        b=lwxpe88oREQ6OIYNFjniYIGe3tUYIKxYeGbIwcKvmg3LQO03HGXAU4yJubFxvXdI9J
         bkWgpdPsQBz1h5BeJEmXIISfdPuNlmTfO23HRvBH7E42C1/MtbzQdJ91yFCKWoWUaam0
         c66dQqnBQG2SWgA6JsXrJEIl3jIiYBpZfsdjEacMfXyWyozFsDNARloRY4lC0vavCVpv
         rXzs1ys9gK0F4ENfn2NY/mDLyJ1psiLqIJjQlhVQxOEKfW1VXSgW2Mps21Ht+YT7Eyyu
         QoeVaz2w3bB/YDc5SLuVkXBBQCh9FioAfvSqedF+z77z20aA2wcRjMoVOor89Y+p+AdK
         25Sw==
X-Gm-Message-State: APjAAAU1KEksKNp/R7BGRaD1TLazUhDYRC11ZxEHyRLm5YvZz3n51RwZ
        mSuJcv/LOcmKDr1mFfdz4ldTEO0gGUlLB/nWuy8=
X-Google-Smtp-Source: APXvYqwptjBMTPoWRGTAvwqu3e+6NI/iyXjZfQ0T9HEOlL7LlYf+55z1dhHXaNodC8Mp3q7d9Lz9Lyhuhd5Qda0uWpc=
X-Received: by 2002:ac2:48af:: with SMTP id u15mr19951848lfg.185.1571125187128;
 Tue, 15 Oct 2019 00:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com> <20191014164110.GA58307@google.com>
In-Reply-To: <20191014164110.GA58307@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Tue, 15 Oct 2019 09:39:35 +0200
Message-ID: <CAMJBoFOqG8GYby-MLCgiYgsfntNP2hiX25WibxvUjpkLHvwsUQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
To:     Minchan Kim <minchan@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

On Mon, Oct 14, 2019 at 6:41 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Oct 10, 2019 at 11:04:14PM +0300, Vitaly Wool wrote:
> > The coming patchset is a new take on the old issue: ZRAM can currently =
be used only with zsmalloc even though this may not be the optimal combinat=
ion for some configurations. The previous (unsuccessful) attempt dates back=
 to 2015 [1] and is notable for the heated discussions it has caused.
> >
> > The patchset in [1] had basically the only goal of enabling ZRAM/zbud c=
ombo which had a very narrow use case. Things have changed substantially si=
nce then, and now, with z3fold used widely as a zswap backend, I, as the z3=
fold maintainer, am getting requests to re-interate on making it possible t=
o use ZRAM with any zpool-compatible backend, first of all z3fold.
> >
> > The preliminary results for this work have been delivered at Linux Plum=
bers this year [2]. The talk at LPC, though having attracted limited intere=
st, ended in a consensus to continue the work and pursue the goal of decoup=
ling ZRAM from zsmalloc.
> >
> > The current patchset has been stress tested on arm64 and x86_64 devices=
, including the Dell laptop I'm writing this message on now, not to mention=
 several QEmu confugirations.
> >
> > [1] https://lkml.org/lkml/2015/9/14/356
> > [2] https://linuxplumbersconf.org/event/4/contributions/551/
>
> Please describe what's the usecase in real world, what's the benefit zsma=
lloc
> cannot fulfill by desgin and how it's significant.

I'm not entirely sure how to interpret the phrase "the benefit
zsmalloc cannot fulfill by design" but let me explain.
First, there are multi multi core systems where z3fold can provide
better throughput.
Then, there are low end systems with hardware
compression/decompression support which don't need zsmalloc
sophistication and would rather use zbud with ZRAM because the
compression ratio is relatively low.
Finally, there are MMU-less systems targeting IOT and still running
Linux and having a compressed RAM disk is something that would help
these systems operate in a better way (for the benefit of the overall
Linux ecosystem, if you care about that, of course; well, some people
do).

> I really don't want to make fragmentaion of allocator so we should really=
 see
> how zsmalloc cannot achieve things if you are claiming.

I have to say that this point is completely bogus. We do not create
fragmentation by using a better defined and standardized API. In fact,
we aim to increase the number of use cases and test coverage for ZRAM.
With that said, I have hard time seeing how zsmalloc can operate on a
MMU-less system.

> Please tell us how to test it so that we could investigate what's the roo=
t
> cause.

I gather you haven't read neither the LPC documents nor my
conversation with Sergey re: these changes, because if you did you
wouldn't have had the type of questions you're asking. Please also see
above.

I feel a bit awkward explaining basic things to you but there may not
be other "root cause" than applicability issue. zsmalloc is a great
allocator but it's not universal and has its limitations. The
(potential) scope for ZRAM is wider than zsmalloc can provide. We are
*helping* _you_ to extend this scope "in real world" (c) and you come
up with bogus objections. Why?

Best regards,
   Vitaly
