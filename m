Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4725FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D0D2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4tK2VOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKUKn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:43:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726957AbfKUKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574333003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJGFd6J2iR6SZmcHzMwTOOI6ea+BczDHgJljqbvt1+k=;
        b=E4tK2VOtcNJ5hmVy5lHACRIJ5MbY+kGwbL/6oQYNTTzK4DErqZibUKMq+4kjONGh/VJjbE
        8xiUKoHNiROAjJ35QbidLvSHVsXTA/FIlnj5eH277qH9/KnCmgqJpv29cbRUQcBSmDhr/7
        3m2befz6fesvuyYFCFeVkVg3AT/rLcU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-pa6KvRM-MOyaXVh9njgfiw-1; Thu, 21 Nov 2019 05:43:19 -0500
Received: by mail-wr1-f70.google.com with SMTP id l3so1807935wrx.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAw1/LVFY4c2d2aF4u+GAoU/WDuvpiCsAx8hSiSJ7t4=;
        b=CRrr8zHRntfCle9deioB3wAJWbOmNAY++Hm4Ly+tVlXuVHshUO8Usz05x2gsU8BuuI
         5+dGCKXqdzy3t9Tstvsms7SHaQLvUXYo6Jwzpce3N0reVP+mabRXt7NzhrQskxkc+U+F
         HQ4hyv6IDIbk+AHtwmrCw/ha4g3aJ9yA4Vr1Efe/+8jRxtt0Bv2TVyFJyiRbPdkxw9gt
         yNaAIGVR8pasI8HUDkYe/w92pAe7YhzXRSiAp7TxJTGwAQ6h8Mnv5VnEgX1VIN+HuU8L
         YhRKgsDuVLDuj6c+d2OeG4DLAnLyUvPI/H3eRItd8lEaFR0qdUwU51CYRNPS/hn5NvfZ
         sQUg==
X-Gm-Message-State: APjAAAXfD9GbKaqs/cWl6Tl6Wwlnxmx+X/CjMCP1sE3sB+ov4NKiapUU
        hLDPAOFYxTjO3wiPwEvWFgA0OP+1KvpoOCEK6ZmiPxrhiTxTTCnyVHNTnURnAt8OVTAchW1Z59w
        WczB1dfMEiQS5lIpvS3fgcw/X
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr8614874wmk.37.1574332998300;
        Thu, 21 Nov 2019 02:43:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2qIB86M1YRPFqzRbiSYJHXSvnR5ntxhBHVG/ZPlAa+uWsmv+N3M3vBvmDnrR+iPYztXY4CA==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr8614836wmk.37.1574332997903;
        Thu, 21 Nov 2019 02:43:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744? ([2001:b07:6468:f312:71a5:6e:f854:d744])
        by smtp.gmail.com with ESMTPSA id k1sm2863881wrp.29.2019.11.21.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 02:43:17 -0800 (PST)
Subject: Re: [PATCH v7 0/9] Enable Sub-Page Write Protection Support
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com, alazar@bitdefender.com,
        edwin.zhai@intel.com
References: <20191119084949.15471-1-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1b64143-d372-81ae-349d-bcd72fd3b668@redhat.com>
Date:   Thu, 21 Nov 2019 11:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119084949.15471-1-weijiang.yang@intel.com>
Content-Language: en-US
X-MC-Unique: pa6KvRM-MOyaXVh9njgfiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/19 09:49, Yang Weijiang wrote:
> EPT-Based Sub-Page write Protection(SPP) allows Virtual Machine Monitor(V=
MM)
> specify write-permission for guest physical memory at a sub-page(128 byte=
)
> granularity. When SPP works, HW enforces write-access check for sub-pages
> within a protected 4KB page.
>=20
> The feature targets to provide fine-grained memory protection for
> usages such as memory guard and VM introspection etc.
>=20
> SPP is active when the "sub-page write protection" (bit 23) is 1 in
> Secondary VM-Execution Controls. The feature is backed with a Sub-Page
> Permission Table(SPPT), and subpage permission vector is stored in the
> leaf entry of SPPT. The root page is referenced via a Sub-Page Permission
> Table Pointer (SPPTP) in VMCS.
>=20
> To enable SPP for guest memory, the guest page should be first mapped
> to a 4KB EPT entry, then set SPP bit 61 of the corresponding entry.=20
> While HW walks EPT, it traverses SPPT with the gpa to look up the sub-pag=
e
> permission vector within SPPT leaf entry. If the corresponding bit is set=
,
> write to sub-page is permitted, otherwise, SPP induced EPT violation is g=
enerated.
>=20
> This patch serial passed SPP function test and selftest on Ice-Lake platf=
orm.
>=20
> Please refer to the SPP introduction document in this patch set and
> Intel SDM for details:
>=20
> Intel SDM:
> https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-v=
ol-1-2abcd-3abcd.pdf
>=20
> SPP selftest patch:
> https://lkml.org/lkml/2019/6/18/1197

On top of the changes I sent for the individual patches, please move
vmx/spp.c to mmu/spp.c, and vmx/spp.h to spp.h (I've just sent a patch
to create the mmu/ directory).  Also, please include the selftest in
this series.

Paolo

> Patch 1: Documentation for SPP and related API.
> Patch 2: Add control flags for Sub-Page Protection(SPP).
> Patch 3: Add SPP Table setup functions.
> Patch 4: Add functions to create/destroy SPP bitmap block.
> Patch 5: Introduce user-space SPP IOCTLs.
> Patch 6: Set up SPP paging table at vmentry/vmexit.
> Patch 7: Enable Lazy mode SPP protection.
> Patch 8: Handle SPP protected pages when VM memory changes.
> Patch 9: Add SPP protection check in emulation case.
>=20
>=20
> Change logs:
> V6 -> V7:
>   1. Configured all available protected pages once SPP induced vmexit
>      happens since there's no PRESENT bit in SPPT leaf entry.
>   2. Changed SPP protection check flow in tdp_page_fault().
>   3. Code refactor and minior fixes.
>=20
> V5 -> V6:
>   1. Added SPP protection patch for emulation cases per Jim's review.
>   2. Modified documentation and added API description per Jim's review.
>   3. Other minior changes suggested by Jim.
>=20
> V4 -> V5:
>   1. Enable SPP support for Hugepage(1GB/2MB) to extend application.
>   2. Make SPP miss vm-exit handler as the unified place to set up SPPT.
>   3. If SPP protected pages are access-tracked or dirty-page-tracked,
>      store SPP flag in reserved address bit, restore it in
>      fast_page_fault() handler.
>   4. Move SPP specific functions to vmx/spp.c and vmx/spp.h
>   5. Rebased code to kernel v5.3
>   6. Other change suggested by KVM community.
>  =20
> V3 -> V4:
>   1. Modified documentation to make it consistent with patches.
>   2. Allocated SPPT root page in init_spp() instead of vmx_set_cr3() to
>      avoid SPPT miss error.
>   3. Added back co-developers and sign-offs.
>=20
> V2 -> V3:                                                               =
=20
>   1. Rebased patches to kernel 5.1 release                               =
=20
>   2. Deferred SPPT setup to EPT fault handler if the page is not
>      available while set_subpage() is being called.
>   3. Added init IOCTL to reduce extra cost if SPP is not used.
>   4. Refactored patch structure, cleaned up cross referenced functions.
>   5. Added code to deal with memory swapping/migration/shrinker cases.
>=20
> V2 -> V1:
>   1. Rebased to 4.20-rc1
>   2. Move VMCS change to a separated patch.
>   3. Code refine and Bug fix=20
>=20
>=20
> Yang Weijiang (9):
>   Documentation: Introduce EPT based Subpage Protection and related
>     ioctls
>   vmx: spp: Add control flags for Sub-Page Protection(SPP)
>   mmu: spp: Add SPP Table setup functions
>   mmu: spp: Add functions to create/destroy SPP bitmap block
>   x86: spp: Introduce user-space SPP IOCTLs
>   vmx: spp: Set up SPP paging table at vmentry/vmexit
>   mmu: spp: Enable Lazy mode SPP protection
>   mmu: spp: Handle SPP protected pages when VM memory changes
>   x86: spp: Add SPP protection check in emulation.
>=20
>  Documentation/virt/kvm/api.txt        |  46 ++
>  Documentation/virtual/kvm/spp_kvm.txt | 180 +++++++
>  arch/x86/include/asm/cpufeatures.h    |   1 +
>  arch/x86/include/asm/kvm_host.h       |  10 +-
>  arch/x86/include/asm/vmx.h            |  10 +
>  arch/x86/include/uapi/asm/vmx.h       |   2 +
>  arch/x86/kernel/cpu/intel.c           |   4 +
>  arch/x86/kvm/mmu.c                    |  78 ++-
>  arch/x86/kvm/mmu.h                    |   2 +
>  arch/x86/kvm/vmx/capabilities.h       |   5 +
>  arch/x86/kvm/vmx/spp.c                | 651 ++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/spp.h                |  28 ++
>  arch/x86/kvm/vmx/vmx.c                | 113 +++++
>  arch/x86/kvm/x86.c                    |  87 ++++
>  include/uapi/linux/kvm.h              |  17 +
>  15 files changed, 1232 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/spp_kvm.txt
>  create mode 100644 arch/x86/kvm/vmx/spp.c
>  create mode 100644 arch/x86/kvm/vmx/spp.h
>=20

