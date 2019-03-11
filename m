Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F599C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0A720828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gtQdlVDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfCKRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:24:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfCKRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:24:35 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2BHOQWr065446;
        Mon, 11 Mar 2019 12:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552325066;
        bh=BFt7fohiswyJ8mq0xFQtbnhi3721NN6ZN2RXc5vC0pM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gtQdlVDVyW8c6cwMNZmdIH1pCnG90CAK+CVBePhEyVPl1qjv1cQ+Zu8yRxdMt2zJY
         kNM1grEH6pTiLDkSKzH3mMCKoIVd4BnLiqN+E2ecFrvoi60Ov3FozHYu/QFsS2qPsf
         iqSzO6R2hm+M+ndnrOx5LNfdB2LQ2lCw7vgOYgeY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2BHOQVV105997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 12:24:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Mar 2019 12:24:26 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Mar 2019 12:24:26 -0500
Received: from [172.22.80.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2BHOP96000747;
        Mon, 11 Mar 2019 12:24:26 -0500
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>, <tony@atomide.com>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-4-dmurphy@ti.com>
 <8ac4d84f-c792-893d-fbae-fac88fac8631@gmail.com>
 <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
 <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ee13f836-bd77-22b0-e230-2fc9050afe88@ti.com>
Date:   Mon, 11 Mar 2019 12:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 3/11/19 12:22 PM, Jacek Anaszewski wrote:
> Dan,
> 
> One more thing I forgot to mention before.
> 
> On 3/11/19 12:36 PM, Dan Murphy wrote:
>> Jacek
> [...]
>>
>>>> @@ -0,0 +1,72 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* TI LM3532 LED driver
>>>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>>>> + */
> 
> Let's have "//" comments here.
> 

Like I said earlier in v2 this header went away.

And checkpatch takes issue with // in headers.

Unless they have removed that requirement.

Dan

>>>> +#ifndef __DT_BINDINGS_LEDS_LM3532_H
>>>> +#define __DT_BINDINGS_LEDS_LM3532_H
>>>> +
>>>> +#define LM3532_BL_MODE_MANUAL    0x00 /* "man" */
>>>> +#define LM3532_BL_MODE_ALS    0x01 /* "als" */
>>>> +
>>>> +/* ALS Resistor Select */
>>>> +#define LM3532_IMP_HIGH        0x00
>>>> +#define LM3532_IMP_37K        0x01
>>>> +#define LM3532_IMP_18_5K    0x02
>>>> +#define LM3532_IMP_12_33K    0x03
>>>> +#define LM3532_IMP_9_25K    0x04
>>>> +#define LM3532_IMP_7_4K        0x05
>>>> +#define LM3532_IMP_6_17K    0x06
>>>> +#define LM3532_IMP_5_29K    0x07
>>>> +#define LM3532_IMP_4_63K    0x08
>>>> +#define LM3532_IMP_4_11K    0x09
>>>> +#define LM3532_IMP_3_7K        0x0a
>>>> +#define LM3532_IMP_3_36K    0x0b
>>>> +#define LM3532_IMP_3_08K    0x0c
>>>> +#define LM3532_IMP_2_85K    0x0d
>>>> +#define LM3532_IMP_2_64K    0x0e
>>>> +#define LM3532_IMP_2_44K    0x0f
>>>> +#define LM3532_IMP_2_31K    0x10
>>>> +#define LM3532_IMP_2_18K    0x11
>>>> +#define LM3532_IMP_2_06K    0x12
>>>> +#define LM3532_IMP_1_95K    0x13
>>>> +#define LM3532_IMP_1_85K    0x14
>>>> +#define LM3532_IMP_1_76K    0x15
>>>> +#define LM3532_IMP_1_68K    0x16
>>>> +#define LM3532_IMP_1_61K    0x17
>>>> +#define LM3532_IMP_1_54K    0x18
>>>> +#define LM3532_IMP_1_48K    0x19
>>>> +#define LM3532_IMP_1_42K    0x1a
>>>> +#define LM3532_IMP_1_37K    0x1b
>>>> +#define LM3532_IMP_1_32K    0x1c
>>>> +#define LM3532_IMP_1_28K    0x1d
>>>> +#define LM3532_IMP_1_23K    0x1e
>>>> +#define LM3532_IMP_1_19K    0x1f
>>>> +
>>>> +/* ALS Averaging Time */
>>>> +#define LM3532_ALS_AVRG_TIME_17_92ms    0x00
>>>> +#define LM3532_ALS_AVRG_TIME_35_84ms    0x01
>>>> +#define LM3532_ALS_AVRG_TIME_71_68ms    0x02
>>>> +#define LM3532_ALS_AVRG_TIME_143_36ms    0x03
>>>> +#define LM3532_ALS_AVRG_TIME_286_72ms    0x04
>>>> +#define LM3532_ALS_AVRG_TIME_573_44ms    0x05
>>>> +#define LM3532_ALS_AVRG_TIME_1146_88ms    0x06
>>>> +#define LM3532_ALS_AVRG_TIME_2293_76ms    0x07
>>>> +
>>>> +/* ALS input select */
>>>> +#define LM3532_ALS_INPUT_AVRG    0x00 /* ALS1 and ALS2 input average */
>>>> +#define LM3532_ALS_INPUT_ALS1    0x01 /* ALS1 Input */
>>>> +#define LM3532_ALS_INPUT_ALS2    0x02 /* ALS2 Input */
>>>> +#define LM3532_ALS_INPUT_CEIL    0x03 /* Max of ALS1 and ALS2 */
>>>> +
>>>> +/* Ramp Times */
>>>> +#define LM3532_RAMP_8us        0x00
>>>> +#define LM3532_RAMP_1024us    0x01
>>>> +#define LM3532_RAMP_2048us    0x02
>>>> +#define LM3532_RAMP_4096us    0x03
>>>> +#define LM3532_RAMP_8192us    0x04
>>>> +#define LM3532_RAMP_16384us    0x05
>>>> +#define LM3532_RAMP_32768us    0x06
>>>> +#define LM3532_RAMP_65536us    0x07
>>>> +
>>>> +#endif /* __DT_BINDINGS_LEDS_LM3532_H */
>>>>
>>>
>>
>>
> 


-- 
------------------
Dan Murphy
