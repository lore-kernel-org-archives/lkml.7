Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D963EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B491C222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfIZITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 04:19:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1722 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726060AbfIZITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:19:48 -0400
X-IronPort-AV: E=Sophos;i="5.64,551,1559491200"; 
   d="scan'208";a="76053882"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Sep 2019 16:19:45 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D50D14CE14F5;
        Thu, 26 Sep 2019 16:19:48 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 26 Sep 2019 16:19:57 +0800
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of
 "reloc"
To:     <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <corbet@lwn.net>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com>
 <20190926060139.GA100481@gmail.com>
 <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com>
 <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <dff52431-ce54-7c64-b223-36f4491c53b0@cn.fujitsu.com>
Date:   Thu, 26 Sep 2019 16:20:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: D50D14CE14F5.AA496
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 3:58 PM, hpa@zytor.com wrote:
> On September 26, 2019 12:55:51 AM PDT, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>> On 9/26/19 2:01 PM, Ingo Molnar wrote:
>>> * Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>>
>>>> The fields marked with (reloc) actually are not dedicated for
>> writing,
>>>> but communicating info for relocatable kernel with boot loaders. For
>>>> example:
>>>>
>>>>     ============    ============
>>>>     Field name:     pref_address
>>>>     Type:           read (reloc)
>>>>     Offset/size:    0x258/8
>>>>     Protocol:       2.10+
>>>>     ============    ============
>>>>
>>>>     ============    ========================
>>>>     Field name:     code32_start
>>>>     Type:           modify (optional, reloc)
>>>>     Offset/size:    0x214/4
>>>>     Protocol:       2.00+
>>>>     ============    ========================
>>>>
>>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>>> ---
>>>> Unless I have incorrect non-native understanding for "fill in", I
>> think
>>>> this is inaccurate.
>>>>
>>>>  Documentation/x86/boot.rst | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
>>>> index 08a2f100c0e6..a611bf04492d 100644
>>>> --- a/Documentation/x86/boot.rst
>>>> +++ b/Documentation/x86/boot.rst
>>>> @@ -243,7 +243,7 @@ bootloader ("modify").
>>>>  
>>>>  All general purpose boot loaders should write the fields marked
>>>>  (obligatory).  Boot loaders who want to load the kernel at a
>>>> -nonstandard address should fill in the fields marked (reloc); other
>>>> +nonstandard address should consult with the fields marked (reloc);
>> other
>>>>  boot loaders can ignore those fields.
>>>>  
>>>>  The byte order of all fields is littleendian (this is x86, after
>> all.)
>>>
>>> Well, this documentation is written from the point of view of a 
>>> *bootloader*, not the kernel. So the 'fill in' says that the
>> bootloader 
>>> should write those fields - which is correct, right?
>>>
>>
>> Take pref_address or relocatable_kernel for example, they have type:
>> read (reloc), does boot loader need to write them? I don't see grub
>> does
>> this at least.
> 
> Read means the boot later reads them.
> 

Sorry I don't know what is going wrong in my mind. For me, if
pref_address has "read (reloc)", base on the current document, it means
boot loader will read it and also write it, which is conflicting. And
the purpose of pref_address should just inform boot loader that kernel
whats itself to be loaded at certain address, it don't want to be written.

-- 
Sincerely,
Cao jin


