Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71522C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE92073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewK0fUbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLJKWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:22:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575973367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hYi5eS0bvVMUP0KaJ0gTC9c1AaBzYooRd9sn22yfd4=;
        b=ewK0fUbZvpHu/jgruzmOaPS7wTHazTex4gGRakUhxzHWNmd212VQymljvhD5/6Q7g8+A1E
        BT7zswWpwhzRDqM5SCqdD5SjMOFIlXIdoElxZguGuyy0pvjT0x1SUmdYDVf9D6WL2QQtsD
        KAvtSkGkofVeULn1ys0ZXck2Zcc5D28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-EoFzPUU3OzWiPdHK-QA7uA-1; Tue, 10 Dec 2019 05:22:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so8720537wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hYi5eS0bvVMUP0KaJ0gTC9c1AaBzYooRd9sn22yfd4=;
        b=jKTO++4xiA4rIQhJe6FyUUzAa4WJjuB5W44Ifsargy0UiQe1soGnokUK0zC1tI9Q6N
         tXXEyHOQ5c9egQqSOLQO7bg1xz9Yh2zVDWaDGkh3jsdUoq3eKtsV2Q/g29/uKHWoKN39
         NcBO+DMUyM1sYK3mpG3nto9vxpPAkOSj0MAfBl10n6oeUF2WkS/Igz2upGImniHtEd4o
         ITYr7RnrNytWFFX+MQEuPFS2/1gjHLD3O7TGY3CAzJw9KYEsRXt01cowGXsO5m1Wy1TY
         ZCXvZKS50SH1OLGWffUp3a6CKy+4JlPf5hbAXUnwzUNAyPG1r23T9UQKAIdljDhC0byi
         uJBQ==
X-Gm-Message-State: APjAAAWDxNLH8rELdKd9DChEe4nq3Tlbi8jNSOOB4L8JofvmvosVNCFq
        CC0NNW8ISd2ZxgJMRptu+22YInBQG0aQmnqvY+ThecqcVtP9BnwtNWbm+9vtwIDpdnOj2sOf8PY
        G8ZMnGfsYCUXAUznsqtCrGdiO
X-Received: by 2002:adf:ec83:: with SMTP id z3mr2272237wrn.133.1575973365550;
        Tue, 10 Dec 2019 02:22:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBitfZdf/RJEPq1dZzPfkb453HjvEVJ0+/v+Z4WoHLXSV9FfeJBqhYpzRlJBzCwH1tt+vBvw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr2272216wrn.133.1575973365287;
        Tue, 10 Dec 2019 02:22:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id n3sm2520674wmc.27.2019.12.10.02.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:22:44 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86: Skip zeroing of MPX state on reset event
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191209201932.14259-1-sean.j.christopherson@intel.com>
 <20191209201932.14259-3-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c0589c5-f7c5-604c-3090-56dc886cb817@redhat.com>
Date:   Tue, 10 Dec 2019 11:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191209201932.14259-3-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: EoFzPUU3OzWiPdHK-QA7uA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/19 21:19, Sean Christopherson wrote:
> Don't bother zeroing out MPX state in the guest's FPU on a reset event,
> the guest's FPU is always zero allocated and there is no path between
> kvm_arch_vcpu_create() and kvm_arch_vcpu_setup() that can lead to guest
> MPX state being modified.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Makes sense, but it's a bit weird to have INIT reset _less_ state than
RESET...  I've queued patch 1 only for now.

Paolo

> ---
>  arch/x86/kvm/x86.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 854ae27bb021..e6f4174f55cd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9194,15 +9194,14 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  	kvm_async_pf_hash_reset(vcpu);
>  	vcpu->arch.apf.halted = false;
>  
> -	if (kvm_mpx_supported()) {
> +	if (kvm_mpx_supported() && init_event) {
>  		void *mpx_state_buffer;
>  
>  		/*
> -		 * To avoid have the INIT path from kvm_apic_has_events() that be
> -		 * called with loaded FPU and does not let userspace fix the state.
> +		 * Temporarily flush the guest's FPU to memory so that zeroing
> +		 * out the MPX areas is done using up-to-date state.
>  		 */
> -		if (init_event)
> -			kvm_put_guest_fpu(vcpu);
> +		kvm_put_guest_fpu(vcpu);
>  		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
>  					XFEATURE_BNDREGS);
>  		if (mpx_state_buffer)
> @@ -9211,8 +9210,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  					XFEATURE_BNDCSR);
>  		if (mpx_state_buffer)
>  			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
> -		if (init_event)
> -			kvm_load_guest_fpu(vcpu);
> +		kvm_load_guest_fpu(vcpu);
>  	}
>  
>  	if (!init_event) {
> 

