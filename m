Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9238BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA912077B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570211642;
	bh=4FIUHUvj9TvjSQswXnLXBO/mOaiern6KROVUR3NRr+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yLP8OmAZxI78o2d/tstzkcT/0i8PXu5lxDWdlBg6BeK4G00W82DKQneYph0pHXrD4
	 kLznzF3qO0XHMs5+zYRH8Hme1XGxuSzgkEjLXFIm2aNMXN0rpOSAFO5dbNOwH6v3Bv
	 uNb2WcYesAwMZXnQ2HQjYUHHaJEuuuzP6e4y4Hxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbfJDRyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:54:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40456 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387900AbfJDRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:54:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so7372533ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+ot6MecpahXBy/XsNEnO0h9gE1GQDq0Bf9rTX+VY1c=;
        b=RxD7rcL8Fr8GWZMypzp09r370bJefuZJwTltueP/8mQyT6b7pUuSEySIjw8cyI6MfK
         FAvUII414LI0hPJIa3T5wjJnf1JRW8oNT4ty5NpJmJlT5F4P4bqFNzjTGWWxb9O1t2Ts
         SF9Seg9ScG9kR+oW6CJlLSGxvzt7lFYAr4rdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+ot6MecpahXBy/XsNEnO0h9gE1GQDq0Bf9rTX+VY1c=;
        b=RWhepwoqkKF+NA3lFFfQaB/8jv8U6aq8uhbPDQBA8bMWbDz2G2St1JuwQYoGplW0d2
         t5c294HdMN1lfFEjJH5y2OfdA5RM15HEVLrkcdV1pBEptPAE5QdZl+RoJevDwf6L9Xl8
         XoFKx0UpeMcYlRINvGIbUwaEtUk/HARk/gsa1hkTTdMMUVXdhuidLEHSBAm9lsOfuFjQ
         MP4PC55xfiDR02Zh5EEJDk64Dy+Pg/pyrUAkN/x/oHkkbJxQ1A1PnrCCfaghWWpAIeGQ
         2kc8xFLCQR5j/YZvxKAasf+eniTNbuEzxjbcJiBLdfcE6aXK6WjNCeJ7Vfn0RH1gxEMz
         Bh8w==
X-Gm-Message-State: APjAAAWWUxPAPGrQ34dUzGG0ebAxmLd2fni3NPfMG4vrk1rryj+vOKve
        Thq/UQ1T/ZJGwO62jkpt1H9A1Jpdryg=
X-Google-Smtp-Source: APXvYqyJ48sD+a7Xe7+e/bfsnIl63fWhvCVRmfLiMhUr39UVZRnNrcbUlqDRRo/xVMRnByUzZbp0LA==
X-Received: by 2002:a2e:9a89:: with SMTP id p9mr10655023lji.131.1570211638780;
        Fri, 04 Oct 2019 10:53:58 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c6sm1253467lfh.65.2019.10.04.10.53.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:53:57 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w67so5085327lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:53:57 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr9574170lfh.29.1570211637449;
 Fri, 04 Oct 2019 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191004104116.20418-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191004104116.20418-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 10:53:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
Message-ID: <CAHk-=whxf5HVdaXqL6RgHCLzb2LNn3U2n_x4GWQZroCC+evRoA@mail.gmail.com>
Subject: Re: [GIT PULL] usercopy structs for v5.4-rc2
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 3:42 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
>            The only separate fix we we had to apply
> was for a warning by clang when building the tests for using the result of
> an assignment as a condition without parantheses.

Hmm. That code is ugly, both before and after the fix.

This just doesn't make sense for so many reasons:

        if ((ret |= test(umem_src == NULL, "kmalloc failed")))

where the insanity comes from

 - why "|=" when you know that "ret" was zero before (and it had to
be, for the test to make sense)

 - why do this as a single line anyway?

 - don't do the stupid "double parenthesis" to hide a warning. Make it
use an actual comparison if you add a layer of parentheses.

So

        if ((x = y))

is *wrong*. I know the compiler suggests that, but the compiler is
just being stupid, and the suggestion comes from people who don't have
any taste.

If you want to test an assignment, you should just use

        if ((x = y) != 0)

instead, at which point it's not syntactic noise mind-games any more,
but the parenthesis actually make sense.

However, you had no reason to use an assignment in the conditional in
the first place.

IOW, the code should have just been

        ret = test(umem_src == NULL, "kmalloc failed");
        if (ret) ...

instead. Which is a whole lot more legible.

The alternative, of course, is to just ignore the return value of
"test()" which is useless anyway (it's a boolean, not an error) and
just write it as

        if (test(umem_src == NULL, "kmalloc failed"))
                goto out_free;

and set ret to the error value ahead of time.

Regardless, the double parentheses are _never_ the right answer. Ugly,
broken, senseless syntax that is hard for humans to read, and doesn't
make any sense even for computers when there's a perfectly regular
alternative that isn't a random special case.

I've pulled this, since it's not in core kernel code anyway, but I
wish I had never had to see that ugly construct.

             Linus
