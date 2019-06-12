Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C667C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ED321721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bz8o81L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406325AbfFLAQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:16:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46131 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFLAQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:16:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id l125so9106459vsl.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 17:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfO9F8KZrr8f2zYzYCRkN8MSxrGxIaN330Tf5LK87fo=;
        b=bz8o81L6+cYm2ngvHqapE8gu1XLoSuCnuYhH0SUdUtpksRCuF2SsLGGes/2mwR9s2S
         RM6CKjQmDnezF8ApAw0fUBxHfpZUgPHC2pLNBvJvyZMVy7pv167DASrNvojG8XTA8BZy
         F4JG4+AytDmmTtNdNUxLuH24pkHO8bPHRfy5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfO9F8KZrr8f2zYzYCRkN8MSxrGxIaN330Tf5LK87fo=;
        b=fHgXfaTuw8VIhAtL8qHyKZbhQ81asmSvB2Qnfl5XzC9U1DftFEPBjMosS8Dcn8sUmS
         9OtV32AVcjBHttgdk9m1BYUmmObQufZkxeL2TSPihPbTbA9OJQr4uZrokgAIvxQRt7Uj
         ap5RnZjuRV1QKUqh1v7XuwPp89lBFfe5WhisYNRX4NUQNvm3SHLvv83KrlSJJWjbKV49
         NDSbaO1AOMbGc3yIsqNk2mU2m7TChJVB5eBItHOg0+VIOhur8nSvreSQYXTi/+5jyQbG
         iEBh2HHOuasl8zrFtlc2lFiLAbj7wqnI+7K98tlgW6f7FUQ4LRSj8CvajFDBtYA3oy5W
         U//g==
X-Gm-Message-State: APjAAAW87ZYl2qj8eazNrdBTjDUbm6Belwg946OYJUlb6LSehUfl3sZY
        th25D6HPnegXS6+3cxxR0E6n5+6VaUhWzbCCRr44BA==
X-Google-Smtp-Source: APXvYqxUOzD8AqvvcWDf7lhY9Uveg285+W4sY5GBDN/I9hYwTGaKY8nKDHt/xqKW6AbgISVYKcf5oBcbdbGd+wCWdEY=
X-Received: by 2002:a67:8e01:: with SMTP id q1mr44148432vsd.1.1560298611160;
 Tue, 11 Jun 2019 17:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-5-dbasehore@chromium.org> <87zhmoy270.fsf@intel.com> <01636500-0be5-acf8-5f93-a57383bf4b20@redhat.com>
In-Reply-To: <01636500-0be5-acf8-5f93-a57383bf4b20@redhat.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Tue, 11 Jun 2019 17:16:40 -0700
Message-ID: <CAGAzgsoxpsft-vmVOuKSAbLJqR-EZvcceLpMeWkz6ikJEKGJHg@mail.gmail.com>
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

On Tue, Jun 11, 2019 at 1:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11-06-19 10:08, Jani Nikula wrote:
> > On Mon, 10 Jun 2019, Derek Basehore <dbasehore@chromium.org> wrote:
> >> This removes the orientation quirk detection from the code to add
> >> an orientation property to a panel. This is used only for legacy x86
> >> systems, yet we'd like to start using this on devicetree systems where
> >> quirk detection like this is not needed.
> >
> > Not needed, but no harm done either, right?
> >
> > I guess I'll defer judgement on this to Hans and Ville (Cc'd).
>
> Hmm, I'm not big fan of this change. It adds code duplication and as
> other models with the same issue using a different driver or panel-type
> show up we will get more code duplication.
>
> Also I'm not convinced that devicetree based platforms will not need
> this. The whole devicetree as an ABI thing, which means that all
> devicetree bindings need to be set in stone before things are merged
> into the mainline, is done solely so that we can get vendors to ship
> hardware with the dtb files included in the firmware.

We've posted fixes to the devicetree well after the initial merge into
mainline before, so I don't see what you mean about the bindings being
set in stone. I also don't really see the point. The devicetree is in
the kernel. If there's some setting in the devicetree that we want to
change, it's effectively the same to make the change in the devicetree
versus some quirk setting. The only difference seems to be that making
the change in the devicetree is cleaner.

>
> I'm 100% sure that there is e.g. ARM hardware out there which uses
> non upright mounted LCD panels (I used to have a few Allwinner
> tablets which did this). And given my experience with the quality
> of firmware bundled tables like ACPI tables I'm quite sure that
> if we ever move to firmware included dtb files that we will need
> quirks for those too.

Is there a timeline to start using firmware bundled tables? Since the
quirk code only uses DMI, it will need to be changed anyways for
firmware bundled devicetree files anyways.

We could consolidate the duplicated code into another function that
calls drm_get_panel_orientation_quirks too. The only reason it's like
it is is because I initially only had the call to
drm_get_panel_orientation_quirk once in the code.


>
> Also calling this "used only for legacy x86 systems" is a bit
> unfair IMHO, new UEFI models are still being added to the quirk list
> today, for hardware which does not even ship yet. Actually 99%
> of the models in the quirk list are UEFI only models, which do
> not even support classic PC BIOS booting, so those systems are
> anything but legacy.
>
> I believe the only reason we have only had to deal with this on x86
> so far is because the OOTB support for most ARM systems is less polished
> then that for x86 systems and on ARM systems there are still more
> important issues to tackle first.

ARM just handles it in a different way. I'm not exactly sure how more
of the Android tablets do this, but it might just be handled entirely
in userspace with rotated splash screens on boot (so a device with a
180 degree panel has an upside down splash screen).

>
> Regards,
>
> Hans
>
>
>
>
>
>
> >
> > Side note, I'm about to apply some (minor) conflicting changes in our
> > -next as soon as I get CI results on it.
> >
> >
> > BR,
> > Jani.
> >
> >
> >>
> >> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> >> ---
> >>   drivers/gpu/drm/drm_connector.c | 16 ++++------------
> >>   drivers/gpu/drm/i915/intel_dp.c | 14 +++++++++++---
> >>   drivers/gpu/drm/i915/vlv_dsi.c  | 14 ++++++++++----
> >>   include/drm/drm_connector.h     |  2 +-
> >>   4 files changed, 26 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> >> index e17586aaa80f..58a09b65028b 100644
> >> --- a/drivers/gpu/drm/drm_connector.c
> >> +++ b/drivers/gpu/drm/drm_connector.c
> >> @@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
> >>    * drm_connector_init_panel_orientation_property -
> >>    * initialize the connecters panel_orientation property
> >>    * @connector: connector for which to init the panel-orientation property.
> >> - * @width: width in pixels of the panel, used for panel quirk detection
> >> - * @height: height in pixels of the panel, used for panel quirk detection
> >>    *
> >>    * This function should only be called for built-in panels, after setting
> >>    * connector->display_info.panel_orientation first (if known).
> >>    *
> >> - * This function will check for platform specific (e.g. DMI based) quirks
> >> - * overriding display_info.panel_orientation first, then if panel_orientation
> >> - * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
> >> - * "panel orientation" property to the connector.
> >> + * This function will check if the panel_orientation is not
> >> + * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "panel
> >> + * orientation" property to the connector.
> >>    *
> >>    * Returns:
> >>    * Zero on success, negative errno on failure.
> >>    */
> >>   int drm_connector_init_panel_orientation_property(
> >> -    struct drm_connector *connector, int width, int height)
> >> +    struct drm_connector *connector)
> >>   {
> >>      struct drm_device *dev = connector->dev;
> >>      struct drm_display_info *info = &connector->display_info;
> >>      struct drm_property *prop;
> >> -    int orientation_quirk;
> >> -
> >> -    orientation_quirk = drm_get_panel_orientation_quirk(width, height);
> >> -    if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> >> -            info->panel_orientation = orientation_quirk;
> >>
> >>      if (info->panel_orientation == DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> >>              return 0;
> >> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> >> index b099a9dc28fd..72ab090ea97a 100644
> >> --- a/drivers/gpu/drm/i915/intel_dp.c
> >> +++ b/drivers/gpu/drm/i915/intel_dp.c
> >> @@ -40,6 +40,7 @@
> >>   #include <drm/drm_edid.h>
> >>   #include <drm/drm_hdcp.h>
> >>   #include <drm/drm_probe_helper.h>
> >> +#include <drm/drm_utils.h>
> >>   #include <drm/i915_drm.h>
> >>
> >>   #include "i915_debugfs.h"
> >> @@ -7281,9 +7282,16 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
> >>      intel_connector->panel.backlight.power = intel_edp_backlight_power;
> >>      intel_panel_setup_backlight(connector, pipe);
> >>
> >> -    if (fixed_mode)
> >> -            drm_connector_init_panel_orientation_property(
> >> -                    connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
> >> +    if (fixed_mode) {
> >> +            int orientation = drm_get_panel_orientation_quirk(
> >> +                            fixed_mode->hdisplay, fixed_mode->vdisplay);
> >> +
> >> +            if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> >> +                    connector->display_info.panel_orientation =
> >> +                            orientation;
> >> +
> >> +            drm_connector_init_panel_orientation_property(connector);
> >> +    }
> >>
> >>      return true;
> >>
> >> diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
> >> index bfe2891eac37..27f86a787f60 100644
> >> --- a/drivers/gpu/drm/i915/vlv_dsi.c
> >> +++ b/drivers/gpu/drm/i915/vlv_dsi.c
> >> @@ -30,6 +30,7 @@
> >>   #include <drm/drm_crtc.h>
> >>   #include <drm/drm_edid.h>
> >>   #include <drm/drm_mipi_dsi.h>
> >> +#include <drm/drm_utils.h>
> >>
> >>   #include "i915_drv.h"
> >>   #include "intel_atomic.h"
> >> @@ -1650,6 +1651,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
> >>
> >>      if (connector->panel.fixed_mode) {
> >>              u32 allowed_scalers;
> >> +            int orientation;
> >>
> >>              allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
> >>              if (!HAS_GMCH(dev_priv))
> >> @@ -1660,12 +1662,16 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
> >>
> >>              connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
> >>
> >> -            connector->base.display_info.panel_orientation =
> >> -                    vlv_dsi_get_panel_orientation(connector);
> >> -            drm_connector_init_panel_orientation_property(
> >> -                            &connector->base,
> >> +            orientation = drm_get_panel_orientation_quirk(
> >>                              connector->panel.fixed_mode->hdisplay,
> >>                              connector->panel.fixed_mode->vdisplay);
> >> +            if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> >> +                    connector->base.display_info.panel_orientation = orientation;
> >> +            else
> >> +                    connector->base.display_info.panel_orientation =
> >> +                            vlv_dsi_get_panel_orientation(connector);
> >> +
> >> +            drm_connector_init_panel_orientation_property(&connector->base);
> >>      }
> >>   }
> >>
> >> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> >> index 47e749b74e5f..c2992f7a0dd5 100644
> >> --- a/include/drm/drm_connector.h
> >> +++ b/include/drm/drm_connector.h
> >> @@ -1370,7 +1370,7 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
> >>   void drm_connector_set_vrr_capable_property(
> >>              struct drm_connector *connector, bool capable);
> >>   int drm_connector_init_panel_orientation_property(
> >> -    struct drm_connector *connector, int width, int height);
> >> +    struct drm_connector *connector);
> >>   int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
> >>                                        int min, int max);
> >
