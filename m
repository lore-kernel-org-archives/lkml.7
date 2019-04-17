Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C1C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E220420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfDQKUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:20:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:32514 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDQKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:20:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 03:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="338401436"
Received: from aubrey-lkp.sh.intel.com ([10.239.97.113])
  by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2019 03:20:45 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v16 1/3] /proc/pid/status: Add support for architecture specific output
Date:   Wed, 17 Apr 2019 18:18:38 +0800
Message-Id: <20190417101840.2926-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture specific information of the running processes could
be useful to the userland. Add support to examine process architecture
specific information externally.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/array.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 2edbb657f859..a6b394402ea2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -96,6 +96,14 @@
 #include <asm/processor.h>
 #include "internal.h"
 
+/*
+ * Add support for architecture specific output in /proc/pid/status.
+ * arch_proc_pid_status() must be defined in asm/processor.h
+ */
+#ifndef	arch_proc_pid_status
+#define	arch_proc_pid_status(m, task)
+#endif
+
 void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 {
 	char *buf;
@@ -424,6 +432,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_status(m, task);
 	return 0;
 }
 
-- 
2.21.0

