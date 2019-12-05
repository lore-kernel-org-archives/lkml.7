Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544FCC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9924670
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epHmOUmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfLEUwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:52:12 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40777 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbfLEUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:52:11 -0500
Received: by mail-yb1-f194.google.com with SMTP id n3so2057823ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=esyZevaXdkhJjUMNx13nyp+9Eluo1ToosFQUPVH2VNs=;
        b=epHmOUmVY5XkxCHYw6AAnfY9JySDXyEZKHaF6sJV4EyJ+bSwyM1GK54ZM1ailY+lV3
         0Nn8ofg9UOzrfqHhstT6+V1J8dp1S6GUk3GaXYRaEp4zV6R37ZUkRxlcQ/c7xBqZDjDf
         5l+JW4DDsiuYkaRkCF9f1HpLDPJb5/RHjHQEa7l1E7L+0Uzm7qStowX6lY825AjlSUHk
         9Bc3lSgjBOhhquvmlFXzSoYCXi/uX8v+rUeerc/1jNz/R7/StUnAKsY6Zd8YIWWBay5c
         fPZlwbiE9nc6uR+uedEJFOhetl59OSR/hH7G38atXZU7zQ2+hHXZHnA5uUUo2oDiFUcd
         wHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=esyZevaXdkhJjUMNx13nyp+9Eluo1ToosFQUPVH2VNs=;
        b=Tja7TKjESE2jNG8AzA1N1GC7PG+ngNLm1pklp+5KtG4C6lVVBn/U2z5yQgilO9OjzV
         AlNFzE2VUf3YpFm8R1H0W5CXQl8721wcbZNwos4tyAqD+/hNpVxfmCsfb51MAUsEsSt4
         D/I150Irx2i8gJZkmYLQh7fWB5xID6/X6GGD3I4GqfqzD/tkyY92CHailVA773J00q5G
         PQ1xmiF2NA46BdH1P6BM9E/WyaImVvEn/mSO8IyRze3zWzge63R/Fdoe+GAVCOf19lrc
         XymJYPh1DruIoAFV76/bjEzfxyQ6TZwyCXOjpO9t0edfqkxsrGkhBlbXU5qEnI2C1t0Z
         rRow==
X-Gm-Message-State: APjAAAX0ELdRaE8/Azk7LSiuyBQDKGGRBU3JbeOKxI+DiS4CwxSbHDdO
        iOj+PsnivG7U4DGdRRzMdZxfKA==
X-Google-Smtp-Source: APXvYqzX6DhUtg5junDkGQ0xaFYdjCa3bCK6/wVaEApBqjt3MOGS/x0JQ/OSLlK0fbl0spyrdckXTQ==
X-Received: by 2002:a25:bb87:: with SMTP id y7mr8259383ybg.473.1575579129251;
        Thu, 05 Dec 2019 12:52:09 -0800 (PST)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id 199sm5159675ywn.52.2019.12.05.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 12:52:08 -0800 (PST)
Date:   Thu, 5 Dec 2019 14:52:06 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Jack Wang <jack.wang.usish@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 067/306] KVM: nVMX: move check_vmentry_postreqs()
 call to nested_vmx_enter_non_root_mode()
Message-ID: <20191205205206.2mnr3dj2slamuhrl@xps.therub.org>
Mail-Followup-To: Jack Wang <jack.wang.usish@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20191127203114.766709977@linuxfoundation.org>
 <20191127203119.676489279@linuxfoundation.org>
 <CA+res+QKCAn8PsSgbkqXNAF0Ov5pOkj=732=M5seWj+-JFQOwQ@mail.gmail.com>
 <20191204175033.smve4dleem2ht7st@xps.therub.org>
 <CA+res+SW7o4YpUtv4-UYXP4WSPm417tgow68YM7YjOEcZ5xO3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+res+SW7o4YpUtv4-UYXP4WSPm417tgow68YM7YjOEcZ5xO3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 10:51:18AM +0100, Jack Wang wrote:
> Dan Rue <dan.rue@linaro.org> 于2019年12月4日周三 下午6:50写道：
> >
> > On Mon, Dec 02, 2019 at 03:40:04PM +0100, Jack Wang wrote:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> 于2019年11月27日周三 下午10:30写道：
> > > >
> > > > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > > >
> > > > [ Upstream commit 7671ce21b13b9596163a29f4712cb2451a9b97dc ]
> > > >
> > > > In preparation of supporting checkpoint/restore for nested state,
> > > > commit ca0bde28f2ed ("kvm: nVMX: Split VMCS checks from nested_vmx_run()")
> > > > modified check_vmentry_postreqs() to only perform the guest EFER
> > > > consistency checks when nested_run_pending is true.  But, in the
> > > > normal nested VMEntry flow, nested_run_pending is only set after
> > > > check_vmentry_postreqs(), i.e. the consistency check is being skipped.
> > > >
> > > > Alternatively, nested_run_pending could be set prior to calling
> > > > check_vmentry_postreqs() in nested_vmx_run(), but placing the
> > > > consistency checks in nested_vmx_enter_non_root_mode() allows us
> > > > to split prepare_vmcs02() and interleave the preparation with
> > > > the consistency checks without having to change the call sites
> > > > of nested_vmx_enter_non_root_mode().  In other words, the rest
> > > > of the consistency check code in nested_vmx_run() will be joining
> > > > the postreqs checks in future patches.
> > > >
> > > > Fixes: ca0bde28f2ed ("kvm: nVMX: Split VMCS checks from nested_vmx_run()")
> > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > > Cc: Jim Mattson <jmattson@google.com>
> > > > Reviewed-by: Jim Mattson <jmattson@google.com>
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  arch/x86/kvm/vmx.c | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > > index fe7fdd666f091..bdf019f322117 100644
> > > > --- a/arch/x86/kvm/vmx.c
> > > > +++ b/arch/x86/kvm/vmx.c
> > > > @@ -12694,6 +12694,9 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
> > > >         if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
> > > >                 evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
> > > >
> > > > +       if (from_vmentry && check_vmentry_postreqs(vcpu, vmcs12, exit_qual))
> > > > +               return EXIT_REASON_INVALID_STATE;
> > > > +
> > > >         enter_guest_mode(vcpu);
> > > >
> > > >         if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
> > > > @@ -12836,13 +12839,6 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
> > > >          */
> > > >         skip_emulated_instruction(vcpu);
> > > >
> > > > -       ret = check_vmentry_postreqs(vcpu, vmcs12, &exit_qual);
> > > > -       if (ret) {
> > > > -               nested_vmx_entry_failure(vcpu, vmcs12,
> > > > -                                        EXIT_REASON_INVALID_STATE, exit_qual);
> > > > -               return 1;
> > > > -       }
> > > > -
> > > >         /*
> > > >          * We're finally done with prerequisite checking, and can start with
> > > >          * the nested entry.
> > > > --
> > > > 2.20.1
> > > >
> > > >
> > > >
> > > Hi all,
> > >
> > > This commit caused many kvm-unit-tests regression, cherry-pick
> > > following commits from 4.20 fix the regression:
> >
> > Hi Jack - can you be more specific about the failing tests? What type of
> > environment and which tests failed, which version of kvm-unit-tests? Do
> > you have any logs available? I ask because we do run kvm-unit-tests on
> > x86 and arm64 but we did not see these regressions.
> >
> > Thanks,
> > Dan
> >
> Hi Dan,
> 
> I'm running at kvm-unit-tests commit b1414c5f0142 ("x86: vmx: fix
> required alignment for posted interrupt descriptor")
> 
> using "run_tests.sh -a -t -j8" with qemu-2.7.1
> 
> Left side has only 78 tests ok, and right side has 112 tests ok.

Thanks - so we run it with "run_tests.sh -v" and only see 43 passes in
the best case. Besides missing -a, we see a skip for the vmx related
tests because vmx isn't enabled in our environment.

We will fix those problems in LKFT so that we can catch regressions like
this before they are released.

Dan
