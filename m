Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D3D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FPOXc0Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHMSZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:25:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42627 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfHMSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:25:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so31484140ota.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KKbCR1tFCWObTnhlH9C2d2XLJKP2zhB/LK0xe4rn60I=;
        b=FPOXc0AodraVwoTfynD6VRQNVTH0DcfUBNErnRpVBxdYrVdGm/iCq9GLJQQW36Phh6
         t9N7/MXMvJ7hZVt2cZoJ4QCPMLJkZuuwa808avZrvlCKI8oeWovWt2eMewROtONZzSHd
         7UzYHmk1Iwq4AXEfBrQW4GENapMDS+D8ZVk4okXLvHdJW0JuEVglqh7KVJdeW2y2VNo2
         CKZlp/Nna+R1ORJci9HqYjLSDhoWYaLYu2B7BXzIJFHh9c4wRToke9T5nlavWf5ZfFFL
         Dvn1lENwZ6jam7bhQD6lenKt0njDiYWAdrrVXpZGJmQTjVIUxs6ick/0lFz1YlJHqTsU
         M+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KKbCR1tFCWObTnhlH9C2d2XLJKP2zhB/LK0xe4rn60I=;
        b=ikFxGywhDe6uYd79qaAmTR3AAT9V1/dxEY9wr9bXmJxpTPM2D981ifU9S3UBFEnxzP
         hfiOjiHEkKef99yll9n3nKR24c1NI8HcuKy46HhsnMecECxp+ox5HFbjA8qwgoWLpThm
         d5pdWTnJsx37uNdaL2YRYZzdBTqNtmks6vDi3ROcJI13XQGpb16E5a8dsWqnh1tyoFmC
         SDt0MWVMf0HSIEOZIcOYAepA0rg6FpJixjlDJU2cceDqVz9wKk9w3H+3pZQI96cV+X7e
         bP26ggmcG2Ftsm9bC9uFH1F2jXQZN3tcHBJVTY750bAzAXBqN7DM0uSR/55KppASAajv
         tSCQ==
X-Gm-Message-State: APjAAAX1NssV7ZilMDGFARSKLLh6okpgwwjkXowJbjX0kF/xdRQosCE3
        ymNz0+svJLfpZfBpXdRSmEpZLg==
X-Google-Smtp-Source: APXvYqzCos6QmRqnSaor6zsGjXbzDUPbcse6TbNMSR4F/H38mTVtC5bxGKOPb7Z5BK5/ZQOkvMbwNQ==
X-Received: by 2002:a02:390c:: with SMTP id l12mr32485157jaa.76.1565720717060;
        Tue, 13 Aug 2019 11:25:17 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id k7sm18488997iop.88.2019.08.13.11.25.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 11:25:16 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:25:15 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908131053520.30024@viisi.sifive.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Fri, 9 Aug 2019, Atish Patra wrote:

> In RISC-V, tlb flush happens via SBI which is expensive.
> If the target cpumask contains a local hartid, some cost
> can be saved by issuing a local tlb flush as we do that
> in OpenSBI anyways.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

A few brief comments/questions beyond the ones that others have mentioned:

1. At some point, some RISC-V systems may implement this SBI call in 
hardware, rather than in software.  Then this might wind up becoming a 
de-optimization.  I don't think there's anything to do about that in code 
right now, but it might be worth adding a comment, and thinking about how 
that case might be handled in the platform specification group.

2. If this patch masks or reduces the likelihood of hitting the 
TLB-related crashes that we're seeing, we probably will want to hold off 
on merging this one until we're relatively certain that those other 
problems have been fixed. 



> ---
>  arch/riscv/include/asm/tlbflush.h | 33 +++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 687dd19735a7..b32ba4fa5888 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -8,6 +8,7 @@
>  #define _ASM_RISCV_TLBFLUSH_H
>  
>  #include <linux/mm_types.h>
> +#include <linux/sched.h>
>  #include <asm/smp.h>
>  
>  /*
> @@ -46,14 +47,38 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
>  				     unsigned long size)
>  {
>  	struct cpumask hmask;
> +	struct cpumask tmask;
> +	int cpuid = smp_processor_id();
>  
>  	cpumask_clear(&hmask);
> -	riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -	sbi_remote_sfence_vma(hmask.bits, start, size);
> +	cpumask_clear(&tmask);
> +
> +	if (cmask)
> +		cpumask_copy(&tmask, cmask);
> +	else
> +		cpumask_copy(&tmask, cpu_online_mask);
> +
> +	if (cpumask_test_cpu(cpuid, &tmask)) {
> +		/* Save trap cost by issuing a local tlb flush here */
> +		if ((start == 0 && size == -1) || (size > PAGE_SIZE))
> +			local_flush_tlb_all();
> +		else if (size == PAGE_SIZE)
> +			local_flush_tlb_page(start);
> +		cpumask_clear_cpu(cpuid, &tmask);
> +	} else if (cpumask_empty(&tmask)) {
> +		/* cpumask is empty. So just do a local flush */
> +		local_flush_tlb_all();
> +		return;
> +	}
> +
> +	if (!cpumask_empty(&tmask)) {
> +		riscv_cpuid_to_hartid_mask(&tmask, &hmask);
> +		sbi_remote_sfence_vma(hmask.bits, start, size);
> +	}
>  }
>  
> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
> -#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
> +#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, (addr) + PAGE_SIZE)
>  #define flush_tlb_range(vma, start, end) \
>  	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
>  #define flush_tlb_mm(mm) \
> -- 
> 2.21.0
> 
> 


- Paul
