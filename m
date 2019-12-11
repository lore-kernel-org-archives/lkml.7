Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2E4214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNHkSRRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfLKOQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:16:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727554AbfLKOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576073801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBRqCf/oDTPsn7qeKEviFrRNkV0xOjlRJF+4d5zRUBE=;
        b=HNHkSRRHGqLY0PnWRtTfRGKa7fc9eNjUFKcza/bFtkNswAKuThwQvUjOYCJc5FYSiO2A8J
        sUolKthz9/aL+KUI599hzUBKEKN0zPpQvbInj/5Ufcnraj9ODrkoKoYoWWF8GDZdWgmhgz
        a1S1VtIAQwAR0sC6wua0YTeQH4V9aj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-na345tNkMk6t88VIVkiDhg-1; Wed, 11 Dec 2019 09:16:36 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so647813wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBRqCf/oDTPsn7qeKEviFrRNkV0xOjlRJF+4d5zRUBE=;
        b=g5R/eG6KAU01DkQJoJHAe5/tt61aF4svBquGehYtUueJdAMwQgb9kTXP16f8tLMW8o
         Cz+8gqKIlgyPdYo7Rl6rBmPDyLyMDE7EcmIJ7cFWYuodUCg7apbmmLj4awZaK8IbmR83
         M9eg3CGKQh4zpS7YJ9EpT8dHGrcyZVxBCxj620vYvadNgRjqTkvkG5pJjPtpjimBlHvv
         F6xTjwIqtQWAfrDK2/EKH/7KcFjmpHNtoTi3FonIcMPqSFLkL0djzOldsDw1ik90T2aA
         6iAHIS2mTuPTRe6FiVCf1Rw/ayfLurUBUfBdC6k1Rlhu4uqluIIqZLQFdkVwN3jEPPb9
         JB+g==
X-Gm-Message-State: APjAAAUdZpuM+1SnUI0/1QafqpBgur9vXFgA/l9lPALMw+7aoy1FYVUc
        xh14W0X+Eq7qPsWFzQ0ctOtxdA0pNbRRRjykOrHS7MWAvF+jICAMiVlFk56k4l8G4nPVK8tinxi
        fTmcno7nUBsM5SQw9kDKAag+/
X-Received: by 2002:adf:9427:: with SMTP id 36mr36814wrq.166.1576073795466;
        Wed, 11 Dec 2019 06:16:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqy944UtRNsFmM7MYcYlNfW9+RgHGwm30xFL7Gg23d9r4zM9+0q2ipoxOHk+rpXYyC5JakjlVA==
X-Received: by 2002:adf:9427:: with SMTP id 36mr36785wrq.166.1576073795110;
        Wed, 11 Dec 2019 06:16:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id g21sm2920337wmh.17.2019.12.11.06.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:16:34 -0800 (PST)
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
To:     Christophe de Dinechin <dinechin@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
 <m1r21bgest.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f386bca9-b967-2e76-c580-465463843aa4@redhat.com>
Date:   Wed, 11 Dec 2019 15:16:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <m1r21bgest.fsf@redhat.com>
Content-Language: en-US
X-MC-Unique: na345tNkMk6t88VIVkiDhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 14:41, Christophe de Dinechin wrote:
> 
> Peter Xu writes:
> 
>> Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
>>
>> Overview
>> ============
>>
>> This is a continued work from Lei Cao <lei.cao@stratus.com> and Paolo
>> on the KVM dirty ring interface.  To make it simple, I'll still start
>> with version 1 as RFC.
>>
>> The new dirty ring interface is another way to collect dirty pages for
>> the virtual machine, but it is different from the existing dirty
>> logging interface in a few ways, majorly:
>>
>>   - Data format: The dirty data was in a ring format rather than a
>>     bitmap format, so the size of data to sync for dirty logging does
>>     not depend on the size of guest memory any more, but speed of
>>     dirtying.  Also, the dirty ring is per-vcpu (currently plus
>>     another per-vm ring, so total ring number is N+1), while the dirty
>>     bitmap is per-vm.
> 
> I like Sean's suggestion to fetch rings when dirtying. That could reduce
> the number of dirty rings to examine.

What do you mean by "fetch rings"?

> Also, as is, this means that the same gfn may be present in multiple
> rings, right?

I think the actual marking of a page as dirty is protected by a spinlock
but I will defer to Peter on this.

Paolo

>>
>>   - Data copy: The sync of dirty pages does not need data copy any more,
>>     but instead the ring is shared between the userspace and kernel by
>>     page sharings (mmap() on either the vm fd or vcpu fd)
>>
>>   - Interface: Instead of using the old KVM_GET_DIRTY_LOG,
>>     KVM_CLEAR_DIRTY_LOG interfaces, the new ring uses a new interface
>>     called KVM_RESET_DIRTY_RINGS when we want to reset the collected
>>     dirty pages to protected mode again (works like
>>     KVM_CLEAR_DIRTY_LOG, but ring based)
>>
>> And more.
>>
>> I would appreciate if the reviewers can start with patch "KVM:
>> Implement ring-based dirty memory tracking", especially the document
>> update part for the big picture.  Then I'll avoid copying into most of
>> them into cover letter again.
>>
>> I marked this series as RFC because I'm at least uncertain on this
>> change of vcpu_enter_guest():
>>
>>         if (kvm_check_request(KVM_REQ_DIRTY_RING_FULL, vcpu)) {
>>                 vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>>                 /*
>>                         * If this is requested, it means that we've
>>                         * marked the dirty bit in the dirty ring BUT
>>                         * we've not written the date.  Do it now.
> 
> not written the "data" ?
> 
>>                         */
>>                 r = kvm_emulate_instruction(vcpu, 0);
>>                 r = r >= 0 ? 0 : r;
>>                 goto out;
>>         }
>>
>> I did a kvm_emulate_instruction() when dirty ring reaches softlimit
>> and want to exit to userspace, however I'm not really sure whether
>> there could have any side effect.  I'd appreciate any comment of
>> above, or anything else.
>>
>> Tests
>> ===========
>>
>> I wanted to continue work on the QEMU part, but after I noticed that
>> the interface might still prone to change, I posted this series first.
>> However to make sure it's at least working, I've provided unit tests
>> together with the series.  The unit tests should be able to test the
>> series in at least three major paths:
>>
>>   (1) ./dirty_log_test -M dirty-ring
>>
>>       This tests async ring operations: this should be the major work
>>       mode for the dirty ring interface, say, when the kernel is
>>       queuing more data, the userspace is collecting too.  Ring can
>>       hardly reaches full when working like this, because in most
>>       cases the collection could be fast.
>>
>>   (2) ./dirty_log_test -M dirty-ring -c 1024
>>
>>       This set the ring size to be very small so that ring soft-full
>>       always triggers (soft-full is a soft limit of the ring state,
>>       when the dirty ring reaches the soft limit it'll do a userspace
>>       exit and let the userspace to collect the data).
>>
>>   (3) ./dirty_log_test -M dirty-ring-wait-queue
>>
>>       This sololy test the extreme case where ring is full.  When the
>>       ring is completely full, the thread (no matter vcpu or not) will
>>       be put onto a per-vm waitqueue, and KVM_RESET_DIRTY_RINGS will
>>       wake the threads up (assuming until which the ring will not be
>>       full any more).
> 
> Am I correct assuming that guest memory can be dirtied by DMA operations?
> Should
> 
> Not being that familiar with the current implementation of dirty page
> tracking, I wonder who marks the pages dirty in that case, and when?
> If the VM ring is used for I/O threads, isn't it possible that a large
> DMA could dirty a sufficiently large number of GFNs to overflow the
> associated ring? Does this case need a separate way to queue the
> dirtying I/O thread?
> 
>>
>> Thanks,
>>
>> Cao, Lei (2):
>>   KVM: Add kvm/vcpu argument to mark_dirty_page_in_slot
>>   KVM: X86: Implement ring-based dirty memory tracking
>>
>> Paolo Bonzini (1):
>>   KVM: Move running VCPU from ARM to common code
>>
>> Peter Xu (12):
>>   KVM: Add build-time error check on kvm_run size
>>   KVM: Implement ring-based dirty memory tracking
>>   KVM: Make dirty ring exclusive to dirty bitmap log
>>   KVM: Introduce dirty ring wait queue
>>   KVM: selftests: Always clear dirty bitmap after iteration
>>   KVM: selftests: Sync uapi/linux/kvm.h to tools/
>>   KVM: selftests: Use a single binary for dirty/clear log test
>>   KVM: selftests: Introduce after_vcpu_run hook for dirty log test
>>   KVM: selftests: Add dirty ring buffer test
>>   KVM: selftests: Let dirty_log_test async for dirty ring test
>>   KVM: selftests: Add "-c" parameter to dirty log test
>>   KVM: selftests: Test dirty ring waitqueue
>>
>>  Documentation/virt/kvm/api.txt                | 116 +++++
>>  arch/arm/include/asm/kvm_host.h               |   2 -
>>  arch/arm64/include/asm/kvm_host.h             |   2 -
>>  arch/x86/include/asm/kvm_host.h               |   5 +
>>  arch/x86/include/uapi/asm/kvm.h               |   1 +
>>  arch/x86/kvm/Makefile                         |   3 +-
>>  arch/x86/kvm/mmu/mmu.c                        |   6 +
>>  arch/x86/kvm/vmx/vmx.c                        |   7 +
>>  arch/x86/kvm/x86.c                            |  12 +
>>  include/linux/kvm_dirty_ring.h                |  67 +++
>>  include/linux/kvm_host.h                      |  37 ++
>>  include/linux/kvm_types.h                     |   1 +
>>  include/uapi/linux/kvm.h                      |  36 ++
>>  tools/include/uapi/linux/kvm.h                |  47 ++
>>  tools/testing/selftests/kvm/Makefile          |   2 -
>>  .../selftests/kvm/clear_dirty_log_test.c      |   2 -
>>  tools/testing/selftests/kvm/dirty_log_test.c  | 452 ++++++++++++++++--
>>  .../testing/selftests/kvm/include/kvm_util.h  |   6 +
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 103 ++++
>>  .../selftests/kvm/lib/kvm_util_internal.h     |   5 +
>>  virt/kvm/arm/arm.c                            |  29 --
>>  virt/kvm/arm/perf.c                           |   6 +-
>>  virt/kvm/arm/vgic/vgic-mmio.c                 |  15 +-
>>  virt/kvm/dirty_ring.c                         | 156 ++++++
>>  virt/kvm/kvm_main.c                           | 315 +++++++++++-
>>  25 files changed, 1329 insertions(+), 104 deletions(-)
>>  create mode 100644 include/linux/kvm_dirty_ring.h
>>  delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
>>  create mode 100644 virt/kvm/dirty_ring.c
> 
> 
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)
> 

