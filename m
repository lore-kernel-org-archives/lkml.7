Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D165DC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66DC21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599176;
	bh=7g0KLZ3AYtEIdel+tDxRwK9bgHudtFZEhasU/qDui7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMARrgjXLRN1gfCRWDn5i7DDFd80mGkuQQ3ZsdtP2IeFwyVZI0JrGFD/gsS2t4Y1F
	 5+rRfKlSIOnKrHuDI/+fm4TbP6Y5hsEW2T1Eb3v4TloiUqW9jNTSj8rSwnYa9bhBY4
	 CXgWlpvs/0oWX/cALM+6JlMlIJsgSxAGUbt1Io9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfGHPTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbfGHPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:19:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DC0216E3;
        Mon,  8 Jul 2019 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599173;
        bh=7g0KLZ3AYtEIdel+tDxRwK9bgHudtFZEhasU/qDui7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2kG1nhtYRN2NbHuRn+a1fmnR+Ab8sgRCaYXnMkmBPr2+jYgsPATbDse5pyX1ZGaPe
         ZidUjNj+unM+ew91l3wOd5I+HbjnPoPXYTo5cx1SfmIWvYn4jDpXzKDZIP0gX5bgG/
         gTwGaSx5CFwBAoSg+kwtZm+jG9AaG9/A4rYKXLK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.9 029/102] powerpc/bpf: use unsigned division instruction for 64-bit operations
Date:   Mon,  8 Jul 2019 17:12:22 +0200
Message-Id: <20190708150527.829196928@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit 758f2046ea040773ae8ea7f72dd3bbd8fa984501 upstream.

BPF_ALU64 div/mod operations are currently using signed division, unlike
BPF_ALU32 operations. Fix the same. DIV64 and MOD64 overflow tests pass
with this fix.

Fixes: 156d0e290e969c ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/ppc-opcode.h |    1 +
 arch/powerpc/net/bpf_jit.h            |    2 +-
 arch/powerpc/net/bpf_jit_comp64.c     |    8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -261,6 +261,7 @@
 #define PPC_INST_MULLI			0x1c000000
 #define PPC_INST_DIVWU			0x7c000396
 #define PPC_INST_DIVD			0x7c0003d2
+#define PPC_INST_DIVDU			0x7c000392
 #define PPC_INST_RLWINM			0x54000000
 #define PPC_INST_RLWIMI			0x50000000
 #define PPC_INST_RLDICL			0x78000000
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -116,7 +116,7 @@
 				     ___PPC_RA(a) | IMM_L(i))
 #define PPC_DIVWU(d, a, b)	EMIT(PPC_INST_DIVWU | ___PPC_RT(d) |	      \
 				     ___PPC_RA(a) | ___PPC_RB(b))
-#define PPC_DIVD(d, a, b)	EMIT(PPC_INST_DIVD | ___PPC_RT(d) |	      \
+#define PPC_DIVDU(d, a, b)	EMIT(PPC_INST_DIVDU | ___PPC_RT(d) |	      \
 				     ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_AND(d, a, b)	EMIT(PPC_INST_AND | ___PPC_RA(d) |	      \
 				     ___PPC_RS(a) | ___PPC_RB(b))
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -419,12 +419,12 @@ static int bpf_jit_build_body(struct bpf
 			PPC_LI(b2p[BPF_REG_0], 0);
 			PPC_JMP(exit_addr);
 			if (BPF_OP(code) == BPF_MOD) {
-				PPC_DIVD(b2p[TMP_REG_1], dst_reg, src_reg);
+				PPC_DIVDU(b2p[TMP_REG_1], dst_reg, src_reg);
 				PPC_MULD(b2p[TMP_REG_1], src_reg,
 						b2p[TMP_REG_1]);
 				PPC_SUB(dst_reg, dst_reg, b2p[TMP_REG_1]);
 			} else
-				PPC_DIVD(dst_reg, dst_reg, src_reg);
+				PPC_DIVDU(dst_reg, dst_reg, src_reg);
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
 		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
@@ -452,7 +452,7 @@ static int bpf_jit_build_body(struct bpf
 				break;
 			case BPF_ALU64:
 				if (BPF_OP(code) == BPF_MOD) {
-					PPC_DIVD(b2p[TMP_REG_2], dst_reg,
+					PPC_DIVDU(b2p[TMP_REG_2], dst_reg,
 							b2p[TMP_REG_1]);
 					PPC_MULD(b2p[TMP_REG_1],
 							b2p[TMP_REG_1],
@@ -460,7 +460,7 @@ static int bpf_jit_build_body(struct bpf
 					PPC_SUB(dst_reg, dst_reg,
 							b2p[TMP_REG_1]);
 				} else
-					PPC_DIVD(dst_reg, dst_reg,
+					PPC_DIVDU(dst_reg, dst_reg,
 							b2p[TMP_REG_1]);
 				break;
 			}


