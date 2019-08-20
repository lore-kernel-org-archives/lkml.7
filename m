Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D149BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EEF2339D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="iWwLw8IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfHTTTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:19:47 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:45904 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfHTTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:19:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 58BC63F6E0;
        Tue, 20 Aug 2019 21:19:44 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=iWwLw8IS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1fZYgUt5HZ-L; Tue, 20 Aug 2019 21:19:43 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2B7EE3F4AA;
        Tue, 20 Aug 2019 21:19:41 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 71EBF3600CD;
        Tue, 20 Aug 2019 21:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566328781; bh=3wFO9paJywUnDqiqMAk/LQH2V5FGMYiXvSekFU37fYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iWwLw8IS5QgMlxrXDZYWEO/pzdUNfzTZcJgiZ2OiDN+6oyd3x5KTae4CspgnFV5JE
         hB+GPEiWqM/kbgX+DJ7JQgFXnCq9LWoA2VDnw0pwgz3mlLxAFctQlQlAUZvD1ZUCK0
         CrYBqeOWw+xYVRgzLt27CD6rrAtfa6NnAcHlJEfQ=
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190820113203.GM2332@hirez.programming.kicks-ass.net>
 <597132a4-2514-2f13-5786-b423d82b7fd4@shipmail.org>
 <alpine.DEB.2.21.1908201540400.2223@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <e7002524-2572-57af-176a-d6b924c98738@shipmail.org>
Date:   Tue, 20 Aug 2019 21:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908201540400.2223@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 3:42 PM, Thomas Gleixner wrote:
> On Tue, 20 Aug 2019, Thomas Hellström (VMware) wrote:
>
>> On 8/20/19 1:32 PM, Peter Zijlstra wrote:
>>> On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:
>>>
>>>> +#define VMWARE_HYPERCALL \
>>>> +	ALTERNATIVE_2(".byte 0xed", \
>>>> +		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
>>>> +		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMW_VMMCALL)
>>> For sanity, could we either add comments, or macros for those
>>> instrucions?
>> Hmm. Here I followed and slightly extended what was done in asm/kvm_para.h.
>>
>> What confuses me a bit is, if it's clarity we're after, why don't people use
>>
>> #define VMWARE_HYPERCALL 					\
>> 	ALTERNATIVE_2("inl (%%dx)", 				\
>> 		      "vmcall", X86_FEATURE_VMW_VMCALL,		\	
>> 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
>>
>> Seems to build fine here. Is it fear of old assemblers not supporting, for
>> example vmmcall
> The requirement for binutils is version >= 2.21. If 2.21 supports vmcall and
> vmmcall all good.
>
> Thanks,
>
> 	tglx

So I tested 2.20.1 and 2.21.1 from ftp.gnu.org/gnu/binutils, and both 
seem to assemble (as-new) and disassemble (objdump -S) vmcall and 
vmmcall fine so I think we should be OK using the mnemonic format then.

Thanks,

Thomas




<https://ftp.gnu.org/gnu/binutils/>

