Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1737DC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4CE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OCB8W11M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbfGPSIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:08:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44406 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbfGPSIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:08:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6GI8nXO083448;
        Tue, 16 Jul 2019 13:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563300529;
        bh=B7gPU0oH6hxYy1ylLsR2AOejA70E1O6r06wLMSX9mBM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OCB8W11M+F7vpmYqAbmiA251t2aO7VFuaYqNamSiwIMd4fHYX3bg2gdTigZojZlOZ
         /EX0Vw3/WbQn9RirQkEpqXw5pCUMWMFaRHpzDWB4l2V1Ex6FhVmeKy+gD+qITKZlss
         HfIEzTAclCJKwLnUiQO2hbc1IfDH3y569IhpyBSg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6GI8nI6099075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 13:08:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 13:08:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 13:08:49 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6GI8nhY078141;
        Tue, 16 Jul 2019 13:08:49 -0500
Subject: Re: [RFT][PATCH 1/2] regulator: lm363x: Fix off-by-one n_voltages for
 lm3632 ldo_vpos/ldo_vneg
To:     Axel Lin <axel.lin@ingics.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190626132632.32629-1-axel.lin@ingics.com>
 <a99b04a3-f079-3a43-9e19-d9501b76a96e@ti.com>
 <CAFRkauAewFwcQNzpSfAfXMiCdHuENcg2NRzKECjPQ1RtUCuXEA@mail.gmail.com>
 <CAFRkauAuvM5gjCDnJeVgKy48Qr6yRyX6L-B1f=bdhM3+rApTTQ@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e94bbf28-37b2-d51f-ec65-ed282bd77e81@ti.com>
Date:   Tue, 16 Jul 2019 13:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFRkauAuvM5gjCDnJeVgKy48Qr6yRyX6L-B1f=bdhM3+rApTTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel

On 7/7/19 9:02 PM, Axel Lin wrote:
> Axel Lin <axel.lin@ingics.com> 於 2019年6月26日 週三 下午11:12寫道：
>> Dan Murphy <dmurphy@ti.com> 於 2019年6月26日 週三 下午11:07寫道：
>>> Hello
>>>
>>> On 6/26/19 8:26 AM, Axel Lin wrote:
>>>> According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pdf
>>>> Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
>>>> Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
>>>> 000000: 4 V
>>>> 000001: 4.05 V
>>>> 000010: 4.1 V
>>>> ....................
>>>> 011101: 5.45 V
>>>> 011110: 5.5 V (Default)
>>>> 011111: 5.55 V
>>>> ....................
>>>> 100111: 5.95 V
>>>> 101000: 6 V
>>>> Note: Codes 101001 to 111111 map to 6 V
>>>>
>>>> The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum voltage
>>>> can match the datasheet.
>>>>
>>>> Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
>>>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>>> ---
>>>>    drivers/regulator/lm363x-regulator.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
>>>> index 5647e2f97ff8..e4a27d63bf90 100644
>>>> --- a/drivers/regulator/lm363x-regulator.c
>>>> +++ b/drivers/regulator/lm363x-regulator.c
>>>> @@ -30,7 +30,7 @@
>>>>
>>>>    /* LM3632 */
>>>>    #define LM3632_BOOST_VSEL_MAX               0x26
>>>> -#define LM3632_LDO_VSEL_MAX          0x29
>>>> +#define LM3632_LDO_VSEL_MAX          0x28
>>> Similar comment as I made on the LM36274
>>>
>>> These are 0 based registers so it is 28 + 1
>> The code shows:  .n_voltages     = LM3632_LDO_VSEL_MAX + 1
>> so LM3632_LDO_VSEL_MAX needs to be 0x28.
>>
>>                  .name           = "ldo_vpos",
>>                  .of_match       = "vpos",
>>                  .id             = LM3632_LDO_POS,
>>                  .ops            = &lm363x_regulator_voltage_table_ops,
>>                  .n_voltages     = LM3632_LDO_VSEL_MAX + 1,
> Hi Dan,
> I'm wondering if you read my previous reply.

Yes I just got to it I was buried with other work.  Thanks for the bump 
on the list.

I will have to try this on my board.

FYI this is not really my code Milo K was the original author.

I just added another entry to the driver.  But since Milo is MIA I will

give it a look once I finish up my LED work next week

Dan

<snip>

> Regards,
> Axel
