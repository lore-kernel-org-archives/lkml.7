Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56665C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28596205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+G35Npy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfLEKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:18:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24603 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbfLEKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575541091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrJ2QpeOD1T6UGSZxBKj4bnGbZCCWof+wP8aUHJYy/8=;
        b=P+G35NpyG5qoHXartKYpb/x3tfZyBae6ST8aDPau7ac+sfzMr86Am6kkSmjUFOrxhlpVyD
        GMo6rOXL1aPe3UHYGyOBhQCaWwZ2NIG5dyJdx+PGNWXGCp3qj+XTqpoLLrLew5McTKjJn8
        kFEBaZY+CXbsSQs+1xDKFE8kNhHouDY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-DQNpI_JtPTivqZ3V7MnfXw-1; Thu, 05 Dec 2019 05:18:10 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so1295772wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrJ2QpeOD1T6UGSZxBKj4bnGbZCCWof+wP8aUHJYy/8=;
        b=iUM5cr2zFZceSfXdQtB9jLqogRRhYMKEuaG4SNDRg7vFUdsqgStVL3jO0bR5vPq7Bg
         HFi6E6bTnQbDcFU8LlhaVv5PtPk3BI3Y0k7cZ/2BjwoNLcXLl/wvY0Ob1YtTKLijvEMK
         sgBEVXK+/hoUMOvmRueRIBjfKRkI9yg6TG0grrknwDvQGCwiGN+qlo889Q7/vLf1MLrE
         5ksWpY6ccPhXQho2VG9x6p5d1/WLcyBCsin3Gv9rrKTpvbPLzsIhPNX/ky7cQXz1mhrr
         r9ud6Vo5GD9KAP4kX4LuSGrtV4ZNFlfjEBbwX3TjojLbq5cmh7gSa6nM3mf24zriqMhW
         RC+A==
X-Gm-Message-State: APjAAAXZCqxQXmaT68DWl7aX+kBZfNhLDzerlVZZZwFxl8j0gyjtLi4F
        iIkOyOFB2D3DlkAXHt+43pudazLs1/2PZEWynqDSGzLUcYH/v/JL0iKKg+aY5ZHQcBrd7tT4e+W
        Vd0dczIXVcvacIBkbqPH59Z/9
X-Received: by 2002:adf:c74f:: with SMTP id b15mr9102705wrh.272.1575541089032;
        Thu, 05 Dec 2019 02:18:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9KpijdtwrciYuh/BwTYlT6yukw04yKTCUYkRGS6I9sNL+NECO7fX2tcX67XlyzUJLfJUBFw==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr9102686wrh.272.1575541088803;
        Thu, 05 Dec 2019 02:18:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id f12sm9612263wmf.28.2019.12.05.02.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:18:08 -0800 (PST)
Subject: Re: [PATCH] KVM: get rid of var page in kvm_set_pfn_dirty()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1575515105-19426-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dbb89c0e-73f1-84a7-7f47-05ee886ba8f1@redhat.com>
Date:   Thu, 5 Dec 2019 11:18:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575515105-19426-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: DQNpI_JtPTivqZ3V7MnfXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 04:05, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We can get rid of unnecessary var page in
> kvm_set_pfn_dirty() , thus make code style
> similar with kvm_set_pfn_accessed().
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/kvm_main.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 00268290dcbd..3aa21bec028d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1931,11 +1931,8 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
>  
>  void kvm_set_pfn_dirty(kvm_pfn_t pfn)
>  {
> -	if (!kvm_is_reserved_pfn(pfn) && !kvm_is_zone_device_pfn(pfn)) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		SetPageDirty(page);
> -	}
> +	if (!kvm_is_reserved_pfn(pfn) && !kvm_is_zone_device_pfn(pfn))
> +		SetPageDirty(pfn_to_page(pfn));
>  }
>  EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
>  
> 

Queued, thanks.

Paolo

