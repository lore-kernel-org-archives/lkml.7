Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355639;
	bh=5YL+rWJV1VY0G7h6sA/ONOHxtJlgO2PM6OISqDGaYH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATStlZiGB4e6j0NXsM5QA2gqtnKI8jMsFxYc1VHP36LQ5eXQSkeoGrGZY04QiMA1k
	 5YzcrHQLaZHatRswuTFsXG3eHb3lDQ7nexbDJrK0PHtsTZCCBcL85v4o3l4bQ8d+ac
	 yjg3l3xb0QnC3EN5w2rdY5Djqtrc/OfNRBFBhkHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfDOTN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbfDOTNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A9520880;
        Mon, 15 Apr 2019 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355635;
        bh=5YL+rWJV1VY0G7h6sA/ONOHxtJlgO2PM6OISqDGaYH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osLex4tWBcirSQgsjgffGOz+pXGVIEeygzgH34XHYe9z2/3gN2sl9cTc3iVLkTak1
         6d1gk/ZQdbn+o3phfw2xz9m10m28HIZFQZ89ViWi3G5sclB6Sm7t73CRRlG8/3H9M4
         69SCP3UXuMgv2N7h6LwFJd4E1570VqzV9uJbzguw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.0 095/117] arm64/ftrace: fix inadvertent BUG() in trampoline check
Date:   Mon, 15 Apr 2019 21:01:05 +0200
Message-Id: <20190415183749.669767123@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 5a3ae7b314a2259b1188b22b392f5eba01e443ee upstream.

The ftrace trampoline code (which deals with modules loaded out of
BL range of the core kernel) uses plt_entries_equal() to check whether
the per-module trampoline equals a zero buffer, to decide whether the
trampoline has already been initialized.

This triggers a BUG() in the opcode manipulation code, since we end
up checking the ADRP offset of a 0x0 opcode, which is not an ADRP
instruction.

So instead, add a helper to check whether a PLT is initialized, and
call that from the frace code.

Cc: <stable@vger.kernel.org> # v5.0
Fixes: bdb85cd1d206 ("arm64/module: switch to ADRP/ADD sequences for PLT entries")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/module.h |    5 +++++
 arch/arm64/kernel/ftrace.c      |    3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -73,4 +73,9 @@ static inline bool is_forbidden_offset_f
 struct plt_entry get_plt_entry(u64 dst, void *pc);
 bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b);
 
+static inline bool plt_entry_is_initialized(const struct plt_entry *e)
+{
+	return e->adrp || e->add || e->br;
+}
+
 #endif /* __ASM_MODULE_H */
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -107,8 +107,7 @@ int ftrace_make_call(struct dyn_ftrace *
 		trampoline = get_plt_entry(addr, mod->arch.ftrace_trampoline);
 		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
 				       &trampoline)) {
-			if (!plt_entries_equal(mod->arch.ftrace_trampoline,
-					       &(struct plt_entry){})) {
+			if (plt_entry_is_initialized(mod->arch.ftrace_trampoline)) {
 				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
 				return -EINVAL;
 			}


