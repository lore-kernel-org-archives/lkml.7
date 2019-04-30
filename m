Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D249F2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HaUCoP9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfD3LQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:16:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:16:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBFtfY1346626
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:15:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBFtfY1346626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556622957;
        bh=zmLZXMki4lbtPnV30AcLo2TRv3iWX3LutwrOebnDquk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HaUCoP9k1SflB6tBcu+WSHXQm1/wS4/SxliIH4EO+SC3Adruk3TQhNS2yymPX80n8
         3LPM4RPLMwAzp+egdmv1G25h/TMrMTb4Q0AIVq61aEegYe0G+KJcOy5fhd3ZyPQ25H
         dFdOcqdzqr219hTptXKIMkHx/UuR6NXIf3zMD8X1ShPmTNojeVDWqLQYHLcMgbcX+x
         J7cycNwA+H5I2jyNXmdOAupWXfPFYXtDQUzThhJZxpug3evD2x2dL7q0Tbew+0QxCa
         lML2a8lsSTe3A3pjTHhtuZBw0JvIGwQ7T5VcULwqK8HFSWzsaWCn3QwmAJwPnqb+Qr
         x6K3fZJGEOlRg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBFt4g1346622;
        Tue, 30 Apr 2019 04:15:55 -0700
Date:   Tue, 30 Apr 2019 04:15:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-1fd8de46d01d95f875c12684a6a03559831e8b4c@git.kernel.org>
Cc:     riel@surriel.com, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, torvalds@linux-foundation.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, kristen@linux.intel.com, bp@alien8.de,
        tglx@linutronix.de, linux_dti@icloud.com, will.deacon@arm.com,
        keescook@chromium.org, deneen.t.dock@intel.com, namit@vmware.com,
        mhiramat@kernel.org, rick.p.edgecombe@intel.com,
        ard.biesheuvel@linaro.org, peterz@infradead.org, luto@kernel.org
Reply-To: keescook@chromium.org, deneen.t.dock@intel.com,
          will.deacon@arm.com, linux_dti@icloud.com, tglx@linutronix.de,
          bp@alien8.de, kristen@linux.intel.com, dave.hansen@intel.com,
          luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
          rick.p.edgecombe@intel.com, mhiramat@kernel.org,
          namit@vmware.com, hpa@zytor.com, torvalds@linux-foundation.org,
          kernel-hardening@lists.openwall.com, riel@surriel.com,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190426001143.4983-3-namit@vmware.com>
References: <20190426001143.4983-3-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/jump_label: Use text_poke_early() during early
 init
Git-Commit-ID: 1fd8de46d01d95f875c12684a6a03559831e8b4c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1fd8de46d01d95f875c12684a6a03559831e8b4c
Gitweb:     https://git.kernel.org/tip/1fd8de46d01d95f875c12684a6a03559831e8b4c
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 17:11:22 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:49 +0200

x86/jump_label: Use text_poke_early() during early init

There is no apparent reason not to use text_poke_early() during
early-init, since no patching of code that might be on the stack is done
and only a single core is running.

This is required for the next patches that would set a temporary mm for
text poking, and this mm is only initialized after some static-keys are
enabled/disabled.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-3-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/jump_label.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f99bd26bd3f1..e7d8c636b228 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -50,7 +50,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	if (early_boot_irqs_disabled)
+	/*
+	 * As long as only a single processor is running and the code is still
+	 * not marked as RO, text_poke_early() can be used; Checking that
+	 * system_state is SYSTEM_BOOTING guarantees it.
+	 */
+	if (system_state == SYSTEM_BOOTING)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
