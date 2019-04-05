Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9482186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfDELge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:36:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:36:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BaRGI2734315
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:36:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BaQja2734312;
        Fri, 5 Apr 2019 04:36:26 -0700
Date:   Fri, 5 Apr 2019 04:36:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lgugmfa8z4bpw5zsbuoitllb@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty renameat: No need to include
 linux/fs.h
Git-Commit-ID: b64f1cc6d02ce92f7752545c0bd82dc052013167
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

Commit-ID:  b64f1cc6d02ce92f7752545c0bd82dc052013167
Gitweb:     https://git.kernel.org/tip/b64f1cc6d02ce92f7752545c0bd82dc052013167
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 27 Mar 2019 10:16:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf trace beauty renameat: No need to include linux/fs.h

There is no use for what is in that file, as everything is
built by the tools/perf/trace/beauty/rename_flags.sh script from
the copied kernel headers, the end result being:

  $ cat /tmp/build/perf/trace/beauty/generated/rename_flags_array.c
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

I.e. no use of any defines from uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgugmfa8z4bpw5zsbuoitllb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/renameat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
index 6dab340cc506..852d2e271833 100644
--- a/tools/perf/trace/beauty/renameat.c
+++ b/tools/perf/trace/beauty/renameat.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "trace/beauty/beauty.h"
-#include <uapi/linux/fs.h>
 
 static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
