Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED8DC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0714B2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="k8ywuutI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF0MSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:18:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51611 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0MSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:18:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so5514736wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Zdd4Pp3dYlawoEQsjCTjL1Bm9eBCVbOZ/q37LUapnaQ=;
        b=k8ywuutI5JJ1zOZBUSRsiA6wF2HW/8zzohHwXhnHqAE4EOXoGZ6iion4AWL7kpTwR6
         qAY+CpaQo3wjcaUtdet5Ew+axkm4VjOnlrKl9HBABghASKurGPUynYSpaOP4PU+6mece
         z7xORIC5BZJAMxRKJwKl4WQ6E0fiVnWmR9t39mGB2/DytymcTWatNM/SRNdT8DoCixeQ
         eudI3hm86XZDcojtmkzCOfoFGiokZRxpQQutxIzHUgMQAA339QF1UW1S2h7QIsQlNetS
         1vsloMKS2mL8TAN9kbK+Zjz8hEQZ7WBEOJKvJIoBDSTqwV5KXBqHBppJN9/PdbPQ+IiX
         mvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Zdd4Pp3dYlawoEQsjCTjL1Bm9eBCVbOZ/q37LUapnaQ=;
        b=tDRieP8bjmmuiJ037tD0G+NZG7fqsZBSH7ZrBo3wF1P+r/IT9iwhL3lQdWJs3aDHAi
         PYHKdJY2ZlagIhRKyPtuGH/Kvm4ifGxRpLeNFtsa069GQ+V011eYSmO52FPdgSYDmNDa
         2Lhl1NJruMV9+v/6OaJ6uaB7XRX5zpk8scbkF8y62pmTWeVnv73O1RgBzrAEKHA6p4J7
         OEBSoewUWRpSIo+9p1tRRoj0g9ZZ9xtm7rXV8D1+2+Ij3+ljJcMTBJmWs0kNu1bnVqMg
         pNpsGKvuzMcZqGSIa8EiW/JVV8GYnbWOZXsMW1pUN+PE7HLNmi6Eu+5ho9SBDpkM+EMo
         qnBA==
X-Gm-Message-State: APjAAAXqD8DWwdY+5xza60qR5dRMyC1Ap1ffLMcPNKT/RX/Kc+GCaRqh
        GLfSSDEw2KbxDDlDeWWk8454Og==
X-Google-Smtp-Source: APXvYqwP5/KqbmGqmRh+sNx5VCR+6gZxpNd+GAZ3G0BUulrp4g0b6pfWHwk+3cirqW7BcslJWBkoWg==
X-Received: by 2002:a1c:7a01:: with SMTP id v1mr3202693wmc.10.1561637917201;
        Thu, 27 Jun 2019 05:18:37 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id l19sm3291337wmj.33.2019.06.27.05.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 05:18:36 -0700 (PDT)
References: <20190626231257.14495-1-lukenels@cs.washington.edu>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Luke Nelson <lukenels@cs.washington.edu>
Cc:     linux-kernel@vger.kernel.org, Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= 
        <bjorn.topel@gmail.com>, linux-riscv@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] RV32G eBPF JIT
In-reply-to: <20190626231257.14495-1-lukenels@cs.washington.edu>
Date:   Thu, 27 Jun 2019 13:18:35 +0100
Message-ID: <87y31nuspw.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luke Nelson writes:

<snip>
> +
> +static int emit_insn(const struct bpf_insn *insn,
> +		     struct rv_jit_context *ctx,
> +		     bool extra_pass)
> +{
> +	int rvoff, i = insn - ctx->prog->insnsi;
> +	u8 code = insn->code;
> +	s16 off = insn->off;
> +	s32 imm = insn->imm;
> +
> +	const s8 *dst = bpf2rv32[insn->dst_reg];
> +	const s8 *src = bpf2rv32[insn->src_reg];
> +	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
> +	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
> +
> +	switch (code) {
> +	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		if (imm == 1) {
> +			/* Special mov32 for zext */
> +			emit_rv32_zext64(dst, ctx);
> +			break;
> +		}

Thanks for adding the 32-bit opt!

Just want to mention ZEXT is a special mov32, see include/linux/filter.h:

#define BPF_ZEXT_REG(DST)
        ((struct bpf_insn) {
                 .code  = BPF_ALU | BPF_MOV | BPF_X

So it can't be BPF_ALU64. It is safe to remove this chunk of code.

For backend like arm, riscv etc, they are grouping several CASE label
together and are sharing code. imm == 1 check is done inside the shared
code to avoid moving code around given imm == 1 can't be true for ALU64 as
if there is such insn (register format using imm) it should have been
rejected by verifier. While mov32 variant is inserted by verifier at very
late stage after main verification finished.

Regards,
Jiong
