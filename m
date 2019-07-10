Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A40DC71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B84A2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StYp8lyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfGJMme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:42:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45220 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfGJMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:42:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so1903147lje.12;
        Wed, 10 Jul 2019 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SaYCgTca3sd4iZ2y4Hurjp1FivgyQ/okDm47EWmj7hc=;
        b=StYp8lySiG1t3rWrCk1RzdObODtoNN3M/d5jCJvsQedwGPLuCSmiBx/w1LaHbHFBgl
         IW+kkJFyaUBp09u3k5VqkReqlcgUfOobnH8TQDrFU0OR+Liynqa8yY2NxZLOzag7KUT1
         xCJCIUw/qeUpp3J+PSkmXkFC1wEJNMB0ySnOXLazvLNFVsf0WDQod9shSiT40woQDRzt
         3kEHD3fpkyI7jbriqPscoEqppfz1fxGz5f9WTCG+U0mFSoFFYGmkT1CxrM6OT850kyI6
         TTqE2IEKoUZfN8fzfYoPZV1GWkDrtiFaySStTqhFu17j+UF1MPIRJlHbfX/NR8LuSGK4
         0Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SaYCgTca3sd4iZ2y4Hurjp1FivgyQ/okDm47EWmj7hc=;
        b=UpW68VWR+9Nz3Q/r4Sf0j1EjDbJiOJnhN+gRFQp0sIYLjq2S0WY7pV4izbIK88VZ2V
         ONV++KrdaagtaxxDfnGawqBDGbllot52eHeWOQ/NO/iU78E/+mcYSTvA0h2nTypFsPpL
         0LW172djIqYj5MW3HVgVCAXzGC8TBkkwo0dGx93T4m84jysTuxpiGiFxnC6d3GeBzzOn
         yW0JHjE/ReWQXurxon6SQchcUCmBAb9wfhhcnIT0u6SOwJNFiPxLb4oWvy/YhaKibntO
         zN5hvr+A+1Y927xx5aCKTPFk1SuZ5eTlQOaTSLKXX2TP5C/KdWkS0Q4c+sM5HzXvXx3s
         cUeQ==
X-Gm-Message-State: APjAAAV2G7fkKef2MlA0LwIci0+WlYMYzbSnfswNPlISAEeaSTEkWKqv
        wmeIQDBSNyNA41fwzlq4BL7El/N4
X-Google-Smtp-Source: APXvYqyv9qEg1ZlrIdBVCuMpXtGYZG0FA071/mv/amZvqdKqsia+jiOwNz2oyczUb0a57xAb31Vn7w==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr17637479ljg.134.1562762551887;
        Wed, 10 Jul 2019 05:42:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id n187sm343784lfa.30.2019.07.10.05.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 05:42:29 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
Date:   Wed, 10 Jul 2019 15:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710101229.54ufuhmh22dfxclr@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 13:12, Maxime Ripard пишет:
> On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
>> The named mode could be invalid and then cmdline parser misses to validate
>> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
>> this happens is NVIDIA Tegra devices that are using downstream bootloader
>> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
>> DRM driver fails to probe because of the invalid mode.
>>
>> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Applied to drm-misc-next-fixes
> 
> Thanks for figuring this out!

Thank you very much! So the driver now doesn't fail to probe because of the cmdline, but
what else I noticed is that the framebuffer console is now rotated by 90° on a 800x1280
panel, while display in Xorg is vertical as it was before. Seems something else is still
missing, reverting "drm/modes: Rewrite the command line parser" returns the framebuffer's
console orientation
into the original state.
