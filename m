Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694042173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4oRtsUKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404817AbfHHUWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:22:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39069 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404763AbfHHUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:22:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KLgVw3321806
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:21:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KLgVw3321806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295703;
        bh=GCHPCeR8uPQ94Nk8i1XY9/BC/5YRP6Xm+sy/I3HF908=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=4oRtsUKfr33hs/C7cbm6reSwuIYp0j9PQfWl2udwXdkHrNbWlVzd4mT84myO5dVyx
         gy8AJZailxBzOaplyGfiQKue2iXFa19Uk0YDu728YiIaNr9iY3FwzMhjtvvfFwXhrI
         7IlUHgMBrwVyZwGdNw0LgMPAXXJzEpVuolYta6l4lU0IriN1pwRzCUUvnSEKDPkdLq
         uroeLY6TOsfpeUaxHwNLHS2v39c3QHTO7CucEEE3aB1my2vbD9SMVBM2midaphrmGh
         T9ZZmz0KapsITq3CRPVJBWRvYyNiU/FnIl05zceN/on4TjslFrO0w9mfr8qE+HYrND
         jDOnlu4gKroZA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KLe6B3321792;
        Thu, 8 Aug 2019 13:21:40 -0700
Date:   Thu, 8 Aug 2019 13:21:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-12a6d2940b5f02b4b9f71ce098e3bb02bc24a9ea@git.kernel.org>
Cc:     tglx@linutronix.de, tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        heiko.carstens@de.ibm.com, mingo@kernel.org, acme@redhat.com,
        stli@linux.ibm.com, gor@linux.ibm.com
Reply-To: tglx@linutronix.de, brueckner@linux.ibm.com,
          tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
          stli@linux.ibm.com, acme@redhat.com, gor@linux.ibm.com,
          hpa@zytor.com, mingo@kernel.org, heiko.carstens@de.ibm.com
In-Reply-To: <20190724122703.3996-1-tmricht@linux.ibm.com>
References: <20190724122703.3996-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Fix module size on s390
Git-Commit-ID: 12a6d2940b5f02b4b9f71ce098e3bb02bc24a9ea
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

Commit-ID:  12a6d2940b5f02b4b9f71ce098e3bb02bc24a9ea
Gitweb:     https://git.kernel.org/tip/12a6d2940b5f02b4b9f71ce098e3bb02bc24a9ea
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Wed, 24 Jul 2019 14:27:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:11 -0300

perf record: Fix module size on s390

On s390 the modules loaded in memory have the text segment located after
the GOT and Relocation table. This can be seen with this output:

  [root@m35lp76 perf]# fgrep qeth /proc/modules
  qeth 151552 1 qeth_l2, Live 0x000003ff800b2000
  ...
  [root@m35lp76 perf]# cat /sys/module/qeth/sections/.text
  0x000003ff800b3990
  [root@m35lp76 perf]#

There is an offset of 0x1990 bytes. The size of the qeth module is
151552 bytes (0x25000 in hex).

The location of the GOT/relocation table at the beginning of a module is
unique to s390.

commit 203d8a4aa6ed ("perf s390: Fix 'start' address of module's map")
adjusts the start address of a module in the map structures, but does
not adjust the size of the modules. This leads to overlapping of module
maps as this example shows:

[root@m35lp76 perf] # ./perf report -D
     0 0 0xfb0 [0xa0]: PERF_RECORD_MMAP -1/0: [0x3ff800b3990(0x25000)
          @ 0]:  x /lib/modules/.../qeth.ko.xz
     0 0 0x1050 [0xb0]: PERF_RECORD_MMAP -1/0: [0x3ff800d85a0(0x8000)
          @ 0]:  x /lib/modules/.../ip6_tables.ko.xz

The module qeth.ko has an adjusted start address modified to b3990, but
its size is unchanged and the module ends at 0x3ff800d8990.  This end
address overlaps with the next modules start address of 0x3ff800d85a0.

When the size of the leading GOT/Relocation table stored in the
beginning of the text segment (0x1990 bytes) is subtracted from module
qeth end address, there are no overlaps anymore:

   0x3ff800d8990 - 0x1990 = 0x0x3ff800d7000

which is the same as

   0x3ff800b2000 + 0x25000 = 0x0x3ff800d7000.

To fix this issue, also adjust the modules size in function
arch__fix_module_text_start(). Add another function parameter named size
and reduce the size of the module when the text segment start address is
changed.

Output after:
     0 0 0xfb0 [0xa0]: PERF_RECORD_MMAP -1/0: [0x3ff800b3990(0x23670)
          @ 0]:  x /lib/modules/.../qeth.ko.xz
     0 0 0x1050 [0xb0]: PERF_RECORD_MMAP -1/0: [0x3ff800d85a0(0x7a60)
          @ 0]:  x /lib/modules/.../ip6_tables.ko.xz

Reported-by: Stefan Liebler <stli@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 203d8a4aa6ed ("perf s390: Fix 'start' address of module's map")
Link: http://lkml.kernel.org/r/20190724122703.3996-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/machine.c | 14 +++++++++++++-
 tools/perf/util/machine.c           |  3 ++-
 tools/perf/util/machine.h           |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/machine.c b/tools/perf/arch/s390/util/machine.c
index a19690a17291..de26b1441a48 100644
--- a/tools/perf/arch/s390/util/machine.c
+++ b/tools/perf/arch/s390/util/machine.c
@@ -7,7 +7,7 @@
 #include "api/fs/fs.h"
 #include "debug.h"
 
-int arch__fix_module_text_start(u64 *start, const char *name)
+int arch__fix_module_text_start(u64 *start, u64 *size, const char *name)
 {
 	u64 m_start = *start;
 	char path[PATH_MAX];
@@ -17,6 +17,18 @@ int arch__fix_module_text_start(u64 *start, const char *name)
 	if (sysfs__read_ull(path, (unsigned long long *)start) < 0) {
 		pr_debug2("Using module %s start:%#lx\n", path, m_start);
 		*start = m_start;
+	} else {
+		/* Successful read of the modules segment text start address.
+		 * Calculate difference between module start address
+		 * in memory and module text segment start address.
+		 * For example module load address is 0x3ff8011b000
+		 * (from /proc/modules) and module text segment start
+		 * address is 0x3ff8011b870 (from file above).
+		 *
+		 * Adjust the module size and subtract the GOT table
+		 * size located at the beginning of the module.
+		 */
+		*size -= (*start - m_start);
 	}
 
 	return 0;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index cf826eca3aaf..83b2fbbeeb90 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1378,6 +1378,7 @@ static int machine__set_modules_path(struct machine *machine)
 	return map_groups__set_modules_path_dir(&machine->kmaps, modules_path, 0);
 }
 int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
+				u64 *size __maybe_unused,
 				const char *name __maybe_unused)
 {
 	return 0;
@@ -1389,7 +1390,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	struct machine *machine = arg;
 	struct map *map;
 
-	if (arch__fix_module_text_start(&start, name) < 0)
+	if (arch__fix_module_text_start(&start, &size, name) < 0)
 		return -1;
 
 	map = machine__findnew_module_map(machine, start, name);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index f70ab98a7bde..7aa38da26427 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -222,7 +222,7 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 					const char *filename);
-int arch__fix_module_text_start(u64 *start, const char *name);
+int arch__fix_module_text_start(u64 *start, u64 *size, const char *name);
 
 int machine__load_kallsyms(struct machine *machine, const char *filename);
 
