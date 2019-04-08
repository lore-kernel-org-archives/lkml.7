Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D97C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE3D21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ramyE9rZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDHPyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:54:10 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37664 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfDHPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:54:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x38Fs2do128381;
        Mon, 8 Apr 2019 10:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554738842;
        bh=RymBz0PeFeVSSCiVwkKi3a8di8Dux4gYLzCGOtvKZVk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ramyE9rZtj2bB0TWxqCiPmPGsNM/n62NCgkIlM69Yhq7McazSYmTP+Pqfk5GlRXMG
         dI+SHC9fc+5p0ZNMCeQFAObNawuQ7KcVNAjK55CNHYS/mbydF4+5NZOyKiZiq2Ev+J
         YSx537sGUGChOlUhP5HzCj4nb9sXAr3qRKWg6gts=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x38Fs2fN028355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 10:54:02 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 10:54:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 10:54:02 -0500
Received: from [172.22.110.173] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x38Fs0ZJ089802;
        Mon, 8 Apr 2019 10:54:00 -0500
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
 <20190407221740.GA6327@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f96d09dc-3ddc-4ac7-3668-508df430f686@ti.com>
Date:   Mon, 8 Apr 2019 10:53:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407221740.GA6327@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review

On 4/7/19 5:17 PM, Pavel Machek wrote:
> Hi!
> 
>> Changes since v1:
>>
>> - synchronized DT label properties in DT bindings with what has been agreed
>>   for the patch "ARM: dts: omap4-droid4: Update backlight dt properties"
>>
>> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
>>
>>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/lm3532-driver-improvements
>>
>> for you to fetch changes up to bc1b8492c764fea940fc66206047e37a7f8d77e1:
>>
>>   leds: lm3532: Introduce the lm3532 LED driver (2019-04-07 20:45:49 +0200)
>>
>> Thanks,
>> Jacek Anaszewski
>>
>> ----------------------------------------------------------------
>> LM3532 backlight driver improvements and relocation
>> ----------------------------------------------------------------
>> Dan Murphy (4):
>>       dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
> 
> Sorry, this one will need more work.
> 
> When did Rob acknowledge this? I do not remember that mail & quick
> google does not find it.
> 
> I still don't like the fact that it is using different binding from
> other similar chips. It for example replaces "ramp-up-msec" with
> "ramp-up-us".
> 

It does not replace anything.  The LM3532 has a completely different ramping table then
the other LMU devices.  The ramp times for this part is in uS not mS and there is no alignment on
common values or deltas.

> This is certainly wrong:
> 
> +Optional properties if ALS mode is used:
> +	  - ti,als-vmin - Minimum ALS voltage defined in Volts
> +	  - ti,als-vmax - Maximum ALS voltage defined in Volts
> +	  Per the data sheet the max ALS voltage is 2V and the min is
> 0V
> 
> ...but milivolts (or microvolts?) make sense there, and clearly
> milivolts are used because 2000V is way out of range.:
> 

I will send a patch that changes "Volts" to "millivolts" in the description.

> +	  ti,als-vmin = <0>;
> +	  ti,als-vmax = <2000>;
> 
> Plus:
> 
> +Required child properties:
> ...
> +	- ti,led-mode : Defines if the LED strings are manually controlled or
> +			if the LED strings are controlled by the ALS.
> +			       0x00 - LED strings are I2C controlled via full scale brightness control register
> +        		  	  0x01 - LED strings are ALS controlled
> 
> Dunno. Normally we'd have "ti,automatic-led-mode", and if it was not
> present, we'd default to manual, no? (Also "led-mode" is a bit too
> generic. ti,als-enabled would be better description).
> 
> Plus, I'd kind of expect ALS enabled/disabled to be runtime controled,
> not from the device tree.

We can always add runtime override control to the driver.

Just need to see if there is a common interface from input or IIO we can adopt.

Dan


> 
> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
