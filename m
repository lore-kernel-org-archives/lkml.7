Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F26C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCCF206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H82LxDw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfGaGsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:48:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46385 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfGaGsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:48:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id 65so49908944oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARnp264mkg+vgDR6aFa4bBRucWQsk31TmXFK/mhGmEk=;
        b=H82LxDw7HMx7ygKOffo5s8yWCSN6dY4VOpCLsGRzZrlBCx5t353Bt8Rq+NPQVkGoNz
         vM3csQFuzdGmBeydRm3AB6oPWWU7zBtV0+k+FOhzXjR+UvwApAGdOHY6M8DbA9+cNtVj
         edPp3Ljlevuif8zlC9YcrxXgbQu8bLtl1Zs9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARnp264mkg+vgDR6aFa4bBRucWQsk31TmXFK/mhGmEk=;
        b=T2fXt7BG3fj4nSNcor5l+OE+Pb0Qq0x3WX18vSY7QQiNJjfnph4ND11mVDgMLw1I/K
         Ba+moy/eh+Jj+DM5r5NURh4Qx2wf8BRR7uRYmLv/gUdn6DcL4CTId0mgADIcQD6WmPmC
         YdIXkvcPgDpYvvisjIASfyXNIP/WCV9fl89KVdLEIA4jpQrIklQyVR29bVwK5S10hOfC
         OcsU7wDHaWJ2k2QEWUqNTsHMF1ZE10iO95m8ATjFNXVkHcbL0IajaOXVpn9HG6ePJn3Q
         oVQfXTr2tMnGpVlAjcfjr1w4wVAYrhbmQVl/+N29DLj+yyRf1rnYSn9T5sC8lxmKwvwZ
         /xOg==
X-Gm-Message-State: APjAAAVbTEjR9RaPcr8cOA1Vzshpx0ZBdbiNUUNJvtHXhaKYpQroAJVz
        DyFNIGwuOMbQhwNhCOq+hrf2QH2fbZ3mIxr8+TorMbna
X-Google-Smtp-Source: APXvYqwibNpJ4B+gxLsp1aCDzwWOmzTecymwjL88p7TCiSZWKUa7MqXOSei/T/zegrVtPunGBi5T5zXsy4pZnLoHldU=
X-Received: by 2002:aca:5403:: with SMTP id i3mr57252625oib.132.1564555681258;
 Tue, 30 Jul 2019 23:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
 <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net> <20190730140852.GB12424@arch-x1c3>
 <52212fa4-e396-29c4-e5d2-07fbb371c302@jaseg.net> <20190730164926.GD14551@arch-x1c3>
 <fa70f88e-6c18-26fb-83c0-18528acb12ce@jaseg.net>
In-Reply-To: <fa70f88e-6c18-26fb-83c0-18528acb12ce@jaseg.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 31 Jul 2019 08:47:50 +0200
Message-ID: <CAKMK7uE5DXyuek2VSdbd_fNBAW4sXbhXgVMUky1pt_GZp87cng@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm: uapi: add gdepaper uapi header
To:     =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.net>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 4:01 AM Jan Sebastian G=C3=B6tte <linux@jaseg.net> =
wrote:
>
> On 7/31/19 1:49 AM, Emil Velikov wrote:
> > On 2019/07/31, Jan Sebastian G=C3=B6tte wrote:
> >> Hi Emil,
> >>
> >> thank you for your comments.
> >>
> >> On 7/30/19 11:08 PM, Emil Velikov wrote:
> >>> On 2019/07/30, Jan Sebastian G=C3=B6tte wrote:
> >>>> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.net>
> >>>> ---
> >>>>  include/uapi/drm/gdepaper_drm.h | 62 ++++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 62 insertions(+)
> >>>>  create mode 100644 include/uapi/drm/gdepaper_drm.h
> >>>>
> >>>> diff --git a/include/uapi/drm/gdepaper_drm.h b/include/uapi/drm/gdep=
aper_drm.h
> >>>> new file mode 100644
> >>>> index 000000000000..84ff6429bef5
> >>>> --- /dev/null
> >>>> +++ b/include/uapi/drm/gdepaper_drm.h
> >>>> @@ -0,0 +1,62 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> >>>> +/* gdepaper_drm.h
> >>>> + *
> >>>> + * Copyright (c) 2019 Jan Sebastian G=C3=B6tte
> >>>> + */
> >>>> +
> >>> I'm glad to see more devices using upstream KMS interface. Usually
> >>> custom UAPI should not be needed for such devices.
> >>>
> >>> Can you elaborate why this is required? Is there an open-source
> >>> userspace that uses these?
> >>
> >> Not yet. I added this API because I couldn't figure out a way to do th=
at in KMS. What I need is some way for userspace to tell the driver paramet=
ers for the display refresh (driving waveforms, refresh speed etc.) on a fr=
ame-by-frame basis. These parameters depend on ambient temperature and the =
displayed content. One has to trade off speed, ghosting and the number of p=
ossible partial refreshes until next full one.
> >>
> >> Usually, epaper display refresh all pixels at once like an LCD would. =
This takes about 15s of flickering for b/w/red displays. Since they're bist=
able, they can also only physically refresh part of the area though. The re=
ason for not having that on-by-default is that epaper partial refresh is re=
ally tricky. If you refresh the same area partially a few times, charge bui=
lds up, image quality degrades and the picture starts bleeding. If you refr=
esh the same area partially all the time and don't do enough full refresh c=
ycles to balance charges again, eventually the display is going to get perm=
anent burn-in. I think partial refresh should be supported by a driver like=
 this since it's a good tool to alleviate the enormous full refresh times.
> >>
> >> For partial hardware refresh you have to customize all these values an=
d the waveform LUTs depending on the displayed content. For example you mig=
ht want a LUT specifying more inversion cycles for text display to reduce g=
hosting, or one with less cycles but higher voltages for some spinning load=
ing animation to reduce flickering. If you are displaying a loading bar you=
 might be able to get away with a high drive strength since you know it's g=
oing to be done in a few frames, but if you display e.g. a text console you=
 might want to reduce drive strength to do as many partial updates as possi=
ble before the next full refresh, to reduce flicker.
> >>
> >> I think what one would like to do from userspace here is along the lin=
es of:
> >> * set voltages depending on content
> >> * set waveforms depending on content
> >> * write framebuffer
> >> * (optional) trigger partial refresh of affected areas
> >>
> >> You can get the display up and running with some default values and th=
e factory-programmed OTP LUTs using full hardware refresh, but if you try p=
artial hardware refresh with those you get a irrecognizable mess.
> >>
> >>>> +#ifndef _UAPI_GDEPAPER_DRM_H_
> >>>> +#define _UAPI_GDEPAPER_DRM_H_
> >>>> +
> >>>> +#include "drm.h"
> >>>> +
> >>>> +#if defined(__cplusplus)
> >>>> +extern "C" {
> >>>> +#endif
> >>>> +
> >>>> +enum drm_gdepaper_vghl_lv {
> >>>> +  DRM_GDEP_PWR_VGHL_16V =3D 0,
> >>>> +  DRM_GDEP_PWR_VGHL_15V =3D 1,
> >>>> +  DRM_GDEP_PWR_VGHL_14V =3D 2,
> >>>> +  DRM_GDEP_PWR_VGHL_13V =3D 3,
> >>>> +};
> >>>> +
> >>>> +struct gdepaper_refresh_params {
> >>>> +  enum drm_gdepaper_vghl_lv vg_lv; /* gate voltage level */
> >>> From my experience, kernel drivers aim to avoid exposing voltage cont=
rol
> >>> to userspace. AFAICT exceptions are present, but generally it's a no-=
go
> >> I agree with that. FWIW, in this draft these properties are exposed th=
rough a DRM_ROOT_ONLY ioctl.
> >>
> >>>> +  __u32 vcom_sel; /* VCOM select bit according to datasheet */
> >>>> +  __s32 vdh_bw_mv; /* drive high level, b/w pixel (mV) */
> >>>> +  __s32 vdh_col_mv; /* drive high level, red/yellow pixel (mV) */
> >>>> +  __s32 vdl_mv; /* drive low level (mV) */
> >>>> +  __s32 vcom_dc_mv;
> >>>> +  __u32 vcom_data_ivl_hsync; /* data ivl len in hsync periods */
> >>>> +  __u32 border_data_sel; /* "vbd" in datasheet */
> >>>> +  __u32 data_polarity; /* "ddx" in datasheet */
> >>> These properties look like they should live in the device-tree bindin=
gs.
> >>
> >> On init they are loaded from dt, but they can be overwritten via ioctl=
. This would be necessary for anything using the display's partial hardware=
 refresh feature and might change frame-by-frame.
> >>
> >>>> +  __u32 use_otp_luts_flag; /* Use OTP LUTs */
> >>>> +  __u8 lut_vcom_dc[44];
> >>>> +  __u8 lut_ww[42];
> >>>> +  __u8 lut_bw[42];
> >>>> +  __u8 lut_bb[42];
> >>>> +  __u8 lut_wb[42];
> >>> There is UAPI to manage LUT (or was it WIP with patches on the list) =
via
> >>> the atomic API. Is that not flexible enough for your needs?
> >>
> >> I had a look around, and I found something in uapi/drm/drm_mode.h for =
color LUTs. This isn't color LUTs though. The vendor should really have cal=
led them "waveform tables". They basically contain a list of voltage levels=
 a pixel transitioning white-black, white-red etc. should be driven at. The=
 format seems to be standardized across different driver chips, but I'd rea=
lly treat them as device-dependent binary blobs since for some chips they'r=
e not even specified and there's no guarantee the format won't suddenly cha=
nge for some new chip.
> >>
> >>>> +};
> >>>> +
> >>>> +/* Force a full display refresh */
> >>>> +#define DRM_GDEPAPER_FORCE_FULL_REFRESH           0x00
> >>>> +#define DRM_GDEPAPER_GET_REFRESH_PARAMS           0x01
> >>>> +#define DRM_GDEPAPER_SET_REFRESH_PARAMS           0x02
> >>>> +#define DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN        0x03
> >>>> +
> >>>> +#define DRM_IOCTL_GDEPAPER_FORCE_FULL_REFRESH \
> >>>> +  DRM_IO(DRM_COMMAND_BASE + DRM_GDEPAPER_FORCE_FULL_REFRESH)
> >>>> +#define DRM_IOCTL_GDEPAPER_GET_REFRESH_PARAMS \
> >>>> +  DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_GET_REFRESH_PARAMS, \
> >>>> +  struct gdepaper_refresh_params)
> >>>> +#define DRM_IOCTL_GDEPAPER_SET_REFRESH_PARAMS \
> >>>> +  DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_REFRESH_PARAMS, \
> >>>> +  struct gdepaper_refresh_params)
> >>>> +#define DRM_IOCTL_GDEPAPER_SET_PARTIAL_UPDATE_EN \
> >>>> +  DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN, __=
u32)
> >>>> +
> >>> Similarly to the LUT above, the atomic UAPI has support for partial
> >>> updates. The property is called FB_DAMAGE_CLIPS and there is an examp=
le
> >>> in weston how to use it see 009b3cfa6f16bb361eb54efcc7435bfede4524bc.
> >>
> >> I do already have support for that. The partial_update_en flag here co=
ntrols whether the partial hardware refresh is used to implement that. The =
force_full_refresh thing would be useful to do the periodic (every 10hrs) r=
efresh required by the display's specs without having to re-render the cont=
ent.
> >>
> > Correct me if I'm wrong, so it sounds like at least the full refresh is
> > a decision that can and should in the kernel? After all we don't need
> > an ioctl if it's a trivial "wait 10h, full refresh".
>
> I think I might remove this then, and instead have a timeout on updates. =
If userspace doesn't update for x hours, kernel forces a refresh. Then, use=
rspace can still manage this if necessary with a full redraw.
>
> > With regards to the other properties, what heuristic are you using to
> > adjust the parameters? Perhaps it's better to expose the decision itsel=
f
> > to the kernel module?
>
> I think my problem is I don't have a heuristic yet. I think you'd use som=
ething like [0] here. My issue putting that into kernel is that I don't und=
erstand it well enough to be confident this is all anybody would ever need.

In that case I'm suggesting we experiment around a lot first in the
kernel to improve this. The trouble with uapi is it's forever, kernel
driver heuristics can be changed much easier. If you want to have it
easier for experimentation then I think the right uapi is probably
going to be a custom drm_fourcc.h, with one plane containing the
white/black/red values (so 2 bits per pixel), and the 2nd plane
containing all the information for partial update. But that would just
be a patch you're carrying locally for quick development of
heuristics.

For these partial update heuristics I think a good starting point
would be to wire up the damage stuff, and default to full refresh for
full frame updates.

Just throwing this in as an idea.
-Daniel

> > This way, the kernel can change voltages and perform sanity checks (rat=
e
> > limit, temperature, etc.) instead of "blindly" damaging the hardware.
>
> I wouldn't know how to come up with safe boundaries for such checks. The =
vendor's datasheets are not much of a help. They basically say "don't devia=
te from our defaults for too long", but then there's others[1] who totally =
do deviate without a problem. The built-in hardware limits seem to be sensi=
ble. This patch configures both the b/w high drive voltage and the b/w/r lo=
w drive voltage to maximums (+/-11.0V) according to an example from the ven=
dor, and it's working fine.
>
> Maybe a way to go at this would be to have a set of parameter presets in =
dt along with limits (full refresh at least every x seconds, full refresh a=
t least every x partial refreshes, etc.), and allow userspace to select one=
 of these presets using a drm property? This way it can still be configured=
 but and it doesn't need any ioctls.
>
> - Jan
>
> [0] https://github.com/zkarcher/FancyEPD/blob/master/FancyEPD_Demo/FancyE=
PD.cpp#L900
> [1] https://www.youtube.com/watch?v=3DMsbiO8EAsGw
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
