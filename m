Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B99FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C58C22D6D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H+EogopS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfIAVxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 17:53:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38891 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfIAVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:53:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so11908466ota.5;
        Sun, 01 Sep 2019 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEhJt/EuEX52SqVPgMOZhCHD3vE6EwjavZnuWjJauI8=;
        b=H+EogopSS6+QVKxTUznOCWYUqIImQHvhH0GL9wHPsyQ6eOMFL8bDOv5lhma6JKWPlG
         nDtYXlzi8QhyegV9QBIRM/oMLLAO4cGBoyto0KytwdqZTLccD5YJrO+aaDcNt+D5ehGr
         zpsmFdaBL4aQ+UDghAsrzQ4Z/YQjQ2mYbKSV81hT4ucrHCASnt1FnIsWEhMeemIDVgOn
         IATEZdOzxNPXhstaXLYKg7jYtJ3+OMuWnV+F+szT1qCnEQZGiJD6ME7/XxPy37sLSXO5
         4TvNGf17IV9WvPSHXkPO8DiHIuUnEtcTpac10CBMOFWdl6XqJH0Y3jPIN8GxtxFWipnX
         BvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEhJt/EuEX52SqVPgMOZhCHD3vE6EwjavZnuWjJauI8=;
        b=IHYf8t+2fBNZtA/aB4wq3PPofIumu98eTL61P46Mpmj986PKjhP4wvJ+3E/jT+ebHE
         N3NK20aL59JJ+S5gh8MGKZzZxEkSIwA+E64dIBUKtVcVBqizAa+av1O5pftQG8y77eT6
         0aImV3xGab3d4Wc/Y1SAV6QXFeNWU9P6yDPpFXj3HCCJv8kk99A2oVsNx1ZVc4wiCa+5
         mJfut4MnOYwnS6xPKakCNN1Rt2Cr+tgmJhMpt7DUPAguAwa7XGmVtGAZQps5JBx8ZxTk
         X1kQjSd9RccPXaj9/vYUuAmYUY41EEeXyVZiqnn0Q5h11wsNtiDSCVNsP6Tz+Nnj0Z9A
         Yomg==
X-Gm-Message-State: APjAAAWo68l9lePoRPGt8+MSWEw4IFAGdj6E5xEdikMO2FahvZBoKKHl
        +9MfwGZ9bmuALvDQvr7vq+dJIGkIYIe24Rtis48=
X-Google-Smtp-Source: APXvYqz41KOD9u8sFziIzz6VBDnTuq9iWWzjB30yrB4xnLoj6n3Q0Qn4Mrcrjr0+WD/lgauNBmWiK6648rEIyDKKEe8=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr20076301otj.96.1567374832185;
 Sun, 01 Sep 2019 14:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202723.1145-1-linux.amoon@gmail.com> <20190828202723.1145-2-linux.amoon@gmail.com>
 <CAFBinCBWq0LcdA1-a5W06zKp0RzGs5_=Mph6StGKXJ7npCgbfg@mail.gmail.com> <CANAwSgS+HGYXr290=EvdhKxh3TiBOqfbcuuF4cMAiBVX1ez9+Q@mail.gmail.com>
In-Reply-To: <CANAwSgS+HGYXr290=EvdhKxh3TiBOqfbcuuF4cMAiBVX1ez9+Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 23:53:41 +0200
Message-ID: <CAFBinCCLPa64_h0JE4Z_pMuUuhb=HKUXPti2pkUFAuEPO2fE6Q@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] arm64: dts: meson: odroid-c2: Add missing regulator
 linked to P5V0 regulator
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Sun, Sep 1, 2019 at 3:58 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> Thanks for your review comments.
>
> Their have been some revision changes in S905 Odroid Schematics.
> [0] https://dn.odroid.com/S905/Schematic/
>
> Well I have make my changes based on old odroid-c2_rev0.2_20151218.pdf

[...]
> >
> > according to the schematics there's both:
> > - VDDIO_AO3V3
> > - VCC3V3 (which is turned on by VDDIO_AO3V3, see [0])
> >
>
> From the schematics it seams same.
>
> VDDIO_AO3V3---DMG340LSQN4 (Q4)---VCC3V3
yes, they are the same signal. the only difference is that VCC3V3 is
turned on later in the power-up sequence

> But this name change was done to link TFLASH_VDD_EN to TFLASH_VDD for eMMC
>
> VDDIO_AO3V3-----TFLASH_VDD using  TFLASH_VDD_EN gpio pin.
>
> Well I have tested this changes on eMMC module.
I cannot see any of the TFLASH_* regulators being linked to eMMC (they
are only linked to the SD card slot, I also checked
odroid-c2_rev0.2_20151218.pdf and odroid-c2_rev0.2_20171114.pdf).
which page of the odroid-c2_rev0.2_20151218.pdf schematics shows how
TFLASH_VDD is linked to eMMC?

please note that I don't have an Odroid-C2 board myself (so I cannot
test any of this).


Martin
