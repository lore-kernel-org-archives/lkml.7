Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A1F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llwhd/u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfDXPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:10:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35490 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfDXPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:10:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id m10so16467197otp.2;
        Wed, 24 Apr 2019 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5b1SSwWrbMSWeHJT9LSNjf6Sf7GaupVu/R4M530q+Q=;
        b=llwhd/u9jhAdJR80lPLwvLXhdH9NVwDfMRCJP0upafUi+2a0yufmLyarnasjWcn6I1
         +YY9pNWFrNOk1QtVJDAmZZnfodsOziE2T75HEPCSD3lUwI8SkpwciH3juvAFjIyx1XE1
         4hRxyMxsa1zjbxTY3S0N8VK3kLW9yfOMyuBMEphXdgvMbfXOyfOqugixFRvc+2iTOsTa
         g5oY6Xrixj8mOODg32L7yGPy6jzL8J0/U0snbI3j9PS1Pfs4EedGBXNVRCOzgxqAB9hq
         pYz3yrunyYFB8s/ueSKse7H+LCNm1L8JupOmopyZwNpXlfM3Tl2NNhsJFJkwfdHvFAno
         1nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5b1SSwWrbMSWeHJT9LSNjf6Sf7GaupVu/R4M530q+Q=;
        b=DAqV56mQwvWuUkooCb0aZP92aVWZnzvseqdvHp/XI4azW5mhwRgNF0IjQ/jtqV/bvy
         kqgUTAebM3gGpit7xyvTFdnuEyyft03X5qRGZcfxSsLsk2fQxLl653w53aNUhWYwwVfB
         CNJPt5SJe1r0tHLFX9zTM1C4sRfgY85PmmdvuOvnSyWffJGLogLZ6Meh/Ic50yVVBeFO
         LwW6hbcw5+IqS5w2XxZJPiZKJ751a/awV3GbkHzoLumozLVciL/tnBH2LAjbKRo3vxX2
         rJWvMknyYlyCS/PUEUaLKyDnyXzsioZhx3XKz0dufNmPIJlPi0ya6oKIWb3NVOeBA5LT
         rHVw==
X-Gm-Message-State: APjAAAUt5MJ5Gb2T3+UDdhUHfJ+bISV4PwQZdk+sjDelYwXDexXvg8kV
        14KILsPlzrp62sV0sqWHb6Z4dG8Hf35eqElGbHU=
X-Google-Smtp-Source: APXvYqzs8dn20Yw581OEA6lWFtRZ0zEnAT3CgQTU2/l9tfsT/vbdgfYGaeqrGHKVadPCR3YY/S4L0DydeszaswrFOUM=
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr18039151otd.250.1556118628400;
 Wed, 24 Apr 2019 08:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net> <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net> <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
 <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net> <CAGngYiUPZ+g4eXJKvgA9GSJXgOFAAf6Q3qqAheiqNSnJ+Dbx+w@mail.gmail.com>
 <e07f7575-2617-a11a-fd78-d068b10a8171@metux.net> <06024a8a-ad00-8062-215b-01b2f95a6e24@hartkopp.net>
 <c1b783b0-9773-17f5-d043-35e28f7797f0@suse.de> <d54b294e-d641-bb14-84ed-39d9a9079dc7@hartkopp.net>
In-Reply-To: <d54b294e-d641-bb14-84ed-39d9a9079dc7@hartkopp.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 24 Apr 2019 11:10:17 -0400
Message-ID: <CAGngYiX_xxDWEAbxQ=XeZPYAA+zgQ32U0Ov=CG86yE=6=qTfpg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
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

Hello Oliver, thank you for your input, appreciate it !

On Wed, Apr 24, 2019 at 7:50 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> I hopefully got it right by: You implemented a standardized chardev ABI
> that enables a data exchange between userspace and kernel, where other
> drivers can register 'from inside the kernel', that feel like being a
> fieldbus controller?!?

Close ! Devices that "feel like" a Fieldbus _device_ can register.

The subsystem is called fieldbus_dev "fieldbus device" because it
abstracts Linux fieldbus clients that want to expose themselves as
e.g. an actuator, motor, console light, switch, ...

The commit message fully describes this, and so does the
Documentation. Any improvements are welcome.
https://lkml.org/lkml/2019/4/16/817
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/fieldbus/Documentation/fieldbus_dev.txt?h=staging-next

During one of the eleven review cycles, drivers/fieldbus_dev got
truncated to drivers/fieldbus because the reviewers felt that
_dev was redundant, given the lack of other fieldbus
subsystems.

This subsystem came about because I'm trying to mainline
support for three HMS cards: FLNet, Profinet and CC-Link.
These cards are not controllers, but slaves on the bus.
All three make heavy use of process memory. From the
get-go, the kernel reviewers made it clear that the userspace
cannot be specific and must be generic. So I crafted a generic
ABI that works for clients on process-memory based busses,
and called it 'fieldbus_dev', for lack of a better name.

I'm by no means a fieldbus expert. It seems that the term
'fieldbus' is much broader than these process-memory based
standards? I am open to any _concrete_ naming suggestions
that can get consensus.

I'm a bit confused by Wikipedia's entry for fieldbus.
It suggests that IEC 61158 and Fieldbus are
interchangeable?
https://en.wikipedia.org/wiki/Fieldbus

<quote>
Fieldbus is the name of a family of industrial computer
network protocols used for real-time distributed control,
standardized as IEC 61158.
</quote>

>
> How can this fit together for me and what would be the plan to cover
> CANopen or EtherCAT in the fieldbus subsystem? Does it need some kind of
> CANopen protocol driver that registers to your ABI and speaks to CAN
> interfaces on the other side?

Given that CAN/EtherCAT are not process memory based
(that I know of), the fieldbus_dev subsystem is probably
not a good fit.

Also no good for bus controllers, the subsystem deals
with slave devices only.

Sven
