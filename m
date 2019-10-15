Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B0ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B69820872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfJOTSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:18:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389457AbfJOTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:50 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLA-00067i-FD; Tue, 15 Oct 2019 21:18:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 22/34] xen: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:09 +0200
Message-Id: <20191015191821.11479-23-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the preempt anand xen-ops code over to use CONFIG_PREEMPTION.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/xen/preempt.c | 4 ++--
 include/xen/xen-ops.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
index 8b9919c26095d..70650b248de5d 100644
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -8,7 +8,7 @@
 #include <linux/sched.h>
 #include <xen/xen-ops.h>
=20
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
=20
 /*
  * Some hypercalls issued by the toolstack can take many 10s of
@@ -37,4 +37,4 @@ asmlinkage __visible void xen_maybe_preempt_hcall(void)
 		__this_cpu_write(xen_in_preemptible_hcall, true);
 	}
 }
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index d89969aa9942c..095be1d66f31c 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -215,7 +215,7 @@ bool xen_running_on_version_or_later(unsigned int major=
, unsigned int minor);
 void xen_efi_runtime_setup(void);
=20
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
=20
 static inline void xen_preemptible_hcall_begin(void)
 {
@@ -239,6 +239,6 @@ static inline void xen_preemptible_hcall_end(void)
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
=20
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
=20
 #endif /* INCLUDE_XEN_OPS_H */
--=20
2.23.0

