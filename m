Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87433217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kukr2Ouj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfHHJR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:17:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38016 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfHHJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:17:28 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x789GZ3Q049234;
        Thu, 8 Aug 2019 04:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565255795;
        bh=AFN9O6o9mO07bhZK9Vv8bZWmYFDF2zWncPLyZjoemxY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Kukr2OujeHdmin+Dhy+sXx3hc0wul8G91sEguAj80/HXxgbUG05pusdWWLB7jpdF8
         cU5G1SnN5QRrxscoB3W7vT2/CXDLlhTRITju7Sfz6RXmxku781Bud84p+FwmHUQofk
         q+fzFMCBaYDz1nTKAErgvlR8ROTd/JGHypENrBX8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x789GZev114711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Aug 2019 04:16:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 8 Aug
 2019 04:16:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 8 Aug 2019 04:16:34 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x789GVX8101829;
        Thu, 8 Aug 2019 04:16:32 -0500
Subject: Re: [PATCH v2 0/9] ARM: davinci: da850-evm: remove more legacy GPIO
 calls
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190722134423.26555-1-brgl@bgdev.pl>
 <CAMRc=Me51RgQu8VK70dy=1OhmHeKo40HLxfsvp2nD5UC+Mzb=w@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <408dc72e-eb4e-ea8d-2c5d-f7300a7a296d@ti.com>
Date:   Thu, 8 Aug 2019 14:46:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me51RgQu8VK70dy=1OhmHeKo40HLxfsvp2nD5UC+Mzb=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 2:00 PM, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 15:44 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is another small step on the path to liberating davinci from legacy
>> GPIO API calls and shrinking the davinci GPIO driver by not having to
>> support the base GPIO number anymore.
>>
>> This time we're removing the legacy calls used indirectly by the LCDC
>> fbdev driver.
>>
>> First two patches enable the GPIO backlight driver in
>> davinci_all_defconfig.
>>
>> Patch 3/12 models the backlight GPIO as an actual GPIO backlight device.
>>
>> Patches 4-6 extend the fbdev driver with regulator support and convert
>> the da850-evm board file to using it.
>>
>> Last three patches are improvements to the da8xx fbdev driver since
>> we're already touching it in this series.
>>
>> v1 -> v2:
>> - dopped the gpio-backlight patches from this series as since v5.3-rc1 we
>>   can probe the module with neither the OF node nor platform data
>> - collected review and ack tags
>> - rebased on top of v5.3-rc1
>>
>> Bartosz Golaszewski (9):
>>   ARM: davinci: refresh davinci_all_defconfig
>>   ARM: davinci_all_defconfig: enable GPIO backlight
>>   ARM: davinci: da850-evm: model the backlight GPIO as an actual device
>>   fbdev: da8xx: add support for a regulator
>>   ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
>>   fbdev: da8xx: remove panel_power_ctrl() callback from platform data
>>   fbdev: da8xx-fb: use devm_platform_ioremap_resource()
>>   fbdev: da8xx-fb: drop a redundant if
>>   fbdev: da8xx: use resource management for dma
>>
>>  arch/arm/configs/davinci_all_defconfig  |  27 ++----
>>  arch/arm/mach-davinci/board-da850-evm.c |  90 +++++++++++++-----
>>  drivers/video/fbdev/da8xx-fb.c          | 118 +++++++++++++-----------
>>  include/video/da8xx-fb.h                |   1 -
>>  4 files changed, 141 insertions(+), 95 deletions(-)
>>
>> --
>> 2.21.0
>>
> 
> Hi Sekhar,
> 
> the fbdev patches have been acked by Bartlomiej. I think the entire
> series can go through the ARM-SoC tree.

Applied for v5.4. Will queue through ARM-SoC.

Thanks,
Sekhar
