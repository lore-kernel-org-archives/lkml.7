Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61299C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447C21744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMjaeoJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgAGQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:47:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46511 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:47:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so221397ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvoR1wO4oEITSwLk+nSR4iwy2dpggu13mmwT8OJyr0g=;
        b=FMjaeoJA437ug2DT9AkKATKeWYluxfalXHIXuGLsu+H/CQWTMXEXGaJONDmFqkXD9Z
         YIl47qQjL9YED4/QKTQMdRBMaR4UtzhzsUP4vEGJgLYsQ8a2Lh84aBwcaeZ5/Dv4RszG
         GuV9ct7YZJyaK5EC0tdAm/MZa1N1zGPbW9Y1BGjKgKcF6Eaa0cfA576OBqXwRNXvngR+
         q5bgSIUOToJTEtbIQwgXjX7ADRA6XiN3fJ+mbM5GBESF0JdmpNuOlJYgepSHvi/UyCa8
         JcMXJizo1L2IUUuDvh8IEVEK/ct86ME35mNKyCYVQXGlZI1mfCA2nsZb30F/bHp35m1X
         AOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvoR1wO4oEITSwLk+nSR4iwy2dpggu13mmwT8OJyr0g=;
        b=VyMqoXDU59ZIFFdpV2CUC3CGexSMWdQ24BoFjqn6YHOzNX6j6LNLO8Xt5NhpODRNP3
         L9ejLa7utLgFyc0FKJiNyeadlgU+4RddPuyorjSwyOWOZYOxucQfJynHUWyJ8N01S8Zs
         +CPwUnyDFDK0jnFQKjtswyWRN49++8ufUR8pLmg4qNQy69VBz5ZRfZGKxuf5r99BhQGe
         Orla5feK3sHdYdxXBsSOQdFsZO3ePnNbpvS09fx5ysMyZJifqUs5LMa78hyfe8LVcp1K
         81oHiAsxiEgvPfZXm66vfX90FzsocB5ALYonUGFPa4OKsqdot3+bY7sUIXylI4Kr8pbx
         +29A==
X-Gm-Message-State: APjAAAXc7YSxIv7H9ehajeu8caR9US8YERug0UNzGj9q81k0u+bHvVRG
        4WGkad24VhLp89T6ye5fYRe3NV2jT4pnima0X/XRTg==
X-Google-Smtp-Source: APXvYqwIOBpCiKZzxq03MFz/y1i3ELijhWT1WUVjLBovW8HeCR9HCsqvBGOQKdcEH2KQk6TVpk5F1srYFucbjgSGpMY=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr215735ljd.227.1578415644575;
 Tue, 07 Jan 2020 08:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20191210185351.14825-1-f.fainelli@gmail.com>
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jan 2020 22:17:13 +0530
Message-ID: <CA+G9fYsMyUWGo8Qtd2UCfYDV2aoH71=hCZKaTurq4Aj2eeZczw@mail.gmail.com>
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

On Wed, 11 Dec 2019 at 00:25, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Jens,
>
> The first 4 patches are fixes and should ideally be queued up/picked up
> by stable. The last 4 patches add support for BCM7216 which is one of
> our latest devices supported by this driver.
>
> Patch #2 does a few things, but it was pretty badly broken before and it
> is hard not to fix all call sites (probe, suspend, resume) in one shot.
>
> Please let me know if you have any comments.
>
> Thanks!
>
> Florian Fainelli (8):
>   ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
>   ata: ahci_brcm: Fix AHCI resources management

Following error on stable-rc 4.14 and 4.9 branch for arm build.

 drivers/ata/ahci_brcm.c: In function 'brcm_ahci_probe':
 drivers/ata/ahci_brcm.c:412:28: error: 'struct brcm_ahci_priv' has no
member named 'rcdev'; did you mean 'dev'?
   if (!IS_ERR_OR_NULL(priv->rcdev))
                             ^~~~~
                             dev
   CC      fs/pnode.o
   CC      block/genhd.o
 drivers/ata/ahci_brcm.c:413:3: error: implicit declaration of
function 'reset_control_assert'; did you mean 'ahci_reset_controller'?
[-Werror=implicit-function-declaration]
    reset_control_assert(priv->rcdev);
    ^~~~~~~~~~~~~~~~~~~~
    ahci_reset_controller
 drivers/ata/ahci_brcm.c:413:30: error: 'struct brcm_ahci_priv' has no
member named 'rcdev'; did you mean 'dev'?
    reset_control_assert(priv->rcdev);
                               ^~~~~
                               dev
 cc1: some warnings being treated as errors

Full build log links,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.14/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/702/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.9/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/773/consoleText


-- 
Linaro LKFT
https://lkft.linaro.org
