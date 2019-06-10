Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22726C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4CD208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="clRIYTQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbfFJMTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:19:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40272 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbfFJMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:19:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5ACJYvj051757;
        Mon, 10 Jun 2019 07:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560169175;
        bh=HRczlLLLa8fNcM5JaVoEwlEJRwamvX4hQ+KRQb/Fon8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=clRIYTQvxertq25F+Zqgjl+8PyIO0ND2jEZjKoYcU8Mn6OD+umX8Ti7bX9wO5Ak0v
         +CnBk0v4nZRQ/MK6dzy/h/1yt93KX71Yexc5heunvy/+PfcAYzL0JIzRlReMtF4Agy
         SXtCOX7X159pZzGAo+9swxcupT2mDJBLvaZUKSBQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5ACJYUs089592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 07:19:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 07:19:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 07:19:29 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5ACJQGV122170;
        Mon, 10 Jun 2019 07:19:27 -0500
Subject: Re: [PATCH] firmware: ti_sci: Add support for processor control
To:     <santosh.shilimkar@oracle.com>, Suman Anna <s-anna@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190605223334.30428-1-s-anna@ti.com>
 <4302c224-9e50-6320-2585-60bfe0aa2a32@oracle.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <2174bc51-9e28-e519-b936-9e101e2a2a4e@ti.com>
Date:   Mon, 10 Jun 2019 15:19:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4302c224-9e50-6320-2585-60bfe0aa2a32@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2019 00:35, santosh.shilimkar@oracle.com wrote:
> On 6/5/19 3:33 PM, Suman Anna wrote:
>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>> is used in Texas Instrument's System on Chip (SoC) such as those
>> in K3 family AM654 SoC to communicate between various compute
>> processors with a central system controller entity.
>>
>> The system controller provides various services including the control
>> of other compute processors within the SoC. Extend the TI-SCI protocol
>> support to add various TI-SCI commands to invoke services associated
>> with power and reset control, and boot vector management of the
>> various compute processors from the Linux kernel.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> Hi Santosh, Nishanth, Tero,
>>
>> Appreciate it if this patch can be picked up for the 5.3 merge window.
>> This is a dependency patch for my various remoteproc drivers on TI K3
>> SoCs. Patch is on top of v5.2-rc1.
>>
> I will pick this up for 5.3.

Santosh,

There is a pile of drivers/firmware changes for ti-sci, which have cross 
dependencies, and will cause merge conflicts also as they touch same file.

Do you mind if I setup a pull-request for these all and send it to you? 
They are going to be on top of the keystone clock pull-request I just 
sent today though, otherwise it won't compile (the 32bit clock support 
has dependency towards the clock driver.)

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
