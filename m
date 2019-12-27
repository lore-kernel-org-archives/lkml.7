Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E7C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED1206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468951;
	bh=YgJ1Rj9xwayAqRHWe+d8iXp2E6DpWtapNBQW+ENO0ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1wqot9JWIZ7FAP3j7CcCPuj1R16FNIlyJsIW8pOeng+fccsz13WYUuDe2KJOGoD85
	 dr3fj7DNWGsGP5g7TZET1zoFbFNRM1Y4hFJMQPknxJba8kAzTmHqBct22Ov+v2WqrY
	 O+nHaWCn8tuQ+B/Zf7g78gg7fZHWaZD2CWLmTnzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfL0RtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:49:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfL0Rof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B961722522;
        Fri, 27 Dec 2019 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468674;
        bh=YgJ1Rj9xwayAqRHWe+d8iXp2E6DpWtapNBQW+ENO0ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjtNQ0xFmWGUiaXa15XJvFLbxnB6XjejKN8/f7mpv8GqMN+U/wVfioD5zH1FRWDJi
         p5EN8vwnOP3gMuumb6tpMgnu3FI03R538GIyTd2fyoKdOBCLHsEDrLjNV1zInTsNjW
         i2mKC8jkmchHtrLbb+AcIJTt3MWGmDJ0j4Csufww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Chaignon <paul.chaignon@orange.com>,
        Mahshid Khezri <khezri.mahshid@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/84] bpf, mips: Limit to 33 tail calls
Date:   Fri, 27 Dec 2019 12:43:02 -0500
Message-Id: <20191227174352.6264-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Chaignon <paul.chaignon@orange.com>

[ Upstream commit e49e6f6db04e915dccb494ae10fa14888fea6f89 ]

All BPF JIT compilers except RISC-V's and MIPS' enforce a 33-tail calls
limit at runtime.  In addition, a test was recently added, in tailcalls2,
to check this limit.

This patch updates the tail call limit in MIPS' JIT compiler to allow
33 tail calls.

Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Reported-by: Mahshid Khezri <khezri.mahshid@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/b8eb2caac1c25453c539248e56ca22f74b5316af.1575916815.git.paul.chaignon@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/net/ebpf_jit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index 9bda82ed75eb..3832c4628608 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -586,6 +586,7 @@ static void emit_const_to_reg(struct jit_ctx *ctx, int dst, u64 value)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int this_idx)
 {
 	int off, b_off;
+	int tcc_reg;
 
 	ctx->flags |= EBPF_SEEN_TC;
 	/*
@@ -598,14 +599,14 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int this_idx)
 	b_off = b_imm(this_idx + 1, ctx);
 	emit_instr(ctx, bne, MIPS_R_AT, MIPS_R_ZERO, b_off);
 	/*
-	 * if (--TCC < 0)
+	 * if (TCC-- < 0)
 	 *     goto out;
 	 */
 	/* Delay slot */
-	emit_instr(ctx, daddiu, MIPS_R_T5,
-		   (ctx->flags & EBPF_TCC_IN_V1) ? MIPS_R_V1 : MIPS_R_S4, -1);
+	tcc_reg = (ctx->flags & EBPF_TCC_IN_V1) ? MIPS_R_V1 : MIPS_R_S4;
+	emit_instr(ctx, daddiu, MIPS_R_T5, tcc_reg, -1);
 	b_off = b_imm(this_idx + 1, ctx);
-	emit_instr(ctx, bltz, MIPS_R_T5, b_off);
+	emit_instr(ctx, bltz, tcc_reg, b_off);
 	/*
 	 * prog = array->ptrs[index];
 	 * if (prog == NULL)
-- 
2.20.1

