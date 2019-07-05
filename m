Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC3C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7244218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yp5yQJh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGEJY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:24:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfGEJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:24:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so23862wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HHbqpLTt/UqK8u8skkn9x9YIdY8wkJ4ttRxZXF6EinY=;
        b=yp5yQJh8jtfYUPLuGlLq2DfqpPBdGGO494xChqpf9zNWBSsXLE5a0248/NAxkoBO4/
         0BsVaDdF03YgBQ/EiWOMx+7i4XiuJ0zQf7XlokIV1VYWJHiMZ3PDkE/KfYOab4VzMB+J
         f/pVJLRXx+gS9twTb1Pgz2EXRdaLuXqYybXQVVic64Dl6MDkktWQB7g1huoxjSF5Uleo
         KWEaVwh/WkLIXcfSUgaE+apFuFz8i+7Qp7PYmwtsyWVa2Ym0Ym+UO3OF2ienlhikB0yc
         b4nd6B6ytLHgVQbS9mVjQWCRJczLAl4BYGmiNDVXuTYnaPhD6JUOdm5tiGTCbXBzkVMF
         YL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HHbqpLTt/UqK8u8skkn9x9YIdY8wkJ4ttRxZXF6EinY=;
        b=YqfNHTCXsH7cBtLetFNTYBaauHTJ6plQmtKMWn8J6kThw4EQ9FX8/1gCCtG9Huc8wa
         g9WiuM38kKzKeYSBn8oiIaHdWtiyeziqVztuLwcM0f5sc9GAellvrHuYuyWAfEQcaC9L
         etCK8P8qK5avNI6c+YCmTwBMzsaE08SMZMfr9KuZ20p8G3R7EkM+NjFzNHIYAxNgB/1D
         G1kwdPjUrrJt8U3Ck52aNipqYMJus7ZslSTCu5vLGSpV8vsy4NbjnI9qywjk7ne5AFoU
         Asrba5Y9gP+lrNXoSN8oAMWgV7oEzrekHypMJorr+Feapm8W1A96yY5wOodJiU2oGg4s
         Hdfg==
X-Gm-Message-State: APjAAAXkL1f0ivUlRuBlkMTzrWRJiCbR+O1xSu6O4lkP7OfVQVdUvYQY
        X3P5v792M6bdb51+7EeEzos86w==
X-Google-Smtp-Source: APXvYqwfVWZ2uyQrHtW79irxr4cfhJhTkvjPeAqMQ25Qa5108rnUpXmlpdEPv1K0U4PAXpWDPp+JbQ==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr3191191wrm.117.1562318666604;
        Fri, 05 Jul 2019 02:24:26 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id o126sm7447501wmo.1.2019.07.05.02.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 02:24:25 -0700 (PDT)
References: <20190705001803.30094-1-luke.r.nels@gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Luke Nelson <lukenels@cs.washington.edu>
Cc:     linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Xi Wang <xi.wang@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] Enable zext optimization for more RV64G ALU ops
In-reply-to: <20190705001803.30094-1-luke.r.nels@gmail.com>
Date:   Fri, 05 Jul 2019 10:24:22 +0100
Message-ID: <8736jk4ywp.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luke Nelson writes:

> commit 66d0d5a854a6 ("riscv: bpf: eliminate zero extension code-gen")
> added the new zero-extension optimization for some BPF ALU operations.
>
> Since then, bugs in the JIT that have been fixed in the bpf tree require
> this optimization to be added to other operations: commit 1e692f09e091
> ("bpf, riscv: clear high 32 bits for ALU32 add/sub/neg/lsh/rsh/arsh"),
> and commit fe121ee531d1 ("bpf, riscv: clear target register high 32-bits
> for and/or/xor on ALU32")
>
> Now that these have been merged to bpf-next, the zext optimization can
> be enabled for the fixed operations.

LGTM, thanks.

Acked-by: Jiong Wang <jiong.wang@netronome.com>

>
> Cc: Song Liu <liu.song.a23@gmail.com>
> Cc: Jiong Wang <jiong.wang@netronome.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
> index 876cb9c705ce..5451ef3845f2 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -757,31 +757,31 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU | BPF_ADD | BPF_X:
>  	case BPF_ALU64 | BPF_ADD | BPF_X:
>  		emit(is64 ? rv_add(rd, rd, rs) : rv_addw(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_SUB | BPF_X:
>  	case BPF_ALU64 | BPF_SUB | BPF_X:
>  		emit(is64 ? rv_sub(rd, rd, rs) : rv_subw(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_AND | BPF_X:
>  	case BPF_ALU64 | BPF_AND | BPF_X:
>  		emit(rv_and(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_OR | BPF_X:
>  	case BPF_ALU64 | BPF_OR | BPF_X:
>  		emit(rv_or(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_XOR | BPF_X:
>  	case BPF_ALU64 | BPF_XOR | BPF_X:
>  		emit(rv_xor(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_MUL | BPF_X:
> @@ -811,13 +811,13 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU | BPF_RSH | BPF_X:
>  	case BPF_ALU64 | BPF_RSH | BPF_X:
>  		emit(is64 ? rv_srl(rd, rd, rs) : rv_srlw(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  	case BPF_ALU | BPF_ARSH | BPF_X:
>  	case BPF_ALU64 | BPF_ARSH | BPF_X:
>  		emit(is64 ? rv_sra(rd, rd, rs) : rv_sraw(rd, rd, rs), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;
>  
> @@ -826,7 +826,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  	case BPF_ALU64 | BPF_NEG:
>  		emit(is64 ? rv_sub(rd, RV_REG_ZERO, rd) :
>  		     rv_subw(rd, RV_REG_ZERO, rd), ctx);
> -		if (!is64)
> +		if (!is64 && !aux->verifier_zext)
>  			emit_zext_32(rd, ctx);
>  		break;

