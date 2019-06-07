Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF828C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEFB212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFGN1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:27:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37913 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfFGN1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:27:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so1930150wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 06:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lhbrQuJABuaDxncms4eZbC3z/E1oBNqlH5KBxisoGi4=;
        b=EpJLl+DMeC14qkC30yFe8qvNCxgGcILFRcbsx8bz8sQn4BXuHt979jC//zZL5DDg13
         PJBLPL35Mjn/Nv90YmyN0dfag4OVv30+fw+IROylJZwHJfoO4Vj+IqcK3fC+481Cn6hz
         YceNmeMjJCMRxsV4CyXg1kuPDPDhZJeehSkd2/CsUKBDgOZ4sIY1RS5q6ftorqt/G5VD
         cTeRkj5ut4YaoQ0tcuknBNg7WVxK34WmxqTDiR3tYtebo2MoYsGGtzaW4yQ20T40nL1o
         cfNUFpYoG/893awlx5bcpKqUPaxT2Pz+l4lqstZwpGYe2T2ByfPXicl+PLGpEIsJnZ7r
         ICbg==
X-Gm-Message-State: APjAAAX2Zk6ZPuY0tPsPR7rRAelFWn4KpB3Awo/gILDlt/+j88UW4zN2
        j8piBM60Sew+tG48T1OdLT6Grg==
X-Google-Smtp-Source: APXvYqwlbrW5803loZwfI57pKwa/8DYb5Sd/eSd+MIsFUZpPApFO52rx59tTBF02rz8nSbOY6P7r6A==
X-Received: by 2002:a1c:345:: with SMTP id 66mr2417630wmd.8.1559914027357;
        Fri, 07 Jun 2019 06:27:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id h23sm2103672wmb.25.2019.06.07.06.27.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 06:27:06 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] Enable Sub-page Write Protection Support
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com,
        jmattson@google.com, yu.c.zhang@intel.com
References: <20190606152812.13141-1-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <415e571a-47db-b0b5-0215-a7ef1b9be81d@redhat.com>
Date:   Fri, 7 Jun 2019 15:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606152812.13141-1-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/19 17:28, Yang Weijiang wrote:
> EPT-Based Sub-Page write Protection(SPP)is a HW capability which
> allows Virtual Machine Monitor(VMM) to specify write-permission for
> guest physical memory at a sub-page(128 byte) granularity. When this
> capability is enabled, the CPU enforces write-access check for
> sub-pages within a 4KB page.
> 
> The feature is targeted to provide fine-grained memory protection
> for usages such as device virtualization, memory check-point and
> VM introspection etc.
> 
> SPP is active when the "sub-page write protection" (bit 23) is 1 in
> Secondary VM-Execution Controls. The feature is backed with a Sub-Page
> Permission Table(SPPT), SPPT is referenced via a 64-bit control field
> called Sub-Page Permission Table Pointer (SPPTP) which contains a
> 4K-aligned physical address.
> 
> Right now, only 4KB physical pages are supported for SPP. To enable SPP
> for certain physical page, we need to first make the physical page
> write-protected, then set bit 61 of the corresponding EPT leaf entry. 
> While HW walks EPT, if bit 61 is set, it traverses SPPT with the guset
> physical address to find out the sub-page permissions at the leaf entry.
> If the corresponding bit is set, write to sub-page is permitted,
> otherwise, SPP induced EPT vilation is generated.
> 
> Please refer to the SPP introduction document in this patch set and Intel SDM
> for details:
> 
> Intel SDM:
> https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
> 
> Previous patch:
> https://lkml.org/lkml/2018/11/30/605
> 
> Patch 1: Introduction to SPP.
> Patch 2: Add SPP related flags and control bits.
> Patch 3: Functions for SPPT setup.
> Patch 4: Add SPP access bitmaps for memslots.
> Patch 5: Low level implementation of SPP operations.
> Patch 6: Implement User space access IOCTLs.
> Patch 7: Handle SPP induced VMExit and EPT violation.
> Patch 8: Enable lazy mode SPPT setup.
> Patch 9: Handle memory remapping and reclaim.
> 
> 
> Change logs:
> 
> V2 - V3:                                                                
>  1. Rebased patches to kernel 5.1 release                                
>  2. Deferred SPPT setup to EPT fault handler if the page is not available
>     while set_subpage() is being called.                                 
>  3. Added init IOCTL to reduce extra cost if SPP is not used.            
>  4. Refactored patch structure, cleaned up cross referenced functions.    
>  5. Added code to deal with memory swapping/migration/shrinker cases.    
>                                                                            
> V2 - V1:                                                                
>  1. Rebased to 4.20-rc1                                                  
>  2. Move VMCS change to a separated patch.                               
>  3. Code refine and Bug fix 
> 
> 
> Yang Weijiang (9):
>   Documentation: Introduce EPT based Subpage Protection
>   KVM: VMX: Add control flags for SPP enabling
>   KVM: VMX: Implement functions for SPPT paging setup
>   KVM: VMX: Introduce SPP access bitmap and operation functions
>   KVM: VMX: Add init/set/get functions for SPP
>   KVM: VMX: Introduce SPP user-space IOCTLs
>   KVM: VMX: Handle SPP induced vmexit and page fault
>   KVM: MMU: Enable Lazy mode SPPT setup
>   KVM: MMU: Handle host memory remapping and reclaim
> 
>  Documentation/virtual/kvm/spp_kvm.txt | 216 ++++++++++++
>  arch/x86/include/asm/cpufeatures.h    |   1 +
>  arch/x86/include/asm/kvm_host.h       |  26 +-
>  arch/x86/include/asm/vmx.h            |  10 +
>  arch/x86/include/uapi/asm/vmx.h       |   2 +
>  arch/x86/kernel/cpu/intel.c           |   4 +
>  arch/x86/kvm/mmu.c                    | 469 ++++++++++++++++++++++++++
>  arch/x86/kvm/mmu.h                    |   1 +
>  arch/x86/kvm/vmx/capabilities.h       |   5 +
>  arch/x86/kvm/vmx/vmx.c                | 138 ++++++++
>  arch/x86/kvm/x86.c                    | 141 ++++++++
>  include/linux/kvm_host.h              |   9 +
>  include/uapi/linux/kvm.h              |  17 +
>  13 files changed, 1038 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/virtual/kvm/spp_kvm.txt
> 

Please add testcases in tools/testing/selftests/kvm.

Paolo
