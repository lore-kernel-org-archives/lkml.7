Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF87C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C042206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfHBDGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:06:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfHBDGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:06:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0B309FFFDDE6338C5C4F;
        Fri,  2 Aug 2019 11:06:10 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 11:06:03 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <songliubraving@fb.com>,
        <rostedt@goodmis.org>, <kan.liang@linux.intel.com>,
        <tz.stoyanov@gmail.com>, <alexey.budankov@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <tanxiaojun@huawei.com>
Subject: [PATCH] perf record: Support aarch64 random socket_id assignment
Date:   Fri, 2 Aug 2019 11:48:57 +0800
Message-ID: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as the commit 01766229533f ("perf record: Support s390 random
socket_id assignment"), aarch64 also have this problem.

Without this fix:
  [root@localhost perf]# ./perf report --header -I -v
  ...
  socket_id number is too big.You may need to upgrade the perf tool.

  # ========
  # captured on    : Thu Aug  1 22:58:38 2019
  # header version : 1
  ...
  # Core ID and Socket ID information is not available
  ...

With this fix:
  [root@localhost perf]# ./perf report --header -I -v
  ...
  cpumask list: 0-31
  cpumask list: 32-63
  cpumask list: 64-95
  cpumask list: 96-127

  # ========
  # captured on    : Thu Aug  1 22:58:38 2019
  # header version : 1
  ...
  # CPU 0: Core ID 0, Socket ID 36
  # CPU 1: Core ID 1, Socket ID 36
  ...
  # CPU 126: Core ID 126, Socket ID 8442
  # CPU 127: Core ID 127, Socket ID 8442
  ...

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 20111f8..d57fb74 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2251,8 +2251,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	/* On s390 the socket_id number is not related to the numbers of cpus.
 	 * The socket_id number might be higher than the numbers of cpus.
 	 * This depends on the configuration.
+	 * AArch64 is the same.
 	 */
-	if (ph->env.arch && !strncmp(ph->env.arch, "s390", 4))
+	if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
+			  || !strncmp(ph->env.arch, "aarch64", 7)))
 		do_core_id_test = false;
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
-- 
2.7.4

