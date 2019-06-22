Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64DDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5BE206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qOzBYr+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVKEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:04:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:04:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA44dw2094403
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:04:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA44dw2094403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197845;
        bh=J93idEMkupPvur128aw4LqWY+QkuT3ibbpZzuPvyONA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qOzBYr+2q30aW7ptTpk3uC749yXb4mP8qFnRHZ8DHYOcBh3Ra553xIyHiYTCjmNuC
         AWQrNNonfaPHxDfyc2RbGoYuykgbWT3mH7znhM7TNIb9raFaqTmC6MSt1Fzp3z/qly
         ImoFPskwh5/4HcDEsWQK16T4gOeJDZrcIV3LIf7B86z8O41JUAS0XqJYhqDVfiDsOa
         n2C8+85OHztVJMZVMtAe6B+BU7rBhYO3FzQQ1xCkb3lpVbs4B7albiwdGgY0UsKSD/
         yDFgm2V7VPpDG4YE2RfbgG6LiicV2slfdiIY/MLcb2HNMX/kj4csPoa4uZHtVDEiDd
         3CKyO9nkF6TXQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA44kt2094052;
        Sat, 22 Jun 2019 03:04:04 -0700
Date:   Sat, 22 Jun 2019 03:04:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-48f5e52e916b55fb73754833efbacc7f8081a159@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        chang.seok.bae@intel.com
Reply-To: linux-kernel@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
          chang.seok.bae@intel.com
In-Reply-To: <9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com>
References: <9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/ptrace: Prevent ptrace from clearing the FS/GS
 selector
Git-Commit-ID: 48f5e52e916b55fb73754833efbacc7f8081a159
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

Commit-ID:  48f5e52e916b55fb73754833efbacc7f8081a159
Gitweb:     https://git.kernel.org/tip/48f5e52e916b55fb73754833efbacc7f8081a159
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Sun, 16 Jun 2019 15:44:11 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:50 +0200

x86/ptrace: Prevent ptrace from clearing the FS/GS selector

When a ptracer writes a ptracee's FS/GSBASE with a different value, the
selector is also cleared. This behavior is not correct as the selector
should be preserved.

Update only the base value and leave the selector intact. To simplify the
code further remove the conditional checking for the same value as this
code is not performance critical.

The only recognizable downside of this change is when the selector is
already nonzero on write. The base will be reloaded according to the
selector. But the case is highly unexpected in real usages.

[ tglx: Massage changelog ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com

---
 arch/x86/kernel/ptrace.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a166c960bc9e..3108cdc00b29 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,22 +397,12 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		/*
-		 * When changing the FS base, use do_arch_prctl_64()
-		 * to set the index to zero and to set the base
-		 * as requested.
-		 */
-		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+		x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
-		/*
-		 * Exactly the same here as the %fs handling above.
-		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
-		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+		x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
