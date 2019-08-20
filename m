Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BBC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E622DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="pc9cQtrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfHTNeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:34:37 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:48338 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfHTNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:34:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 902503F7A2;
        Tue, 20 Aug 2019 15:34:29 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pc9cQtrm;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T8zTOd1saZAy; Tue, 20 Aug 2019 15:34:28 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B92823F4AA;
        Tue, 20 Aug 2019 15:34:26 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 29E94360142;
        Tue, 20 Aug 2019 15:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566308066; bh=p08T2tUCRkinmvQgEWWdKWntf5MKPjK9265lF/lWTUs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pc9cQtrm58CoytcPegkwHkPaWsa5iRay0++Ol02JdcBofBECrqdrTIAMCKc71NAF3
         SLIa5uJfmwANAZL7pAKXTxf5BalY1pFONjCNvdrG/+GfF+QfybcGT+Cr7eZqtrym4s
         pnyPWItOsfzp4FzU49TLYbX242mnycy+6j6VZDR4=
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190820113203.GM2332@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <597132a4-2514-2f13-5786-b423d82b7fd4@shipmail.org>
Date:   Tue, 20 Aug 2019 15:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820113203.GM2332@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 1:32 PM, Peter Zijlstra wrote:
> On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:
>
>> +#define VMWARE_HYPERCALL \
>> +	ALTERNATIVE_2(".byte 0xed", \
>> +		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
>> +		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMW_VMMCALL)
> For sanity, could we either add comments, or macros for those
> instrucions?

Hmm. Here I followed and slightly extended what was done in asm/kvm_para.h.

What confuses me a bit is, if it's clarity we're after, why don't people use

#define VMWARE_HYPERCALL 					\
	ALTERNATIVE_2("inl (%%dx)", 				\
		      "vmcall", X86_FEATURE_VMW_VMCALL,		\	
		      "vmmcall", X86_FEATURE_VMW_VMMCALL)

Seems to build fine here. Is it fear of old assemblers not supporting, for example vmmcall

Thanks,
/Thomas
  

> Something like:
>
> #define INSN_INL	0xed
> #define INSN_VMCALL	0x0f,0x01,0xc1
> #define INSN_VMMCALL	0x0f,0x01,0xd9
>
> #define VMWARE_HYPERCALL \
> 	ALTERNATIVE_2(_ASM_MK_NOP(INSN_INL),
> 		      _ASM_MK_NOP(INSN_VMCALL), X86_FEATURE_VMCALL,
> 		      _ASM_MK_NOP(INSN_VMMCALL), X86_FEATURE_VMMCALL)
>
> With possibly a patch that does 's/_ASM_MK_NOP/_ASM_MK_INSN/' on
> arch/x86/ for further sanity :-)


