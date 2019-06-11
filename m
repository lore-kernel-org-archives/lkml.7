Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8CC2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e0i1aSjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406236AbfFKRhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:37:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49722 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405681AbfFKRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:37:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BHb5mD016474;
        Tue, 11 Jun 2019 12:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560274625;
        bh=iF6yw2xuGHxpTtPw7MooWyGH3TcrPgGgUGIlsmVqIw0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e0i1aSjp/2BdZoqo2uP7dqVA7SBL664LNqOExKnCnTxV5t2TdbnByEkhlrh/ptZ7c
         ZeNeVTS6lVO2cOsgS58rz9F7QvJltE2pECZkjZWfH/Rw8LBfPW/8A8oDQyr9wqJR1r
         gQ5T4soOCWgMMfyvPY+L/s0IqAaPJM/GrZGQWaNo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BHb5EB033547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 12:37:05 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 12:37:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 12:37:04 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BHb1S1064295;
        Tue, 11 Jun 2019 12:37:03 -0500
Subject: Re: [PATCH] firmware: ti_sci: Add support for processor control
To:     <santosh.shilimkar@oracle.com>, Suman Anna <s-anna@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190605223334.30428-1-s-anna@ti.com>
 <4302c224-9e50-6320-2585-60bfe0aa2a32@oracle.com>
 <2174bc51-9e28-e519-b936-9e101e2a2a4e@ti.com>
 <ea3bf059-86b0-2d8c-c42d-44c08a6ec808@oracle.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a3eba154-d47f-1b2f-a2c6-9cb7a0ee817a@ti.com>
Date:   Tue, 11 Jun 2019 20:37:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea3bf059-86b0-2d8c-c42d-44c08a6ec808@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2019 20:16, santosh.shilimkar@oracle.com wrote:
> 
> 
> On 6/10/19 5:19 AM, Tero Kristo wrote:
>> On 08/06/2019 00:35, santosh.shilimkar@oracle.com wrote:
>>> On 6/5/19 3:33 PM, Suman Anna wrote:
>>>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>>>> is used in Texas Instrument's System on Chip (SoC) such as those
>>>> in K3 family AM654 SoC to communicate between various compute
>>>> processors with a central system controller entity.
>>>>
>>>> The system controller provides various services including the control
>>>> of other compute processors within the SoC. Extend the TI-SCI protocol
>>>> support to add various TI-SCI commands to invoke services associated
>>>> with power and reset control, and boot vector management of the
>>>> various compute processors from the Linux kernel.
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>> Hi Santosh, Nishanth, Tero,
>>>>
>>>> Appreciate it if this patch can be picked up for the 5.3 merge window.
>>>> This is a dependency patch for my various remoteproc drivers on TI K3
>>>> SoCs. Patch is on top of v5.2-rc1.
>>>>
>>> I will pick this up for 5.3.
>>
>> Santosh,
>>
>> There is a pile of drivers/firmware changes for ti-sci, which have 
>> cross dependencies, and will cause merge conflicts also as they touch 
>> same file.
>>
>> Do you mind if I setup a pull-request for these all and send it to 
>> you? They are going to be on top of the keystone clock pull-request I 
>> just sent today though, otherwise it won't compile (the 32bit clock 
>> support has dependency towards the clock driver.)
>>
> That will be great Tero.

Ok doing that.

For this patch, queuing up for 5.3, thanks.

-Tero

> 
> Regards,
> Santosh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
