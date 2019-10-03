Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1703C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF36B222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfJCKOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCKOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:14:36 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AB658665A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2019 10:14:36 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so905102wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ia+gGf8D4RKqD3mYHNJW4KBxV39P1F98Z1sPmxgCPUE=;
        b=dFBnO5imJsSEz675kmxuuTWRZrgxtgcEUdn2dGRYAw0EdX87YVKHNN+qnDnsv6nSvM
         wXIneTZyLT/6Hd5qPJyKUOlNrS/T/xssYqiapilaudC+2WiiAfg8kbjFeDiaIHtbFu20
         TxVwDPtXKRc4LU/xyhfciOsV9jHaPA1cN/Xw5dije6aMifBjK/uYRMa4KfVAPJ0ooyEV
         tzXDdwG6382gtDsAtLq3JEWpnarJKwZvwR+2y5ws943oVpFfS9xKA+1nYDQKuZMF8xEA
         cjgVxEXeNwQTAdar0F3YIS8cyQSgSCQkjD1Nbl/kqj/zhvcvoGykH3JE0zvUWwz42e2b
         Mxhg==
X-Gm-Message-State: APjAAAWKeey/aMNZrmlqmLhY63AH1sXqCXYAzfceRBAksD6Coq9cckr/
        MVv9/nsBn3uUSP5F+fWR8Oyur4cc4FBCHajiTAUNv+sYJ+5zp2XzBh3L+AbKP9jEgRgNycvJsbJ
        3KvWRhp6EyZSgvJno2boKCqOk
X-Received: by 2002:adf:fa86:: with SMTP id h6mr6381154wrr.152.1570097674773;
        Thu, 03 Oct 2019 03:14:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxiL1KyYf7AH8ZuOpHEBO+Sv2DSfWFZnG8bjX9o9BKUHcZpAC6YIg7sjWK9r+jlV/CkD8mV7w==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr6381135wrr.152.1570097674523;
        Thu, 03 Oct 2019 03:14:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464? ([2001:b07:6468:f312:b903:6d6f:a447:e464])
        by smtp.gmail.com with ESMTPSA id n8sm2851784wma.7.2019.10.03.03.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 03:14:33 -0700 (PDT)
Subject: Re: [PATCH tip/core/rcu 2/9] x86/kvm/pmu: Replace
 rcu_swap_protected() with rcu_replace()
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <20191003014310.13262-2-paulmck@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dd735e5f-c326-4b53-1126-98c5e38961d3@redhat.com>
Date:   Thu, 3 Oct 2019 12:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003014310.13262-2-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 03:43, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit replaces the use of rcu_swap_protected() with the more
> intuitively appealing rcu_replace() as a step towards removing
> rcu_swap_protected().
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <kvm@vger.kernel.org>
> ---
>  arch/x86/kvm/pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 46875bb..4c37266 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -416,8 +416,8 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
>  	*filter = tmp;
>  
>  	mutex_lock(&kvm->lock);
> -	rcu_swap_protected(kvm->arch.pmu_event_filter, filter,
> -			   mutex_is_locked(&kvm->lock));
> +	filter = rcu_replace(kvm->arch.pmu_event_filter, filter,
> +			     mutex_is_locked(&kvm->lock));
>  	mutex_unlock(&kvm->lock);
>  
>  	synchronize_srcu_expedited(&kvm->srcu);
> 

Should go without saying, but

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
