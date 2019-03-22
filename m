Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84794C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F20218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCVQVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:21:48 -0400
Received: from [110.188.70.11] ([110.188.70.11]:5237 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727246AbfCVQVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:21:48 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id x2MGJ5JE005624;
        Sat, 23 Mar 2019 00:19:06 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x2MGJ0Pv072954;
        Sat, 23 Mar 2019 00:19:00 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 23 Mar
 2019 00:19:00 +0800
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic for
 multi-die processor
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
Date:   Sat, 23 Mar 2019 00:19:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322155449.GE12472@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x2MGJ5JE005624
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/22 23:55, Borislav Petkov wrote:
> On Fri, Mar 22, 2019 at 06:43:00PM +0800, Pu Wen wrote:
>> Current codes direct use "phys_proc_id = initial_apicid >> bits", which
> 
> Use proper english please - there's no "codes"
> 
>> calc phys_proc_id from initial_apicid by shifting *bits*, will get
> 
> ... or "calc"

Okay, will correct the spelling.

>> For Hygon family 18h CPU the socket ID should be obtained from ApicId[6].
>> To fix the problem and match ApicID field definition, adjust the shift
>> bits to 6 for all Hygon family 18h multi-die CPUs.
> 
> Sounds to me like you're programming the initial APIC ID not
> the same way as AMD do...

In the same way.

>> Reference:
>> [1] https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> ---
>>   arch/x86/kernel/cpu/hygon.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
>> index cf25405..2df6dd9 100644
>> --- a/arch/x86/kernel/cpu/hygon.c
>> +++ b/arch/x86/kernel/cpu/hygon.c
>> @@ -87,6 +87,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
>>   		if (!err)
>>   			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
>>   
>> +		/* Socket ID is ApicId[6] for these processors. */
>> +		c->phys_proc_id = c->apicid >> 6;
> 
> That 6 is a magic number, I assume?

That 6 is not a magic number. It indicate bit 6 of ApicId. This calculation
is the same as the LLC ID calculation in cacheinfo_hygon_init_llc_id().

-- 
Regards,
Pu Wen
