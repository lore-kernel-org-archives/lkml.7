Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6557C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237D206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfHNN3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:29:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43514 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfHNN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:29:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so5154001wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vt6M8evguG8mza7xAGCORpRNGIMSe6MxiCbo5YivOBk=;
        b=UYGoYC5ppE5KXUoH1bdk8CffqUVC/Mclu4YIcExJOqa/4C4NR0/2HU6weePxYJIuMg
         V1/q4ZFuEYROY//CwYR8miJDZtM0KektVRGhLXRUlj6bod9PGmJUUcj7j9F/c/D08jRI
         0mlK6EW9fGu/MhJXENi8u1T/p3IQZs1hMGjbH6sR6MJBu+hl/ht1RYjcOIS5zT5ZOapT
         0iEQCsuKV1vR6RT5HksESYDO47O1i56r+IkYX1D8fVk3h4u1JKVCK5oHT983Hgl9LMQq
         TeldOhHUDkhtiLC24ueD76dfx7ksF9u6vWeqITEsQf3jE+CptTe2Goa6xqNxb3U8ykSS
         sUqw==
X-Gm-Message-State: APjAAAVKh6D3/4EQSlWFm0kylw+Pr+tpC9B5s+qndZsRPGAYhfj17mii
        I9nuf6dd6xZdlg+YtZ2mfTm4Is1f3hE=
X-Google-Smtp-Source: APXvYqwGUCBvQIFvJWsaQjWF1pIdbcTuoqLxKp8M4Us+qFA7PbNgUf7dCVRKH2NabDANH5yzssaA8g==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr48053642wrr.319.1565789362015;
        Wed, 14 Aug 2019 06:29:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cae:66cd:dd43:92d9? ([2001:b07:6468:f312:2cae:66cd:dd43:92d9])
        by smtp.gmail.com with ESMTPSA id f18sm8245770wrx.85.2019.08.14.06.29.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:29:21 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: skip populating logical dest map if apic is not
 sw enabled
To:     Bandan Das <bsd@redhat.com>, kvm <kvm@vger.kernel.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <jpgv9v076ym.fsf@linux.bootlegged.copy>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aee50952-144d-78da-9036-045bd3838b59@redhat.com>
Date:   Wed, 14 Aug 2019 15:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <jpgv9v076ym.fsf@linux.bootlegged.copy>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 05:37, Bandan Das wrote:
> 
> recalculate_apic_map does not santize ldr and it's possible that
> multiple bits are set. In that case, a previous valid entry
> can potentially be overwritten by an invalid one.
> 
> This condition is hit when booting a 32 bit, >8 CPU, RHEL6 guest and then
> triggering a crash to boot a kdump kernel. This is the sequence of
> events:
> 1. Linux boots in bigsmp mode and enables PhysFlat, however, it still
> writes to the LDR which probably will never be used.
> 2. However, when booting into kdump, the stale LDR values remain as
> they are not cleared by the guest and there isn't a apic reset.
> 3. kdump boots with 1 cpu, and uses Logical Destination Mode but the
> logical map has been overwritten and points to an inactive vcpu.
> 
> Signed-off-by: Radim Krcmar <rkrcmar@redhat.com>
> Signed-off-by: Bandan Das <bsd@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 685d17c11461..e904ff06a83d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -216,6 +216,9 @@ static void recalculate_apic_map(struct kvm *kvm)
>  		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
>  			new->phys_map[xapic_id] = apic;
>  
> +		if (!kvm_apic_sw_enabled(apic))
> +			continue;
> +
>  		ldr = kvm_lapic_get_reg(apic, APIC_LDR);
>  
>  		if (apic_x2apic_mode(apic)) {
> @@ -258,6 +261,8 @@ static inline void apic_set_spiv(struct kvm_lapic *apic, u32 val)
>  			static_key_slow_dec_deferred(&apic_sw_disabled);
>  		else
>  			static_key_slow_inc(&apic_sw_disabled.key);
> +
> +		recalculate_apic_map(apic->vcpu->kvm);
>  	}
>  }
>  
> 

Queued, thanks.

Paolo
