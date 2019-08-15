Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E7C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577572173B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ju5undD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfHOJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:37:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfHOJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:37:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9Zx182275131
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:35:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9Zx182275131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861760;
        bh=0yPQC3co021hKgcA2DD+PLYhcMZQw49ORGdECLLy2fw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ju5undD56dOGsIXNNF5/34biLIQXFdzFK72e6vS6s5vbcDpxTr90fLsngPQTckMyN
         00ZtujXA6cLlxnZbxu8cewf1JPo7NovXF7XhiFSU3eK7u+HsQZSriofn0kUhTr1zK/
         tqLp7bb2gea/5HtpFJOA3tiPwCL9cDhWT1uWV/gDC35/z0qmjHLjMv2ns3ezoa22Gg
         JpCx2P1LReKkNrWkaixFUhzKqdwjeZoe2mC90gPEPPVwyAFIzoLr1WQPU4yOv4GbQP
         QXBT4aYKLY0ybHqXbqnVHeXv3HOteipxqki0tYiWn7oiC/PmbxYtM591RNLM0+wXK8
         HFfGh2Zi/vorw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9ZxBQ2275127;
        Thu, 15 Aug 2019 02:35:59 -0700
Date:   Thu, 15 Aug 2019 02:35:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tan Xiaojun <tipbot@zytor.com>
Message-ID: <tip-0a4d8fb229dd78f9e0752817339e19e903b37a60@git.kernel.org>
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        alexey.budankov@linux.intel.com, rostedt@goodmis.org,
        tglx@linutronix.de, tanxiaojun@huawei.com, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tz.stoyanov@gmail.com,
        kan.liang@linux.intel.com, songliubraving@fb.com, hpa@zytor.com
Reply-To: kan.liang@linux.intel.com, tz.stoyanov@gmail.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, tanxiaojun@huawei.com, mingo@kernel.org,
          rostedt@goodmis.org, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          songliubraving@fb.com
In-Reply-To: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
References: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Support aarch64 random socket_id
 assignment
Git-Commit-ID: 0a4d8fb229dd78f9e0752817339e19e903b37a60
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

Commit-ID:  0a4d8fb229dd78f9e0752817339e19e903b37a60
Gitweb:     https://git.kernel.org/tip/0a4d8fb229dd78f9e0752817339e19e903b37a60
Author:     Tan Xiaojun <tanxiaojun@huawei.com>
AuthorDate: Fri, 2 Aug 2019 11:48:57 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 11:00:00 -0300

perf record: Support aarch64 random socket_id assignment

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
