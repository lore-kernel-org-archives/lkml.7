Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06036C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92272339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977530;
	bh=vg3lP/qWybXrxx5UVq8tB4ShDHKqOHaimStHy4nihTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUC5eUoAfUseWp2dnm629FgHvlTVx6TsAjgz8hAcTxBbPJ8DjDtsXBVvdX7JS7EcG
	 7pok+bHguPvmt9A2CduVYSDit8p2xwoDLkVPKAey0HqH3uBIALidkL++dSu8fsGPE6
	 fzcYsiOhmfyOGAE9C+8Hb+svBOZ5JdJj1PoK6H7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfH1HcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44158 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfH1HcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so802883plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWpTxdViVJ8kbMOdBTQcl5GUZ1qtcE/mYeOtkzVviDY=;
        b=ZCypNtG77oJow1Q38B525hWz+xs8J0NdOow3BC1b4CNQCLtkGFnVoxRZBx2ojjRE3v
         igU8f1SbOK3t0oozUlVIevdQzC0FbLSC/sjtPhN2wT1pzMnXj7pUwpzC1qYriswRhLkG
         PVf64fIKzGGDWl07pcOhIjWJs8kSv36aFRhBRPj/SUIynAq4CDif8U0UyGe34/ZorQa4
         02CTW7A2u3SiKqSMd+3Os2zazedUYIek0OjKVkxUzo/qWJeEaAkg/8JCeHZ2UCtbMqEn
         OYROeGLnJ0WZtKUWnUon9jVIEjm6NFdT0y+lkxexVnaSVLq1ZriD0/zPiZ5H7GUyzGMi
         do2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TWpTxdViVJ8kbMOdBTQcl5GUZ1qtcE/mYeOtkzVviDY=;
        b=kftidFNQZh0NsIwg1bPm9IIy382upxvRDtLmqYlWKryFZuEELrsTHUzOvplMPrSwd5
         M5Vbm9MucFu4LNe4gVGXzrJjmziECuApUn1jpPFqNECN4HiS1EWS+GgzB1ijo+Ifmr4L
         bQRlcEJLXCHPebg7DmS7gNe1Kgxl6iti654HdJaOOoONTtMgGwJu3uBUh8BA0lFSOEdE
         esFXMpruPEmE6/8pU4UPAb1D9rr7Gxo0YY4HqA1GTzd9RvL6K89ImqZD5sYcRnn3X+aQ
         Y1opoAdGhi+Z1uFyBJUeOG0AI+MLO4BS5Cg71XB5fTBq11zX5kh9BapQzhQ0xVnT3Ua6
         jIVw==
X-Gm-Message-State: APjAAAWMJYJM00YdrKmjzT2vOqOcr+8DftxjR+f0nyf9p5pp5nmdo1gS
        QpQ8rVOmv+7gJMV2EEtLxZc=
X-Google-Smtp-Source: APXvYqxo96JBZU0JMaI8+TDK7FtBtv4PR0yF+c2kxWr3pVx+M82in72TskVxyrekGL7695RizVNmyA==
X-Received: by 2002:a17:902:7616:: with SMTP id k22mr2855627pll.315.1566977522357;
        Wed, 28 Aug 2019 00:32:02 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:32:01 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date:   Wed, 28 Aug 2019 16:31:27 +0900
Message-Id: <20190828073130.83800-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
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
 tools/perf/builtin-record.c |   5 ++
 tools/perf/util/cgroup.c    |   3 +-
 tools/perf/util/cgroup.h    |   1 +
 tools/perf/util/event.c     | 115 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/event.h     |   4 ++
 tools/perf/util/tool.h      |   1 +
 6 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 359bb8f33e57..a6e3c4413b39 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1318,6 +1318,11 @@ static int record__synthesize(struct record *rec, bool tail)
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
index 8e4c26ea5078..274f0f29c72d 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -14,8 +14,7 @@ int nr_cgroups;
 
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
index c19b00c1fc26..9e71b9561f72 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -29,6 +29,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "cgroup.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -296,6 +297,120 @@ int perf_event__synthesize_namespaces(struct perf_tool *tool,
 	return 0;
 }
 
+static int perf_event__synthesize_cgroup(struct perf_tool *tool,
+					 union perf_event *event,
+					 char *path, size_t mount_len,
+					 perf_event__handler_t process,
+					 struct machine *machine)
+{
+	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
+	size_t path_len = strlen(path) - mount_len + 1;
+	struct stat64 stbuf;
+
+	while (path_len % sizeof(u64))
+		path[mount_len + path_len++] = '\0';
+
+	memset(&event->cgroup, 0, event_size);
+
+	event->cgroup.header.type = PERF_RECORD_CGROUP;
+	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
+
+	if (stat64(path, &stbuf) < 0) {
+		pr_debug("stat failed: %s\n", path);
+		return -1;
+	}
+
+	event->cgroup.ino = stbuf.st_ino;
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
 static int perf_event__synthesize_fork(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid, pid_t ppid,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 0170435fd1e8..b4c4da69a771 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -735,6 +735,10 @@ int perf_event__synthesize_namespaces(struct perf_tool *tool,
 				      perf_event__handler_t process,
 				      struct machine *machine);
 
+int perf_event__synthesize_cgroups(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine);
+
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid,
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
2.23.0.187.g17f5b7556c-goog

