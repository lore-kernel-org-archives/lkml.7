Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3348024680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816405;
	bh=vd5XhJ7IDGuXYQQ6Js/C4h4LDSb/2sIdp5icIaIR0sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZkEBz9bTP5gLRCNFGbYGp580Fgni5hdd44fjEVykmM5KSzsObIjfEh/2F984IUl4l
	 OJO4tlfipWk3CrIE/KDeUx1OWzps9SgYKXMINfjTwE9yEuAguPMDANMq+tWGhkd+FJ
	 W/iwFa/fkH8cb9qNXCN5w2LQ3nTPytQtncjOBpfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLTEdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37850 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTEdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so4300704pga.4;
        Thu, 19 Dec 2019 20:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qenrwjpURO/6nte65YX+DruuvEXC/la4h9aao5d2/Rg=;
        b=m26in75Y+aQg5hxGu4zx+Xo/PMLaja/samTzqpbySE3nJklBwl0tQBpWWbWrXa2NJJ
         0r7ak2nwlHDr0/2r9P5HAQXifoyKS3hxnxUIpLTdWlKiYNljr3jRtT/72CTP7QZODt66
         KUv5CNHxyL/AfNj2qwkGU/MXYhXol2HFE1VHNV/Fwgz4bfBfFLlO/CcPme7nBWC+fCw5
         zMGnKVRoc+sxiSBEyDS/UXdXvd699xE5xf6OQDjr4fZyPUgsxPDd71Cc6CgxDhjhVqRw
         MwhSOzDVNzKINNN7rFyIf7CemtQ+4n7EEkGGcgxJ4Ro1rMqly4PdTv39VgTHxna00seJ
         ccFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qenrwjpURO/6nte65YX+DruuvEXC/la4h9aao5d2/Rg=;
        b=TaDCX7sxQ66aB7wb942lM7xBrtX+QtvDhDg+akC741IXl+e49meyO/uEzRprqJ/B38
         teowvsswFVgvhSrL8I9YfyRENc712O6SCjRl4Xd22vC4rVVA6te5R/3bS3Hx0teg3kq3
         VjdCCj4iJa3pyHxw8fBJh/DsjaP2Gc0ylXaoEknKYDnIPQZ+aqM+Ms89ik3UloUAsw5R
         r03MUQ7WPg8fHlRgQE7Ezq+TmXrUdbKA7Z5fXq2s275pr3pg9idWl/6+/6fNR2LO4vlf
         2ybGt5YnDj40tFXl7OHk6RUrzCkd3mYVpYXXXBJ65HAj9pv63s3hNCb020j8unntW/Qi
         LIcg==
X-Gm-Message-State: APjAAAUsMJ61B9iUx5p2FygqUPGFPcJWoxHBThMbXOPlxv+uuiMzowLB
        xbgMjhJleJsUlyU9CEQfUQI=
X-Google-Smtp-Source: APXvYqz3U84QNH9Xj9pLzopUpSroUns1Mpl6m1pWxrO3jwUa+plKbuZFe5MRwxrjkSyRjDIQ92tihA==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr12291140pgd.387.1576816402267;
        Thu, 19 Dec 2019 20:33:22 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:21 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date:   Fri, 20 Dec 2019 13:32:46 +0900
Message-Id: <20191220043253.3278951-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
in the sample.  It will add a 64-bit id to identify current cgroup and
it's the file handle in the cgroup file system.  Userspace should use
this information with PERF_RECORD_CGROUP event to match which cgroup
it belongs.

I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
64-bit word.  But if we want bigger samples, I can work on that
direction too.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..17b5bff045a6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1001,6 +1001,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				cgroup;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7bae2d3380a6..e59c89b0286b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9bcb2b552acc..d19f04ecfa14 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		size += sizeof(data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		size += sizeof(data->cgroup);
+
 	event->header_size = size;
 }
 
@@ -6699,6 +6702,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP)
+		perf_output_put(handle, data->cgroup);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -6895,6 +6901,18 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		u64 cgrp_id = 0;
+#ifdef CONFIG_CGROUP_PERF
+		struct cgroup *cgrp;
+
+		/* protected by RCU */
+		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
+		cgrp_id = cgroup_id(cgrp);
+#endif
+		data->cgroup = cgrp_id;
+	}
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
-- 
2.24.1.735.g03f4e72817-goog

