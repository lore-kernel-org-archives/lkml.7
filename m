Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71400C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3EA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5G8aRe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfC0Up4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:45:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35200 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfC0Upz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:45:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id e1so10801705vsp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kq826wvn/TLWGIs6hJHKhv70e9n0vWDj2EknqQ2AxhU=;
        b=L5G8aRe33gqcEZIDdrvBBKq4FXw3xngseYfNGfp/VClVytIBmagSaDHJWwmiop0/uk
         CLKJ3mOqeAM2Q2pWlbTiEqPBkXGXojIYu6tW5KW70890LuYTnS5IPX4dwNZFnHBS01Vz
         ePplaNVlsZWJO//U1H3kJNGvyK1f63HVgvzhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kq826wvn/TLWGIs6hJHKhv70e9n0vWDj2EknqQ2AxhU=;
        b=aHM9gYJ0qcoy6SiBvz3Lk/K2j5floln87dk4buDZwNQj5UMuw6U4gclmjXmZsv8eCN
         kcZWNRwNeTewRi+7izAOQqz+Sw733XYQQJXEFLfJj1DuCukSStntIdRwyxnhKEeuRx+x
         NFBeWAosYjmpXY6Nc9UUOv2bi91k/X7AJn8i2i9Sial4KdataifdrEFxF74lJYwv+nFx
         gOqTwOX5gNfZUHfJ8nmooS0naqHJ0sIDPQTOnSWePFj5EkvRW50ZGmp8dCwKbc/B2Qf2
         zu4FsaphgaeqRFYy6Kf7TWt3G5pc0hs5PTiUkJIZwcDhoyRMjd8LfG/38CJ7tRv8YM6V
         l/Tg==
X-Gm-Message-State: APjAAAXUcWrcicBRtn6+ZK2iJ004tEW1OnB4pTIwPrdpfxsuJg52prjJ
        FqRET8kJ+bhMdJEABmJCvi6yFWcUzx8=
X-Google-Smtp-Source: APXvYqw1a0Z3P1oHxJ8UH8XPII4xWyqpLu08In9ISx2UeIlmTx8htYcF0W6z7o6N8IoD1o86VbLhgA==
X-Received: by 2002:a67:e256:: with SMTP id w22mr7292147vse.173.1553719553576;
        Wed, 27 Mar 2019 13:45:53 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id u6sm7753749vke.54.2019.03.27.13.45.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 13:45:52 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id l17so4018545vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:45:51 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr12458668vka.4.1553719551456;
 Wed, 27 Mar 2019 13:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org> <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com> <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
In-Reply-To: <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Mar 2019 13:45:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
Message-ID: <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
Subject: Re: Linux 5.1-rc2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 1:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/03/28 4:16, Kees Cook wrote:
> > The part I don't understand is what you've said about TOMOYO being
> > primary and not wanting the others stackable? That kind of goes
> > against the point, but I'm happy to do that if you want it that way.
>
> Automatically enabling multiple legacy major LSMs might result in a confusion like
> Jakub encountered.

The confusion wasn't multiple enabled: it was a change of what was
enabled (due to ignoring the old config). (My very first suggested
patch fixed this...)

> For a few releases from 5.1 (about one year or so?), since
> CONFIG_DEFAULT_SECURITY_* will be ignored after CONFIG_LSM is once defined in
> their kernel configs, I guess that it is better not to enable TOMOYO automatically
> until most people complete migrating from CONFIG_DEFAULT_SECURITY_* to CONFIG_LSM
> and get used to use lsm= kernel command line option rather than security= kernel
> command line option.

It sounds like you want TOMOYO to stay an exclusive LSM? Should we
revert a5e2fe7ede12 ("TOMOYO: Update LSM flags to no longer be
exclusive") instead? (I'm against this idea, but defer to you. I think
it should stay stackable since the goal is to entirely remove the
concept of exclusive LSMs.)

I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
also initializing TOMOYO, though. It should be a no-op. Is there some
situation where this is not true?

The situation you helped me see was that a TOMOYO user with
CONFIG_DEFAULT_SECURITY_TOMOYO would not want to see any exclusive LSM
also initialized, since that may NOT be a no-op.

So, AFAICT, my proposal fixes both Jakub's issue
(CONFIG_DEFAULT_SECURITY_* oldconfig entirely ignored) and Randy's
issue (subset of Jakub's: choosing DAC should mean no legacy major
initializes), and the "TOMOYO user surprised to see an exclusive LSM
also initialized". If you're happy with the proposed change in my
prior email, I'll send it properly to James. If not, what do you see
that needs changing?

Thanks!

-Kees


--
Kees Cook
