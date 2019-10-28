Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73ACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A712220873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJ1GrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:47:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43042 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730477AbfJ1GrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:47:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63B1A55C1466A571EBB9;
        Mon, 28 Oct 2019 14:47:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 28 Oct 2019
 14:47:03 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] perf kmem: Fix memory leak in __cmd_record()
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Message-ID: <81e3d338-dbf3-341b-431d-27bb51996e46@huawei.com>
Date:   Mon, 28 Oct 2019 14:46:35 +0800
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

There are memory leaks in __cmd_record() found by visual inspection.
calloc() and strdup() are used to allocate memory for rec_argv pointer
array and argv, which should be freed before the function returns.

In addition, checking whether strdup() is success or not, if failure,
then go to the failure path to free memory and return the function.

Fixes: ba77c9e11111 ("perf: Add 'perf kmem' tool")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9661671cc26e..6a62acfc9470 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1847,6 +1847,7 @@ static int __cmd_record(int argc, const char **argv)
 	};
 	unsigned int rec_argc, i, j;
 	const char **rec_argv;
+	int ret = -ENOMEM;

 	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
 	if (kmem_slab)
@@ -1873,10 +1874,20 @@ static int __cmd_record(int argc, const char **argv)
 			rec_argv[i] = strdup(page_events[j]);
 	}

-	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+	for (j = 0; j < i; j++)
+		if (!rec_argv[j]) /* check strdup success or not */
+			goto out;
+
+	rec_argc = i;
+	for (j = 1; j < (unsigned int)argc; j++, rec_argc++)
+		rec_argv[rec_argc] = argv[j];

-	return cmd_record(i, rec_argv);
+	ret = cmd_record(rec_argc, rec_argv);
+out:
+	for (i--; (int)i >= 0; i--)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }

 static int kmem_config(const char *var, const char *value, void *cb __maybe_unused)
-- 
2.7.4

