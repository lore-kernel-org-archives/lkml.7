Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780EFC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D42081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578404132;
	bh=tiS2QDs2E3lhkk79IHRHVc8y9Ek929AZjfS2N9/C934=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jiRjR91K0eYd/wUwxYhCzda4yrMKPLJ1pcOcIbJUfRVV6myQDiezME+QzJ4Zvc/fp
	 6q04YoMRxiNDwMcMaZo++gkv/7XlfSVhb7l/XCbwgXSisDnPoL1/Omzudnt05n5O+u
	 bPOZT8MaZ4pZIuKONxKidwAABPFG3E/ZUkYikcc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgAGNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:35:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so20749081pff.13;
        Tue, 07 Jan 2020 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84OwywXgIJkO5bIYBX7jlLx0QRho8GQkLvLPABVgVfY=;
        b=XPq/26Y1PNxItAKl2djpJeqWxSBcJ2oGpG8NOu/PX+ooiJo7JQURfjFJgNb/4QLJYT
         6NVgaFPmEs+y41D/TyBvck2p4luAkEgczIAUALXZWwbqlFRgggicLUzq420c7mckJBaY
         HKCAf7Zlcet8aWihrUldBf2Jtgztw1B0tkbd9+LHI5x/PpxIw3v4fHeyXktm9pNtv3J2
         hqBbgzCGsWZoNxQgC03gaqgfHx99vKonRcSrUeMe4zJJiFRus+b358HS+Kdkl8YaZq6p
         gQHn6ojnPzovrwvI3efywMRrJaZ3ZIFRqh4Xk5qW5sh6zSbSvacWzjzchKODD7HX1gRU
         YSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=84OwywXgIJkO5bIYBX7jlLx0QRho8GQkLvLPABVgVfY=;
        b=f0RA0ZX6DO9kbwLWTjrF6ekp/u4IsXfAaDXcNsxfEeJFGAyTaCmCMAPNhqTWbylW8x
         lnqqtXUwvI85121coiUEekjka6bWjA6bvpU43azrOzG5Gu08Nlr/4+ZP/KnhfJ/40+Gz
         oQ+x5Da+1hqBUZUWO/iFw5Pf5fuc+8/qswiAw0LH9cJIRSZTgJuu8j2Gxa3QGs71w5lR
         FnXKZ1Q2afMAP7BHhAR8OBjwn0SXYklk/mogzK5kns55V5JaJ4g6SD8A2+BzFrOQZYrb
         7OT4jaYwJF/k1J+9XydWXiuZq+kpni2FwQouwy8FdFIppxTplAm0nuUf04Kmhh/5oKEc
         P1Zw==
X-Gm-Message-State: APjAAAVNzDte8sk8zlVNRGKXOqHTD1qcSSuLukWJNFqxSTUMkk0uWVe+
        1nTs232FTyKBpDEEi6oEqa8=
X-Google-Smtp-Source: APXvYqyrCuWaykb0HYkFJcAXErJAs3kYnfWR7sLC+vLNQ9YDKdIOGdFZpNPdw6Oq8XoLVlApEFwquA==
X-Received: by 2002:aa7:8e0e:: with SMTP id c14mr92539848pfr.95.1578404129967;
        Tue, 07 Jan 2020 05:35:29 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p17sm80358484pfn.31.2020.01.07.05.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:35:29 -0800 (PST)
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date:   Tue,  7 Jan 2020 22:34:53 +0900
Message-Id: <20200107133501.327117-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support cgroup tracking, add CGROUP event to save a link between
cgroup path and id number.  This is needed since cgroups can go away
when userspace tries to read the cgroup info (from the id) later.
The attr.cgroup bit was also added to enable cgroup tracking from
userspace.

This event will be generated when a new cgroup becomes active.
Userspace might need to synthesize those events for existing cgroups.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
[staticize perf_event_cgroup function]
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/perf_event.h |  13 +++-
 kernel/events/core.c            | 111 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794d3105..de2ab87ca92c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -377,7 +377,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1006,6 +1007,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde19b56..dbc46b884505 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_cgroup_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4455,6 +4456,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_dec(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_dec(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_dec(&nr_task_events);
 	if (event->attr.freq)
@@ -7564,6 +7567,105 @@ void perf_event_namespaces(struct task_struct *task)
 			NULL);
 }
 
+/*
+ * cgroup tracking
+ */
+#ifdef CONFIG_CGROUPS
+
+struct perf_cgroup_event {
+	char				*path;
+	int				path_size;
+	struct {
+		struct perf_event_header	header;
+		u64				id;
+		char				path[];
+	} event_id;
+};
+
+static int perf_event_cgroup_match(struct perf_event *event)
+{
+	return event->attr.cgroup;
+}
+
+static void perf_event_cgroup_output(struct perf_event *event, void *data)
+{
+	struct perf_cgroup_event *cgroup_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u16 header_size = cgroup_event->event_id.header.size;
+	int ret;
+
+	if (!perf_event_cgroup_match(event))
+		return;
+
+	perf_event_header__init_id(&cgroup_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				cgroup_event->event_id.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, cgroup_event->event_id);
+	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	cgroup_event->event_id.header.size = header_size;
+}
+
+static void perf_event_cgroup(struct cgroup *cgrp)
+{
+	struct perf_cgroup_event cgroup_event;
+	char path_enomem[16] = "//enomem";
+	char *pathname;
+	size_t size;
+
+	if (!atomic_read(&nr_cgroup_events))
+		return;
+
+	cgroup_event = (struct perf_cgroup_event){
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_CGROUP,
+				.misc = 0,
+				.size = sizeof(cgroup_event.event_id),
+			},
+			.id = cgroup_id(cgrp),
+		},
+	};
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (pathname == NULL) {
+		cgroup_event.path = path_enomem;
+	} else {
+		/* just to be sure to have enough space for alignment */
+		cgroup_path(cgrp, pathname, PATH_MAX - sizeof(u64));
+		cgroup_event.path = pathname;
+	}
+
+	/*
+	 * Since our buffer works in 8 byte units we need to align our string
+	 * size to a multiple of 8. However, we must guarantee the tail end is
+	 * zero'd out to avoid leaking random bits to userspace.
+	 */
+	size = strlen(cgroup_event.path) + 1;
+	while (!IS_ALIGNED(size, sizeof(u64)))
+		cgroup_event.path[size++] = '\0';
+
+	cgroup_event.event_id.header.size += size;
+	cgroup_event.path_size = size;
+
+	perf_iterate_sb(perf_event_cgroup_output,
+			&cgroup_event,
+			NULL);
+
+	kfree(pathname);
+}
+
+#endif
+
 /*
  * mmap tracking
  */
@@ -10607,6 +10709,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_inc(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_inc(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_inc(&nr_task_events);
 	if (event->attr.freq)
@@ -12581,6 +12685,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(jc);
 }
 
+static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
+{
+	perf_event_cgroup(css->cgroup);
+	return 0;
+}
+
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
@@ -12602,6 +12712,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 struct cgroup_subsys perf_event_cgrp_subsys = {
 	.css_alloc	= perf_cgroup_css_alloc,
 	.css_free	= perf_cgroup_css_free,
+	.css_online	= perf_cgroup_css_online,
 	.attach		= perf_cgroup_attach,
 	/*
 	 * Implicitly enable on dfl hierarchy so that perf events can
-- 
2.24.1.735.g03f4e72817-goog

