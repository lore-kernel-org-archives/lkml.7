Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA94C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7549F20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRzFebtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfETPQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:16:38 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34656 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbfETPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:16:38 -0400
Received: by mail-yb1-f194.google.com with SMTP id v78so5838975ybv.1;
        Mon, 20 May 2019 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=39pc0LYY2SOLC+Eab1jH/LHKWZC4F4vmwoS5+aTUN+8=;
        b=FRzFebtGvRzGumqr5/EOZMft8/BWyHD6J6b4Z9ZwYcf9Sle5L3/dS0JH8ZFX9ODkm/
         cZF4ZKffFotK/pNY52v4dL69ZDldsGJ1oZVQtNMPkHuPjkovD6x3wvOWtx/toYy7SsJ7
         DOpNjJA6rgc3vK52YLl+aQqPuOs5L2Mcu0rpk70QWwQs5WTExgBaG+TnapM/U9FHgNGM
         u5wb2zy0aHDXNwvCMkvTzy6K6M8KqpRlrIstB8TMcDkkV83MBWFQVTnWKxH6bpZdlAZb
         hkGTvHaKocyyQsV9f1UN915n+tYk9S15RMUFJx0ryNZ1zCDAL8a2g3w+Lgahs7JV4dv9
         pWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=39pc0LYY2SOLC+Eab1jH/LHKWZC4F4vmwoS5+aTUN+8=;
        b=GX9UCLo9JhL81le64zPePhagGQCAmzmsb1H2W7A4vQ906OIgRm/kgnSQNwlWDAtkD3
         K0NhiY3DuSBL2nHijItvtpGpNAbkaIMBreG1jhjIjMQeuNFVOYHch4dZ43qdMUHQ1UgD
         sld/+ty7egkSXHsMKuKjbRldIkv2gL3RrxugfjNDAhNAzv2/bI/vJyUkagaanrePHce3
         49xtyd0ZSpmtvcG/Qq74tzLb2d/1qj9O8PIFcVcyWuH3uZPgyLfJBQItiJzZBh7f0Ngx
         A4v1eZLE+zFItuzAbCoBC80PcjjsPyYP/7jpZLhZqfDS9XMJY4dmmHcl8YHkVnFHojwa
         ef8w==
X-Gm-Message-State: APjAAAUTvOC8Vg4UIWTwMGf1jnkWyiHjVQKfA7g8cVayCKphuH7dKujJ
        7uCacUBLg+6ZpV7QJR/AaNAbbU50b1ESjhAejdOs84TVVIc=
X-Google-Smtp-Source: APXvYqzow3lQOqwpzptZIX0AC+6atUp95ha3AFYPDLnPZl03o6N6jBbz43DrPfl2QMoZUmG26GkF95me2V3vml881DI=
X-Received: by 2002:a25:10c2:: with SMTP id 185mr33170384ybq.379.1558365396955;
 Mon, 20 May 2019 08:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190518152355.11134-1-peron.clem@gmail.com> <20190518152355.11134-2-peron.clem@gmail.com>
 <20190520073529.nxptfbibexrqyzfi@flea> <CAJiuCcdrW7RcEKePCr1DaL-be8dA5oOjvHdxYkiu=h37z2e7tw@mail.gmail.com>
 <20190520144258.eauhvvwfxuhiczie@flea>
In-Reply-To: <20190520144258.eauhvvwfxuhiczie@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 20 May 2019 17:16:25 +0200
Message-ID: <CAJiuCccUQ0grMo_RC4DN1AfzSPQq14KjUbNpFFvfQ+GBWDvG+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: watchdog: add Allwinner H6 watchdog
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 at 16:43, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Mon, May 20, 2019 at 10:14:10AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > >
> > > > +     - "allwinner,sun4i-a10-wdt"
> > > > +     - "allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
> > > > +     - "allwinner,sun50i-h6-wdt","allwinner,sun50i-a64-wdt",
> > > > +       "allwinner,sun6i-a31-wdt"
> > >
> > > Is there a reason to keep the A64 compatible?
> >
> > Yes, A64 and H6 has the exact same memory mapping looking at the datash=
eet.
> > So if there is an errata or a new feature for the A64, it should be
> > also compatible with the H6.
> > Which is not the case with A31 (WDT_KEY_FIELD is not preset)
>
> The thing is, if you use those three compatibles, then you're saying
> that it's ok for the OS to use first the H6 driver, then the A64
> driver, and then the A31 driver.
>
> If the A31 isn't compatible, then it shouldn't be listed there. And if
> it is, then you can skip the A64 compatible.

Hi Maxime,

I'm just supposing that A31 is the version 1.0 of the IP, A64 is the
version 1.1 and H6 is 1.2.
And if an issue is found for A64 there is more chance that we will
have to fix it also for H6.
But bindings the driver with :
"allwinner,sun50i-h6-wdt","allwinner,sun50i-a31-wdt" is also fine for
me.

Regards,
Clement
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
