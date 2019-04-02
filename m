Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31D52133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y0Cr/gMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfDBLEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:04:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55172 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfDBLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:04:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32B3qL2045684;
        Tue, 2 Apr 2019 06:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554203032;
        bh=ekL+N1CmudRHo9MaT0mJbGgnuLpY00UrgKAZBBLzPv0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y0Cr/gMJme5B6xjk3O5uHZujf5X5H/noHsWOFNeSmQ+Z4guOnQgsUlTeFbzdazpNi
         gDrrpykCIKWe2P4jcWA6HQSRyidNwPTsmE0uZV2eroxDJ5EFNFKU6FJrQNcW9v3DQT
         m0AByEAuNZt1V2/cevkrZ6T56ljx9GzkChSpZufI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32B3qI1010134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 06:03:52 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 06:03:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 06:03:51 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32B3ngP049645;
        Tue, 2 Apr 2019 06:03:49 -0500
Subject: Re: [RESEND PATCH 1/2] ARM: davinci: support multiplatform build for
 ARM v5
To:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318122901.7231-1-brgl@bgdev.pl>
 <20190318122901.7231-2-brgl@bgdev.pl>
 <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c1fa9027-3f92-5edd-6e5b-be4889e5363c@ti.com>
Date:   Tue, 2 Apr 2019 16:33:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0EhCRH7O87WSyfHujomQ_Dzz3=BT0SaXF-33Z9g0oSjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/19 6:38 PM, Arnd Bergmann wrote:
> On Mon, Mar 18, 2019 at 1:29 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add modifications necessary to make davinci part of the ARM v5
>> multiplatform build.
>>
>> Move the arch-specific configuration out of arch/arm/Kconfig and
>> into mach-davinci/Kconfig. Remove the sub-menu for DaVinci
>> implementations (they'll be visible directly under the system type.
>> Select all necessary options not already selected by ARCH_MULTI_V5.
>> Update davinci_all_defconfig. Explicitly include the mach-specific
>> headers in mach-davinci/Makefile.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> I like this a lot, it gives me some hope that we can eventually
> do the same for the remaining ARMv5 platforms that are
> not multiplatform yet (s3c24xx, ks8695, w90x900, lpc32xx,
> omap1, ep93xx, and maybe even the xscale based ones).
> 
> I have done a lot of randconfig testing with this patch appled now
> and not found any issues, great work!

Thanks Arnd. Will take this as your Acked-by:

The timer conversion patches are pending review/rework. Will queue once
those are cleared.

Regards,
Sekhar
