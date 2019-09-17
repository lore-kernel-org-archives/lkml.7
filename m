Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD08C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925992171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfIQPOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58533 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbfIQPOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:14:09 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E69E155DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:14:08 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so1394028wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4PB1FbT5VkDhYHBq97VeVQ0522bZ0vraJdaFOAhJuo=;
        b=B7cVWlSzWDCNeQvCsUtl6tGTmDPSZJaInhksWIgnUGuOm0/Q6Vj4QwiMsYIPSNJa1o
         zQJPyL8+JyqP9Yke5vGMwr+09KBRbAToMESLAiVSIxGUtthEu0vHhGog2PqosY1ce95H
         jwSmgiScE2ji1k5dPlopL2cOv+QFKHI63HkTRdrqDHPUOTtqbMiOhJVdSVsmy60CROmC
         ChgdJqtapgb1QjyU1wfrACHuBQgaqBpsVFzVSco0gR2J3Z5DCJDyYMK4cTOz8UBLRU0R
         Ys3C1rhxFzLlkMGsg0o9WDMJT2qjVK45Jb2HjG2kP99Uyq/cukEjsKSl9mdo2gPnFYnS
         p0Xg==
X-Gm-Message-State: APjAAAU2srkmyh6RZi6HL8O7rbWiV8p0Z5MvIIxq9JjWnkT+k9BEWtuM
        PB2dBFGbXO6LDKwTFuc8JTZ4WcCP/s6tZBqEHIWrgmzBlYAjo1CjxP6uF4bsAcP7DVIdIK4NMaN
        VinQoyWnIs8XGzM7WB3ZFJUlM
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr3816308wmc.71.1568733247243;
        Tue, 17 Sep 2019 08:14:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwF9YRZou9rba0jj+36aOHC5cKqqWC2RMuT6lv4mHM7Undu6Vtwyk71MMpvH3Xf+0DWBq3Sxg==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr3816284wmc.71.1568733246955;
        Tue, 17 Sep 2019 08:14:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id r28sm3553198wrr.94.2019.09.17.08.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:14:06 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] KVM: x86: Remove emulation_result enums
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
References: <20190827214040.18710-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8dec39ac-7d69-b1fd-d07c-cf9d014c4af3@redhat.com>
Date:   Tue, 17 Sep 2019 17:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827214040.18710-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/19 23:40, Sean Christopherson wrote:
> Rework the emulator and its users to handle failure scenarios entirely
> within the emulator.
> 
> {x86,kvm}_emulate_instruction() currently returns a tri-state value to
> indicate success/continue, userspace exit needed, and failure.  The
> intent of returning EMULATE_FAIL is to let the caller handle failure in
> a manner that is appropriate for the current context.  In practice,
> the emulator has ended up with a mixture of failure handling, i.e.
> whether or not the emulator takes action on failure is dependent on the
> specific flavor of emulation.
> 
> The mixed handling has proven to be rather fragile, e.g. many flows
> incorrectly assume their specific flavor of emulation cannot fail or
> that the emulator sets state to report the failure back to userspace.
> 
> Move everything inside the emulator, piece by piece, so that the
> emulation routines can return '0' for exit to userspace and '1' for
> resume the guest, just like every other VM-Exit handler.
> 
> Patch 13/14 is a tangentially related bug fix that conflicts heavily with
> this series, so I tacked it on here.
> 
> Patch 14/14 documents the emulation types.  I added it as a separate
> patch at the very end so that the comments could reference the final
> state of the code base, e.g. incorporate the rule change for using
> EMULTYPE_SKIP that is introduced in patch 13/14.
> 
> v1:
>   - https://patchwork.kernel.org/cover/11110331/
> 
> v2:
>   - Collect reviews. [Vitaly and Liran]
>   - Squash VMware emultype changes into a single patch. [Liran]
>   - Add comments in VMX/SVM for VMware #GP handling. [Vitaly]
>   - Tack on the EPT misconfig bug fix.
>   - Add a patch to comment/document the emultypes. [Liran]
> 
> Sean Christopherson (14):
>   KVM: x86: Relocate MMIO exit stats counting
>   KVM: x86: Clean up handle_emulation_failure()
>   KVM: x86: Refactor kvm_vcpu_do_singlestep() to remove out param
>   KVM: x86: Don't attempt VMWare emulation on #GP with non-zero error
>     code
>   KVM: x86: Move #GP injection for VMware into x86_emulate_instruction()
>   KVM: x86: Add explicit flag for forced emulation on #UD
>   KVM: x86: Move #UD injection for failed emulation into emulation code
>   KVM: x86: Exit to userspace on emulation skip failure
>   KVM: x86: Handle emulation failure directly in kvm_task_switch()
>   KVM: x86: Move triple fault request into RM int injection
>   KVM: VMX: Remove EMULATE_FAIL handling in handle_invalid_guest_state()
>   KVM: x86: Remove emulation_result enums, EMULATE_{DONE,FAIL,USER_EXIT}
>   KVM: VMX: Handle single-step #DB for EMULTYPE_SKIP on EPT misconfig
>   KVM: x86: Add comments to document various emulation types
> 
>  arch/x86/include/asm/kvm_host.h |  40 +++++++--
>  arch/x86/kvm/mmu.c              |  16 +---
>  arch/x86/kvm/svm.c              |  62 ++++++--------
>  arch/x86/kvm/vmx/vmx.c          | 147 +++++++++++++-------------------
>  arch/x86/kvm/x86.c              | 133 ++++++++++++++++-------------
>  arch/x86/kvm/x86.h              |   2 +-
>  6 files changed, 195 insertions(+), 205 deletions(-)
> 

Queued, thanks (a couple conflicts had to be sorted out, but nothing
requiring a respin).

Paolo
