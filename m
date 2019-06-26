Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E614C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578502085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E8bujS7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:07:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42498 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:07:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5QH7clZ119197;
        Wed, 26 Jun 2019 12:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561568858;
        bh=7VXKI/t5sNp7zNH6sC+bn1Pxq4OnvCi8fXFUinc/Hbc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E8bujS7ZZXTx/89VxZ0+2j3tGJ4t0dYMvefg5HiYYO35idkhZxKplsSe9VO9jt2wT
         ctpy7HW15vIwD+euYnixyVHpjq68uLHVv8RfCGbIrXKOZjWbMpq369qCn69VC2AA/4
         G0Ee2cMacZgqv9oD7ZbtaP6pxqcjTAJCizTPU5mM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5QH7cW3109292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 12:07:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 26
 Jun 2019 12:07:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 26 Jun 2019 12:07:37 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5QH7bvC077439;
        Wed, 26 Jun 2019 12:07:37 -0500
Subject: Re: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for
 lm36274
To:     Axel Lin <axel.lin@ingics.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190626132632.32629-1-axel.lin@ingics.com>
 <20190626132632.32629-2-axel.lin@ingics.com>
 <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com>
 <CAFRkauCtHtG0mfqXp=FuBYYqGhhMGfP3o_N3iBoRHwkQNQYtNw@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b5452465-3dd4-855b-1a17-3da96070903c@ti.com>
Date:   Wed, 26 Jun 2019 12:07:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFRkauCtHtG0mfqXp=FuBYYqGhhMGfP3o_N3iBoRHwkQNQYtNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel

On 6/26/19 10:20 AM, Axel Lin wrote:
> Dan Murphy <dmurphy@ti.com> 於 2019年6月26日 週三 下午11:07寫道：
>> Hello
>>
>> On 6/26/19 8:26 AM, Axel Lin wrote:
>>> According to the datasheet http://www.ti.com/lit/ds/symlink/lm36274.pdf:
>>> Table 23. VPOS Bias Register Field Descriptions VPOS[5:0]:
>>> VPOS voltage (50-mV steps): VPOS = 4 V + (Code × 50 mV), 6.5 V max
>>> 000000 = 4 V
>>> 000001 = 4.05 V
>>> :
>>> 011110 = 5.5 V (Default)
>>> :
>>> 110010 = 6.5 V
>>> 110011 to 111111 map to 6.5 V
>>>
>>> So the LM36274_LDO_VSEL_MAX should be 0b110010 (0x32).
>>> The valid selectors are 0 ... LM36274_LDO_VSEL_MAX, n_voltages should be
>>> LM36274_LDO_VSEL_MAX + 1. Similarly, the n_voltages should be
>>> LM36274_BOOST_VSEL_MAX + 1 for LM36274_BOOST.
>>>
>>> Fixes: bff5e8071533 ("regulator: lm363x: Add support for LM36274")
>>> Signed-off-by: Axel Li
>>>
>>> 6.5 V
>>> DISPLAY BIAS POSITIVE OUTPUT (VPOS)
>>> Programmable output voltage
>>> range
>>>
>>>
>>> n <axel.lin@ingics.com>
>>> ---
>>>    drivers/regulator/lm363x-regulator.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
>>> index e4a27d63bf90..4b9f618b07e9 100644
>>> --- a/drivers/regulator/lm363x-regulator.c
>>> +++ b/drivers/regulator/lm363x-regulator.c
>>> @@ -36,7 +36,7 @@
>>>
>>>    /* LM36274 */
>>>    #define LM36274_BOOST_VSEL_MAX              0x3f
>>> -#define LM36274_LDO_VSEL_MAX         0x34
>>> +#define LM36274_LDO_VSEL_MAX         0x32
>>>
>>> 6.5 V
>>> DISPLAY BIAS POSITIVE OUTPUT (VPOS)
>>> Programmable output voltage
>>> range
>>>
>>>
>> This does not seem correct the max number of voltages are 0x34.
>>
>> The register is zero based so you can have 33 voltage select levels and
>> + 1 is 34 total selectors
>>
>> Liam/Mark correct me if I am incorrect.
>  From the datasheet, the maximum voltage 110010 = 6.5 V, the 0b110010 is 0x32.
> I know it is 0 based, so .n_voltages     = LM36274_LDO_VSEL_MAX + 1,
> (And that coding style is to match the original code.)
>
> With your current code where LM36274_LDO_VSEL_MAX and n_voltages is 0x34,
> the maximum voltage will become 400000 + 50000 * 0x34 = 6.6V which
> does not match the datasheet.

Not sure how you get 6.6v the LDO max is 6.5v.

After 0x32->0x7f maps to 6.5v

000000 = 4 V
000001 = 4.05 V
:
011110 = 5.5 V (Default)
:
110010 = 6.5 V

110011 to 111111 map to 6.5 V <- Should never see 6.6v from LDO

Page 7 of the Datasheet says range is 4v->6.5v

Dan

> Would you mind double check again?
