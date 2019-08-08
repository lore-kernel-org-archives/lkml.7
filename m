Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DBDC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A45421881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290493;
	bh=HnDJEk1DiM0iDJK3qCEAwZQ1UyOBruNrDUNypFmzK8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zeCrIXIUZgepn+HgAH5d0DJaulmSJxM/sQ6BNvsOiKvenZaZHyPsuU968fLSZ+HGk
	 QcbIUOm0uaS6pnkDK+HEqNWIo7FB8LXf2aWruNiwkAGfLQu46TFykKHp+Jiaa5S7Tj
	 BfBj+eI8PXPhxCcH1SazJ2qOpzfriz/6Gr4cnpcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390321AbfHHSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbfHHSyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:54:51 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454CE2184E;
        Thu,  8 Aug 2019 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290490;
        bh=HnDJEk1DiM0iDJK3qCEAwZQ1UyOBruNrDUNypFmzK8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwbl1Mp+1BOnE6cY5mE8mYVxFindwvQQm21xohsfgSipfVaKlcs8vYJ+PrJPHKNfp
         CZYiPwNUrD0wjBPfcs3kbtmDFrx1Z6H73R5JyW5YVE31VH9hQshuqXdPSY60oB37UW
         yC3HwmtKE2oVWyxG+2bbscMwIAvpgAXFH3F03POc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 04/10] perf ftrace: Fix failure to set cpumask when only one cpu is present
Date:   Thu,  8 Aug 2019 15:53:52 -0300
Message-Id: <20190808185358.20125-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

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
-- 
2.21.0

