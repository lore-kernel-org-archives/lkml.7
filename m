Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5E0C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022322BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfGYLYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:24:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32873 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391812AbfGYLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:24:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so35543226wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RjbdG3nViJvxOOUD7oJ8kV9hETSbuqoaOubZjfcu3IQ=;
        b=MMhNtEuCDXJD143PC8e3AM5AP4GY40nNbKa4M/VB8Bvi+nOeCYFvYfFYm3lcZwp/MS
         Zg49esBfwxAeAaDaMjk099JMv0XaRsbMINKBeijjvMS16KSR5nqPwfzzqTZDZfngnVc0
         t/Nv7MsKyaXXJrSqCG5zYlaoW1ZzbFrFZyTBaEyudXwjpzfZnihma0ej/f4iB4oItfM0
         Qy8+eqphNRg9Iww3mXfySZ/LT5NMzXjM8+L1phUmp7Pbk0q+itENoxDBcccY8pAqaQsb
         QpK0QGvfU6bgg8giEJQVrGwr5Wg1nIH1GSqe5Z5pttESC61UccyWO3AtdQJtH6r4qhkS
         aF6w==
X-Gm-Message-State: APjAAAW/ONWZ2wNWOwsHLM0cZop0L0BAluoE4/SE3vaDyP9Sp0FIjhfZ
        4cyG0ZwkuCo0HYhXr6cjQfffmOXRnzo=
X-Google-Smtp-Source: APXvYqzdtuI6MnxEnBnPgCfGVAMefcNKRGR3/m2Mtw0Ia+Lfly9vb5NT90uj+luQR/pqs+tcN1zdRg==
X-Received: by 2002:a1c:3:: with SMTP id 3mr80318202wma.6.1564053868317;
        Thu, 25 Jul 2019 04:24:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id k124sm79155642wmk.47.2019.07.25.04.24.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 04:24:27 -0700 (PDT)
Subject: Re: [PATCH stable-4.19 0/2] KVM: nVMX: guest reset fixes
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, stable@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190725104645.30642-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b0ca6477-ac1e-bf92-3e3a-902243707f54@redhat.com>
Date:   Thu, 25 Jul 2019 13:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725104645.30642-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 12:46, Vitaly Kuznetsov wrote:
> Few patches were recently marked for stable@ but commits are not
> backportable as-is and require a few tweaks. Here is 4.19 stable backport.
> 
> Jan Kiszka (1):
>   KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
> 
> Paolo Bonzini (1):
>   KVM: nVMX: do not use dangling shadow VMCS after guest reset
> 
>  arch/x86/kvm/vmx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks Vitaly for helping out.

Paolo
