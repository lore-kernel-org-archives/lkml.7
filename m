Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59495C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B62E2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410712;
	bh=sA7wHAVT6wW4wF+OUZze6Xl2wg/y/EcUaA0buFJoIgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VAOkx7Xc8aWLSHp4Tn/DSrr5LR+6F9ZxQqK/GVzC/maYNDwAzDFnZRhYEgoscP/Bc
	 IyYWnT3zmxdV7maV+MWu6EcH3CH5n6JMO6qwcbDHWJSOzQ9Z+kc9XKA9kJ3FqXxc3K
	 U5eYEgP1OKRbvQLlJ+UiAiU1as51fphU+Fiu7x1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCLRLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfCLRLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:42 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B2E217D4;
        Tue, 12 Mar 2019 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410701;
        bh=sA7wHAVT6wW4wF+OUZze6Xl2wg/y/EcUaA0buFJoIgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgYm3sdRAyXYD8cOmFqkgmpd3C6BOKC8vAAdUfTkytv01dTQx4+JsFfwR5VkLaxZR
         sbPsLpYXMqmYMM02Y5DfM6lSyqTGXoF4yT5/bdx1QvYCwMyTUiCfogx3EOmfGpDAjX
         EjChwKfp2lu5n0g7+V+xh1ZSj93CigCUHHXNZfPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 011/171] perf script: Fix crash when processing recorded stat data
Date:   Tue, 12 Mar 2019 10:06:31 -0700
Message-Id: <20190312170348.854888888@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8bf8c6da53c2265aea365a1de6038f118f522113 ]

While updating perf to work with Python3 and Python2 I noticed that the
stat-cpi script was dumping core.

$ perf  stat -e cycles,instructions record -o /tmp/perf.data /bin/false

 Performance counter stats for '/bin/false':

           802,148      cycles

           604,622      instructions                                                       802,148      cycles
           604,622      instructions

       0.001445842 seconds time elapsed

$ perf script -i /tmp/perf.data -s scripts/python/stat-cpi.py
Segmentation fault (core dumped)
...
...
    rblist=rblist@entry=0xb2a200 <rt_stat>,
    new_entry=new_entry@entry=0x7ffcb755c310) at util/rblist.c:33
    ctx=<optimized out>, type=<optimized out>, create=<optimized out>,
    cpu=<optimized out>, evsel=<optimized out>) at util/stat-shadow.c:118
    ctx=<optimized out>, type=<optimized out>, st=<optimized out>)
    at util/stat-shadow.c:196
    count=count@entry=727442, cpu=cpu@entry=0, st=0xb2a200 <rt_stat>)
    at util/stat-shadow.c:239
    config=config@entry=0xafeb40 <stat_config>,
    counter=counter@entry=0x133c6e0) at util/stat.c:372
...
...

The issue is that since 1fcd03946b52 perf_stat__update_shadow_stats now calls
update_runtime_stat passing rt_stat rather than calling update_stats but
perf_stat__init_shadow_stats has never been called to initialize rt_stat in
the script path processing recorded stat data.

Since I can't see any reason why perf_stat__init_shadow_stats() is presently
initialized like it is in builtin-script.c::perf_sample__fprint_metric()
[4bd1bef8bba2f] I'm proposing it instead be initialized once in __cmd_script

Committer testing:

After applying the patch:

  # perf script -i /tmp/perf.data -s tools/perf/scripts/python/stat-cpi.py
       0.001970: cpu -1, thread -1 -> cpi 1.709079 (1075684/629394)
  #

No segfault.

Signed-off-by: Tony Jones <tonyj@suse.de>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
Link: http://lkml.kernel.org/r/20190120191414.12925-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5c070a600233..d8791e0e5f75 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1633,13 +1633,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 		.force_header = false,
 	};
 	struct perf_evsel *ev2;
-	static bool init;
 	u64 val;
 
-	if (!init) {
-		perf_stat__init_shadow_stats();
-		init = true;
-	}
 	if (!evsel->stats)
 		perf_evlist__alloc_stats(script->session->evlist, false);
 	if (evsel_script(evsel->leader)->gnum++ == 0)
@@ -2305,6 +2300,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
-- 
2.19.1



