Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319F7C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5EF206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmZL1j65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfD1BDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:03:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42594 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfD1BDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:03:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so5755699otl.9;
        Sat, 27 Apr 2019 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFMpKaVtG83ocJUgGi9QfNWDN7Vcw/byLNsDbK4tBA4=;
        b=lmZL1j654n8vEjeaN1CPUJT+6Cl0p893MDOcnI0dI5okQ+OSWeMBdbKAG+5WOpTtXI
         3MG5xmAQtzRk6ky4ksXYa80lCafJ9rwH1WsAoakvJYPHL92D0pTJGa1EPZeJyIIuKulF
         InQJ/vET0CDoOacGTdkF3OfZLDREtk1ccIZVrG//GiSxPN9JacNGw16ZPe+v5XZ98Tes
         6U4SkXmILuk0WGsFKIVT/qh7UsAxh3pX2+2YXZ/TuLdBhbZS4m0kEe95LsbSBDIJN21M
         geojwu0MYfKnFpGrpsrz0THERAV/6Ssf8bfLJVXsIBi2E19502mwK8m3/XPGBp5jHaTI
         JQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFMpKaVtG83ocJUgGi9QfNWDN7Vcw/byLNsDbK4tBA4=;
        b=sNhDq2p81dm15tBitMo1oa3pmmPXBc86SB5JXqb16t+yw7AeCX5Z5mxCISzFWxld8t
         fO0NxpFCs2UJ5cy2FDTr4D5+WXoFj/xlHiUpoh7yubklJSuo8bFkIycovvZETsTh6v4c
         kQM2iD1nmHV63OOOeCUNJ4AuPfnBg4BPYMLpHVM6DVxcwClG7kFI1F4anMOqOruBUMNi
         705R7c15NGUtRPXKU/toEZg5v4bZR5GYQWf1sGyLKOH0YGcZtwxWgVMgijtGx6PAcCYf
         AdnPZAfChYFTCXX7dgncS0Ls2Qm+2V1+um5Il1b10KqbQJ3F7EPaHD6/pEXcmdN8zu8o
         p1+Q==
X-Gm-Message-State: APjAAAVzlgSAtvG5vH2OehPwBrf41SnnbGRVsfnRQ5uREWLFdWGmPd2e
        BXdP9BEZwVbb9NVLL8+HJ+TOCD0a/CQamOCHsCA=
X-Google-Smtp-Source: APXvYqxrXgirARSozsaGkTnJKWBi6ZoHaUL5vaTPe6he/9j4ZqIeynEC1W0DIRvJqAaWQcAzNc/5X32POIIMVSpGPEk=
X-Received: by 2002:a9d:3f05:: with SMTP id m5mr33950212otc.59.1556413419059;
 Sat, 27 Apr 2019 18:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190412075539.24624-1-chao.wang@ucloud.cn> <23f882f1-6477-3c18-c07f-873c24351cfc@redhat.com>
In-Reply-To: <23f882f1-6477-3c18-c07f-873c24351cfc@redhat.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Sun, 28 Apr 2019 09:03:54 +0800
Message-ID: <CANRm+Cz9+eg8W0YoAyqinAfEYEyV6v=K4TqX6h4UJ56m+6AYaw@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: move kvm_load/put_guest_xcr0 into atomic context
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     WANG Chao <chao.wang@ucloud.cn>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 at 16:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/04/19 09:55, WANG Chao wrote:
> > guest xcr0 could leak into host when MCE happens in guest mode. Because
> > do_machine_check() could schedule out at a few places.
> >
> > For example:
> >
> > kvm_load_guest_xcr0
> > ...
> > kvm_x86_ops->run(vcpu) {
> >   vmx_vcpu_run
> >     vmx_complete_atomic_exit
> >       kvm_machine_check
> >         do_machine_check
> >           do_memory_failure
> >             memory_failure
> >               lock_page

Maybe this should not be counted to guest time in guest_exit_irqoff()?

Regards,
Wanpeng Li

> >
> > In this case, host_xcr0 is 0x2ff, guest vcpu xcr0 is 0xff. After schedule
> > out, host cpu has guest xcr0 loaded (0xff).
> >
> > In __switch_to {
> >      switch_fpu_finish
> >        copy_kernel_to_fpregs
> >          XRSTORS
> >
> > If any bit i in XSTATE_BV[i] == 1 and xcr0[i] == 0, XRSTORS will
> > generate #GP (In this case, bit 9). Then ex_handler_fprestore kicks in
> > and tries to reinitialize fpu by restoring init fpu state. Same story as
> > last #GP, except we get DOUBLE FAULT this time.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
>
> Thanks for the detailed commit message.  Patch queued!.
>
> Paolo
>
> > ---
> >  arch/x86/kvm/svm.c     |  2 ++
> >  arch/x86/kvm/vmx/vmx.c |  4 ++++
> >  arch/x86/kvm/x86.c     | 10 ++++------
> >  arch/x86/kvm/x86.h     |  2 ++
> >  4 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index e0a791c3d4fc..2bf73076de7f 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -5621,6 +5621,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
> >       svm->vmcb->save.cr2 = vcpu->arch.cr2;
> >
> >       clgi();
> > +     kvm_load_guest_xcr0(vcpu);
> >
> >       /*
> >        * If this vCPU has touched SPEC_CTRL, restore the guest's value if
> > @@ -5766,6 +5767,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
> >       if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
> >               kvm_before_interrupt(&svm->vcpu);
> >
> > +     kvm_put_guest_xcr0(vcpu);
> >       stgi();
> >
> >       /* Any pending NMI will happen here */
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index ab432a930ae8..3157598c52f1 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6410,6 +6410,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >       if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
> >               vmx_set_interrupt_shadow(vcpu, 0);
> >
> > +     kvm_load_guest_xcr0(vcpu);
> > +
> >       if (static_cpu_has(X86_FEATURE_PKU) &&
> >           kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
> >           vcpu->arch.pkru != vmx->host_pkru)
> > @@ -6506,6 +6508,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >                       __write_pkru(vmx->host_pkru);
> >       }
> >
> > +     kvm_put_guest_xcr0(vcpu);
> > +
> >       vmx->nested.nested_run_pending = 0;
> >       vmx->idt_vectoring_info = 0;
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 099b851dabaf..22f66e9a7dc5 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -800,7 +800,7 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_lmsw);
> >
> > -static void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
> > +void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
> >  {
> >       if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE) &&
> >                       !vcpu->guest_xcr0_loaded) {
> > @@ -810,8 +810,9 @@ static void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu)
> >               vcpu->guest_xcr0_loaded = 1;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(kvm_load_guest_xcr0);
> >
> > -static void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
> > +void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
> >  {
> >       if (vcpu->guest_xcr0_loaded) {
> >               if (vcpu->arch.xcr0 != host_xcr0)
> > @@ -819,6 +820,7 @@ static void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu)
> >               vcpu->guest_xcr0_loaded = 0;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(kvm_put_guest_xcr0);
> >
> >  static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
> >  {
> > @@ -7865,8 +7867,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >               goto cancel_injection;
> >       }
> >
> > -     kvm_load_guest_xcr0(vcpu);
> > -
> >       if (req_immediate_exit) {
> >               kvm_make_request(KVM_REQ_EVENT, vcpu);
> >               kvm_x86_ops->request_immediate_exit(vcpu);
> > @@ -7919,8 +7919,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >       vcpu->mode = OUTSIDE_GUEST_MODE;
> >       smp_wmb();
> >
> > -     kvm_put_guest_xcr0(vcpu);
> > -
> >       kvm_before_interrupt(vcpu);
> >       kvm_x86_ops->handle_external_intr(vcpu);
> >       kvm_after_interrupt(vcpu);
> > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > index 28406aa1136d..aedc5d0d4989 100644
> > --- a/arch/x86/kvm/x86.h
> > +++ b/arch/x86/kvm/x86.h
> > @@ -347,4 +347,6 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
> >       __this_cpu_write(current_vcpu, NULL);
> >  }
> >
> > +void kvm_load_guest_xcr0(struct kvm_vcpu *vcpu);
> > +void kvm_put_guest_xcr0(struct kvm_vcpu *vcpu);
> >  #endif
> >
>
