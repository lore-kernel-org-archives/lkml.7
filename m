Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F24ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783EA206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVM9BcVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfJHBoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:44:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39634 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJHBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:44:37 -0400
Received: by mail-io1-f67.google.com with SMTP id a1so33112304ioc.6;
        Mon, 07 Oct 2019 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fw209Whs539FleYIAnU1s0PqSxWW0KiTK1H4R+hwlPI=;
        b=OVM9BcVLoy6BaRIpxY8+rAgvJ00VTOBWAiySLb/FwcAzbDZIwDGGgb/C/oZ7axKGns
         mIk7bwGQo78Ahi0c0ZEyjVw2ZvYCuNod3xX2tppd7mTUr7GEUqfJvaLVfBIj+3O1/Z4X
         iQqBoxjeQlZiHtcbpZbqYpkG7VdOJxx3lPTQ/m8/BaA/Pw6E14XOXVPunznX76FNaTd5
         EixN7GlsZxlvh6v0Z9rsJ6+A1rvHUowLrR8u7QB4QVRISIJNcUqTz0m1MAEzn60FFs0G
         F1jUK+zocZQwlIkQ5HUFJ5CaVRupKdrjW98xH/W49nKbhQZA4NNEC8yuz7XOv250B1m+
         92gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fw209Whs539FleYIAnU1s0PqSxWW0KiTK1H4R+hwlPI=;
        b=lqHTyF7vUCZdR/KQXJQpq/ksfBekVMzXHf/8yZ+iAangoxxQSG8RhcibSXIM32tshp
         X56eyMcoFn7TuNmuOV3PobgNrQQAa4IYjs0RZf3AOwY4ppPmxEdmvS9cMYq5uCUSf3Lo
         bdTclTzVVlU4+JEbs4gHzADztIhGPlP/62Ve30XcKERMmATYls6FnsaBriBusofa08FQ
         b3wYsB8o1xSo6Nheqe5i1FqsVNuYA0fSrxLLljhVzPB1N1FwvqefaipPR7YErrKJFFFE
         g9BDJxAmF2CGPHtiVvTJIG038vpbnBAX0WoUM9PfSLS1roYuMuS9tgNj1oHfoVDrozfp
         AbVw==
X-Gm-Message-State: APjAAAViqBJY9e/esU9B4uU9HTVGQNDekAZvaMYG6X8OqP5IIlzplNE+
        uUgvC/Ed4slLgd0v6Bc4CeUhONSZ2FvCH6HKjBw=
X-Google-Smtp-Source: APXvYqxt6/0xninW5CnKNuJYQqbikrgLXATP2QD131RmcPQ9Z/5vmjUUYkrZ6xXfXBxL3RpKBYFfL7OfUy6i9llje9k=
X-Received: by 2002:a5e:8c15:: with SMTP id n21mr11990598ioj.246.1570499076276;
 Mon, 07 Oct 2019 18:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-6-linux.amoon@gmail.com>
 <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
In-Reply-To: <CAFBinCAoJLZj9Kh+SfF4Q+0OCzac2+huon_BU=Q3yE7Fu38U3w@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 8 Oct 2019 12:49:46 +0530
Message-ID: <CANAwSgQScXdKewfBtu-o_sjRb-pk+CvJrv4RunGJOzz=DWjBnQ@mail.gmail.com>
Subject: Re: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin.

On Tue, 8 Oct 2019 at 01:40, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Mon, Oct 7, 2019 at 3:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index c9a867ac32d4..72f6a7dca0d6 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -774,7 +774,7 @@ CONFIG_MPL3115=m
> >  CONFIG_PWM=y
> >  CONFIG_PWM_BCM2835=m
> >  CONFIG_PWM_CROS_EC=m
> > -CONFIG_PWM_MESON=m
> > +CONFIG_PWM_MESON=y
> some time ago I submitted a similar patch for the 32-bit SoCs
> it turned that that pwm-meson can be built as module because the
> kernel will run without CPU DVFS as long as the clock and regulator
> drivers are returning -EPROBE_DEFER (-517)
>
> did you check whether there's some other problem like some unused
> clock which is being disabled at that moment?
> I've been hunting weird problems in the past where it turned out that
> changing kernel config bits changed the boot timing - that masked the
> original problem

OK.

>
>
> Martin

Sorry for linking this two separate issue PWM failed and microSD detect failed.
Thanks for the input, I will check if you patch help, I will try to
investigate more why it fails at my end.

Best Regards
-Anand
