Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E9C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE562084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfILIvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfILIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:51:50 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C4B95AFF8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 08:51:50 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id d10so2332644wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mx1kKrIiSmryWWn3Il/w12tQaldws+Bo5K0e/h/OmZw=;
        b=NjFIAfoqLKgaFc1WUriO/mT82EZxwAlPUFx7OOY3qvdHuS5jWOyU6+uVAJ5LIcXyHy
         bQgkQHWn1r8uBOypRmHKhib3QM1ndEUqBbu5VJpODcnRvql34HZfmQI6kw3AGQeqEe5Q
         xOCqoB6pgPspWYBV76Ot0Gnokm1bR20Th5PAKzc/HBz/p3PQm5S1gQhMhlQem8QCZ7iz
         C75V7/Cv3XL+LMJzbDzPDVrScsFBJZsYkhBoIsds/yqSRmmiUF0M3g9Fpfuh0PyE6535
         o99o9/yDkFvPk32AWyR1oisbaHUgdS2TEOvBnrD4myw8cYnByyf5+u50sE7QADFE/Mlz
         l81w==
X-Gm-Message-State: APjAAAUs0JU/38+nBv6m38M4GRSiJz820zFDeIZA5HSxyzQHYUPtlXqC
        DUrhbNUnLGs7gs53iGOqq2UVuHATgpBmSaGXS58EKIP7ATLMumLRWmsePFwXyVxhihbOJZwXi1Q
        VeZtYsO5JyoB7gsFwuKb4T9+0
X-Received: by 2002:adf:f44e:: with SMTP id f14mr32811308wrp.290.1568278308860;
        Thu, 12 Sep 2019 01:51:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZZE+RhkaLzAZJ36RWJxFit5DZtSqEtla93L8pUsJW8tO6EZdN+nW+/hJlyMkag7t70ajcQw==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr32811294wrp.290.1568278308638;
        Thu, 12 Sep 2019 01:51:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q3sm7850196wrm.86.2019.09.12.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 01:51:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH] KVM: x86: work around leak of uninitialized stack contents
In-Reply-To: <20190912041817.23984-1-huangfq.daxian@gmail.com>
References: <20190912041817.23984-1-huangfq.daxian@gmail.com>
Date:   Thu, 12 Sep 2019 10:51:47 +0200
Message-ID: <87tv9hew2k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuqian Huang <huangfq.daxian@gmail.com> writes:

> Emulation of VMPTRST can incorrectly inject a page fault
> when passed an operand that points to an MMIO address.
> The page fault will use uninitialized kernel stack memory
> as the CR2 and error code.
>
> The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
> exit to userspace;

Hm, why so? KVM_EXIT_INTERNAL_ERROR is basically an error in KVM, this
is not a proper reaction to a userspace-induced condition (or ever).

I also looked at VMPTRST's description in Intel's manual and I can't
find and explicit limitation like "this must be normal memory". We're
just supposed to inject #PF "If a page fault occurs in accessing the
memory destination operand."

In case it seems to be too cumbersome to handle VMPTRST to MMIO and we
think that nobody should be doing that I'd rather prefer injecting #GP.

Please tell me what I'm missing :-)

>  however, it is not an easy fix, so for now just ensure
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
>  	/* kvm_write_guest_virt_system can pull in tons of pages. */
>  	vcpu->arch.l1tf_flush_l1d = true;
>  
> +	memset(exception, 0, sizeof(*exception));
>  	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
>  					   PFERR_WRITE_MASK, exception);
>  }

-- 
Vitaly
