Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B41C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C72341C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfHTHqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:46:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:34413 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:46:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46CNCL0NxNz1rK4l;
        Tue, 20 Aug 2019 09:46:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46CNCK6d0dz1qqkQ;
        Tue, 20 Aug 2019 09:46:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id h_MA-htdbiCz; Tue, 20 Aug 2019 09:46:21 +0200 (CEST)
X-Auth-Info: prE92elRMKSf1/jqoEhkE2DLPPA8p3cg3p+PYrMx3HIkJWlUjiRKFPESlmwx3WsX
Received: from hawking (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Aug 2019 09:46:21 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "hch\@infradead.org" <hch@infradead.org>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
References: <20190820004735.18518-1-atish.patra@wdc.com>
X-Yow:  When you get your PH.D. will you get able to work at BURGER KING?
Date:   Tue, 20 Aug 2019 09:46:20 +0200
In-Reply-To: <20190820004735.18518-1-atish.patra@wdc.com> (Atish Patra's
        message of "Mon, 19 Aug 2019 17:47:35 -0700")
Message-ID: <mvmh86cl1o3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 19 2019, Atish Patra <atish.patra@wdc.com> wrote:

> @@ -42,20 +43,44 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>  
>  #include <asm/sbi.h>
>  
> -static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
> -				     unsigned long size)
> +static void __riscv_flush_tlb(struct cpumask *cmask, unsigned long start,
> +			      unsigned long size)

cmask can be const.

>  {
>  	struct cpumask hmask;
> +	unsigned int hartid;
> +	unsigned int cpuid;
>  
>  	cpumask_clear(&hmask);
> +
> +	if (!cmask) {
> +		riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
> +		goto issue_sfence;
> +	}

Wouldn't it make sense to fall through to doing a local flush here?

	if (!cmask)
		cmask = cpu_online_mask;

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
