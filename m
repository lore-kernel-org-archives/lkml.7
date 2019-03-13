Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720C620657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505178;
	bh=tJc0Qfycx8ivVRr+M7sfBNQSVTXzJRlyoGTii9zg8QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6iCWV3H0ncgwUdpgaDaG6wmkcrU7iMnzM15aKkVA3l6beOpNaFHOl8lqqlGGJW3r
	 OipeER0ltlIcUjZtEO2oF3StyBC30xruwVJ2kj8Mij848mnaPPyln85GLM+lohYsHf
	 dm5f9E+DOHBkvplx4zfhpLIfWV3PeI72hzbqWIVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfCMTO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfCMTOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688142075C;
        Wed, 13 Mar 2019 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504491;
        bh=tJc0Qfycx8ivVRr+M7sfBNQSVTXzJRlyoGTii9zg8QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iChemOBGVO199h0hPgNJOhAOKXBMT2gkCIOOV5R38SVHhaRQHI4lSLVkNaWPUnkE8
         CPyUMXe7C79JTofYuKxNeOneSxdrgq6YDGZIMaS9eNp5/fVMzzwEqjQs6m8ZyPz+m2
         fBXiAIyUmMYIzqHod6leMVcZHNBAIva+TvDoaclg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: [PATCH AUTOSEL 4.19 43/48] nfp: bpf: fix ALU32 high bits clearance bug
Date:   Wed, 13 Mar 2019 15:12:45 -0400
Message-Id: <20190313191250.158955-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit f036ebd9bfbe1e91a3d855e85e05fc5ff156b641 ]

NFP BPF JIT compiler is doing a couple of small optimizations when jitting
ALU imm instructions, some of these optimizations could save code-gen, for
example:

  A & -1 =  A
  A |  0 =  A
  A ^  0 =  A

However, for ALU32, high 32-bit of the 64-bit register should still be
cleared according to ISA semantics.

Fixes: cd7df56ed3e6 ("nfp: add BPF to NFP code translator")
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index 0a934296ea53..4e18d95e548f 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -1288,15 +1288,10 @@ wrp_alu64_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 
 static int
 wrp_alu32_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
-	      enum alu_op alu_op, bool skip)
+	      enum alu_op alu_op)
 {
 	const struct bpf_insn *insn = &meta->insn;
 
-	if (skip) {
-		meta->skip = true;
-		return 0;
-	}
-
 	wrp_alu_imm(nfp_prog, insn->dst_reg * 2, alu_op, insn->imm);
 	wrp_immed(nfp_prog, reg_both(insn->dst_reg * 2 + 1), 0);
 
@@ -2306,7 +2301,7 @@ static int xor_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int xor_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR);
 }
 
 static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2316,7 +2311,7 @@ static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int and_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND, !~meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND);
 }
 
 static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2326,7 +2321,7 @@ static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int or_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR);
 }
 
 static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2336,7 +2331,7 @@ static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int add_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD);
 }
 
 static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2346,7 +2341,7 @@ static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int sub_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB);
 }
 
 static int mul_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
-- 
2.19.1

