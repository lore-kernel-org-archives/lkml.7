Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27EC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06112184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezQW1HqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGCRzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:55:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39111 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfGCRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:55:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3347658wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC3yaTa9Zv23N3R7uNs2zkiGKU8tLMgZakv4khIWziI=;
        b=ezQW1HqYiasnn2IejNRSlbVBL00j/KJXgBYKahj9Jo2znBoOvxVWiKvvWn1kP5zH/E
         gZGYtb1Osr1Yk6J/M1XBG5qIXvrR5YeWSDaxC7pQdBWKPZjlouT/TgmCYEK6Gak6VGqJ
         1NGu1wIePcRZSuqvoHg4adXXiBu5AYc+rtqUDobIb0lzGBLUZ9RRFiI2zfVfFJl35hEF
         E2l5IjU5yRZk5hVrLMgUo1qusJ5j2cGpeB1uDfuAJPOtlMb8DrglYtskifpYDUcxhxjp
         ItYuWOwrSt86OS+F1Wz4MAVxOe7XjoVim7XLXelwDDfdY9djS8avS8SpvEm1S8eF/gA6
         MjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC3yaTa9Zv23N3R7uNs2zkiGKU8tLMgZakv4khIWziI=;
        b=jvOmxLYA1nmx9iRNJrHLy/3vXhyXUpIU2R3gsC4ZExlFgECW2uYn0ISjFrM33sgSa1
         RV7Itd5fKjQeOxRebEHn78Y3wocog8LiaCnZwMEApIkoEXkS3OGydDg6Z12gaG7P4xLx
         ND+avrbjDk7sLsgHFvCyKdpA+Iu3GtpQGl/u5DGf7v8iWRDsXhehiIx3obHgclK2RpxC
         z+Ulwp7BbC2NrppBUZOVdhygmlKC03gpyBvQrEWHhUSFIxMtUH/47uiQKSrzx1FPDFUE
         8+T2RS0YuJQXRDMWxQ0coCySi3LipeLEq0EEQWGmFGYEkuRggD4D7OnLXDoyCTD1FRzz
         0spw==
X-Gm-Message-State: APjAAAWyEic+UpN6qOx5h03p9VkTa2FKU5ke1quUE5ivkAHC88/pJrky
        UYOuhtt31YJaYYWM2HqcXBQqPFp1xxjtPUQzJ4WVTQ==
X-Google-Smtp-Source: APXvYqzZS1NTKUToA2Buor/C5A6sez5Obmg98g9LIv8BmymHB5yzHcyQ7kuI9IMQNbSf7XPpkIKZWVJEd2k4U83H2/k=
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr8249422wmh.136.1562176498161;
 Wed, 03 Jul 2019 10:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630203614.5290-3-robdclark@gmail.com>
 <CAKv+Gu_8BOt+f8RTspHo+se-=igZba1zL0+jWLV2HuuUXCKYpA@mail.gmail.com>
 <CAKv+Gu-KhPJxxJA3+J813OPcnoAD4nHq6MhiRTJSd_5y1dPNnw@mail.gmail.com>
 <CAF6AEGv+uAXVV6Q78n=jP0YRDjYn9OS=Xec9MU0+_7EBirxF5w@mail.gmail.com>
 <20190702215953.wdqges66hx3ge4jr@bivouac.eciton.net> <CAF6AEGvm62rcm4Lp4a+QmqFweVQ0QWXLDoN2CP8=40BdwiiVbQ@mail.gmail.com>
 <20190703163311.gtbo72dzpkpjvpi5@bivouac.eciton.net> <CAF6AEGtL2hJ0poNY9yK7vBxc9-zoY5AeZqKsVoJvxbBwM_yrGw@mail.gmail.com>
In-Reply-To: <CAF6AEGtL2hJ0poNY9yK7vBxc9-zoY5AeZqKsVoJvxbBwM_yrGw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 3 Jul 2019 19:54:42 +0200
Message-ID: <CAKv+Gu87OJhYY3j0gmx9MgfWP-5fsaUqWFdAJNeJ-RwwXCau-g@mail.gmail.com>
Subject: Re: [PATCH 2/4] efi/libstub: detect panel-id
To:     Rob Clark <robdclark@gmail.com>
Cc:     Leif Lindholm <leif.lindholm@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 at 19:41, Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Jul 3, 2019 at 9:33 AM Leif Lindholm <leif.lindholm@linaro.org> wrote:
> >
> > On Tue, Jul 02, 2019 at 03:48:48PM -0700, Rob Clark wrote:
> > > > > There is one kernel, and there
> > > > > are N distro's, so debugging a users "I don't get a screen at boot"
> > > > > problem because their distro missed some shim patch really just
> > > > > doesn't seem like a headache I want to have.
> > > >
> > > > The distros should not need to be aware *at all* of the hacks required
> > > > to disguise these platforms as DT platforms.
> > > >
> > > > If they do, they're already device-specific installers and have
> > > > already accepted the logistical/support nightmare.
> > >
> > > I guess I'm not *against* a DT loader shim populating the panel-id
> > > over into /chosen.. I had it in mind as a backup plan.  Ofc still need
> > > to get dt folks to buy into /chosen/panel-id but for DT boot I think
> > > that is the best option.  (At least the /chosen/panel-id approach
> > > doesn't require the shim to be aware of how the panel is wired up to
> > > dsi controller and whether their is a bridge in between, and that
> > > short of thing, so the panel-id approach seems more maintainable that
> > > other options.)
> >
> > I am leaning like Ard towards preferring a configuration table though.
>
> Ok, if you want the DT loader to propagate UEFIDisplayInfo to a config
> table, I can update the drm parts of my patchset to look for that in
> addition to /chosen/panel-id
>
> > That removes the question of no runtime services (needing to manually
> > cache things, at least until EBBR 1.2 (?) is out and in use), and
> > means we don't have to use different paths for DT and ACPI. Now we
> > have UEFI in U-Boot, do we really need to worry about the non-UEFI
> > case?
>
> I've mixed feelings about requiring UEFI..  I definitely want to give
> qcom an incentive to turn on GOP and full UEFI boot for future android
> devices.  OTOH there are quite a few devices out there that aren't
> UEFI boot.  But I guess if drm falls back to /chosen/panel-id we are
> covered.
>
> > > I am a bit fearful of problems arising from different distros and
> > > users using different versions of shim, and how to manage that.  I
> > > guess if somehow "shim thing" was part of the kernel, there would by
> > > one less moving part...
> >
> > Sure, but that's insurance against bindings changing
> > non-backwards-compatibly - which there are ways to prevent, and which
> > streamlining the design for really isn't the way to discourage...
> >
> > Distros have no need to worry about the DT loader - the whole point of
> > it is to remove the need for the distro to worry about anything other
> > than getting the required drivers in.
>
> I'm a bit more concerned about DT loader getting into the business of
> DT fixup..  I guess if we don't do that, it is less of a concern.  But
> if we relied on it to fixup DT for installed panel, we could probably
> make it work semi-generically on existing devices that have bridge and
> panel wired up same way.  But seems like some of the 835 laptops have
> bridge hooked up as child of dsi bus instead.  And someday we could
> see devices using dsi directly, etc.
>
> (It would be really nice to see DT loader able to pick the correct
> .dtb based on smbios tables tho ;-).. but maybe different topic)
>

I think this is the only sane way of doing things: the DT loader,
which is tied much more closely to the platform, does whatever it
needs to do to infer from UEFI variables and/or ACPI or SMBIOS tables
which bundled DT it installs, and whether/how it needs to fix things
up. This indeed constitutes a moving part separate from the OS, but
this is the only way that scales. Getting DTs for these devices into
distros is *not* what we should be doing.

> > > I'd know if user had kernel vX.Y.Z they'd be
> > > good to go vs not.  But *also* depending on a new-enough version of a
> > > shim, where the version # is probably not easily apparent to the end
> > > user, sounds a bit scary from the "all the things that can go wrong"
> > > point of view.  Maybe I'm paranoid, but I'm a bit worried about how to
> > > manage that.
> >
> > Until the hardware abstractions provided by the system firmware (ACPI)
> > is supported, these platforms are not going to be appropriate for
> > end users anyway. No matter how many not-quite-upstream hacks distros
> > include, they won't be able to support the next minor spin that comes
> > off the production line and is no longer compatible with existing DTs.
>
> yeah, that will be a problem.. and also switching to older kernel
> after upgrading when in-flight dt bindings evolve.  Having one less
> moving part would be nice.
>

The whole point of the discussion we have been having for years is
that for production use cases, we should not be dealing with evolving
in-flight DT binding in the first place. If we ship a DT loader with a
certain version of the binding and there is a need to change it, we
can only do so if we retain support for the old binding as well.

> Maybe if adding a config table for UEFIDisplayInfo, you could also add
> one for DT loader version, so (at least if user is able to get far
> enough to get dmesg) we could see that more easily?
>

I'd prefer it if the DT loader were in charge of creating the
UEFIDisplayInfo config tables, but given that we'll need to deal with
platforms that don't implement runtime variable services, it is
something I would be able to live with in the stub.

In summary, working around platform limitations that prevent us from
delivering an accurate DT to the OS should preferably be addressed in
a platform specific pre-OS component. I haven't had the chance to look
at leif's code yet, but from what I understand, we have pretty much
what we need with the exception of the panel/gop variable handling,
no?
