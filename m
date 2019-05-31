Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7367EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA4926EF7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m+sB14Yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfEaUkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:40:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40247 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfEaUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:40:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so4648490pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=L9DdyCtjUjmQm6BTqIghH9AyiE8Bj0FZDxV/U7xA1V0=;
        b=m+sB14YoMKD0En6Ta1jguYQojAS5qLFbQotT+YNGILgTJGeqwJGD4s/f/rbm2iH7fu
         uL/Puewkgm9o8a+YhgF4KSzecl0+KRcZ5bFpnn6R0gBxZ05SMmCvyVXtqA+3kLUKngOo
         O9AiG/tILOp2WJEGwSRJ3n56HGnMhkUyurCCUlj7H9LaLrx7icNhelYOl337LGrD7dq6
         5MRFjT0pqpaEsSicSzRDqdDiv07JC0R2M9vcWKR+wim16AUTL3NRgr9wipNWpbKpIWmF
         r8mszFJ8lwToWogOXRC4Tg5M0PnLSLrmlPxfRC2m1Szk15lbD7qTLEqrsQquM4QKf1PE
         Ar0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=L9DdyCtjUjmQm6BTqIghH9AyiE8Bj0FZDxV/U7xA1V0=;
        b=JWvBEo6dsRTQC4W2dSje1nM/m/1xgTcx98c1M1Dsu0At4/kKCKLA025g4Vv0QJlGDu
         o1YHv5Giw7P1nbsOEDS4y4e7zlK1rIAyfPAfkpFmfc+Ed6JU1TigkaD8FvdV50qZgGBU
         2leRcN1bUSHPJe7yvuKxvL73aeoJ3jVeflZM/1flF19H6T6WfepJyrPsO4wOSU5CH94U
         PAKZa0bo/139RDHrP0d44TqdeFsoPw8qk33FOuoBfoNtI6qaFi6u8oDGJvFDI1Uw5kFT
         4sUx+kl2r8i0/H9OvAEFK8yfP23RM7wYpwO6+Fmofem9oQof0GciYb/X1QhbnrSQX9me
         nc6Q==
X-Gm-Message-State: APjAAAX3XoZVgOVApFD0TvOki3nEMn+1hYKNymY7g2B93WU6U2wxRSf5
        X2Xqs0TYJfYAkTh/+taPKA2SmA==
X-Google-Smtp-Source: APXvYqz4SQR8SyNvYw/RbVYq9J75OHRdEl+vxzGoZ1hj8lWeH/sIaNdK7fANnH7Zay6JrXmUtrIdGA==
X-Received: by 2002:a63:2ace:: with SMTP id q197mr11342665pgq.102.1559335236450;
        Fri, 31 May 2019 13:40:36 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s27sm18341537pfd.18.2019.05.31.13.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 13:40:35 -0700 (PDT)
Date:   Fri, 31 May 2019 13:40:35 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2019 13:39:54 PDT (-0700)
Subject:     Re: [PATCH bpf v2] bpf, riscv: clear high 32 bits for ALU32 add/sub/neg/lsh/rsh/arsh
In-Reply-To: <20190530222922.4269-1-luke.r.nels@gmail.com>
CC:     xi.wang@gmail.com, bjorn.topel@gmail.com, aou@eecs.berkeley.edu,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luke.r.nels@gmail.com
Message-ID: <mhng-b4ce883e-9ec7-4098-9acc-18eb140f93e0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 15:29:22 PDT (-0700), luke.r.nels@gmail.com wrote:
> In BPF, 32-bit ALU operations should zero-extend their results into
> the 64-bit registers.
>
> The current BPF JIT on RISC-V emits incorrect instructions that perform
> sign extension only (e.g., addw, subw) on 32-bit add, sub, lsh, rsh,
> arsh, and neg. This behavior diverges from the interpreter and JITs
> for other architectures.
>
> This patch fixes the bugs by performing zero extension on the destination
> register of 32-bit ALU operations.
>
> Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
> Cc: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!  I'm assuming this is going in through a BPF tree and not the RISC-V
tree, but LMK if that's not the case.

> ---
> The original patch is
> https://lkml.org/lkml/2019/5/30/1370
>
> This version is rebased against the bpf tree.
> ---
>  arch/riscv/net/bpf_jit_comp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
> index e5c8d675bd6e..426d5c33ea90 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -751,10 +751,14 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU | BPF_ADD | BPF_X:
>  	case BPF_ALU64 | BPF_ADD | BPF_X:
>  		emit(is64 ? rv_add(rd, rd, rs) : rv_addw(rd, rd, rs), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_SUB | BPF_X:
>  	case BPF_ALU64 | BPF_SUB | BPF_X:
>  		emit(is64 ? rv_sub(rd, rd, rs) : rv_subw(rd, rd, rs), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_AND | BPF_X:
>  	case BPF_ALU64 | BPF_AND | BPF_X:
> @@ -795,14 +799,20 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU | BPF_LSH | BPF_X:
>  	case BPF_ALU64 | BPF_LSH | BPF_X:
>  		emit(is64 ? rv_sll(rd, rd, rs) : rv_sllw(rd, rd, rs), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_RSH | BPF_X:
>  	case BPF_ALU64 | BPF_RSH | BPF_X:
>  		emit(is64 ? rv_srl(rd, rd, rs) : rv_srlw(rd, rd, rs), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_ARSH | BPF_X:
>  	case BPF_ALU64 | BPF_ARSH | BPF_X:
>  		emit(is64 ? rv_sra(rd, rd, rs) : rv_sraw(rd, rd, rs), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>
>  	/* dst = -dst */
> @@ -810,6 +820,8 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU64 | BPF_NEG:
>  		emit(is64 ? rv_sub(rd, RV_REG_ZERO, rd) :
>  		     rv_subw(rd, RV_REG_ZERO, rd), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>
>  	/* dst = BSWAP##imm(dst) */
> @@ -964,14 +976,20 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU | BPF_LSH | BPF_K:
>  	case BPF_ALU64 | BPF_LSH | BPF_K:
>  		emit(is64 ? rv_slli(rd, rd, imm) : rv_slliw(rd, rd, imm), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_RSH | BPF_K:
>  	case BPF_ALU64 | BPF_RSH | BPF_K:
>  		emit(is64 ? rv_srli(rd, rd, imm) : rv_srliw(rd, rd, imm), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_ARSH | BPF_K:
>  	case BPF_ALU64 | BPF_ARSH | BPF_K:
>  		emit(is64 ? rv_srai(rd, rd, imm) : rv_sraiw(rd, rd, imm), ctx);
> +		if (!is64)
> +			emit_zext_32(rd, ctx);
>  		break;
>
>  	/* JUMP off */
