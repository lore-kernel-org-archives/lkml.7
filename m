Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE60C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B921851
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808530;
	bh=/YVLKbuofx3QJedTNi22hYOQSOPCKP1Mbk93RVno/m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wW4uGHtuTqU3ftDJHvKQ3LEcj5AJy4m1aC3AoogTvotp1hAjvtQYgFlIuhyvi7jTs
	 rKxZJyHHR4O0To+60Q1m3vgBqw1ZiigrMIv7S8YxhIWeRVqfGF09i3KfY0mdWU+xli
	 y6LZPeG7IDdCl64MYvX2wDLh5LweudLJfTmYiNKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfHNSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfHNSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:10 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43EC2064A;
        Wed, 14 Aug 2019 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808429;
        bh=/YVLKbuofx3QJedTNi22hYOQSOPCKP1Mbk93RVno/m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XvrOzYrurUkoGbqKkapxMNAWPKOWFMWaMhxebK1T1VgDKRjKA3kujExpp3WBE7tb9
         6yGmpFfGe5q35h5sVjrV6A2ePQ6qD/CS6N/EVpZOutnqqEVu0fgy18J+bsXRrSzn9v
         aCvBFf9sBiimCSIPtswEIFWe5Nh+3zNHAgCVzWL4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/28] perf record: Support aarch64 random socket_id assignment
Date:   Wed, 14 Aug 2019 15:40:50 -0300
Message-Id: <20190814184051.3125-28-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

Same as in the commit 01766229533f ("perf record: Support s390 random
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Link: http://lkml.kernel.org/r/1564717737-21602-1-git-send-email-tanxiaojun@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b04c2b6b28b3..1f2965a07bef 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2252,8 +2252,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
2.21.0

