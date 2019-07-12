Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD2C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE6D21738
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934314;
	bh=xRiTgwMNvyE5rkypTg2cjx+bZtwrm3oL0sa/UfcbRQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrefGfayyhsB+BYHtU0DHtJijxa/BaVuks8mWs1YiHoXZNknncBhisVJfy+B6X+79
	 WCXU7xC7opxYrhzs3KCcVpKcjXdlrblM0Oug+kJU+Z13Pk+e3UuS2eH/6assPU8J0w
	 /BgIoKvIi1SPbxxSJdurtbd3wVF59j9ZZ8FN21/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfGLMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfGLMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:25:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F88D21670;
        Fri, 12 Jul 2019 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934307;
        bh=xRiTgwMNvyE5rkypTg2cjx+bZtwrm3oL0sa/UfcbRQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJGKZGad/j3yRLRx/SvZpTVx1CQzboMD1nkAxLXmryCPt5BRMbJEhTVsCY+83LNsX
         Zn1/aap85+rHMcHqrtqOrtm75DIr36ffCgFkxOgO8KwG2sKZf7N54Y+Z4U6qEJHTOS
         zd/LXzy6tkFwx2J9zHUOLr/deXG3Whitdn1RE0Sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiong Wang <jiong.wang@netronome.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 013/138] bpf, riscv: clear target register high 32-bits for and/or/xor on ALU32
Date:   Fri, 12 Jul 2019 14:17:57 +0200
Message-Id: <20190712121629.229571351@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fe121ee531d1362810bfd30f38a1b88b1d3d376c ]

When using 32-bit subregisters (ALU32), the RISC-V JIT would not clear
the high 32-bits of the target register and therefore generate
incorrect code.

E.g., in the following code:

  $ cat test.c
  unsigned int f(unsigned long long a,
  	       unsigned int b)
  {
  	return (unsigned int)a & b;
  }

  $ clang-9 -target bpf -O2 -emit-llvm -S test.c -o - | \
  	llc-9 -mattr=+alu32 -mcpu=v3
  	.text
  	.file	"test.c"
  	.globl	f
  	.p2align	3
  	.type	f,@function
  f:
  	r0 = r1
  	w0 &= w2
  	exit
  .Lfunc_end0:
  	.size	f, .Lfunc_end0-f

The JIT would not clear the high 32-bits of r0 after the
and-operation, which in this case might give an incorrect return
value.

After this patch, that is not the case, and the upper 32-bits are
cleared.

Reported-by: Jiong Wang <jiong.wang@netronome.com>
Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
index 80b12aa5e10d..e5c8d675bd6e 100644
--- a/arch/riscv/net/bpf_jit_comp.c
+++ b/arch/riscv/net/bpf_jit_comp.c
@@ -759,14 +759,20 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_AND | BPF_X:
 	case BPF_ALU64 | BPF_AND | BPF_X:
 		emit(rv_and(rd, rd, rs), ctx);
+		if (!is64)
+			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU64 | BPF_OR | BPF_X:
 		emit(rv_or(rd, rd, rs), ctx);
+		if (!is64)
+			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU64 | BPF_XOR | BPF_X:
 		emit(rv_xor(rd, rd, rs), ctx);
+		if (!is64)
+			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-- 
2.20.1



