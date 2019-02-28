Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70459C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F0F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfB1IGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:06:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfB1IGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:06:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S85O4w2954976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:05:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S85OWC2954973;
        Thu, 28 Feb 2019 00:05:24 -0800
Date:   Thu, 28 Feb 2019 00:05:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-94816add0005595ea33fc8456519be582330401e@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, eranian@google.com,
        hpa@zytor.com, ak@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: hpa@zytor.com, eranian@google.com, mingo@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, ak@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190224153722.27020-9-andi@firstfloor.org>
References: <20190224153722.27020-9-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add perf_exe() helper to find perf
 binary
Git-Commit-ID: 94816add0005595ea33fc8456519be582330401e
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

Commit-ID:  94816add0005595ea33fc8456519be582330401e
Gitweb:     https://git.kernel.org/tip/94816add0005595ea33fc8456519be582330401e
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Sun, 24 Feb 2019 07:37:19 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:58:28 -0300

perf tools: Add perf_exe() helper to find perf binary

Also convert one existing user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 +++---------
 tools/perf/util/util.c   | 10 ++++++++++
 tools/perf/util/util.h   |  2 ++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2323d777dae..01b324c275b9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -527,17 +527,11 @@ static int write_event_desc(struct feat_fd *ff,
 static int write_cmdline(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
-	char buf[MAXPATHLEN];
-	u32 n;
-	int i, ret;
+	char pbuf[MAXPATHLEN], *buf;
+	int i, ret, n;
 
 	/* actual path to perf binary */
-	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return -1;
-
-	/* readlink() does not add null termination */
-	buf[ret] = '\0';
+	buf = perf_exe(pbuf, MAXPATHLEN);
 
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 706818693086..d388f80d8703 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -568,3 +568,13 @@ out:
 
 	return tip;
 }
+
+char *perf_exe(char *buf, int len)
+{
+	int n = readlink("/proc/self/exe", buf, len);
+	if (n > 0) {
+		buf[n] = 0;
+		return buf;
+	}
+	return strcpy(buf, "perf");
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 01c538027c6f..09c1b0f91f65 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -77,6 +77,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+char *perf_exe(char *buf, int len);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
