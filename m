Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16659218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCWK7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:59:46 -0400
Received: from [110.188.70.11] ([110.188.70.11]:38719 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfCWK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:59:46 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id x2NAuq2x064531;
        Sat, 23 Mar 2019 18:56:52 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x2NAumNl061105;
        Sat, 23 Mar 2019 18:56:48 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 23 Mar
 2019 18:56:49 +0800
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic for
 multi-die processor
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
 <20190322171632.GI12472@zn.tnic>
 <18e15073-81c2-73a3-abf1-e785d6a5649b@hygon.cn>
 <20190323085934.GB23698@zn.tnic>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <e181933e-775a-4597-7700-9dde8b98295f@hygon.cn>
Date:   Sat, 23 Mar 2019 18:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323085934.GB23698@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x2NAuq2x064531
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/23 16:59, Borislav Petkov wrote:
> On Sat, Mar 23, 2019 at 10:13:39AM +0800, Pu Wen wrote:
>> Current physical id is computed via "phys_proc_id = initial_apicid >>
>> bits".
>>
>> For 4-Die 2 socket system, the physical id of socket 2 is:
>> initial_apicid >> bits = 0b1xxxxxx >> 6 = 1.
>> The result is true.
>>
>> But for 2-Die 2 socket system, the physical id of socket 2 is:
>> initial_apicid >> bits = 0b10xxxxx >> 5 = 2,
>> and for 1-Die 2 socket system, the physical id of socket 2 is:
>> initial_apicid >> bits = 0b100xxxx >> 4 = 4.
>> The results are not correct any more.
>>
>> So the adjustment for the 1-Die/2-Die 2 socket system is needed.
>> And just use ApicId[6], which already defined the right thing, as the
>> socket ID.
> 
> I understand all that. But let me repeat my question:
> 
> So why do you need to do something different than what AMD does?
> 
> You said you're programming the initial APIC ID the same as AMD. So why
> doesn't this need to be changed in AMD code too but only for hygon?

Because AMD doesn't have 2-Socket system with 1-Die/2-Die processors(see
reference [2]). So it will return the right result when getting physical
ID in AMD system.

[2] https://www.amd.com/en/products/specifications/processors

-- 
Regards,
Pu Wen
