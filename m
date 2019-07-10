Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6F7C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89F21537
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn1ffGe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfGJPFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:05:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42813 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfGJPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:05:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so2428773lje.9;
        Wed, 10 Jul 2019 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=plj7Pya5YTb4+cAp/1kpLYGyDPb7au0yoFGuKe+7qFY=;
        b=dn1ffGe6dth9Oa2U3ErOvNerY11cGz6vSJElqa5YXlbDwn30Ve3ooVZEXWn4IUU6Bs
         lCd4gQbTwemMSWty9NBDGmwbHsUYE3SYt3Q5RV8UKmx8O138s11CuV12EnV9F+6IpHAb
         BC0Brhev7dXYSCFMTz1QEuWxB2Xfo2dha2glR6d3oEAN3ws7f0FMV4pUfG89QFFEldk6
         bwqBAcgMOdy2IJcN3zGmbusThrE1zwx+jZfXZdb1Xdw/cYIqz7r8I5N6Wqtp9dal1XgZ
         QZL0oVaomRXUvUQQTu/Av76U3o4gWyuwRR03ThcHSdG0j8xI4LYEXFpxfoXFlxDKr4cM
         7hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=plj7Pya5YTb4+cAp/1kpLYGyDPb7au0yoFGuKe+7qFY=;
        b=dLYshCtYYrjkUX4yTQRqY3uTyyeZwod3gBtabqsCKRwm0HeGg8jM92WPJPnOObeZl2
         TczSyuUaZMJwy4kZIqSoLYEXxlaRytzFo+U9MFGKog2wPPmkB4Km3ATyCkmvOdtQBlaA
         ilGt7JqzjGG4anexonTCYFkXTruQI43kPGH0BWNrj4NJOn8JQMmi0K5FxWCKqQleWriw
         ISRkv/bMQEbxyPxsGOcHUyz3SyVtvDsTDNBEGMZqoogJT5eJ619iUJcUlf4lDLsNbtE6
         yWn7CiLPzdpmNW2j+/FGpiWwevBOugoZAhM5rYtZCz9wjAurZTEIF0R3QGMgV6I2fRgI
         zW5A==
X-Gm-Message-State: APjAAAVkzn73i3NJE/2ZVCSk+dPZiFd57Z9PwB1zyrQmVGhEKucldh5S
        hmK2w2tmdMOOVo/GoZpEuR1gOfyn
X-Google-Smtp-Source: APXvYqyE3tu3WfUYC8HKZAgmJ8SO73hKeBP5o5kHfZaJXhL6Y/c0NQz/jCvjk3O3RopNPtYNbJJP5w==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr17934150ljm.180.1562771121206;
        Wed, 10 Jul 2019 08:05:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id u17sm393025lfq.69.2019.07.10.08.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 08:05:19 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e7d78307-4a48-45b1-ffbe-bc397fec0e40@gmail.com>
Date:   Wed, 10 Jul 2019 18:05:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710140504.t5lsk36gnn5cdn6b@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 17:05, Maxime Ripard пишет:
> On Wed, Jul 10, 2019 at 04:29:19PM +0300, Dmitry Osipenko wrote:
>> This works:
>>
>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>> index 56d36779d213..e5a2f9c8f404 100644
>> --- a/drivers/gpu/drm/drm_client_modeset.c
>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>> @@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
>>         mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
>>         if (mode)
>>                 list_add(&mode->head, &connector->modes);
>> +       else
>> +               cmdline_mode->specified = false;
> 
> Hmmm, it's not clear to me why that wouldn't be the case.
> 
> If we come back to the beginning of that function, we retrieve the
> cmdline_mode buffer from the connector pointer, that will probably
> have been parsed a first time using drm_mode_create_from_cmdline_mode
> in drm_helper_probe_add_cmdline_mode.
> 
> Now, I'm guessing that the issue is that in
> drm_mode_parse_command_line_for_connector, if we have a named mode, we
> just copy the mode over and set mode->specified.
> 
> And we then move over to do other checks, and that's probably what
> fails and returns, but our drm_cmdline_mode will have been modified.
> 
> I'm not entirely sure how to deal with that though.
> 
> I guess we could allocate a drm_cmdline_mode structure on the stack,
> fill that, and if successful copy over its content to the one in
> drm_connector. That would allow us to only change the content on
> success, which is what I would expect from such a function?
> 
> How does that sound?

I now see that there is DRM_MODE_TYPE_USERDEF flag that is assigned only
for the "cmdline" mode and drm_client_rotation() is the only place in
DRM code that cares about whether mode is from cmdline, hence looks like
it will be more correct to do the following:

diff --git a/drivers/gpu/drm/drm_client_modeset.c
b/drivers/gpu/drm/drm_client_modeset.c
index 56d36779d213..e5b3be9ed689 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -825,6 +825,7 @@ bool drm_client_rotation(struct drm_mode_set
*modeset, unsigned int *rotation)
 {
        struct drm_connector *connector = modeset->connectors[0];
        struct drm_plane *plane = modeset->crtc->primary;
+       struct drm_display_mode *mode = modeset->mode;
        struct drm_cmdline_mode *cmdline;
        u64 valid_mask = 0;
        unsigned int i;
@@ -859,7 +860,7 @@ bool drm_client_rotation(struct drm_mode_set
*modeset, unsigned int *rotation)
         * simple XOR between the two handle the addition nicely.
         */
        cmdline = &connector->cmdline_mode;
-       if (cmdline->specified) {
+       if (mode->flags & DRM_MODE_TYPE_USERDEF) {
                unsigned int cmdline_rest, panel_rest;
                unsigned int cmdline_rot, panel_rot;
                unsigned int sum_rot, sum_rest;
