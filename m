Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D72166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYlC8+bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfH2Lhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:37:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37977 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfH2Lhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:37:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id 62so2168811vsl.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=steHU9JTMpLHW7sybl9YQfRLR82mnhptlWwdqUe7Zcg=;
        b=fYlC8+bWZqR6XAfZhhKThI98qPivkoDILLJEWVCGUmMcEVDNau268nO678oYz2Haq6
         bmMtC4uuUu3KJg6bIbm5+boLwf+l8EkdFDEQDvPVjopj0wqLRln09CPb2ryMq76qUEjk
         JZkDX9bIbdu1BwxXgbD/qS8oHYFHEAEgRhmzN8sr/2fnePykHkgDXvor4Gj3bzeixJGZ
         /J5QdyYN1k9gZ83TBf1D2dDUqsjB0C7nWqGs/1GulojlUH4Z/N9Zg1T2OW4XVRrM+kRs
         BBBRW0dxsRpNuV+fNa6bWBpNGxJaiZOH8Yr29ngIVQQugS2pmpPIaUUsxUDI5stbThRr
         SUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=steHU9JTMpLHW7sybl9YQfRLR82mnhptlWwdqUe7Zcg=;
        b=WOoN6rXE5BWQs16AVZFcpzsFYJkyL94UQ8A+EarVX2zVWZ5Pd/E0RiS14JT3zA32Vc
         r1QWlLEm5u2McYNMtPW5zbtvCsCokq4RMRIDBXOQMCRfjpASV+96ggBT6RDkzSAW5eJt
         LkPoOjncAcHUYxZxvk2vFztJzOm/KbhfgKc6bPpRZhMGcm0e2rtBAg+vUHrDolYawdWu
         IbPgVmvZEgn4uRnV2kXy/ssuix5Ec5BrDKSRzbn8gKPH626x3Wb3zJAu6j3iRq+yVBhy
         sXgFwsvcGEm+SzeyIOweDKvNfllR1KrkHhgmHKS8D+5MyvpMTdhtPW19f7Yoz4QqyLiE
         Rf3Q==
X-Gm-Message-State: APjAAAXCgQlkOHz/gsqAbC67O64LjV/kiTjKBWC5vMBSbPUN33JhV4HJ
        IjbIQ3FUAXNMzRiyHg1A2ujXxIKLKBP6ViQCWItzog==
X-Google-Smtp-Source: APXvYqwNRXIaneirGcWLGuYXd/YuixR4X36HnLqF4jth7rfkzeHfTgzi9mMgWpVzP8+sp931Sn93UV23G6KlVGudVsg=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr5337390vsr.34.1567078671028;
 Thu, 29 Aug 2019 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com> <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
In-Reply-To: <f84d62b7-da00-f2bd-36e9-972435080bfe@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 13:37:14 +0200
Message-ID: <CAPDyKFp420OaeoedkR=KuX1EMNwOvCkCfJHZPRDXhVz-w8J0mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
To:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 12:52, Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:
>
> El 27/8/19 a las 15:24, Ulf Hansson escribi=C3=B3:> Assuming this should =
go stable as well? Perhaps you can find a
> > relevant commit that we can put as a fixes tag as well?
> >
> > Kind regards
> > Uffe
>
> The most relevant commit I've found that is related to enabling DDR speed=
s
> on H6 boards is this one: https://github.com/torvalds/linux/commit/07bafc=
1e3536a4e3c422dbd13341688b54f159bb .
> But it doesn't address the H6 SoC specifically, so I doubted whether it w=
ould
> be appropiate to mark this patch as fixing it, and opted to not do it. I =
don't
> mind adding that tag if it's appropiate, though :-)

Hard to say what makes sense here, but how about picking this below instead=
?

Fixes: 0a23f1ad88fc ("dt-binding: mmc: sunxi: add H6 compatible (with
A64 fallback)")

>
> On the other hand, I'm not sure that I understood correctly what do you m=
ean by
> this patch going stable, but I might say the changes themselves are stabl=
e and work.
> The only downside I can think of to them is that they are a kind of worka=
round that
> reduces performance on H6 boards and/or eMMC not affected by this problem=
 (are there
> any?), unless device trees are changed.

Adding a stable tag and a fixes tag for the commit, makes maintainers
of stable kernels to try to backport this commit and fix the problem
for "older" kernels.

Kind regards
Uffe
