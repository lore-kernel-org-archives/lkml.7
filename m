Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE0C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952DD20709
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfLHO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:58:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfLHO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy11-0000Rw-Gb; Sun, 08 Dec 2019 15:58:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 34AC71C2885;
        Sun,  8 Dec 2019 15:58:31 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, xen: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-23-bigeasy@linutronix.de>
References: <20191015191821.11479-23-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711109.21853.12142170301517881405.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d4a3dcbc4727966a64a64d57e2b5106a138d426d
Gitweb:        https://git.kernel.org/tip/d4a3dcbc4727966a64a64d57e2b5106a138d426d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:36 +01:00

sched/rt, xen: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the preempt anand xen-ops code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lore.kernel.org/r/20191015191821.11479-23-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/xen/preempt.c | 4 ++--
 include/xen/xen-ops.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
index 8b9919c..70650b2 100644
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -8,7 +8,7 @@
 #include <linux/sched.h>
 #include <xen/xen-ops.h>
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 
 /*
  * Some hypercalls issued by the toolstack can take many 10s of
@@ -37,4 +37,4 @@ asmlinkage __visible void xen_maybe_preempt_hcall(void)
 		__this_cpu_write(xen_in_preemptible_hcall, true);
 	}
 }
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index d89969a..095be1d 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -215,7 +215,7 @@ bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
 void xen_efi_runtime_setup(void);
 
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 
 static inline void xen_preemptible_hcall_begin(void)
 {
@@ -239,6 +239,6 @@ static inline void xen_preemptible_hcall_end(void)
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
 
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 #endif /* INCLUDE_XEN_OPS_H */
