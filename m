Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32FB2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pKqFFrXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfHGT2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:28:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33634 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbfHGT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:28:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77JSBXa037788;
        Wed, 7 Aug 2019 14:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565206091;
        bh=s6qSTw4uTX39/wpqBURdlKljFoXZCZOw10ItvX2ujn8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pKqFFrXDQyVK7s7VZsnG3SWq6eqC22upoTejwXJgs5xLmN2H0WmTVZrQwDjzrRzi8
         BtOadbBo0buFSd3SqsBI+xBLclboHD15ICggPNvr553nmd0tOvGJ4uHXpZEGI9zQ1N
         pTK4Lg9GXoQR4mg0+SvON2Y69SghTduKB/1xcrXU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77JSA2l119747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 14:28:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 14:28:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 14:28:10 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77JS8MS120779;
        Wed, 7 Aug 2019 14:28:09 -0500
Subject: Re: [RESEND PATCH 00/10] ARM: davinci: use the new clocksource driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190722131748.30319-1-brgl@bgdev.pl>
 <CAMRc=Mes8dEwscGU8LLQ5CcxmUnhBwt2iP0wk1qNRjRwy8CcFA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <9e5704a3-8169-1575-4027-61d36c5e39b4@ti.com>
Date:   Thu, 8 Aug 2019 00:58:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mes8dEwscGU8LLQ5CcxmUnhBwt2iP0wk1qNRjRwy8CcFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 1:59 PM, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 15:17 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Sekhar,
>>
>> the following patches switch DaVinci to using the new clocksource driver which
>> is now upstream. They are rebased on top of v5.3-rc1. Additionally the
>> following two patches were reverted locally due to a regression in v5.3-rc1
>> about which the relevant maintainers have been already notified:
>>
>>   2eef1399a866 modules: fix BUG when load module with rodata=n
>>   93651f80dcb6 modules: fix compile error if don't have strict module rwx
>>
>> Bartosz Golaszewski (10):
>>   ARM: davinci: enable the clocksource driver for DT mode
>>   ARM: davinci: WARN_ON() if clk_get() fails
>>   ARM: davinci: da850: switch to using the clocksource driver
>>   ARM: davinci: da830: switch to using the clocksource driver
>>   ARM: davinci: move timer definitions to davinci.h
>>   ARM: davinci: dm355: switch to using the clocksource driver
>>   ARM: davinci: dm365: switch to using the clocksource driver
>>   ARM: davinci: dm644x: switch to using the clocksource driver
>>   ARM: davinci: dm646x: switch to using the clocksource driver
>>   ARM: davinci: remove legacy timer support
>>
>>  arch/arm/Kconfig                            |   1 +
>>  arch/arm/mach-davinci/Makefile              |   3 +-
>>  arch/arm/mach-davinci/da830.c               |  45 +--
>>  arch/arm/mach-davinci/da850.c               |  50 +--
>>  arch/arm/mach-davinci/davinci.h             |   3 +
>>  arch/arm/mach-davinci/devices-da8xx.c       |   1 -
>>  arch/arm/mach-davinci/devices.c             |  19 -
>>  arch/arm/mach-davinci/dm355.c               |  28 +-
>>  arch/arm/mach-davinci/dm365.c               |  26 +-
>>  arch/arm/mach-davinci/dm644x.c              |  28 +-
>>  arch/arm/mach-davinci/dm646x.c              |  28 +-
>>  arch/arm/mach-davinci/include/mach/common.h |  17 -
>>  arch/arm/mach-davinci/include/mach/time.h   |  35 --
>>  arch/arm/mach-davinci/time.c                | 414 --------------------
>>  14 files changed, 110 insertions(+), 588 deletions(-)
>>  delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
>>  delete mode 100644 arch/arm/mach-davinci/time.c
>>
>> --
>> 2.21.0
>>
> 
> Hi Sekhar,
> 
> a gentle ping. Is this series good to go in for v5.4?

Hi Bartosz, a quick test shows that DM365 fails to boot after this. Can
you please see if there is anything obviously wrong for that SoC. Rest
seems to be okay.

Thanks,
Sekhar
