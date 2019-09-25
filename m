Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7523BC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533552146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406553AbfIYNap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406504AbfIYNaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:30:39 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5291963704
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:30:38 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m6so2070243wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QOoXojrDcM6YKd5O7J93fem8+nhl/1NFQhh6LIecpZs=;
        b=Mpzh3LXKN1H36DGsaKJyLWCFqgjAuB3lF7nL/Gye7koC2olw5P589BM/iDMH9gKxwp
         dyAxjbhDn0/hWOAwAzBXssnNh6Edref+Fa408FXUG7VVGPetBlMZga5M+j/3G5fVJSBT
         2GXV45nn930CiavUlW/FMRHEVewT9d5BwhptMvhiPh9ZWvdS7yWTYPwwqzY2bw7zzSV8
         s0hsmmBhP9ISmEFiCkbISIp673KWBFJBdyFXrBLMLVsHdx2O7b75hyZo/oMJlNbux7Ib
         5aJ4nxq9RkvDxGkEN9FFvf2u5xWArWKtslBKvZT+6yp3DkWV31p8owfI8z/W2DSt+O8Y
         UE+w==
X-Gm-Message-State: APjAAAWQe7fYNxBIKXz5+KETaWY0PeyA3qbn6qZDreN3+tYflrEtzahE
        mGv6hTKMTWd6WfnmvrzxGExZq+rJNMnsqsWNakvSI2TJUcrDsGLaWWtilyiF9ZAoOeNCS7CBstx
        LbyuHh9rQDoGNdKJAq9CVCCFK
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr7703926wmi.108.1569418236811;
        Wed, 25 Sep 2019 06:30:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuaqf0jVbeUISXALRc4LB5SYcrZWFjcUia7gahVKdmybxNiH3P6jiXA8cJTojNFcmHJuq6Hw==
X-Received: by 2002:a7b:c10b:: with SMTP id w11mr7703896wmi.108.1569418236525;
        Wed, 25 Sep 2019 06:30:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id h17sm6571710wme.6.2019.09.25.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:30:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] KVM: VMX: Optimize VMX instrs error/fault handling
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190719204110.18306-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf2d8a9d-0d7b-73da-c62e-ad3713b38e6a@redhat.com>
Date:   Wed, 25 Sep 2019 15:30:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719204110.18306-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/19 22:41, Sean Christopherson wrote:
> A recent commit reworked __kvm_handle_fault_on_reboot() to play nice with
> objtool.  An unfortunate side effect is that JMP is now inserted after
> most VMX instructions so that the reboot macro can use an actual CALL to
> kvm_spurious_fault() instead of a funky PUSH+JMP facsimile in .fixup.
> 
> Rework the low level VMX instruction helpers to handle unexpected faults
> manually instead of relying on the "fault on reboot" macro.  By using
> asm-goto, most helpers can branch directly to an in-function call to
> kvm_spurious_fault(), which can then be optimized by compilers to reside
> out-of-line at the end of the function instead of inline as done by
> "fault on reboot".
> 
> The net impact relative to the current code base is more or less a nop
> when building with a compiler that supports __GCC_ASM_FLAG_OUTPUTS__.
> A bunch of code that was previously in .fixup gets moved into the slow
> paths of functions, but the fast paths are more basically unchanged.
> 
> Without __GCC_ASM_FLAG_OUTPUTS__, manually coding the Jcc is a net
> positive as CC_SET() without compiler support almost always generates a
> SETcc+CMP+Jcc sequence, which is now replaced with a single Jcc.
> 
> A small bonus is that the Jcc instrs are hinted to predict that the VMX
> instr will be successful.
> 
> v2:
>   - Rebased to x86/master, commit eceffd88ca20 ("Merge branch 'x86/urgent'")
>   - Reworded changelogs to reference the commit instead lkml link for
>     the recent changes to __kvm_handle_fault_on_reboot().
>   - Added Paolo's acks for patch 1-4
>   - Added patch 5 to do more cleanup, which was made possible by rebasing
>     on top of the __kvm_handle_fault_on_reboot() changes.
>   
> Sean Christopherson (5):
>   objtool: KVM: x86: Check kvm_rebooting in kvm_spurious_fault()
>   KVM: VMX: Optimize VMX instruction error and fault handling
>   KVM: VMX: Add error handling to VMREAD helper
>   KVM: x86: Drop ____kvm_handle_fault_on_reboot()
>   KVM: x86: Don't check kvm_rebooting in __kvm_handle_fault_on_reboot()
> 
>  arch/x86/include/asm/kvm_host.h | 16 ++----
>  arch/x86/kvm/vmx/ops.h          | 93 ++++++++++++++++++++-------------
>  arch/x86/kvm/vmx/vmx.c          | 42 +++++++++++++++
>  arch/x86/kvm/x86.c              |  3 +-
>  tools/objtool/check.c           |  1 -
>  5 files changed, 104 insertions(+), 51 deletions(-)
> 

Queued, thanks.

Paolo
