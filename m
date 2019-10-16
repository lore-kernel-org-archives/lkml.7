Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D9DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B03F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbfJPNuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:50:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387953AbfJPNub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:50:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 793C74C11AFACF345F20;
        Wed, 16 Oct 2019 21:50:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 21:50:19 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <john.garry@huawei.com>,
        <ak@linux.intel.com>, <lukemujica@google.com>,
        <yeyunfeng@huawei.com>, <kan.liang@linux.intel.com>,
        <yuzenghui@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] perf jevents: Fix resource leak in process_mapfile() and
 main()
Message-ID: <d7907042-ec9c-2bef-25b4-810e14602f89@huawei.com>
Date:   Wed, 16 Oct 2019 21:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are memory leaks and file descriptor resource leaks in
process_mapfile() and main().

Fix this by adding free(), fclose() and free_arch_std_events()
on the error paths.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Fixes: 3f056b66647b ("perf jevents: Make build fail on JSON parse error")
Fixes: e9d32c1bf0cd ("perf vendor events: Add support for arch standard events")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
v1 -> v2:
 - add free(eventsfp) to fix eventsfp resource leaks
 - add free_arch_std_events() on the error path

 tools/perf/pmu-events/jevents.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e2837260ca4d..99e3fd04a5cb 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -758,6 +758,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	char *line, *p;
 	int line_num;
 	char *tblname;
+	int ret = 0;

 	pr_info("%s: Processing mapfile %s\n", prog, fpath);

@@ -769,6 +770,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	if (!mapfp) {
 		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
 				fpath);
+		free(line);
 		return -1;
 	}

@@ -795,7 +797,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 			/* TODO Deal with lines longer than 16K */
 			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
 					prog, fpath, line_num);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		line[strlen(line)-1] = '\0';

@@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)

 out:
 	print_mapping_table_suffix(outfp);
-	return 0;
+	fclose(mapfp);
+	free(line);
+	return ret;
 }

 /*
@@ -1122,6 +1127,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1134,6 +1140,7 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	} else if (rc < 0) {
 		/* Make build fail */
+		fclose(eventsfp);
 		free_arch_std_events();
 		return 1;
 	} else if (rc) {
@@ -1151,6 +1158,8 @@ int main(int argc, char *argv[])
 	if (process_mapfile(eventsfp, mapfile)) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
 		/* Make build fail */
+		fclose(eventsfp);
+		free_arch_std_events();
 		return 1;
 	}

-- 
2.7.4.3

