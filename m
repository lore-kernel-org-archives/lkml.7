Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D0BC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7920657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404753AbfFKIyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:54:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43495 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404119AbfFKIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:54:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so18856016edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 01:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3uzcEie+Ohpl02QogzO6HKa3vZkAr6RMtmIQE/ajIxY=;
        b=Ezbn8XsLBgG2hE9oItwdWroWu/rZi3y1STnWZvbab+QxleJ7c5vqZOizqYnX9ZCB/B
         m/W1p+vQDValh7Tv/I1bLJYPznVrY1RZZeRBYWgcONGF6J25Rk+XANRbp2UZCFNyOsdL
         b/Hcg59RJtKgnx3BtBrTpF5OretWAhQwVxDI4s8hEWn5y0SB2G089/1KOyeJkHuXqI9m
         8JlOCV/FziTMmmOtfw3nF03Nd2TFCBwOBo92gkO6NRO28oVFZ2m4DFPpmUqraoDrRGha
         ri+0+rVGhQMbogkvOc9kIdEmiBUJmLs1BZAqfTzW7TRvEwvOhLie+mt1LfNI6c+EtcmP
         Ixrg==
X-Gm-Message-State: APjAAAUOe26O3zHHUNoSS7LMXAnoy3zPDVWAXv07Fkdpd7gLeM4rbqRy
        Y8Zou3YRO8RDP82Ne0BpaNFBFQ==
X-Google-Smtp-Source: APXvYqyAHxRrGS3STysulUcExa6+FqtFwDiyuJoWwkEl0mB62VVXi/OtKmiTQYlXkcIRTDwF1yQQ4g==
X-Received: by 2002:a50:a935:: with SMTP id l50mr79217474edc.198.1560243275828;
        Tue, 11 Jun 2019 01:54:35 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e19sm769255eja.91.2019.06.11.01.54.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:54:35 -0700 (PDT)
Subject: Re: [PATCH 4/5] drm/connector: Split out orientation quirk detection
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-5-dbasehore@chromium.org> <87zhmoy270.fsf@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <01636500-0be5-acf8-5f93-a57383bf4b20@redhat.com>
Date:   Tue, 11 Jun 2019 10:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zhmoy270.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-06-19 10:08, Jani Nikula wrote:
> On Mon, 10 Jun 2019, Derek Basehore <dbasehore@chromium.org> wrote:
>> This removes the orientation quirk detection from the code to add
>> an orientation property to a panel. This is used only for legacy x86
>> systems, yet we'd like to start using this on devicetree systems where
>> quirk detection like this is not needed.
> 
> Not needed, but no harm done either, right?
> 
> I guess I'll defer judgement on this to Hans and Ville (Cc'd).

Hmm, I'm not big fan of this change. It adds code duplication and as
other models with the same issue using a different driver or panel-type
show up we will get more code duplication.

Also I'm not convinced that devicetree based platforms will not need
this. The whole devicetree as an ABI thing, which means that all
devicetree bindings need to be set in stone before things are merged
into the mainline, is done solely so that we can get vendors to ship
hardware with the dtb files included in the firmware.

I'm 100% sure that there is e.g. ARM hardware out there which uses
non upright mounted LCD panels (I used to have a few Allwinner
tablets which did this). And given my experience with the quality
of firmware bundled tables like ACPI tables I'm quite sure that
if we ever move to firmware included dtb files that we will need
quirks for those too.

Also calling this "used only for legacy x86 systems" is a bit
unfair IMHO, new UEFI models are still being added to the quirk list
today, for hardware which does not even ship yet. Actually 99%
of the models in the quirk list are UEFI only models, which do
not even support classic PC BIOS booting, so those systems are
anything but legacy.

I believe the only reason we have only had to deal with this on x86
so far is because the OOTB support for most ARM systems is less polished
then that for x86 systems and on ARM systems there are still more
important issues to tackle first.

Regards,

Hans






> 
> Side note, I'm about to apply some (minor) conflicting changes in our
> -next as soon as I get CI results on it.
> 
> 
> BR,
> Jani.
> 
> 
>>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> ---
>>   drivers/gpu/drm/drm_connector.c | 16 ++++------------
>>   drivers/gpu/drm/i915/intel_dp.c | 14 +++++++++++---
>>   drivers/gpu/drm/i915/vlv_dsi.c  | 14 ++++++++++----
>>   include/drm/drm_connector.h     |  2 +-
>>   4 files changed, 26 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index e17586aaa80f..58a09b65028b 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -1894,31 +1894,23 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>>    * drm_connector_init_panel_orientation_property -
>>    *	initialize the connecters panel_orientation property
>>    * @connector: connector for which to init the panel-orientation property.
>> - * @width: width in pixels of the panel, used for panel quirk detection
>> - * @height: height in pixels of the panel, used for panel quirk detection
>>    *
>>    * This function should only be called for built-in panels, after setting
>>    * connector->display_info.panel_orientation first (if known).
>>    *
>> - * This function will check for platform specific (e.g. DMI based) quirks
>> - * overriding display_info.panel_orientation first, then if panel_orientation
>> - * is not DRM_MODE_PANEL_ORIENTATION_UNKNOWN it will attach the
>> - * "panel orientation" property to the connector.
>> + * This function will check if the panel_orientation is not
>> + * DRM_MODE_PANEL_ORIENTATION_UNKNOWN. If not, it will attach the "panel
>> + * orientation" property to the connector.
>>    *
>>    * Returns:
>>    * Zero on success, negative errno on failure.
>>    */
>>   int drm_connector_init_panel_orientation_property(
>> -	struct drm_connector *connector, int width, int height)
>> +	struct drm_connector *connector)
>>   {
>>   	struct drm_device *dev = connector->dev;
>>   	struct drm_display_info *info = &connector->display_info;
>>   	struct drm_property *prop;
>> -	int orientation_quirk;
>> -
>> -	orientation_quirk = drm_get_panel_orientation_quirk(width, height);
>> -	if (orientation_quirk != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>> -		info->panel_orientation = orientation_quirk;
>>   
>>   	if (info->panel_orientation == DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>>   		return 0;
>> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
>> index b099a9dc28fd..72ab090ea97a 100644
>> --- a/drivers/gpu/drm/i915/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/intel_dp.c
>> @@ -40,6 +40,7 @@
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_hdcp.h>
>>   #include <drm/drm_probe_helper.h>
>> +#include <drm/drm_utils.h>
>>   #include <drm/i915_drm.h>
>>   
>>   #include "i915_debugfs.h"
>> @@ -7281,9 +7282,16 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>>   	intel_connector->panel.backlight.power = intel_edp_backlight_power;
>>   	intel_panel_setup_backlight(connector, pipe);
>>   
>> -	if (fixed_mode)
>> -		drm_connector_init_panel_orientation_property(
>> -			connector, fixed_mode->hdisplay, fixed_mode->vdisplay);
>> +	if (fixed_mode) {
>> +		int orientation = drm_get_panel_orientation_quirk(
>> +				fixed_mode->hdisplay, fixed_mode->vdisplay);
>> +
>> +		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>> +			connector->display_info.panel_orientation =
>> +				orientation;
>> +
>> +		drm_connector_init_panel_orientation_property(connector);
>> +	}
>>   
>>   	return true;
>>   
>> diff --git a/drivers/gpu/drm/i915/vlv_dsi.c b/drivers/gpu/drm/i915/vlv_dsi.c
>> index bfe2891eac37..27f86a787f60 100644
>> --- a/drivers/gpu/drm/i915/vlv_dsi.c
>> +++ b/drivers/gpu/drm/i915/vlv_dsi.c
>> @@ -30,6 +30,7 @@
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_edid.h>
>>   #include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_utils.h>
>>   
>>   #include "i915_drv.h"
>>   #include "intel_atomic.h"
>> @@ -1650,6 +1651,7 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>>   
>>   	if (connector->panel.fixed_mode) {
>>   		u32 allowed_scalers;
>> +		int orientation;
>>   
>>   		allowed_scalers = BIT(DRM_MODE_SCALE_ASPECT) | BIT(DRM_MODE_SCALE_FULLSCREEN);
>>   		if (!HAS_GMCH(dev_priv))
>> @@ -1660,12 +1662,16 @@ static void intel_dsi_add_properties(struct intel_connector *connector)
>>   
>>   		connector->base.state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>>   
>> -		connector->base.display_info.panel_orientation =
>> -			vlv_dsi_get_panel_orientation(connector);
>> -		drm_connector_init_panel_orientation_property(
>> -				&connector->base,
>> +		orientation = drm_get_panel_orientation_quirk(
>>   				connector->panel.fixed_mode->hdisplay,
>>   				connector->panel.fixed_mode->vdisplay);
>> +		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
>> +			connector->base.display_info.panel_orientation = orientation;
>> +		else
>> +			connector->base.display_info.panel_orientation =
>> +				vlv_dsi_get_panel_orientation(connector);
>> +
>> +		drm_connector_init_panel_orientation_property(&connector->base);
>>   	}
>>   }
>>   
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index 47e749b74e5f..c2992f7a0dd5 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -1370,7 +1370,7 @@ void drm_connector_set_link_status_property(struct drm_connector *connector,
>>   void drm_connector_set_vrr_capable_property(
>>   		struct drm_connector *connector, bool capable);
>>   int drm_connector_init_panel_orientation_property(
>> -	struct drm_connector *connector, int width, int height);
>> +	struct drm_connector *connector);
>>   int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>>   					  int min, int max);
> 
