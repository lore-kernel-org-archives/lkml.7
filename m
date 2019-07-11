Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4353C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DE020644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebzoQHp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfGKPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:55:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfGKPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:55:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so6290700ljv.10;
        Thu, 11 Jul 2019 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yBVyR6ZJ0iQUUa+9rzC5FP5zydV7ynjfxBMM816XPLM=;
        b=ebzoQHp2Iefm7DqbiL2uxAJ0FnEG+6T5H0RDLOMUGDGgZVDCpdCAncry3BSUzYCnRi
         CuwLx4Rnd5cUdD1kLLQYO78a+AhFBDdDeXJdzAFl1xZ54sSoGHCMa6aSwxBbm89tOPXh
         nowuvtlI7QbRLokizmjukvfCImbXMsk0vzP64RtWiUn2bfyM3OZkldpQvye+P036TZGa
         S1S+q0CbObjfU0VDgnwYVALBvqrxZt4yfRd+k0bu566Jqu8ZvfwwHAfAyeqI/LTL1Fvv
         AuWeykkthtJuacGxjmFT9A7hobTPPaoB/YdHyOQMhBIjXxDYGzDBI/6GBrgGufluCAmm
         JSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBVyR6ZJ0iQUUa+9rzC5FP5zydV7ynjfxBMM816XPLM=;
        b=OZ61xa0wUE1bG7EcyMvaa1STygjlM9F/VCvFhT8gjoI5ajOM7w5LDNArvVJZHFhAkw
         Zj5iaiMcjWaLvQoMWquijiC7sVYN7h3utoVoA7S3tWwZHnwFlw3gvwZgWGT/b2wTGWrg
         iRpM3kTvDsD6Q+IoI3K4cC8PTaPzcthVwpuKG+4BbgqmuQSUMZPu/2FHRvs409i2I/H6
         vJ+W9t04N4vWaCfZ7JsLUIm+cQfY2oyOKvBNSmfe1soPunT+iS9QjC3UuloEEOTMsr/k
         RfDmTNSBwWWS2OBZSluM7dpX0EgZMNkL+P9QKnigc91fSWnVM2FuvnPclYGJyAyu/DMs
         SNoQ==
X-Gm-Message-State: APjAAAUTS/eQ2+H+EOXHbqOg35s1uN0/FM+iwc1pKYqTkZE9R7BZ6LOs
        GZjyyo9frPYrgPIO7adZhBaLNlEE
X-Google-Smtp-Source: APXvYqyTK8sBETfS3g9KzxOaVoj9h5C7ZRbwY9iiH0Btpm54oU0IvlRjihXZjOZ82rrVj7UccdF6Pw==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr3029754ljb.186.1562860506034;
        Thu, 11 Jul 2019 08:55:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id a70sm1032963ljf.57.2019.07.11.08.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 08:55:05 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
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
 <20190711090327.keuxt2ztfqecdbef@flea>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de21fe78-87a6-741f-caf7-2771f6468739@gmail.com>
Date:   Thu, 11 Jul 2019 18:55:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711090327.keuxt2ztfqecdbef@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.07.2019 12:03, Maxime Ripard пишет:
> On Wed, Jul 10, 2019 at 06:05:18PM +0300, Dmitry Osipenko wrote:
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
> 
> I'm still under the impression that we're dealing with workarounds of
> a more central issue, which is that we shouldn't return a partially
> modified drm_cmdline_mode.
> 
> You said it yourself, the breakage is in the commit changing the
> command line parsing logic, while you're fixing here some code that
> was introduced later on.

The problem stems from assumption that *any* named mode is valid. It
looks to me that the ultimate solution would be to move the mode's name
comparison into the [1], if that's possible.

[1] drm_mode_parse_command_line_for_connector()

> Can you try the followintg patch?
> http://code.bulix.org/8cwk4c-794565?raw

This doesn't help because the problem with the rotation_reflection is
that it's 0 if "rotation" not present in the cmdline and then ilog2(0)
returns -1. So the patch "drm/modes: Don't apply cmdline's rotation if
it wasn't specified" should be correct in any case.
