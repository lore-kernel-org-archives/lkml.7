Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E247CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAFB20663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502305AbfJYLqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502108AbfJYLqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:46:55 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1930485362
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 11:46:55 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id 4so963357wrf.19
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFxVTkuWS3kQBWJGbndYa5A8WjnfR9HWKV7Q51mjf4g=;
        b=LstSFXp8KiI9OdRqfeKnTAqCVysTWCMxGiPuDhaSmhf6c04MQXYiUt40xKEUvjbr+0
         5+O/ZTvjG3e4eOwoem1NpZ6b146EI1h1xmop3iYXO3SeeWIfn/WhAKqjMxvpXvbblrA5
         wnJVMROdeF1pMsm3wBTe3JmZibFV+gjaU8PtebTZaloKLX/DQ5/JTae1H9jpG1vLJCGt
         yx+IHAVytvajDDgnP+dc6YfQcd7Y68/7rbhZkltnfkzo2WnEhDJvtMZn82nFr8gKyunP
         NxUAL3LQm0mpql9erMyHZww8dd0TEtv3MWt7ch4tVsWNYDF5N6oEukHd/8boD+4LH1yn
         vAxg==
X-Gm-Message-State: APjAAAUtuI4P4HznvE0MFGJRnymRAPw1ZnOkcWMWVHE0etGVlZLJf8Ue
        8Yowtf1DwhvOk3AtwxOA6Blvjke3fxVZZ/lckZmV14JYuiUHVwQfskJqCI9YRVHnSl9Pq9YqIFv
        mM8TK0+CImsSC45C9Qji6W70c
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr2682963wrs.345.1572004013391;
        Fri, 25 Oct 2019 04:46:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0N+07IZUEvJWWb7N83GBppYgQj1HmvMn6Q1GmAwZLzX0L4MctCmq7ANIVvVFt7HSefCOVbg==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr2682929wrs.345.1572004013107;
        Fri, 25 Oct 2019 04:46:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c7b:17ec:2a40:d29? ([2001:b07:6468:f312:9c7b:17ec:2a40:d29])
        by smtp.gmail.com with ESMTPSA id o73sm1723689wme.34.2019.10.25.04.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 04:46:52 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: get rid of odd out jump label in
 pdptrs_changed
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1572000874-28259-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <365321df-2f66-95ef-4bf3-4e250f0a99a7@redhat.com>
Date:   Fri, 25 Oct 2019 13:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1572000874-28259-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks (but it likely won't be on git.kernel.org until after the
end of KVM Forum, sorry about that).

Paolo

On 25/10/19 12:54, Miaohe Lin wrote:
> The odd out jump label is really not needed. Get rid of
> it by return true directly while r < 0 as suggested by
> Paolo. This further lead to var changed being unused.
> Remove it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff395f812719..8b0d594a3b90 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -721,7 +721,6 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
>  bool pdptrs_changed(struct kvm_vcpu *vcpu)
>  {
>  	u64 pdpte[ARRAY_SIZE(vcpu->arch.walk_mmu->pdptrs)];
> -	bool changed = true;
>  	int offset;
>  	gfn_t gfn;
>  	int r;
> @@ -738,11 +737,9 @@ bool pdptrs_changed(struct kvm_vcpu *vcpu)
>  	r = kvm_read_nested_guest_page(vcpu, gfn, pdpte, offset, sizeof(pdpte),
>  				       PFERR_USER_MASK | PFERR_WRITE_MASK);
>  	if (r < 0)
> -		goto out;
> -	changed = memcmp(pdpte, vcpu->arch.walk_mmu->pdptrs, sizeof(pdpte)) != 0;
> -out:
> +		return true;
>  
> -	return changed;
> +	return memcmp(pdpte, vcpu->arch.walk_mmu->pdptrs, sizeof(pdpte)) != 0;
>  }
>  EXPORT_SYMBOL_GPL(pdptrs_changed);
>  
> 

