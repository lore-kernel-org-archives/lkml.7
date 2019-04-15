Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6D12064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDWXaf84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfDONCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:02:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34009 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfDONCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:02:23 -0400
Received: by mail-io1-f67.google.com with SMTP id n11so14467586ioh.1;
        Mon, 15 Apr 2019 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sFM+qsI5/6bYFnc1EZQHLAcVqYKJhjMvjztdQS7uHX4=;
        b=bDWXaf84R7HM51lgL5G0BQmAqV2KC689QZDuAPxEvG2MqltsthqE8lpy68zMHFqjvw
         B64C19wY4vPo+r8gziWGnhvnwMujTihoOw43luhSgleBIkN9+0xtYep8TdnRN478Pj9p
         Q0HWaoRa6Lw4AWVOzQm4kweQ+DBEUVbt92A/Q74XKCbwm6v+0m5KewhM+XYdyVVAMGRR
         Xi6+IOEmBhnwuJSNSxV07w+6SRYoNy5xw11Sp3TmN/oi7pO32/7qNXPB5F8W7hzTvs73
         /yRKdjOuf6xjipYIjQ0rcRCjhafgIZ08KLlwTgWYJj1IxgoSBC4yi7HGRjcyAJ0Xkd6i
         54QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sFM+qsI5/6bYFnc1EZQHLAcVqYKJhjMvjztdQS7uHX4=;
        b=PiGA+iL28W5DJ6O2ng+ICbGFZjyfSLkMWPgJoFgLTTc+ek2OZjkmS/nIQp5h7UOaCM
         BSgcKthkhnzA0Rlp8gLpZQLSXtntTr49DwEbdqr/G0Hv1+zMZF14jzJkEEqQvdO7osY4
         xZLupTfzxAiOmUceO4Tkn2PnHqa3Cmfee0uQsvVXEw1PQWRqhxoFh1TfPVgbFvaM8fjW
         mSriKwuHjt5IR04c/VWkU1DyTshuu7CrF8blpqk6OigebZy6Y/lVk7SGcZej2XMdCtOI
         QTIp+I31rWAHu1A99bB+Vxg7JSPv+ExoSnIMUwhTCfadTTGqHFNYYd5GHDvPLigpWaGJ
         j7Ug==
X-Gm-Message-State: APjAAAV4bxvHDpur+pLKyNwLyNjLEBErjax3WoedZm+e2wULbKJM/DeV
        AQBRl3DdsqmfPaz6x7eNWIUDolSM48crWY76nh8=
X-Google-Smtp-Source: APXvYqx8VYoGqiD59hm30siuS9kEuOHoJrweWaziiY253mPCKX9WKVxVds99pDJkyehuVA32rGh1xZlGLzvT3HKdyKk=
X-Received: by 2002:a6b:e61a:: with SMTP id g26mr48126044ioh.105.1555333341766;
 Mon, 15 Apr 2019 06:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com> <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com> <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com> <CAMpxmJUG+7ENUCnooexWKMwoq+zCuRsV_Y54un7omumk9nJguA@mail.gmail.com>
In-Reply-To: <CAMpxmJUG+7ENUCnooexWKMwoq+zCuRsV_Y54un7omumk9nJguA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 15 Apr 2019 08:02:10 -0500
Message-ID: <CAHCN7xLyiKjr9dvVKBHmpacTQnWwdf_WjJ4xa-URrO8=-=UVQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 6:55 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> pon., 15 kwi 2019 o 12:21 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
> >
> > On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
> > > pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a)=
:
> > >>
> > >> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
> > >>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(=
a):
> > >>>>
> > >>>> Hi Bartosz,
> > >>>>
> > >>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > >>>>> From: David Lechner <david@lechnology.com>
> > >>>>>
> > >>>>> This adds a cpu node and operating points to the common da850.dts=
i file.
> > >>>>>
> > >>>>> Additionally, a regulator is added to the LEGO EV3 board along wi=
th
> > >>>>> some board-specific CPU configuration.
> > >>>>>
> > >>>>> Regulators need to be hooked up on other boards to get them worki=
ng.
> > >>>>>
> > >>>>> Signed-off-by: David Lechner <david@lechnology.com>
> > >>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>>>
> > >>>> I remember you mentioning about some problems using OCHI and cpufr=
eq
> > >>>> together. Are those resolved now? CPU PLL on DA850 can affect othe=
r
> > >>>> peripheral clock frequencies too. So enabling it should really be =
a
> > >>>> per-board decision.
> > >>>>
> > >>>
> > >>> The problems are still there. I've never been able to find the
> > >>> culprit, but it also occurs on TI BSP in the same way (a couple
> > >>> cpufreq transitions will make the controller unresponsive).
> > >>
> > >> Is that on LCDK as well? As I recall cpufreq was never enabled on LC=
DK
> > >> in TI BSP.
> > >>
> > >
> > > Yes, I just verified that the bug occurs on LCDK with patches from th=
is series.
> > >
> > >> If the OHCI problem is present on LCDK, then there is a user visible
> > >> regression on mainline after this patch. Lets enable cpufreq in LCDK
> > >> only if all working peripherals keep working afterwards.
> > >>
> > >
> > > The OHCI driver doesn't register any cpufreq transition notifier
> > > callbacks. I can't really find anything in the datasheet, but I'm
> > > wondering if we shouldn't do something similar to what the driver for
> > > davinci i2c controller does. I'll try a couple things tomorrow.
> >
> > Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
> > not sure the benefits of just frequency scaling will be justifiable eno=
ugh.
> >
> > Fixing the OHCI issue may help in other boards like da850-evm use it
> > though. So that will be a good thing.
> >
> > How do you feel about keeping all OPPs disabled by default in da850.dts=
i
> > and enabling only the ones that make sense for a board in <board>.dts?
> >
> > Empty OPP table is illegal, so this does mean that every board must
> > enable at least one OPP.
> >
>
> I guess in that case we'd need to make 300 MHz the default for
> da850-evm, but on da850-lcdk I'd go for 456 MHz (due to the regulator
> being fixed anyway).

Based on what I've seen of your V4 patch, I think it's fine to let the
da850-evm run at 375.  I am not sure why it would need to be default
to 300.
I agree that the cpu-supply is correctly referencing vdcdc3_reg, and
it's currently setup to handle .95 to 1.35V, which I think is OK based
on what I've seen and the OPP's look right from what I can tell.

adam
>
> Bart
