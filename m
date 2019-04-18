Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF636C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3BC217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oloqSQV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfDRNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:18:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37653 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388253AbfDRNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:18:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so1672692otn.4;
        Thu, 18 Apr 2019 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmRLwwulNSmiQ7YqZfm/rSlRZBFV/TKnGZPEzI+AGpo=;
        b=oloqSQV11CRs849x7iwLVtrscASGRrTPOPPryHv1IPLfambPgLyUuIJqvI/ca8xPuP
         qUV6Uq/Hml6snG/ulcL4O7l+jZhYHxlaiPT4wB8x6fVgkyS1NiSjL3oxdMkX16pOVp6K
         GI7NeVBfegYI1Cjp4xM/vkByWYfp8s7iBOtdKRedmXtDobGnkiqO/U/2AfJoMpAGWmrZ
         4oUODLUOtR9wdwaQa1M8je88l9KnvouzMCkPnU5Yi3qPhJ6NHk0BIW89axwXc0YT5hd2
         LlSAZIuaKTIeRj0X5E+DjV/CwE3xHs1DQH46TS0uhl4pZ5rusHFMSPm6R6fo2Esrw/v/
         XN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmRLwwulNSmiQ7YqZfm/rSlRZBFV/TKnGZPEzI+AGpo=;
        b=hQo9Km9+So5+DuUxUruP8QBHnJ9XDGP8MA0fKO41XNqEEJKT8OaBz56BilGe5w1bPv
         rz5ZHzK1/G8IRAibTDesn4UlZRF1XANWEuIk3zps7E/B/JMyt447tdaIcDSa3Z5iCGk8
         xFQIXE5xqYXdfIheO4VrbY5vhGonpuFISzaVNyFVi0Vpzx3spEtrLTswWGVljx8U6xVd
         +w6WGBHSOK4R3Ot/Kpg0rx4JNW07AL0Y+qXDP+iWtxtQimtQm4rjR27IA6JNwLeWjIic
         M9GE1yh/BDfO3MWOR1CriJajKMdA7fco3Ll7vCF8Id9C+iNofibkJUQcc161rhkMOca2
         H1Kw==
X-Gm-Message-State: APjAAAVQY8g+9tEj/EKio1K6tIsjm+pIX7DR2Hf3HI28qnFW0Ogx+7Tl
        c2nHTZFMzT30yBWOXGCJKRyXtUZ5cO+xZ2ZABDg=
X-Google-Smtp-Source: APXvYqyX5QLsU3pbj+6nkbiTuKPZCtejBr1tKmbuy0REPwJz+MaK09GRPPZpPsIOarvVsG//kU90Mb/hrtYvv8vxHZw=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr57602153otk.95.1555593527015;
 Thu, 18 Apr 2019 06:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net> <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net> <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
 <3103f45a-facf-89a3-8a36-84507c570909@metux.net> <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
 <c1c84e6b-99db-672e-4062-9129d5e89d10@metux.net>
In-Reply-To: <c1c84e6b-99db-672e-4062-9129d5e89d10@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 18 Apr 2019 09:18:36 -0400
Message-ID: <CAGngYiX+VF=p1riYdC2ce=Vz0ig-2YR-TbeyL=XDh2gXn_Rp_Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Thu, Apr 18, 2019 at 4:21 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> So, that input line is *always* hardwired to the regulator ?Okay, that's
> a different situation.
>

Yes, it's always hardwired to the CAN regulator by production / assembly.

So it looks as if regulator is the closest suitable abstraction. I
suggest we stick
with it until and unless someone has a better suggestion.
