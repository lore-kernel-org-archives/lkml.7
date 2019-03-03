Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A4C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F0D20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2jyAv55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCCOcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:32:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34262 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCCOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:32:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id g16so1874525oib.1;
        Sun, 03 Mar 2019 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcEiJSf6W2mFlK701kQmXQbOOT+3vjHiGZ7pRhBXDeE=;
        b=D2jyAv55gkBf0zQWZtiVGzQ4PoebTlFqyjFxCN3JGq623AohjhETk0fH9uJCH0vMGx
         2JDG0rGGsXTAF6KMNeb71I8AaiW5cWu6fUQkYcj3siNi2RvxtcUm6HZYVd7yWUYCpmNI
         V8gZbswkGOQMG8ZJ+mF9ohM7f0BOe2D1xzjIxIWylrAeAEJprzvFEvyrFKfTp3NCtsBB
         PDiK8U1IYc8PSL37DWI5dhlb1KnONI1flLA8TX2rVcFYUE6hxYH49TazSn4wuBfWbXeU
         b4/EwnSygw5YGbCaVPv38UH3LiqBUGciaKcY9lqdPsJNN2i1Wm4NbFZVZ6yFPf1kf+tV
         YoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcEiJSf6W2mFlK701kQmXQbOOT+3vjHiGZ7pRhBXDeE=;
        b=DiiSU5LmWBpkUWUVVCrZ8IVAA8jDv7NVQtw4XzAuNVaE5cvE+pM0wJYO2OpdI3sBoe
         gq5lf0BAg69XJwkS3voNOsj3mYquCZyKoy6yecdIla92KmE/wwzz03zGZXfxr4lLJMhB
         YXaylEsHZoIl06V57rEEFG4G6Ft1kDzCdMylPjaK+3+YRga7qp4IH7VtCQxvEufHJywq
         7RanuWZacF1UNakM2+UChOg7FSEHxRjlzop86k9vVLdMPHaE5qEaizmPnAWk8ZlRjQf7
         yCPRd1ed0+t9ja3q+rRXAqtThZqK1zGoMBGHyJ+x5hLM9eFRXTKhg8yXjLhSeiotYVet
         K2ng==
X-Gm-Message-State: AHQUAuY4QmSurWKnv3yMJPfsF5rCyUqijS47XvGv/LLp0QGQ9KhP8c6b
        xrLJqfDbHsXS4ZmXhDjsJZj59iAfeDPJiAysBvY=
X-Google-Smtp-Source: AHgI3IarF0EMPOA3ykuSKsXS23moO0gKn1nwZEqJLgmYb9J5K6g7SDmDDzAyOJAOUTg15HgTgBPwn7IcWzt/JDDhRY8=
X-Received: by 2002:aca:b388:: with SMTP id c130mr9027514oif.117.1551623561772;
 Sun, 03 Mar 2019 06:32:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1551358569.git.renatogeh@gmail.com> <72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel@analog.com>
 <20190303135220.swjrc4r7jb52rw6n@renatolg>
In-Reply-To: <20190303135220.swjrc4r7jb52rw6n@renatolg>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 3 Mar 2019 16:32:29 +0200
Message-ID: <CA+U=DsrQ290frz6D2XJa-Z2joG-883hehLfN-u_NM_1n69X+PQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] staging: iio: ad7780: move out of staging
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 3:52 PM Renato Lui Geh <renatogeh@gmail.com> wrote:
>
> Hi Alexandru,
>
> Thanks for the review. Some questions inline.
>
> Thanks,
> Renato
>
> On 03/01, Ardelean, Alexandru wrote:
> >On Thu, 2019-02-28 at 11:23 -0300, Renato Lui Geh wrote:
> >>
> >
> >The patch-series is a bit big.
> >I guess that the intent is to move this out-of-staging, but various patches
> >are holding this in it's place.
> >For patch series above a certain size, you could get many re-spins
> >[V2,3,4... so on].
> >
> >You could send some of the changes as individual patches, or group them in
> >series of 1,2 or 3 patches. That way, you "parallelize" patch sending, and
> >when you get reviews on each patch, you can re-spin them individually.
> >You'll find over time that certain patches get accepted on V1, others on V2
> >and some on V7 [ hopefully, there isn't any frustration at that point ].
>
> On these subseries, should versioning follow this patchset (v5) or should
> they start anew (v1), ignoring this series version?

I guess, in this case it's fine to leave it as is [in this series].
The series has been reviewed now.

But [for me typically], I delay doing a review if a patch-series is
longer than 4-5 patches. And I think some reviewers may do the same.
So, if I want more people to review/look at my code, I try to make
things as easy to review, as possible.
And one way, is to definitely keep things decoupled.
If one patch can be independent of another [for the same driver/code],
I send them as separate patches.

This [of course], is a preference. Some reviewers don't mind longer
series [than 4-5 patches].

> >
> >Well, this is a technique I use to distribute some of my upstream-patch-
> >work, so that I can switch easier between internal-work & upstreaming-work.
> >
> >Coming back to this patch-series.
> >My general input, is that the patches are fine over-all; some are just
> >cosmetics/noise/a-different-way-of-doing-things-for-this-driver, and those
> >usually can be left to preference [of the maintainer usually].
> >
> >I do suggest to not hurry when re-spinning patches, and not change too much
> >the number of patches in a new series. That can complicate things
> >sometimes. But, if doing small patch-series or individual patches, you
> >won't have this problem too much.
> >
> >Thanks
> >Alex
> >
> >>
> >> This series of patches contains the following:
> >>  - Adds user input for the 'gain' and 'filter' GPIO pins for the ad778x
> >>    family chips;
> >>  - Filter reading for the ad778x;
> >>  - Sets pattern macro values and mask for PATTERN status bits;
> >>  - Adds ID values for the ad7170, ad7171, ad7780 and ad7781 for ID
> >>    status bits checking;
> >>  - Moves regulator initialization to after GPIO init to maintain
> >>    consistency between probe and remove;
> >>  - Copyright edits, adding SPDX identifier and new copyright holder;
> >>  - Moves the ad7780 driver out of staging to the mainline;
> >>  - Adds device tree binding for the ad7780 driver.
> >>
> >> Renato Lui Geh (9):
> >>   staging: iio: ad7780: add gain & filter gpio support
> >>   staging: iio: ad7780: add filter reading to ad778x
> >>   staging: iio: ad7780: set pattern values and masks directly
> >>   staging:iio:ad7780: add chip ID values and mask
> >>   staging: iio: ad7780: move regulator to after GPIO init
> >>   staging: iio: ad7780: add SPDX identifier
> >>   staging: iio: ad7780: add new copyright holder
> >>   staging: iio: ad7780: moving ad7780 out of staging
> >>   staging: iio: ad7780: add device tree binding
> >>
> >> Changelog:
> >> *v3
> >>  - SPDX and regulator init as patches
> >>  - Renamed filter to odr and ad778x_filter to ad778x_odr_avail
> >>  - Removed unnecessary regulator disabling
> >>  - Removed unnecessary AD_SD_CHANNEL macro
> >>  - Changed unsigned int to unsigned long long to avoid overflow
> >> *v4
> >>  - Split gain & filter patch into two, with the new commit adding only
> >>    filter reading
> >>  - Changed pattern values to direct values, and added pattern mask
> >>  - Added ID values and mask
> >>  - Added new copyright holder
> >>  - Added device tree binding to the ad7780 driver
> >>
> >>  .../bindings/iio/adc/adi,ad7780.txt           |  48 +++
> >>  drivers/iio/adc/Kconfig                       |  12 +
> >>  drivers/iio/adc/Makefile                      |   1 +
> >>  drivers/iio/adc/ad7780.c                      | 365 ++++++++++++++++++
> >>  drivers/staging/iio/adc/Kconfig               |  13 -
> >>  drivers/staging/iio/adc/Makefile              |   1 -
> >>  drivers/staging/iio/adc/ad7780.c              | 277 -------------
> >>  7 files changed, 426 insertions(+), 291 deletions(-)
> >>  create mode 100644
> >> Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> >>  create mode 100644 drivers/iio/adc/ad7780.c
> >>  delete mode 100644 drivers/staging/iio/adc/ad7780.c
> >>
> >> --
> >> 2.21.0
> >>
> >
> >--
> >You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> >To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> >To post to this group, send email to kernel-usp@googlegroups.com.
> >To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/72a54cd5f58aeb9507b95b7e33ca3d9a38c853e9.camel%40analog.com.
> >For more options, visit https://groups.google.com/d/optout.
