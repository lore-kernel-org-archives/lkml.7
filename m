Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4236CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156A02084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndMx+gJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfJDTng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:43:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfJDTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:43:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so8487766wrw.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fr5y/RvlB6x0gWwbCBYcM9hwB+ke8YDXuG6rntGxLCM=;
        b=ndMx+gJgLIhohBHTBHDLgHFxGPC/IMObaTRm7UIziVbnvT2+nzCGHUbWvkLJaHL5w5
         bnv6PF2vWG/05jWnf0S/GGapG6dIJfxzX4DrFUdM6HThT3OZUbNn2nG1mM9uTEN35wSx
         Fv7GBHmkKda60q0rQyRcViOKp7ls7vJl5R3swI/5pH5brlj6emslmsCN3sHfCp++T97s
         4aBnCM/zQaetMcxBIjFROotY54DiReGqyJV1jrZHx+DKJ7fClKg2/3SNwTiVF6u2wPB2
         CtKM60aFMbanXHZ3Fo8NZNM8d2gDkqvREs6S0QU2QRk93hG8ohB3uAjBfO8vXO3m3cIO
         7A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fr5y/RvlB6x0gWwbCBYcM9hwB+ke8YDXuG6rntGxLCM=;
        b=gVuOdLtJUNRJXpPhqQEBr9NTtSW6ZqCROyZWWudlXnypGw3qg/JFtLpDGwH9GGVq61
         Uedffvs+qxrbW0judJNeVvCZH9PHbdipqwK8X4mfH3h821jSzaLEE+No+RfVc+lRL9RV
         qHsskiBBCKvwtB8tBhjUIQB6axWIlk6bnFLcuXJoSYpTaQysIBqycm/DtWRr/h7e5p8g
         vlxvp1AsMB3uzVSEEQY9uadIjyIF+fKdXYeh7b/gVAKjzrLcDgskKzEyXlBn8FJV+waL
         Y+SqxX5TqKqRzqN5F6ga3uO2Ik/zznhYD1xYEX2BeIVoU6WND72Cy1LOW9Bly8FlTgZx
         2fjQ==
X-Gm-Message-State: APjAAAUdLylQHUgeWASThS1nHre0Do2JxyunYYO5PGhsiDHyVsluqmH8
        bgSS7HzmU9Apm41cnsFiChPI2Qwe
X-Google-Smtp-Source: APXvYqzW+d+PLfKGj/zPSMxQeffxUrBaWf4c1MckZr1+EVwgl9Fn+hKgW8Lauv814+mMr35X6qLBnQ==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr12473614wru.242.1570218213334;
        Fri, 04 Oct 2019 12:43:33 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f143sm11289741wme.40.2019.10.04.12.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 12:43:32 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:43:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
Message-ID: <20191004194330.GA1478788@archlinux-threadripper>
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
 <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:53:41AM -0700, Linus Torvalds wrote:
> On Fri, Oct 4, 2019 at 3:42 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> >            The only separate fix we we had to apply
> > was for a warning by clang when building the tests for using the result of
> > an assignment as a condition without parantheses.
> 
> Hmm. That code is ugly, both before and after the fix.
> 
> This just doesn't make sense for so many reasons:
> 
>         if ((ret |= test(umem_src == NULL, "kmalloc failed")))
> 
> where the insanity comes from
> 
>  - why "|=" when you know that "ret" was zero before (and it had to
> be, for the test to make sense)
> 
>  - why do this as a single line anyway?
> 
>  - don't do the stupid "double parenthesis" to hide a warning. Make it
> use an actual comparison if you add a layer of parentheses.
> 
> So
> 
>         if ((x = y))
> 
> is *wrong*. I know the compiler suggests that, but the compiler is
> just being stupid, and the suggestion comes from people who don't have
> any taste.
> 
> If you want to test an assignment, you should just use
> 
>         if ((x = y) != 0)
> 
> instead, at which point it's not syntactic noise mind-games any more,
> but the parenthesis actually make sense.
> 
> However, you had no reason to use an assignment in the conditional in
> the first place.
> 
> IOW, the code should have just been
> 
>         ret = test(umem_src == NULL, "kmalloc failed");
>         if (ret) ...

Yes, I had this as the original fix but I tried to keep the same
intention as the original author. I should have gone with my gut. Sorry
for the ugliness, I'll try to be better in the future.

Cheers,
Nathan
