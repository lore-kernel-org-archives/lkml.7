Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB922C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB22084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPYM2bE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDHUED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:04:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32900 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:04:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x38K3qLQ063825;
        Mon, 8 Apr 2019 15:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554753832;
        bh=vHUJI18Z6EFedneL7w5XOP0QTirJ9jXdjs2TSxiWj4Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oPYM2bE3wtpbJzxq9om3rBeN7Rj1HIQ2YzPrp5ffLIrmW04nkQkli4bAjg8VM9/b4
         D22K5loSzd817DjaKIN6zzhwtZeiYo69K3acijmDpaceQKI+ywoluVkTdB1P7Vs2kB
         IP0rSJzYPOLRpuS+IvoMK8rc4aHh/lc/XSID7OtI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x38K3qi3114356
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 15:03:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 15:03:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 15:03:52 -0500
Received: from [10.250.71.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x38K3px1004402;
        Mon, 8 Apr 2019 15:03:51 -0500
Subject: Re: [GIT PULL v2] LM3532 backlight support improvements and
 relocation
To:     Tony Lindgren <tony@atomide.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh@kernel.org>, <lee.jones@linaro.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
 <20190407221740.GA6327@amd> <f96d09dc-3ddc-4ac7-3668-508df430f686@ti.com>
 <20190408193055.GN49658@atomide.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <df6e1bf1-2588-46d0-c115-b6827174bb9b@ti.com>
Date:   Mon, 8 Apr 2019 15:03:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408193055.GN49658@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony

On 4/8/19 2:30 PM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [190408 15:54]:
>> On 4/7/19 5:17 PM, Pavel Machek wrote:
>>> Plus, I'd kind of expect ALS enabled/disabled to be runtime controled,
>>> not from the device tree.
>> We can always add runtime override control to the driver.
> Yeah that sounds good to me :) Sounds like this can be done
> with follow up patches though.
>
>> Just need to see if there is a common interface from input or IIO we can adopt.
> Hmm can the lm3532 registers actually show the value
> for the ALS sensors?


No it can only report the current configured ALS zone not the LUX value.

Dan


> Regards,
>
> Tony
