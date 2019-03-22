Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A752EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD320883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCVWVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:21:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCVWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:21:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMLakC750565
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:21:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMLa9i750562;
        Fri, 22 Mar 2019 15:21:36 -0700
Date:   Fri, 22 Mar 2019 15:21:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-r17l6py9g0sezb7mi1f286gt@git.kernel.org>
Cc:     ak@linux.intel.com, mingo@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@redhat.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, ak@linux.intel.com,
          mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Indicate JITed code better in report
Git-Commit-ID: a4e7e6efabc57e85e0737c2eaa391525c0ae36f3
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

Commit-ID:  a4e7e6efabc57e85e0737c2eaa391525c0ae36f3
Gitweb:     https://git.kernel.org/tip/a4e7e6efabc57e85e0737c2eaa391525c0ae36f3
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:49:59 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:03 -0300

perf report: Indicate JITed code better in report

Print [TID] tid %d instead of the crypted /tmp/perf-%d.map default.

% cat >loop.java
  public class loop {
          public static void main(String[] args)
          {
                  for (;;);
          }
  }
  ^D
  % javac loop.java
  % perf record java loop
  ^C

Before:

  % perf report --stdio
  ...
      56.09%  java     perf-34724.map      [.] 0x00007fd5bd021896
      19.12%  java     perf-34724.map      [.] 0x00007fd5bd021887
       9.79%  java     perf-34724.map      [.] 0x00007fd5bd021783
       8.97%  java     perf-34724.map      [.] 0x00007fd5bd02175b

After:

  % perf report --stdio
  ...
      56.09%  java     [JIT] tid 34724     [.] 0x00007fd5bd021896
      19.12%  java     [JIT] tid 34724     [.] 0x00007fd5bd021887
       9.79%  java     [JIT] tid 34724     [.] 0x00007fd5bd021783
       8.97%  java     [JIT] tid 34724     [.] 0x00007fd5bd02175b

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LPU-Reference: 20190314225002.30108-7-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-r17l6py9g0sezb7mi1f286gt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ba58ba603b69..ab8a455d2283 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1141,28 +1141,34 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 
 static void dso__set_basename(struct dso *dso)
 {
-       /*
-        * basename() may modify path buffer, so we must pass
-        * a copy.
-        */
-       char *base, *lname = strdup(dso->long_name);
+	char *base, *lname;
+	int tid;
 
-       if (!lname)
-               return;
-
-       /*
-        * basename() may return a pointer to internal
-        * storage which is reused in subsequent calls
-        * so copy the result.
-        */
-       base = strdup(basename(lname));
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
 
-       free(lname);
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
 
-       if (!base)
-               return;
+		free(lname);
 
-       dso__set_short_name(dso, base, true);
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
 }
 
 int dso__name_len(const struct dso *dso)
