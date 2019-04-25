Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C795C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAD9218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556176627;
	bh=zsylMkP4bRslzGZRoAEzIJEZGys7ChwJYc/Pnlt3yAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RwqIqEZKeTNmmgkc7GZZAgSvRENomWDJ5UBhax7aEIW7hdAf83450I40gBBO29f1o
	 RkKia003vMypimQ8ne94W7lSOsYICOCuRhmHDEDtnXifJAWgML2fBKnm/mit9vwjAO
	 Hr7qgpehzM8L7JON+33jEdBknVdvgc59GH3QaDg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfDYHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:17:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbfDYHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:17:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so3927234wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5R6CXxa9eo4zeOC6Ii2aox+tn3YpxrwUFs4OWbvoonM=;
        b=cz67UedEt8u1vDUOxXIA4O62hMDtBoL0I42ShKbFWsuzCIkl/1tFpWPzfoAHvXkeaB
         bZAlLZjrK2zJGAwedLy2D8sev5ewGuqON3E1YRcu4qOUE/P2Krj7aZfIcaQuI1dwWMm1
         DRP8KV2QZzXC7Y7K1CmZLdbAO5IsJJ6GiGrg03S1KgtIPVgwEzOf5Znc0XIRWIqC7+Od
         JE/5J/Z3bXXFjXxODYVZLSlaneQCW+QgvwT1QEdoAs+sCXWHvDrPov5QxO2xRgxOaAQ+
         OdFOBVEDjlNuUk1KFnEEE+9XGe+hfS6EbQLarfhspfOTIxRjw4f5Mna2GmyYfMtK39m6
         FCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5R6CXxa9eo4zeOC6Ii2aox+tn3YpxrwUFs4OWbvoonM=;
        b=Qb1+b2eJKYt/5LV53O3mG7N+Vdd/5ZIBYTTPZUJxIZP8wTYWmwo3NxgrIddI6e3TFj
         SwwgzJ2V9cSaR01qzRBT3y0W9zbQS09KNre6jnVe0ymT/mUTMIUCFmeDTFOeHNfH7gRA
         jC804c/Q1q7DPotxIxtW4ACoc87XJsLYov8pztvhXMLsfFCcIhcn+GBJE9VIaVsiQqMf
         2fYAnl03BnDyUSNaZ9qTzGFebjethHgAOu8vSLc/FvTWYxIxST5DDiY9oq5q5YxFZqPB
         u9LbSVCMpSjucgXQvm8eug+yAp4yjgMpuCsmXeDfk6En7AWYFiCPfITA8t9XWuP2ujUz
         x1jA==
X-Gm-Message-State: APjAAAXFnZeFR++d16P5d+nntYo/5DenctKlG8GVbUI6qJrokdobkNjs
        hPFSqPlIxTWvzyCt5ZufQfk=
X-Google-Smtp-Source: APXvYqwmCNUYadyi+djNR2rOIK2AFruwpVc75QuZRZcQmF5+/CpharvSkeqeCgT/hxB57BvsocJnRg==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr5821072wrj.179.1556176623743;
        Thu, 25 Apr 2019 00:17:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a4sm14975390wrr.39.2019.04.25.00.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 00:17:03 -0700 (PDT)
Date:   Thu, 25 Apr 2019 09:17:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        bp@alien8.de, Jason Chen CJ <jason.cj.chen@intel.com>
Subject: Re: [RFC PATCH v5 3/4] x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for
 ACRN guest upcall vector
Message-ID: <20190425071700.GB57256@gmail.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556067260-9128-4-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhao Yakui <yakui.zhao@intel.com> wrote:

> Linux kernel uses the HYPERVISOR_CALLBACK_VECTOR for hypervisor upcall
> vector. And it is already used for Xen and HyperV.

English sentences should not be started with 'and'.

> After ACRN hypervisor is detected, it will also use this defined vector
> to notify ACRN guest.

Missing 'the', twice.

> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ACRN_H
> +#define _ASM_X86_ACRN_H
> +
> +void acrn_hv_callback_vector(void);

Please mark these with 'extern', as customary in x86 headers.

>  
> +#include <linux/interrupt.h>
> +#include <asm/acrn.h>
> +#include <asm/desc.h>
>  #include <asm/hypervisor.h>
> +#include <asm/irq_regs.h>
>  
>  static uint32_t __init acrn_detect(void)
>  {
> @@ -18,6 +22,8 @@ static uint32_t __init acrn_detect(void)
>  
>  static void __init acrn_init_platform(void)
>  {
> +	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
> +			acrn_hv_callback_vector);

Why is this on two lines, not a single line?

> +static void (*acrn_intr_handler)(void);
> +
> +__visible void __irq_entry acrn_hv_vector_handler(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	entering_ack_irq();

Does the hypervisor model the APIC EOI command, i.e. does it require the 
APIC to be acked? I.e. would not acking the APIC create an IRQ storm?

> +	inc_irq_stat(irq_hv_callback_count);
> +
> +	if (acrn_intr_handler)
> +		acrn_intr_handler();

Nothing appears to be setting acrn_intr_handler, so this will never 
execute anything? Is more code relying on this?

Thanks,

	Ingo
