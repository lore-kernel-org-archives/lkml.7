Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DB3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB6F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sf8vBT1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfH0OLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:11:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0OLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jn68BdvZhJrmEXMt74AaFJ4t5OFYoY/FSvB04ozunVk=; b=Sf8vBT1TC/Qn3jbU46GFV/fPn
        pY8Os4CfxDsanw82XFqNEsUjR1fk17yNzSxH4zqssCMYkJL5uctl2L7st0SqAtQQApp5NpN66RiY4
        2t6KLu2SyF1PnMFxashJAtAxDl0BZDbNRQ5zlt6mwkgszxFilA7z2vWvidwev8jRCJ6ozoUZOw5UL
        2gvXPcB1c2CgNW6B9lvVv3Tulb5MfEEX+22aMo6CPZVPKIZRyW0YpvzJstm3OPDUt+ybRKsEWlUzt
        t5PHAQvzzeZx2LXhVWxxdP+cO88KmEZU16ozAFDTQwNyF9eilVKc/9LDY9vZ7F/DEABmHkjQQ0dhH
        RywpB7qDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2cC2-0007KK-LQ; Tue, 27 Aug 2019 14:11:30 +0000
Date:   Tue, 27 Aug 2019 07:11:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add basic support for SBI v0.2
Message-ID: <20190827141130.GC21855@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190826233256.32383-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233256.32383-3-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define SBI_EXT_BASE 0x10

I think you want an enum enumerating the extensions.

> +#define SBI_CALL_LEGACY(ext, fid, arg0, arg1, arg2, arg3) ({	\
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
>  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
>  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\
>  	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);	\
> -	register uintptr_t a7 asm ("a7") = (uintptr_t)(which);	\
> +	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);	\
> +	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);	\

This seems to break the calling convention.  I also think we should go
back to the Unix platform working group and make the calling convention
backwards compatible.  There is really no advantage or disadvantag
in swapping a6 and a7 in the calling convention itself, but doing so
means you can just push the ext field in always and it will be
ignored by the old sbi.

> +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> +			       int arg2, int arg3);
> +
> +#define SBI_CALL_0(ext, fid) riscv_sbi_ecall(ext, fid, 0, 0, 0, 0)
> +#define SBI_CALL_1(ext, fid, arg0) riscv_sbi_ecall(ext, fid, arg0, 0, 0, 0)
> +#define SBI_CALL_2(ext, fid, arg0, arg1) \
> +		riscv_sbi_ecall(ext, fid, arg0, arg1, 0, 0)
> +#define SBI_CALL_3(ext, fid, arg0, arg1, arg2) \
> +		riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, 0)
> +#define SBI_CALL_4(ext, fid, arg0, arg1, arg2, arg3) \
> +		riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, arg3)

Again, no point in having these wrappers.

> +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> +			     int arg2, int arg3)
> +{
> +	struct sbiret ret;
> +
> +	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +	asm volatile ("ecall"
> +		      : "+r" (a0), "+r" (a1)
> +		      : "r" (a2), "r" (a3), "r" (a6), "r" (a7)
> +		      : "memory");
> +	ret.error = a0;
> +	ret.value = a1;
> +
> +	return ret;

Again much simpler done in pure asm..

> +	/* legacy SBI version*/
> +	sbi_firmware_version = 0x1;
> +	ret = sbi_get_spec_version();
> +	if (!ret.error)
> +		sbi_firmware_version = ret.value;

Why not:

	ret = sbi_get_spec_version();
	if (ret.error)
		sbi_firmware_version = 0x1; /* legacy SBI */
	else
		sbi_firmware_version = ret.value;

btw, I'd find a calling convention that returns the value as a pointer
much nicer than the return by a struct.  Yes, the RISC-V ABI still
returns that in registers, but it is a pain in the b**t to use.  Without
that we could simply pass the variable to fill by reference.
