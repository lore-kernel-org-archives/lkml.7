Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFBC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949342064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8gwQ0Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGJN3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:29:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39449 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:29:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so2094136ljh.6;
        Wed, 10 Jul 2019 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qt0Z/EWbx8ePpfO2WoHAwWkGi24LP5aE69SRcQxeOl4=;
        b=E8gwQ0JcP09G+sf7foN3IbkHFxswbokNmJfjLp715V9h7UwX7pgEjsdxkm+Qaza+4r
         CiWLwN5xczr1NadRbDEd4AamdpNJ47POYevXw3xuRAgK20QmMD6aTZLTZ3OHOfMlAAql
         CcSN9WPUeFHnjWRxjbtjtYZsi0+Zjg24+5fMsU53e4egQ9uWZsT3SolUkmRLlwKTk3Vn
         jg0xtbi75P22KHO4stsUzDfTPeiJp1sBwbMm5wztP7h1L72Sct+n0pEwETTCNLYHmatH
         szhEi1JqseLl697eId7aNUNk01P3aWf5gHNEW0YGQcat3cIfMC+TFVlm1m2tItIv4OZp
         1EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qt0Z/EWbx8ePpfO2WoHAwWkGi24LP5aE69SRcQxeOl4=;
        b=QozFmwB/TPGRP+dvWHQL+0qcfURFTUHwZ/KlJuby+FuOn4gkmwnik2oGnEblNiMsOU
         BmyC7wxTYsLftOVEYeNHM+DruXHLS7kYO9ta2lgyGzv217ofnaIeXrGrV7vS/SGuPZ6a
         hdQS7GcIvmglGqSsnNrYGXEfNWA89PYHlaNGBFoGUI0dzVC82B3lc3NKvBvF9cBvBQbX
         Z3gWJTIxdNRsnAKHT/3cTlJpI3Bs5i+iC0CxTUUQvNFkE9dJ5WLi8aGjTViNCEo9tIQP
         nJjcExKRyxAGk0L8H7dVAbAqUsEBBwOJVUuzeJG00C1r1h7+MBZq082GId179i1CS1Ku
         WOqw==
X-Gm-Message-State: APjAAAU/A+7VH5RiQG7uBfaNWo87GFWJ98uMzSLJrOkHeJqOW/mGrV3Z
        GbVrdD0w5smE7GpO0WSEZl8GQROF
X-Google-Smtp-Source: APXvYqz8iVPXqFHBElQG4wJKWcmnRVe9O/IR6c1zHhFPvkZQEg/Op6pK7aEtG1dk+k06oHE6veiY4w==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr17533553ljk.106.1562765360632;
        Wed, 10 Jul 2019 06:29:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id r68sm358666lff.52.2019.07.10.06.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 06:29:20 -0700 (PDT)
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
Message-ID: <4a13f12f-05a7-473e-4e4e-7a7e32d09720@gmail.com>
Date:   Wed, 10 Jul 2019 16:29:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <75719cad-c65c-7ebc-3ea8-98134f86ddc3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 16:11, Dmitry Osipenko пишет:
> 10.07.2019 16:06, Maxime Ripard пишет:
>> On Wed, Jul 10, 2019 at 03:59:55PM +0300, Dmitry Osipenko wrote:
>>> 10.07.2019 15:55, Maxime Ripard пишет:
>>>> On Wed, Jul 10, 2019 at 03:42:28PM +0300, Dmitry Osipenko wrote:
>>>>> 10.07.2019 13:12, Maxime Ripard пишет:
>>>>>> On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
>>>>>>> The named mode could be invalid and then cmdline parser misses to validate
>>>>>>> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
>>>>>>> this happens is NVIDIA Tegra devices that are using downstream bootloader
>>>>>>> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
>>>>>>> DRM driver fails to probe because of the invalid mode.
>>>>>>>
>>>>>>> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>
>>>>>> Applied to drm-misc-next-fixes
>>>>>>
>>>>>> Thanks for figuring this out!
>>>>>
>>>>> Thank you very much! So the driver now doesn't fail to probe because
>>>>> of the cmdline, but what else I noticed is that the framebuffer
>>>>> console is now rotated by 90° on a 800x1280 panel, while display in
>>>>> Xorg is vertical as it was before. Seems something else is still
>>>>> missing, reverting "drm/modes: Rewrite the command line parser"
>>>>> returns the framebuffer's console orientation into the original
>>>>> state.
>>>>
>>>> What is the whole command line passed by the bootloader ?
>>>
>>> tegraid=30.1.3.0.0 mem=1022M@2048M android.commchip=0 vmalloc=512M androidboot.serialno=015d3f18c9081210 video=tegrafb no_console_suspend=1 console=none
>>> debug_uartport=hsport usbcore.old_scheme_first=1 lp0_vec=8192@0xbddf9000 tegra_fbmem=8195200@0xabe01000 core_edp_mv=0 audio_codec=rt5640 board_info=f41:a00:1:44:2
>>> root=/dev/sda1 rw rootwait tegraboot=sdmmc gpt gpt_sector=61079551 androidboot.bootloader=4.23 androidboot.baseband=1231_0.18.0_0409
>>
>> Thanks.
>>
>> It still doesn't really make sense to me why that video=tegrafb should
>> be considered valid.
>>
>> However, I don't see anything rotation related in the commit you
>> list. Are you sure it's really the offending one and not another one?
> 
> Yes.
> 
>> Also, do you have the option to recompile a kernel so that we can add
>> some debug?
> 
> Recompiling kernel is not a problem at all.
> 
> Before "drm/modes: Rewrite the command line parser":
> 
> [    1.256454] [drm] parse error at position 6 in video mode 'tegrafb'
> [    1.256654] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.256664] [drm] No driver support for vblank timestamp query.
> [    1.256703] [drm:drm_client_modeset_probe]
> [    1.256719] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1]
> [    1.256731] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] status updated from unknown to connected
> [    1.256828] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] probed modes :
> [    1.256842] [drm:drm_mode_debug_printmodeline] Modeline "800x1280": 60 66770 800 849 882 899 1280 1281 1288 1303 0x48 0xa
> [    1.256849] [drm:drm_client_modeset_probe] connector 95 enabled? yes
> [    1.256859] [drm:drm_client_modeset_probe] Not using firmware configuration
> [    1.256867] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 95
> [    1.256874] [drm:drm_client_modeset_probe] looking for preferred mode on connector 95 0
> [    1.256880] [drm:drm_client_modeset_probe] found mode 800x1280
> [    1.256886] [drm:drm_client_modeset_probe] picking CRTCs for 4096x4096 config
> [    1.256896] [drm:drm_client_modeset_probe] desired mode 800x1280 set on crtc 94 (0,0)
> [    1.279069] [drm:tegra_crtc_atomic_enable] rate: 408000000, div: 10
> [    1.279077] [drm:tegra_crtc_atomic_enable] pclk: 0
> [    1.296744] [drm:drm_fb_helper_hotplug_event.part.0]
> [    1.296760] [drm:drm_client_modeset_probe]
> [    1.296792] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1]
> [    1.296987] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] probed modes :
> [    1.297010] [drm:drm_mode_debug_printmodeline] Modeline "800x1280": 60 66770 800 849 882 899 1280 1281 1288 1303 0x48 0xa
> [    1.297022] [drm:drm_client_modeset_probe] connector 95 enabled? yes
> [    1.297040] [drm:drm_client_modeset_probe] Not using firmware configuration
> [    1.297054] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 95
> [    1.297065] [drm:drm_client_modeset_probe] looking for preferred mode on connector 95 0
> [    1.297073] [drm:drm_client_modeset_probe] found mode 800x1280
> [    1.297083] [drm:drm_client_modeset_probe] picking CRTCs for 800x1280 config
> [    1.297102] [drm:drm_client_modeset_probe] desired mode 800x1280 set on crtc 94 (0,0)
> 
> After:
> 
> [    1.225000] [drm:drm_connector_init] cmdline mode for connector LVDS-1 tegrafb 0x0@60Hz
> [    1.225143] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.225154] [drm] No driver support for vblank timestamp query.
> [    1.225182] [drm:drm_client_modeset_probe]
> [    1.225195] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1]
> [    1.225203] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] status updated from unknown to connected
> [    1.225283] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] probed modes :
> [    1.225294] [drm:drm_mode_debug_printmodeline] Modeline "800x1280": 60 66770 800 849 882 899 1280 1281 1288 1303 0x48 0xa
> [    1.225299] [drm:drm_client_modeset_probe] connector 95 enabled? yes
> [    1.225307] [drm:drm_client_modeset_probe] Not using firmware configuration
> [    1.225314] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 95
> [    1.225319] [drm:drm_client_modeset_probe] looking for preferred mode on connector 95 0
> [    1.225323] [drm:drm_client_modeset_probe] found mode 800x1280
> [    1.225328] [drm:drm_client_modeset_probe] picking CRTCs for 4096x4096 config
> [    1.225336] [drm:drm_client_modeset_probe] desired mode 800x1280 set on crtc 94 (0,0)
> [    1.249051] [drm:tegra_crtc_atomic_enable] rate: 408000000, div: 10
> [    1.249058] [drm:tegra_crtc_atomic_enable] pclk: 0
> [    1.266748] [drm:drm_fb_helper_hotplug_event.part.0]
> [    1.266768] [drm:drm_client_modeset_probe]
> [    1.266805] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1]
> [    1.267045] [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:95:LVDS-1] probed modes :
> [    1.267074] [drm:drm_mode_debug_printmodeline] Modeline "800x1280": 60 66770 800 849 882 899 1280 1281 1288 1303 0x48 0xa
> [    1.267091] [drm:drm_client_modeset_probe] connector 95 enabled? yes
> [    1.267113] [drm:drm_client_modeset_probe] Not using firmware configuration
> [    1.267129] [drm:drm_client_modeset_probe] looking for cmdline mode on connector 95
> [    1.267143] [drm:drm_client_modeset_probe] looking for preferred mode on connector 95 0
> [    1.267155] [drm:drm_client_modeset_probe] found mode 800x1280
> [    1.267168] [drm:drm_client_modeset_probe] picking CRTCs for 800x1280 config
> [    1.267191] [drm:drm_client_modeset_probe] desired mode 800x1280 set on crtc 94 (0,0)
> 

This works:

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 56d36779d213..e5a2f9c8f404 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
        mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
        if (mode)
                list_add(&mode->head, &connector->modes);
+       else
+               cmdline_mode->specified = false;

        return mode;
 }

I'll make a proper patch later today if there are no objections.
