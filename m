Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081309;
	bh=Uz6oVUVhfR52DGq6ET3k5sNG1v/Xh/1/BP0UczGO6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b1uM62c4XT1Lz7IZyc3n+FtqS7xdLybXlYo/xkM+Sp0mBcnyd/8U7nblpyO4CE34p
	 3pmvZuDhbKz8kKRv6aC4CvO9dXytkfy7iVsnbCuug3LwAgistVLumoOhsJEAVhkrhd
	 1AV8GB2hQB63Se/cG2Bwu8BgLjvWRxQZ0Xubas6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLWGI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39828 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so7013240pjb.4;
        Sun, 22 Dec 2019 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0+hBc0sASqCr7q7ooYNHa6LJ1/euN7sQVpaH1YKHiI=;
        b=Pj8GTLobqoOU9wHLJ4V7XLSXcJO7V6KXrsEK6uq1ABygfK1IQxPIqfbhHHcr7u5gat
         cYrFSy3Ux+U+unRkUP5PicdSu+zY7FfqYvPaVLPqtxwH86dhyTT/DZ/5kWEv9j4kB5j3
         sBLHCzjAOQvIrHpWmXJ0F2P8E/Vc9r/RIw87r5je29gzr6nFQjT00bHj1NKSv4oGAllL
         2Iig1xMi0bORn5MQSFJRANozZJ6q9WTzyljmKPG2sc5t6ofjwMzc/Al7g8V7Yq/lJnTx
         DKPE0sldGypX4LTe0fzdKC3byCZwNJmR8EiBv3Ffnmc4YFvOOu0QvjoxLV4OxI0hmxGD
         zDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=M0+hBc0sASqCr7q7ooYNHa6LJ1/euN7sQVpaH1YKHiI=;
        b=TlMuGxvuu2GxmObcul8/4p9UCFBi47F2UEw8TGn1ilmHBFgBpvv1NclZqQHmOJYTKf
         dbEkkq7pGSRpz4gBhRtFW6/lorV6t2TGbrxYga0BCHV6WOtcU0IT12meCtskpsfSdMp/
         KXArBdP8uzHXJYYc80tj6T8xoU0Rg6RJzoZEcPJkyvjolVw8Jm74TlhQZf0zJ770EyVK
         9QHTOXNs7Jz9mRvzfcEgJtACdHfka7ICKh/YmgKv//p10JzixAlJjzhRe5FKXBhkPl3N
         wsuC63BmZXxQhzR0Msf5S5QlXMtLQe+8+W+SY4hYJGfzo1vX/K+YvIbl5JHDKOjSerZL
         iGYQ==
X-Gm-Message-State: APjAAAUyc4xTKSVs50u8CAEOngt6w6CtAu7zp5mzT2rbSQDKofq/XsD5
        UEyAAGQrkUso3iFehiTdLrE=
X-Google-Smtp-Source: APXvYqzPTuggv+AAHTxY2xt9l6Qy3PuVM0BxU5YksduRMoIZlJl5z2ZBxLOMl3lEBrvkm+VCypot5Q==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr32422956pjn.60.1577081303728;
        Sun, 22 Dec 2019 22:08:23 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:23 -0800 (PST)
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
Date:   Mon, 23 Dec 2019 15:07:54 +0900
Message-Id: <20191223060759.841176-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
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

