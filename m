Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C2921906
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfJVN72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:59:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732006AbfJVN72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:59:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38E96BB9CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:59:27 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k10so184193wrl.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 06:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dlx0qR6qGoizUuI3jCS47jEOZVwYOv8dJ62/TjyH9Xs=;
        b=knprj6fm3/ENFjhN/RGtNe269KuEbdOZ8LS/lQuSo5KK2f03s8GFzhZu6CB4uozzLa
         Q/iZim3adJ7vfvmuXCKQ9zha3kGQHEVa0tC1gL+xPcR/FSTLccx6m3mm0cWf6Qqk4hGn
         AHrVmrc+QyL1MPH3/qHd1YNKk6hZNuuRiNyTwyLrPZu7nAk8MnqQRRZxgXeVngJr9ziU
         v5EEOkQwbVrdtOBNC/zFDtHm/KHqUFkBe92jzm9uTofCRg9NJdh3K0Z5uQ54o3u6/fr/
         66K7XncwQWYtwo1JZCdDvM36Ztf3E0AR1vcDB5muaZmLO5QWe961+syyJpQ2VAFjSd2l
         2BxA==
X-Gm-Message-State: APjAAAWqOzlItSlM9Fz0WPhpetSX8G1Td/vu9NYRop63A6tKDg21BR9u
        GPExtxhovnh8PsfCrAtgwxV/o5uNLnSNYaYIDN3vgQo9jMGiEZUkr9yoe5NY26wNd1zOJvOK2pU
        LjsjVoCsSVHnqI2uC/9JmVimr
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr3690729wrf.221.1571752765668;
        Tue, 22 Oct 2019 06:59:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzdoYw58nkYxoG/VDS1/LYhdqcebVxQ/IRP7wL/K4uxfwmYmVxn6Yd5KXoTPuPOxmY6ROAMw==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr3690694wrf.221.1571752765319;
        Tue, 22 Oct 2019 06:59:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id l14sm2833445wrr.37.2019.10.22.06.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 06:59:24 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] KVM: Dynamically size memslot arrays
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20191022003537.13013-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <15624ac3-6a43-29c8-8d07-23779454f9e6@redhat.com>
Date:   Tue, 22 Oct 2019 15:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022003537.13013-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 02:35, Sean Christopherson wrote:
> The end goal of this series is to dynamically size the memslot array so
> that KVM allocates memory based on the number of memslots in use, as
> opposed to unconditionally allocating memory for the maximum number of
> memslots.  On x86, each memslot consumes 88 bytes, and so with 2 address
> spaces of 512 memslots, each VM consumes ~90k bytes for the memslots.
> E.g. given a VM that uses a total of 30 memslots, dynamic sizing reduces
> the memory footprint from 90k to ~2.6k bytes.
> 
> The changes required to support dynamic sizing are relatively small,
> e.g. are essentially contained in patches 12/13 and 13/13.  Patches 1-11
> clean up the memslot code, which has gotten quite crusy, especially
> __kvm_set_memory_region().  The clean up is likely not strictly necessary
> to switch to dynamic sizing, but I didn't have a remotely reasonable
> level of confidence in the correctness of the dynamic sizing without first
> doing the clean up.
> 
> Testing, especially non-x86 platforms, would be greatly appreciated.  The
> non-x86 changes are for all intents and purposes untested, e.g. I compile
> tested pieces of the code by copying them into x86, but that's it.  In
> theory, the vast majority of the functional changes are arch agnostic, in
> theory...
> 
> v2:
>   - Split "Drop kvm_arch_create_memslot()" into three patches to move
>     minor functional changes to standalone patches [Janosch].
>   - Rebase to latest kvm/queue (f0574a1cea5b, "KVM: x86: fix ...")
>   - Collect an Acked-by and a Reviewed-by
> 
> Sean Christopherson (15):
>   KVM: Reinstall old memslots if arch preparation fails
>   KVM: Don't free new memslot if allocation of said memslot fails
>   KVM: PPC: Move memslot memory allocation into prepare_memory_region()
>   KVM: x86: Allocate memslot resources during prepare_memory_region()
>   KVM: Drop kvm_arch_create_memslot()
>   KVM: Explicitly free allocated-but-unused dirty bitmap
>   KVM: Refactor error handling for setting memory region
>   KVM: Move setting of memslot into helper routine
>   KVM: Move memslot deletion to helper function
>   KVM: Simplify kvm_free_memslot() and all its descendents
>   KVM: Clean up local variable usage in __kvm_set_memory_region()
>   KVM: Provide common implementation for generic dirty log functions
>   KVM: Ensure validity of memslot with respect to kvm_get_dirty_log()
>   KVM: Terminate memslot walks via used_slots
>   KVM: Dynamically size memslot array based on number of used slots
> 
>  arch/mips/include/asm/kvm_host.h      |   2 +-
>  arch/mips/kvm/mips.c                  |  68 +---
>  arch/powerpc/include/asm/kvm_ppc.h    |  14 +-
>  arch/powerpc/kvm/book3s.c             |  22 +-
>  arch/powerpc/kvm/book3s_hv.c          |  36 +-
>  arch/powerpc/kvm/book3s_pr.c          |  20 +-
>  arch/powerpc/kvm/booke.c              |  17 +-
>  arch/powerpc/kvm/powerpc.c            |  13 +-
>  arch/s390/include/asm/kvm_host.h      |   2 +-
>  arch/s390/kvm/kvm-s390.c              |  21 +-
>  arch/x86/include/asm/kvm_page_track.h |   3 +-
>  arch/x86/kvm/page_track.c             |  15 +-
>  arch/x86/kvm/x86.c                    | 100 ++---
>  include/linux/kvm_host.h              |  48 +--
>  virt/kvm/arm/arm.c                    |  47 +--
>  virt/kvm/arm/mmu.c                    |  18 +-
>  virt/kvm/kvm_main.c                   | 546 ++++++++++++++++----------
>  17 files changed, 467 insertions(+), 525 deletions(-)
> 

Christian, Marc, Paul, can you help testing patches 1-13?

Thanks,
