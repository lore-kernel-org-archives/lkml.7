Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B2DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8841E2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WD+9g4D8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbfHHUSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:18:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404566AbfHHUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:18:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KIaV83321220
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:18:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KIaV83321220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295517;
        bh=jjsyZe/g1ELpLbfcuFi5lyYTwtm4ps8xKc4c/gamOWc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WD+9g4D8x0+fjhGmppK9bqLaPjEqFb9CzC/Ocamsi7+NceXvgjAUd6442EIiSGNUL
         pWvh9Ex4FWno5KYwa1M3b6KLLZwkI0cS/XOv6cSUeLeYiA7g+ciBiBGfrePVWwNt6l
         KfFL4ODUz4kbwtTPRyfO+J97mYEqilULE/RCPKbrpX30k7lQvtzjKhZnX1kgWqK4JT
         njXfVwFa+bspsZy+kXx7ehjspFwjT5MpJQERKcyQQq57fIoSJ6H4Y0Xj8nWkCi2Xxv
         Wp+UZGDq24etbv0i1X3/Ee4UlnrXeGwziLsauJsk1VqAuo9rLdiNQ/Niw48qeyM+0p
         XYtCtLgMNO82w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KIa9n3321217;
        Thu, 8 Aug 2019 13:18:36 -0700
Date:   Thu, 8 Aug 2019 13:18:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for He Zhe <tipbot@zytor.com>
Message-ID: <tip-cf30ae726c011e0372fd4c2d588466c8b50a8907@git.kernel.org>
Cc:     eranian@google.com, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, acme@redhat.com, jolsa@redhat.com,
        hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, zhe.he@windriver.com,
        tglx@linutronix.de, kan.liang@linux.intel.com, namhyung@kernel.org
Reply-To: acme@redhat.com, jolsa@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
          eranian@google.com, alexander.shishkin@linux.intel.com,
          zhe.he@windriver.com, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de, kan.liang@linux.intel.com,
          namhyung@kernel.org
In-Reply-To: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
References: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf ftrace: Fix failure to set cpumask when only
 one cpu is present
Git-Commit-ID: cf30ae726c011e0372fd4c2d588466c8b50a8907
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

Commit-ID:  cf30ae726c011e0372fd4c2d588466c8b50a8907
Gitweb:     https://git.kernel.org/tip/cf30ae726c011e0372fd4c2d588466c8b50a8907
Author:     He Zhe <zhe.he@windriver.com>
AuthorDate: Fri, 2 Aug 2019 16:29:51 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:10 -0300

perf ftrace: Fix failure to set cpumask when only one cpu is present

The buffer containing the string used to set cpumask is overwritten at
the end of the string later in cpu_map__snprint_mask due to not enough
memory space, when there is only one cpu.

And thus causes the following failure:

  $ perf ftrace ls
  failed to reset ftrace
  $

This patch fixes the calculation of the cpumask string size.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: dc23103278c5 ("perf ftrace: Add support for -a and -C option")
Link: http://lkml.kernel.org/r/1564734592-15624-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 66d5a6658daf..019312810405 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
 	int last_cpu;
 
 	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
-	mask_size = (last_cpu + 3) / 4 + 1;
+	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
 	cpumask = malloc(mask_size);
