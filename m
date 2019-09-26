Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB35222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPr6feej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfIZPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:20:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yLzCCbA1xxgfSSaN55ak3+kri+HafX9octEvTxgZHQ4=; b=QPr6feejBrc5AYDFCfltGGA9g
        MOBKVaJNT8g359mo5ovvj7SADpWggwaleaynmHTmIYrP0Dvoza9azT1TCvicyZuy9cv5sANCwT5W3
        FF2mFDgv3fPhc3hN6hocoT+L4rJuD25u1PZbE61MAfmTXHNk8R0mjCVermC1hgulxsQNBhNEldsMD
        gh4TwP/rzW80LblNU6jyYPgNR+2MnxFo+EM6EDSKKJdOEXsKzFiYZ3MsDbGNPX2nYvsefFcRJhyB3
        ZBi7dDMANOsy7GNmE1geqRK3jmUBJTtd4fcii6HYFMX87s2QXBhODXtm8z67ADOVa6PpQGLnU6pDf
        OrGBGwJzA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDVZF-00039v-NT; Thu, 26 Sep 2019 15:20:29 +0000
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of
 "reloc"
To:     hpa@zytor.com, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, corbet@lwn.net
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com>
 <20190926060139.GA100481@gmail.com>
 <faabfe47-ba3e-5a92-af65-dc26e8e2ecb9@cn.fujitsu.com>
 <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f7a1d739-94ae-f6d3-efdb-9748e5e03f82@infradead.org>
Date:   Thu, 26 Sep 2019 08:20:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3073CD01-65C5-4BEC-B2FC-F76DD0E70D73@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 12:58 AM, hpa@zytor.com wrote:
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

is that          boot loader ??


-- 
~Randy
