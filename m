Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1910C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8D216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 03:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfE0DAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 23:00:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:61440 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfE0DAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 23:00:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 20:00:53 -0700
X-ExtLoop1: 1
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2019 20:00:51 -0700
Subject: Re: [PATCH v6 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
 <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
 <20190515073715.GC24212@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <b8210e0e-bdf2-3e17-ce9a-d7a3ca0e6672@intel.com>
Date:   Mon, 27 May 2019 10:57:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190515073715.GC24212@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年05月15日 15:37, Borislav Petkov wrote:
> On Tue, Apr 30, 2019 at 11:45:26AM +0800, Zhao Yakui wrote:
>> When the ACRN hypervisor is detected, the hypercall is needed so that the
>> ACRN guest can query/config some settings. For example: it can be used
>> to query the resources in hypervisor and manage the CPU/memory/device/
>> interrupt for guest operating system.
>>
>> Add the hypercall so that the ACRN guest can communicate with the
>> low-level ACRN hypervisor. On x86 it is implemented with the VMCALL
>> instruction.
>>
>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
>> v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
>> v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H.
>>          Use the "VMCALL" mnemonic in comment/commit log.
>>          Uppercase r8/rdi/rsi/rax for hypercall parameter register in comment.
>> v5->v6: Remove explicit local register variable for inline assembly
>> ---
>>   arch/x86/include/asm/acrn_hypercall.h | 84 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 arch/x86/include/asm/acrn_hypercall.h
>>
>> diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
>> new file mode 100644
>> index 0000000..5cb438e
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrn_hypercall.h
> 
> Questions:
> 
> * why isn't this in acrn.h and needs to be a separate header?

I refer to the Xen/KVM hypercall to add the ACRN hypercall in one 
separate header.

The ACRN hypercall is defined in one separate acrn_hypercall.h and can 
be included explicitly by the *.c that needs the hypercall.


> 
> * why aren't those functions used anywhere?

The hypercall will be used in driver part. Before the driver part is 
added, it seems that the defined ACRN hypercall functions are not used.
Do I need to add these functions together with driver part?

Thanks
    Yakui
> 
