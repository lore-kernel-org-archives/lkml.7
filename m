Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16190C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9CF206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qge9FMNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfH0ODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:03:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0ODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hl8svcAvSlazt0+rAk+TpsMNvw0DYfmMevZpbRXZEJ0=; b=Qge9FMNOdFQbBh+DYHEeSB6zM
        Xi/oK5Yvkr5IeHFhQNk6iFtCDdLFMTORNeEgZvBeWUa76EIp8Y7eKzuxg2YjCCkyNaLuoBFjTUF7L
        3Ss6TFYYS6tIQ/0uzpdX+/ivNPU5DX0Z3Ze7m4T9Yw0q779VPHmYmJq9FitUP17It0rNDSj0hixD8
        Zl9tiWzIuPgFEuCX8DfIfW5KhtnWkdRF6KPQ7JYVEuZdsB7b5RZTXA3UZw+RZC1MqO7//chqWzhmq
        TrSDd0bWLhe/yA5fqrYLwHQGBfbqctcnlM7kWWlLsbQKtIj/c4hTy2wWue7hzmyboJ58H4lIxfs9X
        seK+ai+ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i2c3s-0003ua-DN; Tue, 27 Aug 2019 14:03:04 +0000
Date:   Tue, 27 Aug 2019 07:03:04 -0700
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
Subject: Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
Message-ID: <20190827140304.GA21855@infradead.org>
References: <20190826233256.32383-1-atish.patra@wdc.com>
 <20190826233256.32383-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233256.32383-2-atish.patra@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define SBI_EXT_LEGACY_SET_TIMER 0x0
> +#define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
> +#define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
> +#define SBI_EXT_LEGACY_CLEAR_IPI 0x3
> +#define SBI_EXT_LEGACY_SEND_IPI 0x4
> +#define SBI_EXT_LEGACY_REMOTE_FENCE_I 0x5
> +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA 0x6
> +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
> +#define SBI_EXT_LEGACY_SHUTDOWN 0x8

As Mike said legacy is a bit of a weird name.  I think this should
be SBI01_* or so.  And pleae align the numeric values and maybe use
an enum.

> +
> +#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
>  	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);	\
>  	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);	\
>  	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);	\

Instead of the weird inline assembly with forced register allocation,
why not move this to pure assembly?  AFAICs this is the whole assembly
code we'd need:

ENTRY(sbi01_call)
        ecall
END(sbi01_call)

>  /* Lazy implementations until SBI is finalized */
> -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
> -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
> -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
> -#define SBI_CALL_3(which, arg0, arg1, arg2) \
> -		SBI_CALL(which, arg0, arg1, arg2, 0)
> -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
> -		SBI_CALL(which, arg0, arg1, arg2, arg3)
> +#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
> +#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
> +#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
> +		SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)

When you touch this anyway I'd suggest you kill these rather
pointless wrappers as well as the comment above them.
