Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9FB21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="P0y7S7AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCNInp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:43:45 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36863 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:43:45 -0400
Received: by mail-vs1-f66.google.com with SMTP id j12so2735617vsd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amc6bmVLFsqmbdzeqy2n806dmj76qtTSQMA24ZgCC6g=;
        b=P0y7S7ASVRX9hnjcY4IyerNpFn3bt780Hwjl2HUZ62hTnkHAxx2FSW1lWykJuN/INf
         VP2PJx3Wvd26OJpPKHQmAz5kJ1TosPENalY78zRwyLjDcX4bKSP1OoG71l6v27eBMPtQ
         Iw2iWh7NpH3qPm2baAAoknMoAiJow08l9tYW1QmnQHV40Efsh0HGObbC+1QGU1QyxS5C
         A+5gW6s1MyscUWDCBZYQeeGYyiPRM5YsdcnpcF/S4O7TIlcRnHLKoqJl11vOf74RvCkD
         ei1fHc78bV32NK1RnHJOJcc0mKc2nmFIob/1GZF9tImp1pmUTFr00pOmgrU2sLHmvd0Z
         cYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amc6bmVLFsqmbdzeqy2n806dmj76qtTSQMA24ZgCC6g=;
        b=JPa4irtDvnoTy5QhH2GswIHxE9aAqO3YEOtX+rduCo7KRTKJcV5m/xeELmCx+ybAjO
         g2ceZf974FU5+3tWXHgPXCZQx0yTJSN12/tQy/LH+0T5uymx1KocdzbmF+yYMfQ4f8RQ
         N6Jm03xvhm0AGJfYuJSTXBaYvZrxDaiBbbnZlDpC2S0659BRgXNaV3Q/9REDuwxVoSL+
         TGYsAv9LCyRWzTMSuLyQ8JeQ7J2/GM3VNWRmFblpEi4j9pIM7LKUtZFRkZTNPQqUTzII
         6mfboQsqm9GHcXrTKyndETT5C/AuOc/pCXxB3vwd+rxSDDS4IfSph1muBfwQZBunNdWi
         93ng==
X-Gm-Message-State: APjAAAXZpkyAVOKoAQl7mWHRLVAbdS+nQmm1NAw+IFias2WivFJQ3/vC
        FGFqtCY4IXr8d3tib/ZQmmjCyULIAHQU1YgCxRgsBA==
X-Google-Smtp-Source: APXvYqwJkNfVWkzfjFwoj4GsDAKHS+V7Q8Drn3mNQQusqE2sOZL87Fn5ZRULv28imsGilcMrC4wPMcZklTuwS4zFgw8=
X-Received: by 2002:a67:f148:: with SMTP id t8mr26458002vsm.209.1552553023437;
 Thu, 14 Mar 2019 01:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190314063858.18292-1-xiaoyao.li@linux.intel.com>
In-Reply-To: <20190314063858.18292-1-xiaoyao.li@linux.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 14 Mar 2019 21:43:28 +1300
Message-ID: <CAP045Args8Pq-jGnSSnpCcZ2xqgSb1EHnn74-fBgPrgurKY0PQ@mail.gmail.com>
Subject: Re: [PATCH] kvm/x86/vmx: switch MSR_MISC_FEATURES_ENABLES between
 host and guest
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, Chao Gao <chao.gao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 7:50 PM Xiaoyao Li <xiaoyao.li@linux.intel.com> wrote:
>
> CPUID Faulting is a feature about CPUID instruction. When CPUID Faulting is
> enabled, all execution of the CPUID instruction outside system-management
> mode (SMM) cause a general-protection (#GP) if the CPL > 0.
>
> About this feature, detailed information can be found at
> https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf
>
> There is an issue that current kvm doesn't switch the value of
> MSR_MISC_FEATURES_ENABLES between host and guest. If MSR_MISC_FEATURES_ENABLES
> exists on the hardware cpu, and host enables CPUID faulting (setting the bit 0
> of MSR_MISC_FEATURES_ENABLES), it will impact the guest's behavior because
> cpuid faulting is enabled by host and passed to guest.

The host doesn't enable CPUID faulting and keep it enabled for
everything though, it only enables it for specified user-space
processes (via arch_prctl). How does CPUID faulting "leak" into the
KVM guest?

- Kyle

> From my tests, when host enables cpuid faulting, it causes guest boot failure
> when guest uses *modprobe* to load modules. Below is the error log:
>
> [    1.233556] traps: modprobe[71] general protection fault ip:7f0077f6495c sp:7ffda148d808 error:0 in ld-2.17.so[7f0077f4d000+22000]
> [    1.237780] traps: modprobe[73] general protection fault ip:7fad5aba095c sp:7ffd36067378 error:0 in ld-2.17.so[7fad5ab89000+22000]
> [    1.241930] traps: modprobe[75] general protection fault ip:7f3edb89495c sp:7fffa1a81308 error:0 in ld-2.17.so[7f3edb87d000+22000]
> [    1.245998] traps: modprobe[77] general protection fault ip:7f91d670895c sp:7ffc25fa7f38 error:0 in ld-2.17.so[7f91d66f1000+22000]
> [    1.250016] traps: modprobe[79] general protection fault ip:7f0ddbbdc95c sp:7ffe9c34f8d8 error:0 in ld-2.17.so[7f0ddbbc5000+22000]
>
> *modprobe* calls CPUID instruction thus causing cpuid faulting in guest.
> At the end, because guest cannot *modprobe* modules, it boots failure.
>
> This patch switches MSR_MISC_FEATURES_ENABLES between host and guest when
> hardware has this MSR.
>
> This patch doesn't confict with the commit db2336a80489 ("KVM: x86: virtualize
> cpuid faulting"), which provides a software emulation of cpuid faulting for
> x86 arch. Below analysing how cpuid faulting will work after applying this patch:
>
> 1. If host cpu is AMD. It doesn't have MSR_MISC_FEATURES_ENABLES, so we can just
> use the software emulation of cpuid faulting.
>
> 2. If host cpu is Intel and it doesn't have MSR_MISC_FEATURES_ENABLES. The same
> as case 1, we can just use the software emulation of cpuid faulting.
>
> 3. If host cpu is Intel and it has MSR_MISC_FEATURES_ENABLES. With this patch,
> it will write guest's value into MSR_MISC_FEATURES_ENABLES when vm entry.
> If guest enables cpuid faulting and when guest calls CPUID instruction with
> CPL > 0, it will cause #GP exception in guest instead of VM exit because of
> CPUID, thus it doesn't go to the kvm emualtion path but ues the hardware
> feature. Also it's a benefit that we needn't use VM exit to inject #GP to
> emulate cpuid faulting feature.
>
> Intel SDM vol3.25.1.1 specifies the priority between cpuid faulting
> and CPUID instruction.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 30a6bcd735ec..90707fae688e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6321,6 +6321,23 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>                                         msrs[i].host, false);
>  }
>
> +static void atomic_switch_msr_misc_features_enables(struct kvm_vcpu *vcpu)
> +{
> +       u64 host_msr;
> +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +       /* if MSR MISC_FEATURES_ENABLES doesn't exist on the hardware, do nothing*/
> +       if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &host_msr))
> +               return;
> +
> +       if (host_msr == vcpu->arch.msr_misc_features_enables)
> +               clear_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES);
> +       else
> +               add_atomic_switch_msr(vmx, MSR_MISC_FEATURES_ENABLES,
> +                                     vcpu->arch.msr_misc_features_enables,
> +                                     host_msr, false);
> +}
> +
>  static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
>  {
>         vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
> @@ -6562,6 +6579,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>
>         atomic_switch_perf_msrs(vmx);
>
> +       atomic_switch_msr_misc_features_enables(vcpu);
> +
>         vmx_update_hv_timer(vcpu);
>
>         /*
> --
> 2.19.1
