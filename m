Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23940C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186021874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfCUMJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:09:19 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:39440 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfCUMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:09:19 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 21 Mar
 2019 20:10:25 +0800
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <jianxin.pan@amlogic.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com>
 <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
 <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
 <20190307140959.10092d45@xps13>
 <ccb95e75-e62f-c510-cabd-853481f77fc8@amlogic.com>
 <CAFBinCBd=dOZjv4KEDY9ODOONDO=WtaBqAMRi_a+gH3_iZEAHQ@mail.gmail.com>
 <CAFBinCA7LLK6K3ZqauJy2N-z5-kTfuTztmoSQ=Bk4A5Xagxddw@mail.gmail.com>
 <8134890a-457d-7803-01a4-1832f925f65f@amlogic.com>
 <CAFBinCBfkr-yyR4Vbd1HVmXVCOKuK-Kw1HKz4SMt9G3eA49HQQ@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <2aebeb86-1cf6-26e9-b19b-03c2a55bff9c@amlogic.com>
Date:   Thu, 21 Mar 2019 20:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAFBinCBfkr-yyR4Vbd1HVmXVCOKuK-Kw1HKz4SMt9G3eA49HQQ@mail.gmail.com>
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

On 2019/3/21 4:48, Martin Blumenstingl wrote:
> Hi Liang,
> 
> On Wed, Mar 20, 2019 at 4:32 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>
>> Hi Martin,
>>
>> Thanks for your time.
>> On 2019/3/20 4:27, Martin Blumenstingl wrote:
>>> Hello Liang,
>>>
>>> On Sat, Mar 16, 2019 at 11:55 AM Martin Blumenstingl
>>> <martin.blumenstingl@googlemail.com> wrote:
>>> [...]
> 
>> Allocating a fixed size info buffer before nand_scan_ident and attach it
>> on the struct meson_nfc; Or considering not use dma for reading data
>> less than 8 bytes. Both can reduce kmalloc and kfree calling. Thanks.
> both suggestions sound reasonable.
> however, I will search for the root cause of the unaligned address
> first before changing the Meson NFC driver.
That is good.  And i will implement one of both mentioned above soon.
> 
> [...]
>>> [    2.227374] ------------[ cut here ]------------
>>> [    2.231968] WARNING: CPU: 1 PID: 1 at
>>> drivers/mtd/nand/raw/nand_base.c:5503 nand_scan_with_ids+0x1718/0x171c
>>> [    2.241760] No oob scheme defined for oobsize 1280
>>> ...
>>> (the "No oob scheme defined for oobsize 1280" message is expected)
>>>
>> miss mtd_set_ooblayout(mtd, &meson_ooblayout_ops) on function
>> meson_nand_attach_chip.
> thank you for the suggestion. I didn't have time to test this on my
> board yet but I'll let you know about my results during the weekend.
> Does the missing mtd_set_ooblayout() call also affect GXL or AXG boards?
> 
Yes. I deleted it unintentionally.
> 
> Regards
> Martin
> 
> .
> 
