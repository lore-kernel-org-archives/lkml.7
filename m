Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFADBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0A205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAlzxw74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLQWVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:21:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33907 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLQWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:21:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so6679784oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB4CGLkJroraKNh1/6HAdcjC0bnZlBqMW6X2ht1CYGM=;
        b=YAlzxw74Dvr6+wSa+xSqDMlAhk23VwakXm5wZ+eOz0cBgY1MjO6EasIDXerPXdFz5h
         CrPYcHzneChH2QLjAECPA3AJ3f5OZl8R9DFVUsN1l6+dBJLbKiCKy4/kOzZadDODS2nF
         0QaVdf+6vkFOY3oa+dNjUgLEPe149o9aXmDvmhwONikhSra+DTkYt+aRmXR/LvcPbE7B
         Y3+mNOWgIJ3zxDoEhUgD8Ef5gsqBIGD08Ofgh7ujxOEMfYkIRnmBgeG3iAP8VNudHnF2
         w6qaRDbjpCkyu2DcAPfliiG20NcTT4cXug/EP3cBiHZBj/Txf5zz3+Paa4c/aRxA49a8
         6MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB4CGLkJroraKNh1/6HAdcjC0bnZlBqMW6X2ht1CYGM=;
        b=o7rukXFq+gQ5r/DiqeMBXKmWWIX0E535B8F7CcayoGeLTqHtbhSVkOzLlEuEHuu0jj
         jcht7C/amx4ZdyJr+e6XjiPY8LD902NyQrR0ilRT8FfYkdv6taeiZv491MiR2KzoRHz4
         hretbjBzwb9PSuW/SV1KoMBZCpjOADZ1kV7qqXmmmAI2mAZwmjJa2U84TayktZ7Lkri7
         akhZvmAXte4Es+XoRMkKHm3TtzMaw3dyVhvgQthAYoeVpBUrYb9qNCRUNoNH+XSa+Ijs
         A3RxiYRbuM/B9YP3Phl1SuxDsnefzXQC58ibbQQfdjqTZMiU4ukeyUhhQcJlghjJ/Gri
         fVNA==
X-Gm-Message-State: APjAAAVAFVCSQ3Aoz/Nu1cwnRFV5A0dyN6gO39FyVENxqTZV+pmgYg0H
        xjA79ruI5wgZwY2jzNKTT6ABwVRC6Umr6wi3IGZQhQ==
X-Google-Smtp-Source: APXvYqxUdSMUGjIYkHAAAs/1MyRUWBH0p5gnLBNuQX1ZYHmYTbj3Ko+q57g8RPufme6evpKRs7gSJg8B3/T+/20Al4s=
X-Received: by 2002:a54:450e:: with SMTP id l14mr2961220oil.36.1576621274673;
 Tue, 17 Dec 2019 14:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com> <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
In-Reply-To: <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Tue, 17 Dec 2019 14:21:03 -0800
Message-ID: <CAJmaN=mNVJVGPkwYvE6PmQSgT8o3Uo3=1iQm2NFicZ2fFC6Pxw@mail.gmail.com>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Dec 17, 2019 at 11:33 AM Jesse Barnes <jsbarnes@google.com> wrote:
> >
> > Still debugging, but this causes a panic in console_on_rootfs() when we try to dup the fds for stderr and stdout.
>
> Duh.
>
> That series was incredibly buggy, and there's another bug in there.
>
> I think this should fix it:
>
>   diff --git a/init/main.c b/init/main.c
>   index ec3a1463ac69..1ecfd43ed464 100644
>   --- a/init/main.c
>   +++ b/init/main.c
>   @@ -1163,7 +1163,7 @@ void console_on_rootfs(void)
>
>           /* Open /dev/console in kernelspace, this should never fail */
>           file = filp_open("/dev/console", O_RDWR, 0);
>   -       if (!file)
>   +       if (IS_ERR(file))
>                   goto err_out;
>
>           /* create stdin/stdout/stderr, this should never fail */
>
> and yes,that particular problem only triggers when you have some odd
> root filesystem without a /dev/console. Or a kernel config that
> doesn't have those devices enabled at all.
>
> I delayed pulling it for a couple of days, but the branch was not in
> linux-next, so my delay didn't make any difference, and all these
> things only became obvious after I pulled. And while it was all
> horribly buggy, it was only buggy for the "these cases don't happen in
> a normal distro" case, so the regular use didn't show them.
>
> My bad. I shouldn't have pulled this, but it all looked very obvious
> and trivial.

Oh I should have caught that too, I was looking right at it...

But anyway it looks like a nice cleanup with a few more fixes.
Hopefully we can get there soon...

Thanks,
Jesse
