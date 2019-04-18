Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF87C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12883218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610795;
	bh=l3mEksAhETOfE9vy+dVzH51J7h5d56XNOPUG2rnxr7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UOF7hooDQ1a0vz5Ydl3dBWPG9VaL5Rsmcl2PoO5KLWDD09OHCVi8PWCXROlRvJPJ4
	 1wfUIxk1JeqEHt1IgvEEBLbQRYqmfrmFt0Sh6bq5Y3sEO6dTr3suMJ/o+idnS21i0q
	 N+36kMEO+Tl0d9bcBVSjvrokACYvqtZ+WAnyn4MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbfDRSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391490AbfDRSGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61221217FA;
        Thu, 18 Apr 2019 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610789;
        bh=l3mEksAhETOfE9vy+dVzH51J7h5d56XNOPUG2rnxr7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVwdSiJgv+noFUWpxkyWhNglNyA1dIoyQWzvbtUBVR84JpfR1lkuv+ujwbXrzeSqu
         hMj0eKQN4MuAObZziwqyG2VZ58MBZ6S2JWGmqwaro1e1014vvq/4UuRfylH6b2PYfz
         PtYPBR8wX2MUAI7Qi+YuAA0MI/RnggSnPZLoAR/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Vallish Vaidyeshwara <vallish@amazon.com>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 85/92] bpf: fix sanitation of alu op with pointer / scalar type from different paths
Date:   Thu, 18 Apr 2019 19:57:43 +0200
Message-Id: <20190418160437.947159927@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit d3bd7413e0ca40b60cf60d4003246d067cafdeda upstream.

While 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer
arithmetic") took care of rejecting alu op on pointer when e.g. pointer
came from two different map values with different map properties such as
value size, Jann reported that a case was not covered yet when a given
alu op is used in both "ptr_reg += reg" and "numeric_reg += reg" from
different branches where we would incorrectly try to sanitize based
on the pointer's limit. Catch this corner case and reject the program
instead.

Fixes: 979d63d50c0c ("bpf: prevent out of bounds speculation on pointer arithmetic")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Vallish Vaidyeshwara <vallish@amazon.com>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf_verifier.h |    1 
 kernel/bpf/verifier.c        |   61 +++++++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 13 deletions(-)

--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -117,6 +117,7 @@ struct bpf_verifier_state_list {
 #define BPF_ALU_SANITIZE_SRC		1U
 #define BPF_ALU_SANITIZE_DST		2U
 #define BPF_ALU_NEG_VALUE		(1U << 2)
+#define BPF_ALU_NON_POINTER		(1U << 3)
 #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
 					 BPF_ALU_SANITIZE_DST)
 
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2037,6 +2037,40 @@ static int retrieve_ptr_limit(const stru
 	}
 }
 
+static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
+				    const struct bpf_insn *insn)
+{
+	return env->allow_ptr_leaks || BPF_SRC(insn->code) == BPF_K;
+}
+
+static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
+				       u32 alu_state, u32 alu_limit)
+{
+	/* If we arrived here from different branches with different
+	 * state or limits to sanitize, then this won't work.
+	 */
+	if (aux->alu_state &&
+	    (aux->alu_state != alu_state ||
+	     aux->alu_limit != alu_limit))
+		return -EACCES;
+
+	/* Corresponding fixup done in fixup_bpf_calls(). */
+	aux->alu_state = alu_state;
+	aux->alu_limit = alu_limit;
+	return 0;
+}
+
+static int sanitize_val_alu(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
+{
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+
+	if (can_skip_alu_sanitation(env, insn))
+		return 0;
+
+	return update_alu_sanitation_state(aux, BPF_ALU_NON_POINTER, 0);
+}
+
 static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 			    struct bpf_insn *insn,
 			    const struct bpf_reg_state *ptr_reg,
@@ -2051,7 +2085,7 @@ static int sanitize_ptr_alu(struct bpf_v
 	struct bpf_reg_state tmp;
 	bool ret;
 
-	if (env->allow_ptr_leaks || BPF_SRC(insn->code) == BPF_K)
+	if (can_skip_alu_sanitation(env, insn))
 		return 0;
 
 	/* We already marked aux for masking from non-speculative
@@ -2067,19 +2101,8 @@ static int sanitize_ptr_alu(struct bpf_v
 
 	if (retrieve_ptr_limit(ptr_reg, &alu_limit, opcode, off_is_neg))
 		return 0;
-
-	/* If we arrived here from different branches with different
-	 * limits to sanitize, then this won't work.
-	 */
-	if (aux->alu_state &&
-	    (aux->alu_state != alu_state ||
-	     aux->alu_limit != alu_limit))
+	if (update_alu_sanitation_state(aux, alu_state, alu_limit))
 		return -EACCES;
-
-	/* Corresponding fixup done in fixup_bpf_calls(). */
-	aux->alu_state = alu_state;
-	aux->alu_limit = alu_limit;
-
 do_sim:
 	/* Simulate and find potential out-of-bounds access under
 	 * speculative execution from truncation as a result of
@@ -2360,6 +2383,8 @@ static int adjust_scalar_min_max_vals(st
 	s64 smin_val, smax_val;
 	u64 umin_val, umax_val;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	u32 dst = insn->dst_reg;
+	int ret;
 
 	if (insn_bitness == 32) {
 		/* Relevant for 32-bit RSH: Information can propagate towards
@@ -2394,6 +2419,11 @@ static int adjust_scalar_min_max_vals(st
 
 	switch (opcode) {
 	case BPF_ADD:
+		ret = sanitize_val_alu(env, insn);
+		if (ret < 0) {
+			verbose("R%d tried to add from different pointers or scalars\n", dst);
+			return ret;
+		}
 		if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
 		    signed_add_overflows(dst_reg->smax_value, smax_val)) {
 			dst_reg->smin_value = S64_MIN;
@@ -2413,6 +2443,11 @@ static int adjust_scalar_min_max_vals(st
 		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
 		break;
 	case BPF_SUB:
+		ret = sanitize_val_alu(env, insn);
+		if (ret < 0) {
+			verbose("R%d tried to sub from different pointers or scalars\n", dst);
+			return ret;
+		}
 		if (signed_sub_overflows(dst_reg->smin_value, smax_val) ||
 		    signed_sub_overflows(dst_reg->smax_value, smin_val)) {
 			/* Overflow possible, we know nothing */


