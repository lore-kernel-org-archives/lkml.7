Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824D20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfDZDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:21:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:35922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDZDVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:21:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 20:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; 
   d="scan'208";a="137575842"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2019 20:21:18 -0700
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
Date:   Fri, 26 Apr 2019 11:18:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190425110025.GA16164@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月25日 19:00, Borislav Petkov wrote:
> On Thu, Apr 25, 2019 at 06:16:02PM +0800, Zhao, Yakui wrote:
>> The parameter register for the VMCALL is predefined in ACRN hypervisor. Now
>> the R8 is used to pass the hcall_id.
>> It seems that there is no special constraint for R8~R15.
>> So the explicit register variable is used so that the R8 can be passed.
> 
> If you're going to use the constraint "D" for param1, you can just as
> well do
> 
> 	"=a" (result)
> 
> everywhere since you have the letter constraint for %rax instead of
> declaring it with "register".
> 
> Also, you can completely get rid of those "register" declarations
> and let gcc have all the freedom to pass in hcall_id and the other
> parameters:
Thanks Borislav for providing the code.

It seems that it is seldom used in kernel although the explicit register 
variable is supported by GCC and makes the code look simpler. And it 
seems that the explicit register variable is not suppoorted by CLAG.


So the explicit register variable will be removed. I will follow the asm 
code from Borislav. Of course one minor change is that the "movq" is 
used instead of "mov".

Is this ok?

Thanks

> 
> 	unsigned long result;
> 
>          asm volatile("mov %[hcall_id], %%r8\n\t"
>                       "vmcall\n\t"
>                       : "=a" (result)
>                       : [hcall_id] "g" (hcall_id)
>                       : "r8");
> 
>          return result;
> 
> and %r8 will be in the clobber list so gcc will reload it if needed.
> 
> gcc turns it into
> 
> 0000000000001040 <main>:
>      1040:       4c 8b 05 e1 2f 00 00    mov    0x2fe1(%rip),%r8        # 4028 <hcall_id>
>      1047:       0f 01 c1                vmcall
>      104a:       c3                      retq
>      104b:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 
> here.
> 
