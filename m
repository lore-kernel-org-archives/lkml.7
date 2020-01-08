Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E733AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C488820692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgAHQ5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:57:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgAHQ5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:57:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D26F20678;
        Wed,  8 Jan 2020 16:57:08 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:57:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/ftrace: fix building on BE32
Message-ID: <20200108115707.2419bf97@gandalf.local.home>
In-Reply-To: <20200108143640.1034808-1-arnd@arndb.de>
References: <20200108143640.1034808-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Jan 2020 15:36:30 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> Compiling patch.c on BE32 fails because there is no definition
> of __opcode_to_mem_thumb32()
> 
> arch/arm/kernel/patch.c: In function '__patch_text_real':
> arch/arm/kernel/patch.c:94:11: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]
> 
> Since we don't actually call it, only a declaration is required
> here, add one without a definition that fixes the build here
> but will cause a link failure if someone actually relies on the
> result.
> 
> Fixes: 5a735583b764 ("arm/ftrace: Use __patch_text()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure if this version is any less ugly than the first
> approach of adding an #ifdef in patch.c

Adding #ifdef in headers is always better than adding it in C code.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  arch/arm/include/asm/opcodes.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
> index 6bff94b2372b..f75f59c1257a 100644
> --- a/arch/arm/include/asm/opcodes.h
> +++ b/arch/arm/include/asm/opcodes.h
> @@ -110,14 +110,19 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
>  #define __opcode_to_mem_thumb16(x) ___opcode_identity16(x)
>  #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
>  #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
> -#ifndef CONFIG_CPU_ENDIAN_BE32
>  /*
>   * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
>   * work in all cases, due to alignment constraints.  For now, a correct
> - * version is not provided for BE32.
> + * version is not provided for BE32, only an extern declaration to allow
> + * compiling patch.c
>   */
> +#ifndef CONFIG_CPU_ENDIAN_BE32
>  #define __opcode_to_mem_thumb32(x) ___opcode_swahw32(x)
>  #define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahw32(x)
> +#else
> +#ifndef __ASSEMBLY__
> +extern unsigned __opcode_to_mem_thumb32(unsigned);
> +#endif
>  #endif
>  
>  #endif /* ! CONFIG_CPU_ENDIAN_BE8 */

