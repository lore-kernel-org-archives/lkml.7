Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027DACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF46821D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foVyjmSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393555AbfJYLyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:54:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36967 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfJYLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:54:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so2016677wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1LWEk5NDwzMMuF3rkTFZO8+rZQPu2LeOg3dA41BWEk=;
        b=foVyjmSWVCB+ODO3mICLm2j4i1gb55MmAGwOlRsBDwiOFyHF2PL2yvwKoBkKn0vNqK
         ELdUYWXNM7Vni1z1T2d0hdDudJFR0dC7wh8jmtXzGAfQ8K2GZXufbOQVnTenI3jyoIW8
         PeDyz+27Vp74ZHKkEGbM1R5yJ+YM8/E0gyL87dsPxZhQWW8a5u1fMUeI1B2Gd5Pwou4b
         WrXB5iCwMrw2gBka1Yh5w0qgaaQfYvL3cDY4uREkwJPwaSFXG7nJ+0QXDuih8YiTfE2V
         KysDj2yiXEc1ruL6pjOjsNLMWRuYzEuCsfg60DEdisNtOTVrBD/TEu/SNWFnWDPrBYRv
         B0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1LWEk5NDwzMMuF3rkTFZO8+rZQPu2LeOg3dA41BWEk=;
        b=NSDdZ/soFO9+sTavOYc6K1n9tC1fZzWvZICg3cMcN7am9zqb0RErbxayNWu7BNnUVc
         jmDEW5tZShzTVuMRpsmJTJ3cZmD8KjSB5l75CG6wZXv3fbMrcLO/tJWETekPkF7sGdbt
         ugeyBf1Pe4/izBE741mcvOf+eN1NSwINp8OHRuxXohEtevFJXpCm1Iml9DEmrzuYd3FB
         JGuodnN4/0uOjyd2tHuNwZjXkhCIaWXr2NICJAp9Wlv7JB0LW1+skQFltOL4t9w0TzPs
         Fvq/uBMHusLutEqKu53+Us2PY88MABz6/lY3EahzZs0P4W93O3NMvkK1Zv5YVEN9+SZ1
         1tyQ==
X-Gm-Message-State: APjAAAXgf4VW27LGZBB4aqjYFhQ6waALTeHt403dLJZenSYYUER9Bwq+
        jVPnK/QtUkSrZpP1xe0WBInA4i0HWphD0J+5T90=
X-Google-Smtp-Source: APXvYqz+3Xw9UHDe/WVlrgvvSEnMNWID/tGfnWcDU7yo8lh7WP7z5yB8vBQrTlwrLsJuXGo9ptbRDBtG6Em1EK/VQ30=
X-Received: by 2002:adf:edcc:: with SMTP id v12mr2580991wro.158.1572004457239;
 Fri, 25 Oct 2019 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <0d3919c9-40e0-7343-0bbc-159984348216@redhat.com>
 <CAHtQpK5ZSOMKY4U0y-HHHH6QiuYRWHr90SAzjaACpAGgTzALLQ@mail.gmail.com> <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
In-Reply-To: <0136a15a-7af4-dabc-a857-fcd80d5576a9@redhat.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 13:54:05 +0200
Message-ID: <CAHtQpK42mbpdZ5ppU6gjNvKOBZU8+DfdWLEmvjLRa0MnVTZZww@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Oct 25, 2019 at 12:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 25-10-2019 12:11, Andrey Zhizhikin wrote:
> > On Fri, Oct 25, 2019 at 11:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 25-10-2019 09:53, Andy Shevchenko wrote:
> >>> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> >>>> This patchset introduces additional regulator driver for Intel Cherry
> >>>> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> >>>> PMIC, which is used to instantiate this regulator.
> >>>>
> >>>> Regulator support for this PMIC was present in kernel release from Intel
> >>>> targeted Aero platform, but was not entirely ported upstream and has
> >>>> been omitted in mainline kernel releases. Consecutively, absence of
> >>>> regulator caused the SD Card interface not to be provided with Vqcc
> >>>> voltage source needed to operate with UHS-I cards.
> >>>>
> >>>> Following patches are addessing this issue and making sd card interface
> >>>> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> >>>> of the SD Card interface in consumers and exposes optional "vqmmc"
> >>>> voltage source, which mmc driver uses to switch signalling voltages
> >>>> between 1.8V and 3.3V.
> >>>>
> >>>> This set contains of 2 patches: one is implementing the regulator driver
> >>>> (based on a non upstreamed version from Intel Aero), and another patch
> >>>> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> >>>
> >>> Thank you.
> >>> Hans, Cc'ed, has quite interested in these kind of patches.
> >>> Am I right, Hans?
> >>
> >> Yes since I do a lot of work on Bay and Cherry Trail hw enablement I'm
> >> always interested in CHT specific patches.
> >>
> >> Overall this series looks good (from a high level view I did not
> >> do a detailed review) but I wonder if we really want to export all the
> >> regulators when we just need the vsdio one?
> >
> > I thought about this point, and actually came to a personal conclusion
> > that if I do this as a new driver - then it is better to list all
> > possible regulators, creating some sort of "skeleton" which people
> > could then work on if need be. I do agree that at the present moment
> > the one regulator which is exposed is the one for vsdio, but listing
> > all possibilities should not hurt. This was my motivation to put them
> > all into the driver on the first place.
> >
> > If you believe additional regulator elements should be removed from
> > this version of the driver - I can clean them up and come up with v2
> > here.
> >
> >>
> >> Most regulators are controlled by either the P-Unit inside the CHT SoC
> >> or through ACPI OpRegion accesses.  Luckily the regulator subsys does not
> >> expose a sysfs interface for users to directly poke regulators, but this will
> >> still make it somewhat easier for users to poke regulators which they should
> >> leave alone.
> >
> > Agree, this is a valid point. But honestly I would really be surprised
> > if a user would directly touch something which can burn his silicon to
> > pieces. Regulators are usually not approached by users; unless they
> > are really HW engineers and know what they are doing.
>
> True.
>
> Hmm, I do just realize that the regulator subsystem turns off regulators
> which are not in use from its pov, which would be kinda bad here.

Interesting point, this I did not know.

>
> It does this when the kernel is done initializing / switches to the
> initrd or directly to the rootfs. Its been a while since I've last touched
> this. Have you tried building the regulator driver (and mfd stuff and i2c
> controller, etc.) into the kernel, so that the regulators work without modules?

This is the first thing that I've tested - I've selected the new
regulator as built-in, and it is fully operable.

>
> I'm afraid that if you do that they will all get turned off, with expecting
> results... Although I guess the regulator subsystem may skip this step for
> regulators without any constrains, to be sure I would have to re-read the code.

I guess (although to 100% sure), that this is exactly the reason why
this regulator remains operable - it does have neither source nor
constraints, therefore it remains enabled.

>
> Anyways this is a serious concern which we need to resolve.
>
> >> Andrey, may I ask which device you are testing this on?
> >
> > Sure, I use the original Intel Aero board. It used to have an official
> > image from Aero team with a heavily patched 4.4.y kernel, but when I
> > decided to have this updated to the latest stable branch - I've faced
> > the issue of missing core functionality, which led me to this patch.
>
> Ah I see, the reason I was asking is because I only know of three CHT
> devices using a Whiskey Cove PMIC (instead of the AXP288, Crystal Cove or
> TI one): the GPD Win, GPD pocket and one of the Lenovo Book versions
> (the one with the CHT SoC).

I've stumbled upon those platforms, specifically when I was searching
for information about the sdmmc interface. It looks like that they all
are affected by this missing vqmmc piece, since a lot of people have
raised complaints some SD Cards are not recognized.

>
> Lets say I want to test this patch-set on one of the GPD devices,
> I guess I need an UHS-I capable card and then what should I see
> in sysfs for the mmc settings ?

This is rather trivial: with the absence of 1.8v on the interface,
UHS-I cards are failing during the speed switch sped in
initialization. If you would plug in the UHS-I SD Card in the slot,
then driver outputs the error message in dmesg:
mmc2: error -110 whilst initialising SD card

Error codes returned are either ETIMEDOUT or EILSEQ, depending on how
the SD Card controller handles improper voltages on interface.

With the patch applied, when UHS-I card is inserted, following message
in recorded in dmesg:
mmc2: new ultra high speed SDR104 SDHC card at address aaaa

SDR104 mode is only for UHS-capable cards (Grade I and above); that
message is for example recorded when SanDisk Extreme 32GB card is
inserted. I've also tested different other cards from Verbatim,
Swissbit and SanDisk, and they all were recognized OK.

BTW, as a side note: there is a way to disable 1.8v switching in mmc
sub-system via quirks2, this makes all UHS-I cards to operate as High
Speed (HS) cards at 3.3v IO level. This is rather a hack, but people
using the CHT-based products tend to do exactly that (or at least this
is a common solution proposed in Internet).

As for sysfs attributes: I actually didn't look into those to really
tell you which values for which parameters would definitely
distinguish UHS cards and settings from HS ones.

>
> Regards,
>
> Hans
>

-- 
Regards,
Andrey.
