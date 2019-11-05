Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55487FC6197
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A5C2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfKEKEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:04:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbfKEKET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:04:19 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CF6CC054C58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:04:19 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f2so7451198wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lrDn3WRTg+rwGOnenXl0j0b2dvVQo5Nmi58gDUT8LNE=;
        b=MvBadvBXOoeN1TXzuEHho+dcuPi6wtjrmrFngRgvSeOiwVrGzyH6cqwAfefQV+zv8S
         6EANWcntVeqoPbdOQw6vf/o1xFMxgnBnkS+gVi+YWUaHlq79h1MNKOEUnR/jGsDBc+WM
         WZ4BknANclcfWF4ridIEtfSpmQrakMIhqVwXcO0yFmAq15cwawwRMvX6xwNgwyV5hEG2
         eHu2Zkf5WM+GV0KleVOi8EjIbe6Ahvs7Bw98qfwJBfmjEZE4ov5Xff4OOAOcHJkT3bu6
         7Mc2edXLjPRH3ETLVLcK68nWt19NpsdLwUYAP4gsuGMg7Pfz2YABHMJ6gZuQBUIKuCpP
         MQow==
X-Gm-Message-State: APjAAAVBKfiIO4+BxfZfKCttZw1r8h1SloWYpdIvcMwTFJqNI5dIFmpn
        qXMw0GLoy3EghrY4RKm2yKPZEs5ajDzkvrUSmiWQCfI4cmtgeGOkK4sWHnMp5svuD04Lf5qRDfd
        nP0vAeqgo0dM22tRhRQIQa9ef
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr13486384wrx.261.1572948258200;
        Tue, 05 Nov 2019 02:04:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjNhFV5qF8IUjCi16O1NoaQu8sSVoDIfgxCmNd9O29UA3q2m/52eCf5DqgEb0rGOHyGFqzUg==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr13486352wrx.261.1572948257905;
        Tue, 05 Nov 2019 02:04:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4051:461:136e:3f74? ([2001:b07:6468:f312:4051:461:136e:3f74])
        by smtp.gmail.com with ESMTPSA id t24sm30988243wra.55.2019.11.05.02.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:04:17 -0800 (PST)
Subject: Re: [PATCH 03/13] kvm: monolithic: fixup x86-32 build
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-4-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ed4a5cd-38b1-04f8-e3d5-3327a1bd5d87@redhat.com>
Date:   Tue, 5 Nov 2019 11:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-4-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19 23:59, Andrea Arcangeli wrote:
> kvm_x86_set_hv_timer and kvm_x86_cancel_hv_timer needs to be defined
> to succeed the 32bit kernel build, but they can't be called.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bd17ad61f7e3..1a58ae38c8f2 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7195,6 +7195,17 @@ void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
>  {
>  	to_vmx(vcpu)->hv_deadline_tsc = -1;
>  }
> +#else
> +int kvm_x86_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
> +			 bool *expired)
> +{
> +	BUG();
> +}
> +
> +void kvm_x86_cancel_hv_timer(struct kvm_vcpu *vcpu)
> +{
> +	BUG();
> +}
>  #endif
>  
>  void kvm_x86_sched_in(struct kvm_vcpu *vcpu, int cpu)
> 

I'll check for how long this has been broken.  It may be the proof that
we can actually drop 32-bit KVM support.

Paolo
