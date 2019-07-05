Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6413C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D2621850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfGEJut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:50:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43772 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfGEJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:50:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so9235515wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUgV9oyAP3Ji8jA9MSEhvMmGZhPCnmuMeRDLIoIYTW0=;
        b=hA81FD+HlYB6kqeHOeqpFItjrKxIL+OtIMgtISvfoeyLVY4OFPoFSXHj1YpRgNdmaX
         IxRZ4O9LdW6AZP18T87E0Creq6J/aWsagnTXWYM4MdjuhWHxlVE7zTU1lI+cPXKFV4wU
         ZVt6+0wDJNG+RloHH3f31gYwq1nUFmejyvNo7nzI2s+CziA0n6kV55xHnB94ZpbEjIin
         5b1U5DDZxY5mpyYKExRxXY+Gn9JgZqvd1wZeNVLeRKRe7RNyLfqqmZudbajFiZRYTLKX
         gZ28ClBeWIBOLb/4RabwxKg4Kw1wc8nQe0H9xy5N5nlBZMhLDguKFcGJ02d/R/RkkwX9
         iQDg==
X-Gm-Message-State: APjAAAWAMWfg4+A5OVKjxHkdkqZgYoypXz9ogQHPUjYE+e/5LW8tFPoH
        vTeKk1CQu1WK00IsxmyGO0bLLg==
X-Google-Smtp-Source: APXvYqypJu/BEjih6IidHXtaQ3xrNB0U+85zf/Y9MMWD6a3bCmLx/E4SeqEvaBrNU348XT146MdsGQ==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr3261472wrv.212.1562320246561;
        Fri, 05 Jul 2019 02:50:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id z1sm8749189wrv.90.2019.07.05.02.50.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 02:50:46 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Reset timer_advance_ns to 1000 after adaptive
 tuning goes insane
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1562319651-6992-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dfdce82d-7cea-9b8d-0187-906b777d494d@redhat.com>
Date:   Fri, 5 Jul 2019 11:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562319651-6992-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 11:40, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Reset timer_advance_ns to the default value 1000ns after adaptive tuning 
> goes insane which can happen sporadically in product environment.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 05d8934..454d3dd 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1549,7 +1549,7 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  	if (abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
>  		apic->lapic_timer.timer_advance_adjust_done = true;
>  	if (unlikely(timer_advance_ns > 5000)) {
> -		timer_advance_ns = 0;
> +		timer_advance_ns = 1000;
>  		apic->lapic_timer.timer_advance_adjust_done = true;

Do you also want to reset timer_advance_adjust_done to false?

Paolo

>  	}
>  	apic->lapic_timer.timer_advance_ns = timer_advance_ns;
> 

