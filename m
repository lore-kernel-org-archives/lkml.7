Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92275205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwSUHEkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfLLRL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:11:26 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33951 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfLLRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:11:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1255897qvf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8i/P7PW2Hmf7if5w9WzMo01jNRINdPJBRjB9gK59EQ=;
        b=KwSUHEkKFnQJl6ziISrvsigGagqLvOmVERDG6DUYWMqZR+pR+SlGTc4CfEoM4oKLga
         5znnUebLqUXbHjT5ebLhMIGPf5Rq4o1M2fI9H1eLh0llknAWtN2bOGIfcD9HkfGQTw/K
         It0FKvAouyzEKkl6ZmqP+ELrCB69SXBTK+T5sYtzPxGwIBPt9EH71nss5ZPd7+UwtSNG
         1IpNsZnrk4f1B2KtLPOKkILRTAVLpOdV8vs8pYsGYJQ3aR1nHpiYppyu45qEfGZ83hxW
         M5QI2jQ3BhnLPS8nbx/NTKSKXakHPBAzSXWBqdjrhlW581Rdw0rvowt/bvyC7HHQz9zA
         BFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8i/P7PW2Hmf7if5w9WzMo01jNRINdPJBRjB9gK59EQ=;
        b=a2oKHGmXY9sKUJ/x8En98kuccx06YosvzEKoQCBWSMFvET7bWUTmJnY/lIz1vFNz46
         5SswFqXFGLvKMtGQhCYszhBu3PjlaOaSGJ5e4MzeNP0VwLOqkVbzKH099lRp45xjXCZc
         OmzibsowWZRgs1vJjF6bPlLx0XW9gBPsMs3xbJOsbDTN2Trz+Bf3SXyjav3Q4YajZ+1j
         U5XrjrThrQY68nQXPytq803RBzSXfLRy3Uk3WaniDI67/Hc0gWStuHphwBq1kpJnku2n
         SB4lPErvoGdZS1jgTPPgmDSXHkyNbCfXBSuPc7lDsPyCfSCXcBqyKLWAyedG8QPTOCZl
         YOkA==
X-Gm-Message-State: APjAAAX4YlDHo3Uc+5U2zQNoxT1ncAlj05nFLS/g4RTBLqO2OcWXhIDo
        PxNK6Ld5d1dSReNTlPj8pmhoCmr0p7fnrrCXRankYg==
X-Google-Smtp-Source: APXvYqzQk46Y6eeg2hH2s6F7jP6tW8AHVwnJZaLYT6r1Wf5ecobjIj6/5wKC5s9XcEf0+8Tie52rAjaWCUQE/ZryatY=
X-Received: by 2002:ad4:4b08:: with SMTP id r8mr9321668qvw.250.1576170684921;
 Thu, 12 Dec 2019 09:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-3-pomonis@google.com>
 <87eex9c20c.fsf@vitty.brq.redhat.com>
In-Reply-To: <87eex9c20c.fsf@vitty.brq.redhat.com>
From:   Marios Pomonis <pomonis@google.com>
Date:   Thu, 12 Dec 2019 09:11:14 -0800
Message-ID: <CAKXAmdjmYzY=eQUpt2f7J6OLBozAjg=pgEgkFXEVDudH4-EydQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data()
 from Spectre-v1/L1TF attacks
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 1:43 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Marios Pomonis <pomonis@google.com> writes:
>
> > This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
> > and kvm_hv_msr_set_crash_data().
> > These functions contain index computations that use the
> > (attacker-controlled) MSR number.
>
> Just to educate myself,
>
> in both cases 'index' is equal to 'msr - HV_X64_MSR_CRASH_P0' where
> 'msr' is constrained:
>   case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
>          ....
>
> and moreover, kvm_hv_{get,set}_msr_common() is only being called for a
> narrow set of MSRs. How can an atacker overcome these limitations?
>
This attack scenario relies on speculative execution. Practically, one
could train the branch predictors involved to speculatively execute
this path even if the adversary-supplied MSR number does not fall into
the legitimate range. The adversary-supplied MSR number however is
going to be used when -speculatively- computing the index of the array
thus allowing an attacker to load normally illegitimate memory values
in the L1 cache.
> >
> > Fixes: commit e7d9513b60e8 ("kvm/x86: added hyper-v crash msrs into kvm hyperv context")
> >
> > Signed-off-by: Nick Finco <nifi@google.com>
> > Signed-off-by: Marios Pomonis <pomonis@google.com>
> > Reviewed-by: Andrew Honig <ahonig@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/x86/kvm/hyperv.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 23ff65504d7e..26408434b9bc 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -809,11 +809,12 @@ static int kvm_hv_msr_get_crash_data(struct kvm_vcpu *vcpu,
> >                                    u32 index, u64 *pdata)
> >  {
> >       struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
> > +     size_t size = ARRAY_SIZE(hv->hv_crash_param);
> >
> > -     if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
> > +     if (WARN_ON_ONCE(index >= size))
> >               return -EINVAL;
> >
> > -     *pdata = hv->hv_crash_param[index];
> > +     *pdata = hv->hv_crash_param[array_index_nospec(index, size)];
> >       return 0;
> >  }
> >
> > @@ -852,11 +853,12 @@ static int kvm_hv_msr_set_crash_data(struct kvm_vcpu *vcpu,
> >                                    u32 index, u64 data)
> >  {
> >       struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
> > +     size_t size = ARRAY_SIZE(hv->hv_crash_param);
> >
> > -     if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
> > +     if (WARN_ON_ONCE(index >= size))
> >               return -EINVAL;
> >
> > -     hv->hv_crash_param[index] = data;
> > +     hv->hv_crash_param[array_index_nospec(index, size)] = data;
> >       return 0;
> >  }
>
> --
> Vitaly
>


-- 
Marios Pomonis
Software Engineer, Security
GCP Platform Security
US-KIR-6THC
