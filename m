Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2626C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9064E233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwC223b9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389953AbfHVQaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:30:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40328 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389939AbfHVQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:30:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so6013347wrd.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+mOx0lYqD6ocklkpSaGRwmKmSPyTCbL4pINdnHHHgs=;
        b=uwC223b9YBE+s6I+Q969S0WnnbC7HMjX99bxpVm5u0z6YeploaaywvumGsA5E2h4Zp
         iFEhakxCkohR8wwJIjlq37R4n3YTS55Txybs0rODpcov6zeO/Oepg6J8Y6M6p4W7TFI2
         yNk8JkFZBnGdi7QxUaJFp5Bi+YPAnHvLk8m3KjM9iD+pnlJtyINC+OHOOK5a7H+8dzBp
         MsnCVg+Y4h90s5CqnBi5G2ZJJReNVHD7+rz0juY7fgHq/ITDq7EXxsB1F2vtNqpIn4aO
         1U50NU1pzwGYZgGda4WGKXVGxMtrkeK47357m+uZ3mgVs8VwgdkyC/Hb+pATyk8Jtdkx
         4y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+mOx0lYqD6ocklkpSaGRwmKmSPyTCbL4pINdnHHHgs=;
        b=murMxtuzhum2xOF9xiz+0boWODUhydT/WN+Bm8vP+gEhPnGKLzhuUk3BBfU0g6jocA
         3qGfn1wo+9KoajiN9Kg/9ZZ/P9excW17d47S/qdE+aXiFL58TiRBHqKahMkgSs2Ibg1u
         BjOopvcLHI0WpSgOIqseZBm0WqCJfbhk1LTvK0uAHJK8qbgHXKp6kvnO4LoY0U9f2710
         3HtCRihIR21hWlJ7Nu6Gygkow4stHJsM6EIR5xxQmuJWIWoDOiIW7Tj1LClWBpaEeClR
         HUAayQHlvM6U/sWKhKBM8Hjp64/JJoHH0pj3bYYhLIJUwJvu9KnokCXl72kVToNL5Nge
         CRog==
X-Gm-Message-State: APjAAAVEkiULqqyoZlTT/oWq6bhGDNNiMfU92B6EFgHTql/uEEcO0sA4
        F/uulEI80cqjYt2FgkjQ3Xc=
X-Google-Smtp-Source: APXvYqyZw6pEh9lK6SgHYRMwyVB+kdGlXlDoeVipFIgsisWJHKxnMbyQZhsgUlZH2BGfWkmNu4MAqQ==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr5680295wrn.84.1566491411300;
        Thu, 22 Aug 2019 09:30:11 -0700 (PDT)
Received: from [192.168.1.67] (host81-157-241-155.range81-157.btcentralplus.com. [81.157.241.155])
        by smtp.gmail.com with ESMTPSA id v12sm49438wrr.87.2019.08.22.09.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:30:10 -0700 (PDT)
Subject: Re: [RFC v4 01/18] objtool: Add abstraction for computation of
 symbols offsets
To:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        raph.gault+kdev@gmail.com
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-2-raphael.gault@arm.com>
From:   Julien <julien.thierry.kdev@gmail.com>
Message-ID: <7bdc1178-e916-7d21-eb54-bea27fcadc17@gmail.com>
Date:   Thu, 22 Aug 2019 17:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190816122403.14994-2-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphaël,

On 16/08/19 13:23, Raphael Gault wrote:
> The jump destination and relocation offset used previously are only
> reliable on x86_64 architecture. We abstract these computations by calling
> arch-dependent implementations.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>   tools/objtool/arch.h            |  6 ++++++
>   tools/objtool/arch/x86/decode.c | 11 +++++++++++
>   tools/objtool/check.c           | 15 ++++++++++-----
>   3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index ced3765c4f44..a9a50a25ca66 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -66,6 +66,8 @@ struct stack_op {
>   	struct op_src src;
>   };
>   
> +struct instruction;
> +
>   void arch_initial_func_cfi_state(struct cfi_state *state);
>   
>   int arch_decode_instruction(struct elf *elf, struct section *sec,
> @@ -75,4 +77,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>   
>   bool arch_callee_saved_reg(unsigned char reg);
>   
> +unsigned long arch_jump_destination(struct instruction *insn);
> +
> +unsigned long arch_dest_rela_offset(int addend);
> +
>   #endif /* _ARCH_H */
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 0567c47a91b1..fa33b3465722 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -11,6 +11,7 @@
>   #include "lib/inat.c"
>   #include "lib/insn.c"
>   
> +#include "../../check.h"
>   #include "../../elf.h"
>   #include "../../arch.h"
>   #include "../../warn.h"
> @@ -66,6 +67,11 @@ bool arch_callee_saved_reg(unsigned char reg)
>   	}
>   }
>   
> +unsigned long arch_dest_rela_offset(int addend)
> +{
> +	return addend + 4;
> +}
> +
>   int arch_decode_instruction(struct elf *elf, struct section *sec,
>   			    unsigned long offset, unsigned int maxlen,
>   			    unsigned int *len, enum insn_type *type,
> @@ -497,3 +503,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
>   	state->regs[16].base = CFI_CFA;
>   	state->regs[16].offset = -8;
>   }
> +
> +unsigned long arch_jump_destination(struct instruction *insn)
> +{
> +	return insn->offset + insn->len + insn->immediate;
> +}
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 176f2f084060..479fab46b656 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -563,7 +563,7 @@ static int add_jump_destinations(struct objtool_file *file)
>   					       insn->len);
>   		if (!rela) {
>   			dest_sec = insn->sec;
> -			dest_off = insn->offset + insn->len + insn->immediate;
> +			dest_off = arch_jump_destination(insn);
>   		} else if (rela->sym->type == STT_SECTION) {
>   			dest_sec = rela->sym->sec;
>   			dest_off = rela->addend + 4;
> @@ -659,7 +659,7 @@ static int add_call_destinations(struct objtool_file *file)
>   		rela = find_rela_by_dest_range(insn->sec, insn->offset,
>   					       insn->len);
>   		if (!rela) {
> -			dest_off = insn->offset + insn->len + insn->immediate;
> +			dest_off = arch_jump_destination(insn);
>   			insn->call_dest = find_symbol_by_offset(insn->sec,
>   								dest_off);
>   
> @@ -672,14 +672,19 @@ static int add_call_destinations(struct objtool_file *file)
>   			}
>   
>   		} else if (rela->sym->type == STT_SECTION) {
> +			/*
> +			 * the original x86_64 code adds 4 to the rela->addend
> +			 * which is not needed on arm64 architecture.
> +			 */

I'm not sure this is worth mentioning in generic code. You might include 
it in the commit message to justify the change.

> +			dest_off = arch_dest_rela_offset(rela->addend);
>   			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
> -								rela->addend+4);
> +								dest_off);
>   			if (!insn->call_dest ||
>   			    insn->call_dest->type != STT_FUNC) {
> -				WARN_FUNC("can't find call dest symbol at %s+0x%x",
> +				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
>   					  insn->sec, insn->offset,
>   					  rela->sym->sec->name,
> -					  rela->addend + 4);
> +					  dest_off);
>   				return -1;
>   			}
>   		} else
> 

Otherwise, the change looks good to me.

Thanks,

-- 
Julien Thierry
