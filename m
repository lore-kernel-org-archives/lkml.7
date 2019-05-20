Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD57BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADFE20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfETKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:36:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50553 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfETKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:36:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so12753965wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3xXPvZpyjHsgmFWoKd9d5EDj4j0NbyZe+58R2bsw9kA=;
        b=Wt+tj0eBsZYq3NmNrfnFewGX8f0JjWbDUybvX/qHzdmDvkk2LtN5MkIPk/DfyRzSuV
         ct2IpVU2/U6IN6FJKUqha/zgsQlauEfcwJpvPnzw9LBJHUpU037Y074CuY6rX/wcyfFO
         e8Sa6oYpydeg+WhJH+s34JoUOQq+EWrKbauyGP5d/21SIrx9MHWQEEvYBvCN6cNDdYME
         DgOEZXWScHv87xMLtTlMzWXs6fSkDCHHFUAZLO0iiKYd4puV0EVKLAs7lfO+D60uEJtU
         bQBZRjnAyxYzf+ZJVz71mChz39dDKaHGa9l1rmyFfUDuHI76OVuYcIyPU9JoyZf23elK
         ADzQ==
X-Gm-Message-State: APjAAAWqzp4kGkTo07s9YrRMtprVygXO/MS2Shxjn77Pl4SmSYNsEs0R
        7oA5p2x5sJlaFyhxfmbqLM1R8Q==
X-Google-Smtp-Source: APXvYqwFrpHwMAG0+wlGu82qSp+aU4+gtbOAlaZFMGwiFeMGZZMWNYjWlOJtHuNt4/KLKgezSbLeSw==
X-Received: by 2002:a1c:ca19:: with SMTP id a25mr11412291wmg.105.1558348598772;
        Mon, 20 May 2019 03:36:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id m10sm9686930wmf.40.2019.05.20.03.36.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:36:38 -0700 (PDT)
Subject: Re: [PATCH 4/4] KVM: nVMX: Fix using __this_cpu_read() in preemptible
 context
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
 <1558082990-7822-4-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4874aa09-7f46-7ca5-5d32-1d7b1cb1eef3@redhat.com>
Date:   Mon, 20 May 2019 12:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558082990-7822-4-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/19 10:49, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
>  BUG: using __this_cpu_read() in preemptible [00000000] code: qemu-system-x86/4590
>   caller is nested_vmx_enter_non_root_mode+0xebd/0x1790 [kvm_intel]
>   CPU: 4 PID: 4590 Comm: qemu-system-x86 Tainted: G           OE     5.1.0-rc4+ #1
>   Call Trace:
>    dump_stack+0x67/0x95
>    __this_cpu_preempt_check+0xd2/0xe0
>    nested_vmx_enter_non_root_mode+0xebd/0x1790 [kvm_intel]
>    nested_vmx_run+0xda/0x2b0 [kvm_intel]
>    handle_vmlaunch+0x13/0x20 [kvm_intel]
>    vmx_handle_exit+0xbd/0x660 [kvm_intel]
>    kvm_arch_vcpu_ioctl_run+0xa2c/0x1e50 [kvm]
>    kvm_vcpu_ioctl+0x3ad/0x6d0 [kvm]
>    do_vfs_ioctl+0xa5/0x6e0
>    ksys_ioctl+0x6d/0x80
>    __x64_sys_ioctl+0x1a/0x20
>    do_syscall_64+0x6f/0x6c0
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Accessing per-cpu variable should disable preemption, this patch extends the 
> preemption disable region for __this_cpu_read().
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0c601d0..8f6f69c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2792,14 +2792,13 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  	      : "cc", "memory"
>  	);
>  
> -	preempt_enable();
> -
>  	if (vmx->msr_autoload.host.nr)
>  		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
>  	if (vmx->msr_autoload.guest.nr)
>  		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
>  
>  	if (vm_fail) {
> +		preempt_enable();
>  		WARN_ON_ONCE(vmcs_read32(VM_INSTRUCTION_ERROR) !=
>  			     VMXERR_ENTRY_INVALID_CONTROL_FIELD);
>  		return 1;
> @@ -2811,6 +2810,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
>  	local_irq_enable();
>  	if (hw_breakpoint_active())
>  		set_debugreg(__this_cpu_read(cpu_dr7), 7);
> +	preempt_enable();
>  
>  	/*
>  	 * A non-failing VMEntry means we somehow entered guest mode with
> 


Queued, thanks.

Paolo
