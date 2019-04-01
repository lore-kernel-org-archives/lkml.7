Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138979;
	bh=TwGn2gwko/UelVSeQ2Rbt+G0mxsO1KxyR07M/i8o760=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=thNFRPLH/gvTumnqy0cnWLEWgv2Ju75hzPGCyQ5cg9Xt3oH8tSUxljvZAZOrSa+/u
	 xhBVVQZrN2N0QBDH/DM/J5053fM8gz34e3c/xOP6IxBvg078FFuNoR4IwPF3b3jb3d
	 Ci9dBJJSrhxHGoyqMRqqaevh+Dhh1SgYp41gH6mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfDARQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbfDARQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D3520856;
        Mon,  1 Apr 2019 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138973;
        bh=TwGn2gwko/UelVSeQ2Rbt+G0mxsO1KxyR07M/i8o760=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn4kQHCi7z5oVqrdqLnIWNrr++pOXzXmQnwDBdapVTT91N+UBvAT5to9aXonogB1B
         2LoIuoACiAi1qLQO7jISgRFTi55KMZwsbQw02l46W8rDwPvJhcM8/FeINsmuKYaUqy
         uaP0HBcnd3VLG7IAQoqRcoSvmRVs9F0JLbvXSKRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 037/134] powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)
Date:   Mon,  1 Apr 2019 19:01:13 +0200
Message-Id: <20190401170048.209259393@linuxfoundation.org>
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

From: Diana Craciun <diana.craciun@nxp.com>

commit 10c5e83afd4a3f01712d97d3bb1ae34d5b74a185 upstream.

In order to protect against speculation attacks on
indirect branches, the branch predictor is flushed at
kernel entry to protect for the following situations:
- userspace process attacking another userspace process
- userspace process attacking the kernel
Basically when the privillege level change (i.e. the
kernel is entered), the branch predictor state is flushed.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_64.S       |    5 +++++
 arch/powerpc/kernel/exceptions-64e.S |   26 +++++++++++++++++++++++++-
 arch/powerpc/mm/tlb_low_64e.S        |    7 +++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -80,6 +80,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	beq	2f			/* if from kernel mode */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	BTB_FLUSH(r10)
+END_BTB_FLUSH_SECTION
+#endif
 	ACCOUNT_CPU_USER_ENTRY(r13, r10, r11)
 2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -296,7 +296,8 @@ ret_from_mc_except:
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
 	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
-1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
+1:	type##_BTB_FLUSH		\
+	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
 	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
 	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
 
@@ -328,6 +329,29 @@ ret_from_mc_except:
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define GEN_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		beq 1f;			\
+		BTB_FLUSH(r10)			\
+		1:		\
+	END_BTB_FLUSH_SECTION
+
+#define CRIT_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		BTB_FLUSH(r10)		\
+	END_BTB_FLUSH_SECTION
+
+#define DBG_BTB_FLUSH CRIT_BTB_FLUSH
+#define MC_BTB_FLUSH CRIT_BTB_FLUSH
+#define GDBELL_BTB_FLUSH GEN_BTB_FLUSH
+#else
+#define GEN_BTB_FLUSH
+#define CRIT_BTB_FLUSH
+#define DBG_BTB_FLUSH
+#define GDBELL_BTB_FLUSH
+#endif
+
 #define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			    \
 	EXCEPTION_PROLOG(n, intnum, GEN, addition##_GEN(n))
 
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -70,6 +70,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	std	r15,EX_TLB_R15(r12)
 	std	r10,EX_TLB_CR(r12)
 #ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
 	std	r7,EX_TLB_R7(r12)
 #endif
 	TLB_MISS_PROLOG_STATS


