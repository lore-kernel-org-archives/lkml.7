Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D5AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EBE2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHlYCryy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfLEJfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:35:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35455 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLEJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:35:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so2768879lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs7MdTRDJXxfrjfj/PRNyfDVjsF99qRi7d4xsxIPdRU=;
        b=nHlYCryyIFOo8N17YCFS/TkAvuAk6fyI5SY4y6Ze6Ormx/vq2wGKe2YtpOhAhRXI6U
         +YmytvGDJBIHdFpz4TC4q7qk/wenexHaRJvv8H9GiBGn+Md0b4qfQ0xGUIJuynWAyV7B
         xwaFp8yYgxiKRggcbqR/+GFQ4s7Ah0lxUrBQoKliULvslnpXZSwftYrJIo+h4/KDp70U
         uHZ7ZNai69KUPirWAualzhuEwR9GhuZfjV+ZJgpQCSipjkev8jTivEoPetqlk2y08rgl
         8gqgq8q8d1pnSzQeYZznV9HI0GqGn+VVJnMqcnZ4qtrblsG5R0JFNVY+gyg84W3DDASE
         QfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs7MdTRDJXxfrjfj/PRNyfDVjsF99qRi7d4xsxIPdRU=;
        b=unJeA5aEFV0IhSK7DKsY1BUgwABm2oYpPqOWAA16PN69aBg3CKXG0u/14fqJUGSAcC
         SJEfr9SymucTn+0tEWdelGvcmFbXrzv+ITEp1fQ+ccZ901H5XanIJkubLbF/lYU6POrN
         mOgqXJh52iDJTtgdKIy6HwFjIpr+nvJnuUQsiKl/AmAG81GFelaIta6qbk/4vekR+Qwn
         7zlIIZE+lKJcbO6rxmuDTDaprPSJtpw+bvMZaEBb9sS0maiJ7Ewiypu6A3EIynIKb0YH
         hnnS7LWQCPdjoio2fm4aKi5FXWKp6k1c61RpNhOINNKRvtmJjDn4kQWL/QNXttXzQWIl
         9BuA==
X-Gm-Message-State: APjAAAX2xSr9Ti1mbQ2E7qhBl8MpRCXmgOhcthlbF0CpDFlJma0JNPH+
        iIbpMg47EHtnh0zpD6qMxOZiToXv/15dzwFEt92PRA==
X-Google-Smtp-Source: APXvYqxvcYHaD2NlZH/0DOLkj2XBzFbM/jn5VCSEQihvnkDBoi0zK3zvwV070dks246vQV5n0gCqFht/IS6SrvXHU9U=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr4416952ljg.126.1575538512259;
 Thu, 05 Dec 2019 01:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191104194147.185642-1-rajatja@google.com>
 <87wobuwqz2.fsf@intel.com>
In-Reply-To: <87wobuwqz2.fsf@intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 5 Dec 2019 01:34:33 -0800
Message-ID: <CACK8Z6HSdPY3TZZ1vwsr7YBM63veFyVwQneG-XNSM_x6L1QiLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/i915: Move the code to populate ACPI device ID
 into intel_acpi
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

Thanks for the review.

On Wed, Nov 20, 2019 at 6:41 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Mon, 04 Nov 2019, Rajat Jain <rajatja@google.com> wrote:
> > Move the code that populates the ACPI device ID for devices, into
> > more appripriate intel_acpi.c. This is done in preparation for more
> > users of this code (in next patch).
>
> I don't think your use of the code makes sense (I'll explain in reply to
> the other patches)

OK, I'll discuss this there.

> but I could be persuaded to move the code to
> intel_acpi.c.
>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Change-Id: Ifb3bd458734985c2a78ba682e6f0a2e63e0626ca
>
> Please drop Change-Ids.

Done.

>
> > ---
> > v2: v1 doesn't exist. Found existing code in i915 driver to assign the ACPI ID
> >     which is what I plan to re-use.
> >
> >
> >  drivers/gpu/drm/i915/display/intel_acpi.c     | 87 +++++++++++++++++++
> >  drivers/gpu/drm/i915/display/intel_acpi.h     |  6 ++
> >  drivers/gpu/drm/i915/display/intel_opregion.c | 80 +----------------
> >  3 files changed, 97 insertions(+), 76 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> > index 3456d33feb46..748d9b3125dd 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> > @@ -156,3 +156,90 @@ void intel_register_dsm_handler(void)
> >  void intel_unregister_dsm_handler(void)
> >  {
> >  }
> > +
> > +/*
> > + * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
> > + * Attached to the Display Adapter).
> > + */
> > +#define ACPI_DISPLAY_INDEX_SHIFT             0
> > +#define ACPI_DISPLAY_INDEX_MASK                      (0xf << 0)
> > +#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT   4
> > +#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK    (0xf << 4)
> > +#define ACPI_DISPLAY_TYPE_SHIFT                      8
> > +#define ACPI_DISPLAY_TYPE_MASK                       (0xf << 8)
> > +#define ACPI_DISPLAY_TYPE_OTHER                      (0 << 8)
> > +#define ACPI_DISPLAY_TYPE_VGA                        (1 << 8)
> > +#define ACPI_DISPLAY_TYPE_TV                 (2 << 8)
> > +#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL   (3 << 8)
> > +#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL   (4 << 8)
> > +#define ACPI_VENDOR_SPECIFIC_SHIFT           12
> > +#define ACPI_VENDOR_SPECIFIC_MASK            (0xf << 12)
> > +#define ACPI_BIOS_CAN_DETECT                 (1 << 16)
> > +#define ACPI_DEPENDS_ON_VGA                  (1 << 17)
> > +#define ACPI_PIPE_ID_SHIFT                   18
> > +#define ACPI_PIPE_ID_MASK                    (7 << 18)
> > +#define ACPI_DEVICE_ID_SCHEME                        (1ULL << 31)
> > +
> > +static u32 acpi_display_type(struct intel_connector *connector)
> > +{
> > +     u32 display_type;
> > +
> > +     switch (connector->base.connector_type) {
> > +     case DRM_MODE_CONNECTOR_VGA:
> > +     case DRM_MODE_CONNECTOR_DVIA:
> > +             display_type = ACPI_DISPLAY_TYPE_VGA;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_Composite:
> > +     case DRM_MODE_CONNECTOR_SVIDEO:
> > +     case DRM_MODE_CONNECTOR_Component:
> > +     case DRM_MODE_CONNECTOR_9PinDIN:
> > +     case DRM_MODE_CONNECTOR_TV:
> > +             display_type = ACPI_DISPLAY_TYPE_TV;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_DVII:
> > +     case DRM_MODE_CONNECTOR_DVID:
> > +     case DRM_MODE_CONNECTOR_DisplayPort:
> > +     case DRM_MODE_CONNECTOR_HDMIA:
> > +     case DRM_MODE_CONNECTOR_HDMIB:
> > +             display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_LVDS:
> > +     case DRM_MODE_CONNECTOR_eDP:
> > +     case DRM_MODE_CONNECTOR_DSI:
> > +             display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
> > +             break;
> > +     case DRM_MODE_CONNECTOR_Unknown:
> > +     case DRM_MODE_CONNECTOR_VIRTUAL:
> > +             display_type = ACPI_DISPLAY_TYPE_OTHER;
> > +             break;
> > +     default:
> > +             MISSING_CASE(connector->base.connector_type);
> > +             display_type = ACPI_DISPLAY_TYPE_OTHER;
> > +             break;
> > +     }
> > +
> > +     return display_type;
> > +}
> > +
> > +void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev)
>
> Plase use intel_foo_ prefix for functions in intel_foo.c,
> i.e. intel_acpi_ here. Say, intel_acpi_device_id_update() or something.

Done.

>
> Please always prefer struct drm_i915_private *i915 over struct
> drm_device * pointers in i915 code.

Done

>
> > +{
> > +     struct intel_connector *connector;
> > +     struct drm_connector_list_iter conn_iter;
> > +     u8 display_index[16] = {};
> > +     u32 device_id, type;
> > +
> > +     /* Populate the ACPI IDs for all connectors for a given drm_device */
> > +     drm_connector_list_iter_begin(drm_dev, &conn_iter);
> > +     for_each_intel_connector_iter(connector, &conn_iter) {
> > +
>
> Superfluous newline, the device_id and type local vars could be here as
> in the original.

Done.

>
> > +             device_id = acpi_display_type(connector);
> > +
> > +             /* Use display type specific display index. */
> > +             type = (device_id & ACPI_DISPLAY_TYPE_MASK)
> > +                     >> ACPI_DISPLAY_TYPE_SHIFT;
> > +             device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
> > +
> > +             connector->acpi_device_id = device_id;
> > +     }
> > +     drm_connector_list_iter_end(&conn_iter);
> > +}
> > diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> > index 1c576b3fb712..8f6d850df6fa 100644
> > --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> > +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> > @@ -6,12 +6,18 @@
> >  #ifndef __INTEL_ACPI_H__
> >  #define __INTEL_ACPI_H__
> >
> > +#include "intel_display_types.h"
> > +
>
> Please prefer forward declarations over adding new includes.
>
> struct drm_i915_private;
>

Done.

> >  #ifdef CONFIG_ACPI
> >  void intel_register_dsm_handler(void);
> >  void intel_unregister_dsm_handler(void);
> > +void intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev);
> >  #else
> >  static inline void intel_register_dsm_handler(void) { return; }
> >  static inline void intel_unregister_dsm_handler(void) { return; }
> > +static inline void
> > +static inline void
>
> Whoops.

Done.

>
> > +intel_populate_acpi_ids_for_all_connectors(struct drm_device *drm_dev) { }
> >  #endif /* CONFIG_ACPI */
> >
> >  #endif /* __INTEL_ACPI_H__ */
> > diff --git a/drivers/gpu/drm/i915/display/intel_opregion.c b/drivers/gpu/drm/i915/display/intel_opregion.c
> > index 969ade623691..f5976a6ab3c4 100644
> > --- a/drivers/gpu/drm/i915/display/intel_opregion.c
> > +++ b/drivers/gpu/drm/i915/display/intel_opregion.c
> > @@ -35,6 +35,7 @@
> >  #include "display/intel_panel.h"
> >
> >  #include "i915_drv.h"
> > +#include "intel_acpi.h"
> >  #include "intel_display_types.h"
> >  #include "intel_opregion.h"
> >
> > @@ -242,29 +243,6 @@ struct opregion_asle_ext {
> >  #define SWSCI_SBCB_POST_VBE_PM               SWSCI_FUNCTION_CODE(SWSCI_SBCB, 19)
> >  #define SWSCI_SBCB_ENABLE_DISABLE_AUDIO      SWSCI_FUNCTION_CODE(SWSCI_SBCB, 21)
> >
> > -/*
> > - * ACPI Specification, Revision 5.0, Appendix B.3.2 _DOD (Enumerate All Devices
> > - * Attached to the Display Adapter).
> > - */
> > -#define ACPI_DISPLAY_INDEX_SHIFT             0
> > -#define ACPI_DISPLAY_INDEX_MASK                      (0xf << 0)
> > -#define ACPI_DISPLAY_PORT_ATTACHMENT_SHIFT   4
> > -#define ACPI_DISPLAY_PORT_ATTACHMENT_MASK    (0xf << 4)
> > -#define ACPI_DISPLAY_TYPE_SHIFT                      8
> > -#define ACPI_DISPLAY_TYPE_MASK                       (0xf << 8)
> > -#define ACPI_DISPLAY_TYPE_OTHER                      (0 << 8)
> > -#define ACPI_DISPLAY_TYPE_VGA                        (1 << 8)
> > -#define ACPI_DISPLAY_TYPE_TV                 (2 << 8)
> > -#define ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL   (3 << 8)
> > -#define ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL   (4 << 8)
> > -#define ACPI_VENDOR_SPECIFIC_SHIFT           12
> > -#define ACPI_VENDOR_SPECIFIC_MASK            (0xf << 12)
> > -#define ACPI_BIOS_CAN_DETECT                 (1 << 16)
> > -#define ACPI_DEPENDS_ON_VGA                  (1 << 17)
> > -#define ACPI_PIPE_ID_SHIFT                   18
> > -#define ACPI_PIPE_ID_MASK                    (7 << 18)
> > -#define ACPI_DEVICE_ID_SCHEME                        (1 << 31)
> > -
> >  #define MAX_DSLP     1500
> >
> >  static int swsci(struct drm_i915_private *dev_priv,
> > @@ -662,54 +640,12 @@ static void set_did(struct intel_opregion *opregion, int i, u32 val)
> >       }
> >  }
> >
> > -static u32 acpi_display_type(struct intel_connector *connector)
> > -{
> > -     u32 display_type;
> > -
> > -     switch (connector->base.connector_type) {
> > -     case DRM_MODE_CONNECTOR_VGA:
> > -     case DRM_MODE_CONNECTOR_DVIA:
> > -             display_type = ACPI_DISPLAY_TYPE_VGA;
> > -             break;
> > -     case DRM_MODE_CONNECTOR_Composite:
> > -     case DRM_MODE_CONNECTOR_SVIDEO:
> > -     case DRM_MODE_CONNECTOR_Component:
> > -     case DRM_MODE_CONNECTOR_9PinDIN:
> > -     case DRM_MODE_CONNECTOR_TV:
> > -             display_type = ACPI_DISPLAY_TYPE_TV;
> > -             break;
> > -     case DRM_MODE_CONNECTOR_DVII:
> > -     case DRM_MODE_CONNECTOR_DVID:
> > -     case DRM_MODE_CONNECTOR_DisplayPort:
> > -     case DRM_MODE_CONNECTOR_HDMIA:
> > -     case DRM_MODE_CONNECTOR_HDMIB:
> > -             display_type = ACPI_DISPLAY_TYPE_EXTERNAL_DIGITAL;
> > -             break;
> > -     case DRM_MODE_CONNECTOR_LVDS:
> > -     case DRM_MODE_CONNECTOR_eDP:
> > -     case DRM_MODE_CONNECTOR_DSI:
> > -             display_type = ACPI_DISPLAY_TYPE_INTERNAL_DIGITAL;
> > -             break;
> > -     case DRM_MODE_CONNECTOR_Unknown:
> > -     case DRM_MODE_CONNECTOR_VIRTUAL:
> > -             display_type = ACPI_DISPLAY_TYPE_OTHER;
> > -             break;
> > -     default:
> > -             MISSING_CASE(connector->base.connector_type);
> > -             display_type = ACPI_DISPLAY_TYPE_OTHER;
> > -             break;
> > -     }
> > -
> > -     return display_type;
> > -}
> > -
> >  static void intel_didl_outputs(struct drm_i915_private *dev_priv)
> >  {
> >       struct intel_opregion *opregion = &dev_priv->opregion;
> >       struct intel_connector *connector;
> >       struct drm_connector_list_iter conn_iter;
> >       int i = 0, max_outputs;
> > -     int display_index[16] = {};
> >
> >       /*
> >        * In theory, did2, the extended didl, gets added at opregion version
> > @@ -721,20 +657,12 @@ static void intel_didl_outputs(struct drm_i915_private *dev_priv)
> >       max_outputs = ARRAY_SIZE(opregion->acpi->didl) +
> >               ARRAY_SIZE(opregion->acpi->did2);
> >
> > +     intel_populate_acpi_ids_for_all_connectors(&dev_priv->drm);
> > +
>
> As the acpi_device_ids will be used elsewhere too, maybe this call needs
> to be moved to a higher level and called on the resume path. *shrug*

I don't understand this code well, happy to do whatever you or others
see fit. I kept it here so as to not to disturb any code that I do not
understand and cause unintended regressions (this code had it here, so
decided to leave it as-is). For the privacy screen purposes, we just
need to know the ACPI ID before we probe for the privacy screen to add
the property.

Thanks,

Rajat




>
> BR,
> Jani.
>
> >       drm_connector_list_iter_begin(&dev_priv->drm, &conn_iter);
> >       for_each_intel_connector_iter(connector, &conn_iter) {
> > -             u32 device_id, type;
> > -
> > -             device_id = acpi_display_type(connector);
> > -
> > -             /* Use display type specific display index. */
> > -             type = (device_id & ACPI_DISPLAY_TYPE_MASK)
> > -                     >> ACPI_DISPLAY_TYPE_SHIFT;
> > -             device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
> > -
> > -             connector->acpi_device_id = device_id;
> >               if (i < max_outputs)
> > -                     set_did(opregion, i, device_id);
> > +                     set_did(opregion, i, connector->acpi_device_id);
> >               i++;
> >       }
> >       drm_connector_list_iter_end(&conn_iter);
>
> --
> Jani Nikula, Intel Open Source Graphics Center
