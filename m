Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0EFC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22CB217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558503191;
	bh=7+yqMwr7hcn8I/KrMJOFmlTCWz/f6mzumaosQ1CwjWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jY0wkbtWwJN2LNDLNitSVVfpNc/P4e7Fi5y/A2wBjQQVPlBueKsZ0fQd6lDttcLj+
	 j3lwPcQKDP6EyicvTzHXOHbAWLAQylhWK7PYeFNhjN2PZ1hPwEMlPlfmBtoWwkDQWH
	 JnMMm7ybAXXt75wWESal/XNM3V70h0GilTmNl7QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfEVFdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:33:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34565 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVFdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:33:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so494978plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpMNTukzEU3GnyZeQbJtOBvq2lWJF2LOUFiXzinJa48=;
        b=LX3XH/zD8Vi9YWkPUh/AVpL4iYs/xXiNoMAqWCPb0VBMJJvT/12publxzRTiqihCVd
         6qaKLFj7/5xhZbMGxqaPrmAanTf28HSujZ3u8TklfbAcEboScKVDjn8PHIpwI9OLmt2L
         PGlbMuVpc4rgmuCK0H68wyWaljUC0Am6CLlgiTsc/7q85vyfK5olZHlYZNutYQ1coWIr
         rFLKNQdt6JYdLG3FWbmo65AtTUC6RICSa6nelf2sQEhL3BDCGt9t5ARyF/xBigJdC+ED
         npPPzwsXSBHz9AadJgNTByNpac5LIUiwzNIbmzB4GtpZe4yXj0YtkvkoUqp/Rp9RKoH4
         ZLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QpMNTukzEU3GnyZeQbJtOBvq2lWJF2LOUFiXzinJa48=;
        b=E/f8fsM3kwI1ju6szcopZlx32J/DYYdOaxWQ2RKDkxRyL3mJCSRUSDvxSeXqCQRUJi
         xeBA3gDJpvCm7G2bwEP5wIxSSbFeOiArQgZ7r660bzODwnuqggqLNXPFm4m4BokS1jRI
         Drx/6gA1mIBGc3hECDCuzb2DkEe/nwDpA1+zm7vG2xH2tTvyOMRrZtPM6KK6UpUGIb6J
         C1i4395njmQ9461tyxCuLY7GsbuMmetlV/BMPCMFUWMihk3HYpL+FHAQJHlrYfrUj+Ym
         JalCg+ti54JarhWFQKCXEYdDzjZEvu+d37jb/FD301+liglfncuRL26C5k4q6Km6Xu+P
         5nPA==
X-Gm-Message-State: APjAAAXYCMChmsLLc+4M3NQ2Sduupqtktne5bXCbBtwZ0y5t58UduXmQ
        N+cGDS42ktHq7i4JSkSHFp0=
X-Google-Smtp-Source: APXvYqxPbHRpiZZmZa8naODvSAPDHZ9e19CjJdCF9is0GDJ2Wq3ewv+//5c94FaXLnxm9J6fU/wrTg==
X-Received: by 2002:a17:902:10c:: with SMTP id 12mr88302205plb.61.1558503183740;
        Tue, 21 May 2019 22:33:03 -0700 (PDT)
Received: from namhyung.seo.corp.google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id p7sm25027927pgb.92.2019.05.21.22.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 22:33:03 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 3/3] perf top: Enable --namespaces option
Date:   Wed, 22 May 2019 14:32:50 +0900
Message-Id: <20190522053250.207156-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190522053250.207156-1-namhyung@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since perf record already have the option, let's have it for perf top
as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 44d89fb9c788..cfea87c6f38e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -262,6 +262,11 @@ Default is to monitor all CPUS.
 	The number of threads to run when synthesizing events for existing processes.
 	By default, the number of threads equals to the number of online CPUs.
 
+--namespaces::
+	Record events of type PERF_RECORD_NAMESPACES and display it with the
+	'cgroup_id' sort key.
+
+
 INTERACTIVE PROMPTING KEYS
 --------------------------
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3648ef576996..6651377fd762 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1208,6 +1208,9 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
+	if (opts->record_namespaces)
+		top->tool.namespace_events = true;
+
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
@@ -1500,6 +1503,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
+	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
+		    "Record namespaces events"),
 	OPT_END()
 	};
 	struct perf_evlist *sb_evlist = NULL;
-- 
2.21.0.1020.gf2820cf01a-goog

