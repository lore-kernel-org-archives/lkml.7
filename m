Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1920F20833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMvA0jVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfK3IaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:30:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725835AbfK3IaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575102602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlJL9JS9u1P7IJHdf08bdc2Fu7AL+CnNYtBcqg0EBPA=;
        b=PMvA0jVHSCoUzEZH2p+HKzl64FcxGbjVpjShblW1Cf2d8XEe69FKcQjG7eo1QBkC20OETs
        whLIRzu55/R4GKELgnpqVUGzV++hhq/RmvSHMkcNOVsFTcMqQS080X5CpJCjEDPXWkpe/4
        SqjDzSzOJNl4pKeNWG+xgkhOPdv/kCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-g0Pux07-MJG7YRZseOAWVg-1; Sat, 30 Nov 2019 03:29:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so16801089wrm.18
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 00:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlJL9JS9u1P7IJHdf08bdc2Fu7AL+CnNYtBcqg0EBPA=;
        b=dRkdcoZGRaj9MfLam3yljLlUzQpd54ppBaButsRo6X8SSBg6Wey1nTmRT89TxOaSZt
         2IzQHxizp1BMFZhh9gGoxSLAEaRnVw/baPO7IWUHVCoY6/kdHPVahYsSFY1lZb+kTq9V
         Rn9hkyOq4q5ZGKpzdQ1LXtI2AFG6Pwye2gw/+4atuhH3czeuc/sqgg/2tYTuBw9L5r51
         dpviwtr0nkd9tmGpVUSbwXyKO+w1Be14D6ppp1pkYbDdtX/ayyL1yeFtTjdceeOq72OB
         ieAQ+GwI4Rz5PYvLCVNpLMkvl4/XZknNAYwqlKH1niuL55aRgkV3P/l3ECwtnjOoLJwW
         vN/Q==
X-Gm-Message-State: APjAAAWwZCetsQEiP0QjxFSehBFdwVKbzwpcXpyAqZ51bpUkY3M5mW0b
        TKE0cGiKFZ3ZrjswebnzjvjjL+o9qVb1NihJM7datzLS6wp61BPlhWdPmmWBt6mKOqagnOKzGlY
        auWLT78O8iRm1Bu6bEH57++IY
X-Received: by 2002:adf:ab41:: with SMTP id r1mr36545529wrc.281.1575102596001;
        Sat, 30 Nov 2019 00:29:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxThWgJh9bHEqvFyHZIVphvxDcpprnRnUuClhctgE3kKRX2v7ucmBEsQMvn79mw7mXBcGtTeQ==
X-Received: by 2002:adf:ab41:: with SMTP id r1mr36545512wrc.281.1575102595726;
        Sat, 30 Nov 2019 00:29:55 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f12sm16192993wmf.28.2019.11.30.00.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 00:29:55 -0800 (PST)
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191129213505.18472-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8f28d8c-2486-2d66-04fd-a2674b598cfd@redhat.com>
Date:   Sat, 30 Nov 2019 09:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129213505.18472-1-peterx@redhat.com>
Content-Language: en-US
X-MC-Unique: g0Pux07-MJG7YRZseOAWVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

thanks for the RFC!  Just a couple comments before I look at the series
(for which I don't expect many surprises).

On 29/11/19 22:34, Peter Xu wrote:
> I marked this series as RFC because I'm at least uncertain on this
> change of vcpu_enter_guest():
> 
>         if (kvm_check_request(KVM_REQ_DIRTY_RING_FULL, vcpu)) {
>                 vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>                 /*
>                         * If this is requested, it means that we've
>                         * marked the dirty bit in the dirty ring BUT
>                         * we've not written the date.  Do it now.
>                         */
>                 r = kvm_emulate_instruction(vcpu, 0);
>                 r = r >= 0 ? 0 : r;
>                 goto out;
>         }

This is not needed, it will just be a false negative (dirty page that
actually isn't dirty).  The dirty bit will be cleared when userspace
resets the ring buffer; then the instruction will be executed again and
mark the page dirty again.  Since ring full is not a common condition,
it's not a big deal.

> I did a kvm_emulate_instruction() when dirty ring reaches softlimit
> and want to exit to userspace, however I'm not really sure whether
> there could have any side effect.  I'd appreciate any comment of
> above, or anything else.
> 
> Tests
> ===========
> 
> I wanted to continue work on the QEMU part, but after I noticed that
> the interface might still prone to change, I posted this series first.
> However to make sure it's at least working, I've provided unit tests
> together with the series.  The unit tests should be able to test the
> series in at least three major paths:
> 
>   (1) ./dirty_log_test -M dirty-ring
> 
>       This tests async ring operations: this should be the major work
>       mode for the dirty ring interface, say, when the kernel is
>       queuing more data, the userspace is collecting too.  Ring can
>       hardly reaches full when working like this, because in most
>       cases the collection could be fast.
> 
>   (2) ./dirty_log_test -M dirty-ring -c 1024
> 
>       This set the ring size to be very small so that ring soft-full
>       always triggers (soft-full is a soft limit of the ring state,
>       when the dirty ring reaches the soft limit it'll do a userspace
>       exit and let the userspace to collect the data).
> 
>   (3) ./dirty_log_test -M dirty-ring-wait-queue
> 
>       This sololy test the extreme case where ring is full.  When the
>       ring is completely full, the thread (no matter vcpu or not) will
>       be put onto a per-vm waitqueue, and KVM_RESET_DIRTY_RINGS will
>       wake the threads up (assuming until which the ring will not be
>       full any more).

One question about this testcase: why does the task get into
uninterruptible wait?

Paolo

> 
> Thanks,
> 
> Cao, Lei (2):
>   KVM: Add kvm/vcpu argument to mark_dirty_page_in_slot
>   KVM: X86: Implement ring-based dirty memory tracking
> 
> Paolo Bonzini (1):
>   KVM: Move running VCPU from ARM to common code
> 
> Peter Xu (12):
>   KVM: Add build-time error check on kvm_run size
>   KVM: Implement ring-based dirty memory tracking
>   KVM: Make dirty ring exclusive to dirty bitmap log
>   KVM: Introduce dirty ring wait queue
>   KVM: selftests: Always clear dirty bitmap after iteration
>   KVM: selftests: Sync uapi/linux/kvm.h to tools/
>   KVM: selftests: Use a single binary for dirty/clear log test
>   KVM: selftests: Introduce after_vcpu_run hook for dirty log test
>   KVM: selftests: Add dirty ring buffer test
>   KVM: selftests: Let dirty_log_test async for dirty ring test
>   KVM: selftests: Add "-c" parameter to dirty log test
>   KVM: selftests: Test dirty ring waitqueue
> 
>  Documentation/virt/kvm/api.txt                | 116 +++++
>  arch/arm/include/asm/kvm_host.h               |   2 -
>  arch/arm64/include/asm/kvm_host.h             |   2 -
>  arch/x86/include/asm/kvm_host.h               |   5 +
>  arch/x86/include/uapi/asm/kvm.h               |   1 +
>  arch/x86/kvm/Makefile                         |   3 +-
>  arch/x86/kvm/mmu/mmu.c                        |   6 +
>  arch/x86/kvm/vmx/vmx.c                        |   7 +
>  arch/x86/kvm/x86.c                            |  12 +
>  include/linux/kvm_dirty_ring.h                |  67 +++
>  include/linux/kvm_host.h                      |  37 ++
>  include/linux/kvm_types.h                     |   1 +
>  include/uapi/linux/kvm.h                      |  36 ++
>  tools/include/uapi/linux/kvm.h                |  47 ++
>  tools/testing/selftests/kvm/Makefile          |   2 -
>  .../selftests/kvm/clear_dirty_log_test.c      |   2 -
>  tools/testing/selftests/kvm/dirty_log_test.c  | 452 ++++++++++++++++--
>  .../testing/selftests/kvm/include/kvm_util.h  |   6 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 103 ++++
>  .../selftests/kvm/lib/kvm_util_internal.h     |   5 +
>  virt/kvm/arm/arm.c                            |  29 --
>  virt/kvm/arm/perf.c                           |   6 +-
>  virt/kvm/arm/vgic/vgic-mmio.c                 |  15 +-
>  virt/kvm/dirty_ring.c                         | 156 ++++++
>  virt/kvm/kvm_main.c                           | 315 +++++++++++-
>  25 files changed, 1329 insertions(+), 104 deletions(-)
>  create mode 100644 include/linux/kvm_dirty_ring.h
>  delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
>  create mode 100644 virt/kvm/dirty_ring.c
> 

