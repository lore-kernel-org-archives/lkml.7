Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60381C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906AE20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjNF2Q27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAHRrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:47:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728955AbgAHRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578505659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPVctA+/beiB2tgYujpzj4QWpCakHQu/CLjfG7f6imE=;
        b=YjNF2Q271RqEeKFA9rSopFg51fkU9R4qR/HpDYRn74y//OgfnfhavPhKxlvomG8WFqDXR8
        7MEnyQrpZG+E+unrZ7yS7ev2e1D4c1hhy6B4mO8btgtnlMGDdzk3ip3E/8lFnJ0ejL7WYK
        ShLefnc7S+kxt/oJU/lG1p7npkd9X+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-1VVaDlJjNky3r6FcoqzIYQ-1; Wed, 08 Jan 2020 12:47:38 -0500
X-MC-Unique: 1VVaDlJjNky3r6FcoqzIYQ-1
Received: by mail-wm1-f71.google.com with SMTP id w205so1109391wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPVctA+/beiB2tgYujpzj4QWpCakHQu/CLjfG7f6imE=;
        b=cDdeKmNZD0gt4QPPRsTLIOytAewkXoXvFUKgpP20H7x+G7jg7KFjfbkyHvYPZwjfOA
         7bl4+xD3R3EBGEg798Z+1vcW1U+3V0/xui+OeyH2XMNbNJUF+xTALhvRSMah6K1U9Hs4
         0DEb3B3B+XJU+ayxy26P1ZMcV3AM32/D/cRyesu29l1STvrdg2n1DpibYGHyF4g5MOIY
         XSlFb/l40ojRQP4Kl1RAfnaGgCUhsVFxE42HWIaQtEwgNhh3/PO7/XBYUC4A1e5QAsxf
         ZLv7NoIswK4vhlA989syHsmqyUg4ex4ALBJFabj6mRHYP76AvKq+FL2XllrGZC2msjUg
         Q6bQ==
X-Gm-Message-State: APjAAAWFRK033+ES6HXNmbzn+7osSZKL5z6kKdKTd5Y4AkfKlNlce7Zw
        62JU28sofqyvg3Bl/5R+LUX+pouNAtwCulMe7j8wZbZ+kWJ/BAny9302hz/yGa2OQ/oONnWkPpX
        VsaX8ax2m6pF/xumNcp7/ydeT
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr5114639wmc.161.1578505656808;
        Wed, 08 Jan 2020 09:47:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwK4smqOHHZ61RcHhcQZCij9FjfLEL0lRlGmAMs4ej7ug5KpPtW7nqSUmqikVekUsUPp0OLAg==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr5114613wmc.161.1578505656566;
        Wed, 08 Jan 2020 09:47:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id j12sm5358156wrw.54.2020.01.08.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:47:35 -0800 (PST)
Subject: Re: [PATCH RESEND v2 06/17] KVM: Pass in kvm pointer into
 mark_page_dirty_in_slot()
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-7-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d784ead-44f8-8ebc-6192-be1b4eec6ff8@redhat.com>
Date:   Wed, 8 Jan 2020 18:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191221014938.58831-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/19 02:49, Peter Xu wrote:
> The context will be needed to implement the kvm dirty ring.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c80a363831ae..17969cf110dd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -144,7 +144,9 @@ static void hardware_disable_all(void);
>  
>  static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
>  
> -static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
> +static void mark_page_dirty_in_slot(struct kvm *kvm,
> +				    struct kvm_memory_slot *memslot,
> +				    gfn_t gfn);
>  
>  __visible bool kvm_rebooting;
>  EXPORT_SYMBOL_GPL(kvm_rebooting);
> @@ -2053,8 +2055,9 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
>  
> -static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
> -			          const void *data, int offset, int len,
> +static int __kvm_write_guest_page(struct kvm *kvm,
> +				  struct kvm_memory_slot *memslot, gfn_t gfn,
> +				  const void *data, int offset, int len,
>  				  bool track_dirty)
>  {
>  	int r;
> @@ -2067,7 +2070,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
>  	if (r)
>  		return -EFAULT;
>  	if (track_dirty)
> -		mark_page_dirty_in_slot(memslot, gfn);
> +		mark_page_dirty_in_slot(kvm, memslot, gfn);
>  	return 0;
>  }
>  
> @@ -2077,7 +2080,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
>  {
>  	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>  
> -	return __kvm_write_guest_page(slot, gfn, data, offset, len,
> +	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len,
>  				      track_dirty);
>  }
>  EXPORT_SYMBOL_GPL(kvm_write_guest_page);
> @@ -2087,7 +2090,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
>  {
>  	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
>  
> -	return __kvm_write_guest_page(slot, gfn, data, offset,
> +	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset,
>  				      len, true);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
> @@ -2202,7 +2205,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
>  	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
>  	if (r)
>  		return -EFAULT;
> -	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
> +	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
>  
>  	return 0;
>  }
> @@ -2269,7 +2272,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
>  }
>  EXPORT_SYMBOL_GPL(kvm_clear_guest);
>  
> -static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
> +static void mark_page_dirty_in_slot(struct kvm *kvm,
> +				    struct kvm_memory_slot *memslot,
>  				    gfn_t gfn)
>  {
>  	if (memslot && memslot->dirty_bitmap) {
> @@ -2284,7 +2288,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
>  	struct kvm_memory_slot *memslot;
>  
>  	memslot = gfn_to_memslot(kvm, gfn);
> -	mark_page_dirty_in_slot(memslot, gfn);
> +	mark_page_dirty_in_slot(kvm, memslot, gfn);
>  }
>  EXPORT_SYMBOL_GPL(mark_page_dirty);
>  
> @@ -2293,7 +2297,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
>  	struct kvm_memory_slot *memslot;
>  
>  	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> -	mark_page_dirty_in_slot(memslot, gfn);
> +	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

