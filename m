Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AB5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393C4218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:23:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40410 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfGCQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:23:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so3047743wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6axsB7tTSVN9+THoYftvz6QjMoumSr7HZztyJRyLa40=;
        b=GJNTAHOzrXZIyRk8GvS2BZ5TBP8evgiHpTSfEOL/cAQUKllwqSxPz9+F83AtfMomCw
         CcqHWscWKlBzECjE/2Ksh533tHozVz2cezAl6f/4GhDieCKrcPZE71z7EZ6iKgMqu8B/
         5mmjQWSa0XxQ2LzkFmK1ytrM/lddu/x4HagZBAmJTYcTMWrXpoEWW8avhdSeqClsYK+H
         EJttYNiGSyS0+UxfIjz2hUrP6lRtYo6XyV0TGv97IBl7/4zJSZbwShJhTKnTp0ircOY2
         4IKDeuy5PoPBCsmptye/BxHxJ2sW5CVcNp/+K+n2tJLxJcsTnYYHdvdpblq+MjfLalRv
         /Dqw==
X-Gm-Message-State: APjAAAUxLW6muyCOmk4FXSgWAVSQ4vHwAm48P0GHn8RWNwJ0r229gr0d
        5vWrgOPlKwecVhYmYjMd3myk4w==
X-Google-Smtp-Source: APXvYqygT9WZyOJ4nfYw9a8h6FDTp6c08dZZj8PBT3AKeUmifPjaTG+t58PWdB/deIRlSKNZg6wJOw==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr8150575wme.173.1562170985443;
        Wed, 03 Jul 2019 09:23:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9? ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
        by smtp.gmail.com with ESMTPSA id b2sm3582556wrp.72.2019.07.03.09.23.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:23:04 -0700 (PDT)
Subject: Re: [PATCH 2/4] kvm: x86: allow set apic and ioapic debug dynamically
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <1561962071-25974-1-git-send-email-wang.yi59@zte.com.cn>
 <1561962071-25974-3-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <685680d5-f642-0c48-08f2-8c73026ccaf0@redhat.com>
Date:   Wed, 3 Jul 2019 18:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561962071-25974-3-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 08:21, Yi Wang wrote:
> There are two *_debug() macros in kvm apic source file:
> - ioapic_debug, which is disable using #if 0
> - apic_debug, which is commented
> 
> Maybe it's better to control these two macros using CONFIG_KVM_DEBUG,
> which can be set in make menuconfig.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/kvm/ioapic.c | 2 +-
>  arch/x86/kvm/lapic.c  | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> index 1add1bc..8099253 100644
> --- a/arch/x86/kvm/ioapic.c
> +++ b/arch/x86/kvm/ioapic.c
> @@ -45,7 +45,7 @@
>  #include "lapic.h"
>  #include "irq.h"
>  
> -#if 0
> +#ifdef CONFIG_KVM_DEBUG
>  #define ioapic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg)
>  #else
>  #define ioapic_debug(fmt, arg...)
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4924f83..dfff5c6 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -54,8 +54,11 @@
>  #define PRIu64 "u"
>  #define PRIo64 "o"
>  
> -/* #define apic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg) */
> +#ifdef CONFIG_KVM_DEBUG
> +#define apic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg)
> +#else
>  #define apic_debug(fmt, arg...) do {} while (0)
> +#endif
>  
>  /* 14 is the version for Xeon and Pentium 8.4.8*/
>  #define APIC_VERSION			(0x14UL | ((KVM_APIC_LVT_NUM - 1) << 16))
> 

I would just drop all of them.  I've never used them in years, the kvm
tracepoints are enough.

Paolo
