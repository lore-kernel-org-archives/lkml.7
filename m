Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B19C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE35020726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGM7xmWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLPO7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:59:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22266 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbfLPO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576508364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJOt3/otHQDZlenhUklrLoPIwdlpgH1LgHZIHE3PiAw=;
        b=fGM7xmWvRh2yAQOiG1xBQw+hqV6rSCmcjJ6CozEwvWqD0QdWaVNgE56eVvV034Ck8cbFVX
        qJ7oaukdle1S8oqjArhAag/A7y0S12xrRsVWXYDc420TFKdtkokprsuRp4laoCDH4Wlrti
        i8w09rGwXacAz1mS5jTmgwsARdaigjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-o_R_Ka6BPDm7D1y4X3zWjA-1; Mon, 16 Dec 2019 09:59:22 -0500
X-MC-Unique: o_R_Ka6BPDm7D1y4X3zWjA-1
Received: by mail-wm1-f69.google.com with SMTP id z2so1129252wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJOt3/otHQDZlenhUklrLoPIwdlpgH1LgHZIHE3PiAw=;
        b=MS107T42nLon5vWwe2nak1JOWYksD3B67Mltnx/7hedTi7saNCzKnAwsxSlyQMzDe4
         X4UdRztccJQhWT5iFvTvMKKM1LDHD9B0iFb89rUwV/X8nTA3SU9NvToakVMbqGkEgfwO
         D05fLdPslQY34yC25TX4BRaz7X5lZwtEeLauWpOw04dJFavZ3fXoHa/R2zzqPo/jy7pE
         GV3Cqx9U2mUmWNaXabMFrbbJwB68f4KyQrcgADukD3oDyxP3+YhpSe5VZCZPTFETuUxO
         H2D3xWTWL6vgUSt1efhGmb21fF2RFfVbEhZy1CgryIQmqT/numeKcxcsEiZj6EyX2rke
         5oTA==
X-Gm-Message-State: APjAAAVuJzvbd+Z/AcpP30Gdimphu7FvoNkNVUkkWaO14F4K+eswmk9t
        hpTZ6a7aJDHhNCMdqRuZk3nxk+kIWQtbcYJUYLPvzlBZjkAH4JHkvxsHE+88lRyMbZojShpcy0X
        anKSBSu8iNXdFc6L7sXPWEwpk
X-Received: by 2002:a5d:610a:: with SMTP id v10mr27484192wrt.267.1576508360249;
        Mon, 16 Dec 2019 06:59:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqywGl8Dz3HRQB6nfkN44c07NNAivBGuMSN91rqy5SqGN+A6SlKsV91NWVHxZorRzf4H2zUCSw==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr27484159wrt.267.1576508360016;
        Mon, 16 Dec 2019 06:59:20 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id s8sm21521486wrt.57.2019.12.16.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:59:19 -0800 (PST)
Subject: Re: [PATCH 3/5] drm/i915/dsi: Init panel-enable GPIO to low when the
 LCD is initially off
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20191215163810.52356-1-hdegoede@redhat.com>
 <20191215163810.52356-4-hdegoede@redhat.com>
 <20191216134551.GQ1208@intel.com>
 <c7fe3911-be20-33dd-96c1-58eccd0f323f@redhat.com>
 <20191216141450.GU1208@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <55e2ddf4-cd20-2663-d625-3836fac5f0c7@redhat.com>
Date:   Mon, 16 Dec 2019 15:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216141450.GU1208@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16-12-2019 15:14, Ville Syrjälä wrote:
> On Mon, Dec 16, 2019 at 02:51:54PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for the reviews.
>>
>> On 16-12-2019 14:45, Ville Syrjälä wrote:
>>> On Sun, Dec 15, 2019 at 05:38:08PM +0100, Hans de Goede wrote:
>>>> When the LCD has not been turned on by the firmware/GOP, because e.g. the
>>>> device was booted with an external monitor connected over HDMI, we should
>>>> not turn on the panel-enable GPIO when we request it.
>>>>
>>>> Turning on the panel-enable GPIO when we request it, means we turn it on
>>>> too early in the init-sequence, which causes some panels to not correctly
>>>> light up.
>>>>
>>>> This commits adds a panel_is_on parameter to intel_dsi_vbt_gpio_init()
>>>> and makes intel_dsi_vbt_gpio_init() set the initial GPIO value accordingly.
>>>>
>>>> This fixes the panel not lighting up on a Thundersoft TST168 tablet when
>>>> booted with an external monitor connected over HDMI.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/gpu/drm/i915/display/intel_dsi.h     | 2 +-
>>>>    drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 7 +++----
>>>>    drivers/gpu/drm/i915/display/vlv_dsi.c       | 2 +-
>>>>    3 files changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_dsi.h b/drivers/gpu/drm/i915/display/intel_dsi.h
>>>> index de7e51cd3460..675771ea91aa 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_dsi.h
>>>> +++ b/drivers/gpu/drm/i915/display/intel_dsi.h
>>>> @@ -203,7 +203,7 @@ void bxt_dsi_reset_clocks(struct intel_encoder *encoder, enum port port);
>>>>    
>>>>    /* intel_dsi_vbt.c */
>>>>    bool intel_dsi_vbt_init(struct intel_dsi *intel_dsi, u16 panel_id);
>>>> -void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi);
>>>> +void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on);
>>>>    void intel_dsi_vbt_gpio_cleanup(struct intel_dsi *intel_dsi);
>>>>    void intel_dsi_vbt_exec_sequence(struct intel_dsi *intel_dsi,
>>>>    				 enum mipi_seq seq_id);
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
>>>> index 5352e8c9eca5..027970348b22 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
>>>> @@ -688,17 +688,16 @@ bool intel_dsi_vbt_init(struct intel_dsi *intel_dsi, u16 panel_id)
>>>>     * On some BYT/CHT devs some sequences are incomplete and we need to manually
>>>>     * control some GPIOs.
>>>>     */
>>>> -void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi)
>>>> +void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
>>>>    {
>>>>    	struct drm_device *dev = intel_dsi->base.base.dev;
>>>>    	struct drm_i915_private *dev_priv = to_i915(dev);
>>>>    	struct mipi_config *mipi_config = dev_priv->vbt.dsi.config;
>>>> +	enum gpiod_flags flags = panel_is_on ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
>>>
>>> Can't we just tell it not to change the current setting?
>>
>> We could use GPIOD_ASIS for that, but with the SoC pins (when the PMIC is
>> not used for backlight control) things get a bit muddy, I've seen several
>> instances of this message from drivers/pinctrl/intel/pinctrl-baytrail.c
>> trigger when the GOP did not init the panel:
>>
>> dev_warn(vg->dev, FW_BUG "pin %u forcibly re-configured as GPIO\n", offset);
>>
>> And in that case with GPIOD_ASIS I have no idea which we initially get,
>> so this approach, where we clearly define which initial value we want,
>> seems better.
> 
> I suppose. Probably better to not abuse the current_mode pointer for
> that though and just explicitly call encoder->get_hw_state() instead.

Ok, I'll fix this for v2 of the patch-set.

Regards,

Hans





>> p.s.
>>
>> The intel-gfx CI seems to seriously dislike my patches lately, almost
>> always failing them; and usually on what at least seem to be unrelated
>> test-cases. Any advice on how to deal with this?
> 
> Yeah, CI is snafu. I keep smashing retest until it gets through BAT
> and then just double check the shard results to make sure nothing
> relevant has tripped. If things look OK I recommend replying to the
> result mail and provide a few short log snippets/other details on
> what failed so that it's clear that it's irrelevant.
> 
>>
>>
>>
>>
>>>
>>>>    
>>>>    	if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
>>>>    	    (mipi_config->pwm_blc == PPS_BLC_PMIC)) {
>>>> -		intel_dsi->gpio_panel =
>>>> -			gpiod_get(dev->dev, "panel", GPIOD_OUT_HIGH);
>>>> -
>>>> +		intel_dsi->gpio_panel = gpiod_get(dev->dev, "panel", flags);
>>>>    		if (IS_ERR(intel_dsi->gpio_panel)) {
>>>>    			DRM_ERROR("Failed to own gpio for panel control\n");
>>>>    			intel_dsi->gpio_panel = NULL;
>>>> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
>>>> index 178d0fffba5b..e86e4a11e199 100644
>>>> --- a/drivers/gpu/drm/i915/display/vlv_dsi.c
>>>> +++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
>>>> @@ -1910,7 +1910,7 @@ void vlv_dsi_init(struct drm_i915_private *dev_priv)
>>>>    
>>>>    	vlv_dphy_param_init(intel_dsi);
>>>>    
>>>> -	intel_dsi_vbt_gpio_init(intel_dsi);
>>>> +	intel_dsi_vbt_gpio_init(intel_dsi, current_mode != NULL);
>>>>    
>>>>    	drm_connector_init(dev, connector, &intel_dsi_connector_funcs,
>>>>    			   DRM_MODE_CONNECTOR_DSI);
>>>> -- 
>>>> 2.23.0
>>>
> 

