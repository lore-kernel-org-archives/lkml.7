Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE0BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F620859
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFDRUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:20:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40198 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFDRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:20:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so11840925wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MIeQ1hRc5hTWO/6y4ou8VBIQoDTI2KJ3dAfbqfPHsRY=;
        b=DcECO8y/TkYos/z0n5lha6cjNnZkDc9LnoLECNMsWg4opmgnveO+/VfBYoDG3qNvms
         Pg61iyfvDCe2iWGhRv9wwiqcdd+FkHJyD2XTeNi2YMd7dq6L46DABiPuXpCMZyzyjiVX
         E2/2BY35mSY4ZyvAqreU+sZdW2aUdKXKEI0ALB6IrellDUhEmaGwadrkSEfEbEmZQodA
         FbeX9+XIUPPG8NOEQpV+XXmzi/n6K971w8yH+gBvQrw9g3K9OkLKFJWhcobpoULo+L9n
         Xf3GSKZSZE2sHoXiBvRUD0bnc4hynDqPXauTrfzCRUwPEYHlIx4wMsrwp+Jpu30mRNw5
         lJdA==
X-Gm-Message-State: APjAAAUe67rDlDFDcbTP4+2EegASc1JGVtfr8PvC30cNXvQQD2TyaKyx
        xGDwv864Ja3WLcdko2X7QzPN5qey2jHxiA==
X-Google-Smtp-Source: APXvYqyCLCR9Tut/3XbRV2YRnUp9dQfHLcpQpwQKSuwwLKbot5ERpIMPqcoGXXa6IR6L1BCFAthjmg==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr19107229wrm.24.1559668835069;
        Tue, 04 Jun 2019 10:20:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id e13sm21770174wra.16.2019.06.04.10.20.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:20:34 -0700 (PDT)
Subject: Re: [PATCH] KVM: irqchip: Use struct_size() in kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190531192453.GA13536@embeddedor>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bc61102-47c6-5df3-aa2d-1f7ec91214c1@redhat.com>
Date:   Tue, 4 Jun 2019 19:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531192453.GA13536@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/19 21:24, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>    int stuff;
>    struct boo entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  virt/kvm/irqchip.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 79e59e4fa3dc..f8be6a3d1aa6 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -196,9 +196,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  
>  	nr_rt_entries += 1;
>  
> -	new = kzalloc(sizeof(*new) + (nr_rt_entries * sizeof(struct hlist_head)),
> -		      GFP_KERNEL_ACCOUNT);
> -
> +	new = kzalloc(struct_size(new, map, nr_rt_entries), GFP_KERNEL_ACCOUNT);
>  	if (!new)
>  		return -ENOMEM;
>  
> 

Queued, thanks.

Paolo
