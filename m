Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BECAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3374B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUFG1Adq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKOLkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:40:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43695 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfKOLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:39:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so10324368ljh.10;
        Fri, 15 Nov 2019 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UmAi2H6KzYBMsHnO/QLE+PxP3dI7L9bn6T/LMsCVk58=;
        b=pUFG1AdqOH3wjtFFxLf+iHxJHmMCAwgWgYt+Kf3UyMAZ8bJihvtybvsikZGmmp112C
         Lpw3J8laa3CZUtx8wTHJAINyLMHI3B1wa6KPuYAJ9i1wsDm34ZXeacBUzobWMT2TFXVx
         appDjFnTPzXY3pC/qtpoxSZYWha+Xe0qEFthv24Zm1aGzVhCX9jCPHsdh+yI5Et/hSM4
         Ha/wxLHHxJ9z5P1/DkG4lij87MvGa1CpJ2mXBBXzE3PGJlkuayMX1e8pEp+B1IwfNv7p
         q4m9I5adKBIsEa8r//xd0qs9+FrMAR+0xOQdEb2gHugAYWx8j1sfvzNmmbbqU/nv6vO4
         FTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmAi2H6KzYBMsHnO/QLE+PxP3dI7L9bn6T/LMsCVk58=;
        b=g72FVGyqP/8TQw8fmv0Fwf9rUedryhgzd0WHgCpIcYSyh0TuJxErbo9KXXAFMA4QQb
         6uJdHMokR25VRio1N0YrZSdvPnrH8qTwRIAxr5Dwm3N+/NhmpKNBbCK46p8YAsUInn4P
         +K4MNhg/EJEiOSRv4iGDoikuCXRCZ5q6kmqRz7WvK0saMFZA9QuG1fWbDx4VM+uYGD1F
         VjILLD/IKzIptnktVJixfjs0hh5u8e+gGow6XhrmepIDapFPAXS+9+A2tsfhmmvyYoRx
         62Kio/DGNaoVKB1z3DEEKGTo3JMcTMwd6yQwxwDRV88bKwSLKZ1pH0fPQG0ABeOiKPNr
         u/bw==
X-Gm-Message-State: APjAAAWPHs3GWxV1/j6Lm971OBuKafLVChN1h3T3baR6E5bfvhuJUlkb
        e6LGAaNIX4DMM/G8OkrF5KS7uEpI
X-Google-Smtp-Source: APXvYqxw/RuX+HC0aay7/RhWP6COvieyS/R8ADY2Pgeb/UJPnoCtNftVN+PW0z9r8FrtZdTBXp08Rg==
X-Received: by 2002:a2e:9712:: with SMTP id r18mr11130390lji.12.1573817996154;
        Fri, 15 Nov 2019 03:39:56 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id r22sm4067987lji.71.2019.11.15.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:39:55 -0800 (PST)
Subject: Re: [PATCH v2] drm/tegra: Turn off and reset hardware across
 suspend-resume
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811183932.15850-1-digetx@gmail.com>
 <20191114203117.GA761559@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3b8e79ad-598c-f0f7-4589-00bb0acc1867@gmail.com>
Date:   Fri, 15 Nov 2019 14:39:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114203117.GA761559@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

14.11.2019 23:31, Thierry Reding пишет:
> On Sun, Aug 11, 2019 at 09:39:32PM +0300, Dmitry Osipenko wrote:
>> The drivers core bumps runtime PM refcount during of entering into
>> suspend to workaround some problem where parent device may become turned
>> off before its children. In order to disable and reset CRTCs/HDMI/etc
>> hardware, the runtime PM needs to be "forced" into suspend mode.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2: The SYSTEM_SLEEP_PM_OPS are now set for all of the relevant drivers and
>>     not only for the DC because turned out that they all should enforce the
>>     suspending.
>>
>>  drivers/gpu/drm/tegra/dc.c    | 2 ++
>>  drivers/gpu/drm/tegra/dpaux.c | 2 ++
>>  drivers/gpu/drm/tegra/dsi.c   | 2 ++
>>  drivers/gpu/drm/tegra/hdmi.c  | 2 ++
>>  drivers/gpu/drm/tegra/hub.c   | 2 ++
>>  drivers/gpu/drm/tegra/sor.c   | 2 ++
>>  drivers/gpu/drm/tegra/vic.c   | 2 ++
>>  7 files changed, 14 insertions(+)
> 
> I'm not exactly sure I understand why this is necessary. Runtime PM is
> controlled by the drivers themselves so that when an output (say SOR) is
> disabled, it drops the runtime PM reference. The idea is that since the
> disabled output is no longer needed it can just go into a low power mode
> which on Tegra usually means clocks off and reset asserted (and in some
> cases also power domain off).
> 
> DRM/KMS has system-level suspend support, which we use to disable all
> outputs when entering suspend. I see that, unfortunately, this doesn't
> seem to actually cause the devices to runtime suspend. I'm pretty sure
> that this used to work at some point, so I don't know what changed. I'd
> have to look into this a little more. The core doing something like this
> behind the driver's back seems wrong and having to force the device into
> suspend mode seems like it's just piling up on the workarounds.

Please let me know if you'll find a better solution.

