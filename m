Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E6C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7899F208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578404136;
	bh=IgI8MycRrjW1ev4+e2+WRaDh7OJTGfoGZsdWdyrN9Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MHkD67F9ewpgO1SPoTDhdTyEKuYZg+ph5mzfAPJZaB04I/gNJyCMEg7pQ1eZyJUX
	 IsnHnpwgjy+Utj4Qpo5xBB446ADqT7WizEl3G40CtvM3fdy8FmbhBCzDit8iKSjQNl
	 Wp2rcUu98d8694yeB5pUt2CSHDaDEvO1tm6UW4IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgAGNff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:35:35 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32893 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:34 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so5334664pjb.0;
        Tue, 07 Jan 2020 05:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiEYKxqDgDxg51RdyTx+sIt/BTY6qEXME1ywkY8gAgQ=;
        b=fZK/jSUZNXyPQ1xD7Yi0wzCOv2T2I8gS7ZtPZ2XfYjucTHkAnxj7TVD1Ph2uXOngsn
         MlZ+MT/cGjq2wsZbmBRgyRFxbBDZPcoOWymdPfFiGxhivohrnkEJ9AtWyoQY+s35m7Xk
         rkVOXqdBag2lsInv466IZR/QxJk+JDglNdWi4lBLMb8uCSKppZTOwccdz2fy9rh90NsV
         Z6pHRZ/xRSK/vq5OrSUMMgOzaZqbQ2tFedSIowxpUtVeTgG6y9XeYvx5qqZMDqla5Loc
         PgyN0cZ77O8FuDB19ooENM6CbnjqUyaduu9WFOGNNtltRCl4bC1KkSBKtsiqIRaQ/Doo
         jo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MiEYKxqDgDxg51RdyTx+sIt/BTY6qEXME1ywkY8gAgQ=;
        b=Ya4oee/vL3z+EV5dZ925lJ4VEAIhjbZLCpz0gQxrxJJ2BdF185TwI2/oG+RXyivLPx
         uFNuDrpW1uex45sC+Fe2+cHMfLqTVsARWZjF3yMguYY4pzOerSwkx7pfqnCfnTMTq6N8
         PASfSPsAX8Ii/1jz5nvqkiiUCILdWbnAiECQFOS/4ezq7uwgYPXQ4ywygaSnwCpJJ10B
         vxaQWUhdLTC5Oa5/ScoYj0vTdHwWkBSdcAmENdmB7b8I/3EnsAnnmeK4SUtNLi8zmDLE
         eX85NMSHZoM5ArHl7qg5MV6q0e0vZjlYXUBaL3fXIRGh3HOspclwvC4vlV3BV/9X7v8s
         Qw+g==
X-Gm-Message-State: APjAAAUYa3ONvBUL63uEeBGL1UUORgGNU7KMcTTe0Z7ajLKk586jF8cl
        leL11/hq9qNL/O7Awl5oZj4=
X-Google-Smtp-Source: APXvYqyE8NoFbwqfyegtWpoJRULHv73zsOFa1n1GVc8YpChF8C4ncwmRO5CLOWT0Y9gv/PU6l6SkWA==
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr108600257pld.140.1578404133458;
        Tue, 07 Jan 2020 05:35:33 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p17sm80358484pfn.31.2020.01.07.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:35:32 -0800 (PST)
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
Date:   Tue,  7 Jan 2020 22:34:54 +0900
Message-Id: <20200107133501.327117-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
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
index a34064a031a5..403ed2448b22 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1026,7 +1026,8 @@ config CGROUP_PERF
 	help
 	  This option extends the perf per-cpu mode to restrict monitoring
 	  to threads which belong to the cgroup specified and run on the
-	  designated cpu.
+	  designated cpu.  Or this can be used to have cgroup ID in samples
+	  so that it can monitor performance events among cgroups.
 
 	  Say N if unsure.
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dbc46b884505..773480527194 100644
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

