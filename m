Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA72C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402B620815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCITuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:50:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCITuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:50:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Jo4fR3200764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:50:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Jo3653200760;
        Sat, 9 Mar 2019 11:50:03 -0800
Date:   Sat, 9 Mar 2019 11:50:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-dvngzxd0jkplzw1ary69dilb@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, acme@redhat.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf auxtrace: Improve address filter error
 message when there is no DSO
Git-Commit-ID: c1c49204b0114daf210c79d66a5980c8e6f8f8fb
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

Commit-ID:  c1c49204b0114daf210c79d66a5980c8e6f8f8fb
Gitweb:     https://git.kernel.org/tip/c1c49204b0114daf210c79d66a5980c8e6f8f8fb
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 1 Mar 2019 14:29:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:47:06 -0300

perf auxtrace: Improve address filter error message when there is no DSO

The message does not indicate the possibility that the symbol is not
found because the file does not exist.

Before:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

After:

  $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
  File 'foo' not found or has no symbols.
  Symbol 'strcmp' not found.
  Note that symbols must be functions.
  Failed to parse address filter: 'filter strcmp / strcpy @ foo '
  Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
  Where multiple filters are separated by space or comma.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-dvngzxd0jkplzw1ary69dilb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 267e54df511b..fb76b6b232d4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1918,7 +1918,8 @@ static struct dso *load_dso(const char *name)
 	if (!map)
 		return NULL;
 
-	map__load(map);
+	if (map__load(map) < 0)
+		pr_err("File '%s' not found or has no symbols.\n", name);
 
 	dso = dso__get(map->dso);
 
