Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A38C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D420675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmLqJH7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCGTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:07:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:07:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so12149953pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJo3uciM39NhXlTu5MfFJc8kc/AFbixp4LrAaMojqpk=;
        b=HmLqJH7ExI/1GMiYWLC9yiCqlFRKvfGJ6wascFNL0v+hL6q8WBPzr/TmsjrDc5PcHf
         etq3QYyaq1CKhFwdiKQzeZBt+G/iKMiy5tNEQJLcerIfU4TP7e8C5qz72wrAn6ADb2oQ
         80zI+t3zxImQpmNV4kCFzcsb9WS/2wXs9qbhlSS6lAS1w43H2phmPtAs7GTigdm5y1zS
         tJxVedVHUdePAzUzqvziHNjQnkaukFikQ73mITssZjcL7Sm8F+bzTQZcj3kWZARJS4AI
         kScySqKDeya8TQlmMmNOd8kt9EIXxp9EupLbwO6X3Oph2GlF332GN8rmc+1Z9XiTxBvN
         Me1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJo3uciM39NhXlTu5MfFJc8kc/AFbixp4LrAaMojqpk=;
        b=WkaYOFYtaY/LVl5paBmX/7nWvCf+5J0XiyZcNS90ctZ8puwbNWl48t8Wb4QcR9DF08
         VLqI4xHhr4QcZBllDEbVw+TzcJ+vXuEnI8A5uVe6NqAN9mtMns2EPtml9co3koi9Tnld
         VsX6n/csUdCO0/94K4jgtC5AvKBXubQcEn01Qhe5Y2qqD5K3PDR7Qe2706XSvOCf5yex
         WSVDAEdpVe0NSyj5yJz67OkkySsqW17d0MNMZ0XWvm3n5+LkDz18U+p8EqiMlfrjgWcH
         L0llRi9YQbw8KWZuC1ScIjtMQDfxPUDfXBaRwGnWbyPHBspspsiqVMHlkbx8RJnHobZf
         18Ew==
X-Gm-Message-State: APjAAAX5+201rfY1vP2kyMHD/17b7Egkz6lmEkAuecuAuDSAGpR7rPSD
        wdMqwj0/QhfKV5YbyUDZ+1w=
X-Google-Smtp-Source: APXvYqxugiHnbPs2QU9XSjsowDZTCf1y0ys8JdnXlYVGUbhhqp9t1jVMiFFqTE1QycN1DQI3IhHQDQ==
X-Received: by 2002:a63:5702:: with SMTP id l2mr12925683pgb.2.1551985671593;
        Thu, 07 Mar 2019 11:07:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s79sm11183894pfa.61.2019.03.07.11.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 11:07:50 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:07:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/10] powerpc/6xx: Store PGDIR physical address in a
 SPRG
Message-ID: <20190307190748.GA21622@roeck-us.net>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
 <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
 <20190307141143.GA26761@roeck-us.net>
 <2acc1691-0f74-8843-ecdd-64ba8705de20@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acc1691-0f74-8843-ecdd-64ba8705de20@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 06:14:09PM +0000, Christophe Leroy wrote:
> Hi,
> 
> On 03/07/2019 02:11 PM, Guenter Roeck wrote:
> >Hi,
> >
> >On Thu, Feb 21, 2019 at 10:37:55AM +0000, Christophe Leroy wrote:
> >>Use SPRN_SPRG2 to store the current thread PGDIR and
> >>avoid reading thread_struct.pgdir at every TLB miss.
> >>
> >This patch causes a number of silent (no crash) qemu boot stalls
> >in -next. See
> >https://kerneltests.org/builders/qemu-ppc-next/builds/1080/steps/qemubuildcommand/logs/stdio
> >for an example.
> 
> Oops.
> Could you try the fix below ?
> 

Yes, that does the trick. With this patch applied on top of next-20190306,
all my ppc qemu boot tests pass.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S
> b/arch/powerpc/kernel/cpu_setup_6xx.S
> index 6f1c11e0691f..7534ecff5e92 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -24,9 +24,6 @@ BEGIN_MMU_FTR_SECTION
>  	li	r10,0
>  	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
>  END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> -	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
> -	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
> -	mtspr	SPRN_SPRG_PGDIR, r10
> 
>  BEGIN_FTR_SECTION
>  	bl	__init_fpu_registers
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index ce6a972f2584..48051c8977c5 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -855,6 +855,9 @@ __secondary_start:
>  	li	r3,0
>  	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>  #endif
> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
> +	mtspr	SPRN_SPRG_PGDIR, r4
> 
>  	/* enable MMU and jump to start_secondary */
>  	li	r4,MSR_KERNEL
> @@ -942,6 +945,9 @@ start_here:
>  	li	r3,0
>  	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>  #endif
> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
> +	mtspr	SPRN_SPRG_PGDIR, r4
> 
>  	/* stack */
>  	lis	r1,init_thread_union@ha
> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index 1f13494efb2b..587e4550d83e 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -70,12 +70,12 @@ _GLOBAL(hash_page)
>  	lis	r0,KERNELBASE@h		/* check if kernel address */
>  	cmplw	0,r4,r0
>  	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
> -	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
> +	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
>  	blt+	112f			/* assume user more likely */
> -	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
> -	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
> +	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
> +	addi	r5 ,r5 , (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
>  	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
> -112:	tophys(r5, r5)
> +112:
>  #ifndef CONFIG_PTE_64BIT
>  	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
>  	lwz	r8,0(r5)		/* get pmd entry */
> 
> 
> Thanks
> Christophe
> 
> >
> >Unfortunately, it is not possible to revert the patch due to subsequent
> >patches, so I was unable to test a revert.
> >
> >Bisect log is attached.
> >
> >Guenter
> >
> >---
> ># bad: [cf08baa29613dd899954089e7cc7dba1d478b365] Add linux-next specific files for 20190306
> ># good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
> >git bisect start 'HEAD' 'v5.0'
> ># bad: [6cc8f3499ec8d31904ab9083980a91736512cb37] Merge remote-tracking branch 'vfs/for-next'
> >git bisect bad 6cc8f3499ec8d31904ab9083980a91736512cb37
> ># good: [63bdf4284c38a48af21745ceb148a087b190cd21] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> >git bisect good 63bdf4284c38a48af21745ceb148a087b190cd21
> ># good: [520b5fc601ab760fee7ea0c403b42d04e8ebfd93] Merge remote-tracking branch 'arm-soc/for-next'
> >git bisect good 520b5fc601ab760fee7ea0c403b42d04e8ebfd93
> ># bad: [d7f54e4e0d4e90f5df78da8d6a830bafad3b535a] Merge remote-tracking branch 'xtensa/xtensa-for-next'
> >git bisect bad d7f54e4e0d4e90f5df78da8d6a830bafad3b535a
> ># good: [0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f] Merge remote-tracking branch 'clk/clk-next'
> >git bisect good 0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f
> ># bad: [fb0b0a73b223fc113e961b1d921322844e9c30d9] powerpc: Enable kcov
> >git bisect bad fb0b0a73b223fc113e961b1d921322844e9c30d9
> ># good: [d0055df0c9c1471c389197a69f43e300185a75aa] Merge branch 'topic/dma' into next
> >git bisect good d0055df0c9c1471c389197a69f43e300185a75aa
> ># good: [0df977eafc792a5365a7f81d8d5920132e03afad] powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
> >git bisect good 0df977eafc792a5365a7f81d8d5920132e03afad
> ># bad: [665bed2386e5dc29844ad78c7ef1464664b103ec] powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
> >git bisect bad 665bed2386e5dc29844ad78c7ef1464664b103ec
> ># bad: [78ca1108b10927b3d068c8da91352b0f4cd01fc5] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
> >git bisect bad 78ca1108b10927b3d068c8da91352b0f4cd01fc5
> ># bad: [a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee] powerpc/603: Don't handle kernel page TLB misses when not need
> >git bisect bad a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee
> ># bad: [2c12393f577396a51b7e0537bd3eb29dcc26dc1b] powerpc/603: use physical address directly in TLB miss handlers.
> >git bisect bad 2c12393f577396a51b7e0537bd3eb29dcc26dc1b
> ># bad: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
> >git bisect bad 93c4a162b014d238a287f8264adb25c009c79e61
> ># first bad commit: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
> >
