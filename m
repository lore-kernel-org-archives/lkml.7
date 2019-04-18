Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0748C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83033214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBnuiX3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbfDRReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:34:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41960 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:34:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so2363234otb.8;
        Thu, 18 Apr 2019 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKjAeJZBkpucqw+A5EBo+RGfgZpuy4Jux0R1ukl11uY=;
        b=JBnuiX3VQpqFmcI3ZS3JHA/4CGjuFN5MQBVXRmW0XTYsTXSo/0XeurkkC1YHxA3y2/
         CdTBnWp+xu5PlwVeqeUD+/nF0UjH2Aa9jjT+h7xN6KQLaAqtgGwhhk+4TOvATi8oKuye
         lkxseLFb0e5catDDus9M8JgfKzttFItDyjRpB8PLHkc1p1fsn2Cnd4VlZpkzDYLk7Nbi
         oOi1KGMYPPB44RBzeTzjfBO7Jx3plTECrlCjel3Mjyt5xyJCKM6qahrATb9vJP+wHt8U
         4V39kOKl4wtUAKUoSOUD1ANhofjIJ2lBfYm+7+HGRQ6OjA37GqfUf6fB/r2iI9TjRUut
         2T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKjAeJZBkpucqw+A5EBo+RGfgZpuy4Jux0R1ukl11uY=;
        b=T18QuKf2NcaM3YupAk6nF5oVz4IgG1uyB47h84MMzB1ZJj9jNiitYlaWxILrRC6kPK
         u6OD95jAKKhEbt9CPx9V1/IZ2GBANlRBMl9tbKSm0Se94K6Ga+dhc6XVEoLYzk4/N1r1
         HH/5i6GzrCzcjEHbgDqWbEE6w0liiIt5NIkWaLtFXS0f8h04FTCaM/8VXZu8AHjyOUOW
         dikMrexDkaT2xp1KywUy9ZwQxS7qqXf3oMlRAXYzg+IZpZcRiAJnQ6TP7mqG/RhVXwY5
         Jh6EaQFkf3EXyijmFsftaZ7SCY2QHERv7h6b5xDLvv1ZyFlorTG32IfLhiuLwgRjAgxd
         FZcA==
X-Gm-Message-State: APjAAAXcFHWLjfbeB0mQXbaacVotV8tTuSM0Gn9cYavXnpz/oZmAChr/
        Tw3VGbY9Geve/AS/+H6+pbRW+5gAhE4TW42VQMk=
X-Google-Smtp-Source: APXvYqyfBeng5kGzL00z28e0Gm/+kgAttwaaJ+wLiTF3RRSP3fJnWxqVlAXziqMJmc83U43Dp05yxA6aaEvu1T15/mM=
X-Received: by 2002:a9d:5b7:: with SMTP id 52mr60132803otd.279.1555608855543;
 Thu, 18 Apr 2019 10:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net> <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net> <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
 <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net>
In-Reply-To: <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 18 Apr 2019 13:34:04 -0400
Message-ID: <CAGngYiUPZ+g4eXJKvgA9GSJXgOFAAf6Q3qqAheiqNSnJ+Dbx+w@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Thu, Apr 18, 2019 at 4:34 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 17.04.19 00:12, Sven Van Asbroeck wrote:
>
> > PS do you have a specific fieldbus device in mind which could be added
> > to Linux?
>
> I actually had some Duagon MVB controllers (Ionia) in the pipeline.
> That's stalled for quite some time, as my customer doesn't need the
> MVB communication yet, for now just the machine as generic Linux host
> w/ ADCs+DIOs.
>

If you have a fieldbus device you want to add to mainline Linux, and
you wish to piggy-back onto the fieldbus_dev subsystem, then we can
discuss fieldbus API changes/additions/improvements during the
patch review stage.

It's my experience that good userspace APIs evolve from practical
requirements, not top-down theoretical design. The staging/ location
allows us to take an evolutionary approach.

Sven
