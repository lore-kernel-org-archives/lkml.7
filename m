Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA2C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8420866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caln8y2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLTVBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:01:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57433 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbfLTVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xpJ+lIL1WdaXz/BCzKHdKAiz9jNb7HE3HwznYCminRs=;
        b=caln8y2I1rCfd+UhlG1bUqUk4AmAzzj1ed52Ijl5Wl6GPOlK2riM2ZlEKkG49/RpNVqeBg
        ucOzI8s+LN9Oi7a3wSw2vOZlcY0Kut4SSFTh6OdsXj46j4iHAJa+zluwN4n4JSlLbfIyEL
        Z5wVmJATmgEe4+XDOUUC3c2zfZzOH80=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-BhH4fT5oP26i7rE4qy47WQ-1; Fri, 20 Dec 2019 16:01:50 -0500
X-MC-Unique: BhH4fT5oP26i7rE4qy47WQ-1
Received: by mail-qk1-f198.google.com with SMTP id u10so6771021qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:01:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpJ+lIL1WdaXz/BCzKHdKAiz9jNb7HE3HwznYCminRs=;
        b=L271qHIRBZ6e4B6X1C7+2MQWxyM5nN0nm/KKDCDQ3VbnBmM3dBumAnOuDEqcK+Ik6q
         LW8vaJ7dGzzkQtME+8JAjBOzWmWwwQEODd3hM8H+OGCIfzd3ISW54/bxtWfWIrf1i+bT
         3wkefixY9Viaz0qMW+YA45+XqbYaQ8o0nktCym0rKnProv/f6JdlHY46YdoSnAk8BiBN
         KnwHVNK90pNtzRU8vYvy5w0p2JfOZAUYEPzP3clKjcI5PmHVSy/wNi52wfXAqG2S5N2a
         e7ihulzrau44L/Q7SUpfjvhxJxn+T5uqAWEd1yazDFVkuug7s3UxjBBfpsgfzTYgGNjU
         WRBQ==
X-Gm-Message-State: APjAAAXsnFZz6K55xkBtcdLLPqI59zGMOdgQ8xxEJXnnkJP9FUhKBJDx
        kf/68tLKis7usMpPbSlg/F4/j14fkCCJJlDW4i0dpKn03IaDiYLWO+PLOu3UpPNXUUBbFOQfvfm
        VNkzei1kkLVLLZwrL3/7dY5uP
X-Received: by 2002:a0c:b502:: with SMTP id d2mr14274248qve.110.1576875709425;
        Fri, 20 Dec 2019 13:01:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGmM74vFWoaMutRKZgJghXCmC8qtpjQHdkgeFSxk+2RHIAsRSW7UnwJFLzo8noHTV7kdaZaw==
X-Received: by 2002:a0c:b502:: with SMTP id d2mr14274206qve.110.1576875708992;
        Fri, 20 Dec 2019 13:01:48 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:48 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 00/17] KVM: Dirty ring interface
Date:   Fri, 20 Dec 2019 16:01:30 -0500
Message-Id: <20191220210147.49617-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
(based on 5.4.0)

This is v2 of the dirty ring series, and also the first non-RFC
version of it.  I didn't put a changelog from v1-rfc because I feel
like it would be easier to go into the patchset comparing to read that
lengthy and probably helpless changelog.  However I do like to do a
summary here on what has majorly changed, and also some conclusions on
the previous v1 discussions.

======================

* Per-vm ring is dropped

For x86 (which is still the major focus for now), we found that kvmgt
is probably the only one that still writes to the guest without a vcpu
context.  It would be a complete pity if we keep the per-vm ring only
for kvmgt (who shouldn't write directly to guest via kvm api after
all...), so remove it.  Work should be ongoing in parallel to refactor
kvmgt to not use kvm apis like kvm_write_guest().

However I don't want to break kvmgt before it's fixed.  So this series
uses an interim way to solve this by fallback no-vcpu-context writes
to vcpu0 if there is.  So we will keep the interface clean (per-vcpu
only), while we don't break the code base.  After kvmgt is fixed, we
can probably even drop this special fallback and kvm->dirty_ring_lock.

* Waitqueue is still kept (for now)

We did plan to drop the waitqueue, however again if with kvmgt we
still have chance to ful-fill a ring (and I feel like it'll definitely
happen if we migrate a kvmgt guest).  This series will only trigger
the waitqueue mechanism if it's the special case (no-vcpu-context) and
actually it naturally avoids another mmu lock deadlock issue I've
encountered, which is good.

For vcpu context writes, now the series is even more strict that we'll
directly fail the KVM_RUN if the dirty ring is soft full, until the
userspace collects the dirty rings first.  That'll guarantee the ring
will never be full.  With that, I dropped KVM_REQ_DIRTY_RING_FULL
together because then it's not needed.

Potentially this could still also be used by ARM when there're code
paths that dump the ARM device information to the guests
(e.g. KVM_DEV_ARM_ITS_SAVE_TABLES).  We'll see.  No matter what, even
if the code is there, x86 (as long as without kvmgt) should never
trigger waitqueue.

Although the waitqueue is kept, I dropped the complete waitqueue test,
simply because now I can never trigger it without kvmgt...

* Why not virtio?

There's already some discussion during v1 patchset on whether it's
good to use virtio for the data path of delivering dirty pages [1].
I'd confess the only thing that we might consider to use is the vring
layout (because virtqueue is tightly bound to devices, while we don't
have a device contet here), however it's a pity that even we only use
the most low-level vring api it'll be at least iov based which is
already an overkill for dirty ring (which is literally an array of
addresses).  So I just kept things easy.

======================

About the patchset:

Patch 1-5:    Mostly cleanups
Patch 6,7:    Prepare for the dirty ring interface
Patch 8-10:   Dirty ring implementation (majorly patch 8)
Patch 11-17:  Test cases update

Please have a look, thanks.

[1] V1 is here: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com

Paolo Bonzini (1):
  KVM: Move running VCPU from ARM to common code

Peter Xu (16):
  KVM: Remove kvm_read_guest_atomic()
  KVM: X86: Change parameter for fast_page_fault tracepoint
  KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
  KVM: Cache as_id in kvm_memory_slot
  KVM: Add build-time error check on kvm_run size
  KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
  KVM: X86: Implement ring-based dirty memory tracking
  KVM: Make dirty ring exclusive to dirty bitmap log
  KVM: Don't allocate dirty bitmap if dirty ring is enabled
  KVM: selftests: Always clear dirty bitmap after iteration
  KVM: selftests: Sync uapi/linux/kvm.h to tools/
  KVM: selftests: Use a single binary for dirty/clear log test
  KVM: selftests: Introduce after_vcpu_run hook for dirty log test
  KVM: selftests: Add dirty ring buffer test
  KVM: selftests: Let dirty_log_test async for dirty ring test
  KVM: selftests: Add "-c" parameter to dirty log test

 Documentation/virt/kvm/api.txt                |  96 ++++
 arch/arm/include/asm/kvm_host.h               |   2 -
 arch/arm64/include/asm/kvm_host.h             |   2 -
 arch/x86/include/asm/kvm_host.h               |   3 +
 arch/x86/include/uapi/asm/kvm.h               |   1 +
 arch/x86/kvm/Makefile                         |   3 +-
 arch/x86/kvm/mmu.c                            |   6 +
 arch/x86/kvm/mmutrace.h                       |   9 +-
 arch/x86/kvm/vmx/vmx.c                        |  25 +-
 arch/x86/kvm/x86.c                            |   9 +
 include/linux/kvm_dirty_ring.h                |  57 +++
 include/linux/kvm_host.h                      |  44 +-
 include/trace/events/kvm.h                    |  78 ++++
 include/uapi/linux/kvm.h                      |  31 ++
 tools/include/uapi/linux/kvm.h                |  36 ++
 tools/testing/selftests/kvm/Makefile          |   2 -
 .../selftests/kvm/clear_dirty_log_test.c      |   2 -
 tools/testing/selftests/kvm/dirty_log_test.c  | 420 ++++++++++++++++--
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  64 +++
 .../selftests/kvm/lib/kvm_util_internal.h     |   3 +
 virt/kvm/arm/arch_timer.c                     |   2 +-
 virt/kvm/arm/arm.c                            |  29 --
 virt/kvm/arm/perf.c                           |   6 +-
 virt/kvm/arm/vgic/vgic-mmio.c                 |  15 +-
 virt/kvm/dirty_ring.c                         | 201 +++++++++
 virt/kvm/kvm_main.c                           | 269 +++++++++--
 27 files changed, 1274 insertions(+), 145 deletions(-)
 create mode 100644 include/linux/kvm_dirty_ring.h
 delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
 create mode 100644 virt/kvm/dirty_ring.c

-- 
2.24.1

