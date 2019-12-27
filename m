Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00365C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC8E222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468550;
	bh=sA28e4/Vn28o0eBK2OtFILC07rU4A36VwG070Roqi1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBGCe9rW5ECJqVy1cR4Ic+ufObMQCMZAt+J3iZPz0S5d2lNALJlVxQk1M1XAa9pWH
	 FCPYONXoyOw6LVrM4RMLsReRwRpXPyaWhvelJSDsw22KojhYI9FClg299r2A2XfanE
	 3V7s1UXw31Qi1mYIpprjFxTIZBh5zJdSff+UHd7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfL0Rm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfL0RmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836E624656;
        Fri, 27 Dec 2019 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468542;
        bh=sA28e4/Vn28o0eBK2OtFILC07rU4A36VwG070Roqi1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiKHpEc6CjWZYqHnTSwrNT6baXTcn23/DRReuzfA9XS8TZUMxmDmnBH5smo1ha96M
         ehPvzrdCkn1N0u2vCUI6ia6pA8vZCNYLNODmvK+ehrpI7xlOCdF3zGXDsaubdsgEdu
         d+76EAmFFcvYvSbQs3m1aOdCaEKFlLWSLbIiE72Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Chaignon <paul.chaignon@orange.com>,
        Mahshid Khezri <khezri.mahshid@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 071/187] bpf, riscv: Limit to 33 tail calls
Date:   Fri, 27 Dec 2019 12:38:59 -0500
Message-Id: <20191227174055.4923-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Chaignon <paul.chaignon@orange.com>

[ Upstream commit 96bc4432f5ade1045521f3b247f516b1478166bd ]

All BPF JIT compilers except RISC-V's and MIPS' enforce a 33-tail calls
limit at runtime.  In addition, a test was recently added, in tailcalls2,
to check this limit.

This patch updates the tail call limit in RISC-V's JIT compiler to allow
33 tail calls.  I tested it using the above selftest on an emulated
RISCV64.

Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
Reported-by: Mahshid Khezri <khezri.mahshid@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/966fe384383bf23a0ee1efe8d7291c78a3fb832b.1575916815.git.paul.chaignon@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
index 5451ef3845f2..7fbf56aab661 100644
--- a/arch/riscv/net/bpf_jit_comp.c
+++ b/arch/riscv/net/bpf_jit_comp.c
@@ -631,14 +631,14 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
 		return -1;
 	emit(rv_bgeu(RV_REG_A2, RV_REG_T1, off >> 1), ctx);
 
-	/* if (--TCC < 0)
+	/* if (TCC-- < 0)
 	 *     goto out;
 	 */
 	emit(rv_addi(RV_REG_T1, tcc, -1), ctx);
 	off = (tc_ninsn - (ctx->ninsns - start_insn)) << 2;
 	if (is_13b_check(off, insn))
 		return -1;
-	emit(rv_blt(RV_REG_T1, RV_REG_ZERO, off >> 1), ctx);
+	emit(rv_blt(tcc, RV_REG_ZERO, off >> 1), ctx);
 
 	/* prog = array->ptrs[index];
 	 * if (!prog)
-- 
2.20.1

