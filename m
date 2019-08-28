Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2AD22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977522;
	bh=r+J8wd4rNmeGiV57KDcG3BN0u+t6F1leQdVYypgTjhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5gEfvzFww/boQ6r+ZE+/9ijs3DU7x0shNThdXgk9Wov3yUPURSv3UXWJNrh1et0I
	 Bu6FckDBAWwaWRFMVmI3QLEiwTAYF0Y0Q9+VSm/mOUwZmjP3aTo26k4b+d2R7jhn9l
	 SSoxhGUY+dqV+gNKpJIH6s2Pbcv1w6jxCK8ekDyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfH1HcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38792 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfH1Hb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so818355plp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8TvAllA57WxAU0LkM2JJVxBkvzCPw+8c6SMDZJxD/s=;
        b=YSWGPbRpA2Y9JEkazRI50D5k08cgQ7pNtm7cZQlqCHV0r3RYGaLkStx9LOPsU3u1+l
         P1RLLYRoW0aukw20NQ+wWSPF5SsH6Z+LNj/ryc/oHKb5RlkYMDL4XiJKO53gHDnq0+fh
         y+NyEbrHijQY7HFq2ssYucCNqZhs/xSyhg5A6KqldoBPNikOvt6P/ZOIss7vccLF6yoj
         Sv0agCOVkjxE9UmRwSEsv2MQhDDoCERbrgASdxKp4onhqzKKq9v8j5V3AZmK7l2giQ3+
         eETzXr/Rf1RJ3eANnOagP3RZa3UhfZNsf5rm8ACF61huRkcFjN0w4w8VYgKbssPmXgT1
         OdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i8TvAllA57WxAU0LkM2JJVxBkvzCPw+8c6SMDZJxD/s=;
        b=sdWQRBg8w9+pAFW1nMfFKhlZG557iTYjKm5Ac6XemxvDzgSldIJ5qkLL0/Q4yq91gJ
         9U34M1RmD9EXZpWtV6UMrVXbdFmdYDSEy6Bt0sWpILDG/SmbnVCNlj5+/jiWktW0rmnW
         IwijQ3BQGe+IxC2kFIhE6No9NA3LD7yG3aJr5KdgTBJG4BzUcqo4i2NUyu9xsWMthk8w
         /RWfMi3HvA69sTqZIJM9cBzw+MrV5wqRZQf9UKsLjVLMHMZLrsIs2u0yyIJZBw9LBpvC
         8UFFBcGAu6ED8hGC9mDJkT0xT2q05bhj1KcPLpq++tFLjBKLoWQhVfw6UUaTP2numjg3
         tT0Q==
X-Gm-Message-State: APjAAAXrngNswUjGPZIji3dGhi2kEcqdhJ5y7yjcgNAdn4+zM2lQg9gH
        ZoRwe8FjWHT6gwEM4DWY8eQgZyaj
X-Google-Smtp-Source: APXvYqy6ao2KgssHGppMCP8Jw7qe8uwp4jg10RK8Gw2ebnkaMSpv6rb0KqDGruYmF3rEkRFIk8okfQ==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65mr2842315plb.313.1566977517249;
        Wed, 28 Aug 2019 00:31:57 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:56 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date:   Wed, 28 Aug 2019 16:31:25 +0900
Message-Id: <20190828073130.83800-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each cgroup is kept in the global cgroup_tree sorted by the inode
number.  Hist entries have cgroup ino number can compare it directly
and later it can be used to find a group name using this tree.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  | 15 +++++---
 tools/perf/util/machine.c |  7 ++++
 tools/perf/util/session.c |  4 +++
 4 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index f73599f271ff..8e4c26ea5078 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -12,6 +12,8 @@
 
 int nr_cgroups;
 
+static struct rb_root cgroup_tree = RB_ROOT;
+
 static int
 cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 {
@@ -249,3 +251,73 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+struct cgroup *cgroup__findnew(uint64_t ino, const char *path)
+{
+	struct rb_node **p = &cgroup_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct cgroup *cgrp;
+
+	while (*p != NULL) {
+		parent = *p;
+		cgrp = rb_entry(parent, struct cgroup, node);
+
+		if (cgrp->ino == ino)
+			return cgrp;
+
+		if (cgrp->ino < ino)
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
+	cgrp->ino = ino;
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
index 2ec11f01090d..11a8b187ec09 100644
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
+	u64			ino;
+	char			*name;
+	int			fd;
+	refcount_t		refcnt;
 };
 
-
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
 struct cgroup *cgroup__get(struct cgroup *cgroup);
@@ -26,4 +28,9 @@ void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
 int parse_cgroups(const struct option *opt, const char *str, int unset);
 
+struct cgroup *cgroup__findnew(uint64_t ino, const char *path);
+struct cgroup *cgroup__find_by_path(const char *path);
+
+void destroy_cgroups(void);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 61c35eef616b..33554e745e6b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -26,6 +26,7 @@
 #include "linux/hash.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include "cgroup.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -646,9 +647,15 @@ int machine__process_cgroup_event(struct machine *machine __maybe_unused,
 				  union perf_event *event,
 				  struct perf_sample *sample __maybe_unused)
 {
+	struct cgroup *cgrp;
+
 	if (dump_trace)
 		perf_event__fprintf_cgroup(event, stdout);
 
+	cgrp = cgroup__findnew(event->cgroup.ino, event->cgroup.path);
+	if (cgrp == NULL)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2cdce7ee228c..ffdd956d0a89 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -275,6 +275,8 @@ static void perf_session__release_decomp_events(struct perf_session *session)
 	} while (1);
 }
 
+extern void destroy_cgroups(void);
+
 void perf_session__delete(struct perf_session *session)
 {
 	if (session == NULL)
@@ -289,6 +291,8 @@ void perf_session__delete(struct perf_session *session)
 	if (session->data)
 		perf_data__close(session->data);
 	free(session);
+
+	destroy_cgroups();
 }
 
 static int process_event_synth_tracing_data_stub(struct perf_session *session
-- 
2.23.0.187.g17f5b7556c-goog

