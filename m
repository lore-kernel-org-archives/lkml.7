Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00F925804
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BwCbzuCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfE3IFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:05:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:05:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U85U1s2903178
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:05:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U85U1s2903178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203531;
        bh=OpeCGEt23oiQGRBl0RS9w4ztJIw1EgOLi1vkPYgJRd4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=BwCbzuCIsbqkzeNa3P+dpSOJkLN1oZdLzIptarm8KqroxtWdFkl3hQOR7HLUw0B/6
         2hZJLBA2jtBLrUxbH0h0cAaC2Dv0jD2RqngVC0Y/bfdL3x1HERMVt1HWdhqPrj1O9t
         2dP03iiysrSkUiOm5g0iH9psIRJnp4kpqeOFfGi0ksWVaJ7TPgWIDIWOc/GE9TR+E7
         rMyDqB4+qNVA/rFv+1WDDkuMRcuulBbO+SP3scuTIjvuWfg3euGEyfpXdu9nwyytOR
         0uqQI75sI6Ues9Lu/w192aT3OEiwMVtB4DIcsr46u04T3iabTPJ3jJY/TO0NJlq1UR
         dZAERqVs3YhAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U85TvD2903175;
        Thu, 30 May 2019 01:05:29 -0700
Date:   Thu, 30 May 2019 01:05:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org>
Cc:     torvalds@linux-foundation.org, adrian.hunter@intel.com,
        mingo@kernel.org, amir73il@gmail.com, brendan.d.gregg@gmail.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, adrian.hunter@intel.com,
          torvalds@linux-foundation.org, lclaudio@redhat.com,
          linux-kernel@vger.kernel.org, brendan.d.gregg@gmail.com,
          amir73il@gmail.com, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for sync_file_range's
 'flags' arg values
Git-Commit-ID: 8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
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

Commit-ID:  8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
Gitweb:     https://git.kernel.org/tip/8ef6d74e1dd5ac830fa8b7943255ad9a44a94914
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 21:43:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf beauty: Add generator for sync_file_range's 'flags' arg values

  $ tools/perf/trace/beauty/sync_file_range.sh
  static const char *sync_file_range_flags[] = {
          [ilog2(1) + 1] = "WAIT_BEFORE",
          [ilog2(2) + 1] = "WRITE",
          [ilog2(4) + 1] = "WAIT_AFTER",
  };
  $

When all are the above are present, then we have something called
SYNC_FILE_RANGE_WRITE_AND_WAIT, that will be special cased in the
upcoming scnprintf beautifier for this flags arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sync_file_range.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
new file mode 100755
index 000000000000..7a9282d04e44
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	linux_header_dir=tools/include/uapi/linux
+else
+	linux_header_dir=$1
+fi
+
+linux_fs=${linux_header_dir}/fs.h
+
+printf "static const char *sync_file_range_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_fs} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
