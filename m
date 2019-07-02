Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DBDC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F9B2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJarnZQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGBLg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:36:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53722 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:36:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x62BaMoU122076;
        Tue, 2 Jul 2019 06:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1562067382;
        bh=gIRvrIV2Wc21BZQI/yRZvscQEln3l4qrakkgDdK8Yqw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WJarnZQlahTj1u4qn9Lq6B2GYYwT0OWR6zhM9VQ7+FoVe3/MPM1kuj/0blE/AXRbg
         Z1Ts+Q2J3vWmWul6xfRtm9LO2UmKH6OswZ3ZOCZyK5BwlxlYrw+It6m8MdW/es4371
         vk+/CHtnXNaT6z0o1SMDlEvw+WeZV+Gu2Cz9z3HI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x62BaMp6036626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Jul 2019 06:36:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Jul
 2019 06:36:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Jul 2019 06:36:22 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x62BaKLS027112;
        Tue, 2 Jul 2019 06:36:20 -0500
Subject: Re: [PATCH][next] regulator: lp87565: fix missing break in switch
 statement
To:     Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190627131639.6394-1-colin.king@canonical.com>
 <20190628143628.GJ5379@sirena.org.uk>
 <4cb0e4ab-66c7-2b3d-27d3-fd5cfde8988f@canonical.com>
 <20190702104420.GD4652@dell>
 <4a0a50be-1465-0554-f787-dec72bc07a00@canonical.com>
 <20190702113157.GG4652@dell>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <0c0e0e49-48c3-c1af-b7c7-26603d98cfe3@ti.com>
Date:   Tue, 2 Jul 2019 17:06:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190702113157.GG4652@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/19 5:01 PM, Lee Jones wrote:
> On Tue, 02 Jul 2019, Colin Ian King wrote:
> 
>> On 02/07/2019 11:44, Lee Jones wrote:
>>> On Fri, 28 Jun 2019, Colin Ian King wrote:
>>>
>>>> On 28/06/2019 15:36, Mark Brown wrote:
>>>>> On Thu, Jun 27, 2019 at 02:16:39PM +0100, Colin King wrote:
>>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>>
>>>>>> Currently the LP87565_DEVICE_TYPE_LP87561_Q1 case does not have a
>>>>>> break statement, causing it to fall through to a dev_err message.
>>>>>> Fix this by adding in the missing break statement.
>>>>>
>>>>> This doesn't apply against current code, please check and resend.
>>>>>
>>>> So it applies cleanly against linux-next, I think the original code
>>>> landed in mfd/for-mfd-next - c.f. https://lkml.org/lkml/2019/5/28/550
>>>
>>> Applied, thanks Colin.
>>>
>> I'm confused, who is the official maintainer of the regulator patches
>> nowadays?
> 
> Mark.  But the patch you're fixing is currently in the MFD tree.
> 
> I sent him an updated pull-request.

Thanks Lee!

> 
> Don't worry mate, you're in good hands. ;)
> 
