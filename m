Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E5C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926192086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9sodbYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfGJPpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:45:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34412 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:45:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so1956618lfq.1;
        Wed, 10 Jul 2019 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ijWEMieickbwE2heNBe0wh4Edj/aRy5NBiPlW7DdE8=;
        b=N9sodbYNbD/pvLup9mnY2ExXB7r7hPtkClYGLHD+V9hAYmqDLqJw1lGCCKcNaCuONk
         HJO7g5/4ZPdqE7PO6kT1lU+lD72ZT+3bft4FvWk0+cMFxGr3PU8rzxHUoc/XJLK17IQJ
         C0rx27dyrezih/YKUACfr7Cx1vT1BvoP7athrUSCNUw27PmXICNgD3qFTk5y8dvAHq4N
         1AVGlly2xO00yUMYQNT6UZUVJRD/CY6srlA+x6ddGZmyJ3VpO8Oc+QrPdBzDAK8r7dhz
         oZl1nBYbgHZsnm7VsuAp5sqdIQqhE5tfNwMSBaMZbKECDTfAt4l7boAme0Xss3+Z6pOk
         o+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ijWEMieickbwE2heNBe0wh4Edj/aRy5NBiPlW7DdE8=;
        b=tjIE45HPPiOICtQ+7O8Mnjef3Huz7xpQzEOc8e9a2NV+8u4V0o3EpzLKpYNGqARrKQ
         Kl5LJyBEYcHEd3Nq/fXP6La96VEpWp45eCiQnwiJxxXf5dagajvezkcwl9bzlUL3Chq6
         oKfTI+AGtVYSRDRHi4+rzhio8mqZ/GvGbIJGyBrDg1k/Q60jqOqJf+uCJK17D4MqitzB
         vNsZHmV0+5H9fSXlEhgoUTwlc9BWKSueB47j3WMe3+pYz/INvLKFUgtxlkFDyIcmvIZV
         UX1zOA0MKEG2aBrkpcSfR9YwQBcejFSGFq7dSr60e6rcJedtbOsKPhIA36CekDiDra/i
         T/4w==
X-Gm-Message-State: APjAAAWu0hIDD9tMo8sIt4Gk92bIRuhNnGfw99frxChBdtupJdk2WS+l
        CpPY+w6UenA6PvSaKp22E9PYMXBu
X-Google-Smtp-Source: APXvYqzmm512H5Ed2bqoqtMYLfKJknyJmwMBxi/u6B4GjvWTshAYn5DfkI0715CESbvDggccNSVnZA==
X-Received: by 2002:a19:c503:: with SMTP id w3mr13722696lfe.139.1562773549675;
        Wed, 10 Jul 2019 08:45:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id b25sm407956lfq.11.2019.07.10.08.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 08:45:48 -0700 (PDT)
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
Message-ID: <2b17baa6-0d16-acac-f626-51799f0d3293@gmail.com>
Date:   Wed, 10 Jul 2019 18:45:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e7d78307-4a48-45b1-ffbe-bc397fec0e40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 18:05, Dmitry Osipenko пишет:
> 10.07.2019 17:05, Maxime Ripard пишет:
>> On Wed, Jul 10, 2019 at 04:29:19PM +0300, Dmitry Osipenko wrote:
>>> This works:
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>>> index 56d36779d213..e5a2f9c8f404 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>>>         mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
>>>         if (mode)
>>>                 list_add(&mode->head, &connector->modes);
>>> +       else
>>> +               cmdline_mode->specified = false;
>>
>> Hmmm, it's not clear to me why that wouldn't be the case.
>>
>> If we come back to the beginning of that function, we retrieve the
>> cmdline_mode buffer from the connector pointer, that will probably
>> have been parsed a first time using drm_mode_create_from_cmdline_mode
>> in drm_helper_probe_add_cmdline_mode.
>>
>> Now, I'm guessing that the issue is that in
>> drm_mode_parse_command_line_for_connector, if we have a named mode, we
>> just copy the mode over and set mode->specified.
>>
>> And we then move over to do other checks, and that's probably what
>> fails and returns, but our drm_cmdline_mode will have been modified.
>>
>> I'm not entirely sure how to deal with that though.
>>
>> I guess we could allocate a drm_cmdline_mode structure on the stack,
>> fill that, and if successful copy over its content to the one in
>> drm_connector. That would allow us to only change the content on
>> success, which is what I would expect from such a function?
>>
>> How does that sound?
> 
> I now see that there is DRM_MODE_TYPE_USERDEF flag that is assigned only
> for the "cmdline" mode and drm_client_rotation() is the only place in
> DRM code that cares about whether mode is from cmdline, hence looks like
> it will be more correct to do the following:
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c
> b/drivers/gpu/drm/drm_client_modeset.c
> index 56d36779d213..e5b3be9ed689 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -825,6 +825,7 @@ bool drm_client_rotation(struct drm_mode_set
> *modeset, unsigned int *rotation)
>  {
>         struct drm_connector *connector = modeset->connectors[0];
>         struct drm_plane *plane = modeset->crtc->primary;
> +       struct drm_display_mode *mode = modeset->mode;
>         struct drm_cmdline_mode *cmdline;
>         u64 valid_mask = 0;
>         unsigned int i;
> @@ -859,7 +860,7 @@ bool drm_client_rotation(struct drm_mode_set
> *modeset, unsigned int *rotation)
>          * simple XOR between the two handle the addition nicely.
>          */
>         cmdline = &connector->cmdline_mode;
> -       if (cmdline->specified) {
> +       if (mode->flags & DRM_MODE_TYPE_USERDEF) {
>                 unsigned int cmdline_rest, panel_rest;
>                 unsigned int cmdline_rot, panel_rot;
>                 unsigned int sum_rot, sum_rest;
> 

Although, then rotation won't be applied to the named mode in that case.

Seems the fix could be even simpler:

@@ -859,7 +859,7 @@ bool drm_client_rotation(struct drm_mode_set
*modeset, unsigned int *rotation)
         * simple XOR between the two handle the addition nicely.
         */
        cmdline = &connector->cmdline_mode;
-       if (cmdline->specified) {
+       if (cmdline->specified && cmdline->rotation_reflection) {
                unsigned int cmdline_rest, panel_rest;
                unsigned int cmdline_rot, panel_rot;
                unsigned int sum_rot, sum_rest;

And looks like there is another problem here.. the cmdline's rotation
overrides *all* modes while the doc/fb/modedb.rst claims that rotation
is applied only to the *initial* mode.
