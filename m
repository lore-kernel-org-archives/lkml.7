Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86EC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE61520815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GQmbJ3aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfEPNZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:25:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40354 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfEPNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:25:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id d15so3088396ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBQglN9y1UCEoiDsyDKmavv3pTw2avVwHy9wGSr4d+c=;
        b=GQmbJ3aVkAkxYq4ebWu1xQr82AleFWY5CEch/sBznZ0n1N0TCZv7wWXuBmc5XP4gK9
         0kz8teIQJnMwKDt4K3j18W4obgX85WUOBdEyFawJHemHKe/k3RiymhPVyQ15zn3EOflo
         68z0GFwwNB0yuxgeOj4koQP5hlddq3mITwbdTJl1YABN4VIEGYhAAVYgj0LaHQ/e2/3f
         igDW+NXWmbxv28jV6e2QnJqq+R+z1fq+bQEsXVh4pRMoJVxLNnB2ISHUhoqATTsEUlzq
         MhKsuF+/P24J230PUDWXeuNC2ijNAiqOyXuNACqs8iMiQsma6XyJtItfunwihjMfiT5s
         4i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBQglN9y1UCEoiDsyDKmavv3pTw2avVwHy9wGSr4d+c=;
        b=PJxn5nxeA1sk9kxPXEDZOVQMx0N73wca38MUcG/y9GIfviR/Rnhvsnz93e+9V4LMbD
         ++nrlmHgxjH5bSC61cJN6KT8yeAIYg/8HZHvBf5sSMUmQiyjBRJaTmZ33vg7BehQoI4I
         d3Ijmy6tjn2ZbsFavSstioJBc1Di8KIKIj1UGS6x/X88BF8EBd9qjk/sefqwNdgGCsyy
         QH3BrvR5a3OguHaRcxf0nxZ9Rjjr4VHADlnm++9Zvt+8sOPbV9GFV1xpWcsEVfJXvqGn
         ApMCLDpD75WvpRLyvAh9CfHBx/d//l7/IXspnBdu92nLmvtYXDs60vp2WukfDig2/9I8
         rxLg==
X-Gm-Message-State: APjAAAXPB2Yiza2EbrA7dSlBtrNOY2/96/xUHlZsPhp5NbhmjZ7q5Jo3
        gvejzLHiAriWx+NRht4zwGX/DIpWGxvQjcwntAHw8A==
X-Google-Smtp-Source: APXvYqxyM8uKxGHNJAN6reja+yN/0m8IqjdmaVrInAyROSmFRr/vSpkDGQKVYugaZ4aLVYVtQpPVddOrXFdHM695bek=
X-Received: by 2002:a2e:60a:: with SMTP id 10mr3406462ljg.126.1558013147786;
 Thu, 16 May 2019 06:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190509205955.27842-1-f.fainelli@gmail.com> <20190509205955.27842-3-f.fainelli@gmail.com>
In-Reply-To: <20190509205955.27842-3-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 15:25:36 +0200
Message-ID: <CACRpkdYXp3LMXrSQrndUWWNq0eYb=P22FC9V0__j2AZPGCq0Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: bcm: Allow PINCTRL_BCM2835 for ARCH_BRCMSTB
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Doug Berger <opendmb@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Matheus Castello <matheus@castello.eng.br>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:01 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Doug Berger <opendmb@gmail.com>
>
> ARCH_BRCMSTB needs to use the BCM2835 pin controller for chips
> like BCM7211 which adopted that pin controller for GPIO. This
> commit makes the option menu configurable with default enabled
> for ARCH_BRCMSTB and ARCH_BCM2835.
>
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Patch applied for v5.3 with the ACKs.

Yours,
Linus Walleij
