Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0D4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B335227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816412;
	bh=Tir4ge4XiMFbY00u6g2lQUypQuv8oBiu/oGPAUPYWQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDORcQ5XgPv86CbN/jYRCIkBDHyOc5GLVSem6ml0L3R+YUdvbMzL5j++eI7JknQfD
	 TVKYEfEQ9ZOoJ4scA3qZ4+Qn2BybaYqLW4b3sUqv6vhRavIAHH8zLmvMH/esyX+khI
	 BADQnuwk/4KbBWYIkCh6TfNbQSovduWhfrdw1xwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLTEdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40515 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTEd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so4289620pgt.7;
        Thu, 19 Dec 2019 20:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txU66bRae5Pnays/Y7TNvTzKk7YtK0Vm5EPa+8dKIPQ=;
        b=Nb5U5QCfpQDji2cauROMLcGL7oV6T3iKNne7PLTRK2Qq/7V2nurZn3bcRkT1z30//H
         kZFZxpzQaPGQyR3H/ra9UJM2r0xxBD45useY4oZzrr8xmivfPFXsyz2mQMAuFZI3OVnq
         dH3uwaADs/3iusC8Yiyfv+vrXR+gulZq3SvK5MTbmwSsvsucVJGR5jOTBvlNg1jRxcUx
         mtjCvM8R/oZ52hyVIZ0dglGThUDfAi/cvvRGxxk6Q9lZKhWr3dZdgwYmmHI2LORPyXqY
         gGMaZFSSnt1v6oKu7ReDlrHwGNn8ufeVSz20kPPVk/+WarWeCiN2zZo7s/p6h2+23UJ0
         /l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=txU66bRae5Pnays/Y7TNvTzKk7YtK0Vm5EPa+8dKIPQ=;
        b=W7bpwxfG73PBakQB2bR9rw4Swp8mghhhayS079kQRfUu3dgPDLFAdd30ZlYhS3240m
         /u6VQ+Se3upOHQkeD2tQShiqFfVwz3OdE+BhKcefLaIwZxS3nJY7QSVXRvAjNxPMsJ4t
         Lgm9GvLkaJTJ6l7O48cyt7nKA4KOPl+MBscD9budzfr0A/ghwlkLY2WNaDiJBxFKAqv4
         sKGqIi7bTYLdlKA3Q6w7n6AGFwzm/lAz8w6Z3u5IIX1OoIPS7qISUnU7UjVPT2xcoVb7
         mdqxqcdfZtNtGtMkYI0dW/Cv7jUSBu81IoJWmOPFhHBiJ2FaUBoaQ0wczNlAcnH7q0fT
         42Ag==
X-Gm-Message-State: APjAAAVzFuQGluFFSrre6LfFzWtcIY3rHppfBlbVWOAoh3c1AHYfph8q
        t2SlYP8XynZF/RuBcgiRoAk=
X-Google-Smtp-Source: APXvYqxC+j1472p94kS7bb/j8GN0L3LkPqAEb/VtpALyWiHBINO8TuNRQyfQxI075dPziPLoEtn1pg==
X-Received: by 2002:a63:454a:: with SMTP id u10mr11666427pgk.248.1576816408562;
        Thu, 19 Dec 2019 20:33:28 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:27 -0800 (PST)
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
Subject: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Date:   Fri, 20 Dec 2019 13:32:48 +0900
Message-Id: <20191220043253.3278951-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
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
index 4881d4af3381..99d93f31732d 100644
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

