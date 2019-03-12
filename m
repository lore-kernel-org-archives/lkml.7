Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED38C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A80217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410878;
	bh=75ZUn/mIRRk9x0oksHMZnD4fzhCLuETtfHgnV5Hm6ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TB7CDKCrCsZYPuYHlJv5FofIgmGBOV4+iDBOWUk3vjWbZhw+XqG1ceVwoLwZ4PbTx
	 C4wzH2dhCG459qjxaoIKc50pkooU+wx22QQCsszOhWZsN4kwsUq0rzSdad/dY4NBYT
	 P60qVMFh43D0R4ebF2izOQAKoHNo6mgzAPdEdRes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfCLROh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbfCLRNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B811221850;
        Tue, 12 Mar 2019 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410828;
        bh=75ZUn/mIRRk9x0oksHMZnD4fzhCLuETtfHgnV5Hm6ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpuQhi7txmuo/J9OIYfxJDVO4JFcY4YRRXNz2gv27ZcsjORTYiSAuuM5LfsFxTABO
         qhOJDhgvcQc1StfZnt+8qwpCMLZqsPDKHQxkN8spTGtjJpkkXLj15+PgogfX0y35+G
         rZSpACVea2Aztbz7ShhCx6oofg1IfHquM8cer8k0=
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
Subject: [PATCH 4.19 006/149] perf script: Fix crash when processing recorded stat data
Date:   Tue, 12 Mar 2019 10:07:04 -0700
Message-Id: <20190312170350.018664512@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index ce2aee11e360..53c11fc0855e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1589,13 +1589,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
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
@@ -2214,6 +2209,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
-- 
2.19.1



