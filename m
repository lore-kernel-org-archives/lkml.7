Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00067C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A82082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255354;
	bh=bLTgprw7XxkCeCGfZSMM1Ri67rYK3+u4ryvesb7xiXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n70nayycagaSWrfOZAME5r0tknXF9XFkH46bmZiq+gBd7TCO/0n7KtKrj4QqXVsq3
	 5M1172oLECp0rtbaUR1owAw60nTA9pWAXTDFrknzHD6CtASMSPMdRLGdltgSP/dv8z
	 2LMfqlRPlcEKOq8j/OltAxgwilI/HfzEDLZk+14I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfCVLtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfCVLtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E4E20693;
        Fri, 22 Mar 2019 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255349;
        bh=bLTgprw7XxkCeCGfZSMM1Ri67rYK3+u4ryvesb7xiXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+gFEx9rbnqy5FOSpiMPC8AL1y3zP9QJtDxkeuc2uQovW/ECMiDg4bkC4ulylv9cQ
         s2euGjU8oo65iegNkkn5CHcK25202zY0f5qL1qr5W+XW2p0NT4vW+oNgdU3hZTghuL
         SyeWl6ZAtrzK+hBaPi1z+JslHhyi0muklaUh/V5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 063/183] nfp: bpf: fix ALU32 high bits clearance bug
Date:   Fri, 22 Mar 2019 12:14:51 +0100
Message-Id: <20190322111246.274415130@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 3105ee5bbf8e..c1ffec85817a 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -756,15 +756,10 @@ wrp_alu64_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 
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
 
@@ -1017,7 +1012,7 @@ static int xor_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int xor_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR);
 }
 
 static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1027,7 +1022,7 @@ static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int and_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND, !~meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND);
 }
 
 static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1037,7 +1032,7 @@ static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int or_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR);
 }
 
 static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1047,7 +1042,7 @@ static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int add_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD);
 }
 
 static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1057,7 +1052,7 @@ static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int sub_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB);
 }
 
 static int shl_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
-- 
2.19.1



