Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C6C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED33F21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koGSocao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfIYWKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:10:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44232 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfIYWKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:10:50 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so957658iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWrtMO/1hZ/o86Hyus1zQo+xeKnPuBEenuj+vizXnyo=;
        b=koGSocaoGdmmz2EAifg+USVuephOpKxacLGEobTQDZHxSK8IPRGIsHXPLo6+ji3M02
         he/qi3ePlQUkYeQETTqk6AZqfafzx33eWntchMyfmH1i41z911ZRRnr2h55zLnAH5DhU
         Lk0XXvyS1BLAy2Cwap8ZXQ8O3zH7LAUKwTky6dCiToae2EpAvzExqPX+0L911zwFJktD
         bk8OgO6YJl2QwKvw9+mZEEWeACNFH03tolWaXQUwHtYrbqL+bvuZT7CgPAZvmRZJ3pic
         +96DCQ7muxwH9sOoNIVQ7UCzL5I3RRD7yVBokZLVs97ENcqyAmMFESn8KH5hGlFskgu4
         gs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWrtMO/1hZ/o86Hyus1zQo+xeKnPuBEenuj+vizXnyo=;
        b=Fd8f2xqwe8CffgpEPZExxmaHKeF5nfS4WUsnkdQaI22HVX5CZOKQWY54gCJPJ55VNm
         Zifr8zHOe5h/4lqXGc7irYk9W78Y+FnCvsfHs5tvkFJ/+M+H4+V4o02NIXY4yGA794KM
         945PbY31gRV6hBvZ8MF7p2Bu0ve4fKwQYs51BlZbhXf4NhDIr/dyq7GeS0jLHqLoI9Cg
         w0gfjISXV0sI0da9VWcEApekbUABZtyGbM7kVPw7BtsnoYkQUJ4lkxGwqJtuZdM/47f1
         FnHS4waC7djBK6Rxt+YAtjQOdJ3aCUcljAEbc89R9lniB9f8S64QIL2+T10v38bUBARF
         pFmw==
X-Gm-Message-State: APjAAAV5tteaKlQVcUx+C4AYzhLS9/vXi5hAYAHwnZrTkVRAs8aRIZ9q
        2HOXCIPSaFLrrdkYpR96vG+B7Uf8uyapP0jk9FWtOQ==
X-Google-Smtp-Source: APXvYqw7QpmXVqKEg5vShGZiPGspkFNybObjpkFqQvNP5oupXedhZJ240Iitpdpp2r68VTNCQn/h86Bi/pJJmifkXTE=
X-Received: by 2002:a92:5ad1:: with SMTP id b78mr7934ilg.118.1569449449584;
 Wed, 25 Sep 2019 15:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190925213721.21245-1-bigeasy@linutronix.de> <20190925213721.21245-3-bigeasy@linutronix.de>
In-Reply-To: <20190925213721.21245-3-bigeasy@linutronix.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 25 Sep 2019 15:10:38 -0700
Message-ID: <CALMp9eSc__WyxA9Zswt8pNYJ6vSiWBV+itLvcW--q=yWRfZe-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Expose CLZERO and XSAVEERPTR to the guest
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 2:37 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I was surprised to see that the guest reported `fxsave_leak' while the
> host did not. After digging deeper I noticed that the bits are simply
> masked out during enumeration.
> The XSAVEERPTR feature is actually a bug fix on AMD which means the
> kernel can disable a workaround.
> While here, I've seen that CLZERO is also masked out. This opcode is
> unprivilged so exposing it to the guest should not make any difference.
>
> Pass CLZERO and XSAVEERPTR to the guest if available on the host.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kvm/cpuid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 22c2720cd948e..0ae9194d0f4d2 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -473,6 +473,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>
>         /* cpuid 0x80000008.ebx */
>         const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> +               F(CLZERO) | F(XSAVEERPTR) |
>                 F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
>                 F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
>
> --
> 2.23.0

Didn't someone just post "[PATCH] kvm: x86: Enumerate support for
CLZERO instruction" yesterday? :-)
