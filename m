Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16D22469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfKLLSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfKLLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBh-0000dl-7Z; Tue, 12 Nov 2019 12:18:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE47D1C0483;
        Tue, 12 Nov 2019 12:18:11 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:11 -0000
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf jevents: Fix resource leak in process_mapfile()
 and main()
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Feilong Lin <linfeilong@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
References: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
MIME-Version: 1.0
Message-ID: <157355749152.29376.17973960512966372268.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1785fbb73896dbd9d27a406f0d73047df42db710
Gitweb:        https://git.kernel.org/tip/1785fbb73896dbd9d27a406f0d73047df42db710
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Wed, 16 Oct 2019 21:50:17 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf jevents: Fix resource leak in process_mapfile() and main()

There are memory leaks and file descriptor resource leaks in
process_mapfile() and main().

Fix this by adding free(), fclose() and free_arch_std_events() on the
error paths.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Fixes: 3f056b66647b ("perf jevents: Make build fail on JSON parse error")
Fixes: e9d32c1bf0cd ("perf vendor events: Add support for arch standard events")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Link: http://lore.kernel.org/lkml/d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 7d69727..079c77b 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -772,6 +772,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	char *line, *p;
 	int line_num;
 	char *tblname;
+	int ret = 0;
 
 	pr_info("%s: Processing mapfile %s\n", prog, fpath);
 
@@ -783,6 +784,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	if (!mapfp) {
 		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
 				fpath);
+		free(line);
 		return -1;
 	}
 
@@ -809,7 +811,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 			/* TODO Deal with lines longer than 16K */
 			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
 					prog, fpath, line_num);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		line[strlen(line)-1] = '\0';
 
@@ -839,7 +842,9 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
 out:
 	print_mapping_table_suffix(outfp);
-	return 0;
+	fclose(mapfp);
+	free(line);
+	return ret;
 }
 
 /*
@@ -1136,6 +1141,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1148,6 +1154,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1165,6 +1172,8 @@ int main(int argc, char *argv[])
 	if (process_mapfile(eventsfp, mapfile)) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
+		fclose(eventsfp);
+		free_arch_std_events();
 		return 1;
 	}
 
