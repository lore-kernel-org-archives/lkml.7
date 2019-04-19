Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB02C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3DA21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfDSDxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:53:02 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:60306 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfDSDxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:53:02 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 19 Apr
 2019 11:52:52 +0800
Subject: Re: [PATCH 4/4] mtd: rawnand: meson: only initialize the RB
 completion once
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-amlogic@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <bbrezillon@kernel.org>,
        <jianxin.pan@amlogic.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
 <20190411220056.19109-5-martin.blumenstingl@googlemail.com>
 <bd1900db-7ca1-a6e5-39f9-db54e0b570dd@amlogic.com>
 <CAFBinCB9Z_H4wX3_g2hVL-XnS6Oq-KtPHa4Z1ws79FGp5jCapQ@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <8ff232c3-f325-5b91-4de1-a39e63939df2@amlogic.com>
Date:   Fri, 19 Apr 2019 11:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCB9Z_H4wX3_g2hVL-XnS6Oq-KtPHa4Z1ws79FGp5jCapQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.125]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2019/4/19 3:44, Martin Blumenstingl wrote:
> Hi Liang,
> 
> On Mon, Apr 15, 2019 at 8:04 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>
>>
>> On 2019/4/12 6:00, Martin Blumenstingl wrote:
>>> Documentation/scheduler/completion.txt states:
>>>     Calling init_completion() on the same completion object twice is
>>>     most likely a bug as it re-initializes the queue to an empty queue and
>>>     enqueued tasks could get "lost" - use reinit_completion() in that case,
>>>     but be aware of other races.
>>>
>>> Initialize nfc->completion in meson_nfc_probe using init_completion and
>>> change the call in meson_nfc_queue_rb to reinit_completion so the logic
>>> matches what the documentation suggests.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>    drivers/mtd/nand/raw/meson_nand.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 57cc4bd3f665..ea57ddcec41e 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -400,7 +400,7 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>>        cfg |= NFC_RB_IRQ_EN;
>>>        writel(cfg, nfc->reg_base + NFC_REG_CFG);
>>>
>>> -     init_completion(&nfc->completion);
>>> +     reinit_completion(&nfc->completion);
>> Tested-by:Liang Yang <liang.yang@amlogic.com>
>> Acked-by: Liang Yang <liang.yang@amlogic.com>
> thank you for reviewing and testing my patches!
> 
> [...]
>> Tested-by:Liang Yang <liang.yang@amlogic.com>
>> Acked-by: Liang Yang <liang.yang@amlogic.com>
> please consider the following note for future code-reviews:
> most maintainers take the patch from patchwork and apply it to their git tree.
> however, patchwork is not smart enough to detect when the same
> Tested-by/Acked-by is sent multiple times.
> this results in the same Tested-by/Acked-by being listed multiple
> times in the final commit: [0]
> 
> what I do instead is to reply with one set of Tested-by/Acked-by
> (below the author's Signed-off-by) which is then valid for the whole
> patch.
> There's no problem to have Tested-by and Acked-by at the same time,
> the issue only shows up if you send Acked-by (or any other tag) for
> the same patch multiple times.
> 
Thanks. Well, I known about it now.

> 
> Have a great day!
> Regards,
> Martin
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=nand/next&id=39e01956e2f70ff9f0e97db1a69c9847aa1d5d8b
> 
> .
> 
