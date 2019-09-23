Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB22C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6E8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439241AbfIWKTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfIWKTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:19:16 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C20FC054C52
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:19:15 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s19so2344070wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAyRQH3H07FmS67tnT6hsF/Qfh+8LuStTKrVaQ9zhw8=;
        b=FEBwvuAPI4vtSfsQTQ3mnf60V224XyisBHc6JOrxX1iGDYdGQFhV2dZWx7NE8SjVMS
         ECcokWXmxyMxE+lHIYjHzI10ZB1708eGm2crEgi8iiYVdl/ErV0+FgaOCtwBn18BWNmu
         vTHIWtE8zR3DRXSj0UJcoGtYJRtLoMJ1115gKOM/pwcZmfbvoofiKswFX+aGbkbQq/f1
         bDslgNFZ1Tv3TAHQGFQFtAD3Z1Kt134LHSEI0sQkKIE3ShjSAAGkZ0Q9leU/HJCr/uG/
         Xw+t5zSQS52wFK8hgCetV2yHhZyb5fXv8iKPQaL37NHUF3M/ROxOYyBm1gioReTSgVJc
         ++AA==
X-Gm-Message-State: APjAAAV6vIEC5wYjgDD9hFGaMMsPhTCozlW7kRD6EyyHUcOoDe+xJeRy
        8D3KweoyhScpcS5ru7AdVIa+2mITNW8UM7B4+QFx7176wpc9Y4lG9nqWe0ErlOoAGrUQSEAdYTY
        7UkVLRnBlByDuqX2ZX0iFJXc0
X-Received: by 2002:a5d:458b:: with SMTP id p11mr905177wrq.160.1569233953900;
        Mon, 23 Sep 2019 03:19:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmjLwnJ4DSwFegz6v4hMA/TVeGpRaJTbLpRqq1I+EuABUIXRx+oS++kj9174kVqcS9ORfEpQ==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr905161wrq.160.1569233953665;
        Mon, 23 Sep 2019 03:19:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id s9sm10669778wme.36.2019.09.23.03.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:19:13 -0700 (PDT)
Subject: Re: [PATCH 14/17] KVM: monolithic: x86: inline more exit handlers in
 vmx.c
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-15-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6a1d66a1-74c0-25b9-692f-8875e33b2fae@redhat.com>
Date:   Mon, 23 Sep 2019 12:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-15-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:25, Andrea Arcangeli wrote:
> They can be called directly more efficiently, so we can as well mark
> some of them inline in case gcc doesn't decide to inline them.

What is the output of size(1) before and after?

Paolo

> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index ff46008dc514..a6e597025011 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4588,7 +4588,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static int handle_external_interrupt(struct kvm_vcpu *vcpu)
> +static __always_inline int handle_external_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	++vcpu->stat.irq_exits;
>  	return 1;
> @@ -4860,7 +4860,7 @@ static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
>  	vmcs_writel(GUEST_DR7, val);
>  }
>  
> -static int handle_cpuid(struct kvm_vcpu *vcpu)
> +static __always_inline int handle_cpuid(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_emulate_cpuid(vcpu);
>  }
> @@ -4891,7 +4891,7 @@ static int handle_interrupt_window(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
>  
> -static int handle_halt(struct kvm_vcpu *vcpu)
> +static __always_inline int handle_halt(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_emulate_halt(vcpu);
>  }
> 

