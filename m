Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06659C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEB0208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081300;
	bh=GtUhfFBsT/bBBrmyyUpfzQ1YcIrFMKtBb13y1bPgDM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRh6i73y5owPcDBT0AJOt+tMOmz4wfm8KgBHE48Umzbr/efBHqCiN57fIvmhrM9Ze
	 jQ+yi++7dZw3Si4Tl7jiErn48cVlHRTkCqhzT6GytUIwliicPHAsL6V3sriUzptP+Z
	 6DkwwFUGtIbMSRbM6q9+1Mn9Paz+1W5QcaZ5m87w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLWGIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37195 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so6774847plz.4;
        Sun, 22 Dec 2019 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ymf0a9jdSnD+pCZkbbPrMLWF69n4PbxCNuq04NfiQNY=;
        b=OJUxcbYIqTViMgy7H3HwZm61SpQnynszIsZ1kLQt+o5mx62kPjHJIi8UDtDmKhhRFP
         daSxkpAmZgBX0+sHMXB8VCAGSyJbKI6pXAcvGuNM2Iz63H7PWLiXhvaH0zUt7NzlcwfG
         Uxcn1zY7KUFuGMp7ENk0C4u67URNwTl+2cNMGv28rbdAb7F5fdlEVF+XqghfIFk0MuRw
         iXVii6ZwIWD9LhSKO3AdEkGf5JQmG4CWSou4g5V4wmKdbeSHCs7v0/oSNIWEKjFelQHX
         dWulJlGoLVSaTBcwuzE9VCmei4DcoEfw9kJUjz6a9P3BaQ1Oct8/p7jn9LtkswALMlmI
         WRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ymf0a9jdSnD+pCZkbbPrMLWF69n4PbxCNuq04NfiQNY=;
        b=qWQKEuGqkgl/h2QIvJUtrVMCqDWX7KROHO95VcGaoUSfir8lcGs9Ew0X9CtdNHkr7C
         RVUK44sUKJ2KpoM0PMh5zrZ7s0vhS1MIR07wg6UK+OiSbTFOvAP5leMV5e0WL6x0R/K+
         6qGBEzXrZFUspQrkzSR1IG7nJ0sGC52PMtjxs6NVwIF9piChbisP0q9aFoY6Z73+/4WW
         +CrfdBahjV1mayk9yenpqi5cTWnIVPybVO4VsTGd094WvF01nk/LkR5Mxg23CCSZsIWy
         7tzouvUL3p1eAhlwCGnTYL6ir14qPmao8IUr8/mv3IN8BX8HX61bT4W3sYgjlE/k9yQc
         CFJw==
X-Gm-Message-State: APjAAAVfYL6sjV+s6MC7Sp8gGFTQ2YgkVba8EBRZWwijJLp32iOIlEJY
        uFpOxT9ejyDW+XnAf+xIBeFgrUFZ
X-Google-Smtp-Source: APXvYqx79SfvFTvyGu1hUGALqtO6V309SXGR+2K1ojePacHWGBhlZlJVPppZxDcTonKzfbOmG5O+gw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr29501897plo.57.1577081297482;
        Sun, 22 Dec 2019 22:08:17 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:16 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Date:   Mon, 23 Dec 2019 15:07:52 +0900
Message-Id: <20191223060759.841176-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
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
 init/Kconfig                    |  3 ++-
 kernel/events/core.c            | 22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

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
index de2ab87ca92c..3a81e9806cb1 100644
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
diff --git a/init/Kconfig b/init/Kconfig
index 128b68a16951..fedd7b503bf3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1046,7 +1046,8 @@ config CGROUP_PERF
 	help
 	  This option extends the perf per-cpu mode to restrict monitoring
 	  to threads which belong to the cgroup specified and run on the
-	  designated cpu.
+	  designated cpu.  Or this can be used to have cgroup ID in samples
+	  so that it can monitor performance events among cgroups.
 
 	  Say N if unsure.
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b0aa1b921769..db04ef695a33 100644
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
 
@@ -6895,6 +6901,16 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
+#ifdef CONFIG_CGROUP_PERF
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		struct cgroup *cgrp;
+
+		/* protected by RCU */
+		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
+		data->cgroup = cgroup_id(cgrp);
+	}
+#endif
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
@@ -11090,6 +11106,12 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		ret = perf_reg_validate(attr->sample_regs_intr);
+
+#ifndef CONFIG_CGROUP_PERF
+	if (attr->sample_type & PERF_SAMPLE_CGROUP)
+		return -EINVAL;
+#endif
+
 out:
 	return ret;
 
-- 
2.24.1.735.g03f4e72817-goog

