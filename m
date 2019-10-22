Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A733CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E121783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rwwTslcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfJVKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:16:50 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41954 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJVKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:16:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MAGhrO035851;
        Tue, 22 Oct 2019 05:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571739403;
        bh=Z2M2opz0iULlwvFf1Cl0ogrSLDlsZt+VNcrSmVTDJXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rwwTslcKYRj7uvvJmfOUA6jtzPSwgZ2PgrO5+y/NskBXnLeUgVo7sItcJCLJs/x4D
         5bHSV02yQFT3ktNspGGtChYshyYRxnXf4oOwK/h462aNrZ/DKvR6RYU6EDmAi/7w8C
         YDcEghYqgyrsySroG4rib++bTHe/Rlovz8YLIruo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MAGS9S014916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 05:16:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 05:16:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 05:16:18 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MAGQIg072197;
        Tue, 22 Oct 2019 05:16:27 -0500
Subject: Re: [PATCH] reset: Fix memory leak in reset_control_array_put()
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>
References: <20191022083623.29697-1-kishon@ti.com>
 <0a8e4249ae1e75906e4ab36460c2ffcb7ccf963d.camel@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <94f743e4-f682-a244-0331-329c2edf5da7@ti.com>
Date:   Tue, 22 Oct 2019 15:45:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0a8e4249ae1e75906e4ab36460c2ffcb7ccf963d.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/19 2:30 PM, Philipp Zabel wrote:
> Hi Kishon,
> 
> On Tue, 2019-10-22 at 14:06 +0530, Kishon Vijay Abraham I wrote:
>> Memory allocated for 'struct reset_control_array' in
>> of_reset_control_array_get() is never freed in
>> reset_control_array_put() resulting in kmemleak showing
>> the following backtrace.
>>
>>   backtrace:
>>     [<00000000c5f17595>] __kmalloc+0x1b0/0x2b0
>>     [<00000000bd499e13>] of_reset_control_array_get+0xa4/0x180
>>     [<000000004cc02754>] 0xffff800008c669e4
>>     [<0000000050a83b24>] platform_drv_probe+0x50/0xa0
>>     [<00000000d3a0b0bc>] really_probe+0x108/0x348
>>     [<000000005aa458ac>] driver_probe_device+0x58/0x100
>>     [<000000008853626c>] device_driver_attach+0x6c/0x90
>>     [<0000000085308d19>] __driver_attach+0x84/0xc8
>>     [<00000000080d35f2>] bus_for_each_dev+0x74/0xc8
>>     [<00000000dd7f015b>] driver_attach+0x20/0x28
>>     [<00000000923ba6e6>] bus_add_driver+0x148/0x1f0
>>     [<0000000061473b66>] driver_register+0x60/0x110
>>     [<00000000c5bec167>] __platform_driver_register+0x40/0x48
>>     [<000000007c764b4f>] 0xffff800008c6c020
>>     [<0000000047ec2e8c>] do_one_initcall+0x5c/0x1b0
>>     [<0000000093d4b50d>] do_init_module+0x54/0x1d0
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/reset/core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index 213ff40dda11..36b1ff69b1e2 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -748,6 +748,7 @@ static void reset_control_array_put(struct reset_control_array *resets)
>>  	for (i = 0; i < resets->num_rstcs; i++)
>>  		__reset_control_put_internal(resets->rstc[i]);
>>  	mutex_unlock(&reset_list_mutex);
>> +	kfree(resets);
>>  }
>>  
>>  /**
> 
> Thank you for the patch! I've added a
> 
> Fixes: 17c82e206d2a ("reset: Add APIs to manage array of resets")
> 
> tag and applied it to my reset/fixes branch.

That was quick! Thanks!

-Kishon
