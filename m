Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE291C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648D206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aYvQZEU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfC1KKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:10:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1KKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:10:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2SAACeB110310;
        Thu, 28 Mar 2019 05:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553767812;
        bh=RzuD2FRXkAVJEOTOw5dic7x/3ioNoeko1WqiTXRHgeo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aYvQZEU3ztpye4NfbwqZ2iQMnEE1u5PeILo5wikOR61ZxoubakaNnUmQqlxREcHRw
         a0Et5L3V0yA1LkVfEtuha+C+z1SDx9MYCjpAMFyypTsyZAtKpO56n3bRU90NwdFFSL
         6M45z7P1ah2iZVcGYep3p+iP2uRzgofc1K8Wu69I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2SAACBf103399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Mar 2019 05:10:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 28
 Mar 2019 05:10:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 28 Mar 2019 05:10:12 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2SAA8Bn048890;
        Thu, 28 Mar 2019 05:10:09 -0500
Subject: Re: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190326155728.5432-1-brgl@bgdev.pl>
 <712540aa-6927-9141-4f0c-740193d26f33@ti.com>
 <CAMRc=McPzhOy9Ebp+hDC1eiSKJBf-q9gCeD_WMF5Wa4SSBR=dg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <3d7f7814-6184-96c6-8087-6373a489ebc0@ti.com>
Date:   Thu, 28 Mar 2019 15:40:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McPzhOy9Ebp+hDC1eiSKJBf-q9gCeD_WMF5Wa4SSBR=dg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/19 6:46 PM, Bartosz Golaszewski wrote:
> śr., 27 mar 2019 o 12:37 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> Hi Bart,
>>
>> On 26/03/19 9:27 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Adding the vbus GPIO support to the ohci-da8xx driver isn't really the
>>> optimal solution. Rather: it should be modeled as a fixed regulator
>>> in which case the driver already has support.
>>
>> Can you clarify "driver already has support"? You are introducing
>> support to use the VBUS gpio as regulator as part of 3/3.
>>
> 
> The support is there as in: if the driver can obtain the regulator, it
> will enable it. The overcurrent protection does not work however and
> this is what patch 3 adds. Maybe I should rework the ordering in that
> I'd first add the irq thread disabling the regulator if it exists,
> then the regulator fixups to board files and then remove the vbus
> GPIO.
> 
>> I do see other instances of VBUS regulator being used in USB tree. But
>> we just converted the driver to use VBUS and over-current GPIOs in v5.1.
>> So this is a bit of "churn".
>>
> 
> Yes and it's my fault - I simply converted the legacy code without
> giving it enough consideration. I should have used a fixed regulator
> right away, but now it's upstream and we need a follow-up series.
> 
>> Can you document why the current solution is not optimal? Is it to make
>> future device-tree conversion for these boards easier? Or?
>>
> 
> It's sub-optimal from the HW modeling in SW PoV - it is in fact a
> regulator enabled/disabled by a GPIO. Also: it's code duplication as
> currently we check if the vbus GPIO exists and then use it or check if
> the regulator exists and use this as the second choice. The third
> patch actually shrinks the driver.

I see now that the driver supports controlling the VBUS gpio as
regulator already. Something I should have caught in review last time
around.

I agree this patch is an improvement. Lets see what Alan feels.

Also, reg_enabled member of da8xx_ohci_hcd structure seems to be pretty
useless considering regulator API already has use counting. Can you take
a look and remove that too as an added bonus.

Thanks,
Sekhar
