Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D78C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D3721873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfGSRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:18:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37403 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfGSRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:18:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so7910433wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 10:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e6CLIOKxxHQ60CyDNUesfrqwN5wWOdGDSUFSJX50UpA=;
        b=dfzXMkfZaml06i9z8TRKJGRBKFEcood4+B3+/tLgAeig0oq0fND8gV/TtGSz+OLQYL
         t9gk234Z4D5FmkG9FasjJIImbIS04/eiZyKrBf19R5VV8ZIrGB3J04J0yYnIcMIiMPJj
         loR7lRO8tZ0zfSzrh8CWzDAHnrTmxMQB1XZ/xJ+83cMx4CbKi8J1jSI9txPt1JqKq4Yq
         DKijbttkwwUbc42KIi8CgHqCjSznRvR9R+p5UMPQJ9biXTHMaj2g6qNzFLXJu4nPBgPa
         6PTwFZiq2XnIGSURjvb/O5kwNk4N3bYn+DY4amnsVCIcQa8Ikxpp9MgfsoSyUMjh/nHu
         pTbA==
X-Gm-Message-State: APjAAAU2CSc4ewxAGRkJt3kFCSrN4Dqf0GXiTJ0hp0GVzdAsEJTqTtJH
        RexoRIbBXZILMIAWKyoMvk5dyA==
X-Google-Smtp-Source: APXvYqzJx1HwtFtqTy4uddTx8HPLulB4T5O8jWKvOwCs9aejPI5UxADk2J/Yq8//ReZVhtr/rpQLGA==
X-Received: by 2002:adf:8364:: with SMTP id 91mr57058267wrd.13.1563556713168;
        Fri, 19 Jul 2019 10:18:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8? ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
        by smtp.gmail.com with ESMTPSA id w14sm23627591wrk.44.2019.07.19.10.18.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:18:32 -0700 (PDT)
Subject: Re: [PATCH v8 0/3] KVM: x86: Enable user wait instructions
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, xiaoyao.li@linux.intel.com,
        jingqi.liu@intel.com
References: <20190716065551.27264-1-tao3.xu@intel.com>
 <d01e6b8b-279c-84da-1f08-7b01baf9fdbf@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ad687740-1525-f9c2-b441-63613b7dd93e@redhat.com>
Date:   Fri, 19 Jul 2019 19:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d01e6b8b-279c-84da-1f08-7b01baf9fdbf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/19 08:31, Tao Xu wrote:
> Ping for comments :)

Hi, I'll look at it for 5.4, right after the merge window.

Paolo

> On 7/16/2019 2:55 PM, Tao Xu wrote:
>> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
>>
>> UMONITOR arms address monitoring hardware using an address. A store
>> to an address within the specified address range triggers the
>> monitoring hardware to wake up the processor waiting in umwait.
>>
>> UMWAIT instructs the processor to enter an implementation-dependent
>> optimized state while monitoring a range of addresses. The optimized
>> state may be either a light-weight power/performance optimized state
>> (c0.1 state) or an improved power/performance optimized state
>> (c0.2 state).
>>
>> TPAUSE instructs the processor to enter an implementation-dependent
>> optimized state c0.1 or c0.2 state and wake up when time-stamp counter
>> reaches specified timeout.
>>
>> Availability of the user wait instructions is indicated by the presence
>> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>>
>> The patches enable the umonitor, umwait and tpause features in KVM.
>> Because umwait and tpause can put a (psysical) CPU into a power saving
>> state, by default we dont't expose it to kvm and enable it only when
>> guest CPUID has it. If the instruction causes a delay, the amount
>> of time delayed is called here the physical delay. The physical delay is
>> first computed by determining the virtual delay (the time to delay
>> relative to the VM’s timestamp counter).
>>
>> The release document ref below link:
>> Intel 64 and IA-32 Architectures Software Developer's Manual,
>> https://software.intel.com/sites/default/files/\
>> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
>>
>> Changelog:
>> v8:
>>     Add vmx_waitpkg_supported() helper (Sean)
>>     Add an accessor to expose umwait_control_cached (Sean)
>>     Set msr_ia32_umwait_control in vcpu_vmx u32 and raise #GP when
>>     [63:32] is set when rdmsr. (Sean)
>>     Introduce a common exit helper handle_unexpected_vmexit (Sean)
>> v7:
>>     Add nested support for user wait instructions (Paolo)
>>     Use the test on vmx->secondary_exec_control to replace
>>     guest_cpuid_has (Paolo)
>> v6:
>>     add check msr_info->host_initiated in get/set msr(Xiaoyao)
>>     restore the atomic_switch_umwait_control_msr()(Xiaoyao)
>>
>> Tao Xu (3):
>>    KVM: x86: Add support for user wait instructions
>>    KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
>>    KVM: vmx: Introduce handle_unexpected_vmexit and handle WAITPKG vmexit
>>
>>   arch/x86/include/asm/vmx.h      |  1 +
>>   arch/x86/include/uapi/asm/vmx.h |  6 ++-
>>   arch/x86/kernel/cpu/umwait.c    |  6 +++
>>   arch/x86/kvm/cpuid.c            |  2 +-
>>   arch/x86/kvm/vmx/capabilities.h |  6 +++
>>   arch/x86/kvm/vmx/nested.c       |  5 ++
>>   arch/x86/kvm/vmx/vmx.c          | 83 ++++++++++++++++++++++++++-------
>>   arch/x86/kvm/vmx/vmx.h          |  9 ++++
>>   arch/x86/kvm/x86.c              |  1 +
>>   9 files changed, 101 insertions(+), 18 deletions(-)
>>
> 

