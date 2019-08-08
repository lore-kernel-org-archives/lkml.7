Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43ABC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71A62173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gxyvdHIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbfHHUR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:17:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404324AbfHHUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:17:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KHnFF3320927
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:17:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KHnFF3320927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295469;
        bh=fY2A8QyFB0MqLBtu43yiHTYb2DT3d2bFrT7eQ8fwCMk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gxyvdHIsvjFil+jgmz4POLPwlRTyRCijnGIllnK0PCOqVqrpeAk/KSi6DYj3euIIn
         nBVyccMIb+C4ZiRrargqGUFLu+LrsSA3GNIURlu/YAlmONZbbIhf62fAPZHFm+k2du
         N5DNXtEuzvA4/b8WxvTuahGxnExhYm/Vz0UMjv7+1iP4VmYmwT8cJXKKjiaUsH2t4m
         so1L1WVhLUQqEO+j32uH3+HfWBXgzGPeZ0OsWfxUz7xyJUhUBRyesjylWYMQKIzGaK
         ytW95lZZLNf1FAhDToea1r3f5zRlTZweKaASUJR9FbUKkroigUG9Y8YJ0VVAhSLB0G
         QXRCPA4HQlctg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KHmaW3320924;
        Thu, 8 Aug 2019 13:17:48 -0700
Date:   Thu, 8 Aug 2019 13:17:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-3de7ae0b2a1d86dbb23d0cb135150534fdb2e836@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, jolsa@redhat.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190808064823.14846-1-adrian.hunter@intel.com>
References: <20190808064823.14846-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Fix thread__exec_comm()
Git-Commit-ID: 3de7ae0b2a1d86dbb23d0cb135150534fdb2e836
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

Commit-ID:  3de7ae0b2a1d86dbb23d0cb135150534fdb2e836
Gitweb:     https://git.kernel.org/tip/3de7ae0b2a1d86dbb23d0cb135150534fdb2e836
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 8 Aug 2019 09:48:23 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:10 -0300

perf db-export: Fix thread__exec_comm()

Threads synthesized from /proc have comms with a start time of zero, and
not marked as "exec". Currently, there can be 2 such comms. The first is
created by processing a synthesized fork event and is set to the
parent's comm string, and the second by processing a synthesized comm
event set to the thread's current comm string.

In the absence of an "exec" comm, thread__exec_comm() picks the last
(oldest) comm, which, in the case above, is the parent's comm string.
For a main thread, that is very probably wrong. Use the second-to-last
in that case.

This affects only db-export because it is the only user of
thread__exec_comm().

Example:

  $ sudo perf record -a -o pt-a-sleep-1 -e intel_pt//u -- sleep 1
  $ sudo chown ahunter pt-a-sleep-1

Before:

  $ perf script -i pt-a-sleep-1 --itrace=bep -s tools/perf/scripts/python/export-to-sqlite.py pt-a-sleep-1.db branches calls
  $ sqlite3 -header -column pt-a-sleep-1.db 'select * from comm_threads_view'
  comm_id     command     thread_id   pid         tid
  ----------  ----------  ----------  ----------  ----------
  1           swapper     1           0           0
  2           rcu_sched   2           10          10
  3           kthreadd    3           78          78
  5           sudo        4           15180       15180
  5           sudo        5           15180       15182
  7           kworker/4:  6           10335       10335
  8           kthreadd    7           55          55
  10          systemd     8           865         865
  10          systemd     9           865         875
  13          perf        10          15181       15181
  15          sleep       10          15181       15181
  16          kworker/3:  11          14179       14179
  17          kthreadd    12          29376       29376
  19          systemd     13          746         746
  21          systemd     14          401         401
  23          systemd     15          879         879
  23          systemd     16          879         945
  25          kthreadd    17          556         556
  27          kworker/u1  18          14136       14136
  28          kworker/u1  19          15021       15021
  29          kthreadd    20          509         509
  31          systemd     21          836         836
  31          systemd     22          836         967
  33          systemd     23          1148        1148
  33          systemd     24          1148        1163
  35          kworker/2:  25          17988       17988
  36          kworker/0:  26          13478       13478

After:

  $ perf script -i pt-a-sleep-1 --itrace=bep -s tools/perf/scripts/python/export-to-sqlite.py pt-a-sleep-1b.db branches calls
  $ sqlite3 -header -column pt-a-sleep-1b.db 'select * from comm_threads_view'
  comm_id     command     thread_id   pid         tid
  ----------  ----------  ----------  ----------  ----------
  1           swapper     1           0           0
  2           rcu_sched   2           10          10
  3           kswapd0     3           78          78
  4           perf        4           15180       15180
  4           perf        5           15180       15182
  6           kworker/4:  6           10335       10335
  7           kcompactd0  7           55          55
  8           accounts-d  8           865         865
  8           accounts-d  9           865         875
  10          perf        10          15181       15181
  12          sleep       10          15181       15181
  13          kworker/3:  11          14179       14179
  14          kworker/1:  12          29376       29376
  15          haveged     13          746         746
  16          systemd-jo  14          401         401
  17          NetworkMan  15          879         879
  17          NetworkMan  16          879         945
  19          irq/131-iw  17          556         556
  20          kworker/u1  18          14136       14136
  21          kworker/u1  19          15021       15021
  22          kworker/u1  20          509         509
  23          thermald    21          836         836
  23          thermald    22          836         967
  25          unity-sett  23          1148        1148
  25          unity-sett  24          1148        1163
  27          kworker/2:  25          17988       17988
  28          kworker/0:  26          13478       13478

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 65de51f93ebf ("perf tools: Identify which comms are from exec")
Link: http://lkml.kernel.org/r/20190808064823.14846-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 873ab505ca80..590793cc5142 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -214,14 +214,24 @@ struct comm *thread__comm(const struct thread *thread)
 
 struct comm *thread__exec_comm(const struct thread *thread)
 {
-	struct comm *comm, *last = NULL;
+	struct comm *comm, *last = NULL, *second_last = NULL;
 
 	list_for_each_entry(comm, &thread->comm_list, list) {
 		if (comm->exec)
 			return comm;
+		second_last = last;
 		last = comm;
 	}
 
+	/*
+	 * 'last' with no start time might be the parent's comm of a synthesized
+	 * thread (created by processing a synthesized fork event). For a main
+	 * thread, that is very probably wrong. Prefer a later comm to avoid
+	 * that case.
+	 */
+	if (second_last && !last->start && thread->pid_ == thread->tid)
+		return second_last;
+
 	return last;
 }
 
