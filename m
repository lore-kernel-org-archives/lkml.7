Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B960233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfHWJee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:34:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbfHWJed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:34:33 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 193FA3C919
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:34:32 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id d64so4128332wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QreUaGjv9CTkutPAtfkHcI/YdY++8wYqEFh96/UbB4c=;
        b=iDKhLX7QB5caONZ7e4KRhF5pdYIsaEXwj+DRJl0Bvx1T6TItDkcvesTnbVOn+aY3UL
         6K/oKY5h3kZrcPbHLJs6bRvFUUtwfqITnRWwpMwyunBj9phvpD5rltLuuN4OvOB03bE8
         Q78vMu4MKXZ/CaonXwM9GI9RCXgGTIqSDbNOgpaiJCpBQ+8EE+7Qh3T/cx73l6LnBB4b
         bpLJCeEZVHihc7NYGkxBo6TmhPhP7xcVgvXdqfw7aoI4mDpQGOhnyc5FpIOaXOFUD3el
         Ioq9IAHAFQEN1AhHOtYNpFnbIwcxB4gfS99/x9DBLEX2V+2Dph29luSOH8oLo8uf4/hR
         xmxg==
X-Gm-Message-State: APjAAAWxNSZ15CPY6J/HoGJ3CROMhgD8z0ODuxHmnCys8AEENxnUN6FC
        6tqcZhuMagmQN4ucGYiVUo+knF4XsRiHuNNKQ3jGRytaEFm9SImld1MPmac2jWe2OhBamFdp3vr
        RpbZi1gbeAsHUQo+vL1NWg2hP
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr4128448wmk.51.1566552870727;
        Fri, 23 Aug 2019 02:34:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9X5S2AQSieJq5ssRPSF/b6ABaYvBQm4IqoXFqGxuS8qwxVjSSbMAiXqZKkrNBEM0ZG35lMQ==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr4128410wmk.51.1566552870478;
        Fri, 23 Aug 2019 02:34:30 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o8sm5085455wma.1.2019.08.23.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:34:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [RESEND PATCH 04/13] KVM: x86: Drop EMULTYPE_NO_UD_ON_FAIL as a standalone type
In-Reply-To: <20190823010709.24879-5-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com> <20190823010709.24879-5-sean.j.christopherson@intel.com>
Date:   Fri, 23 Aug 2019 11:34:29 +0200
Message-ID: <874l28p6my.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> The "no #UD on fail" is used only in the VMWare case, and for the VMWare
> scenario it really means "#GP instead of #UD on fail".  Remove the flag
> in preparation for moving all fault injection into the emulation flow
> itself, which in turn will allow eliminating EMULATE_DONE and company.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/svm.c              | 3 +--
>  arch/x86/kvm/vmx/vmx.c          | 3 +--
>  arch/x86/kvm/x86.c              | 2 +-
>  4 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 44a5ce57a905..dd6bd9ed0839 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1318,7 +1318,6 @@ enum emulation_result {
>  #define EMULTYPE_TRAP_UD	    (1 << 1)
>  #define EMULTYPE_SKIP		    (1 << 2)
>  #define EMULTYPE_ALLOW_RETRY	    (1 << 3)
> -#define EMULTYPE_NO_UD_ON_FAIL	    (1 << 4)
>  #define EMULTYPE_VMWARE		    (1 << 5)
>  int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
>  int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 1f220a85514f..5a42f9c70014 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2772,8 +2772,7 @@ static int gp_interception(struct vcpu_svm *svm)
>  
>  	WARN_ON_ONCE(!enable_vmware_backdoor);
>  
> -	er = kvm_emulate_instruction(vcpu,
> -		EMULTYPE_VMWARE | EMULTYPE_NO_UD_ON_FAIL);
> +	er = kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE);
>  	if (er == EMULATE_USER_EXIT)
>  		return 0;
>  	else if (er != EMULATE_DONE)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 18286e5b5983..6ecf773825e2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4509,8 +4509,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  
>  	if (!vmx->rmode.vm86_active && is_gp_fault(intr_info)) {
>  		WARN_ON_ONCE(!enable_vmware_backdoor);
> -		er = kvm_emulate_instruction(vcpu,
> -			EMULTYPE_VMWARE | EMULTYPE_NO_UD_ON_FAIL);
> +		er = kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE);
>  		if (er == EMULATE_USER_EXIT)
>  			return 0;
>  		else if (er != EMULATE_DONE)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fe847f8eb947..e0f0e14d8fac 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6210,7 +6210,7 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
>  	++vcpu->stat.insn_emulation_fail;
>  	trace_kvm_emulate_insn_failed(vcpu);
>  
> -	if (emulation_type & EMULTYPE_NO_UD_ON_FAIL)
> +	if (emulation_type & EMULTYPE_VMWARE)
>  		return EMULATE_FAIL;
>  
>  	kvm_queue_exception(vcpu, UD_VECTOR);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
