Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C6FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA532166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzU33u+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfH2TBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:01:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43183 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfH2TBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:01:47 -0400
Received: by mail-io1-f68.google.com with SMTP id u185so5258723iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0GoqTcetNrsUYVAfNmMyDqTNMHiKZd1X2n4rg0Xzqw=;
        b=XzU33u+W1B0k9YCWc5RlZojrPzqvliMOZTJajeaB1y7KqVJuusocLKxgHiaNO1/QB4
         hAxEnYxtc81Lz9kkcPpJICN2SpCCFR2TEihyt7eVSLUADJhMQvJAXRBN0XwoRjBsQSsO
         3iu5LbmRvzsM5DjCuQsVlJaiCbcWdAqJYl+idwcfVXMhI7aWqMoy5SQv0BnG/DPimIoD
         QYYUXdzpkn8Vd7p85TZ5ATinFawqlUJN6Gpx29OJ7EzNEJC9yMJZe5oUZGpqxZ2EVPzB
         7PjEYSdvQA3EamflN9hXPebOSjyyMqyo41yciS2NqD/n2G7F72q/roZ5Y+Y57DuMkHTf
         cPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0GoqTcetNrsUYVAfNmMyDqTNMHiKZd1X2n4rg0Xzqw=;
        b=aiQOJOT7bEgl5tr3Rt2vnhQkHGBGAPDxRYIt/ma01nbIXwbrH4ZUvuwFun9L6N5Ub6
         /vW3uNni3/9XpUha/JhaVPpDoW+ps6sNRDOVVFDZXJbnb6J5Oy5HAKdXyF6y31nplf8A
         oHAmZekiy1lbh5+1nijWsuydre4SDYPLM2F42NnsaCcwAOQ1qf+aoBPcNqiKRkPSDFUT
         FktPACR03hJ731rwiaxWSi27QFL8lGB+x7YANxQfM+udBuQaQGR42kmww0kYbrkjpAl+
         mTiuGCo/c3fImpKUZLV2GQ+WiAttJQtoCfOGMyGpAvK2WRGO7u1hRV9YrNj6FvdJfowt
         Khog==
X-Gm-Message-State: APjAAAUdKHNdjBMEh67TkjW+b5y3qacDD/SNKj8Kf/CNryEzjHWrbJI3
        tCKk8VtipBoYcTtpFchSd0G+SG9qP9X73NO06I9TJQ==
X-Google-Smtp-Source: APXvYqx/Nd1FoK/WJw+5huELXgYRT9e9xB16tDB/tJa16xuUVF91FMNgbcDHx+F/2Bi6FnUbidggsHmYSy3SOhPd92I=
X-Received: by 2002:a5d:8e15:: with SMTP id e21mr6809020iod.296.1567105306039;
 Thu, 29 Aug 2019 12:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <1567056849-14608-1-git-send-email-luwei.kang@intel.com> <1567056849-14608-2-git-send-email-luwei.kang@intel.com>
In-Reply-To: <1567056849-14608-2-git-send-email-luwei.kang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 29 Aug 2019 12:01:34 -0700
Message-ID: <CALMp9eS0-OfAR1=mrvABrOg85V+-yM64KuOff3A1_wCKDYZNxw@mail.gmail.com>
Subject: Re: [RFC v1 1/9] KVM: x86: Add base address parameter for
 get_fixed_pmc function
To:     Luwei Kang <luwei.kang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:38 PM Luwei Kang <luwei.kang@intel.com> wrote:
>
> PEBS output Inte PT introduces some new MSRs (MSR_RELOAD_FIXED_CTRx)
> for fixed function counters that use for autoload the preset value
> after writing out a PEBS event.
>
> Introduce base MSRs address parameter to make this function can get
> performance monitor counter structure by MSR_RELOAD_FIXED_CTRx registers.
>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/kvm/pmu.h           |  5 ++---
>  arch/x86/kvm/vmx/pmu_intel.c | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 58265f7..c62a1ff 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -93,10 +93,9 @@ static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
>  }
>
>  /* returns fixed PMC with the specified MSR */
> -static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
> +static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr,
> +                                                               int base)
>  {
> -       int base = MSR_CORE_PERF_FIXED_CTR0;
> -
>         if (msr >= base && msr < base + pmu->nr_arch_fixed_counters)
>                 return &pmu->fixed_counters[msr - base];

IIUC, these new MSRs aren't new fixed PMCs, but are values to be
reloaded into the existing fixed PMCs when a PEBS event has been
written. This change makes it look like you are introducing an
additional set of fixed PMCs.
