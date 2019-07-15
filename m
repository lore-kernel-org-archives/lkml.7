Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D3C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B69520868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfGOJFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:05:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfGOJFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:05:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so14345628wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egmDJtEjXK3av0tmMhAsLM9EbPwBz9YJTS8y1gbMsMk=;
        b=Mskq42cvP04DuYnJMKZf5AmKqH1cQTzfZI9bxGJJyNJSHdb+AkKiRh5Pb07YrN4KTw
         jj6OxUBaM4sYAc4IB2vc9h/qS2lHu8I0p8bEjSyhHoeSegI4IfJeSjsy/wOlH196hvm0
         Nd/FcMrmEjOqNG+B8hTsjv5bwdY9LH43/zcvTvjihoZlYQ5lLjOeoCTosNYbejiZoVTD
         r/dFy0UqzlA/ZCLnHCeP+1plcXGT5Y0q8hgrcx+UtRloR4TgroOximEWEvzx3B+1PFtc
         jIinwiEaWVIYldgX6q5BmzG/XiFti+wMRmXG7BYrapBwGfgfRdBzEEei3KswuVRBSXzZ
         XggA==
X-Gm-Message-State: APjAAAVyiOcyEvoY5D+iUpQIRjQO0sA+eg8iJsKPztqbTCFL64h++rgK
        6BbwZ9RAULYeKHE0Gu8ho0HTSQ==
X-Google-Smtp-Source: APXvYqyoYPZPqtS3k6O3cNZwDgQaA3ikdBZXFcNe+QAbkrqrOC6W0TK+vRHAktA1AaVnRVRWKNIa4w==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr24309151wmh.68.1563181501612;
        Mon, 15 Jul 2019 02:05:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e983:8394:d6:a612? ([2001:b07:6468:f312:e983:8394:d6:a612])
        by smtp.gmail.com with ESMTPSA id a6sm12382767wmj.15.2019.07.15.02.05.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:05:01 -0700 (PDT)
Subject: Re: [PATCH 02/22] x86/kvm: Fix fastop function ELF metadata
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <649348878d7def10e578e7a85ef853b6314f8979.1563150885.git.jpoimboe@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a78c29e4-5377-88c1-28a9-b04569fdb0c9@redhat.com>
Date:   Mon, 15 Jul 2019 11:05:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <649348878d7def10e578e7a85ef853b6314f8979.1563150885.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/19 02:36, Josh Poimboeuf wrote:
> Some of the fastop functions, e.g. em_setcc(), are actually just used as
> global labels which point to blocks of functions.  The global labels are
> incorrectly annotated as functions.  Also the functions themselves don't
> have size annotations.
> 
> Fixes a bunch of warnings like the following:
> 
>   arch/x86/kvm/emulate.o: warning: objtool: seto() is missing an ELF size annotation
>   arch/x86/kvm/emulate.o: warning: objtool: em_setcc() is missing an ELF size annotation
>   arch/x86/kvm/emulate.o: warning: objtool: setno() is missing an ELF size annotation
>   arch/x86/kvm/emulate.o: warning: objtool: setc() is missing an ELF size annotation
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  arch/x86/kvm/emulate.c | 44 +++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 8e409ad448f9..718f7d9afedc 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -312,29 +312,42 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
>  
>  static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
>  
> -#define FOP_FUNC(name) \
> +#define __FOP_FUNC(name) \
>  	".align " __stringify(FASTOP_SIZE) " \n\t" \
>  	".type " name ", @function \n\t" \
>  	name ":\n\t"
>  
> -#define FOP_RET   "ret \n\t"
> +#define FOP_FUNC(name) \
> +	__FOP_FUNC(#name)
> +
> +#define __FOP_RET(name) \
> +	"ret \n\t" \
> +	".size " name ", .-" name "\n\t"
> +
> +#define FOP_RET(name) \
> +	__FOP_RET(#name)
>  
>  #define FOP_START(op) \
>  	extern void em_##op(struct fastop *fake); \
>  	asm(".pushsection .text, \"ax\" \n\t" \
>  	    ".global em_" #op " \n\t" \
> -	    FOP_FUNC("em_" #op)
> +	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
> +	    "em_" #op ":\n\t"
>  
>  #define FOP_END \
>  	    ".popsection")
>  
> +#define __FOPNOP(name) \
> +	__FOP_FUNC(name) \
> +	__FOP_RET(name)
> +
>  #define FOPNOP() \
> -	FOP_FUNC(__stringify(__UNIQUE_ID(nop))) \
> -	FOP_RET
> +	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
>  
>  #define FOP1E(op,  dst) \
> -	FOP_FUNC(#op "_" #dst) \
> -	"10: " #op " %" #dst " \n\t" FOP_RET
> +	__FOP_FUNC(#op "_" #dst) \
> +	"10: " #op " %" #dst " \n\t" \
> +	__FOP_RET(#op "_" #dst)
>  
>  #define FOP1EEX(op,  dst) \
>  	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
> @@ -366,8 +379,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
>  	FOP_END
>  
>  #define FOP2E(op,  dst, src)	   \
> -	FOP_FUNC(#op "_" #dst "_" #src) \
> -	#op " %" #src ", %" #dst " \n\t" FOP_RET
> +	__FOP_FUNC(#op "_" #dst "_" #src) \
> +	#op " %" #src ", %" #dst " \n\t" \
> +	__FOP_RET(#op "_" #dst "_" #src)
>  
>  #define FASTOP2(op) \
>  	FOP_START(op) \
> @@ -405,8 +419,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
>  	FOP_END
>  
>  #define FOP3E(op,  dst, src, src2) \
> -	FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
> -	#op " %" #src2 ", %" #src ", %" #dst " \n\t" FOP_RET
> +	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
> +	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
> +	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
>  
>  /* 3-operand, word-only, src2=cl */
>  #define FASTOP3WCL(op) \
> @@ -423,7 +438,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
>  	".type " #op ", @function \n\t" \
>  	#op ": \n\t" \
>  	#op " %al \n\t" \
> -	FOP_RET
> +	__FOP_RET(#op)
>  
>  asm(".pushsection .fixup, \"ax\"\n"
>      ".global kvm_fastop_exception \n"
> @@ -449,7 +464,10 @@ FOP_SETCC(setle)
>  FOP_SETCC(setnle)
>  FOP_END;
>  
> -FOP_START(salc) "pushf; sbb %al, %al; popf \n\t" FOP_RET
> +FOP_START(salc)
> +FOP_FUNC(salc)
> +"pushf; sbb %al, %al; popf \n\t"
> +FOP_RET(salc)
>  FOP_END;
>  
>  /*
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
