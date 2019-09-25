Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D725C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABF9208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWA7771D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfIYWO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:14:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35589 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfIYWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:14:58 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so1139863iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oN2m4++0LKr6bYfqCXcWdRY1alpvZSl28bU6nXFdaRo=;
        b=nWA7771D16q31tdoOAptSyiO4fw0bxdwPLiA2aW6WNm3y555sp4lMyWdhpn9DseJj9
         i7Mbuaps/im/Hp+Ofs3yiga+jYR/tbxF6JcMY3sOrnEUhJo1xFG2V3napIb1eoZEKcld
         yg8/C2yxtiYdAt+rRo4p2hkf5998b2pRB8LEyzPJU6pJhU/FcqyKH/+9LuKysD9QzE+p
         gyvW5pZHdtMHEavMaAAyEofiCYpeClJivd7cbJWj3EmHAfcGyllwAD+sky5NkZADi/Oe
         A4ne8r4ANNVH/68nshgcxglgxbXckv5QUdH3ZEVslFfuH+SdkCON1s1QEO3axn3y52kC
         jhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oN2m4++0LKr6bYfqCXcWdRY1alpvZSl28bU6nXFdaRo=;
        b=IbO/eogtsZKjlrGtvpsChp3jYtSOcPc8WbtJG2UDwtaCiVx5waVwuOsmJxNbusHIvi
         oVt5TzsYCJCl+YZo7X6kUnxIGxPCPi5L+GI/vUcdOdNpN+yy0tvd+Q4WyfVOxrgfnCPg
         Ql3mhU33dbrH6C6TAXNBVOjJQZqwJzb2Pb/B/3qegB6mfTI+TAzlvF4AyNie7KxMgbY/
         r7xV+e08mwoItAYJ4F05Pdgbbe9ZI/F27uiKwkYTmlqNr1alfIVtIUtXAsgq8H5Ki2R3
         y+9NQwyooPiNQmcYrUNPKOUSK5vuzGK+ThsblgvxQzT0iDOFOXhus6uZw08FdqNqh7dj
         Lemg==
X-Gm-Message-State: APjAAAUx0nJo5IQlJVJPHwYOXQ7wxsZFdg1qPg7LxyhC0zhJVexg//U9
        Dyw30FMLcVv0Rwe9hL/PMfa9CXt/IVxyGEUQSvVsxw==
X-Google-Smtp-Source: APXvYqwnzPkSsiUbT68TdAM7/Fq82PmpQ5Z0A/CfGt1w6IWIPokbXcJ9ji5UArTZ6/VDdNS3FrcxTS4scZPUkGpDCyo=
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr238446iog.119.1569449697712;
 Wed, 25 Sep 2019 15:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190925213721.21245-1-bigeasy@linutronix.de> <20190925213721.21245-2-bigeasy@linutronix.de>
In-Reply-To: <20190925213721.21245-2-bigeasy@linutronix.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 25 Sep 2019 15:14:46 -0700
Message-ID: <CALMp9eTbaoCh=izdFHGEnX2-mBKZaWJ_Bkg3b53csVQgs+XmuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: svm: Pass XSAVES to guest if available on host
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
> In commit
>    55412b2eda2b7 ("kvm: x86: Add kvm_x86_ops hook that enables XSAVES for guest")
>
> XSAVES was enabled on VMX with a few additional tweaks and was always
> disabled on SVM. Before ZEN XSAVES was not available so it made no
> difference. With Zen it is possible to expose it to the guest if it is
> available on the host.
> I didn't find anything close to VMX's "VM-Execution Controls" and
> exposing this flag based on the CPUID flags cause no harm so far.
>
> Expose the XSAVES flag to the guest if the host supports it.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kvm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index e0368076a1ef9..3878eb766fa39 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5992,7 +5992,7 @@ static bool svm_mpx_supported(void)
>
>  static bool svm_xsaves_supported(void)
>  {
> -       return false;
> +       return boot_cpu_has(X86_FEATURE_XSAVES);
>  }
>
>  static bool svm_umip_emulated(void)
> --
> 2.23.0

This is inadequate. Please read the existing thread, "[Patch] KVM:
SVM: Fix svm_xsaves_supported." Aaron Lewis is working on completing
this as we speak.
