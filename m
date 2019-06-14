Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E0C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C820B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRTBrlE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfFNAgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:36:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45341 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFNAgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:36:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id n21so655448vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kvz44rB7tgJ0lFfHfKXCBCgyFSEqMN4h+J2Mv3vvphI=;
        b=YRTBrlE2LA8uxN3PfDev4WOSZ4TCRgathqM3/1KwUpGO755YbZ7mnN+QeS3kbrUx+m
         Z4HBVjV4H2pV1hTuQOtYcKJkpVd8+sXJdy4ASJAr8xzPotDqIxxySu2jgYytgEpTQ0vq
         Bl7zFudutTrWJYi7GuLOXu6X27Uc6/ypFvM9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kvz44rB7tgJ0lFfHfKXCBCgyFSEqMN4h+J2Mv3vvphI=;
        b=oINeoGJn6Pa4n5bo4K+1I7Czm5Ll6GOaUKxT4yLMAVB2RucuTpkgY9fvBA1IrqzefO
         ZhSkQB5CNrN2TcBeJqePgKv3h2XxzARlf0IgN4Utewd/hR6Q53BYNyzd6qTJrAOdfkS7
         59nar5aFhnenOmIGTfcgFvgB0+btO1fICx8Lnn30irSbBJynEHJzbLOIenFR8DK6gxFq
         QzRqQJk6uGlDcKhTcnvodmevjm4Acw/4VXCeKkVEycOLOIbWrge6FMluKHPttM0KybF+
         bQkIJK07ALYvNUEP7vW4vENGIe2Clg+8AX5d7mlDBg1T10lDFgiMZ2ZzA9+Zii1sTCjs
         NBrw==
X-Gm-Message-State: APjAAAWpdLJShgqSERAspcZUd3zXJGsGPt5oqLBKg3AbOhu//4RHE0uI
        /Yi0mvAiSo/tsTGVbVQUIbfyO7+B6esD/LFKKF/bRg==
X-Google-Smtp-Source: APXvYqwTL6POXul88bkWpISrGlVLaKAoVDJaFXMv89Ef1GdZT2k2cGQZJDTzBLr/6j7plsyb3Poj9HWMfiJa4fFKTHk=
X-Received: by 2002:a67:ea42:: with SMTP id r2mr40062385vso.207.1560472604694;
 Thu, 13 Jun 2019 17:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-5-dbasehore@chromium.org> <87zhmoy270.fsf@intel.com>
 <01636500-0be5-acf8-5f93-a57383bf4b20@redhat.com> <CAGAzgsoxpsft-vmVOuKSAbLJqR-EZvcceLpMeWkz6ikJEKGJHg@mail.gmail.com>
 <fe774952-6fd5-b4ec-56c9-32fd30546313@redhat.com>
In-Reply-To: <fe774952-6fd5-b4ec-56c9-32fd30546313@redhat.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 13 Jun 2019 17:36:33 -0700
Message-ID: <CAGAzgsrYAaHTuxpt2rQAVbCtx_fCZAd99hX19H4V4h6ZyHwbkw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/connector: Split out orientation quirk detection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 5:33 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12-06-19 02:16, dbasehore . wrote:
> > On Tue, Jun 11, 2019 at 1:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 11-06-19 10:08, Jani Nikula wrote:
> >>> On Mon, 10 Jun 2019, Derek Basehore <dbasehore@chromium.org> wrote:
> >>>> This removes the orientation quirk detection from the code to add
> >>>> an orientation property to a panel. This is used only for legacy x86
> >>>> systems, yet we'd like to start using this on devicetree systems where
> >>>> quirk detection like this is not needed.
> >>>
> >>> Not needed, but no harm done either, right?
> >>>
> >>> I guess I'll defer judgement on this to Hans and Ville (Cc'd).
> >>
> >> Hmm, I'm not big fan of this change. It adds code duplication and as
> >> other models with the same issue using a different driver or panel-type
> >> show up we will get more code duplication.
> >>
> >> Also I'm not convinced that devicetree based platforms will not need
> >> this. The whole devicetree as an ABI thing, which means that all
> >> devicetree bindings need to be set in stone before things are merged
> >> into the mainline, is done solely so that we can get vendors to ship
> >> hardware with the dtb files included in the firmware.
> >
> > We've posted fixes to the devicetree well after the initial merge into
> > mainline before, so I don't see what you mean about the bindings being
> > set in stone.
>
> That was just me repeating the official party line about devicetree.
>
> > I also don't really see the point. The devicetree is in
> > the kernel. If there's some setting in the devicetree that we want to
> > change, it's effectively the same to make the change in the devicetree
> > versus some quirk setting. The only difference seems to be that making
> > the change in the devicetree is cleaner.
>
> I agree with you that devicetree in practice is easy to update after
> shipping. But at least whenever I tried to get new bindings reviewed
> I was always told that I was not allowed to count on that.
>
> >> I'm 100% sure that there is e.g. ARM hardware out there which uses
> >> non upright mounted LCD panels (I used to have a few Allwinner
> >> tablets which did this). And given my experience with the quality
> >> of firmware bundled tables like ACPI tables I'm quite sure that
> >> if we ever move to firmware included dtb files that we will need
> >> quirks for those too.
> >
> > Is there a timeline to start using firmware bundled tables?
>
> Nope, as I said "if we ever move to ...".
>
> > Since the
> > quirk code only uses DMI, it will need to be changed anyways for
> > firmware bundled devicetree files anyways.
> >
> > We could consolidate the duplicated code into another function that
> > calls drm_get_panel_orientation_quirks too. The only reason it's like
> > it is is because I initially only had the call to
> > drm_get_panel_orientation_quirk once in the code.
>
> Yes if you can add a new helper for the current callers, then
> I'm fine with dropping the quirk handling from
> drm_connector_init_panel_orientation_property()
>

Ok, it sounds like having a special callback for quirks in the panel
orientation property is the best way to go. The handles the duplicate
code and devicetree bundles. If we need to fix something that's
specified in a devicetree, and we aren't willing to change it, we can
write the quirk code for that later.

> Regards,
>
> Hans

Thanks for the feedback
