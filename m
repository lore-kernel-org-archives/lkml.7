Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D391C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8672067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zcvq/j0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfLLRot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:44:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45251 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730108AbfLLRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:44:48 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so3652057ioi.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZUkuLltWHAaMt9PiF7re5SLQkc/j51hQPwRCUKb9Mw=;
        b=Zcvq/j0dfcg82cX+jYcHpmIcVtvtDsWFmkRO4oumpHMJBzVvRQUTs/a+SdZiryhxTt
         0zzz71YUxyr6JKp3Riotyq8Nacg2OvjaTqLG9Xqfu8ia62nzd/Ez5/pkR3q4gWDBR7Tp
         MuspoypVdYRvucBFx3gOeBzKWoabO1APnY27Go0vENPxdx97lvA1Zgo/hY0hCMr4DvbY
         gE4cuFY4cECLbNUHNggMwvoACSoA/V5htVau63pTIHbubNesuuoU3LRh/Of0K3M089hd
         /NTiWoftyfnBxI2qXB9ksSS6YIk1Y2idkO86qwlw55yX03BbTg0sUea3Q/llueiJXMZD
         cqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZUkuLltWHAaMt9PiF7re5SLQkc/j51hQPwRCUKb9Mw=;
        b=VFJo4aqEXTMS6BOXveQ0aYw9gUpDqoOkm1ot1yhrQYz67EUDsM23nAr2ofoSXPyUfb
         K0iruVWXKQu19iPJFGM3TMfbV5tYRhdwIQQoPMYck/RntVUch2xTd/ihOKJOt9KDeoG2
         R8dAe4NMzzCPb7vCxJeLyj1d0OWepXMD4dXJ8Nd8bcWMd913A+wFs7HbyHVrgbGQl3dO
         +UalS95+sSarY1tuVg0qFF1LLiwJ5Pk2Wy+UI8OfTKJbQWEH8O9F7vvizgEUhw7Nz7hq
         uQhXvIkVmbFwf8rMHOof3+QzF68Qs3GnfUOBArru80Tnbraq3xUikE05G+fOJ9u491HQ
         w92g==
X-Gm-Message-State: APjAAAU+5vjqKSeQnlUImy5YMcVIWYiP4V2gm/xhMTYPmgoLwxSi1NKN
        q2qr2PACwAsF0V3dSpv8umPnllh/Id5Cz3eK0pq2ZQ==
X-Google-Smtp-Source: APXvYqyP11Avt7fW6f3c7v+tjDwdWe3evb7j+D31QfTjrBzg1C5L1u2gm1VV7aaniEW69FxObtJ77JATYAKYJi6EgCc=
X-Received: by 2002:a5d:8cda:: with SMTP id k26mr4127162iot.26.1576172687645;
 Thu, 12 Dec 2019 09:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-3-pomonis@google.com>
 <314f6d96-b75f-e159-d94d-1d30a5140e40@de.ibm.com>
In-Reply-To: <314f6d96-b75f-e159-d94d-1d30a5140e40@de.ibm.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 Dec 2019 09:44:36 -0800
Message-ID: <CALMp9eTOD6r13sPZ3skz_YkSFn2ZKbsr5zbLP9LgzjpHnsebkQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data()
 from Spectre-v1/L1TF attacks
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Marios Pomonis <pomonis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:31 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 11.12.19 21:47, Marios Pomonis wrote:
> > This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
> > and kvm_hv_msr_set_crash_data().
> > These functions contain index computations that use the
> > (attacker-controlled) MSR number.
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
>
> The fact that we do a WARN_ON_ONCE here, should actually tell that index is not
> user controllable. Otherwise this would indicate the possibility to trigger a
> kernel warning from a malicious user space. So
> a: we do not need this change
> or
> b: we must also fix the WARN_ON_ONCE

That isn't quite true. The issue is *speculative* execution down this path.

The call site does constrain the *actual* value of index:

case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
        return kvm_hv_msr_get_crash_data(...);

However, it is possible to train the branch predictor to go down this
path using valid indices and subsequently pass what would be an
invalid index. The CPU will speculatively follow this path and may
pull interesting data into the cache before it realizes its mistake
and corrects.
