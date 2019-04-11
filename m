Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A39CC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F220818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKDAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:00:41 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:44772 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:00:41 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 11 Apr
 2019 11:00:30 +0800
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Matthew Wilcox <willy@infradead.org>, <mhocko@suse.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <rppt@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org>
 <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com>
 <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com>
 <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
 <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com>
 <CAFBinCCSkVGp_iWKf=o=7UGuDUWxyLPGdrqGy_P-HPuEJiU1zQ@mail.gmail.com>
 <8cb108ff-7a72-6db4-660d-33880fcee08a@amlogic.com>
 <CAFBinCD4cRGbC=cFYEGVAHOtBSvrgNbCSfDWe3To0KCE5+ceVw@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <45ce172c-5c76-bb69-31c8-af91e8ffdd68@amlogic.com>
Date:   Thu, 11 Apr 2019 11:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCD4cRGbC=cFYEGVAHOtBSvrgNbCSfDWe3To0KCE5+ceVw@mail.gmail.com>
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
On 2019/4/11 1:54, Martin Blumenstingl wrote:
> Hi Liang,
> 
> On Wed, Apr 10, 2019 at 1:08 PM Liang Yang <liang.yang@amlogic.com> wrote:
>>
>> Hi Martin,
>>
>> On 2019/4/5 12:30, Martin Blumenstingl wrote:
>>> Hi Liang,
>>>
>>> On Fri, Mar 29, 2019 at 8:44 AM Liang Yang <liang.yang@amlogic.com> wrote:
>>>>
>>>> Hi Martin,
>>>>
>>>> On 2019/3/29 2:03, Martin Blumenstingl wrote:
>>>>> Hi Liang,
>>>> [......]
>>>>>> I don't think it is caused by a different NAND type, but i have followed
>>>>>> the some test on my GXL platform. we can see the result from the
>>>>>> attachment. By the way, i don't find any information about this on meson
>>>>>> NFC datasheet, so i will ask our VLSI.
>>>>>> Martin, May you reproduce it with the new patch on meson8b platform ? I
>>>>>> need a more clear and easier compared log like gxl.txt. Thanks.
>>>>> your gxl.txt is great, finally I can also compare my own results with
>>>>> something that works for you!
>>>>> in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
>>>>> instructions result in a different info buffer output.
>>>>> does this make any sense to you?
>>>>>
>>>> I have asked our VLSI designer for explanation or simulation result by
>>>> an e-mail. Thanks.
>>> do you have any update on this?
>> Sorry. I haven't got reply from VLSI designer yet. We tried to improve
>> priority yesterday, but i still can't estimate the time. There is no
>> document or change list showing the difference between m8/b and gxl/axg
>> serial chips. Now it seems that we can't use command NFC_CMD_N2M on nand
>> initialization for m8/b chips and use *read byte from NFC fifo register*
>> instead.
> thank you for the status update!
> 
> I am trying to understand your suggestion not to use NFC_CMD_N2M:
> the documentation (public S922X datasheet from Hardkernel: [0]) states
> that P_NAND_BUF (NFC_REG_BUF in the meson_nand driver) can hold up to
> four bytes of data. is this the "read byte from NFC FIFO register" you
> mentioned?
> 
You are right.take the early meson NFC driver V2 on previous mail as a 
reference.

> Before I spend time changing the code to use the FIFO register I would
> like to wait for an answer from your VLSI designer.
> Setting the "correct" info buffer length for NFC_CMD_N2M on the 32-bit
> SoCs seems like an easier solution compared to switching to the FIFO
> register. Keeping NFC_CMD_N2M on the 32-bit SoCs also allows us to
> have only one code-path for 32 and 64 bit SoCs, meaning we don't have
> to maintain two separate code-paths for basically the same
> functionality (assuming that NFC_CMD_N2M is not completely broken on
> the 32-bit SoCs, we just don't know how to use it yet).
> 
All right. I am also waiting for the answer.
> 
> Regards
> Martin
> 
> 
> [0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
> 
> .
> 
