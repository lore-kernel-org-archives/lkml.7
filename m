Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE51C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8BE20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oMeGLKfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfILNsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:48:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46341 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfILNsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:48:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id v11so29555614qto.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKkk8JOcHxODl2WFnm1Rghz+daQvfyVneTOsrZmsJ4k=;
        b=oMeGLKfj0ZzTBSi+GKe9O02YwndGj3Ia4Nwi4Q7OXG4tD/6XWsn/cteOXh+cXL63h1
         rzM4QokqWOhUDvER/NKcfzZAjx1FSVZFgxsvsBhIjsaQ10TnR9hf+URAGZ5W84aKdrFA
         kVzXvYlNz0OwGFOQ1iM16sOdYVdaksS9BpU4oE0misV5seyzXCEdZR7b7vlJMfYRGKsB
         QKR0mGRgJVmyx13h8/rphW7k2ggS3bLFiDiXIlaEb8SnJdUOT0AZlbm6rj1RWOj/rV/Y
         EPOFyTMmGYu22gs851nSlU4KjUqLCjAV0fgY7gpYaV3W64mahKEtb53wH4Uh1ugSN044
         GQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKkk8JOcHxODl2WFnm1Rghz+daQvfyVneTOsrZmsJ4k=;
        b=oDQfuiBhRVVY8LzE91edKHqzdFn8aKqfvAOb4RJXxRfTz0lw8wdx0xFFs+ea8AC6BG
         2TZSopZ8MFrCcuQfn4Zy1WAtzzf5P8AgX2jt05hlmpGVV+T0Ft1chrWr/3Mjb/gkn6mm
         wUnB2cKR7rmGEThAIuUcLVpp+Kwul8+zZIX5ZsdVO8Kx50Hsf9W9oZrJeoS7t+5B/HYE
         mmtKT43ce6cDd1UBXMO7/qbm2LD3u+TLZ/EwwvsJ/w07QsBFA0DC/fhF81V5MIi6RV1v
         3E+xBu7aJwY15uiUErsMbHxp58Y7DrQBL8cxiT3hrm7CQhuio8SaEukTC5vs+9VRuxGO
         oQag==
X-Gm-Message-State: APjAAAUhaWxZJhGL5cxr6Sbl9BH34unehgvtXbpcmPKoSuRWCPlQ7Pbc
        kFPqou9pT8S1mUpECeQ0s7K6z+N2ixo=
X-Google-Smtp-Source: APXvYqxCe2JMNq1Ggi+fPGa/aLOY3Yy1INyO1KSi1s+atLHs2+agFimmaZvKZC3WEMTxCIm/3yjdxw==
X-Received: by 2002:ac8:5296:: with SMTP id s22mr40614483qtn.139.1568296085053;
        Thu, 12 Sep 2019 06:48:05 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h29sm15126219qtb.46.2019.09.12.06.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:48:04 -0700 (PDT)
Message-ID: <1568296082.5576.141.camel@lca.pw>
Subject: Re: [PATCH] powerpc/mm/radix: remove useless kernel messages
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Sep 2019 09:48:02 -0400
In-Reply-To: <1566570120-16529-1-git-send-email-cai@lca.pw>
References: <1566570120-16529-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, Aneesh, please take a take at this trivial patch.

On Fri, 2019-08-23 at 10:22 -0400, Qian Cai wrote:
> Booting a POWER9 PowerNV system generates a few messages below with
> "____ptrval____" due to the pointers printed without a specifier
> extension (i.e unadorned %p) are hashed to prevent leaking information
> about the kernel memory layout.
> 
> radix-mmu: Initializing Radix MMU
> radix-mmu: Partition table (____ptrval____)
> radix-mmu: Mapped 0x0000000000000000-0x0000000040000000 with 1.00 GiB
> pages (exec)
> radix-mmu: Mapped 0x0000000040000000-0x0000002000000000 with 1.00 GiB
> pages
> radix-mmu: Mapped 0x0000200000000000-0x0000202000000000 with 1.00 GiB
> pages
> radix-mmu: Process table (____ptrval____) and radix root for kernel:
> (____ptrval____)
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index b4ca9e95e678..b6692ee9411d 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -386,7 +386,6 @@ static void __init radix_init_pgtable(void)
>  	 * physical address here.
>  	 */
>  	register_process_table(__pa(process_tb), 0, PRTB_SIZE_SHIFT - 12);
> -	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
>  	asm volatile("ptesync" : : : "memory");
>  	asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
>  		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
> @@ -420,7 +419,6 @@ static void __init radix_init_partition_table(void)
>  	mmu_partition_table_set_entry(0, dw0, 0);
>  
>  	pr_info("Initializing Radix MMU\n");
> -	pr_info("Partition table %p\n", partition_tb);
>  }
>  
>  void __init radix_init_native(void)
