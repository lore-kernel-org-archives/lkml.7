Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FFCC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054985;
	bh=cWq0Z9QT4n7CT7f9rcLqy3iF8KYjB5mlRvO3kD03/kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZrSpllW5Kzc3w9f9JyXY3l8mae0XLjWH+5UFe0W5HlfBkiR2aQFZtyP2fVUl481WV
	 UmiTu0yDaQnl4LFmkDaBD4t2dzp93u+7w95vJm+/WJEad3CNqJwyTiazg9p/FtXmY+
	 T27/4IUZTEpPysNpxGuLBU9pMc8fwfWdgvv8y+y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfFTSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfFTSJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:09:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6640421530;
        Thu, 20 Jun 2019 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054191;
        bh=cWq0Z9QT4n7CT7f9rcLqy3iF8KYjB5mlRvO3kD03/kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDH583jfEGfXtrqAyZThH1RCWgPLfm6InCcQ2eu69qCEdCTvHqfB0iMdnsyww5cDh
         CjSOQUMzi+rommpUM1d9AWBxDHmPffSHpK6YIVJV7tjAI96IePE0SDGAPdJ45qApCR
         TLokKYuzaWdY5+MHFGF6U2VpT+3Fva0rObCd0M9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 29/45] perf record: Fix s390 missing module symbol and warning for non-root users
Date:   Thu, 20 Jun 2019 19:57:31 +0200
Message-Id: <20190620174339.036758968@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174328.608036501@linuxfoundation.org>
References: <20190620174328.608036501@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



