Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE0CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C220640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437645;
	bh=KDouM1x/ZhUC/AxhtbM10VlvxvdYU4eTIV21usld9RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VD3Sa0Ea6al2//MQIJY23mzkFM82h5pbN4hNn5FNe7twkaFc0SKUlUDW2MUoe7BW
	 gu8MZC6MY9Sf8PnN43p3rFipuy6w6cFV+iMnre88mWiJkS1BLL4aPqJDK0uukWawpv
	 dPC95Ytox6/s7PY+7uTHvdCuwMGOZS4t9IZqReBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406428AbfJRW1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfJRWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BBE2222C3;
        Fri, 18 Oct 2019 22:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436242;
        bh=KDouM1x/ZhUC/AxhtbM10VlvxvdYU4eTIV21usld9RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+hdJW+6Jj42Zqq+ixfLel6Tmz14SkrkcE4pB1aIXo0ichxaqna/H8na6MwDK1Qqm
         h5isWJlzJ4hWjKRiWjpZQyvxV2GlK58akJ8r5KVtkOOgr+C+2QuvIsT+LJHVs2xUSQ
         D56gtFK05Ev6KS9D13e7RV/WR23QfIqbJXWnskpo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 27/89] arm64: ftrace: Ensure synchronisation in PLT setup for Neoverse-N1 #1542419
Date:   Fri, 18 Oct 2019 18:02:22 -0400
Message-Id: <20191018220324.8165-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

[ Upstream commit dd8a1f13488438c6c220b7cafa500baaf21a6e53 ]

CPUs affected by Neoverse-N1 #1542419 may execute a stale instruction if
it was recently modified. The affected sequence requires freshly written
instructions to be executable before a branch to them is updated.

There are very few places in the kernel that modify executable text,
all but one come with sufficient synchronisation:
 * The module loader's flush_module_icache() calls flush_icache_range(),
   which does a kick_all_cpus_sync()
 * bpf_int_jit_compile() calls flush_icache_range().
 * Kprobes calls aarch64_insn_patch_text(), which does its work in
   stop_machine().
 * static keys and ftrace both patch between nops and branches to
   existing kernel code (not generated code).

The affected sequence is the interaction between ftrace and modules.
The module PLT is cleaned using __flush_icache_range() as the trampoline
shouldn't be executable until we update the branch to it.

Drop the double-underscore so that this path runs kick_all_cpus_sync()
too.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/ftrace.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 1717732579742..06e56b4703153 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -121,10 +121,16 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 			/*
 			 * Ensure updated trampoline is visible to instruction
-			 * fetch before we patch in the branch.
+			 * fetch before we patch in the branch. Although the
+			 * architecture doesn't require an IPI in this case,
+			 * Neoverse-N1 erratum #1542419 does require one
+			 * if the TLB maintenance in module_enable_ro() is
+			 * skipped due to rodata_enabled. It doesn't seem worth
+			 * it to make it conditional given that this is
+			 * certainly not a fast-path.
 			 */
-			__flush_icache_range((unsigned long)&dst[0],
-					     (unsigned long)&dst[1]);
+			flush_icache_range((unsigned long)&dst[0],
+					   (unsigned long)&dst[1]);
 		}
 		addr = (unsigned long)dst;
 #else /* CONFIG_ARM64_MODULE_PLTS */
-- 
2.20.1

