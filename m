Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12809C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6F220673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="d6bKmA1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfFXQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:45:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40463 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfFXQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:45:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so31001wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=DzGlPYsIYshbD5peGKifO8l46y0lKsTTIsT4YjNzT5E=;
        b=d6bKmA1qg0uC0Ie/B+rKeOICs7HZyVW8m4zo5CufVyG8tVEYsVvxLbE/SN124rH9p3
         06yUcEvuoj+0PcroXaMiWv8HRvVCQeLqaMGAjw8YiGZA+5OdDouYUSYBBjcOtnTezmpB
         mSev/yoU1rb28ZElCOVgrod/eoj6MrAaSrfoqh6HliP3cARmrjnP7lmUG96MesS3+Ku0
         J5V5MSG5H8SsQIMgau0YDGSiMF5J1gZFIuklMrMYbGDIDGDq/l78UhoMTq3J/cwJ4v7X
         mPdQecNR4EHgr/JIOVaSbkfVdT2FxX1qxupmrqOEyO1iKOT+/uX5o+xyqn6TbPQHpqBd
         X2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=DzGlPYsIYshbD5peGKifO8l46y0lKsTTIsT4YjNzT5E=;
        b=T8ad89Az7rFl6jbjddVrHPOurC5N2dbSQGC2IyJqcTld01eQqvMgM+yZ5znTjCbCph
         8eC1WjyjvLstBm10+TuGZ7wDIduSS+XkYZiL0bin32m4C6OlJDHgGeucTniW1vvLJtgl
         5tanbb6UIZ8NpH9spHtaizBDrNTXfvsroLSRURNPcrVP8GeWqunh2B2uR2guMX91petG
         LJuQixxV8gWMx10Ug2czlC22iongCyWWRYfL1fw0B1wJwYWZGpfBJGtcku3wH0D6kwrn
         v4gldbdzR0yIssNZTMufbZVPmd7RELaHq54VI8teIN5TDPr7P2NufaCHjN8DV7WTbNbi
         WIhg==
X-Gm-Message-State: APjAAAVQOPsm/ecKxPxVsfUlWg8N0VpMHGMluuR9OFMWDrLBuQ6sYids
        Ulovt3bbXqst42S5f4t+oc2WsQ==
X-Google-Smtp-Source: APXvYqzCOhY6pbib85YShe2BKk3kBMiCErh/riJuTO+Y3VGhfakrMQj54c4JSjzoIeVurBCR7ItggQ==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr15402634wme.148.1561394746919;
        Mon, 24 Jun 2019 09:45:46 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 15sm21315wmk.34.2019.06.24.09.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 09:45:46 -0700 (PDT)
References: <20190621225938.27030-1-lukenels@cs.washington.edu>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Luke Nelson <lukenels@cs.washington.edu>
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next] RV32G eBPF JIT
Message-ID: <87h88f9bm3.fsf@netronome.com>
In-reply-to: <20190621225938.27030-1-lukenels@cs.washington.edu>
Date:   Mon, 24 Jun 2019 17:45:45 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luke Nelson writes:

> From: Luke Nelson <luke.r.nels@gmail.com>
>
> This is an eBPF JIT for RV32G, adapted from the JIT for RV64G.
> Any feedback would be greatly appreciated.
>
> It passes 359 out of 378 tests in test_bpf.ko. The failing tests are
> features that are not supported right now:
>   - ALU64 DIV/MOD:
>       These require loops to emulate on 32-bit hardware,
>       and are not supported on other 32-bit JITs like
>       ARM32.
>   - BPF_XADD | BPF_DW:
>       RV32G does not have atomic instructions for operating
>       on double words. This is similar to ARM32.
>   - Tail calls:
>       I'm working on adding support for these now, but couldn't
>       find any test cases that use them. What's the best way
>       of testing tail call code?
>   - Far branches
>       These are not supported in RV64G either.
>
> There are two main changes required for this to work compared to the
> RV64 JIT.
>
> First, eBPF registers are 64-bit, while RV32G registers are 32-bit.
> I take an approach similar to ARM32: most BPF registers map directly to
> 2 RISC-V registers, while some reside in stack scratch space and must
> be saved / restored when used.
>
> Second, many 64-bit ALU operations do not trivially map to 32-bit
> operations. Operations that move bits between high and low words, such
> as ADD, LSH, MUL, and others must emulate the 64-bit behavior in terms
> of 32-bit instructions.
>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> ---
>  arch/riscv/Kconfig              |    2 +-
>  arch/riscv/net/Makefile         |    7 +-
>  arch/riscv/net/bpf_jit_comp32.c | 1460 +++++++++++++++++++++++++++++++
>  3 files changed, 1467 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/net/bpf_jit_comp32.c
>
<snip>
> +static void rv32_bpf_put_reg32(const s8 *reg, const s8 *src,
> +			       struct rv_jit_context *ctx)
> +{
> +	if (is_stacked(reg[1])) {
> +		emit(rv_sw(RV_REG_FP, reg[1], src[1]), ctx);
> +		emit(rv_sw(RV_REG_FP, reg[0], RV_REG_ZERO), ctx);
> +	} else {
> +		emit(rv_addi(reg[0], RV_REG_ZERO, 0), ctx);
> +	}
> +}
> +

Looks to me 32-bit optimization is not enabled.

If you define bpf_jit_needs_zext to return true

  bool bpf_jit_needs_zext(void)
  {
        return true;
  }

Then you don't need to zero high 32-bit when writing 32-bit sub-register
and you just need to implement the explicit zero extension insn which is a
special variant of BPF_MOV. This can save quite a few instructions. RV64
and arches like arm has implemented this, please search
"aux->verifier_zext".

And there is a doc for this optimization:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/bpf_design_QA.rst#n168

Regards,
Jiong
