Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44160C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F32051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578404146;
	bh=Uz6oVUVhfR52DGq6ET3k5sNG1v/Xh/1/BP0UczGO6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nJvipQyJizqmkPh3YTCCUXbdLkapYJsfVo5ZurtvIA/4kSR5I1iJTdkAJ4X8n08Tn
	 +xlflwyhXhXIUYF0hKz7q7G3WJLoPhbe1ITzTNlBLcFYiZML/UtPlOqcRe42vkz4p6
	 5uKKNpKLadrAcRJ+pergu5SN8+aEa+BylakkEvRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgAGNfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:35:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44800 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgAGNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so27759088pfw.11;
        Tue, 07 Jan 2020 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0+hBc0sASqCr7q7ooYNHa6LJ1/euN7sQVpaH1YKHiI=;
        b=DmBqyfxl9cFaXz29wOmccKikcf2UK8xMu2IF4IV29p2kllMt0X20rw7jSAsEwdF2yr
         RdKB+7mI2BtWw8B3nLBTiVD2WWlP4GHbkfcTPi2BqMI4ZliqC6qjErXuR18Kdgoi4KG1
         YbyCYRylq2CDnOJmk283yuIR8LFWJseUhrMQx/YSyb6zu2gayz67cvP/+0+2JYQNEt9y
         XJdegGRjZGnJAR9HUxrtmJxuBZnjoV5ZgjgXmQilcK9jMapfldtwHnBbz6keIAhHz1sf
         DwNYePl8KTrDKBoEzsl3MZtv4WpVwPd4zgHKgjSd15PT3L0I34lGShhLA6EwHFL5eEtj
         yRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=M0+hBc0sASqCr7q7ooYNHa6LJ1/euN7sQVpaH1YKHiI=;
        b=eQ6KqdL6qnrvy9XWhkwdx3F0O75/P7p6ubPqTmnbOGAmQynZUOTBproVnbUmxPdfsk
         LsCR9ISbo/oHxjrkZ/9kJC0XE5OXDo1i/PKKrm5mj8+BNX6HlOWvePhuC2iytGZNP0B3
         BmyD26VLjlZYN0RUxZkcFMy/9LAO+9DoZjJ/quYs/8SZaoDbkW/y0XSARMI6M+6YtyT3
         gvUuWeI0NZ3u8BHeLqPdnZxmmOFUfd3++eho7zAYHjbka20K1X9Ce7los5ZOYZIVaIEq
         9bOFsXSWBBoqCWgOgfhxFRM3cVXoBcHhU4+gSvCttFgdGiONIXZS3KXj+SDZZrehZR4K
         VM5w==
X-Gm-Message-State: APjAAAWeJ5UdKgdd8brCU+bsvYng1+WJ5CpCC/p7zPH1acSXajGQ8skH
        HkR+WTpe+/LQZrKixRLCbEw=
X-Google-Smtp-Source: APXvYqzqirbUC/VRlXnbmfWTYhTC9IPgVUxWPFutQ7gXaVwg/H4gpP+AOLfH1IJa82xzLB5Fd+WYgQ==
X-Received: by 2002:a63:ec0a:: with SMTP id j10mr116621343pgh.178.1578404139807;
        Tue, 07 Jan 2020 05:35:39 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p17sm80358484pfn.31.2020.01.07.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:35:39 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date:   Tue,  7 Jan 2020 22:34:56 +0900
Message-Id: <20200107133501.327117-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
Hist entries have cgroup id can compare it directly and later it can
be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  | 15 +++++---
 tools/perf/util/machine.c |  7 ++++
 tools/perf/util/session.c |  4 +++
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4881d4af3381..4e8ef1db0c94 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -13,6 +13,8 @@
 
 int nr_cgroups;
 
+static struct rb_root cgroup_tree = RB_ROOT;
+
 static int
 cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 {
@@ -250,3 +252,73 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+struct cgroup *cgroup__findnew(uint64_t id, const char *path)
+{
+	struct rb_node **p = &cgroup_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct cgroup *cgrp;
+
+	while (*p != NULL) {
+		parent = *p;
+		cgrp = rb_entry(parent, struct cgroup, node);
+
+		if (cgrp->id == id)
+			return cgrp;
+
+		if (cgrp->id < id)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	cgrp = malloc(sizeof(*cgrp));
+	if (cgrp == NULL)
+		return NULL;
+
+	cgrp->name = strdup(path);
+	if (cgrp->name == NULL) {
+		free(cgrp);
+		return NULL;
+	}
+
+	cgrp->fd = -1;
+	cgrp->id = id;
+	refcount_set(&cgrp->refcnt, 1);
+
+	rb_link_node(&cgrp->node, parent, p);
+	rb_insert_color(&cgrp->node, &cgroup_tree);
+
+	return cgrp;
+}
+
+struct cgroup *cgroup__find_by_path(const char *path)
+{
+	struct rb_node *node;
+
+	node = rb_first(&cgroup_tree);
+	while (node) {
+		struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
+
+		if (!strcmp(cgrp->name, path))
+			return cgrp;
+
+		node = rb_next(&cgrp->node);
+	}
+
+	return NULL;
+}
+
+void destroy_cgroups(void)
+{
+	struct rb_node *node;
+	struct cgroup *cgrp;
+
+	while (!RB_EMPTY_ROOT(&cgroup_tree)) {
+		node = rb_first(&cgroup_tree);
+		cgrp = rb_entry(node, struct cgroup, node);
+
+		rb_erase(node, &cgroup_tree);
+		cgroup__put(cgrp);
+	}
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 2ec11f01090d..381583df27c7 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -3,16 +3,18 @@
 #define __CGROUP_H__
 
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 
 struct option;
 
 struct cgroup {
-	char *name;
-	int fd;
-	refcount_t refcnt;
+	struct rb_node		node;
+	u64			id;
+	char			*name;
+	int			fd;
+	refcount_t		refcnt;
 };
 
-
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
@@ -26,4 +28,9 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
+struct cgroup *cgroup__findnew(uint64_t id, const char *path);
+struct cgroup *cgroup__find_by_path(const char *path);
+
+void destroy_cgroups(void);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2c3223bec561..19d40a2016d7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -33,6 +33,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include <internal/lib.h> // page_size
+#include "cgroup.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -658,9 +659,15 @@ int machine__process_cgroup_event(struct machine *machine __maybe_unused,
 				  union perf_event *event,
 				  struct perf_sample *sample __maybe_unused)
 {
+	struct cgroup *cgrp;
+
 	if (dump_trace)
 		perf_event__fprintf_cgroup(event, stdout);
 
+	cgrp = cgroup__findnew(event->cgroup.id, event->cgroup.path);
+	if (cgrp == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6b4c12d48c3f..5e2c9f504184 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -289,6 +289,8 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 	} while (1);
 }
 
+extern void destroy_cgroups(void);
+
 void perf_session__delete(struct perf_session *session)
 {
 	if (session == NULL)
@@ -303,6 +305,8 @@ void perf_session__delete(struct perf_session *session)
 	if (session->data)
 		perf_data__close(session->data);
 	free(session);
+
+	destroy_cgroups();
 }
 
 static int process_event_synth_tracing_data_stub(struct perf_session *session
-- 
2.24.1.735.g03f4e72817-goog

