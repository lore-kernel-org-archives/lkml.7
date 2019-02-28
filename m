Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703020C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfB1TLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:11:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbfB1TLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:11:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C41E03157652;
        Thu, 28 Feb 2019 19:11:00 +0000 (UTC)
Received: from llong.com (ovpn-121-201.rdu2.redhat.com [10.10.121.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7FFA60C61;
        Thu, 28 Feb 2019 19:10:58 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v3 09/11] locking/lock_events: Don't show pvqspinlock events on bare metal
Date:   Thu, 28 Feb 2019 14:09:39 -0500
Message-Id: <1551380981-3113-10-git-send-email-longman@redhat.com>
In-Reply-To: <1551380981-3113-1-git-send-email-longman@redhat.com>
References: <1551380981-3113-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 28 Feb 2019 19:11:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On bare metail, the pvqspinlock event counts will always be 0. So there
is no point in showing their corresponding debugfs files. So they are
skipped in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/locking/lock_events.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index 71c36d1..fa2c2f9 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -115,6 +115,29 @@ static ssize_t lockevent_write(struct file *file, const char __user *user_buf,
 	.llseek = default_llseek,
 };
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/paravirt.h>
+
+static bool __init skip_lockevent(const char *name)
+{
+	static int pv_on __initdata = -1;
+
+	if (pv_on < 0)
+		pv_on = !pv_is_native_spin_unlock();
+	/*
+	 * Skip PV qspinlock events on bare metal.
+	 */
+	if (!pv_on && !memcmp(name, "pv_", 3))
+		return true;
+	return false;
+}
+#else
+static inline bool skip_lockevent(const char *name)
+{
+	return false;
+}
+#endif
+
 /*
  * Initialize debugfs for the locking event counts.
  */
@@ -133,10 +156,13 @@ static int __init init_lockevent_counts(void)
 	 * root is allowed to do the read/write to limit impact to system
 	 * performance.
 	 */
-	for (i = 0; i < lockevent_num; i++)
+	for (i = 0; i < lockevent_num; i++) {
+		if (skip_lockevent(lockevent_names[i]))
+			continue;
 		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
 					 (void *)(long)i, &fops_lockevent))
 			goto fail_undo;
+	}
 
 	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
 				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-- 
1.8.3.1

