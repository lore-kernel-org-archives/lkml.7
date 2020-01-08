Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED1C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F220643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kqu/Dp9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgAHRqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:46:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28438 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726411AbgAHRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578505566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L4VZx0As0ZHiXTxgHXESIjy6Uh0rww0LXaVy0vAdM7A=;
        b=Kqu/Dp9InwVshsSfyNovVm8ouDElcppFYGvQmkrOSbjKx3DID20ltlp66DAwjAU9tQdKE4
        FBrEJJ5pN1bDdwdj+l9qW7QDM5tLQrqXTIvHO610gu4BCoIzfjScNQEyhS3kU1b2+njofM
        cLrXJxNa/FAbz+t5xp1DHoWr54ZR22U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-6RINwJ4mPteKg-v25hf6PQ-1; Wed, 08 Jan 2020 12:46:03 -0500
X-MC-Unique: 6RINwJ4mPteKg-v25hf6PQ-1
Received: by mail-wm1-f72.google.com with SMTP id h130so1105400wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L4VZx0As0ZHiXTxgHXESIjy6Uh0rww0LXaVy0vAdM7A=;
        b=Ptj0w34aYPK1WFSif9VmvSChUgfARCv6EKAGtJ9VJ6PaR2WF5GGqwO4wrzgisrOxvf
         7bPRB+IzQuj5dK0ItNRHDbQLa6l5Vxw5gTh3Lisow8QVwWhgu45UGEoYH1HF+kogJbgz
         WF/2P/dqQpdH16PiUsclLqEJ3oH3zqFnyOndzUdYsqcBv/qchxVOkqSl7LhhOGPtHFDx
         dQqDFZvZ4jW82EfgZ7W41Px7NJkZw8Gqs/L9uVE4zAyboaI7hlwJxbQxULAlul/7uaAY
         2MXvYlfgtEAVgapkR8x/8M22178C4Q8PJXH+dzGB12wA/cRMHs/G1bE1SuTKFU8d6hYE
         vsIg==
X-Gm-Message-State: APjAAAWDfyBbMPiffMZ3mOo/SKlutQTpwzR3QDsCUOnyqJL8KJkxzF3K
        HGPHuEmFM4dYD4jVdf3EdCio1ElsSFLbr8bb4vvwa94aaXAWPuUlrwSRi/IunC9EBc+pc7g+CTJ
        9IgtXCkVblTo7kawju4YUfocE
X-Received: by 2002:adf:81c2:: with SMTP id 60mr5796482wra.8.1578505562629;
        Wed, 08 Jan 2020 09:46:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUDnQgu7gDBsXLItppqiWGQNzHgByvlYXbyrUB8070jJES4YdmovQ+cTSX6O4KilpgStcP2g==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr5796460wra.8.1578505562427;
        Wed, 08 Jan 2020 09:46:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id p17sm5063893wrx.20.2020.01.08.09.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:46:01 -0800 (PST)
Subject: Re: [PATCH RESEND v2 02/17] KVM: X86: Change parameter for
 fast_page_fault tracepoint
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-3-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9eae2e6e-b767-0471-b913-ea6c3ad00ae8@redhat.com>
Date:   Wed, 8 Jan 2020 18:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191221014938.58831-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/19 02:49, Peter Xu wrote:
> It would be clearer to dump the return value to know easily on whether
> did we go through the fast path for handling current page fault.
> Remove the old two last parameters because after all the old/new sptes
> were dumped in the same line.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/mmutrace.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmutrace.h
> index 7ca8831c7d1a..09bdc5c91650 100644
> --- a/arch/x86/kvm/mmutrace.h
> +++ b/arch/x86/kvm/mmutrace.h
> @@ -244,9 +244,6 @@ TRACE_EVENT(
>  		  __entry->access)
>  );
>  
> -#define __spte_satisfied(__spte)				\
> -	(__entry->retry && is_writable_pte(__entry->__spte))
> -
>  TRACE_EVENT(
>  	fast_page_fault,
>  	TP_PROTO(struct kvm_vcpu *vcpu, gva_t gva, u32 error_code,
> @@ -274,12 +271,10 @@ TRACE_EVENT(
>  	),
>  
>  	TP_printk("vcpu %d gva %lx error_code %s sptep %p old %#llx"
> -		  " new %llx spurious %d fixed %d", __entry->vcpu_id,
> +		  " new %llx ret %d", __entry->vcpu_id,
>  		  __entry->gva, __print_flags(__entry->error_code, "|",
>  		  kvm_mmu_trace_pferr_flags), __entry->sptep,
> -		  __entry->old_spte, __entry->new_spte,
> -		  __spte_satisfied(old_spte), __spte_satisfied(new_spte)
> -	)
> +		  __entry->old_spte, __entry->new_spte, __entry->retry)
>  );
>  
>  TRACE_EVENT(
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

