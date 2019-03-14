Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841820854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCNKrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:47:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:37168 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfCNKrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:47:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 03:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="152275065"
Received: from lxy-dell.sh.intel.com ([10.239.159.145])
  by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2019 03:47:13 -0700
Message-ID: <059a5c6309b0e43695e5532e698d07750502d6d3.camel@linux.intel.com>
Subject: Re: [PATCH] kvm/x86/vmx: switch MSR_MISC_FEATURES_ENABLES between
 host and guest
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, Chao Gao <chao.gao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Mar 2019 18:43:50 +0800
In-Reply-To: <CAP045Args8Pq-jGnSSnpCcZ2xqgSb1EHnn74-fBgPrgurKY0PQ@mail.gmail.com>
References: <20190314063858.18292-1-xiaoyao.li@linux.intel.com>
         <CAP045Args8Pq-jGnSSnpCcZ2xqgSb1EHnn74-fBgPrgurKY0PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 21:43 +1300, Kyle Huey wrote:
> On Thu, Mar 14, 2019 at 7:50 PM Xiaoyao Li <xiaoyao.li@linux.intel.com> wrote:
> > 
> > CPUID Faulting is a feature about CPUID instruction. When CPUID Faulting is
> > enabled, all execution of the CPUID instruction outside system-management
> > mode (SMM) cause a general-protection (#GP) if the CPL > 0.
> > 
> > About this feature, detailed information can be found at
> > 
https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
> > 
> > There is an issue that current kvm doesn't switch the value of
> > MSR_MISC_FEATURES_ENABLES between host and guest. If
> > MSR_MISC_FEATURES_ENABLES
> > exists on the hardware cpu, and host enables CPUID faulting (setting the bit
> > 0
> > of MSR_MISC_FEATURES_ENABLES), it will impact the guest's behavior because
> > cpuid faulting is enabled by host and passed to guest.
> 
> The host doesn't enable CPUID faulting and keep it enabled for
> everything though, it only enables it for specified user-space
> processes (via arch_prctl). How does CPUID faulting "leak" into the
> KVM guest?

Yes, you are right. With your patches, only when we enable cpuid faulting for
the QEMU or other VMM userspace processes via arch_prctl, does it "leak" into
the KVM guest. 

But arch_prctl is not the only way to enable it. We can enable cpuid faulting
via module "msr.ko". And I think it's indeed an issue, we should not ignore it
as it needs special cases and purpose to make it happen so far. 

Besides, Peter's this patch https://patchwork.kernel.org/patch/10850143/ is much
likely to cause the cpuid fauting enabled in host by default during kernel
startup. If that one is going to be applied, it's better to fix the cpuid
faulting leak issue before that.

Thanks,
- Xiaoyao

> - Kyle
> 
> > From my tests, when host enables cpuid faulting, it causes guest boot
> > failure
> > when guest uses *modprobe* to load modules. Below is the error log:
> > 
> > [    1.233556] traps: modprobe[71] general protection fault ip:7f0077f6495c
> > sp:7ffda148d808 error:0 in ld-2.17.so[7f0077f4d000+22000]
> > [    1.237780] traps: modprobe[73] general protection fault ip:7fad5aba095c
> > sp:7ffd36067378 error:0 in ld-2.17.so[7fad5ab89000+22000]
> > [    1.241930] traps: modprobe[75] general protection fault ip:7f3edb89495c
> > sp:7fffa1a81308 error:0 in ld-2.17.so[7f3edb87d000+22000]
> > [    1.245998] traps: modprobe[77] general protection fault ip:7f91d670895c
> > sp:7ffc25fa7f38 error:0 in ld-2.17.so[7f91d66f1000+22000]
> > [    1.250016] traps: modprobe[79] general protection fault ip:7f0ddbbdc95c
> > sp:7ffe9c34f8d8 error:0 in ld-2.17.so[7f0ddbbc5000+22000]
> > 
> > *modprobe* calls CPUID instruction thus causing cpuid faulting in guest.
> > At the end, because guest cannot *modprobe* modules, it boots failure.
> > 
> > This patch switches MSR_MISC_FEATURES_ENABLES between host and guest when
> > hardware has this MSR.
> > 
> > This patch doesn't confict with the commit db2336a80489 ("KVM: x86:
> > virtualize
> > cpuid faulting"), which provides a software emulation of cpuid faulting for
> > x86 arch. Below analysing how cpuid faulting will work after applying this
> > patch:
> > 
> > 1. If host cpu is AMD. It doesn't have MSR_MISC_FEATURES_ENABLES, so we can
> > just
> > use the software emulation of cpuid faulting.
> > 
> > 2. If host cpu is Intel and it doesn't have MSR_MISC_FEATURES_ENABLES. The
> > same
> > as case 1, we can just use the software emulation of cpuid faulting.
> > 
> > 3. If host cpu is Intel and it has MSR_MISC_FEATURES_ENABLES. With this
> > patch,
> > it will write guest's value into MSR_MISC_FEATURES_ENABLES when vm entry.
> > If guest enables cpuid faulting and when guest calls CPUID instruction with
> > CPL > 0, it will cause #GP exception in guest instead of VM exit because of
> > CPUID, thus it doesn't go to the kvm emualtion path but ues the hardware
> > feature. Also it's a benefit that we needn't use VM exit to inject #GP to
> > emulate cpuid faulting feature.
> > 
> > Intel SDM vol3.25.1.1 specifies the priority between cpuid faulting
> > and CPUID instruction.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > ---
> >  arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 30a6bcd735ec..90707fae688e 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6321,6 +6321,23 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx
> > *vmx)
> >                                         msrs[i].host, false);
> >  }
> > 
> > +static void atomic_switch_msr_misc_features_enables(struct kvm_vcpu *vcpu)
> > +{
> > +       u64 host_msr;
> > +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +
> > +       /* if MSR MISC_FEATURES_ENABLES doesn't exist on the hardware, do
> > nothing*/
> > +       if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &host_msr))
> > +               return;
> > +
> > +       if (host_msr == vcpu->arch.msr_misc_features_enables)
> > +               clear_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES);
> > +       else
> > +               add_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES,
> > +                                     vcpu->arch.msr_misc_features_enables,
> > +                                     host_msr, false);
> > +}
> > +
> >  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
> >  {
> >         vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
> > @@ -6562,6 +6579,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
> > 
> >         atomic_switch_perf_msrs(vmx);
> > 
> > +       atomic_switch_msr_misc_features_enables(vcpu);
> > +
> >         vmx_update_hv_timer(vcpu);
> > 
> >         /*
> > --
> > 2.19.1

