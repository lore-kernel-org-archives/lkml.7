Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD354C74820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE582084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZMHBsxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGJNAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:00:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35412 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfGJM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:59:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so2013578ljh.2;
        Wed, 10 Jul 2019 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7ylOxfLdhUvUzU0fEvFs37rFjaeIPMVCihg4Np+yiM=;
        b=bZMHBsxJ8aQL5q16//D1P0Kakf6jjGLqfBX3KWpIqnfbjKhyhGk4JFP5Zh8yrBtV9D
         yFUwyD214OB4RhTTE1FwWKvcdaWQFSiw86DE44C9ki+NtX3vZ0L3n77ohnZcsGRbsLx2
         M7HVjLcUUKFUpTgouNnuV+cpmxk0P7YjuMLW0/N8mx4Ggi7R+tqniIOBgEA4u/cgrblq
         aDn/4dTj+lxZlnpniTeuTTdPwa67iIphdYc7aORIUU8JiWyp2ja2P9RBa5qlptkddm9Z
         DWOORKvuDKvLSMm5CGF6djJsk40gY/vrBl5yfI0zEcmeqIErTzHb7DpDyrelEQROElba
         VIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7ylOxfLdhUvUzU0fEvFs37rFjaeIPMVCihg4Np+yiM=;
        b=gGDlPyKovbX0Z33dh0uxvfp2ZkoPXCjZMYW+xPqEIcUOhM37BdcFrGlKCIOXlahdz1
         oU3fbU6sDnr7Cn7eK4Kqp9aqOszjjTifSH4m/k6K0D+P+TyL4uWoziUmvWJbaN3ZcGjB
         DAc1AmcLhVEeVgwdxPhscN1EwzEHrssaIGOhHPTNM+I1eueJ6FDux+ej0e/kHLD+a2G2
         WzEInV2prDlzFBx+U8yfPk7P59SRJKOqqAdhF5Js38p5NoXpyVn4JuAtkFBA9R27Y4kT
         5bIxejo4DuzV0bO+pXgpvXiYD6Kfw1sJAXQA3ov6q5Lyd7OutslREhvHcHkLmfsK+CEP
         jJFg==
X-Gm-Message-State: APjAAAX7sdnZT+PoEgxRaeFiF5hcpdmRYwcpEstLj4Gh3/ABQLKMcb8M
        T2famRihTf2KR2uwx9nt/aQdbAeT
X-Google-Smtp-Source: APXvYqyAyHtKzYMLhhmkEVzL6+xprN6WUNXA9HHsaLCcX60VB8Jr0lUDrhqT1ogbtvOM4mRgykGpIg==
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr17744867ljk.29.1562763596585;
        Wed, 10 Jul 2019 05:59:56 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id f24sm380661lfk.72.2019.07.10.05.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 05:59:55 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
Date:   Wed, 10 Jul 2019 15:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710125552.qvmnh6qs63ikiu2k@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.07.2019 15:55, Maxime Ripard пишет:
> On Wed, Jul 10, 2019 at 03:42:28PM +0300, Dmitry Osipenko wrote:
>> 10.07.2019 13:12, Maxime Ripard пишет:
>>> On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
>>>> The named mode could be invalid and then cmdline parser misses to validate
>>>> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
>>>> this happens is NVIDIA Tegra devices that are using downstream bootloader
>>>> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
>>>> DRM driver fails to probe because of the invalid mode.
>>>>
>>>> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> Applied to drm-misc-next-fixes
>>>
>>> Thanks for figuring this out!
>>
>> Thank you very much! So the driver now doesn't fail to probe because
>> of the cmdline, but what else I noticed is that the framebuffer
>> console is now rotated by 90° on a 800x1280 panel, while display in
>> Xorg is vertical as it was before. Seems something else is still
>> missing, reverting "drm/modes: Rewrite the command line parser"
>> returns the framebuffer's console orientation into the original
>> state.
> 
> What is the whole command line passed by the bootloader ?

tegraid=30.1.3.0.0 mem=1022M@2048M android.commchip=0 vmalloc=512M androidboot.serialno=015d3f18c9081210 video=tegrafb no_console_suspend=1 console=none
debug_uartport=hsport usbcore.old_scheme_first=1 lp0_vec=8192@0xbddf9000 tegra_fbmem=8195200@0xabe01000 core_edp_mv=0 audio_codec=rt5640 board_info=f41:a00:1:44:2
root=/dev/sda1 rw rootwait tegraboot=sdmmc gpt gpt_sector=61079551 androidboot.bootloader=4.23 androidboot.baseband=1231_0.18.0_0409
