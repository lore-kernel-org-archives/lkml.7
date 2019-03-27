Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C192064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714306;
	bh=Mz3LRQ9HvV8YCCPHLZPUu5Dq2PDMcYBbKYO9oKBC54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLhUQ18TorJBEj2GsKigUMcxW/aUy5mAGXAlSiaoLaipWTEvRYdEFkRpVhCWrZTjI
	 WZvSIHbbaJeT7IIq1AeqSJCtsmlkPDkT4xmi0tCwpsleNyy3RYpaq/eKW7jgLpZ/qw
	 g6N4AsGXtSXaXUsx5ymUToKwjvRRFIXVf0XFsc4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfC0SIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387496AbfC0SIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6021F217F9;
        Wed, 27 Mar 2019 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710089;
        bh=Mz3LRQ9HvV8YCCPHLZPUu5Dq2PDMcYBbKYO9oKBC54w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSLgfmjPAewcRAgf3OzHU+iaAH1zM5/5s7p97IetKhw74XFfUiSaAtuGrj0/lKD7G
         i9USb5pJErah2Ygb4O+W/47H+s4wTl2AYgAaw4QMsLkXVmRgOuV/yPOOj/etQ/qqVX
         PsxZwpcv37yw5qs6EtR/6dO9VAD69LcW0twVV4PY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: [PATCH AUTOSEL 5.0 192/262] nfp: bpf: correct the behavior for shifts by zero
Date:   Wed, 27 Mar 2019 14:00:47 -0400
Message-Id: <20190327180158.10245-192-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit db0a4b3b6b83a081a9ec309cc8178e5c9b4706a5 ]

Shifts by zero do nothing, and should be treated as nops.

Even though compiler is not supposed to generate such instructions and
manual written assembly is unlikely to have them, but they are legal
instructions and have defined behavior.

This patch correct existing shifts code-gen to make sure they do nothing
when shift amount is zero except when the instruction is ALU32 for which
high bits need to be cleared.

For shift amount bigger than type size, already, NFP JIT back-end errors
out for immediate shift and only low 5 bits will be taken into account for
indirect shift which is the same as x86.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 30 +++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index 0a868c829b90..b71ecde7e1d2 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -1958,6 +1958,9 @@ static int neg_reg64(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
  */
 static int __shl_imm64(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
 {
+	if (!shift_amt)
+		return 0;
+
 	if (shift_amt < 32) {
 		emit_shf(nfp_prog, reg_both(dst + 1), reg_a(dst + 1),
 			 SHF_OP_NONE, reg_b(dst), SHF_SC_R_DSHF,
@@ -2070,6 +2073,9 @@ static int shl_reg64(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
  */
 static int __shr_imm64(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
 {
+	if (!shift_amt)
+		return 0;
+
 	if (shift_amt < 32) {
 		emit_shf(nfp_prog, reg_both(dst), reg_a(dst + 1), SHF_OP_NONE,
 			 reg_b(dst), SHF_SC_R_DSHF, shift_amt);
@@ -2171,6 +2177,9 @@ static int shr_reg64(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
  */
 static int __ashr_imm64(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
 {
+	if (!shift_amt)
+		return 0;
+
 	if (shift_amt < 32) {
 		emit_shf(nfp_prog, reg_both(dst), reg_a(dst + 1), SHF_OP_NONE,
 			 reg_b(dst), SHF_SC_R_DSHF, shift_amt);
@@ -2379,10 +2388,13 @@ static int neg_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int __ashr_imm(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
 {
-	/* Set signedness bit (MSB of result). */
-	emit_alu(nfp_prog, reg_none(), reg_a(dst), ALU_OP_OR, reg_imm(0));
-	emit_shf(nfp_prog, reg_both(dst), reg_none(), SHF_OP_ASHR, reg_b(dst),
-		 SHF_SC_R_SHF, shift_amt);
+	if (shift_amt) {
+		/* Set signedness bit (MSB of result). */
+		emit_alu(nfp_prog, reg_none(), reg_a(dst), ALU_OP_OR,
+			 reg_imm(0));
+		emit_shf(nfp_prog, reg_both(dst), reg_none(), SHF_OP_ASHR,
+			 reg_b(dst), SHF_SC_R_SHF, shift_amt);
+	}
 	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
 
 	return 0;
@@ -2424,12 +2436,10 @@ static int shl_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
 	const struct bpf_insn *insn = &meta->insn;
 
-	if (!insn->imm)
-		return 1; /* TODO: zero shift means indirect */
-
-	emit_shf(nfp_prog, reg_both(insn->dst_reg * 2),
-		 reg_none(), SHF_OP_NONE, reg_b(insn->dst_reg * 2),
-		 SHF_SC_L_SHF, insn->imm);
+	if (insn->imm)
+		emit_shf(nfp_prog, reg_both(insn->dst_reg * 2),
+			 reg_none(), SHF_OP_NONE, reg_b(insn->dst_reg * 2),
+			 SHF_SC_L_SHF, insn->imm);
 	wrp_immed(nfp_prog, reg_both(insn->dst_reg * 2 + 1), 0);
 
 	return 0;
-- 
2.19.1

