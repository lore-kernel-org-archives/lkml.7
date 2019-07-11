Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B42C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21D320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 14:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGKOD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 10:03:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40765 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfGKOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:03:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so5826245wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 07:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QbsSGvqJ1CROTsT5zLLVFOwwglNu1pmlg45SGVssb4=;
        b=DYsY9OqK4OLIZEhPxuBx5l/5QNhmF+aHXjh0sCNnf93EMvsO+nqpSlBx++xQmWvou4
         K+pPvcT8ceyoe8idSv/SR8Pmg+HwETrq2fBkid/nkzUlYSBSIaxy/PkxxQXcB4B/TLSK
         tU6vpPIhlQrCjZfIW+kENajBU35U0MBEKVAOKElI3qY/8YFmEZ/y1453yPaUV4+nTD0a
         NVbGgOH1/6NAl3aIvof1K5Ckg15QFEytQ/xRH6cTxLEuKJ3Rm/3yOkIqFT0jVB1DO+Qb
         sIxpm3aOjjbir3B8KqJA46pcEBi32OTF4hj1IHb8jc7cz9+JApUkz6PYTv6rP8cDB7St
         60vg==
X-Gm-Message-State: APjAAAXa2cZT/x68K5Z3gMXSUAoxkZPP5u/6k8++bgfGOdr4Io4Q2Hzb
        lKn/JOxKfwWAiphTeo3S1sT92g==
X-Google-Smtp-Source: APXvYqzh6zwnHmawBqkGTbmYDoU5rPq3y00zlzSXhV26u1DNGPq/ZMb66ZRXshWEHTLxCjHvf+LxIg==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr4738999wmc.75.1562853835240;
        Thu, 11 Jul 2019 07:03:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab? ([2001:b07:6468:f312:d066:6881:ec69:75ab])
        by smtp.gmail.com with ESMTPSA id m16sm5509406wrv.89.2019.07.11.07.03.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 07:03:54 -0700 (PDT)
Subject: Re: [PATCH v7 0/2] KVM: LAPIC: Implement Exitless Timer
To:     Wanpeng Li <wanpeng.li@hotmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1562376411-3533-1-git-send-email-wanpengli@tencent.com>
 <TY2PR02MB41600B4C6B9FF4A9F8CD957880F30@TY2PR02MB4160.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0e05bac0-af49-996a-c5fd-f6c61782ae4f@redhat.com>
Date:   Thu, 11 Jul 2019 16:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <TY2PR02MB41600B4C6B9FF4A9F8CD957880F30@TY2PR02MB4160.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19 15:50, Wanpeng Li wrote:
> kindly ping，

Sorry, I need more time to review this.  It's basically the only
remaining item for the 5.3 merge window, even though it won't be part of
the first pull request to Linus.

Paolo

>> Dedicated instances are currently disturbed by unnecessary jitter due 
>> to the emulated lapic timers fire on the same pCPUs which vCPUs resident.
>> There is no hardware virtual timer on Intel for guest like ARM. Both 
>> programming timer in guest and the emulated timer fires incur vmexits.
>> This patchset tries to avoid vmexit which is incurred by the emulated 
>> timer fires in dedicated instance scenario. 
>>
>> When nohz_full is enabled in dedicated instances scenario, the unpinned 
>> timer will be moved to the nearest busy housekeepers after commit
>> 9642d18eee2cd (nohz: Affine unpinned timers to housekeepers) and commit 
>> 444969223c8 ("sched/nohz: Fix affine unpinned timers mess"). However, 
>> KVM always makes lapic timer pinned to the pCPU which vCPU residents, the 
>> reason is explained by commit 61abdbe0 (kvm: x86: make lapic hrtimer 
>> pinned). Actually, these emulated timers can be offload to the housekeeping 
>> cpus since APICv is really common in recent years. The guest timer interrupt 
>> is injected by posted-interrupt which is delivered by housekeeping cpu 
>> once the emulated timer fires. 
>>
>> The host admin should fine tuned, e.g. dedicated instances scenario w/ 
>> nohz_full cover the pCPUs which vCPUs resident, several pCPUs surplus 
>> for busy housekeeping, disable mwait/hlt/pause vmexits to keep in non-root  
>> mode, ~3% redis performance benefit can be observed on Skylake server.
>>
>> w/o patchset:
>>
>>            VM-EXIT  Samples  Samples%  Time%   Min Time  Max Time   Avg time
>>
>> EXTERNAL_INTERRUPT    42916    49.43%   39.30%   0.47us   106.09us   0.71us ( +-   1.09% )
>>
>> w/ patchset:
>>
>>            VM-EXIT  Samples  Samples%  Time%   Min Time  Max Time         Avg time
>>
>> EXTERNAL_INTERRUPT    6871     9.29%     2.96%   0.44us    57.88us   0.72us ( +-   4.02% )
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>>
>> v6 -> v7:
>> * remove bool argument
>>
>> v5 -> v6:
>> * don't overwrites whatever the user specified
>> * introduce kvm_can_post_timer_interrupt and kvm_use_posted_timer_interrupt
>> * remove kvm_hlt_in_guest() condition
>> * squash all of 2/3/4 together
>>
>> v4 -> v5:
>> * update patch description in patch 1/4
>> * feed latest apic->lapic_timer.expired_tscdeadline to kvm_wait_lapic_expire()
>> * squash advance timer handling to patch 2/4
>>
>> v3 -> v4:
>> * drop the HRTIMER_MODE_ABS_PINNED, add kick after set pending timer
>> * don't posted inject already-expired timer
>>
>> v2 -> v3:
>> * disarming the vmx preemption timer when posted_interrupt_inject_timer_enabled()
>> * check kvm_hlt_in_guest instead
>>
>> v1 -> v2:
>> * check vcpu_halt_in_guest
>> * move module parameter from kvm-intel to kvm
>> * add housekeeping_enabled
>> * rename apic_timer_expired_pi to kvm_apic_inject_pending_timer_irqs
>>
>>
>> Wanpeng Li (2):
>>  KVM: LAPIC: Make lapic timer unpinned
>>  KVM: LAPIC: Inject timer interrupt via posted interrupt
>>
>> arch/x86/kvm/lapic.c            | 109 ++++++++++++++++++++++++++--------------
>> arch/x86/kvm/lapic.h            |   1 +
>> arch/x86/kvm/vmx/vmx.c          |   3 +-
>> arch/x86/kvm/x86.c              |  12 +++--
>> arch/x86/kvm/x86.h              |   2 +
>> include/linux/sched/isolation.h |   2 +
>> kernel/sched/isolation.c        |   6 +++
>> 7 files changed, 90 insertions(+), 45 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>

