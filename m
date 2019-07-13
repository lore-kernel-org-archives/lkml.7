Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E0C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BB82084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I5IynX6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGMK7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:59:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:59:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAxVWj3838411
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:59:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAxVWj3838411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015572;
        bh=TwEt+HjLj1gx1nGoHmPpyQ0E+MzuVElfEyp9hSo/RU4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=I5IynX6uFJC/02WQKYbqieqgHY20W09n3QkiGoC52cIdYVfvG0NaAF6ufv6uu2XoN
         4ztKzs3gGdUSOHs3Cio9OFfCTqCd9HQj/2ljpOSyTMWaI/E5kD9HeeNtDqkEmutbef
         Ev4NJo0z7bwbhUGXU5zbYCRzqOFWOYRDgH1dFwnc1CUjw0qghWORqIvzs3lGeI/Hcp
         BVUFzjIM8MBNPc5tFvrJToGjTLjyf+LruTgc9xdqlbJDBR4D4uYOar0SzwD99k67+q
         55H+hagKjy3/vt5nthU83t5GLplL67CAJvMSqlA1RCgt7NRZWw7NC48piZEz6Rj9vO
         O0g5BvTaKVF9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAxVww3838406;
        Sat, 13 Jul 2019 03:59:31 -0700
Date:   Sat, 13 Jul 2019 03:59:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zlu81bbtccuzygh7m8nmgybc@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf namespaces: Move the conditional setns()
 prototype to namespaces.h
Git-Commit-ID: 245aec7f7f4ca95b924f005d604bab9d838b5eb1
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

Commit-ID:  245aec7f7f4ca95b924f005d604bab9d838b5eb1
Gitweb:     https://git.kernel.org/tip/245aec7f7f4ca95b924f005d604bab9d838b5eb1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 5 Jul 2019 13:59:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:26 -0300

perf namespaces: Move the conditional setns() prototype to namespaces.h

Out of util.h, to reduce its scope, and since we have a namespaces.h
header, much better to have it there, where it is related to.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zlu81bbtccuzygh7m8nmgybc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/namespaces.h | 4 ++++
 tools/perf/util/setns.c      | 4 +++-
 tools/perf/util/util.h       | 4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 15a5a276c478..004430c0de93 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -13,6 +13,10 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 
+#ifndef HAVE_SETNS_SUPPORT
+int setns(int fd, int nstype);
+#endif
+
 struct namespaces_event;
 
 struct namespaces {
diff --git a/tools/perf/util/setns.c b/tools/perf/util/setns.c
index ce8fc290fce8..48f9c0af63b2 100644
--- a/tools/perf/util/setns.c
+++ b/tools/perf/util/setns.c
@@ -1,4 +1,6 @@
-#include "util.h"
+// SPDX-License-Identifier: LGPL-2.1
+
+#include "namespaces.h"
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 125e215dd3d8..59fe33708090 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -67,10 +67,6 @@ char *get_current_dir_name(void);
 int sched_getcpu(void);
 #endif
 
-#ifndef HAVE_SETNS_SUPPORT
-int setns(int fd, int nstype);
-#endif
-
 extern bool perf_singlethreaded;
 
 void perf_set_singlethreaded(void);
