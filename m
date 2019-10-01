Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABDECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA00020815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569936075;
	bh=QYSllP9/ys/7IY6OqXAXwvvPaklbnIJyDItt8Dcq5lY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XI5R+Muw1wWhfDIbdvuug3p21SFNjwrnv/R07bBZCmai3a1+Po3PGQWyMCPPnjBxX
	 QtwDOPk/yQX/xmwqlaec/uOAj/8DhhS6LleEPWh7aQHElJ+kcN2EAzEjEdpw4qqJr+
	 vyngMbziVv71DB1VJr5kMovHlIZ4NiW781Lt6DvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfJANVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388212AbfJANVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:21:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01B6205F4;
        Tue,  1 Oct 2019 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569936073;
        bh=QYSllP9/ys/7IY6OqXAXwvvPaklbnIJyDItt8Dcq5lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzJug3FJYMFIwyKDen3q25TZR5cluR7qieTbzsU3WaMfE18VvgMlfBxWVGfYaGSJ/
         Q63nru9hgzDq8nieQkpJU2IUwDuYrrlifkK0AVXZi349v2SS/FU9FNNaWbTj+WGQ3B
         FHNlA9eeVeIHQ8sNmVuNTMMZHl7Y3VlZlZBd/Qas=
Date:   Tue, 1 Oct 2019 14:21:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 3/5] arm64: vdso32: Fix compilation warning
Message-ID: <20191001132108.jx2x7quyk2p2vyfw@willie-the-truck>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926214342.34608-4-vincenzo.frascino@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:40PM +0100, Vincenzo Frascino wrote:
> As reported by Will Deacon the following compilation warning appears
> during the compilation of the vdso32:
> 
> In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/arm64/include/asm/preempt.h:5,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from .../work/linux/lib/vdso/gettimeofday.c:7,
>                  from <command-line>:0:
> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>                ^
> In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
>                  from ./arch/arm64/include/asm/processor.h:34,
>                  from ./arch/arm64/include/asm/elf.h:118,
>                  from ./include/linux/elf.h:5,
>                  from ./include/linux/elfnote.h:62,
>                  from arch/arm64/kernel/vdso32/note.c:11:
> ./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
> ./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>   u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>                ^
> 
> This happens because few 64 bit compilation headers are included during
> the generation of vdso32.
> 
> Fix the issue redefining the __tag_set function.
> 
> Note: This fix is meant to be temporary, a more comprehensive solution
> based on the refactoring of the generic headers will be provided with a
> future patch set. At that point it will be possible to revert this patch.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/memory.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b61b50bf68b1..c61b2eb50a3b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -228,11 +228,14 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_get(addr)		0
>  #endif /* CONFIG_KASAN_SW_TAGS */
>  
> +#ifdef __aarch64__
> +/* Do not attempt to compile this code with compat vdso */
>  static inline const void *__tag_set(const void *addr, u8 tag)
>  {
>  	u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>  	return (const void *)(__addr | __tag_shifted(tag));
>  }
> +#endif

Sorry, but I'm not taking this.

I know you're trying to fix the issues I reported as quickly as you can (and
thank you for that), but I'm sure that you agree this needs more thought to
develop a proper solution to what is a much bigger issue than can be solved
by sprinkling #ifdefs. I can live with the warning on the basis that a
proper fix is in the pipeline, but in the meantime it can serve as a
reminder that we're not done here.

Will
