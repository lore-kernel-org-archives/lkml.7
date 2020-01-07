Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D7C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B8520678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwQPCEh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgAGR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:29:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42874 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgAGR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:29:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id y4so382741ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgUNxG+Km1+BP8w9TX1X22sqfNmqdVbzivjIJVzsay4=;
        b=qwQPCEh5sM6BpKHk+6sN0FKBHHUglvqoiC7FA66ZsXfXJ1HceaI9LHqlKEi/ca9RY3
         +RwQ7928TzgKz+a7Ve38vM7ARzyXCpfPVEud2OgnJNWNyCxPGd0I/kkC9YIOfQOhhG04
         sCY08N2mkjisP2DpDw046K+C8dDdGqHISrc/MjYC//0BtJmtbkCbH3JWJNFfL0n6b//6
         Agn19xaLVEYYuo3sRmUwT3zq0fJq++8WWOCVgMkiU1ZXlshzqehAzk/IKwjIPe61eDCl
         kb3tFR8jF4tBegzU3ZDCVx6S7RUAC5ks60JcvdrmGn45Zj7E9fIvHyBmcalSCxJlJqau
         jXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgUNxG+Km1+BP8w9TX1X22sqfNmqdVbzivjIJVzsay4=;
        b=VVoLOL1vatt9ZiuyvEhKkwCrWQz2FRZ0jww5VCm1zuBtimtRf3jCc/O6uZgAw01PvY
         VSAauhkg33Fo4QyxrbnF6R0NtRoHoweFMVCMDfmc4zvmIVkzYSxX9Z1l3NfQQmj7Y05D
         E5Y3KjJgwrm/9qkUmEPTm7aMZxRuPtyxlsDBdm10bk7E9GxetUkCAm2ID6IBDmFVzrud
         MyGM3a3V43lS7THHosPHxTqOBk2tMcrYDNjOtZGLGVaj2HVGTzxA//CTN+RV46FN8x+v
         gyiICYADjMPZ1U8NQuDJdMYeZWK+W4ZmCw5wEreG3mpriIYORf3Ws+QUkUHPL+MggW4P
         3JWQ==
X-Gm-Message-State: APjAAAUI2+963GHrEpv6baucZvryzeWglrlBS1Lph5+0BR1N9VO8Vo2e
        f/KPdIghpONnumQ7jfmLs/1RFJ3Nh7SClzTa3o5olQ==
X-Google-Smtp-Source: APXvYqyeD3Z3ZptIkzBJq5ByN1Cm20iK0EYdKy4UieSVpwDzlUWuSCA0ziNPb2E3L3zab4ZLNvJaxxXUt+9CaOdkztc=
X-Received: by 2002:a2e:b4ef:: with SMTP id s15mr380590ljm.20.1578418167575;
 Tue, 07 Jan 2020 09:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20191210185351.14825-1-f.fainelli@gmail.com> <CA+G9fYsMyUWGo8Qtd2UCfYDV2aoH71=hCZKaTurq4Aj2eeZczw@mail.gmail.com>
In-Reply-To: <CA+G9fYsMyUWGo8Qtd2UCfYDV2aoH71=hCZKaTurq4Aj2eeZczw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jan 2020 22:59:16 +0530
Message-ID: <CA+G9fYvmwetcZPraZrHbj=MjgWZik-wFK7nEejs-6TrYyODcSg@mail.gmail.com>
Subject: Re: [PATCH 0/8] ata: ahci_brcm: Fixes and new device support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 at 22:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Wed, 11 Dec 2019 at 00:25, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Hi Jens,
> >
> > The first 4 patches are fixes and should ideally be queued up/picked up
> > by stable. The last 4 patches add support for BCM7216 which is one of
> > our latest devices supported by this driver.
> >
> > Patch #2 does a few things, but it was pretty badly broken before and it
> > is hard not to fix all call sites (probe, suspend, resume) in one shot.
> >
> > Please let me know if you have any comments.
> >
> > Thanks!
> >
> > Florian Fainelli (8):
> >   ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
> >   ata: ahci_brcm: Fix AHCI resources management
>
> Following error on stable-rc 4.14 and 4.9 branch for arm build.

Following error on stable-rc 4.19, 4.14 and 4.9 branch for arm build.

>
>  drivers/ata/ahci_brcm.c: In function 'brcm_ahci_probe':
>  drivers/ata/ahci_brcm.c:412:28: error: 'struct brcm_ahci_priv' has no
> member named 'rcdev'; did you mean 'dev'?
>    if (!IS_ERR_OR_NULL(priv->rcdev))
>                              ^~~~~
>                              dev
>    CC      fs/pnode.o
>    CC      block/genhd.o
>  drivers/ata/ahci_brcm.c:413:3: error: implicit declaration of
> function 'reset_control_assert'; did you mean 'ahci_reset_controller'?
> [-Werror=implicit-function-declaration]
>     reset_control_assert(priv->rcdev);
>     ^~~~~~~~~~~~~~~~~~~~
>     ahci_reset_controller
>  drivers/ata/ahci_brcm.c:413:30: error: 'struct brcm_ahci_priv' has no
> member named 'rcdev'; did you mean 'dev'?
>     reset_control_assert(priv->rcdev);
>                                ^~~~~
>                                dev
>  cc1: some warnings being treated as errors
>
> Full build log links,
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/702/consoleText
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.9/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/773/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/404/consoleText
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
