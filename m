Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D2C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19DA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQ8w4vB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfGJQDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:03:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36672 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfGJQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:03:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so2643049ljj.3;
        Wed, 10 Jul 2019 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLmMkhctNEuFU/NWee/rLpEm39VeDGOXHzQDHvN/6EY=;
        b=sQ8w4vB3vSSSnSSYSg6EQMicHo3+SIxaVI/Vim0+5d+LgR3sk6ohsUDnCq45RH98Wh
         g/prrYculst+mQNxN6577hhFE2ZnRV/dGejnhJi5m+IL8aWdO40RvlPo3Hlx6Ebj5zIK
         Z9P/xymgI822DhULMO3zviWbZYobAnhVTAc7bILNPTauET4Xwu/K56ZelNcnu5Jol6Hq
         kIXa3BBFszmIpErbA41AcYMJTkgnyjBUxu4zJl67FiJg7SFPb8+RPgVEKiy8KiObfTbv
         YxhfzT+UlpSng0XwxhPcu3i2ACIw31aEyVjSjn5xIdSdy7nwrWg34WFg8AVS1dScTMpC
         mXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLmMkhctNEuFU/NWee/rLpEm39VeDGOXHzQDHvN/6EY=;
        b=TyfqFC5cVOYwJtyG6kG7LtUYV3qy40TqWZgndlGeGbQhyOhqhgl2Wp9Z0PvRiEKiD6
         i1vB+qaH78CsDAKJCFn17aF5xUR/IZk0eE+JzTIAP1AiABYe4kVOlmQfo5TD8ljdu6tX
         ss1zM6TL8Z/KlW4363jjmHTsgoSCQ2KxYc2LGFjmT97jSxfbR9patL5cYPS49vJhnVuy
         nXC3+TmxVUjKnej0eIjssnX07hMt4gbevBP9maoS2ikl7qXjlhw1B60V5cdJcO2IBcLB
         x/TXECHhBdjU1sTC1SVR7SnH/gqpfWqSaP20U+HlNYw67hcP3LW8gdu+fb1SsVsR/FXB
         J6Ug==
X-Gm-Message-State: APjAAAXQMmaoC19A5HhtekeyFq8tNQ/1Z7ubXVRg2a3MqAbCpT4ijxu8
        orgXJw15pNqIlXJRWHx98cC3z2FZ
X-Google-Smtp-Source: APXvYqx96rnUQTsomSZgymS/cSn16dapx8+CRxKVlAnq4xASCJqCh4A+Y5s4lFuEgrTSZN3XuqiTQQ==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr15473673ljj.147.1562774585004;
        Wed, 10 Jul 2019 09:03:05 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id t25sm413719lfg.7.2019.07.10.09.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 09:03:04 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190709145151.23086-1-digetx@gmail.com>
 <20190710101229.54ufuhmh22dfxclr@flea>
 <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
 <20190710125552.qvmnh6qs63ikiu2k@flea>
 <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
 <20190710130615.gvi2jwgr2cds66xr@flea>
 <75719cad-c65c-7ebc-3ea8-98134f86ddc3@gmail.com>
 <4a13f12f-05a7-473e-4e4e-7a7e32d09720@gmail.com>
 <20190710140504.t5lsk36gnn5cdn6b@flea>
 <e7d78307-4a48-45b1-ffbe-bc397fec0e40@gmail.com>
 <2b17baa6-0d16-acac-f626-51799f0d3293@gmail.com>
Message-ID: <5b6bc04d-391e-3370-ffe5-17094ae4b365@gmail.com>
Date:   Wed, 10 Jul 2019 19:03:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2b17baa6-0d16-acac-f626-51799f0d3293@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 18:45, Dmitry Osipenko пишет:
> 10.07.2019 18:05, Dmitry Osipenko пишет:
>> 10.07.2019 17:05, Maxime Ripard пишет:
>>> On Wed, Jul 10, 2019 at 04:29:19PM +0300, Dmitry Osipenko wrote:
>>>> This works:
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>>>> index 56d36779d213..e5a2f9c8f404 100644
>>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>>> @@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>>>>         mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
>>>>         if (mode)
>>>>                 list_add(&mode->head, &connector->modes);
>>>> +       else
>>>> +               cmdline_mode->specified = false;
>>>
>>> Hmmm, it's not clear to me why that wouldn't be the case.
>>>
>>> If we come back to the beginning of that function, we retrieve the
>>> cmdline_mode buffer from the connector pointer, that will probably
>>> have been parsed a first time using drm_mode_create_from_cmdline_mode
>>> in drm_helper_probe_add_cmdline_mode.
>>>
>>> Now, I'm guessing that the issue is that in
>>> drm_mode_parse_command_line_for_connector, if we have a named mode, we
>>> just copy the mode over and set mode->specified.
>>>
>>> And we then move over to do other checks, and that's probably what
>>> fails and returns, but our drm_cmdline_mode will have been modified.
>>>
>>> I'm not entirely sure how to deal with that though.
>>>
>>> I guess we could allocate a drm_cmdline_mode structure on the stack,
>>> fill that, and if successful copy over its content to the one in
>>> drm_connector. That would allow us to only change the content on
>>> success, which is what I would expect from such a function?
>>>
>>> How does that sound?
>>
>> I now see that there is DRM_MODE_TYPE_USERDEF flag that is assigned only
>> for the "cmdline" mode and drm_client_rotation() is the only place in
>> DRM code that cares about whether mode is from cmdline, hence looks like
>> it will be more correct to do the following:
>>
>> diff --git a/drivers/gpu/drm/drm_client_modeset.c
>> b/drivers/gpu/drm/drm_client_modeset.c
>> index 56d36779d213..e5b3be9ed689 100644
>> --- a/drivers/gpu/drm/drm_client_modeset.c
>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>> @@ -825,6 +825,7 @@ bool drm_client_rotation(struct drm_mode_set
>> *modeset, unsigned int *rotation)
>>  {
>>         struct drm_connector *connector = modeset->connectors[0];
>>         struct drm_plane *plane = modeset->crtc->primary;
>> +       struct drm_display_mode *mode = modeset->mode;
>>         struct drm_cmdline_mode *cmdline;
>>         u64 valid_mask = 0;
>>         unsigned int i;
>> @@ -859,7 +860,7 @@ bool drm_client_rotation(struct drm_mode_set
>> *modeset, unsigned int *rotation)
>>          * simple XOR between the two handle the addition nicely.
>>          */
>>         cmdline = &connector->cmdline_mode;
>> -       if (cmdline->specified) {
>> +       if (mode->flags & DRM_MODE_TYPE_USERDEF) {
>>                 unsigned int cmdline_rest, panel_rest;
>>                 unsigned int cmdline_rot, panel_rot;
>>                 unsigned int sum_rot, sum_rest;
>>
> 
> Although, then rotation won't be applied to the named mode in that case.
> 
> Seems the fix could be even simpler:
> 
> @@ -859,7 +859,7 @@ bool drm_client_rotation(struct drm_mode_set
> *modeset, unsigned int *rotation)
>          * simple XOR between the two handle the addition nicely.
>          */
>         cmdline = &connector->cmdline_mode;
> -       if (cmdline->specified) {
> +       if (cmdline->specified && cmdline->rotation_reflection) {
>                 unsigned int cmdline_rest, panel_rest;
>                 unsigned int cmdline_rot, panel_rot;
>                 unsigned int sum_rot, sum_rest;
> 
> And looks like there is another problem here.. the cmdline's rotation
> overrides *all* modes while the doc/fb/modedb.rst claims that rotation
> is applied only to the *initial* mode.
> 

Actually, I was wrong here. This rotation is getting applied only to the
framebuffer's console, so looks fine.

I guess it's also okay to just keep applying cmdline's rotation even if
the mode is invalid. Please let me know if you have any objections.
