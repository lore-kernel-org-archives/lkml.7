Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71773C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2F92067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfIQRFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfIQRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:05:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A4866412B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 17:05:21 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id z1so1531749wrw.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 10:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6xejXDOMQ6KuyMfFm1U1GgbUuSpZUSZNER6+lLzGmc=;
        b=RcKo5ftzJkIugOn5f0in0Ntaav3PQhDVzH16U1tmu5Wl44o9g5N90iSWayluMH81wE
         m7sfBwvaloDRyQIMU1oAIm2mK/lz1KBbZZ0wEvpJSOrXdq9EuFO3gCWD4emenB/+rk4e
         eKQbF4D5gEp8auITvdBR1AZulu6tBimNfnieZwFUWTUcWV+y2HyLm7fVNGNn3sTZmrH6
         E++mhoWafwgB15U9kKYQUCwjSNVb8+CaMqSzWz78zB07vzH1N7XKuEDwSA1MA39FwU2u
         oif6UAYMd/le24n3+mf0f6x1cQshAj66IDK8gPrR0YAuLtV0Rww3jEgNI5wxzApQktKQ
         UwXA==
X-Gm-Message-State: APjAAAVy6G5OodWYbeV3KzK9wdP8d7K/hqLh1swFxxGmeDVpEmtSIfE7
        8sUeWQAj9VZpWDbsBJ7y/6ouLFIr2PbR76uDqHdp6pxOzgDtE52JdYnSPQ4Bp1SuSuLPZ24XkVg
        sHuGQDndLWHXIhArImJMLzb5q
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr3653223wru.198.1568739920066;
        Tue, 17 Sep 2019 10:05:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJ0DbeEHzBFaKEv6qVKXKe/VqIgn8HZlgAzW1WduAOnlbb2RWLukrZ6EHzIuJagKt0d7rRtA==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr3653188wru.198.1568739919677;
        Tue, 17 Sep 2019 10:05:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id c6sm4140610wrb.60.2019.09.17.10.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:05:19 -0700 (PDT)
Subject: Re: [PATCH v8 0/3] KVM: x86: Enable user wait instructions
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jingqi.liu@intel.com
References: <20190716065551.27264-1-tao3.xu@intel.com>
 <d01e6b8b-279c-84da-1f08-7b01baf9fdbf@intel.com>
 <ad687740-1525-f9c2-b441-63613b7dd93e@redhat.com>
 <ca969df2-a42a-3e7c-f49c-6b59d097b3de@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a4bbc34c-9a0a-1bfb-2d56-c71a8d9a52c9@redhat.com>
Date:   Tue, 17 Sep 2019 19:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca969df2-a42a-3e7c-f49c-6b59d097b3de@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/19 03:28, Tao Xu wrote:
> On 7/20/2019 1:18 AM, Paolo Bonzini wrote:
>> On 19/07/19 08:31, Tao Xu wrote:
>>> Ping for comments :)
>>
>> Hi, I'll look at it for 5.4, right after the merge window.
>>
>> Paolo
>>
> Hi paolo,
> 
> Linux 5.3 has released, could you review these patches. Thank you very
> much!
> 
> Tao
>>> On 7/16/2019 2:55 PM, Tao Xu wrote:
>>>> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
>>>>
>>>> UMONITOR arms address monitoring hardware using an address. A store
>>>> to an address within the specified address range triggers the
>>>> monitoring hardware to wake up the processor waiting in umwait.
>>>>
>>>> UMWAIT instructs the processor to enter an implementation-dependent
>>>> optimized state while monitoring a range of addresses. The optimized
>>>> state may be either a light-weight power/performance optimized state
>>>> (c0.1 state) or an improved power/performance optimized state
>>>> (c0.2 state).
>>>>
>>>> TPAUSE instructs the processor to enter an implementation-dependent
>>>> optimized state c0.1 or c0.2 state and wake up when time-stamp counter
>>>> reaches specified timeout.
>>>>
>>>> Availability of the user wait instructions is indicated by the presence
>>>> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
>>>>
>>>> The patches enable the umonitor, umwait and tpause features in KVM.
>>>> Because umwait and tpause can put a (psysical) CPU into a power saving
>>>> state, by default we dont't expose it to kvm and enable it only when
>>>> guest CPUID has it. If the instruction causes a delay, the amount
>>>> of time delayed is called here the physical delay. The physical
>>>> delay is
>>>> first computed by determining the virtual delay (the time to delay
>>>> relative to the VM’s timestamp counter).
>>>>
>>>> The release document ref below link:
>>>> Intel 64 and IA-32 Architectures Software Developer's Manual,
>>>> https://software.intel.com/sites/default/files/\
>>>> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
>>>>
>>>> Changelog:
>>>> v8:
>>>>      Add vmx_waitpkg_supported() helper (Sean)
>>>>      Add an accessor to expose umwait_control_cached (Sean)
>>>>      Set msr_ia32_umwait_control in vcpu_vmx u32 and raise #GP when
>>>>      [63:32] is set when rdmsr. (Sean)
>>>>      Introduce a common exit helper handle_unexpected_vmexit (Sean)
>>>> v7:
>>>>      Add nested support for user wait instructions (Paolo)
>>>>      Use the test on vmx->secondary_exec_control to replace
>>>>      guest_cpuid_has (Paolo)
>>>> v6:
>>>>      add check msr_info->host_initiated in get/set msr(Xiaoyao)
>>>>      restore the atomic_switch_umwait_control_msr()(Xiaoyao)
>>>>
>>>> Tao Xu (3):
>>>>     KVM: x86: Add support for user wait instructions
>>>>     KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
>>>>     KVM: vmx: Introduce handle_unexpected_vmexit and handle WAITPKG
>>>> vmexit
>>>>
>>>>    arch/x86/include/asm/vmx.h      |  1 +
>>>>    arch/x86/include/uapi/asm/vmx.h |  6 ++-
>>>>    arch/x86/kernel/cpu/umwait.c    |  6 +++
>>>>    arch/x86/kvm/cpuid.c            |  2 +-
>>>>    arch/x86/kvm/vmx/capabilities.h |  6 +++
>>>>    arch/x86/kvm/vmx/nested.c       |  5 ++
>>>>    arch/x86/kvm/vmx/vmx.c          | 83
>>>> ++++++++++++++++++++++++++-------
>>>>    arch/x86/kvm/vmx/vmx.h          |  9 ++++
>>>>    arch/x86/kvm/x86.c              |  1 +
>>>>    9 files changed, 101 insertions(+), 18 deletions(-)
>>>>
>>>
>>
> 

Queued, thanks.

Paolo
