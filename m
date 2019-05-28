Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F9AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16362075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yqFzMuaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfE1Vag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:30:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfE1Vaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:30:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLUQSV2241056
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:30:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLUQSV2241056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559079026;
        bh=WMY9e1Hmdj3BEHeJW4NnRb/RYti1H2T4KQ1xQJTxRNU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yqFzMuaPum2/RnatIpymLHwLJi/hec75esQQt6qulrFpX7MUcENMU1boz+uZ32QXr
         A+0FaFVCShLPXjWU5Rd4uoOEt0vUWNDYRyvKpHQBs0ulDsAM4B/11+YVkOMKnhx6yP
         O/Ja/x7h5/XTAouEGWjoIfX9krhC+iga0q+sz7veGhxqzeysph3E3JmBMJzxOcC8yA
         cF3OuhNCCQm37CaISlxkXlxwBvidHrBTwh/1hl4LReaVJthz6Bmj5qQRWszQL4mTOC
         jF58g0MGBSDiG8sdmOFidP3LuB1bA8AG5dYTn680WdJYr39PSEUMe/SKyePGUA7qMY
         VB7U0J627t7dw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLUPtA2241053;
        Tue, 28 May 2019 14:30:25 -0700
Date:   Tue, 28 May 2019 14:30:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-6738028dd57df064b969d8392c943ef3b3ae705d@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, brueckner@linux.ibm.com,
        tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        heiko.carstens@de.ibm.com, acme@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, brueckner@linux.ibm.com,
          heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
          tmricht@linux.ibm.com, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190522144601.50763-4-tmricht@linux.ibm.com>
References: <20190522144601.50763-4-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Fix s390 missing module symbol and
 warning for non-root users
Git-Commit-ID: 6738028dd57df064b969d8392c943ef3b3ae705d
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

Commit-ID:  6738028dd57df064b969d8392c943ef3b3ae705d
Gitweb:     https://git.kernel.org/tip/6738028dd57df064b969d8392c943ef3b3ae705d
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Wed, 22 May 2019 16:46:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

perf record: Fix s390 missing module symbol and warning for non-root users

Command 'perf record' and 'perf report' on a system without kernel
debuginfo packages uses /proc/kallsyms and /proc/modules to find
addresses for kernel and module symbols. On x86 this works for root and
non-root users.

On s390, when invoked as non-root user, many of the following warnings
are shown and module symbols are missing:

    proc/{kallsyms,modules} inconsistency while looking for
        "[sha1_s390]" module!

Command 'perf record' creates a list of module start addresses by
parsing the output of /proc/modules and creates a PERF_RECORD_MMAP
record for the kernel and each module. The following function call
sequence is executed:

  machine__create_kernel_maps
    machine__create_module
      modules__parse
        machine__create_module --> for each line in /proc/modules
          arch__fix_module_text_start

Function arch__fix_module_text_start() is s390 specific. It opens
file /sys/module/<name>/sections/.text to extract the module's .text
section start address. On s390 the module loader prepends a header
before the first section, whereas on x86 the module's text section
address is identical the the module's load address.

However module section files are root readable only. For non-root the
read operation fails and machine__create_module() returns an error.
Command perf record does not generate any PERF_RECORD_MMAP record
for loaded modules. Later command perf report complains about missing
module maps.

To fix this function arch__fix_module_text_start() always returns
success. For root users there is no change, for non-root users
the module's load address is used as module's text start address
(the prepended header then counts as part of the text section).

This enable non-root users to use module symbols and avoid the
warning when perf report is executed.

Output before:

  [tmricht@m83lp54 perf]$ ./perf report -D | fgrep MMAP
  0 0x168 [0x50]: PERF_RECORD_MMAP ... x [kernel.kallsyms]_text

Output after:

  [tmricht@m83lp54 perf]$ ./perf report -D | fgrep MMAP
  0 0x168 [0x50]: PERF_RECORD_MMAP ... x [kernel.kallsyms]_text
  0 0x1b8 [0x98]: PERF_RECORD_MMAP ... x /lib/modules/.../autofs4.ko.xz
  0 0x250 [0xa8]: PERF_RECORD_MMAP ... x /lib/modules/.../sha_common.ko.xz
  0 0x2f8 [0x98]: PERF_RECORD_MMAP ... x /lib/modules/.../des_generic.ko.xz

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Link: http://lkml.kernel.org/r/20190522144601.50763-4-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/machine.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index 0b2054007314..a19690a17291 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -5,16 +5,19 @@
 #include "util.h"
 #include "machine.h"
 #include "api/fs/fs.h"
+#include "debug.h"
 
 int arch__fix_module_text_start(u64 *start, const char *name)
 {
+	u64 m_start = *start;
 	char path[PATH_MAX];
 
 	snprintf(path, PATH_MAX, "module/%.*s/sections/.text",
 				(int)strlen(name) - 2, name + 1);
-
-	if (sysfs__read_ull(path, (unsigned long long *)start) < 0)
-		return -1;
+	if (sysfs__read_ull(path, (unsigned long long *)start) < 0) {
+		pr_debug2("Using module %s start:%#lx\n", path, m_start);
+		*start = m_start;
+	}
 
 	return 0;
 }
