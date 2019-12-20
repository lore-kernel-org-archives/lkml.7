Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE43C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828324684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816418;
	bh=hGzGGepXn1hEIJGfxHf7bGCw74VDVodnztr15hUe4Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ww8mtRDRKt14nxkJSxNeqrjE9XinYnLTSU0+JLie36oKIzkcdbkJHK54TaqAL/aSP
	 mjZekQsDfpiFMIZlcRbJjKG3OlSUnwWQHi0nxthaIBZ7Ui6WjcHzTjsBo84S2t3qrm
	 BuGTOxYWf0V82qnFQPL9WM7CioprSNXlBz2r4kso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTEdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40477 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTEdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so805482plr.7;
        Thu, 19 Dec 2019 20:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rjlsWx9PxGCpQUt9QfjqFY2qDcdfMvP/1ytyI4bU3Q=;
        b=GZuhRvb9GoL5N5gsUFttX4j6wiTg5I9JrpGazcBzio4z3LcJDT/+V6YfInWOHShBwm
         bP0ZMafbkJ8YsdisUMTYceyWV0Qin0NBnEI5h8waVIupRv+3cxP38gy5sxOF6kL9Kri9
         amotnFkxnMxjeGSnLb3pKIP5pRZTkzwCIflocTmbe2GhBaQ7pHV1aL+iZzmnsI/oJOfV
         SVMBVq5qymtC5GObjIkOv33d1vbJeubj+i8qDdASZueX/Xuj59mEfQxqCAKUimPKaHvr
         ltLSG0xzIRsQ5iGLnGor2oxpfSnh6egNsrtpmWsgWhTMduC2pIXINmGf8fSwbeOTbC5Y
         jIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+rjlsWx9PxGCpQUt9QfjqFY2qDcdfMvP/1ytyI4bU3Q=;
        b=b3EabjlmeGj0ifV0dKRNZdh3xC3YGELg0yDSu1nyyiEy+YTtlGzzMwjXNxAOPNsPNF
         rQkC/xZiORq28/e6ZcLzlXYOreVCR6XClnwreBDEH7bXbKARgQlOcQLkozbgT3jeWW2s
         61QWP5cthOD4HeE9oo/Vz1ITiHr6k3+e9HoxIIS3qivVOaMYi/6LwwM7P8cVeSW/irmX
         1YeXad7WmVxYlVoqzIufJjv+vHQt151gVZc4O4mlrkQ2UINmRBW4WJUtmwovjHmRMRb5
         HHasisAaGYSF/hiFlLRicBM6LwFmHi56aB2O4IoVzW3yysf9XTltuYX4+C0cuhmKvoKi
         Q5Uw==
X-Gm-Message-State: APjAAAV/BiqNsKoJwhJApoO9SfLXOCdQL+jZp0+IdjwK33JjnxFum/ui
        17TdkOrjuAjclignezE4DbRzpqbm
X-Google-Smtp-Source: APXvYqxM4TUeq0qjbtm2aGgawNrBeTXLeo+lScAfcMiWRG/6fIDipiM5YFGjAjqjUhZN+NFpAlWAxw==
X-Received: by 2002:a17:902:744c:: with SMTP id e12mr13333915plt.123.1576816414661;
        Thu, 19 Dec 2019 20:33:34 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:34 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date:   Fri, 20 Dec 2019 13:32:50 +0900
Message-Id: <20191220043253.3278951-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize cgroup events by iterating cgroup filesystem directories.
The cgroup event only saves the portion of cgroup path after the mount
point and the inode number.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c        |   5 ++
 tools/perf/util/cgroup.c           |   3 +-
 tools/perf/util/cgroup.h           |   1 +
 tools/perf/util/event.c            |   1 +
 tools/perf/util/synthetic-events.c | 120 +++++++++++++++++++++++++++++
 tools/perf/util/synthetic-events.h |   1 +
 tools/perf/util/tool.h             |   1 +
 7 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..2802de9538ff 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1397,6 +1397,11 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
 
+	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
+					     machine);
+	if (err < 0)
+		pr_warning("Couldn't synthesize cgroup events.\n");
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    process_synthesized_event, opts->sample_address,
 					    1);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 99d93f31732d..cf2a7fc24726 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -15,8 +15,7 @@ int nr_cgroups;
 
 static struct rb_root cgroup_tree = RB_ROOT;
 
-static int
-cgroupfs_find_mountpoint(char *buf, size_t maxlen)
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 {
 	FILE *fp;
 	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 11a8b187ec09..755f9712eda4 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -17,6 +17,7 @@ struct cgroup {
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen);
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 824c038e5c33..28801c867f39 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -33,6 +33,7 @@
 #include "bpf-event.h"
 #include "tool.h"
 #include "../perf.h"
+#include "cgroup.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c423298fe62d..7ed7c89f48e6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -16,6 +16,7 @@
 #include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
+#include "util/cgroup.h"
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -413,6 +414,125 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	return rc;
 }
 
+static int perf_event__synthesize_cgroup(struct perf_tool *tool,
+					 union perf_event *event,
+					 char *path, size_t mount_len,
+					 perf_event__handler_t process,
+					 struct machine *machine)
+{
+	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
+	size_t path_len = strlen(path) - mount_len + 1;
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	while (path_len % sizeof(u64))
+		path[mount_len + path_len++] = '\0';
+
+	memset(&event->cgroup, 0, event_size);
+
+	event->cgroup.header.type = PERF_RECORD_CGROUP;
+	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
+
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
+		pr_debug("stat failed: %s\n", path);
+		return -1;
+	}
+
+	event->cgroup.id = handle.cgroup_id;
+	event->cgroup.path_len = path_len;
+	strncpy(event->cgroup.path, path + mount_len, path_len);
+	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
+		pr_debug("process synth event failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
+					union perf_event *event,
+					char *path, size_t mount_len,
+					perf_event__handler_t process,
+					struct machine *machine)
+{
+	size_t pos = strlen(path);
+	DIR *d;
+	struct dirent *dent;
+	int ret = 0;
+
+	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
+					  process, machine) < 0)
+		return -1;
+
+	d = opendir(path);
+	if (d == NULL) {
+		pr_debug("failed to open directory: %s\n", path);
+		return -1;
+	}
+
+	while ((dent = readdir(d)) != NULL) {
+		if (dent->d_type != DT_DIR)
+			continue;
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (path[pos - 1] != '/')
+			strcat(path, "/");
+		strcat(path, dent->d_name);
+
+		ret = perf_event__walk_cgroup_tree(tool, event, path,
+						   mount_len, process, machine);
+		if (ret < 0)
+			break;
+
+		path[pos] = '\0';
+	}
+
+	closedir(d);
+	return ret;
+}
+
+int perf_event__synthesize_cgroups(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine)
+{
+	union perf_event event;
+	char *cgrp_root;
+	size_t mount_len;  /* length of mount point in the path */
+	int ret = -1;
+
+	cgrp_root = malloc(PATH_MAX);
+	if (cgrp_root == NULL)
+		return -1;
+
+	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX) < 0) {
+		pr_debug("cannot find cgroup mount point\n");
+		goto out;
+	}
+
+	mount_len = strlen(cgrp_root);
+	/* make sure the path starts with a slash (after mount point) */
+	strcat(cgrp_root, "/");
+
+	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
+					 process, machine) < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	free(cgrp_root);
+
+	return ret;
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index baead0cdc381..e7a3e9589738 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -45,6 +45,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handl
 int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_cgroups(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
 int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 472ef5eb4068..3fb67bd31e4a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -79,6 +79,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		cgroup_events;
 	bool		no_warn;
 	enum show_feature_header show_feat_hdr;
 };
-- 
2.24.1.735.g03f4e72817-goog

