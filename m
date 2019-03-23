Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C92F218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfCWDGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:06:16 -0400
Received: from [110.188.70.11] ([110.188.70.11]:33280 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbfCWDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:06:15 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id x2N309YN026974;
        Sat, 23 Mar 2019 11:00:10 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x2N3048I023603;
        Sat, 23 Mar 2019 11:00:04 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 23 Mar
 2019 11:00:05 +0800
Subject: Re: [RFC PATCH] x86/cpu/hygon: Fix phys_proc_id calculation logic for
 multi-die processor
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1553251380-7015-1-git-send-email-puwen@hygon.cn>
 <20190322155449.GE12472@zn.tnic>
 <639a5bc6-f821-ee9d-1594-d02701321192@hygon.cn>
 <20190322164445.GG12472@zn.tnic>
 <20190322165214.GI7905@worktop.programming.kicks-ass.net>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <a31e6d79-bc60-b339-185b-58649516aae5@hygon.cn>
Date:   Sat, 23 Mar 2019 11:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322165214.GI7905@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x2N309YN026974
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/23 0:52, Peter Zijlstra wrote:
> On Fri, Mar 22, 2019 at 05:44:45PM +0100, Borislav Petkov wrote:
>> On Sat, Mar 23, 2019 at 12:19:01AM +0800, Pu Wen wrote:
>>> That 6 is not a magic number.
>>
>> Well, if I see a naked 6, then it is only magic to me. Now if it were a
>> proper define with a descriptive name...
> 
> Does AMD/Hygon not have a CPUID leaf to read useful things like this
> from?

ApicId[6] is read from CPUID_Fn00000001_EBX[30].
Please see section 2.1.11.1 and 2.1.10.2.1.3 of referrence [1].

Reference:
[1] https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf

-- 
Regards,
Pu Wen
