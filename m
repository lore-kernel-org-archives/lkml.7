Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D2C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8C82615A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wuaFUP1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3Uan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:30:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36227 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfE3Uam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:30:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1977799wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=HSteFUKF52rWVzt3NjcoHxXLBvXNbvyEYXBsHNUqUF0=;
        b=wuaFUP1Ozlt+4+MWLG6fRYDs6aSrPIgbEmXi3tSSC6W/7egGZLIS272b1Qheh5JU5P
         Oq9csJMPH8Wywm1a4U60VCgOQa48Mrk4ffhhYNDADsbPNnxg3nPWusMMHDatHMZPgLh6
         S+fNEkjVPZqJ+sbUADzBEOh/azCtNVzI8Lv0x4pRr8ltsnNkeJqrjxnu+cTAblZKpSSr
         mhjzCvGsBkx1x+qxeK1RRLbjGe0WMF6Jwt0JuMjeOiAlmSFhO2awU+QZJ+JOvnMhqqHk
         IWb/jMFbRDHMXFigziw/39/xe8Kn6eQ/PZAfEMVg9G41H/U3UEfYFM0oKvmMbG68BX1G
         Bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=HSteFUKF52rWVzt3NjcoHxXLBvXNbvyEYXBsHNUqUF0=;
        b=P6+dE7sFm8gR/N0U897/QdcqbfZ+OnJPdGt0qXsf5aWOfIGnVS8anW5U9k7Dp/Bil3
         AX2khMxMuA8CgrR9YnzjpJ70MvUYuG1YedMfCyYO0PM53v0qIGHGSi9sS0D7TxRi/4SD
         gU1ngsGZ/w0UJmwPazmAawwFoDsxbr64LY/991okqhhtDOCrClFTbG0OFziAIECDq6wF
         kbBS2XfZFvzplOofNra+0gtiAtPcZsCwOd1oEX+9YX2DYwLRCGa6v+F9ttvaoRZP6x5g
         6qy5apwFZG/JyGVTvIVZyyuWLtc1lltp4uXD1ZoFU7bWCi2h0Gs2mzz7HRMVRMqDs7Sy
         UIdw==
X-Gm-Message-State: APjAAAVzfcVRYQ6eJUgWMY/BvVNvbc6kvcUR5mRCKbw/dvG2ceyWQoo+
        sKIJwij2s4eIKSDhY/Sc96rBWNeEhgg=
X-Google-Smtp-Source: APXvYqxGLUZbjBbciy7kuigIoFOTAYX5bbCb2hDNu9emCUTJfNI7h9Yf8US1rv/g8abXrsSbSEaO8g==
X-Received: by 2002:adf:e845:: with SMTP id d5mr3859527wrn.154.1559248239296;
        Thu, 30 May 2019 13:30:39 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id 8sm3262857wmf.18.2019.05.30.13.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 13:30:37 -0700 (PDT)
References: <20190530190800.7633-1-luke.r.nels@gmail.com> <20190530190800.7633-2-luke.r.nels@gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Luke Nelson <luke.r.nels@gmail.com>
Cc:     Xi Wang <xi.wang@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bpf: test_bpf: add tests for upper bits of 32-bit operations
Message-ID: <87lfyn4rdy.fsf@netronome.com>
In-reply-to: <20190530190800.7633-2-luke.r.nels@gmail.com>
Date:   Thu, 30 May 2019 21:30:33 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luke Nelson writes:

> This commit introduces tests that validate the upper 32 bits
> of the result of 32-bit BPF ALU operations.
>
> The existing tests for 32-bit operations do not check the upper 32
> bits of results because the exit instruction truncates the result.
> These tests perform a 32-bit ALU operation followed by a right shift.
> These tests can catch subtle bugs in the extension behavior of JITed
> instructions, including several bugs in the RISC-V BPF JIT, fixed in
> another patch.

Hi Luke,

  Have you seen the following?

    https://www.spinics.net/lists/netdev/msg573355.html

  it has been merged to bpf tree and should have full test coverage of all
  bpf insns that could write to sub-register and are exposed to JIT
  back-end.

  And AFAIK, we add new unit tests to test_verifier which is a userspace
  test infrastructure which offers more test functionality plus tests will
  go through verifier.

Regards,
Jiong

> The added tests pass the JIT and interpreter on x86, as well as the
> JIT and interpreter of RISC-V once the zero extension bugs were fixed.
>
> Cc: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
> ---
>  lib/test_bpf.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 0845f635f404..4580dc0220f1 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -2461,6 +2461,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 1 } },
>  	},
> +	{
> +		"ALU_ADD_X: (1 + 4294967294) >> 32 + 4294967294 = 4294967294",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 1U),
> +			BPF_ALU32_IMM(BPF_MOV, R1, 4294967294U),
> +			BPF_ALU32_REG(BPF_ADD, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_REG(BPF_ADD, R0, R1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 4294967294U } },
> +	},
>  	{
>  		"ALU64_ADD_X: 1 + 2 = 3",
>  		.u.insns_int = {
> @@ -2812,6 +2826,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 1 } },
>  	},
> +	{
> +		"ALU_SUB_X: (4294967295 - 1) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 4294967295U),
> +			BPF_ALU32_IMM(BPF_MOV, R1, 1U),
> +			BPF_ALU32_REG(BPF_SUB, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_REG(BPF_ADD, R0, R1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_SUB_X: 3 - 1 = 2",
>  		.u.insns_int = {
> @@ -3391,6 +3419,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 0xffffffff } },
>  	},
> +	{
> +		"ALU_AND_X: (-1 & -1) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, -1UL),
> +			BPF_LD_IMM64(R1, -1UL),
> +			BPF_ALU32_REG(BPF_AND, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1U),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_AND_X: 3 & 2 = 2",
>  		.u.insns_int = {
> @@ -3533,6 +3575,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 0xffffffff } },
>  	},
> +	{
> +		"ALU_OR_X: (0 & -1) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0),
> +			BPF_LD_IMM64(R1, -1UL),
> +			BPF_ALU32_REG(BPF_OR, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1U),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_OR_X: 1 | 2 = 3",
>  		.u.insns_int = {
> @@ -3675,6 +3731,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 0xfffffffe } },
>  	},
> +	{
> +		"ALU_XOR_X: (0 ^ -1) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0),
> +			BPF_LD_IMM64(R1, -1UL),
> +			BPF_ALU32_REG(BPF_XOR, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1U),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_XOR_X: 5 ^ 6 = 3",
>  		.u.insns_int = {
> @@ -3817,6 +3887,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 0x80000000 } },
>  	},
> +	{
> +		"ALU_LSH_X: (1 << 31) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 1),
> +			BPF_ALU32_IMM(BPF_MOV, R1, 31),
> +			BPF_ALU32_REG(BPF_LSH, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_LSH_X: 1 << 1 = 2",
>  		.u.insns_int = {
> @@ -3842,6 +3926,19 @@ static struct bpf_test tests[] = {
>  		{ { 0, 0x80000000 } },
>  	},
>  	/* BPF_ALU | BPF_LSH | BPF_K */
> +	{
> +		"ALU_LSH_K: (1 << 31) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 1),
> +			BPF_ALU32_IMM(BPF_LSH, R0, 31),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU_LSH_K: 1 << 1 = 2",
>  		.u.insns_int = {
> @@ -3911,6 +4008,20 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 1 } },
>  	},
> +	{
> +		"ALU_RSH_X: (0x80000000 >> 0) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0x80000000),
> +			BPF_ALU32_IMM(BPF_MOV, R1, 0),
> +			BPF_ALU32_REG(BPF_RSH, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_RSH_X: 2 >> 1 = 1",
>  		.u.insns_int = {
> @@ -3936,6 +4047,19 @@ static struct bpf_test tests[] = {
>  		{ { 0, 1 } },
>  	},
>  	/* BPF_ALU | BPF_RSH | BPF_K */
> +	{
> +		"ALU_RSH_K: (0x80000000 >> 0) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0x80000000),
> +			BPF_ALU32_IMM(BPF_RSH, R0, 0),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU_RSH_K: 2 >> 1 = 1",
>  		.u.insns_int = {
> @@ -3993,7 +4117,34 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 0xffff00ff } },
>  	},
> +	{
> +		"ALU_ARSH_X: (0x80000000 >> 0) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0x80000000),
> +			BPF_ALU32_IMM(BPF_MOV, R1, 0),
> +			BPF_ALU32_REG(BPF_ARSH, R0, R1),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	/* BPF_ALU | BPF_ARSH | BPF_K */
> +	{
> +		"ALU_ARSH_K: (0x80000000 >> 0) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_LD_IMM64(R0, 0x80000000),
> +			BPF_ALU32_IMM(BPF_ARSH, R0, 0),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU32_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU_ARSH_K: 0xff00ff0000000000 >> 40 = 0xffffffffffff00ff",
>  		.u.insns_int = {
> @@ -4028,6 +4179,19 @@ static struct bpf_test tests[] = {
>  		{ },
>  		{ { 0, 3 } },
>  	},
> +	{
> +		"ALU_NEG: -(1) >> 32 + 1 = 1",
> +		.u.insns_int = {
> +			BPF_ALU32_IMM(BPF_MOV, R0, 1),
> +			BPF_ALU32_IMM(BPF_NEG, R0, 0),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32),
> +			BPF_ALU64_IMM(BPF_ADD, R0, 1),
> +			BPF_EXIT_INSN(),
> +		},
> +		INTERNAL,
> +		{ },
> +		{ { 0, 1 } },
> +	},
>  	{
>  		"ALU64_NEG: -(3) = -3",
>  		.u.insns_int = {

