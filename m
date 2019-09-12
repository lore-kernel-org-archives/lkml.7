Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70753C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435A9206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwudzUW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfILVUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:20:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35556 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfILVUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:20:22 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so57593244ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gN6NbTbdBD+LpPm2/OIojga+N97BltFjeiskUToQd2k=;
        b=uwudzUW+QhHWEBiuzAIQHoFP9Q69nPzDa6YfPHDIQwbLPH4yOueCxKLHSe10rBJGk/
         KhMtM3sJArrKR7vuHq9nkIr2X+tNYnC7SsyfPUc8rTLoktXUYE+BXhGSdYy2FvVSDgOQ
         yKNYiKfgP1dIJeZSY5aAox8IvqunDL6EsO+02vs0RyvDv4sJ7r5Dd/0RqA51abO/h0vM
         TCAQ2atBaRXIorzCzX0TzVQ/DQaJZZRQIuFIBjS6v+n/Z7h+n5wXwcUqzBUU0Q/AgtPG
         Upc37wSeXinGGYRHaEyBVQFkRHDAnyZe22+DLDbAwn8sjLRfhktzooI2nSXj1XC5rISB
         vpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gN6NbTbdBD+LpPm2/OIojga+N97BltFjeiskUToQd2k=;
        b=Z+rZtAScmZyqV9GcRy0M6mPbj1/+3QCRoIMWdENua22nTz7OhQAQrprb/TL8Z5kWVL
         MVE51DWD2KSA44f4GkylLyMcMiqAWEaGmWPWhgBEvKSEQnz/JGFFnGVyK+ktmOKqGWs0
         XH5Z9Jw8GII7rCC2zBMocoGNqnPzJ8oJgGp7PYTs05OtjxJqfCVx+eHXzf5ouadE3utF
         lDEsJ0PvNc7yIC/57gyjMIR7cueuKGmMaj6qtTkvN9q+E+tfAwO4W1WUGNUgqPYESmmS
         FY44xvx7D3EpSyMs3h0ed/OetW5lA5oAjtc3ue53t1u9AVoPLH78UU4lP38kXSu3QJEK
         TH9Q==
X-Gm-Message-State: APjAAAXX0niuHeG5xxJsU26SNl2dAqglvJ2/QarfHr1PENahwKVRvTp6
        P9icnijGTMiGzDfcLtlXWSSyg+Wr1x/p+9Rqg0pLAg==
X-Google-Smtp-Source: APXvYqwxoYarrCqiyOJMszrAlELGJkKpICOdAogSDotKra7i4hK6Vfwg5TYlNK0oSP4qThk1xhrf5PPbSUlOsmz3LX0=
X-Received: by 2002:a6b:1606:: with SMTP id 6mr2231217iow.108.1568323220804;
 Thu, 12 Sep 2019 14:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190912041817.23984-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190912041817.23984-1-huangfq.daxian@gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 Sep 2019 14:20:09 -0700
Message-ID: <CALMp9eSL_rDdWmgeWNwuqP_J_yu7x5Gs8DUBpJFdie18NEz=ow@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: work around leak of uninitialized stack contents
To:     Fuqian Huang <huangfq.daxian@gmail.com>
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
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 9:18 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Emulation of VMPTRST can incorrectly inject a page fault
> when passed an operand that points to an MMIO address.
> The page fault will use uninitialized kernel stack memory
> as the CR2 and error code.
>
> The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
> exit to userspace; however, it is not an easy fix, so for now just ensure
> that the error code and CR2 are zero.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  arch/x86/kvm/x86.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 290c3c3efb87..7f442d710858 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5312,6 +5312,7 @@ int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
>         /* kvm_write_guest_virt_system can pull in tons of pages. */
>         vcpu->arch.l1tf_flush_l1d = true;
>
> +       memset(exception, 0, sizeof(*exception));
>         return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
>                                            PFERR_WRITE_MASK, exception);
>  }
> --
> 2.11.0
>
Perhaps you could also add a comment like the one Paolo added when he
made the same change in kvm_read_guest_virt?
See commit 353c0956a618 ("KVM: x86: work around leak of uninitialized
stack contents (CVE-2019-7222)").
