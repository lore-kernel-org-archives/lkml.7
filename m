Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3C22133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138901;
	bh=wjJvFYW+USoFjHkoO7lU5JzDcCryPJkCHMbclBgzm8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yADMqbeE6plI0P9/Jl/gLP5Q2f00Y5aki1J4/ZAqz+0e9nmoHnJwyXGTLTqKcLAql
	 WaOYEBkv0ACmDiLg82asr3pWTbWSxshrGiiChqUogtxl9qePUBqh2uiZsfo3Emtk/s
	 BZu21jNf2wuAjr79/9kP5hdlCyXewului1ZmxB3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfDARO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbfDARO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E18D206C0;
        Mon,  1 Apr 2019 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138894;
        bh=wjJvFYW+USoFjHkoO7lU5JzDcCryPJkCHMbclBgzm8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3nquCTkP9lkAx86YMpZchW0XBGcqNBXNuczCdw8QzzBp75Gr32xweKN4Az8iGNrc
         PqzIiF2g66qyCui6ktyBsM0RldTVXsfl/irNZeBRj3y+qOYtqcRlfPrMiJsCBkR18Y
         SkNamUBIye0VLriiVd2bb0n1wsONavKNCWUJY19c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.19 052/134] powerpc: bpf: Fix generation of load/store DW instructions
Date:   Mon,  1 Apr 2019 19:01:28 +0200
Message-Id: <20190401170049.402990760@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit 86be36f6502c52ddb4b85938145324fd07332da1 upstream.

Yauheni Kaliuta pointed out that PTR_TO_STACK store/load verifier test
was failing on powerpc64 BE, and rightfully indicated that the PPC_LD()
macro is not masking away the last two bits of the offset per the ISA,
resulting in the generation of 'lwa' instruction instead of the intended
'ld' instruction.

Segher also pointed out that we can't simply mask away the last two bits
as that will result in loading/storing from/to a memory location that
was not intended.

This patch addresses this by using ldx/stdx if the offset is not
word-aligned. We load the offset into a temporary register (TMP_REG_2)
and use that as the index register in a subsequent ldx/stdx. We fix
PPC_LD() macro to mask off the last two bits, but enhance PPC_BPF_LL()
and PPC_BPF_STL() to factor in the offset value and generate the proper
instruction sequence. We also convert all existing users of PPC_LD() and
PPC_STD() to use these macros. All existing uses of these macros have
been audited to ensure that TMP_REG_2 can be clobbered.

Fixes: 156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
Cc: stable@vger.kernel.org # v4.9+

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/ppc-opcode.h |    2 ++
 arch/powerpc/net/bpf_jit.h            |   17 +++++------------
 arch/powerpc/net/bpf_jit32.h          |    4 ++++
 arch/powerpc/net/bpf_jit64.h          |   20 ++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c     |   12 ++++++------
 5 files changed, 37 insertions(+), 18 deletions(-)

--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -300,6 +300,7 @@
 /* Misc instructions for BPF compiler */
 #define PPC_INST_LBZ			0x88000000
 #define PPC_INST_LD			0xe8000000
+#define PPC_INST_LDX			0x7c00002a
 #define PPC_INST_LHZ			0xa0000000
 #define PPC_INST_LWZ			0x80000000
 #define PPC_INST_LHBRX			0x7c00062c
@@ -307,6 +308,7 @@
 #define PPC_INST_STB			0x98000000
 #define PPC_INST_STH			0xb0000000
 #define PPC_INST_STD			0xf8000000
+#define PPC_INST_STDX			0x7c00012a
 #define PPC_INST_STDU			0xf8000001
 #define PPC_INST_STW			0x90000000
 #define PPC_INST_STWU			0x94000000
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -51,6 +51,8 @@
 #define PPC_LIS(r, i)		PPC_ADDIS(r, 0, i)
 #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
+#define PPC_STDX(r, base, b)	EMIT(PPC_INST_STDX | ___PPC_RS(r) |	      \
+				     ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_STDU(r, base, i)	EMIT(PPC_INST_STDU | ___PPC_RS(r) |	      \
 				     ___PPC_RA(base) | ((i) & 0xfffc))
 #define PPC_STW(r, base, i)	EMIT(PPC_INST_STW | ___PPC_RS(r) |	      \
@@ -65,7 +67,9 @@
 #define PPC_LBZ(r, base, i)	EMIT(PPC_INST_LBZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
-				     ___PPC_RA(base) | IMM_L(i))
+				     ___PPC_RA(base) | ((i) & 0xfffc))
+#define PPC_LDX(r, base, b)	EMIT(PPC_INST_LDX | ___PPC_RT(r) |	      \
+				     ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_LWZ(r, base, i)	EMIT(PPC_INST_LWZ | ___PPC_RT(r) |	      \
 				     ___PPC_RA(base) | IMM_L(i))
 #define PPC_LHZ(r, base, i)	EMIT(PPC_INST_LHZ | ___PPC_RT(r) |	      \
@@ -85,17 +89,6 @@
 					___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_BPF_STDCX(s, a, b)	EMIT(PPC_INST_STDCX | ___PPC_RS(s) |	      \
 					___PPC_RA(a) | ___PPC_RB(b))
-
-#ifdef CONFIG_PPC64
-#define PPC_BPF_LL(r, base, i) do { PPC_LD(r, base, i); } while(0)
-#define PPC_BPF_STL(r, base, i) do { PPC_STD(r, base, i); } while(0)
-#define PPC_BPF_STLU(r, base, i) do { PPC_STDU(r, base, i); } while(0)
-#else
-#define PPC_BPF_LL(r, base, i) do { PPC_LWZ(r, base, i); } while(0)
-#define PPC_BPF_STL(r, base, i) do { PPC_STW(r, base, i); } while(0)
-#define PPC_BPF_STLU(r, base, i) do { PPC_STWU(r, base, i); } while(0)
-#endif
-
 #define PPC_CMPWI(a, i)		EMIT(PPC_INST_CMPWI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPDI(a, i)		EMIT(PPC_INST_CMPDI | ___PPC_RA(a) | IMM_L(i))
 #define PPC_CMPW(a, b)		EMIT(PPC_INST_CMPW | ___PPC_RA(a) |	      \
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -123,6 +123,10 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 #define PPC_NTOHS_OFFS(r, base, i)	PPC_LHZ_OFFS(r, base, i)
 #endif
 
+#define PPC_BPF_LL(r, base, i) do { PPC_LWZ(r, base, i); } while(0)
+#define PPC_BPF_STL(r, base, i) do { PPC_STW(r, base, i); } while(0)
+#define PPC_BPF_STLU(r, base, i) do { PPC_STWU(r, base, i); } while(0)
+
 #define SEEN_DATAREF 0x10000 /* might call external helpers */
 #define SEEN_XREG    0x20000 /* X reg is used */
 #define SEEN_MEM     0x40000 /* SEEN_MEM+(1<<n) = use mem[n] for temporary
--- a/arch/powerpc/net/bpf_jit64.h
+++ b/arch/powerpc/net/bpf_jit64.h
@@ -68,6 +68,26 @@ static const int b2p[] = {
 /* PPC NVR range -- update this if we ever use NVRs below r27 */
 #define BPF_PPC_NVR_MIN		27
 
+/*
+ * WARNING: These can use TMP_REG_2 if the offset is not at word boundary,
+ * so ensure that it isn't in use already.
+ */
+#define PPC_BPF_LL(r, base, i) do {					      \
+				if ((i) % 4) {				      \
+					PPC_LI(b2p[TMP_REG_2], (i));	      \
+					PPC_LDX(r, base, b2p[TMP_REG_2]);     \
+				} else					      \
+					PPC_LD(r, base, i);		      \
+				} while(0)
+#define PPC_BPF_STL(r, base, i) do {					      \
+				if ((i) % 4) {				      \
+					PPC_LI(b2p[TMP_REG_2], (i));	      \
+					PPC_STDX(r, base, b2p[TMP_REG_2]);    \
+				} else					      \
+					PPC_STD(r, base, i);		      \
+				} while(0)
+#define PPC_BPF_STLU(r, base, i) do { PPC_STDU(r, base, i); } while(0)
+
 #define SEEN_FUNC	0x1000 /* might call external helpers */
 #define SEEN_STACK	0x2000 /* uses BPF stack */
 #define SEEN_TAILCALL	0x4000 /* uses tail calls */
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -226,7 +226,7 @@ static void bpf_jit_emit_tail_call(u32 *
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	PPC_LD(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
+	PPC_BPF_LL(b2p[TMP_REG_1], 1, bpf_jit_stack_tailcallcnt(ctx));
 	PPC_CMPLWI(b2p[TMP_REG_1], MAX_TAIL_CALL_CNT);
 	PPC_BCC(COND_GT, out);
 
@@ -239,7 +239,7 @@ static void bpf_jit_emit_tail_call(u32 *
 	/* prog = array->ptrs[index]; */
 	PPC_MULI(b2p[TMP_REG_1], b2p_index, 8);
 	PPC_ADD(b2p[TMP_REG_1], b2p[TMP_REG_1], b2p_bpf_array);
-	PPC_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
+	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_array, ptrs));
 
 	/*
 	 * if (prog == NULL)
@@ -249,7 +249,7 @@ static void bpf_jit_emit_tail_call(u32 *
 	PPC_BCC(COND_EQ, out);
 
 	/* goto *(prog->bpf_func + prologue_size); */
-	PPC_LD(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
+	PPC_BPF_LL(b2p[TMP_REG_1], b2p[TMP_REG_1], offsetof(struct bpf_prog, bpf_func));
 #ifdef PPC64_ELF_ABI_v1
 	/* skip past the function descriptor */
 	PPC_ADDI(b2p[TMP_REG_1], b2p[TMP_REG_1],
@@ -573,7 +573,7 @@ bpf_alu32_trunc:
 				 * the instructions generated will remain the
 				 * same across all passes
 				 */
-				PPC_STD(dst_reg, 1, bpf_jit_stack_local(ctx));
+				PPC_BPF_STL(dst_reg, 1, bpf_jit_stack_local(ctx));
 				PPC_ADDI(b2p[TMP_REG_1], 1, bpf_jit_stack_local(ctx));
 				PPC_LDBRX(dst_reg, 0, b2p[TMP_REG_1]);
 				break;
@@ -629,7 +629,7 @@ emit_clear:
 				PPC_LI32(b2p[TMP_REG_1], imm);
 				src_reg = b2p[TMP_REG_1];
 			}
-			PPC_STD(src_reg, dst_reg, off);
+			PPC_BPF_STL(src_reg, dst_reg, off);
 			break;
 
 		/*
@@ -676,7 +676,7 @@ emit_clear:
 			break;
 		/* dst = *(u64 *)(ul) (src + off) */
 		case BPF_LDX | BPF_MEM | BPF_DW:
-			PPC_LD(dst_reg, src_reg, off);
+			PPC_BPF_LL(dst_reg, src_reg, off);
 			break;
 
 		/*


