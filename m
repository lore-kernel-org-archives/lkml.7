Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpP3edUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfDQDjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:39:18 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36377 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDQDjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:39:17 -0400
Received: by mail-ua1-f65.google.com with SMTP id k32so7453012uae.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHl2P77rAVnev3KHI0yYfa98B0Lb6NwJiV+WY6WqGiM=;
        b=OpP3edUMOxE3/9KU6xYBJqTOJghIlIz4biiLLVIIY4RLhvI1PDmVo6vTvh1g7pyf4D
         biaG2uX8jOU10E0lHZiwsM0fsWvFQCtL5tqdzO28+08rC8EIKHXG3i6e+H6xNwSQHwFW
         zvLEbSdjDNu5KbuBo7zWWpqbX8tPbfLV4fVEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHl2P77rAVnev3KHI0yYfa98B0Lb6NwJiV+WY6WqGiM=;
        b=TZfDyXLvP+FFEi+4YzdtInmBJKXNI3EhR2+RmsNUoyCXDeymWtJ3ctDLNvd5Ir/s11
         CQi09zV/ROY34ffyClCcGOvGYe162fZdgjvKSXbVBauPEtLTzpuqbRcymcPG3j+iQVDh
         Bd1nTWoimoYIQWDVkNU+DF2APrvKcOd6GaTYMQoRwJQ7wtEcjaZx9MAZZ/lNfva4Uayk
         qQHH0ZDKCzuSI9zsWRKyPhLnUE3Lxi9zLx0W57CpUF8htaUp5VmgViWb4OxqHIxIYdXf
         KL9zKV9nMeeel3yJw3/obmJm/x0RLapdh+NgcSAHT5RU18JkUOLUi9G2EOoLpM3g65Cx
         K5qw==
X-Gm-Message-State: APjAAAXBNAoEU5gPiwVUhWs1FWAKWMCHvfePzDhD5HNMRVlZRIJH+Foj
        mUsu746EmrvUXum27o0bi1yZ//O9QCw=
X-Google-Smtp-Source: APXvYqyU66qSa0KPteHxlbi0OnJTWToludev1/u0lq8nsVby9D98FcTtXvQS9FWMFe4uWYiiNlKwIA==
X-Received: by 2002:ab0:714a:: with SMTP id k10mr24604723uao.82.1555472355999;
        Tue, 16 Apr 2019 20:39:15 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id j42sm16589307uag.17.2019.04.16.20.39.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 20:39:15 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id n16so7443895uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:39:15 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr26912367uak.99.1555471866258;
 Tue, 16 Apr 2019 20:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190215185151.GG7897@sirena.org.uk> <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com> <20190301124100.62a02e2f622ff6b5f178a7c3@linux-foundation.org>
 <3fafb552-ae75-6f63-453c-0d0e57d818f3@collabora.com> <CAPcyv4hMNiiM11ULjbOnOf=9N=yCABCRsAYLpjXs+98bRoRpCA@mail.gmail.com>
 <36faea07-139c-b97d-3585-f7d6d362abc3@collabora.com> <20190306140529.GG3549@rapoport-lnx>
 <21d138a5-13e4-9e83-d7fe-e0639a8d180a@collabora.com> <CAPcyv4jBjUScKExK09VkL8XKibNcbw11ET4WNUWUWbPXeT9DFQ@mail.gmail.com>
 <CAGXu5jLAPKBE-EdfXkg2AK5P=qZktW6ow4kN5Yzc0WU2rtG8LQ@mail.gmail.com>
 <CABXOdTdVvFn=Nbd_Anhz7zR1H-9QeGByF3HFg4ZFt58R8=H6zA@mail.gmail.com>
 <CAGXu5j+Sw2FyMc8L+8hTpEKbOsySFGrCmFtVP5gt9y2pJhYVUw@mail.gmail.com>
 <CABXOdTcXWf9iReoocaj9rZ7z17zt-62iPDuvQQSrQRtMeeZNiA@mail.gmail.com>
 <CAPcyv4i8xhA6B5e=YBq2Z5kooyUpYZ8Bv9qov-mvqm4Uz=KLWQ@mail.gmail.com>
 <CABXOdTc5=J7ZFgbiwahVind-SNt7+G_-TVO=v-Y5SBVPLdUFog@mail.gmail.com>
 <CAPcyv4gxk9xbsP3YSKzxu5Yp9FTefyxHc6xC33GwZ3Zf9_eeKA@mail.gmail.com>
 <CABXOdTd-cqHM_feAO1tvwn4Z=kM6WHKYAbDJ7LGfMvRPRPG7GA@mail.gmail.com>
 <CAPcyv4hyOtJsnM6qqey7ADY=7brzVQ5TH3URrofmsQ57t1=WbQ@mail.gmail.com> <CABXOdTeu0WTv9b+0eLHC+0K+HdNQsRTAUaWyxXAbKxQyy_19PQ@mail.gmail.com>
In-Reply-To: <CABXOdTeu0WTv9b+0eLHC+0K+HdNQsRTAUaWyxXAbKxQyy_19PQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 22:30:53 -0500
X-Gmail-Original-Message-ID: <CAGXu5jL=QibF4GLC6uy9pUoXLxVwXZ7X-PPr5v9nAw01h8bKZg@mail.gmail.com>
Message-ID: <CAGXu5jL=QibF4GLC6uy9pUoXLxVwXZ7X-PPr5v9nAw01h8bKZg@mail.gmail.com>
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Guenter Roeck <groeck@google.com>, kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 4:04 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Tue, Apr 16, 2019 at 1:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > Ah, no, the problem is that jump_label_init() is called by
> > setup_arch() on x86, and smp_prepare_boot_cpu() on powerpc, but not
> > until after parse_args() on ARM.
> >
> Anywhere but arm64, x86, and ppc, really.
>
> $ git grep jump_label_init arch
> arch/arm64/kernel/smp.c:        jump_label_init();
> arch/powerpc/lib/feature-fixups.c:      jump_label_init();
> arch/x86/kernel/setup.c:        jump_label_init();

Oooh, nice. Yeah, so, this is already a bug for "hardened_usercopy=0"
which sets static branches too.

> > Given it appears to be safe to call jump_label_init() early how about
> > something like the following?
> >
> > diff --git a/init/main.c b/init/main.c
> > index 598e278b46f7..7d4025d665eb 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -582,6 +582,8 @@ asmlinkage __visible void __init start_kernel(void)
> >         page_alloc_init();
> >
> >         pr_notice("Kernel command line: %s\n", boot_command_line);
> > +       /* parameters may set static keys */
> > +       jump_label_init();
> >         parse_early_param();
> >         after_dashes = parse_args("Booting kernel",
> >                                   static_command_line, __start___param,
> > @@ -591,8 +593,6 @@ asmlinkage __visible void __init start_kernel(void)
> >                 parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
> >                            NULL, set_init_arg);
> >
> > -       jump_label_init();
> > -
>
> That should work, unless there was a reason to have it that late. It
> doesn't look like that was the case, but I may be missing something.

Yes please. :) Let's fix it like you've suggested.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
