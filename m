Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F1C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456342087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfFPSAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 14:00:49 -0400
Received: from stingray.exigere.com.au ([162.217.113.74]:45630 "EHLO
        stingray.exigere.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfFPSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 14:00:49 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2019 14:00:49 EDT
Received: from hippo.sing.id.au (exi2311632.lnk.telstra.net [144.139.233.124])
        by stingray.exigere.com.au (OpenSMTPD) with ESMTPSA id b42fe4cc (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 17 Jun 2019 04:17:28 +1000 (AEST)
Received: from localhost (hippo.sing.id.au [local])
        by hippo.sing.id.au (OpenSMTPD) with ESMTPA id 67ebf947;
        Mon, 17 Jun 2019 03:54:06 +1000 (AEST)
Date:   Mon, 17 Jun 2019 03:54:06 +1000
From:   Joel Sing <joel@sing.id.au>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: Break load reservations during switch_to
Message-ID: <20190616175405.GF61734@hippo.sing.id.au>
References: <20190607222222.15300-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607222222.15300-1-palmer@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-07 15:22:22, Palmer Dabbelt wrote:
> The comment describes why in detail.  This was found because QEMU never
> gives up load reservations, the issue is unlikely to manifest on real
> hardware.

Makes sense, however it obviously will not help until qemu actually
clears load reservations on SC (or otherwise handles the interleaved
SC case).

See comment inline.

> Thanks to Carlos Eduardo for finding the bug!
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
> Changes since v1 <20190605231735.26581-1-palmer@sifive.com>:
> 
> * REG_SC is now defined as a helper macro, for any code that wants to SC
>   a register-sized value.
> * The explicit #ifdef to check that TASK_THREAD_RA_RA is 0 has been
>   removed.  Instead we rely on the assembler to catch non-zero SC
>   offsets.  I've tested this does actually work.
> 
>  arch/riscv/include/asm/asm.h |  1 +
>  arch/riscv/kernel/entry.S    | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 5ad4cb622bed..946b671f996c 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -30,6 +30,7 @@
>  
>  #define REG_L		__REG_SEL(ld, lw)
>  #define REG_S		__REG_SEL(sd, sw)
> +#define REG_SC		__REG_SEL(sc.w, sc.d)

The instructions appear to be inverted here (i.e. "sc.d, sc.w").

>  #define SZREG		__REG_SEL(8, 4)
>  #define LGREG		__REG_SEL(3, 2)
>  
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 1c1ecc238cfa..af685782af17 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -330,6 +330,17 @@ ENTRY(__switch_to)
>  	add   a3, a0, a4
>  	add   a4, a1, a4
>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
> +	/*
> +	 * The Linux ABI allows programs to depend on load reservations being
> +	 * broken on context switches, but the ISA doesn't require that the
> +	 * hardware ever breaks a load reservation.  The only way to break a
> +	 * load reservation is with a store conditional, so we emit one here.
> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
> +	 * know this will always fail, but just to be on the safe side this
> +	 * writes the same value that was unconditionally written by the
> +	 * previous instruction.
> +	 */
> +	REG_SC x0, ra, TASK_THREAD_RA_RA(a3)
>  	REG_S sp,  TASK_THREAD_SP_RA(a3)
>  	REG_S s0,  TASK_THREAD_S0_RA(a3)
>  	REG_S s1,  TASK_THREAD_S1_RA(a3)
> -- 
> 2.21.0
> 
