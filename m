Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E7FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783DA206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9+tY3YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbgAIQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:00:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42330 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731190AbgAIQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZYNwTh4Tu4Bos8ZZOeTkObg6tVBZsVtEef3Z+yMgUhs=;
        b=T9+tY3YQ10oFV62HQb3BxRwYVPsc96pqAqm5i4J8lVzPdZoG2NfUkveA3iNeG4PbRzK3Nn
        Nw/fV6zNfxpWLojYHueHrFdubo0PKeELBh3UyjYDkjl57nlDr5vXjFXbH96pphges1E3KY
        CgDrczPrlV2kLi/xYWCY+dNZtpavE40=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-rlM7CwRyNt6q-QZ_gSGaVQ-1; Thu, 09 Jan 2020 10:59:57 -0500
X-MC-Unique: rlM7CwRyNt6q-QZ_gSGaVQ-1
Received: by mail-qk1-f200.google.com with SMTP id 12so4398015qkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZYNwTh4Tu4Bos8ZZOeTkObg6tVBZsVtEef3Z+yMgUhs=;
        b=S59COrpcWsoRsFUq6q7+APwhAhchg7TES8/gLyr4IBEPvTu5rbLg2KpCtIdZl8pbRU
         vbOuGgCp0kufJdmcCuLCKbNX1Zr784+rxbUAs4X7oCT1yAOjmOGj8MGzNni8domcO7Ls
         w+JfZvo0jV2z5seY3uwaGm3OBejcpd2GUHqo3tyAXAbTmjrs+fAa8GF1QAcicu0zlmLW
         ZmYWl+hcXCWa6oe3hEpWaLbo7B9LIJI1t65w+POOIyxlqgTWxtSxgIlrWB5Tj96QdTzF
         /96N8LmLN6Ycefwubq3I8aKEyq3pOc3hcq7afSJJc1TzkheOwG/tLoZ2mwaTei2Wy740
         VNPQ==
X-Gm-Message-State: APjAAAV2THPlGsHFrlQHgSTH4+rFtLpZl/FGkuEh7nAMyBS2qSKEwa09
        NG4V045xqNKEIlmLsKakl8zicI0CaZpjmvyk1DAYHAcnHYK2SgRvqifolT3mSrmAMPmoPcT6DXo
        m+XgA188F3V0Mwky9NYJcJTs9
X-Received: by 2002:aed:2e02:: with SMTP id j2mr8369191qtd.370.1578585597212;
        Thu, 09 Jan 2020 07:59:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3MHsanpxEwVWBpdyHyNxRs8eWkHDAm95FtF3MPWMx3s40lIzLfEwwE1x1R2+LvWrK9fIE9Q==
X-Received: by 2002:aed:2e02:: with SMTP id j2mr8369170qtd.370.1578585596953;
        Thu, 09 Jan 2020 07:59:56 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id t3sm3602189qtc.8.2020.01.09.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:59:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:59:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109105443-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:57:08AM -0500, Peter Xu wrote:
> Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> (based on kvm/queue)
> 
> Please refer to either the previous cover letters, or documentation
> update in patch 12 for the big picture.

I would rather you pasted it here. There's no way to respond otherwise.

For something that's presumably an optimization, isn't there
some kind of testing that can be done to show the benefits?
What kind of gain was observed?

I know it's mostly relevant for huge VMs, but OTOH these
probably use huge pages.




>  Previous posts:
> 
> V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
> V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
> 
> The major change in V3 is that we dropped the whole waitqueue and the
> global lock. With that, we have clean per-vcpu ring and no default
> ring any more.  The two kvmgt refactoring patches were also included
> to show the dependency of the works.
> 
> Patchset layout:
> 
> Patch 1-2:         Picked up from kvmgt refactoring
> Patch 3-6:         Small patches that are not directly related,
>                    (So can be acked/nacked/picked as standalone)
> Patch 7-11:        Prepares for the dirty ring interface
> Patch 12:          Major implementation
> Patch 13-14:       Quick follow-ups for patch 8
> Patch 15-21:       Test cases
> 
> V3 changelog:
> 
> - fail userspace writable maps on dirty ring ranges [Jason]
> - commit message fixups [Paolo]
> - change __x86_set_memory_region to return hva [Paolo]
> - cacheline align for indices [Paolo, Jason]
> - drop waitqueue, global lock, etc., include kvmgt rework patchset
> - take lock for __x86_set_memory_region() (otherwise it triggers a
>   lockdep in latest kvm/queue) [Paolo]
> - check KVM_DIRTY_LOG_PAGE_OFFSET in kvm_vm_ioctl_enable_dirty_log_ring
> - one more patch to drop x86_set_memory_region [Paolo]
> - one more patch to remove extra srcu usage in init_rmode_identity_map()
> - add some r-bs for Paolo
> 
> Please review, thanks.
> 
> Paolo Bonzini (1):
>   KVM: Move running VCPU from ARM to common code
> 
> Peter Xu (18):
>   KVM: Remove kvm_read_guest_atomic()
>   KVM: Add build-time error check on kvm_run size
>   KVM: X86: Change parameter for fast_page_fault tracepoint
>   KVM: X86: Don't take srcu lock in init_rmode_identity_map()
>   KVM: Cache as_id in kvm_memory_slot
>   KVM: X86: Drop x86_set_memory_region()
>   KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
>   KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
>   KVM: X86: Implement ring-based dirty memory tracking
>   KVM: Make dirty ring exclusive to dirty bitmap log
>   KVM: Don't allocate dirty bitmap if dirty ring is enabled
>   KVM: selftests: Always clear dirty bitmap after iteration
>   KVM: selftests: Sync uapi/linux/kvm.h to tools/
>   KVM: selftests: Use a single binary for dirty/clear log test
>   KVM: selftests: Introduce after_vcpu_run hook for dirty log test
>   KVM: selftests: Add dirty ring buffer test
>   KVM: selftests: Let dirty_log_test async for dirty ring test
>   KVM: selftests: Add "-c" parameter to dirty log test
> 
> Yan Zhao (2):
>   vfio: introduce vfio_iova_rw to read/write a range of IOVAs
>   drm/i915/gvt: subsitute kvm_read/write_guest with vfio_iova_rw
> 
>  Documentation/virt/kvm/api.txt                |  96 ++++
>  arch/arm/include/asm/kvm_host.h               |   2 -
>  arch/arm64/include/asm/kvm_host.h             |   2 -
>  arch/x86/include/asm/kvm_host.h               |   7 +-
>  arch/x86/include/uapi/asm/kvm.h               |   1 +
>  arch/x86/kvm/Makefile                         |   3 +-
>  arch/x86/kvm/mmu/mmu.c                        |   6 +
>  arch/x86/kvm/mmutrace.h                       |   9 +-
>  arch/x86/kvm/svm.c                            |   3 +-
>  arch/x86/kvm/vmx/vmx.c                        |  86 ++--
>  arch/x86/kvm/x86.c                            |  43 +-
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  25 +-
>  drivers/vfio/vfio.c                           |  45 ++
>  drivers/vfio/vfio_iommu_type1.c               |  81 ++++
>  include/linux/kvm_dirty_ring.h                |  55 +++
>  include/linux/kvm_host.h                      |  37 +-
>  include/linux/vfio.h                          |   5 +
>  include/trace/events/kvm.h                    |  78 ++++
>  include/uapi/linux/kvm.h                      |  33 ++
>  tools/include/uapi/linux/kvm.h                |  38 ++
>  tools/testing/selftests/kvm/Makefile          |   2 -
>  .../selftests/kvm/clear_dirty_log_test.c      |   2 -
>  tools/testing/selftests/kvm/dirty_log_test.c  | 420 ++++++++++++++++--
>  .../testing/selftests/kvm/include/kvm_util.h  |   4 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  72 +++
>  .../selftests/kvm/lib/kvm_util_internal.h     |   3 +
>  virt/kvm/arm/arch_timer.c                     |   2 +-
>  virt/kvm/arm/arm.c                            |  29 --
>  virt/kvm/arm/perf.c                           |   6 +-
>  virt/kvm/arm/vgic/vgic-mmio.c                 |  15 +-
>  virt/kvm/dirty_ring.c                         | 162 +++++++
>  virt/kvm/kvm_main.c                           | 215 +++++++--
>  32 files changed, 1379 insertions(+), 208 deletions(-)
>  create mode 100644 include/linux/kvm_dirty_ring.h
>  delete mode 100644 tools/testing/selftests/kvm/clear_dirty_log_test.c
>  create mode 100644 virt/kvm/dirty_ring.c
> 
> -- 
> 2.24.1

