Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B57C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C77214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfLKOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:14:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:5834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKOOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:14:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 06:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="215794088"
Received: from jgullbra-mobl.amr.corp.intel.com (HELO [10.251.27.60]) ([10.251.27.60])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2019 06:13:37 -0800
Subject: Re: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than
 struct declaration
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        jon.grimm@amd.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
 <b63e2111-b0c6-a716-3d99-88f91ad64e1d@intel.com>
 <68bdd6f0-a229-433a-9234-303a3b02b092@amd.com>
 <4b20cff5-6e16-3599-4fc1-4f51d7c18d1d@intel.com>
 <7a8fe748-2c57-295a-e6ed-8969c41462aa@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <d092bae0-69ea-0a57-4db5-6de074956564@intel.com>
Date:   Wed, 11 Dec 2019 06:13:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7a8fe748-2c57-295a-e6ed-8969c41462aa@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 9:24 PM, Suravee Suthikulpanit wrote:
>>> Yes, the implementation includes the padding size within the size of
>>> the enumerated state. This results in the reported size larger than
>>> the amount needed by the feature.
> 
> Actually, please allow me clarify my understanding for this part.
> 
> When you referred to "the existing architecture for padding", IIUC,
> that's the XSAVE state size, offset, and alignment of each extended
> feature reported by the CPUID Fn 0Dh E[A|B|C]X. By "padding", do you
> mean the additional area included as part of alignment?

I was specifically thinking of this nugget in Intel's SDM, Volume 1, 13.2:

> The value returned by ECX[1] indicates the alignment of state
> component i when the compacted format of the extended region of an
> XSAVE area is used (see Section 13.4.3). If ECX[1] returns 0, state
> component i is located immediately following the preceding state
> component; if ECX[1] returns 1, state component i is located on the
> next 64-byte boundary following the preceding state component.

Essentially, if an implementation needs state alignment or (up to) 64
bytes of padding, it could use this existing architecture for it.

>> I don't think we've ever had XSAVE state that differed in size between
>> implementations.  This kind of thing ensures that we can't have any
>> statically-defined inspection into the XSAVE state.
>>
>> It also increases the amount of blind trust that we have in the CPU
>> implementations.  However, those warnings were specifically added at
>> Ingo's behest (IIRC) to reduce our blind trust in the CPU.
> 
> I am not quite sure what you meant by "statically-defined inspection"

Previously, it was possible to depend on a constant offset for a state
component in an XSAVE buffer.  You could literally say "PKRU is at
offset 0x1234" (or whatever).  All implementations had PKRU in the same
spot (without the compacted format).

BTW, I'm not saying this is a problem.  The documented XSAVE
architecture itself has no provisions for the state being accessed like
this.

> and "blind trust".

I think I actually parroted the term from Ingo:

https://lore.kernel.org/lkml/20150808090615.GA32641@gmail.com/

But the point is that with your patch, the kernel becomes less strict
about what we demand from the CPU.  That might lead to letting CPU bugs
creep in that might cause real problems later.

> Please correct me if I am wrong, but I believe this is similar to the
> case mentioned in the commit ef78f2a4bf84 ('x86/fpu: Check
> CPU-provided sizes against struct declarations'), where it mentions
> inconsistency b/w the MPX 'bndcsr' state and the C structures.

Yep, but I fixed that by padding the C structure, not silencing the
warning.  Also *ALL* MPX implementations have had the same size for that
state.

If we go forward with this patch, we should also removing the
pad_to_64_bytes[] from 'struct mpx_bndcsr_state'.

> What I have been told (by HW folks) is that the hardware reports 32 bytes for PKRU feature
> to account for additional padding (24 bytes) required to maintain offset for the XSAVE data
> in compact form where:
> 
>     offset of the next component = offset of current component +
>                                    size of current component
> 
> In this case, the hardware adds the padding needed before the offset of the subsequent
> feature into the PKRU xsave state size. 

Huh, that's exactly why I thought we added ECX[1]. to the architecture.
