Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55942C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C35D21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994692;
	bh=0RdBvR7NS4NcK/RtuYqQMlazgPB8lT4PeYgDNtn3YGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RylKL8tI4FFQvm4NGKz236UsH6jKaI9LfMUXUEy6XsPFyRcna7jgTzxUTjq4GK8DV
	 YqXHJM43No4eG1LxMYmv2ekEz6QpO62myCdM8x2hsTCwjvYg08gYzdwOpmnEfi+zZz
	 fXKkK5Ng+oHgKgHZIuYO7gmEv0DE2DOceVVss0Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfFHLrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfFHLrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF40E21537;
        Sat,  8 Jun 2019 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994456;
        bh=0RdBvR7NS4NcK/RtuYqQMlazgPB8lT4PeYgDNtn3YGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQDlMJDew0ZHBnbqvNcgcqpurteGMWqceEh1zBWilcJsIEzIJeSPEHOM5ahZoVKhw
         bEJzv3kavtAcaAuQSC6f3jQG6t+XdWc2uxfyITdNIcg+N14nfj0Tlugz5Xq5r1hrCg
         GALRsquF5Dt3d5LPp1M8aGvzviqC09X+q3NNtegw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 21/31] perf record: Fix s390 missing module symbol and warning for non-root users
Date:   Sat,  8 Jun 2019 07:46:32 -0400
Message-Id: <20190608114646.9415-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 6738028dd57df064b969d8392c943ef3b3ae705d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

