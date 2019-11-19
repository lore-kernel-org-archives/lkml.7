Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF00222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrdIsyLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfKSLyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:54:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbfKSLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574164462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=doRSJ76XzgPWyysG7t+THLllYu72qQIDHhX5bZ9eXls=;
        b=DrdIsyLiuQGRlfpPxd/NdXQVGbxvwq/5/TcJJ8+3k9BdlgwDP9Up68x+mHkr6jNvsivF71
        9sEUMNii6KebmUvc/LuRCfACfjbOHH6n25rdO6rjFsvOw1LXt8niUXQnBoNIX8XeWmTtwb
        GsypgWHdTXIFowSK2qvhqQ7HQOEZ5QA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-vKG9IJyzOJ66-W1qT-55Gg-1; Tue, 19 Nov 2019 06:54:21 -0500
Received: by mail-wm1-f71.google.com with SMTP id b10so2122930wmh.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mIxdauT8Ocb6jbNjExbQ11Q5FF2m4sH95EG0rjgID/k=;
        b=qthnlpJHwuYAy3GWKeiWe32+nI/uCw2gtKcUB6wTJbU4GQM40i5DCrC/FdhBSYfeWZ
         U1IFIFWM+fiZroJtB1YhvJ9hyWCwLOGd61NUaAls0OS1FRoRez3AB7GDHdpsE2FQQJkj
         qUFpMQAxfBYykml/MzwHfS2Jd+MV3O5iX4tbqUCLFYL9NIC31HkyVQblz4JJHMkjjeh7
         5KkGOEMzhsCaIVyFMVgK5U1OuizA3SmsHgdppqnjbvm/FSxuiDuuoC5k8JvDsIMoRG3G
         6bXB8Gdj6gnsoWtmB1WarDqnL7cLjRWlKAez2JBosbDEUgV5QkOsDmDUaCIBjZ0X/d8A
         rbhA==
X-Gm-Message-State: APjAAAXZCaMzS9rIpT3RY5/ESN72eaoBFIWcdtK94HhrSf0iAwk5o04X
        zdY7+TjlW8h2oLrcVHJ9qazg+EslGTLfmkGxkmS9Nxc7BTDVaIfAelueiv7rP9QOAUIsKNEshq7
        vDet7PufvvD1xvoU6slPHL/JB
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr5389152wmi.40.1574164459791;
        Tue, 19 Nov 2019 03:54:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhmhgjZhzw42SfcbimEvxLDolBCEOxRNZmvCYojHg4OqVxZRlMjXOJI5QTi8rnt8F513wRbg==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr5389122wmi.40.1574164459468;
        Tue, 19 Nov 2019 03:54:19 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z15sm1930299wmi.12.2019.11.19.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 03:54:18 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] KVM: VMX: FIXED+PHYSICAL mode single target IPI fastpath
In-Reply-To: <1574145389-12149-1-git-send-email-wanpengli@tencent.com>
References: <1574145389-12149-1-git-send-email-wanpengli@tencent.com>
Date:   Tue, 19 Nov 2019 12:54:18 +0100
Message-ID: <87r224gjyt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: vKG9IJyzOJ66-W1qT-55Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> ICR and TSCDEADLINE MSRs write cause the main MSRs write vmexits in=20
> our product observation, multicast IPIs are not as common as unicast=20
> IPI like RESCHEDULE_VECTOR and CALL_FUNCTION_SINGLE_VECTOR etc.
>
> This patch tries to optimize x2apic physical destination mode, fixed=20
> delivery mode single target IPI by delivering IPI to receiver as soon=20
> as possible after sender writes ICR vmexit to avoid various checks=20
> when possible, especially when running guest w/ --overcommit cpu-pm=3Don
> or guest can keep running, IPI can be injected to target vCPU by=20
> posted-interrupt immediately.
>
> Testing on Xeon Skylake server:
>
> The virtual IPI latency from sender send to receiver receive reduces=20
> more than 200+ cpu cycles.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add tracepoint
>  * Instead of a separate vcpu->fast_vmexit, set exit_reason
>    to vmx->exit_reason to -1 if the fast path succeeds.
>  * move the "kvm_skip_emulated_instruction(vcpu)" to vmx_handle_exit
>  * moving the handling into vmx_handle_exit_irqoff()
>
>  arch/x86/include/asm/kvm_host.h |  4 ++--
>  arch/x86/include/uapi/asm/vmx.h |  1 +
>  arch/x86/kvm/svm.c              |  4 ++--
>  arch/x86/kvm/vmx/vmx.c          | 40 +++++++++++++++++++++++++++++++++++=
++---
>  arch/x86/kvm/x86.c              |  5 +++--
>  5 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 898ab9e..0daafa9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1084,7 +1084,7 @@ struct kvm_x86_ops {
>  =09void (*tlb_flush_gva)(struct kvm_vcpu *vcpu, gva_t addr);
> =20
>  =09void (*run)(struct kvm_vcpu *vcpu);
> -=09int (*handle_exit)(struct kvm_vcpu *vcpu);
> +=09int (*handle_exit)(struct kvm_vcpu *vcpu, u32 *vcpu_exit_reason);
>  =09int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
>  =09void (*set_interrupt_shadow)(struct kvm_vcpu *vcpu, int mask);
>  =09u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
> @@ -1134,7 +1134,7 @@ struct kvm_x86_ops {
>  =09int (*check_intercept)(struct kvm_vcpu *vcpu,
>  =09=09=09       struct x86_instruction_info *info,
>  =09=09=09       enum x86_intercept_stage stage);
> -=09void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
> +=09void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu, u32 *vcpu_exit_reas=
on);
>  =09bool (*mpx_supported)(void);
>  =09bool (*xsaves_supported)(void);
>  =09bool (*umip_emulated)(void);
> diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/=
vmx.h
> index 3eb8411..b33c6e1 100644
> --- a/arch/x86/include/uapi/asm/vmx.h
> +++ b/arch/x86/include/uapi/asm/vmx.h
> @@ -88,6 +88,7 @@
>  #define EXIT_REASON_XRSTORS             64
>  #define EXIT_REASON_UMWAIT              67
>  #define EXIT_REASON_TPAUSE              68
> +#define EXIT_REASON_NEED_SKIP_EMULATED_INSN -1

Maybe just EXIT_REASON_INSN_SKIP ?

> =20
>  #define VMX_EXIT_REASONS \
>  =09{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index d02a73a..c8e063a 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4929,7 +4929,7 @@ static void svm_get_exit_info(struct kvm_vcpu *vcpu=
, u64 *info1, u64 *info2)
>  =09*info2 =3D control->exit_info_2;
>  }
> =20
> -static int handle_exit(struct kvm_vcpu *vcpu)
> +static int handle_exit(struct kvm_vcpu *vcpu, u32 *vcpu_exit_reason)
>  {
>  =09struct vcpu_svm *svm =3D to_svm(vcpu);
>  =09struct kvm_run *kvm_run =3D vcpu->run;
> @@ -6187,7 +6187,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcp=
u,
>  =09return ret;
>  }
> =20
> -static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> +static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu, u32 *vcpu_exit=
_reason)
>  {
> =20
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 621142e5..b98198d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5792,7 +5792,7 @@ void dump_vmcs(void)
>   * The guest has exited.  See if we can fix it or if we need userspace
>   * assistance.
>   */
> -static int vmx_handle_exit(struct kvm_vcpu *vcpu)
> +static int vmx_handle_exit(struct kvm_vcpu *vcpu, u32 *vcpu_exit_reason)
>  {
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>  =09u32 exit_reason =3D vmx->exit_reason;
> @@ -5878,7 +5878,10 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu)
>  =09=09}
>  =09}
> =20
> -=09if (exit_reason < kvm_vmx_max_exit_handlers
> +=09if (*vcpu_exit_reason =3D=3D EXIT_REASON_NEED_SKIP_EMULATED_INSN) {
> +=09=09kvm_skip_emulated_instruction(vcpu);
> +=09=09return 1;
> +=09} else if (exit_reason < kvm_vmx_max_exit_handlers
>  =09    && kvm_vmx_exit_handlers[exit_reason]) {
>  #ifdef CONFIG_RETPOLINE
>  =09=09if (exit_reason =3D=3D EXIT_REASON_MSR_WRITE)
> @@ -6223,7 +6226,36 @@ static void handle_external_interrupt_irqoff(struc=
t kvm_vcpu *vcpu)
>  }
>  STACK_FRAME_NON_STANDARD(handle_external_interrupt_irqoff);
> =20
> -static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> +static u32 handle_ipi_fastpath(struct kvm_vcpu *vcpu)
> +{
> +=09u32 index;
> +=09u64 data;
> +=09int ret =3D 0;
> +
> +=09if (lapic_in_kernel(vcpu) && apic_x2apic_mode(vcpu->arch.apic)) {
> +=09=09/*
> +=09=09 * fastpath to IPI target, FIXED+PHYSICAL which is popular
> +=09=09 */
> +=09=09index =3D kvm_rcx_read(vcpu);
> +=09=09data =3D kvm_read_edx_eax(vcpu);
> +
> +=09=09if (((index - APIC_BASE_MSR) << 4 =3D=3D APIC_ICR) &&

What if index (RCX) is < APIC_BASE_MSR?

> +=09=09=09((data & KVM_APIC_DEST_MASK) =3D=3D APIC_DEST_PHYSICAL) &&
> +=09=09=09((data & APIC_MODE_MASK) =3D=3D APIC_DM_FIXED)) {
> +
> +=09=09=09trace_kvm_msr_write(index, data);
> +=09=09=09kvm_lapic_set_reg(vcpu->arch.apic, APIC_ICR2, (u32)(data >> 32)=
);
> +=09=09=09ret =3D kvm_lapic_reg_write(vcpu->arch.apic, APIC_ICR, (u32)dat=
a);
> +
> +=09=09=09if (ret =3D=3D 0)
> +=09=09=09=09return EXIT_REASON_NEED_SKIP_EMULATED_INSN;
> +=09=09}
> +=09}
> +
> +=09return ret;
> +}
> +
> +static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu, u32 *exit_reas=
on)
>  {
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> =20
> @@ -6231,6 +6263,8 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu =
*vcpu)
>  =09=09handle_external_interrupt_irqoff(vcpu);
>  =09else if (vmx->exit_reason =3D=3D EXIT_REASON_EXCEPTION_NMI)
>  =09=09handle_exception_nmi_irqoff(vmx);
> +=09else if (vmx->exit_reason =3D=3D EXIT_REASON_MSR_WRITE)
> +=09=09*exit_reason =3D handle_ipi_fastpath(vcpu);
>  }
> =20
>  static bool vmx_has_emulated_msr(int index)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 991dd01..a53bce3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7981,6 +7981,7 @@ EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
>  static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  {
>  =09int r;
> +=09u32 exit_reason =3D 0;
>  =09bool req_int_win =3D
>  =09=09dm_request_for_irq_injection(vcpu) &&
>  =09=09kvm_cpu_accept_dm_intr(vcpu);
> @@ -8226,7 +8227,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  =09vcpu->mode =3D OUTSIDE_GUEST_MODE;
>  =09smp_wmb();
> =20
> -=09kvm_x86_ops->handle_exit_irqoff(vcpu);
> +=09kvm_x86_ops->handle_exit_irqoff(vcpu, &exit_reason);
> =20
>  =09/*
>  =09 * Consume any pending interrupts, including the possible source of
> @@ -8270,7 +8271,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  =09=09kvm_lapic_sync_from_vapic(vcpu);
> =20
>  =09vcpu->arch.gpa_available =3D false;
> -=09r =3D kvm_x86_ops->handle_exit(vcpu);
> +=09r =3D kvm_x86_ops->handle_exit(vcpu, &exit_reason);
>  =09return r;
> =20
>  cancel_injection:

--=20
Vitaly

