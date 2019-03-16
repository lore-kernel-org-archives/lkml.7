Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BC4218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jmrYFc2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCPWHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:07:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41821 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfCPWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:07:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id v7so413127oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tXsxzgOzwviiw4AI4/JgeuPKkrzL6ZPUgu2mPVy+R+0=;
        b=jmrYFc2twfhtugmBZiBKqT2lnFEZhHB6hAxGf9HZBAtXvOE/0dcuspf2Xovr6LEda5
         a76kDDUts2lrmXdGKNqd9QibMUx+ctmGlGkS8QWYyfPq5IuORLoT839vHT08tvt1Xld+
         LdmF9udyXSJX1PNAc/h9ePp3ULfbSNqjnMl5gX391Lwhtug7nNXmfb3awucXS5g7HITQ
         USH34NmV3KA/d0oJJjAwQv8Qo0wiYan/PmQf/KADOD+kww8vHN+JaeLXtTl+ZcCAx8ZZ
         CUjdw6FT2XHgwztRgRYyGuxm1Bsq/lEsvrS9pg4gPR+IrPe3z+FNaqkU9oqAuz2UO9C+
         JaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tXsxzgOzwviiw4AI4/JgeuPKkrzL6ZPUgu2mPVy+R+0=;
        b=NSJjYMOIzG97jBc5Hr8reuTEY56lv0yUCc7+tWofFdtLO9DiA7FCIdtUbTn4pcwOQu
         JOaLPr5IV5C8Ei4+HAgVz0kJyeHfamn5P8gTVm/dSx/NBcJuYFHgbady58MBV3Sz8Faf
         pL5qgo6pUqxdeUCfk/CMZrDa/3fTwexp0H12bYtjbadn2Vno+LYdP2yjfg5GfUk5FKVQ
         kHop49NKB2fHvf19u3HCpo3H+jIZHAGljJUdR2+hOWaaGsS0ruovqaPBiGvyvfcwcBeM
         16p6ueseJlis6pwY1BGAHNrH8S7/8lDz7Um4JVF/oXH0QK+w2FL6WV7wwCvprAl6iuDQ
         XdWA==
X-Gm-Message-State: APjAAAULffsllSGUqvufx1MmG5udWwLo/9ASto12MpJllL8GnRBbwGMD
        1ciyTRJX2IPiGcTxGoAjfISNNmzDJF9Std2ouf647g==
X-Google-Smtp-Source: APXvYqz2qdKtizHFrUWgbw9SI74hQFePNHOcYi7eqSq+Mb1r10fY1LjN2DiRVxT7kSLzXrz9oJuFfnuXEiGsB4EQAtM=
X-Received: by 2002:aca:4205:: with SMTP id p5mr5798922oia.15.1552774032538;
 Sat, 16 Mar 2019 15:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com>
 <20190311095613.11371-12-narmstrong@baylibre.com> <CAFBinCDU_6JEJJS8yZkq0rjbqKcy2eBKFaYqgX3txGMiO5U9Fg@mail.gmail.com>
 <5C8D0C2B.2010605@baylibre.com>
In-Reply-To: <5C8D0C2B.2010605@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Mar 2019 23:07:01 +0100
Message-ID: <CAFBinCDyTPLr+fNptpHa664pMqvp4X3Tv6166h_C+b0gHBJ-ZA@mail.gmail.com>
Subject: Re: [PATCH 11/11] arm64: dts: meson-g12a-x96-max: Enable USB
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Sat, Mar 16, 2019 at 3:46 PM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
>
>
>
> Le 15/03/2019 22:50, Martin Blumenstingl a =C3=A9crit :
> > Hi Neil,
> >
> > On Mon, Mar 11, 2019 at 10:58 AM Neil Armstrong <narmstrong@baylibre.co=
m> wrote:
> > [...]
> >> +&dwc2 {
> >> +       status =3D "okay";
> >> +};
> > your patch description states that this enables the "USB host ports"
> > but dwc2 is only used for peripheral mode (meaning: dr_mode =3D
> > "peripheral" or dr_mode =3D "otg").
> > do we still need to enable dwc2 in a host-only configuration?
>
> DWC2 is peripheral-only, but we can still manually switch one of the
> ports and use it as peripheral with a Type-A to Type-A cable, thus
> enabling dwc2.
thank you for the explanation!

> If the OTG capable PHYs was behind an USB Hub or directly connected to
> a device, we could disable dwc2, but for now this port is always tied
> to a physical Type-A or micro-USB connector.
>
> Maybe it would be sane to always enable dwc2, and disable it for specific
> boards only.
In case the port is connected to an USB hub we can add a comment to
the .dts to explain why dwc2 is being disabled. that way we don't need
a comment in each board.dts that it's enabled to support forced mode
switching.
in other words: I like this idea!


Regards
Martin
