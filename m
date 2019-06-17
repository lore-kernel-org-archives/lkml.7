Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F536C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094B62084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bfe8BfzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfFQTgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:36:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFQTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:36:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJYla33565434
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:34:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJYla33565434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800088;
        bh=zGzpSGjgF9H8nvJX5wum+QqIj+GeL325ZaPw2tf7Nhs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bfe8BfzDXsNP2YJ+fxZ5Zw1xclERoR8vJRhzTSLZTnczWYzbYmCsKSbpQBAN9Oqpz
         E1eUPT3KcXAXCFIjG3vv5RzKYUG4FvW0Nd4wSALWLEE0iSOsWunq5pM1GVFeCIquQZ
         iU7YWvfz3ZpmmFnCslFEuiJwXVO1/YPz+/O+hw8yJs719WFz/dvb4zD7rc8XvpTfb7
         uTWPwmOCB19sBhJNUVeeKBz0FjHhM0Hk2Vv8TLfvjK1cIyTGj4lyZlIj7nT+gBq7Ff
         MYsCLDhOYdt1d0aSWBd/TdW+TGYKDHhRwFNLcV0X6PoowfhUlJ9K1vJRZBXCP/XQzk
         BkgNuUUgy7jZA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJYlS73565430;
        Mon, 17 Jun 2019 12:34:47 -0700
Date:   Mon, 17 Jun 2019 12:34:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-0ccdb8407a4660f6dbc5977bc060917d2c3e7986@git.kernel.org>
Cc:     ak@linux.intel.com, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com
Reply-To: mingo@kernel.org, ak@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, kan.liang@linux.intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1559688644-106558-5-git-send-email-kan.liang@linux.intel.com>
References: <1559688644-106558-5-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Apply new CPU topology sysfs attributes
Git-Commit-ID: 0ccdb8407a4660f6dbc5977bc060917d2c3e7986
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

Commit-ID:  0ccdb8407a4660f6dbc5977bc060917d2c3e7986
Gitweb:     https://git.kernel.org/tip/0ccdb8407a4660f6dbc5977bc060917d2c3e7986
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 4 Jun 2019 15:50:44 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf tools: Apply new CPU topology sysfs attributes

The existing "thread_siblings" and "thread_siblings_list" attribute will
be deprecated.

Use the new CPU topology sysfs attributes, "core_cpus" and
"core_cpus_list", which are synonymous with the deprecated attributes.

Check the new name first. If not available, use the deprecated name to
be compatible with old kernel.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 8 +++++++-
 tools/perf/util/smt.c     | 8 ++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 85fa87fc30cf..26e73a4bd4fe 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -15,6 +15,8 @@
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
 #define THRD_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define THRD_SIB_FMT_NEW \
+	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"
 #define NODE_ONLINE_FMT \
 	"%s/devices/system/node/online"
 #define NODE_MEMINFO_FMT \
@@ -91,8 +93,12 @@ try_dies:
 	ret = 0;
 
 try_threads:
-	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT_NEW,
 		  sysfs__mountpoint(), cpu);
+	if (access(filename, F_OK) == -1) {
+		scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+			  sysfs__mountpoint(), cpu);
+	}
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 453f6f6f29f3..3b791ef2cd50 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -23,8 +23,12 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/thread_siblings",
-			cpu);
+			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+		if (access(fn, F_OK) == -1) {
+			snprintf(fn, sizeof fn,
+				"devices/system/cpu/cpu%d/topology/thread_siblings",
+				cpu);
+		}
 		if (sysfs__read_str(fn, &str, &strlen) < 0)
 			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
