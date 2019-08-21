Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B86C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2742E216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfHUGUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:20:12 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:4644 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:20:11 -0400
IronPort-SDR: 8V8EhrJCUuKyTElVrk+Etk8MRSkN3jFaTOcIXL2ySLd8T/kMnYbJLkp4/a8ZXluS2r5ezUsoIn
 pibmHCVYXvHmMawGPM2NQzs/dHbFEI8ifb0RsvzGfuPfSsMPVmJkV8u16ce9v9Zn5yCPQC/0a+
 nJ+/azIRxQUt+8Y+piWZwPFJqeftIelZfP/+/8z1/zIjv5A8DQH8x1ctAzyj+90SvlKWb4xOx8
 hckWud2MNG3/cWzrgIV1HaAWIgZp8ELvdgD9u6ArUaOTUp6Un1SisPWpV2bzjc47TRFT2052uN
 DhU=
X-IronPort-AV: E=Sophos;i="5.64,411,1559509200"; 
   d="scan'208";a="229121716"
Subject: Re: [v2] rtc: pcf85363/pcf85263: fix error that failed to run hwclock
 -w
To:     Li Yang <leoyang.li@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Biwen Li <biwen.li@nxp.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20190816024636.34738-1-biwen.li@nxp.com>
 <20190816080417.GB3545@piout.net>
 <CADRPPNRkqbWzGEvUJyi0Qff3oS6biO0v7BTrK1Jiz9AMnOYF=Q@mail.gmail.com>
 <20190816162825.GE3545@piout.net>
 <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <ff198737-acb5-7186-7e14-a1e1cdc0f72c@vaisala.com>
Date:   Wed, 21 Aug 2019 09:20:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADRPPNQwcGrVXLm8eHbXKmyecMhT6Mt9rNGnspJA1+MnV4K8oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2019 06:20:05.0337 (UTC) FILETIME=[791E8490:01D557E8]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/19 10:40 PM, Li Yang wrote:
> On Fri, Aug 16, 2019 at 11:30 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
>>
>> On 16/08/2019 10:50:49-0500, Li Yang wrote:
>>> On Fri, Aug 16, 2019 at 3:05 AM Alexandre Belloni
>>> <alexandre.belloni@bootlin.com> wrote:
>>>>
>>>> On 16/08/2019 10:46:36+0800, Biwen Li wrote:
>>>>> Issue:
>>>>>      - # hwclock -w
>>>>>        hwclock: RTC_SET_TIME: Invalid argument
>>>>>
>>>>> Why:
>>>>>      - Relative patch: https://lkml.org/lkml/2019/4/3/55 , this patch
>>>>>        will always check for unwritable registers, it will compare reg
>>>>>        with max_register in regmap_writeable.
>>>>>
>>>>>      - In drivers/rtc/rtc-pcf85363.c, CTRL_STOP_EN is 0x2e, but DT_100THS
>>>>>        is 0, max_regiter is 0x2f, then reg will be equal to 0x30,
>>>>>        '0x30 < 0x2f' is false,so regmap_writeable will return false.
>>>>>
>>>>>      - Root cause: the buf[] was written to a wrong place in the file
>>>>>        drivers/rtc/rtc-pcf85363.c
>>>>>
>>>>
>>>> This is not true, the RTC wraps the register accesses properly and this
>>>
>>> This performance hack probably deserve some explanation in the code comment.  :)
>>>
>>>> is probably something that should be handled by regmap_writable.
>>>
>>> The address wrapping is specific to this RTC chip.  Is it also
>>> commonly used by other I2C devices?  I'm not sure if regmap_writable
>>> should handle the wrapping case if it is too special.
>>>
>>
>> Most of the i2c RTCs do address wrapping which is sometimes the only way
>> to properly set the time.
> 
> Adding Mark and Nandor to the loop.
> 
> Regards,
> Leo
> 

Hi,
   `regmap` provides couple of ways to validate the registers: 
max_register, callback function and write table. All of these are 
optional, so it gives you the freedom to customize it as needed.

In this situation probably you could:
   1. Avoid using the wrapping feature of pcf85363 (you can just provide 
separate calls for stop, reset and time confguration). In this way the 
`max_register` validation method will work fine.
   2. Replace `max_register` method validation with `callback function` 
validation method, were you could make your own validation.


Regards,
    Nandor


