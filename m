Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B3C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE2320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw8fCsBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgAHRrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:47:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28338 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgAHRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578505643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAa69owWCpVJkLCmnm+u7z+Vy9Ti9WLM44pgY0D4sxY=;
        b=Nw8fCsBRcaREIOOzYxJ2KrVBhoKXtbxqC4jxQPSxvd7qLMOv0srlHPV74pCRm4+fydtKoU
        VQ8TAqKudP9eXry69Pa8YnUIfTab6ZpBh83ASSL3huDX1Of0qsWvRifQHc0lNX1olshK8T
        QMAXbMW4A/Ys3YGzlBOCAdAm9AyrAvo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-D3-eLUosNBGb-gZpyjkOcw-1; Wed, 08 Jan 2020 12:47:20 -0500
X-MC-Unique: D3-eLUosNBGb-gZpyjkOcw-1
Received: by mail-wr1-f69.google.com with SMTP id j13so1711144wrr.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bAa69owWCpVJkLCmnm+u7z+Vy9Ti9WLM44pgY0D4sxY=;
        b=VIzXuFU/lzZyAYVuETRxxnETc2ZxkxPWGcx97utSatkeRTUJzykn6BMnKx0vYXzZbx
         DP0FEQ1wQOhDIkBsOkn8lZ4iYfhdvoKTTuXzKcu8XX3Zc4u57sl7MW4fzSYNUQyZtHrV
         8Qck6ACDdYRYBuakDLMgbpguyTLTmG60qgQ80ERIOF5hj1qxXWDm9h15kKo+/t/7NWk4
         mQXXTMB8gXXMMP4Y96Gq0j77IKpCiTojV8HFU8s+t8YJeccsldydWDew4ZxkJ+T6jO7L
         9iXFB66N+Kt3AXcnZ6a3A/cegzt4cRvb+IAIlchhjKEO2GpqDc/gylL+kLmdAxDrs27e
         o60g==
X-Gm-Message-State: APjAAAXVczqD4JA5DNNCS8NaSJrMalAut1bHo/A4H6CGMQ80/5U3MKsO
        2n8g190eAjqPZ5VeVP/n/XuL2d4cTVewpDxyFhymSYy5YhoTX7gZqmmTFtjpjVsBgj7Nd2HrkEG
        AvEyIz0ktoysPJI1w9XzuytsP
X-Received: by 2002:a5d:484f:: with SMTP id n15mr6012216wrs.365.1578505639299;
        Wed, 08 Jan 2020 09:47:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUmk3FDfXBZY3A8HYnfBqzfD0M+CFw9a/XaX+37Y+I7ptfdXLeU0/jbrqR4VO05Zhdfc3tqw==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr6012188wrs.365.1578505639104;
        Wed, 08 Jan 2020 09:47:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id s15sm5090309wrp.4.2020.01.08.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:47:18 -0800 (PST)
Subject: Re: [PATCH RESEND v2 04/17] KVM: Cache as_id in kvm_memory_slot
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-5-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c60668e-1d60-5ab7-8524-54cc970d496d@redhat.com>
Date:   Wed, 8 Jan 2020 18:47:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191221014938.58831-5-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/19 02:49, Peter Xu wrote:
> Let's cache the address space ID just like the slot ID.

Please add a not that it will be useful in order to fill in the dirty
page ring buffer.

Paolo

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/kvm_host.h | 1 +
>  virt/kvm/kvm_main.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4e34cf97ca90..24854c9e3717 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -348,6 +348,7 @@ struct kvm_memory_slot {
>  	unsigned long userspace_addr;
>  	u32 flags;
>  	short id;
> +	u8 as_id;
>  };
>  
>  static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b1047173d78e..cea4b8dd4ac9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1027,6 +1027,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  
>  	new = old = *slot;
>  
> +	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
> +	new.as_id = as_id;
>  	new.id = id;
>  	new.base_gfn = base_gfn;
>  	new.npages = npages;
> 

