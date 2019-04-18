Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FDB206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610833;
	bh=cmqXPQJXxvTCRuC2Nqr0FsEmX7kmCJ3YIjWZ23rz1aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXZ9mzPSsGZOds8pPDurv6Ua9a2NH7IsxchmX1ed4jU8FHe0y7eiSjXCmNt9ylMw5
	 fVjxE20XKcgT2yMRKRI6M/lsYyYiwycejqC85XfDvE1fjUFPMZOo09/xW9uvIkTIus
	 rWa7gZVYuEB+cAj18u6CWvYeyy9HU59GNDyUikdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbfDRSHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391591AbfDRSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B88218DA;
        Thu, 18 Apr 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610828;
        bh=cmqXPQJXxvTCRuC2Nqr0FsEmX7kmCJ3YIjWZ23rz1aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kv3SM8W/liVE1Gvr/xgZiAE91cJEV3mfLfGAiL5iCDNU7bzIxsK4P+r8Srm7n4Wdt
         UIaeJJl4nosaOPg69NsycDNciiqPrVAV5cTVxh2DF97AlzEwBVQmyOVajDmWnJya8g
         zjQW1r0IAausrAkwWfyTTNBNn23VKAuNgIsJpVu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 79/92] bpf: enable access to ax register also from verifier rewrite
Date:   Thu, 18 Apr 2019 19:57:37 +0200
Message-Id: <20190418160437.341757519@linuxfoundation.org>
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

commit 9b73bfdd08e73231d6a90ae6db4b46b3fbf56c30 upstream.

Right now we are using BPF ax register in JIT for constant blinding as
well as in interpreter as temporary variable. Verifier will not be able
to use it simply because its use will get overridden from the former in
bpf_jit_blind_insn(). However, it can be made to work in that blinding
will be skipped if there is prior use in either source or destination
register on the instruction. Taking constraints of ax into account, the
verifier is then open to use it in rewrites under some constraints. Note,
ax register already has mappings in every eBPF JIT.


Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[backported to 4.14 sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/filter.h |    7 +------
 kernel/bpf/core.c      |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -46,12 +46,7 @@ struct bpf_prog_aux;
 #define BPF_REG_X	BPF_REG_7
 #define BPF_REG_TMP	BPF_REG_8
 
-/* Kernel hidden auxiliary/helper register for hardening step.
- * Only used by eBPF JITs. It's nothing more than a temporary
- * register that JITs use internally, only that here it's part
- * of eBPF instructions that have been rewritten for blinding
- * constants. See JIT pre-step in bpf_jit_blind_constants().
- */
+/* Kernel hidden auxiliary/helper register. */
 #define BPF_REG_AX		MAX_BPF_REG
 #define MAX_BPF_EXT_REG		(MAX_BPF_REG + 1)
 #define MAX_BPF_JIT_REG		MAX_BPF_EXT_REG
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -553,6 +553,26 @@ static int bpf_jit_blind_insn(const stru
 	BUILD_BUG_ON(BPF_REG_AX  + 1 != MAX_BPF_JIT_REG);
 	BUILD_BUG_ON(MAX_BPF_REG + 1 != MAX_BPF_JIT_REG);
 
+	/* Constraints on AX register:
+	 *
+	 * AX register is inaccessible from user space. It is mapped in
+	 * all JITs, and used here for constant blinding rewrites. It is
+	 * typically "stateless" meaning its contents are only valid within
+	 * the executed instruction, but not across several instructions.
+	 * There are a few exceptions however which are further detailed
+	 * below.
+	 *
+	 * Constant blinding is only used by JITs, not in the interpreter.
+	 * The interpreter uses AX in some occasions as a local temporary
+	 * register e.g. in DIV or MOD instructions.
+	 *
+	 * In restricted circumstances, the verifier can also use the AX
+	 * register for rewrites as long as they do not interfere with
+	 * the above cases!
+	 */
+	if (from->dst_reg == BPF_REG_AX || from->src_reg == BPF_REG_AX)
+		goto out;
+
 	if (from->imm == 0 &&
 	    (from->code == (BPF_ALU   | BPF_MOV | BPF_K) ||
 	     from->code == (BPF_ALU64 | BPF_MOV | BPF_K))) {


