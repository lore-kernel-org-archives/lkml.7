Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D59C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2AC218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610831;
	bh=BnnITovElPYBfE6IWP8UPNud6fppdsQJ3xGS4XsHsSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0eDFWfbDCQzXaciDrLHGL9JWky1pOO2illuVWZqfTPn3SAmTIkdp1zbfOE1jxg3c6
	 hCJ+Y8c0UbafXEOs+6qywmWiKaZFCjpOYxXoJFxRGGg82nArXPxVDeyhjEJ644WJ7T
	 UfgZrvSPOSz0KXBDSHSLLTYieyE38vwpUc7abKIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbfDRSHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390981AbfDRSHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AD9217FA;
        Thu, 18 Apr 2019 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610823;
        bh=BnnITovElPYBfE6IWP8UPNud6fppdsQJ3xGS4XsHsSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfuoHcLHcI2nBcUT1tdtcfAHc/5oGT3f7jTDmqL/RFqZLDbtwEsnhjD0B/Kl+Wt/i
         DlefCnwTMenqCl0pVypR4cWuYW6eg3dVsoZNnjpG9kXataoz+p91MpRB+3OqJIbVKx
         oe1RRYMP9ghA8Jzqx0zqOZOD/VrtzaJ+qkbHZ1w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Vallish Vaidyeshwara <vallish@amazon.com>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 77/92] bpf: move {prev_,}insn_idx into verifier env
Date:   Thu, 18 Apr 2019 19:57:35 +0200
Message-Id: <20190418160437.013658980@linuxfoundation.org>
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

commit c08435ec7f2bc8f4109401f696fd55159b4b40cb upstream.

Move prev_insn_idx and insn_idx from the do_check() function into
the verifier environment, so they can be read inside the various
helper functions for handling the instructions. It's easier to put
this into the environment rather than changing all call-sites only
to pass it along. insn_idx is useful in particular since this later
on allows to hold state in env->insn_aux_data[env->insn_idx].

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Vallish Vaidyeshwara <vallish@amazon.com>
[Backported to 4.14 by sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf_verifier.h |    2 +
 kernel/bpf/verifier.c        |   64 ++++++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -134,6 +134,8 @@ struct bpf_ext_analyzer_ops {
  * one verifier_env per bpf_check() call
  */
 struct bpf_verifier_env {
+	u32 insn_idx;
+	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3892,7 +3892,6 @@ static int do_check(struct bpf_verifier_
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct bpf_reg_state *regs;
 	int insn_cnt = env->prog->len;
-	int insn_idx, prev_insn_idx = 0;
 	int insn_processed = 0;
 	bool do_print_state = false;
 
@@ -3902,19 +3901,18 @@ static int do_check(struct bpf_verifier_
 	env->cur_state = state;
 	init_reg_state(state->regs);
 	state->parent = NULL;
-	insn_idx = 0;
 	for (;;) {
 		struct bpf_insn *insn;
 		u8 class;
 		int err;
 
-		if (insn_idx >= insn_cnt) {
+		if (env->insn_idx >= insn_cnt) {
 			verbose("invalid insn idx %d insn_cnt %d\n",
-				insn_idx, insn_cnt);
+				env->insn_idx, insn_cnt);
 			return -EFAULT;
 		}
 
-		insn = &insns[insn_idx];
+		insn = &insns[env->insn_idx];
 		class = BPF_CLASS(insn->code);
 
 		if (++insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
@@ -3923,7 +3921,7 @@ static int do_check(struct bpf_verifier_
 			return -E2BIG;
 		}
 
-		err = is_state_visited(env, insn_idx);
+		err = is_state_visited(env, env->insn_idx);
 		if (err < 0)
 			return err;
 		if (err == 1) {
@@ -3931,9 +3929,9 @@ static int do_check(struct bpf_verifier_
 			if (log_level) {
 				if (do_print_state)
 					verbose("\nfrom %d to %d: safe\n",
-						prev_insn_idx, insn_idx);
+						env->prev_insn_idx, env->insn_idx);
 				else
-					verbose("%d: safe\n", insn_idx);
+					verbose("%d: safe\n", env->insn_idx);
 			}
 			goto process_bpf_exit;
 		}
@@ -3943,25 +3941,25 @@ static int do_check(struct bpf_verifier_
 
 		if (log_level > 1 || (log_level && do_print_state)) {
 			if (log_level > 1)
-				verbose("%d:", insn_idx);
+				verbose("%d:", env->insn_idx);
 			else
 				verbose("\nfrom %d to %d:",
-					prev_insn_idx, insn_idx);
+					env->prev_insn_idx, env->insn_idx);
 			print_verifier_state(env->cur_state);
 			do_print_state = false;
 		}
 
 		if (log_level) {
-			verbose("%d: ", insn_idx);
+			verbose("%d: ", env->insn_idx);
 			print_bpf_insn(env, insn);
 		}
 
-		err = ext_analyzer_insn_hook(env, insn_idx, prev_insn_idx);
+		err = ext_analyzer_insn_hook(env, env->insn_idx, env->prev_insn_idx);
 		if (err)
 			return err;
 
 		regs = cur_regs(env);
-		env->insn_aux_data[insn_idx].seen = true;
+		env->insn_aux_data[env->insn_idx].seen = true;
 		if (class == BPF_ALU || class == BPF_ALU64) {
 			err = check_alu_op(env, insn);
 			if (err)
@@ -3986,13 +3984,13 @@ static int do_check(struct bpf_verifier_
 			/* check that memory (src_reg + off) is readable,
 			 * the state of dst_reg will be updated by this func
 			 */
-			err = check_mem_access(env, insn_idx, insn->src_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_READ,
-					       insn->dst_reg, false);
+			err = check_mem_access(env, env->insn_idx, insn->src_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_READ, insn->dst_reg, false);
 			if (err)
 				return err;
 
-			prev_src_type = &env->insn_aux_data[insn_idx].ptr_type;
+			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
 
 			if (*prev_src_type == NOT_INIT) {
 				/* saw a valid insn
@@ -4019,10 +4017,10 @@ static int do_check(struct bpf_verifier_
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_XADD) {
-				err = check_xadd(env, insn_idx, insn);
+				err = check_xadd(env, env->insn_idx, insn);
 				if (err)
 					return err;
-				insn_idx++;
+				env->insn_idx++;
 				continue;
 			}
 
@@ -4038,13 +4036,13 @@ static int do_check(struct bpf_verifier_
 			dst_reg_type = regs[insn->dst_reg].type;
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_WRITE,
-					       insn->src_reg, false);
+			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_WRITE, insn->src_reg, false);
 			if (err)
 				return err;
 
-			prev_dst_type = &env->insn_aux_data[insn_idx].ptr_type;
+			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
 
 			if (*prev_dst_type == NOT_INIT) {
 				*prev_dst_type = dst_reg_type;
@@ -4073,9 +4071,9 @@ static int do_check(struct bpf_verifier_
 			}
 
 			/* check that memory (dst_reg + off) is writeable */
-			err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-					       BPF_SIZE(insn->code), BPF_WRITE,
-					       -1, false);
+			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+					       insn->off, BPF_SIZE(insn->code),
+					       BPF_WRITE, -1, false);
 			if (err)
 				return err;
 
@@ -4091,7 +4089,7 @@ static int do_check(struct bpf_verifier_
 					return -EINVAL;
 				}
 
-				err = check_call(env, insn->imm, insn_idx);
+				err = check_call(env, insn->imm, env->insn_idx);
 				if (err)
 					return err;
 
@@ -4104,7 +4102,7 @@ static int do_check(struct bpf_verifier_
 					return -EINVAL;
 				}
 
-				insn_idx += insn->off + 1;
+				env->insn_idx += insn->off + 1;
 				continue;
 
 			} else if (opcode == BPF_EXIT) {
@@ -4132,7 +4130,7 @@ static int do_check(struct bpf_verifier_
 				}
 
 process_bpf_exit:
-				err = pop_stack(env, &prev_insn_idx, &insn_idx);
+				err = pop_stack(env, &env->prev_insn_idx, &env->insn_idx);
 				if (err < 0) {
 					if (err != -ENOENT)
 						return err;
@@ -4142,7 +4140,7 @@ process_bpf_exit:
 					continue;
 				}
 			} else {
-				err = check_cond_jmp_op(env, insn, &insn_idx);
+				err = check_cond_jmp_op(env, insn, &env->insn_idx);
 				if (err)
 					return err;
 			}
@@ -4159,8 +4157,8 @@ process_bpf_exit:
 				if (err)
 					return err;
 
-				insn_idx++;
-				env->insn_aux_data[insn_idx].seen = true;
+				env->insn_idx++;
+				env->insn_aux_data[env->insn_idx].seen = true;
 			} else {
 				verbose("invalid BPF_LD mode\n");
 				return -EINVAL;
@@ -4170,7 +4168,7 @@ process_bpf_exit:
 			return -EINVAL;
 		}
 
-		insn_idx++;
+		env->insn_idx++;
 	}
 
 	verbose("processed %d insns, stack depth %d\n",


