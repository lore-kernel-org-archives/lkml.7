Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A78CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281F21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GDUVls0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbfJWSy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:54:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404000AbfJWSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:54:57 -0400
Received: by mail-io1-f65.google.com with SMTP id c11so17173415iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=12QbW3key6pkPLRePaJeG2+1IWcL9FQrUNpf3RuSKSQ=;
        b=GDUVls0nbXaYTbmTFZL/RVapwYhF4nk0yOpUXO8xXNki35UwD8vLzY6PEIH775b/eV
         VNCdP2nsxX8S0Kq9AO5cvrLCvrv6qM5hrppOxC2VWCtuWUDk3Tzlc7FqwI4db6+ifuoK
         +vWrow2Di4hCVAXJK88uEH0ux41umg45NcID2sXhUHxpGF9d3PKcR/IEcxfv1YZIF34t
         7u1ujeneJLCnj6GSeuT5nxPZuW5/eJJvvkYXuoON8ADB5dXNHu2LntShneO+66r6YszK
         wAKsFHgpvpJiRLvTUho0x12PR2Mq4iUFg1Khv0PG7Si9RCFyTYD1/vzOEMRqWYMMbEF9
         fg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=12QbW3key6pkPLRePaJeG2+1IWcL9FQrUNpf3RuSKSQ=;
        b=fKjkvn0gwNUSxtNLAQ+kc5Fv8ISLfdBqMh8b+tABdS6eWDU69kZF1kw++oDfIOkoUo
         ljRcs4eFWwz3y7MtNFqilvbCCM/MhVi+UAdZWTJfRY9HxSpWdcynfSO6uA3G7+/lu+nV
         tr+whyFxRZZB0R4IFht1qosWNYav+BV3RoGSciDZtfg0xKDu0M3u8f6wVDBvVn0gh/fp
         udUgaNsaIyoS/fgeDqbilTmijlYTWGDW9GhXlkxCWsbHfMRFOgRy2eK/gjda+IgBkeO5
         DkAHTTi+wpv4w6qRWc73iaQ3x3EtH4Lgea7Frdd+KCJ/VBKrb2yC0RpWPtCCTgM9fqGG
         mrmA==
X-Gm-Message-State: APjAAAVR6qyVM0GQ35cyzpg3lZVBgyMWHI4L6Oi0W9fwDpu51zbmF1ZR
        2mVo6xEoS651O86BWDluiRgWnA==
X-Google-Smtp-Source: APXvYqwAgcDxjS3FQfiMaYQ2W8py38nxP64qtmVkcxcVPl8C/rXsYd/CoOC3NOujys7o6Ep29KpLRQ==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr5108252iop.161.1571856896420;
        Wed, 23 Oct 2019 11:54:56 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm3791776ilo.70.2019.10.23.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 11:54:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 11:54:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alan Mikhak <alan.mikhak@sifive.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        palmer@sifive.com, hch@infradead.org
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
In-Reply-To: <1571847755-20388-1-git-send-email-alan.mikhak@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
References: <1571847755-20388-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ hch

On Wed, 23 Oct 2019, Alan Mikhak wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify plic_init() to skip .dts interrupt contexts other
> than supervisor external interrupt.

Might be good to explain the motivation here.

> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index c72c036aea76..5f2a773d5669 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
>  			continue;
>  		}
>  
> -		/* skip context holes */
> -		if (parent.args[0] == -1)
> +		/* skip contexts other than supervisor external interrupt */
> +		if (parent.args[0] != IRQ_S_EXT)
>  			continue;

Will this need to change for RISC-V M-mode Linux support?  

https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/


- Paul


