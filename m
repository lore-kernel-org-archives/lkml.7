Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B6C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780B82184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="slKwAE6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfEKRQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:16:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39733 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfEKRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:16:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so3251401oie.6;
        Sat, 11 May 2019 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmjomU5YJY1hJ5LLp4HW3B+RQuK7rgkSpAY98t+yz8o=;
        b=slKwAE6jfgdzV3wLyArpatbYuZnieepmKQla1+9qvI2E2rycU6g1G7V3nJarzymotB
         OOktkdgfHW9GdVOCxYYO2xO4EUtHaMZpWi7CfClL/k0K4jKnNt9rYrKip/Yo9Y9vcKNp
         lf4irG4cZ3dGwdolaKyDsyLG+57iPN22aa5duKXce7wXjFpxe4te6EaNoH+QA5sXwR1P
         n3bLE+JZMLXK71v7GhBM+QAWTcIVZoA0dG490NUhdAygRYFNGfE1+JYb3b5X5aryXIvF
         4vYiBd0fpbPc1LQ6iQx4gHGvHRNNQ5MTj2egzb31kA08efK/uOpr+Aev7GxrRcczEaka
         ixNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmjomU5YJY1hJ5LLp4HW3B+RQuK7rgkSpAY98t+yz8o=;
        b=ob8RFTbDn2iio4kWpUCXT2Jgr6m9cI+5AGSN0xQKb4LS6y0j9a4kkbLokxz0bRkVaB
         +RJfAIDXe+T9i+5aqTgHww4x2u9XVqhAkH1ULBMuyl6lEmaLnbw6n2ji5p644NQxm6Qr
         6cyGUq0dRbdcXiY5DIn7v2zDe5iyEoHw+6zH8DXieCGIbSQQ508zh4zTFt9yyVNP04n1
         Zm9dGl4/qlsYMtfIGry8vDNHzTiyo3vYKyu3B8410pQEYOAmK350XzrIY5XRvbN+mOXP
         9g5Ct6MTvusW96o5C6elNc6mj3ETOFglZtkvim7wZBGHExrZggzM/h2V0UGcAeGRgZ31
         NLIA==
X-Gm-Message-State: APjAAAUiNMDOUNbk4VardYE7wo/pMoxg7wAs8YfCc+F3adcJ0HrGbsO6
        0m3Fq0/d5rXovU0s3I8WTLRevdXFN+peax/mAiiOARrtUYO/5Q==
X-Google-Smtp-Source: APXvYqwDBBFTnklw8obeVbRgYAvDTy11F6HrgYJI1Y/q9N3Y451amnscogWIGhUwAoBS6nGEGKbEQkAY7I8Wo9PaEuU=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr8819792oif.47.1557594987534;
 Sat, 11 May 2019 10:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-6-jbrunet@baylibre.com>
 <7ho94ac4jn.fsf@baylibre.com>
In-Reply-To: <7ho94ac4jn.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 May 2019 19:16:16 +0200
Message-ID: <CAFBinCDA3kqCK9riSkNAv9069ASN8E2ECdsffi+U7mYRqHrfJg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: meson: sei510: add network support
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Sat, May 11, 2019 at 12:45 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Jerome Brunet <jbrunet@baylibre.com> writes:
>
> > Enable the network interface of the SEI510 which use the internal PHY.
> >
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> I tried testing this series on SEI510, but I must still be missing some
> defconfig options, as the default defconfig doesn't lead to a working
> interface.
>
>
> I tried adding this kconfig fragment[1], and the dwmac probes/inits but
> I must still be missing something, as the dwmac is still failing to find
> a PHY.  Boot log: https://termbin.com/ivf3
>
> I have the same result testing on the u200.
I wonder if we're simply missing the pinctrl definitions in the ethmac node:
  pinctrl-0 = <&eth_rmii_pins>;
  pinctrl-names = "default";

I don't know how the SoC works internally but I am assuming that the
MDIO pins are routed to the "internal PHY" (within the chip).
also we need the eth_rmii_pins anyways for the RXD/TXD pins which are
connected to the physical Ethernet port on the board.
bonus question: while writing this email I'm surprised to see that on
GXL we don't use the rmii pins anywhere, why is Ethernet working fine
there?


Martin
