Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D0720815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W+2G8WaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfEXPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:36:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4921 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389419AbfEXPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:36:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce80f9a0000>; Fri, 24 May 2019 08:36:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 08:36:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 May 2019 08:36:58 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 15:36:56 +0000
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
To:     Gen Zhang <blackgod016574@gmail.com>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
 <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
 <20190524143309.GA8631@zhanggen-UX430UQ>
 <e52f4140-a119-a584-40a2-6359d6e1784a@nvidia.com>
 <20190524150053.GA9235@zhanggen-UX430UQ>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1740686f-a466-430c-9d01-ab83ea6998ac@nvidia.com>
Date:   Fri, 24 May 2019 16:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524150053.GA9235@zhanggen-UX430UQ>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558712218; bh=rDbHj92qicJ93c3g6qztLoh7zaFndpxTw1RYqjrPd9Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W+2G8WaQZfLr2917mkUcJkjSRe6m9eWd6+SU1muUO0R1zbqSow4az4woRWlAcdpz0
         fsfq12f8q/MWRiLOGWNTcMx+g0bVlol5gS32f9/xGKd9WlZSoM3cec6x3okEVHDC7s
         h8x/Pn7dUGal0TW0+4RyaT4MULKI0FidG/EnuyVhw3j1vDe4fk5dg1WIvBg80MEHKh
         oBTcTgUSnSEBH+5CLGby4Vv30My1eOhEEOgYK/HP784zcm9LPIUxi8ztVFGY7h5IB7
         d/NvHRHJh46Z5Mb7sAOGKiNRXXpPe/0i1Byc7sZzpcIhQiXs2RZjOScqbMC2BFWcl/
         QlpZ6KKsmlufQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2019 16:00, Gen Zhang wrote:
> On Fri, May 24, 2019 at 03:47:34PM +0100, Jon Hunter wrote:
>>
>> On 24/05/2019 15:33, Gen Zhang wrote:
>>> On Fri, May 24, 2019 at 09:33:13AM +0100, Jon Hunter wrote:
>>>>
>>>> On 24/05/2019 01:50, Gen Zhang wrote:
>>>>> In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
>>>>> platform_device_alloc(). When it is NULL, function returns ENOMEM.
>>>>> However, 'machine' is allocated by devm_kzalloc() before this site.
>>>>> Thus we should free 'machine' before function ends to prevent memory
>>>>> leaking.
>>>>
>>>> Memory allocated by devm_xxx() is automatically freed on failure so this
>>>> is not correct.
>>> Thanks for your comments, Jon. But after I examined the code, I am still
>>> confused about the usage of devm_kmalloc(). You can kindly refer to 
>>> hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c. And
>>> devm_kfree() is used to free a memory allocated by devm_kmalloc(). And
>>> I found other situations similar to this in other files.
>>>
>>> So, I hope you can give me some guidance on this. Thanks!
>>
>> Please refer to the devres documentation [0].
>>
>> Cheers,
>> Jon
>>
>> [0] https://www.kernel.org/doc/Documentation/driver-model/devres.txt
>>
>> -- 
>> nvpublic
> Thanks for your reply. I figured out that devm_kmalloc will free the 
> memory no matter fail or not. But I still want to ask why other codes
> as I above mentioned use devm_kfree() to free memory allocated by 
> devm_kmalloc(). If the memory is automatically freed, is this 
> devm_kfee() redundant codes that should be removed? Am I 
> misunderstanding this again or it is something else?

There could well be cases where you need to explicitly call
devm_kfree(), but having a quick glance at the example above, I don't
see why you would call devm_kfree() here and yes looks like that code
could be simplified significantly. Notice that hisi_sas_debugfs_exit()
does not free any memory as it is not necessary to explicitly do so.

Cheers
Jon

-- 
nvpublic
