Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D9AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A67822CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977515;
	bh=EOT6dlfgG8sJ/kgDu9G2mMoZWSKY6XaaVpmPG+VpFCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DyEhciUsqAjZYIUE64QWv4VUqO2s21YEbOZdUQqNH8ZSxu/pWqjX+QMTjIL4ni35Q
	 /y88Sy9uQoqDVzIMEeYrN8+06U3u7mNXVrr31xLXnZz7ca1pVNJN2R3RNirPVdx5GZ
	 09J1J6LK8YgQr/vFYZ5TxEIT7C4mwsIj6lgb3StY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1Hby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:31:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35628 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfH1Hbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so1146280pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozw3s4wDKjqsVdzZlYOC7Q8acgZg4p2t0Wv1nQeXlqo=;
        b=YZiKmdnNvXPgj4mAd9oLrMdRZrBSDCATFkC7Tjc2eGqhJm6rrI5oMNVM/s9d5XXz0n
         V5xd3V2KynE5iJDM24rv/mszhw3hJst2EylaQ1A7OdEKIvnz/G2eHBYDQ0RRIAuN8jE2
         H63pe/KNBIa+RrX1V5cnkp+kmh+1Rcr2wJZPbP3Eqvf3MMqVQTe1qp08yPDSTG2DsPYG
         7N0HqiR204bFT+ocFc09bH9YJSvPcGaVy0n9XRos5SDu1+grcWxoa30ZBiF/FEKVgobm
         C3+WnsCLELOpVtZYZXihxLmooSXVPm4fLLoB9oUQ0W8XEO6+Z+HrGdDpex38MdvXN2A6
         bgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ozw3s4wDKjqsVdzZlYOC7Q8acgZg4p2t0Wv1nQeXlqo=;
        b=KEqFEAr8UwrCkDM1SwwTIoOSaLHkugrPm9ixCnEM1Ufvv9H1fqj9F5hUYLi0CppCVj
         UTkcQs4GxUT/1fROuzvzkC+rF/smaoFfXF4H01oVj6FEW9X171CNg0VR6AtvUvrOtmnh
         SdrHDVNUzMchEFGSAt/wWVanH0ZdnxhZiOjQo822x8R9p+TYl2T0S7gnDr+Bd+z7P6s4
         ELXARgjFWfKRJr1L0ihQad+VkxaYu0Hj8N4PWY0XW7Z269D/EyTLPtFdPyguRmDbzJL5
         x5YjL2ENG5s8RXGzS5KFuWss9pEVFOhCQRMkcyGLSHZDvCEQmIz8Twc2u8MYbNB307tz
         N3Eg==
X-Gm-Message-State: APjAAAW83KZiPn5jGYh/51b2mQpvQQWhH5mYRfVHejBGAxUd8cL2FvmP
        ZLoZjjnNIVEq85DrF6YJn8E=
X-Google-Smtp-Source: APXvYqyWM90JSIQXUSAPiWPqjWkVXFgKV0hPtIvBM7Zxq2b48bUpucgpTR+CN/HRUc1/maZc6pf2aw==
X-Received: by 2002:a62:7790:: with SMTP id s138mr2909737pfc.243.1566977511814;
        Wed, 28 Aug 2019 00:31:51 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:51 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date:   Wed, 28 Aug 2019 16:31:23 +0900
Message-Id: <20190828073130.83800-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
in the sample.  It will add a 64-bit integer to identify current
cgroup and it's the inode number in the cgroup file system.  Userspace
should use this information with PERF_RECORD_CGROUP event to match
which cgroup it belongs.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  3 ++-
 kernel/events/core.c            | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e8ad3c590a23..2b9661aa4240 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -958,6 +958,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				cgroup;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index cb07c24b715f..91a552bf9611 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_CGROUP			= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d898263db4fc..04ae6a42a98b 100644
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
 
@@ -6388,6 +6391,19 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		perf_output_put(handle, data->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_CGROUP) {
+		u64 ino = 0;
+
+#ifdef CONFIG_CGROUP_PERF
+		struct cgroup *cgrp;
+
+		/* protected by RCU */
+		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
+		ino = cgroup_ino(cgrp);
+#endif
+		perf_output_put(handle, ino);
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
-- 
2.23.0.187.g17f5b7556c-goog

