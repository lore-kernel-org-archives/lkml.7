Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC48BC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DBB21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUFhlv2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGLIaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:30:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33535 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:30:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so8519146ljg.0;
        Fri, 12 Jul 2019 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F10no2HO30FOZ+nye/7YyMgOcOyHDq4Smw1AGcr+NuE=;
        b=FUFhlv2fuv2V88WkQK0agSQNWYZOCsSrQ8Q8vhkMtDBewdtdwWu8UWg0seEGVfXgox
         cLYoreLpSloGGBaTJa842HVIvlnvrnvmxxNnv+wte05OVULZS7zNF8kKY5qFcs+IxI/1
         K5Jsx8kRAOaAy2RdC6gvFHXCqQSC3PJZ+SMDZUl9u2PEsJuc1grSqLvjfD4V10TACqvl
         6xrdQ5BsSB86Y1IdogOHa+2B2Q1gX3v/qynMz9skjDIT5ocYGTD4e2GfuMW3HOZT84zH
         k8pZ/YKrdmGxqnYQ0N7PLm/1UC/SG1VA6w5HEzb0JWztQUiUC3pVCWhN2bsd04a4bFc8
         0Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F10no2HO30FOZ+nye/7YyMgOcOyHDq4Smw1AGcr+NuE=;
        b=KqWZywsA/9iNhlrXJF1ekEdAjT+GRHIlMMPicViw8NC+xT3UlH2VPzMIzMesIW/nEe
         yYoigGtgJqmGBpiL54gZlbXoAqgKKFP8oMzMXibDu6Dh65uTLvsX9J6m/W0zWCOqSj4k
         CRt7QYbLOQf0rdh570V8vw12l5quqGBv7zyPgFAYX6IP6YVVVGA3fnKZhohgX76TIMMB
         EvFkFsE0qJpoLQMngZDNM5aq+0qHM/gZNN8RXPmTvjTgd2bG9grLNHXDii0ljUFCi2WB
         +zhlHumf4pnLGX5LQoT3r4JywXVtcmjclmMIDBN+roEaBDrr5DPEIGNfhrG0HN8yWmLD
         iUJQ==
X-Gm-Message-State: APjAAAWYgAgOMBZ6V/+43JENUGpAHIj6QtwaiOYrlY85aMrxmM3oWr9N
        Gxp6/7EF2qC3RdZTY0AsAmPce7Nh
X-Google-Smtp-Source: APXvYqyTvMHU3DVGX9m5tM1UF/mI2SFuTMllRS1g+dw37MyuFprMMPHVM+CFp2fLB6+vC/OinBEyag==
X-Received: by 2002:a2e:898b:: with SMTP id c11mr5338649lji.241.1562920202772;
        Fri, 12 Jul 2019 01:30:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id w1sm1540417ljm.81.2019.07.12.01.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 01:30:02 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
 <20190710125552.qvmnh6qs63ikiu2k@flea>
 <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
 <20190710130615.gvi2jwgr2cds66xr@flea>
 <75719cad-c65c-7ebc-3ea8-98134f86ddc3@gmail.com>
 <4a13f12f-05a7-473e-4e4e-7a7e32d09720@gmail.com>
 <20190710140504.t5lsk36gnn5cdn6b@flea>
 <e7d78307-4a48-45b1-ffbe-bc397fec0e40@gmail.com>
 <20190711090327.keuxt2ztfqecdbef@flea>
 <de21fe78-87a6-741f-caf7-2771f6468739@gmail.com>
 <20190712081027.arybdoxr6nzrmkxt@flea>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <686a20ce-e09a-037c-a5db-bd1309790c3e@gmail.com>
Date:   Fri, 12 Jul 2019 11:30:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712081027.arybdoxr6nzrmkxt@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.07.2019 11:10, Maxime Ripard пишет:
> On Thu, Jul 11, 2019 at 06:55:03PM +0300, Dmitry Osipenko wrote:
>> 11.07.2019 12:03, Maxime Ripard пишет:
>>> On Wed, Jul 10, 2019 at 06:05:18PM +0300, Dmitry Osipenko wrote:
>>>> 10.07.2019 17:05, Maxime Ripard пишет:
>>>>> On Wed, Jul 10, 2019 at 04:29:19PM +0300, Dmitry Osipenko wrote:
>>>>>> This works:
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>>>>>> index 56d36779d213..e5a2f9c8f404 100644
>>>>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>>>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>>>>> @@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>>>>>>         mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
>>>>>>         if (mode)
>>>>>>                 list_add(&mode->head, &connector->modes);
>>>>>> +       else
>>>>>> +               cmdline_mode->specified = false;
>>>>>
>>>>> Hmmm, it's not clear to me why that wouldn't be the case.
>>>>>
>>>>> If we come back to the beginning of that function, we retrieve the
>>>>> cmdline_mode buffer from the connector pointer, that will probably
>>>>> have been parsed a first time using drm_mode_create_from_cmdline_mode
>>>>> in drm_helper_probe_add_cmdline_mode.
>>>>>
>>>>> Now, I'm guessing that the issue is that in
>>>>> drm_mode_parse_command_line_for_connector, if we have a named mode, we
>>>>> just copy the mode over and set mode->specified.
>>>>>
>>>>> And we then move over to do other checks, and that's probably what
>>>>> fails and returns, but our drm_cmdline_mode will have been modified.
>>>>>
>>>>> I'm not entirely sure how to deal with that though.
>>>>>
>>>>> I guess we could allocate a drm_cmdline_mode structure on the stack,
>>>>> fill that, and if successful copy over its content to the one in
>>>>> drm_connector. That would allow us to only change the content on
>>>>> success, which is what I would expect from such a function?
>>>>>
>>>>> How does that sound?
>>>>
>>>> I now see that there is DRM_MODE_TYPE_USERDEF flag that is assigned only
>>>> for the "cmdline" mode and drm_client_rotation() is the only place in
>>>> DRM code that cares about whether mode is from cmdline, hence looks like
>>>> it will be more correct to do the following:
>>>
>>> I'm still under the impression that we're dealing with workarounds of
>>> a more central issue, which is that we shouldn't return a partially
>>> modified drm_cmdline_mode.
>>>
>>> You said it yourself, the breakage is in the commit changing the
>>> command line parsing logic, while you're fixing here some code that
>>> was introduced later on.
>>
>> The problem stems from assumption that *any* named mode is valid. It
>> looks to me that the ultimate solution would be to move the mode's name
>> comparison into the [1], if that's possible.
>>
>> [1] drm_mode_parse_command_line_for_connector()
> 
> Well, one could argue that video=tegrafb is invalid and should be
> rejected as well, but we haven't cleared that up.

The video=tegrafb is invalid mode, there is nothing to argue here. And
the problem is that invalid modes and not rejected for the very beginning.

>>> Can you try the followintg patch?
>>> http://code.bulix.org/8cwk4c-794565?raw
>>
>> This doesn't help because the problem with the rotation_reflection is
>> that it's 0 if "rotation" not present in the cmdline and then ilog2(0)
>> returns -1. So the patch "drm/modes: Don't apply cmdline's rotation if
>> it wasn't specified" should be correct in any case.
> 
> So we would have the same issue with rotate=0 then?

No, we won't. Rotation mode is parsed into the DRM_MODE bitmask and
rotate=0 corresponds to DRM_MODE_ROTATE_0, which is BIT(0) as you may
notice. Hence rotation_reflection=0 is always an invalid value, meaning
that "rotate" option does not present in the cmdline. Please consult the
code, in particular see drm_mode_parse_cmdline_options() which was
written by yourself ;)
