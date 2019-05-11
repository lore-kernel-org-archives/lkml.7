Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D24C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FD521841
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OmGjgt7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfEKMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 08:49:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54921 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfEKMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 08:49:10 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so13593091ite.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zd9Zp9MAsLaVOIfM+3iMvyilHtpibiYoJjp6hLjLpc0=;
        b=OmGjgt7J5IsJ0nlDnn4zjCGMSK554FEokSjg0EiBaQeJ/RvZT7re6UejW/4+kuBLUz
         vKfosXNZYXnUWnljMFydRYmDORYWJjf4f94FtCuWgIKoNUUYuKG0EDBbgG5pnuRBl6Iv
         BX778ZtrFSRtFzmJjZwQME+zIEH/o8vax4bNxtzZNhjNKQEZc+m5vGlYbC7QQpPQseDK
         lJpFI/bXLK6EQcsN+/4/M0zkUUHPXrqiVHcyK3mb3k30fUVj3ZQydvHsFeT8eMnzbNSQ
         WJArYfc/L1QFJFuOq2ypUFA3zmfftBbYvC4qaxzbdRH2tEXtG5hiRCoY1jks2Q3X6YwK
         UiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zd9Zp9MAsLaVOIfM+3iMvyilHtpibiYoJjp6hLjLpc0=;
        b=CAzTEdfgrIMdhuBEk/+1TzFu0hRjE8q2V5DWDPKeqjnAl+8xfckE/Q8eYHaOEcSYle
         hobpjojHT3IWZ1Azs1uzBQxkf7m2UhnxVYMR6wLIXzph6BLOC4ufymjUN155bxlRN3P3
         wOknFqZB0VZpztA3MOowrXXQdEci8MHVxKvkO6X7xA24tTHB/WUnSYojaR8/ngDkj1ZN
         XJ2easivqizkpZbi4sywYxqkdoUuuVmUfbaUPAp4D74V8GwiD3XkLz9HYkAaPl2AcDSl
         J+gmyT9TRkz9aOL4IH2ezZtx2rUZJipfszo0v9CGlVAVq7lKGdmoBECrhNzfHsq3vaD0
         EUnA==
X-Gm-Message-State: APjAAAWb3Pg9IHo8h4zBhdtddFFiqM6uaM5VSufZEvAQe27YkoeCAgIC
        9NliJ+akPHOvyY7tM2gTYa1clndYDa3GtGI5suxEPg==
X-Google-Smtp-Source: APXvYqztIEDYo3alGkeqwDxIYarkNx5BaXoTQc/Nvp5SfuSqWrJrks0GwGQwAUdRLa/SjinEOEAxlxC/Q9kDPn3T04s=
X-Received: by 2002:a02:1986:: with SMTP id b128mr12277400jab.136.1557578949592;
 Sat, 11 May 2019 05:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190411094944.12245-1-brgl@bgdev.pl> <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com> <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
 <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com> <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
In-Reply-To: <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 11 May 2019 14:48:58 +0200
Message-ID: <CAMRc=MeOHr0bKJYGgOrhHq4dYFwCnpYvuFAL3jZerwCPvQgC3Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 maj 2019 o 18:22 Anton Ivanov
<anton.ivanov@cambridgegreys.com> napisa=C5=82(a):
>
>
> On 10/05/2019 17:20, Bartosz Golaszewski wrote:
> > pt., 10 maj 2019 o 11:16 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
> >> =C5=9Br., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napis=
a=C5=82(a):
> >>> ----- Urspr=C3=BCngliche Mail -----
> >>>>> Can you please check?
> >>>>> This patch is already queued in -next. So we need to decide whether=
 to
> >>>>> revert or fix it now.
> >>>>>
> >>>> I am looking at it. It passed tests in my case (I did the usual roun=
d).
> >>> It works here too. That's why I never noticed.
> >>> Yesterday I noticed just because I looked for something else in the k=
ernel logs.
> >>>
> >>> Thanks,
> >>> //richard
> >> Hi,
> >>
> >> sorry for the late reply - I just came back from vacation.
> >>
> >> I see it here too, I'll check if I can find the culprit and fix it tod=
ay.
> >>
> >> Bart
> > Hi Richard, Anton,
> >
> > I'm not sure yet what this is caused by. It doesn't seem to break
> > anything for me but since it's a new error message I guess it's best
> > to revert this patch (others are good) and revisit it for v5.3.
>
> Can you send me your command line and .config so I can try to reproduce i=
t.
>

Sure,

the command line is:

./linux rootfstype=3Dhostfs rootflags=3D<path to a regular buildroot
rootfs> rw mem=3D48M

The config is the regular x86_64_defconfig from arch/um.

Bart
