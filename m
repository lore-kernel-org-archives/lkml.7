Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A59C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A871B20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m8glgmWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgAGKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:54:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39151 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgAGKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:54:09 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so22271254ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=55zGQCan/BVSbUS/lERboFokfvk914OIASgTIrIGSMY=;
        b=m8glgmWU2bmFV6XaqzDbxxkQrTNyU77OUM6rzJbL/F3d/0w1TqQPZBQQrWiR8htJ+k
         OcNVqaztp4ttvnYPhLkqGNxuPACuxfUKt/JHxyelffdOzpVzG6+st6BnhvCHA5qyg+L4
         nzJYmQB19SSbWd9wkxe3IIZjuFjIB8KuGz1RyJS7YJF0bYbdXC9INUs7Jda9GKlMaUM5
         k5Gr2EnlrBmuQOe+lZZTYm9vkCIx+IGUeebJk3XtmhTqKgg/454E2eqV7ZUXKZ1mE28O
         IUECGaZQPn8tnfm6VltpcziwIDySAib8KPTJvcCjvw8pTMZeZHSsVv5syQeKqN8EuEv1
         CSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=55zGQCan/BVSbUS/lERboFokfvk914OIASgTIrIGSMY=;
        b=kjrRgp8yeim1zlkHFUyaLy6QS44xotteOnUly4U4A8FpIKr5ZSwBWxr4fTLbEaRV8P
         Vr4snSZHRDeBJtwp4TikX+vWNYucZwURS/AiEkWqYS4HY6a/GLi1T5ktbuZ2DNAAUFvK
         IETz7K/wk0LUO1LsLR+VNCQFchPdXJ9VqcXGD4czvfwC2dbAN4olx5uG2vrOtcfy7gDH
         nV+PfEnm3PIwI868T+lhIrTzmqwaFKOJQu2lU0fBsIC4A88T/ADiRN+aumPjDX5g2QB3
         EYrC5uXvXFp1BxltyRtsQz3V5JqOEiRnPHNjVj+xbW6h3QuuOsApouiT9FztMKw6ANg2
         5YRw==
X-Gm-Message-State: APjAAAUeRdpcH61Hf2vC+3tKtGorvqElS+zeyQdMgQaLfQn370jGknt8
        1pfia80V2B/FpuMqSyXp97Mn4lmHRyM=
X-Google-Smtp-Source: APXvYqwYyM9UchL19MH04zd3Ziizjw9GGG1gYwasSH5L+3DLLbAgxrJCWdBov2MEAG5TiIraC2giIw==
X-Received: by 2002:a02:c9d2:: with SMTP id c18mr83648393jap.66.1578394448585;
        Tue, 07 Jan 2020 02:54:08 -0800 (PST)
Received: from localhost (67-0-46-172.albq.qwest.net. [67.0.46.172])
        by smtp.gmail.com with ESMTPSA id r17sm24809102ill.27.2020.01.07.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:54:08 -0800 (PST)
Date:   Tue, 7 Jan 2020 02:54:07 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Greentime Hu <greentime.hu@sifive.com>
cc:     green.hu@gmail.com, greentime@kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: to make sure the cores in .Lsecondary_park
In-Reply-To: <20200107091618.7214-1-greentime.hu@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001070253000.75790@viisi.sifive.com>
References: <20200107091618.7214-1-greentime.hu@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

On Tue, 7 Jan 2020, Greentime Hu wrote:

> The code in secondary_park is currently placed in the .init section.  The
> kernel reclaims and clears this code when it finishes booting.  That
> causes the cores parked in it to go to somewhere unpredictable, so we
> move this function out of init to make sure the cores stay looping there.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/head.S | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f8f996916c5b..d8da076fc69e 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -217,11 +217,6 @@ relocate:
>  	tail smp_callin
>  #endif
>  
> -.align 2
> -.Lsecondary_park:
> -	/* We lack SMP support or have too many harts, so park this hart */
> -	wfi
> -	j .Lsecondary_park
>  END(_start)
>  
>  #ifdef CONFIG_RISCV_M_MODE
> @@ -303,6 +298,14 @@ ENTRY(reset_regs)
>  END(reset_regs)
>  #endif /* CONFIG_RISCV_M_MODE */
>  
> +__FINIT
> +.section ".text", "ax",@progbits

Can the __FINIT be dropped?

> +.align 2
> +.Lsecondary_park:
> +	/* We lack SMP support or have too many harts, so park this hart */
> +	wfi
> +	j .Lsecondary_park
> +
>  __PAGE_ALIGNED_BSS
>  	/* Empty zero page */
>  	.balign PAGE_SIZE


- Paul
