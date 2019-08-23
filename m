Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD25C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726DE233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfHWJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfHWJPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:15:21 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76DCBC054C52
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:15:21 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a2so4533488wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Fogl+Xs+eEecVqlA/+UJZO2WdJiNWt+Dkg9XFhlgz2U=;
        b=FywVFYnFUes2gkk0clwRiD4teDnbfLzBibTaZNsdRSTytM7+wc9Pw3e+mZzpvC9c0X
         jmC1bBgG2qRY08ZWx4TrdyW7EsYqzg/lbc5q1rin+A6J2lGNEyZ+yvLqe9oUsIUU68kI
         ZX+wmFxTXXeWUqq8aJzcYyrRi/zsGcNz1/cuNRDTcoNfdTKiLgt6f22pntWmYag2qS2Q
         cxYcSJaKcereGILjYVkLSuaTLnJ4SMNjxdULXpf/m+MaicmsHLrhrX6QtnzZtO2Ia5HU
         GGzGmVcgKBDWAtmngK4Q/ikiTg4tAgJZdypTJzv9Xey0itDqWNxbaF7ydVoC0+0Lhrbq
         6UEg==
X-Gm-Message-State: APjAAAWwghxgn8dU3qHk2e4adZ4r9Hnkk7xKOiLgyQNNZjOVLXg/WizH
        z/ufldAQ1sD8kVoD9PO/p85YAbqD20DQEXRbWbmAiQV43gHNj6HQrp0Mt30o4ytgTibvNQWB9Fs
        em6pZmTQtQRAYLpvdwA638gKt
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr3492103wrm.295.1566551720231;
        Fri, 23 Aug 2019 02:15:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCFMlFThRSbr0p2bFyKMbVO+GhKtybrGNQbyE4KaJLTqw6rB3fsEgDC8WW2wselB1EwGJhig==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr3492071wrm.295.1566551719960;
        Fri, 23 Aug 2019 02:15:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a142sm3258237wme.2.2019.08.23.02.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 02:15:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [RESEND PATCH 01/13] KVM: x86: Relocate MMIO exit stats counting
In-Reply-To: <20190823010709.24879-2-sean.j.christopherson@intel.com>
References: <20190823010709.24879-1-sean.j.christopherson@intel.com> <20190823010709.24879-2-sean.j.christopherson@intel.com>
Date:   Fri, 23 Aug 2019 11:15:18 +0200
Message-ID: <87d0gwp7ix.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the stat.mmio_exits update into x86_emulate_instruction().  This is
> both a bug fix, e.g. the current update flows will incorrectly increment
> mmio_exits on emulation failure, and a preparatory change to set the
> stage for eliminating EMULATE_DONE and company.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

This, however, makes me wonder why this is handled in x86-specific code
in the first place, can we just count KVM_EXIT_MMIO exits when handling
KVM_RUN?

> ---
>  arch/x86/kvm/mmu.c     | 2 --
>  arch/x86/kvm/vmx/vmx.c | 1 -
>  arch/x86/kvm/x86.c     | 2 ++
>  3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 4c45ff0cfbd0..845e39d8a970 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -5437,8 +5437,6 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
>  	case EMULATE_DONE:
>  		return 1;
>  	case EMULATE_USER_EXIT:
> -		++vcpu->stat.mmio_exits;
> -		/* fall through */
>  	case EMULATE_FAIL:
>  		return 0;
>  	default:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 570a233e272b..18286e5b5983 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5200,7 +5200,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
>  		err = kvm_emulate_instruction(vcpu, 0);
>  
>  		if (err == EMULATE_USER_EXIT) {
> -			++vcpu->stat.mmio_exits;
>  			ret = 0;
>  			goto out;
>  		}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b4cfd786d0b6..cd425f54096a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6598,6 +6598,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
>  		}
>  		r = EMULATE_USER_EXIT;
>  	} else if (vcpu->mmio_needed) {
> +		++vcpu->stat.mmio_exits;
> +
>  		if (!vcpu->mmio_is_write)
>  			writeback = false;
>  		r = EMULATE_USER_EXIT;

-- 
Vitaly
