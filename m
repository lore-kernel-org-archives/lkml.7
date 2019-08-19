Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE48C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE63206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfHSPmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfHSPmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:42:11 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B34B5811A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:42:10 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id u13so333565wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zVYBxHNdylCUSC38C870FwmXf/G6m4riNwalhyYgVkY=;
        b=ppJHqZQaKQxtIrQGMV6AP1rlarky/NbpR1ce6RWs5UKwLXoPZnTsNv8zo0Qn/7UNAq
         3WDFn05vmZbsaHm4DfstquhPyuFkl4tPhB8W6CqGnFbAtt+1FYAQjcTK53xVP0L7PoPX
         oUBY0KkXwQS382fhsKzjkBd0fPigmVWqDDH2OXxZgkQESr7QnW5jVvRH0gNlxV3ORwVT
         IYa2tKXSHjiS9oifJ1kvyL0hTBUvoUvKwJbC2jGAXaTpIqPD4Y/Fi+CdP3pFnztjwsqt
         emjosLCn4JbaEW2X8v4SynQ3i5pcNRZYa0bdhkO+EpvC1NWIR6bauWdM3Yk+J3qIoKKw
         80kw==
X-Gm-Message-State: APjAAAVkvtgcmvGIPvkKVRkaDaPe9r3r7zatSyUcf350odHI+M7+Xq/L
        BjIxX9safFP7bVfapY+oF7bcS1QYXt3O6gavA1eKbREVrJPu5Owy58V7ygQLpDvqmI7RSKAnttY
        4ZcTenRVkrfWvab8WHvc0/im0
X-Received: by 2002:a5d:4644:: with SMTP id j4mr27828238wrs.146.1566229329225;
        Mon, 19 Aug 2019 08:42:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwNhD0DHO6CIBYcODwc0WTpH84mqMLWJzGDbNyGGTpZ00maIx5eJhNRY9qRsDRnuD7FOEQvoA==
X-Received: by 2002:a5d:4644:: with SMTP id j4mr27828209wrs.146.1566229328952;
        Mon, 19 Aug 2019 08:42:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id j9sm15758601wrx.66.2019.08.19.08.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:42:08 -0700 (PDT)
Subject: Re: [PATCH] KVM: Assert that struct kvm_vcpu is always as offset zero
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190815172237.10464-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <51adb35e-8297-1992-726e-a8e9f4953932@redhat.com>
Date:   Mon, 19 Aug 2019 17:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815172237.10464-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 19:22, Sean Christopherson wrote:
> KVM implementations that wrap struct kvm_vcpu with a vendor specific
> struct, e.g. struct vcpu_vmx, must place the vcpu member at offset 0,
> otherwise the usercopy region intended to encompass struct kvm_vcpu_arch
> will instead overlap random chunks of the vendor specific struct.
> E.g. padding a large number of bytes before struct kvm_vcpu triggers
> a usercopy warn when running with CONFIG_HARDENED_USERCOPY=y.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Note, the PowerPC change is completely untested.
> 
>  arch/powerpc/kvm/e500.c | 3 +++
>  arch/x86/kvm/svm.c      | 3 +++
>  arch/x86/kvm/vmx/vmx.c  | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
> index b5a848a55504..00649ca5fa9a 100644
> --- a/arch/powerpc/kvm/e500.c
> +++ b/arch/powerpc/kvm/e500.c
> @@ -440,6 +440,9 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_e500(struct kvm *kvm,
>  	struct kvm_vcpu *vcpu;
>  	int err;
>  
> +	BUILD_BUG_ON_MSG(offsetof(struct kvmppc_vcpu_e500, vcpu) != 0,
> +		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
> +
>  	vcpu_e500 = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
>  	if (!vcpu_e500) {
>  		err = -ENOMEM;
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index d685491fce4d..70015ae5fc19 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2137,6 +2137,9 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm *kvm, unsigned int id)
>  	struct page *nested_msrpm_pages;
>  	int err;
>  
> +	BUILD_BUG_ON_MSG(offsetof(struct vcpu_svm, vcpu) != 0,
> +		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
> +
>  	svm = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
>  	if (!svm) {
>  		err = -ENOMEM;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 42ed3faa6af8..402cf2fe5cdd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6615,6 +6615,9 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>  	unsigned long *msr_bitmap;
>  	int cpu;
>  
> +	BUILD_BUG_ON_MSG(offsetof(struct vcpu_vmx, vcpu) != 0,
> +		"struct kvm_vcpu must be at offset 0 for arch usercopy region");
> +
>  	vmx = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
>  	if (!vmx)
>  		return ERR_PTR(-ENOMEM);
> 

Queued, thanks.

Paolo
