Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00592C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB1620679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNyITElN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfHMNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:44:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38155 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbfHMNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:44:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so22722494ota.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G+G9l6sHBySdRwXOFFe8DEk9Xv/ufJQ2kG5hgA77tBk=;
        b=oNyITElNlRS5IKoO27dbnlQeDTR3di9cBknbLl/TzRy0OfFrN7FrszKKF9RogU+82h
         dh650Zy/aJ4tb2PDVCTCfpkkEtuK7CP6wyvhe59rsHuW4ArpqsV5CicnCSEDxJvq8knl
         pxnMGex44S9+BkbN+5C35qqGSCMt3pRK06ciJuCeUc2AuQ1Gyy/RH5yzkEcWx2Zp0ykC
         nP8+N08rETqiN+2n5IEgRGCOBFtUKkdarfGWJvBcf464iZJc5meuswLu6uVksgkDyLtR
         I+FyVSHqKfTjSTFMaRiP0la+7BNZVziBcovbP5SIe7+1EiEDcVAHrjaSYDSusCvhisMx
         6OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G+G9l6sHBySdRwXOFFe8DEk9Xv/ufJQ2kG5hgA77tBk=;
        b=e5TqLQRIMQj7+s8cCPxwO8GqkL6iA/E5hpGvmxN212Tka2kmU1t0IjDek8m+Cp4QcJ
         b+I9b+c2G3fid/sfLrsy7GsJ3nqVz0ixsjPZRy22jHpUOl8Jv97NC0L9DkhjczpDge+f
         bwNzzAe+NWE5KpOTnkeA2xj6xFGfdzaCrRB3LrohCkspsIPnpRz3ooReyyPbJW54pA0y
         PJrI0VYsEgy4G/k5AQ1PuFsPXPeNP/WLryR//Um+dk7V5jg0+/6KsZQzDwuayxgGHMHv
         2lGo+nR6dc7scYEmv1CU5khhibN4PwUzS1gtsqH1UedD6murLH1E26F4a3MSfgWElhLO
         3Rxg==
X-Gm-Message-State: APjAAAUAtPp5XpxGOXeixKVz0qZvmpyYMM+HisqELZ8UOZuiFq+y4SLl
        HwoyWE4BVGbnZPd4ksXKJpnzPTXgqlaqLZ+JvS7baw==
X-Google-Smtp-Source: APXvYqxsl0OjYU2QpOHrN2OzlJzdHW5Wiwko6BTDqu1Xxe8c8ISrQKbzx5myTiJVU5yAF7c/V/QpovgcR7IAVS7lIKo=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr22258479otk.145.1565703848169;
 Tue, 13 Aug 2019 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
In-Reply-To: <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 13 Aug 2019 21:43:56 +0800
Message-ID: <CAMz4kuL-YFpV-JxAq2cM2=vKo1AUU2uWzrfG6SXG0NFqzOnq3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Fri, 9 Aug 2019 at 18:06, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>  Hi Uwe,
>
> On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > From: Neo Hou <neo.hou@unisoc.com>
> > >
> > > This patch adds the Spreadtrum PWM support, which provides maximum 4
> > > channels.
> > >
> > > Signed-off-by: Neo Hou <neo.hou@unisoc.com>
> > > Co-developed-by: Baolin Wang <baolin.wang@linaro.org>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/pwm/Kconfig    |   10 ++
> > >  drivers/pwm/Makefile   |    1 +
> > >  drivers/pwm/pwm-sprd.c |  311 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 322 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sprd.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a7e5751..4963b4d 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -423,6 +423,16 @@ config PWM_SPEAR
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-spear.
> > >
> > > +config PWM_SPRD
> > > +     tristate "Spreadtrum PWM support"
> > > +     depends on ARCH_SPRD || COMPILE_TEST
> >
> > I think you need
> >
> >         depends on HAS_IOMEM
>
> OK.
>
> >
> > > +     help
> > > +       Generic PWM framework driver for the PWM controller on
> > > +       Spreadtrum SoCs.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-sprd.
> > > +
> > >  config PWM_STI
> > >       tristate "STiH4xx PWM support"
> > >       depends on ARCH_STI
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 76b555b..26326ad 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_ROCKCHIP)  +=3D pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)    +=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)     +=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SPEAR)              +=3D pwm-spear.o
> > > +obj-$(CONFIG_PWM_SPRD)               +=3D pwm-sprd.o
> > >  obj-$(CONFIG_PWM_STI)                +=3D pwm-sti.o
> > >  obj-$(CONFIG_PWM_STM32)              +=3D pwm-stm32.o
> > >  obj-$(CONFIG_PWM_STM32_LP)   +=3D pwm-stm32-lp.o
> > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > new file mode 100644
> > > index 0000000..f6fc793
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sprd.c
> > > @@ -0,0 +1,311 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2019 Spreadtrum Communications Inc.
> >
> > If there is a publicly available reference manual available, please add
> > a link to it here.
>
> Sure.

Sorry, we have not supplied a publicly available reference manual now.
So no change for this comment in next version.

--=20
Baolin Wang
Best Regards
