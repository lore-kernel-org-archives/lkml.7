Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117A205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLsbC5cE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfLEKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:19:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729041AbfLEKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575541176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ln8ZUNvOPrVi4maH8Z61jrB9tpqjzLpExI55MiJBJ2w=;
        b=iLsbC5cE0A6FhwRuG9h0eV+HveaxcMxr6mxrhhvc2LWZivLwXT7VzR3r/RYCBKJXIEwLoD
        N9Dn7ror4DmEDVeyN9GD7ew1NKj7YGfzrfWKpWTMXK/wZfH1peq9nzCa7ULzirM6DfoZ3n
        g+6qRCt8f+z+1rcXOlczPSJCXJSbPoc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-mjGcqNRXPE6UFdONGmwsKQ-1; Thu, 05 Dec 2019 05:19:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so1297322wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ln8ZUNvOPrVi4maH8Z61jrB9tpqjzLpExI55MiJBJ2w=;
        b=dfr3nRdsYdP2GwTE41VJpgiTayy0KvENFTUoKHIdyZrJpV9Cl50JVtR8/laRwyn0NM
         eNR2067+RKmGuLX6/2ikIPUHD4AKSxVXuU5ckKpW+YR+x9w7EMtSeWC/EX+0OlDuEb02
         l3w9Xrde/JjKtALDG3OZeOMEHxKWC/tLtKlDsoLqKREkRgu89WuSEqoAmzdUx49E8Zkf
         fOWOu/FgcqT886N28K5x+P9I7wuTOveGvLxbLaH/Cp+MI+7YhLL/KwMV4gAsLuqW6TWV
         ygQzArbmMpefrfUkX0KbnBlqN1zS+FV9AvSIEDGTbJDrgHqVyLRj7hSMLjfy2/4Wq0Bu
         HQNA==
X-Gm-Message-State: APjAAAUggQZRY2YoVXtVqn6lLXdzbB2r+nRJ9Lq/qpq/CBBskKpDdlzf
        k75Th2mq5bkgn4+ZD6eFDU85ccCLosWPuNbspqcc/s88KREkgxRxYlUeRHyc6C0f1vPNBe4Lpdh
        0hAPl2t4jfj7S+81gXEDa+8Ub
X-Received: by 2002:a1c:3803:: with SMTP id f3mr4446400wma.134.1575541174626;
        Thu, 05 Dec 2019 02:19:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGZwu2osdsqyQJM4F16+Z0qPXhHN5OwXXbgylNZNCRn6oWdfdmCqf0PLAgBUweCD/FWfQW/g==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr4446378wma.134.1575541174401;
        Thu, 05 Dec 2019 02:19:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id u18sm11656947wrt.26.2019.12.05.02.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:19:33 -0800 (PST)
Subject: Re: [PATCH] KVM: explicitly set rmap_head->val to 0 in
 pte_list_desc_remove_entry()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1575517216-5571-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9469628-dc2c-c738-5589-2ac19c01109c@redhat.com>
Date:   Thu, 5 Dec 2019 11:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575517216-5571-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: mjGcqNRXPE6UFdONGmwsKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 04:40, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When we reach here, we have desc->sptes[j] = NULL with j = 0.
> So we can replace desc->sptes[0] with 0 to make it more clear.
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6f92b40d798c..a81c605abbba 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1410,7 +1410,7 @@ pte_list_desc_remove_entry(struct kvm_rmap_head *rmap_head,
>  	if (j != 0)
>  		return;
>  	if (!prev_desc && !desc->more)
> -		rmap_head->val = (unsigned long)desc->sptes[0];
> +		rmap_head->val = 0;
>  	else
>  		if (prev_desc)
>  			prev_desc->more = desc->more;
> 

Queued, thanks.

Paolo

