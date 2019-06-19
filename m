Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1121920679
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z50UkcJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfFSOlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:41:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46477 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfFSOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:41:13 -0400
Received: by mail-ua1-f65.google.com with SMTP id o19so10031820uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuL65TuVUonkfDYC+yc+qXGA89Xa2MqrM+C9nMr53yk=;
        b=z50UkcJ9gf1Qmb0DTS3m0F60LXoKl9Uj4ZE8Y69bTITcVx9kxGwD+yUakZDgenUpMM
         MiLeZcvrSH41/V/cUogSecHNER0CvlIhvkiHNy5EJfw26PP0BzvukiV/lUlbZwUKN1In
         ueCcx0vPNC99LiCjH2KzgxVVXbor3azuonwTyx42gSTn7BQS+ALSzjZln+iIwctYArf4
         3PRJSa5Dp8WSlmBfV833+QccgrJMI9y5SZ8VmxWswoUCIlYbonz8KYJeQkUn6dxgz9Fl
         CYuWXwN2IGOrGGpCkJQIqsLEV/9T5TYERWJuRM5ICOL/hkav+FCiKs++ovFs8Mxev8Qs
         /U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuL65TuVUonkfDYC+yc+qXGA89Xa2MqrM+C9nMr53yk=;
        b=pWmelf/Br30tiuYYWAuzzT0Z5u6OoGhcr/P1qXRE28Z3bWXLu9TW9sd8Kvl9K2Ewhx
         43Iqi2y07qeTzTUW2Bp5O0l5+8LoFSO/owXcbxgakT0UfBYvPQqL4nBq9AQdPRlUX1fH
         SDRG05vXizzb4DN0GgCtKCJjOePmV/TgTb1w8IOIA8YuG+231MeFLXoQWOU2vJ3HezyE
         UJD+9f2O/PqBxTs+pt63Tuq1g7QmwOmtRBsSNd05Y5R/njHT80qZKX9TCENry88w7Rsl
         Y4a058R0whjJLMGYUNXuVI/LgUjxVW7iP6kbNybCLMQNx06iY5G4Gu6Xzfo6F9j4eFHi
         kVzg==
X-Gm-Message-State: APjAAAXPvWnmH6gkDdJePvJScZXDEB9hA6nDMiWr89BNLUNgOv/uHv/B
        5TqAbHo2O3+qOVEGIrYDwW3rblfUc76Ret/Nz8jBxg==
X-Google-Smtp-Source: APXvYqxiOhYGOm5J4KhiAdkkQECEzQdtrbEE+lhxjuEjI6r6F96s8L3Sc7YMCWr6KJmrx0p+YMydPuX3sCUGg9bvjMI=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr14379202uad.15.1560955272797;
 Wed, 19 Jun 2019 07:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com> <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com> <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
 <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Jun 2019 16:40:36 +0200
Message-ID: <CAPDyKFqC7aGX+BSP7U162Viq8qoL_df+N=zP_6P9xbzSZseipw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
To:     Manish Narani <MNARANI@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 at 06:59, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Uffe,
>
> Thanks for the review. Please find my comments below.
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, June 17, 2019 8:29 PM
> > To: Michal Simek <michals@xilinx.com>
> > Cc: Manish Narani <MNARANI@xilinx.com>; Rob Herring
> > <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Adrian
> > Hunter <adrian.hunter@intel.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly
> > Shah <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Olof
> > Johansson <olof@lixom.net>; linux-mmc@vger.kernel.org; DTML
> > <devicetree@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
> > Platform Tap Delays Setup
> >
> > [...]
> >
> > > >>
> > > >>
> > > >>> In regards to the mmc data part, I suggest to drop the
> > > >>> ->set_tap_delay() callback, but rather use a boolean flag to indicate
> > > >>> whether clock phases needs to be changed for the variant. Potentially
> > > >>> that could even be skipped and instead call clk_set_phase()
> > > >>> unconditionally, as the clock core deals fine with clock providers
> > > >>> that doesn't support the ->set_phase() callback.
>
> In the current implementation, I am taking care of both the input and
> output clock delays with the single clock (which is output clock) registration
> and differentiating these tap delays based on their values
> (<256 then input delay and  >= 256 then output delay), because that is
> zynqmp specific. If we want to make this generic, we may need to
> register 'another' clock which will be there as an input (sampling) clock
> and then we can make this 'clk_set_phase()' be called unconditionally
> each for both the clocks and let the platforms handle their clock part.
> What's your take on this?

Not sure exactly what you are suggesting, but my gut feeling says it
sounds good.

How is tap delays managed for both the input clock and the output
clock? Is some managed by the clock provider (which is probably
firmware in your case) and some managed by the MMC controller?

[...]

Kind regards
Uffe
