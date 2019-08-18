Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43BC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CCD21873
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="pO25JSKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHRW2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:28:11 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:55336 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:28:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D7F3E3F6D0;
        Mon, 19 Aug 2019 00:28:08 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pO25JSKn;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HekrHisEvoLz; Mon, 19 Aug 2019 00:28:08 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 76AF03F6BF;
        Mon, 19 Aug 2019 00:28:06 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id DF69A3600A4;
        Mon, 19 Aug 2019 00:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566167286; bh=6XOFftYrHgJWhu81Mj1Y7Ji4bqxYqiH18LnZh+KSKc0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pO25JSKndgHnunaQBWopDOaAYrvQZ06PkepYn4sSk0J8EMDftNemnP/GuCIjJLB/A
         M17RJ16vp5w7JLMWLPANZ+xlxYta3eWOIHYtf1RIEUPWTkBKFzBhom/e6Mvc64do2i
         lVP+Kflw3VoITD7gEnklDaYQKONK+pSR2zx1wsuY=
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190818201942.GC29353@zn.tnic>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b8875504-b112-ba5e-13d7-6abb51c01121@shipmail.org>
Date:   Mon, 19 Aug 2019 00:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190818201942.GC29353@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/19 10:19 PM, Borislav Petkov wrote:
> On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> This is intended to be used by drivers using the backdoor, and
>> we follow the kvm example using alternatives self-patching to
>> choose between vmcall, vmmcall and inl instructions.
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 998c2cc08363..69cecc3bc9cb 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -232,6 +232,8 @@
>>   #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
>>   #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
>>   #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
>> +#define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* VMware prefers VMCALL hypercall instruction */
>> +#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
> Those are not set anywhere in the patchset. Please send them with their
> user.

Thanks for reviewing. Hmm, That hunk appears to have been lost. I'll 
restore in v2.

>
> Then, there already is X86_FEATURE_VMMCALL which you can use too, I'd
> guess.

Unfortunately we can't use it, because it's unconditionally set on AMD 
even if the VMware hypervisor
doesn't support it (by version or by configuration).

I was thinking of having the VMware platform code clear it if vmmcall 
wasn't supported  but that would most probably conflict with other 
hypervisors using the vmmouse driver, still using the old "inl" 
interface for the vmmouse backdoor, but otherwise requiring vmmcall for 
other hypercalls.

>
> Also, I don't see a reason to show the synthetic bit in /proc/cpuinfo
> so when you define it, add "":
>
> #define X86_FEATURE_VMW_VMCALL		( 8*32+18) /* "" VMware prefers VMCALL hypercall instruction */
> 						      ^
> 						      |
> 						      |
> 						      this here.

Ah. I wasn't aware of that. I'll add. Thanks.

Thomas


>
> Thx.
>

