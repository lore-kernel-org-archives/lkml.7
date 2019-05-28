Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1763CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C79217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559065885;
	bh=46Q44svXPUpVD4scPAxbsdIVi99vSJJDbwx5cLTkPsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czz448FimcO1GceghgU31Yc9Jy6C2XB+prJO9Hd2tvOOziImeSa4a+Wzein8AeikL
	 6Tg6cOF75Xe1ScDrJOsqg+FCENrlFzazrBmR/Lv3nCJnD46NlFkqCVhkkWlflRQKJn
	 krYHR10A6/A2FONY8XvDuzuO4kS/Y51xruh1gNZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfE1RvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfE1RvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:51:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BEF52187F;
        Tue, 28 May 2019 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559065880;
        bh=46Q44svXPUpVD4scPAxbsdIVi99vSJJDbwx5cLTkPsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTS159N6G/2WmlT44uc51LoUqnfk2+G9bwBYM6ARX+mSeupOKt2qFxtzkwoMnOoux
         haf03k6l6iy07YjfBj1Ss7wedTWlKR33INH72JymlH6PRWVUpW8DaLkjuVz+8aBCyD
         IaJlmNAbASiVsxE4uKnWC2JsjwYGH/X/vSW0yLDo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/14] perf record: Fix s390 missing module symbol and warning for non-root users
Date:   Tue, 28 May 2019 14:50:19 -0300
Message-Id: <20190528175020.13343-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

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
-- 
2.20.1

