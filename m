Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4496C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FB206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="glzUp8gA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfGaEXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 00:23:21 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38166 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGaEXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:23:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so68803095oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 21:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tm6ntfcYmNHUpIkveTc5p4r6569ul1qIUEH4oxRjwA4=;
        b=glzUp8gAgo6Q9+gjT5xKBMG30uah/MGW3tgERppjauRxj/tmhas8EEff6tCjk6x9Oo
         y4yyZpqHDXgaIfsG4COlY9nVCd1boATU3DBufsqEy40c28G9vJaAsDkpn0KK+No1GvNH
         qTG5qAKnhCkwiGa6BBEERHNzSbb8ZEClpQLptBPI8pxEXmmih6Jd7qqCXTXelHmSSfV2
         PngzgOomffODrlcUHKczYix6KxGwDAzWrQ7M739Hp0U6FwXuxSj2Nn1VdFfspfag6XCs
         AcALx/y+P3AngYVbf2fVaNiAQbx4faQhsUnrcqe6vRdyXlKg9OCXPZM1AWyOudTLoarK
         KXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tm6ntfcYmNHUpIkveTc5p4r6569ul1qIUEH4oxRjwA4=;
        b=iyiA5U7OFlzluoTPPmNzVDi9lLXoaPF+lfRt3gbvmQRVujLvqHjp/Y5nt7mhDQYWe4
         lfVw0OtWhY1lT2ajwWjRlJ3U+3+LrdeMPMaVPYkgm6TwFnJL3eO05uJzGRkj9FUUZLyB
         1dpx5Wl1heegURj/Yx52b6g2P4Q/iHMwQiWOmiFK15htV5xsu0Io0Vf8m8V9JO/CxkA3
         8jreFxv3qY2Xp5OfoOc/UK9owP2wY10eifh+u7VgZH6SiupdHc/q16lykYiDbAC0Hs2C
         xDd1WXoxfQpAmBMRhf6EHrtVBQeviUdw4MgOoCFs1oL/H4CI+NdW/krD5EQqqVy+V49R
         VRTg==
X-Gm-Message-State: APjAAAUpswlXsAB8HR9xhT+9oE2FQXyWRJgLz1IsFs8gIv4oTAIKfW0t
        prn3gIUTqbIhI2MQJPGy2xOl0w==
X-Google-Smtp-Source: APXvYqyrmqRX0TMTUvKRI9kn2OfHhiN/A4ouvjYOKSZwB7DvlVq/p3PsehROt3mdsdg2QXOYNxFx/w==
X-Received: by 2002:a05:6830:2119:: with SMTP id i25mr9479782otc.282.1564547000208;
        Tue, 30 Jul 2019 21:23:20 -0700 (PDT)
Received: from localhost ([2600:100e:b005:6ca0:a8bb:e820:e6d3:8809])
        by smtp.gmail.com with ESMTPSA id v203sm25607331oie.5.2019.07.30.21.23.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 21:23:19 -0700 (PDT)
Date:   Tue, 30 Jul 2019 21:23:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/5] RISC-V: Add riscv_isa reprensenting ISA features
 common across CPUs
In-Reply-To: <20190731012418.24565-3-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907302117420.15340@viisi.sifive.com>
References: <20190731012418.24565-1-atish.patra@wdc.com> <20190731012418.24565-3-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Atish Patra wrote:

> From: Anup Patel <anup.patel@wdc.com>
> 
> This patch adds riscv_isa integer to represent ISA features common
> across all CPUs. The riscv_isa is not same as elf_hwcap because
> elf_hwcap will only have ISA features relevant for user-space apps
> whereas riscv_isa will have ISA features relevant to both kernel
> and user-space apps.
> 
> One of the use case is KVM hypervisor where riscv_isa will be used
> to do following operations:
> 
> 1. Check whether hypervisor extension is available
> 2. Find ISA features that need to be virtualized (e.g. floating
>    point support, vector extension, etc.)
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 25 +++++++++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 41 +++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 7ecb7c6a57b1..e069f60ad5d2 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -22,5 +22,30 @@ enum {
>  };
>  
>  extern unsigned long elf_hwcap;
> +
> +#define RISCV_ISA_EXT_A		(1UL << ('A' - 'A'))

Are these uppercase variants still needed if we define the ISA string to 
be all lowercase, per our recent discussion?

> +#define RISCV_ISA_EXT_a		RISCV_ISA_EXT_A
> +#define RISCV_ISA_EXT_C		(1UL << ('C' - 'A'))
> +#define RISCV_ISA_EXT_c		RISCV_ISA_EXT_C
> +#define RISCV_ISA_EXT_D		(1UL << ('D' - 'A'))
> +#define RISCV_ISA_EXT_d		RISCV_ISA_EXT_D
> +#define RISCV_ISA_EXT_F		(1UL << ('F' - 'A'))
> +#define RISCV_ISA_EXT_f		RISCV_ISA_EXT_F
> +#define RISCV_ISA_EXT_H		(1UL << ('H' - 'A'))
> +#define RISCV_ISA_EXT_h		RISCV_ISA_EXT_H
> +#define RISCV_ISA_EXT_I		(1UL << ('I' - 'A'))
> +#define RISCV_ISA_EXT_i		RISCV_ISA_EXT_I
> +#define RISCV_ISA_EXT_M		(1UL << ('M' - 'A'))
> +#define RISCV_ISA_EXT_m		RISCV_ISA_EXT_M
> +#define RISCV_ISA_EXT_S		(1UL << ('S' - 'A'))
> +#define RISCV_ISA_EXT_s		RISCV_ISA_EXT_S
> +#define RISCV_ISA_EXT_U		(1UL << ('U' - 'A'))
> +#define RISCV_ISA_EXT_u		RISCV_ISA_EXT_U
> +
> +extern unsigned long riscv_isa;
> +
> +#define riscv_isa_extension_available(ext_char)	\
> +		(riscv_isa & RISCV_ISA_EXT_##ext_char)
> +
>  #endif
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index b1ade9a49347..177529d48d87 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -43,8 +49,22 @@ void riscv_fill_hwcap(void)
>  			continue;
>  		}
>  
> -		for (i = 0; i < strlen(isa); ++i)
> +		i = 0;
> +		isa_len = strlen(isa);
> +#if defined(CONFIG_32BIT)
> +		if (strncasecmp(isa, "rv32", 4) != 0)

strcmp()?

> +			i += 4;
> +#elif defined(CONFIG_64BIT)
> +		if (strncasecmp(isa, "rv64", 4) != 0)

And again here?

> +			i += 4;
> +#endif
> +		for (; i < isa_len; ++i) {
>  			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> +			if ('a' <= isa[i] && isa[i] <= 'z')
> +				this_isa |= (1UL << (isa[i] - 'a'));
> +			if ('A' <= isa[i] && isa[i] <= 'Z')
> +				this_isa |= (1UL << (isa[i] - 'A'));

Are these uppercase variants still needed?


- Paul
