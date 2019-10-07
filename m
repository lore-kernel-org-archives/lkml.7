Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C21ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675FD20679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570463258;
	bh=I9sUBOOn4VhmaV6Kwzd6IFEmIDNRJtwlR1oOSDCQLKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fk5zEoF7iiRApEg7z75c2Kg7A75M8yuyht49gbuYXFG5X5/cZg4g+retFFFnicfL1
	 IPPCuu5hj3GJh5iWwx7zm4BEdYLl8IcRqH2KTRedgoZ6JJ9rVA2uflxS6MqLcAG1Dz
	 hAvVsEnW1K2Tv6bZYbPoEtcpB+gMO+1sgRvnl7l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfJGPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfJGPr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:29 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FC22190F;
        Mon,  7 Oct 2019 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463248;
        bh=I9sUBOOn4VhmaV6Kwzd6IFEmIDNRJtwlR1oOSDCQLKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/wvFMzfoIiocKn4F3P5CXgNDDO21QPNEjGJVS9FGkIsGQbQuwl9b3rAY+mav1qjw
         fgV6uvwegWGUEBj2VVeMYHlh8fDkYdL1rJUTL9oN75KamVh4PGj76TcyAucTe8kMY5
         lXHZczypKv5NX6U6V81CDFiNSZ0+M2R4CiI5w4JY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 09/10] lib/refcount: Remove unused 'refcount_error_report()' function
Date:   Mon,  7 Oct 2019 16:47:02 +0100
Message-Id: <20191007154703.5574-10-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'refcount_error_report()' has no callers. Remove it.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/kernel.h |  7 -------
 kernel/panic.c         | 11 -----------
 2 files changed, 18 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403dac2e..09f759228e3f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -328,13 +328,6 @@ extern int oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
-#ifdef CONFIG_ARCH_HAS_REFCOUNT
-void refcount_error_report(struct pt_regs *regs, const char *err);
-#else
-static inline void refcount_error_report(struct pt_regs *regs, const char *err)
-{ }
-#endif
-
 /* Internal, do not use. */
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
diff --git a/kernel/panic.c b/kernel/panic.c
index 47e8ebccc22b..10d05fd4f9c3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -670,17 +670,6 @@ EXPORT_SYMBOL(__stack_chk_fail);
 
 #endif
 
-#ifdef CONFIG_ARCH_HAS_REFCOUNT
-void refcount_error_report(struct pt_regs *regs, const char *err)
-{
-	WARN_RATELIMIT(1, "refcount_t %s at %pB in %s[%d], uid/euid: %u/%u\n",
-		err, (void *)instruction_pointer(regs),
-		current->comm, task_pid_nr(current),
-		from_kuid_munged(&init_user_ns, current_uid()),
-		from_kuid_munged(&init_user_ns, current_euid()));
-}
-#endif
-
 core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
-- 
2.23.0.581.g78d2f28ef7-goog

