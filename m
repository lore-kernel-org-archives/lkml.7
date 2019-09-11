Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCCDC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3A2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfIKQZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:25:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfIKQZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:25:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D46913D3C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 16:25:44 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id j3so10684983wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jouLTsamzJ4avMDtLnEA4ZYZ2r8dstKdUGPZA1EeyPc=;
        b=QZkn+VZ1VdH4nJGGCTXYwPguAmAvgEzhjVNpTZ6bgBcAeV5lxfbOkYjLQoQs6oXYvP
         inIm707JDjSbExdUazJhfYtm3lYi5urr0yYjCmKV4d0dOk/qEtPLAvCtyg9EXuAz3noP
         /Ip4c10saF+L8eB38XdeSJ0nsFM3j+5vdyla0IifAZNt9dX/eHnqNBq1Dcu8r6CY1bkj
         KNfzSFBGikysYWcRwaQV/b63QVLXaz+JlLOq+NCjwchpmryZcUKPDXd6WDnQQCmtyuwY
         wVy/P9IZMRnw1It65c5JOYw+NniPKihh5hYxh/sVNZq6fzyu4cI/A+Iu8y325Xd7Eui4
         b8+Q==
X-Gm-Message-State: APjAAAWRG9I9EXLaNJel7q0bYDbzHCCB0mZr0tU13twKz9keb0Klla54
        IhnFE0mC1IKXEnLs5tg533HGHk371afcwCab/35DQa5HVGmsTndSmfkLZRGMPRmXR/hKkHo1ep2
        b5G8bwddKb45u75iUIO/RD6Bs
X-Received: by 2002:adf:db8e:: with SMTP id u14mr5211830wri.50.1568219143519;
        Wed, 11 Sep 2019 09:25:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9RLDSUAqf9dPaonHEiASXp5JqjZOlzrrW+BDIVOqMn9pjKU55MQl1oFpGGrhgDg26esMu6w==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr5211814wri.50.1568219143230;
        Wed, 11 Sep 2019 09:25:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6? ([2001:b07:6468:f312:102b:3795:6714:7df6])
        by smtp.gmail.com with ESMTPSA id d78sm4041480wmd.47.2019.09.11.09.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:25:42 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Fix SynIC Timers inject timer interrupt w/o
 LAPIC present
To:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1567680270-14022-1-git-send-email-wanpengli@tencent.com>
 <87ftlakhn6.fsf@vitty.brq.redhat.com>
 <CANRm+CyPxb+ZY2cTdbLL_LBKMJSOaMqnPGKc_ATc6-TMHW-rJw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <23b9c284-9317-2c9a-ed3d-6bdf9ac0dea5@redhat.com>
Date:   Wed, 11 Sep 2019 18:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CyPxb+ZY2cTdbLL_LBKMJSOaMqnPGKc_ATc6-TMHW-rJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/19 03:54, Wanpeng Li wrote:
> On Thu, 5 Sep 2019 at 21:16, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> Wanpeng Li <kernellwp@gmail.com> writes:
>>
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Reported by syzkaller:
>>>
>>>       kasan: GPF could be caused by NULL-ptr deref or user memory access
>>>       general protection fault: 0000 [#1] PREEMPT SMP KASAN
>>>       RIP: 0010:__apic_accept_irq+0x46/0x740 arch/x86/kvm/lapic.c:1029
>>>       Call Trace:
>>>       kvm_apic_set_irq+0xb4/0x140 arch/x86/kvm/lapic.c:558
>>>       stimer_notify_direct arch/x86/kvm/hyperv.c:648 [inline]
>>>       stimer_expiration arch/x86/kvm/hyperv.c:659 [inline]
>>>       kvm_hv_process_stimers+0x594/0x1650 arch/x86/kvm/hyperv.c:686
>>>       vcpu_enter_guest+0x2b2a/0x54b0 arch/x86/kvm/x86.c:7896
>>>       vcpu_run+0x393/0xd40 arch/x86/kvm/x86.c:8152
>>>       kvm_arch_vcpu_ioctl_run+0x636/0x900 arch/x86/kvm/x86.c:8360
>>>       kvm_vcpu_ioctl+0x6cf/0xaf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2765
>>>
>>> The testcase programs HV_X64_MSR_STIMERn_CONFIG/HV_X64_MSR_STIMERn_COUNT,
>>> in addition, there is no lapic in the kernel, the counters value are small
>>> enough in order that kvm_hv_process_stimers() inject this already-expired
>>> timer interrupt into the guest through lapic in the kernel which triggers
>>> the NULL deferencing. This patch fixes it by checking lapic_in_kernel,
>>> discarding the inject if it is 0.
>>>
>>> Reported-by: syzbot+dff25ee91f0c7d5c1695@syzkaller.appspotmail.com
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>>  arch/x86/kvm/hyperv.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>>> index c10a8b1..461fcc5 100644
>>> --- a/arch/x86/kvm/hyperv.c
>>> +++ b/arch/x86/kvm/hyperv.c
>>> @@ -645,7 +645,9 @@ static int stimer_notify_direct(struct kvm_vcpu_hv_stimer *stimer)
>>>               .vector = stimer->config.apic_vector
>>>       };
>>>
>>> -     return !kvm_apic_set_irq(vcpu, &irq, NULL);
>>> +     if (lapic_in_kernel(vcpu))
>>> +             return !kvm_apic_set_irq(vcpu, &irq, NULL);
>>> +     return 0;
>>>  }
>>>
>>>  static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
>>
>> Hm, but this basically means direct mode synthetic timers won't work
>> when LAPIC is not in kernel but the feature will still be advertised to
>> the guest, not good. Shall we stop advertizing it? Something like
>> (completely untested):
>>
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 3f5ad84853fb..1dfa594eaab6 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -1856,7 +1856,13 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>>
>>                         ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>>                         ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
>> -                       ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
>> +
>> +                       /*
>> +                        * Direct Synthetic timers only make sense with in-kernel
>> +                        * LAPIC
>> +                        */
>> +                       if (lapic_in_kernel(vcpu))
>> +                               ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
>>
>>                         break;
> 
> Thanks, I fold this into v2, syzkaller even didn't check the cpuid, so
> I still keep the discard inject part.

Can you also include a beautified testcase or at least a link to the
syzkaller source?

Thanks,

Paolo
