Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E3C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE972214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="ZfaMJue7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfF2F6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:58:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37730 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfF2F6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 01:58:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so1626642pgi.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 22:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6saX9Hkf+VB72NbXyQ2NLowOYmfY1wBCp5L14Rva570=;
        b=ZfaMJue7YllyxdUzRfCqixkMLs0ZyBVDc9J0DS6kqjtXrBZr5joCibB/Htn2qhsPy2
         39c3gm8fLUX8N1YUpuJYVtnZoNkor9e6ujUwofQvnzRnxqMq6N58LwgTpR4xoWPD2XEI
         DIa4r9hl174GIQIQXaFEfNw+8j6GqKbepNcHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6saX9Hkf+VB72NbXyQ2NLowOYmfY1wBCp5L14Rva570=;
        b=lK5NqIJCjhcmmcphbQ5jOSlLnhdLM+WILyGXBepQGwXd6U3WtyUcRMhYoMSc8Ujhgw
         EJmsF3UI+tLrhHTsKq0kBu1IBWqPLtP6L6ts4n9g8tCOJBwwPNoWVFy1jhq9wTxE4wjB
         trmEbL1QDIavavA+wXK80sLFgR2r2+G8WBBmvJ9W1qUNSqbRxnqMERsqOQTRdNWHeV1W
         I30GT0vtorzEIeYjni1YcphiNpL+yWglcQE3XOZBMkjFLyfLGoZhmjwssjNvsLQzBlMa
         YJvU7+zbOkYug4C/DLrh8h3D0z3VuXZPCEkNOWTBAClC5M7IR74ckNBA0XQlHD6nVaKk
         +sfQ==
X-Gm-Message-State: APjAAAXX5Wszt7VW2JHU7LAP2S7UMgGIKmUGpyCAwsGHDrQuN9zXfphM
        9BXPwOceIZfoubUQE+n0LTJWIK8SZ2wi+Q==
X-Google-Smtp-Source: APXvYqzLF98Gn4hCXY+LN83OIvB7YAMu+dLXiMmww7GUBIdRbxTzQwh0Y6YrTjXdxzQbRDh+PTL+ZQ==
X-Received: by 2002:a17:90a:19d:: with SMTP id 29mr18061421pjc.71.1561787923558;
        Fri, 28 Jun 2019 22:58:43 -0700 (PDT)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:717c:64f7:ecd0:38c2])
        by smtp.gmail.com with ESMTPSA id r3sm3272243pgp.51.2019.06.28.22.58.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 22:58:43 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wang YanQing <udknight@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 3/3] selftests: bpf: add tests for shifts by zero
Date:   Fri, 28 Jun 2019 22:57:51 -0700
Message-Id: <20190629055759.28365-3-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190629055759.28365-1-luke.r.nels@gmail.com>
References: <20190629055759.28365-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently no tests for ALU64 shift operations when the shift
amount is 0. This adds 6 new tests to make sure they are equivalent
to a no-op. The x32 JIT had such bugs that could have been caught by
these tests.

Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 .../selftests/bpf/verifier/basic_instr.c      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/basic_instr.c b/tools/testing/selftests/bpf/verifier/basic_instr.c
index ed91a7b9a456..071dbc889e8c 100644
--- a/tools/testing/selftests/bpf/verifier/basic_instr.c
+++ b/tools/testing/selftests/bpf/verifier/basic_instr.c
@@ -90,6 +90,91 @@
 	},
 	.result = ACCEPT,
 },
+{
+	"lsh64 by 0 imm",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 1),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"rsh64 by 0 imm",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
+	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 0),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"arsh64 by 0 imm",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
+	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 0),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"lsh64 by 0 reg",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 1),
+	BPF_LD_IMM64(BPF_REG_2, 0),
+	BPF_ALU64_REG(BPF_LSH, BPF_REG_1, BPF_REG_2),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 1, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"rsh64 by 0 reg",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
+	BPF_LD_IMM64(BPF_REG_3, 0),
+	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_3),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"arsh64 by 0 reg",
+	.insns = {
+	BPF_LD_IMM64(BPF_REG_0, 1),
+	BPF_LD_IMM64(BPF_REG_1, 0x100000000LL),
+	BPF_ALU64_REG(BPF_MOV, BPF_REG_2, BPF_REG_1),
+	BPF_LD_IMM64(BPF_REG_3, 0),
+	BPF_ALU64_REG(BPF_ARSH, BPF_REG_1, BPF_REG_3),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.retval = 1,
+},
 {
 	"invalid 64-bit BPF_END",
 	.insns = {
-- 
2.20.1

