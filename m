Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF540C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA882196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256156;
	bh=j1H0mLtazSwEK7wKm27j+DY9lrFjAlxrBi6QPnRLBV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEK7Oaa+KVKMTeYFqItsOzPpbkY3WoGJXV93mlEYOjvghXZequ6zL8IvzPOZcvclQ
	 8wDjlxeWLdzJkxAHxFX0uY9Jv0qQ0jf5IJ5MFkAheDl99X0ddr+mM7h9AsiGoDOBL1
	 GIjGoXO/vxRI0Wpe117q/EXozeKXfkqzp56/xUaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfCVMCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388377AbfCVMCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C9C21A4A;
        Fri, 22 Mar 2019 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256151;
        bh=j1H0mLtazSwEK7wKm27j+DY9lrFjAlxrBi6QPnRLBV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXG5j4JNuaqkVrVOdhCl6N9Ib7Vhd0tFpw7Uz9C4g//7nGez8FGkydfiXpZuUD9m4
         wc1/bhVNNzv01vuXTgevP9L7G4j/tsS6d1m5OWURfmWveOFw7gn4K8xFMUcEwOZVaD
         pLhqwvqSY35qbLxlXeEyalws9vzWiDREfT/U1EAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/280] nfp: bpf: fix ALU32 high bits clearance bug
Date:   Fri, 22 Mar 2019 12:14:19 +0100
Message-Id: <20190322111312.840486844@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



