Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C52C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FE320838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfGOJRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:17:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfGOJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:17:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so13824718wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v5fo+uSi73xpR+4ETmGVl9w7fmYmhPooNofZwTaxS60=;
        b=QOf8IFQxzTHXVZqAIBKh81bJKzMUCaOE2Oi3BhpMd1Vz9RavscY08HhcPN2O7C3NpO
         bURFfmHYTM53qw+HTZ9BssdEmPPBHhoKxmZw/5P9KmbpgxQzpRUJ3Ij+vtcFfUjjl5bG
         TbfaC3Ynt6tXL6NEAIjT4P3M/fLLMsnY/SrOitF+NNh0r1tvUk8+fsDm2kyzHQKX/Wit
         /LzH+PEdkiChcVAeZhISj7fzs+m1FwjCbtEzwfx1BfYlbbMRHNjU3g6CPQnoh1y4tKwd
         nPJE1x7ty0PwA8X1y+aUAVP8WafNB1YZzf34hVG/NXpSS6O04RurSYc6ViOzxZYuDvc2
         39Uw==
X-Gm-Message-State: APjAAAXpjzhUEZ0SEQ/CMrJhAaA+vjkuInzxsp2PqzfREOo9kgif9//q
        LtQMA55D4TQCZU6/wVbwAMftIQ==
X-Google-Smtp-Source: APXvYqx/8fS4DHovqQrXPURh4GRC5n8Wt1AN2V3TGuiwf2O7Uf1HvdjxSGYzf+fWQVXcWRo5LGl0GA==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr11970612wmg.15.1563182219160;
        Mon, 15 Jul 2019 02:16:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e983:8394:d6:a612? ([2001:b07:6468:f312:e983:8394:d6:a612])
        by smtp.gmail.com with ESMTPSA id x20sm12605163wmc.1.2019.07.15.02.16.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:16:58 -0700 (PDT)
Subject: Re: [PATCH RESEND] i386/kvm: support guest access CORE cstate
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
References: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ba3ae595-7f82-d17b-e8ed-6e86e9195ce5@redhat.com>
Date:   Mon, 15 Jul 2019 11:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563154124-18579-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 03:28, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allow guest reads CORE cstate when exposing host CPU power management capabilities 
> to the guest. PKG cstate is restricted to avoid a guest to get the whole package 
> information in multi-tenant scenario.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Hi,

QEMU is in hard freeze now.  This will be applied after the release.

Thanks,

Paolo

> ---
>  linux-headers/linux/kvm.h | 4 +++-
>  target/i386/kvm.c         | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index b53ee59..d648fde 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -696,9 +696,11 @@ struct kvm_ioeventfd {
>  #define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
>  #define KVM_X86_DISABLE_EXITS_HLT            (1 << 1)
>  #define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
> +#define KVM_X86_DISABLE_EXITS_CSTATE         (1 << 3)
>  #define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
>                                                KVM_X86_DISABLE_EXITS_HLT | \
> -                                              KVM_X86_DISABLE_EXITS_PAUSE)
> +                                              KVM_X86_DISABLE_EXITS_PAUSE | \
> +                                              KVM_X86_DISABLE_EXITS_CSTATE)
>  
>  /* for KVM_ENABLE_CAP */
>  struct kvm_enable_cap {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b29ce5..49a0cc1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1645,7 +1645,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          if (disable_exits) {
>              disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
>                                KVM_X86_DISABLE_EXITS_HLT |
> -                              KVM_X86_DISABLE_EXITS_PAUSE);
> +                              KVM_X86_DISABLE_EXITS_PAUSE |
> +                              KVM_X86_DISABLE_EXITS_CSTATE);
>          }
>  
>          ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
> 

