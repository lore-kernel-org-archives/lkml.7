Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165EFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1C92146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDqeaeSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfDERsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:48:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42763 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfDERrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so3447626pgh.9;
        Fri, 05 Apr 2019 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Xwgw7oNRWc5QUjdIzS9HWKC+CrbutV7TwPIITbbDd4=;
        b=XDqeaeSnd2hPunQJv8l1EwYu+c818r6D50Dm5yMr6X0anpwLI1ih2M5mjd9pkF2Fjv
         +pnI4yAVsepRQ4w8wNmvSUBUGMtA3JQ4C4m7VF2irPc7ACPEEPSAnlasFp978zTu2vHE
         C+E5kA5Kf5iJRYpPulrRj7cv4MjjxSSS3kxJMSknmy5oytN/V5z2+trE17uoFb8nt4TR
         6I3s4t3NAWtn5/8Dqg9kVEdsroQrJeeq/plurZSLRxrOOyLN6r0+TOmvYG0Doi5W0bct
         uP7VcTKdZN8E/wg0mibnD1x/X1s59oXpcXGxtu0WmYvq1JufuqFX87vgpJY1UvEcSLLH
         rUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Xwgw7oNRWc5QUjdIzS9HWKC+CrbutV7TwPIITbbDd4=;
        b=jvcl30UyuRHVyPeFuH9iOKyFH7tFhi8uZRVYdOtwdBB2PDikvpcVlwAdmuwIC0Xwel
         wf9v8pPRbIkc5ICkWeeE2EbZ1Fkcc/lKD5+adx3WwuLzpJBAleZvNmuaOWbLqGKWqQm1
         /fY5fML5i1efbQ2TvyVG/tEDU2MEC/3L0WRejvifJgeqFbXZCkMJ5LOs1MjXhnfBeJfO
         /L4w01aSNWx7XFVidVTafcIeXKaQPV8QUzzEtqvNtcKQI+XkOA7j/cStwUbKsrYMOMXt
         V6xRaTWV2QFt8TvhbiUtMEnwBdHdwg+WR80FaG+xRFd3XGpII8oWQPJFcGMA0B8BMkdh
         lSZg==
X-Gm-Message-State: APjAAAXhcdcjtrckpOlPBqVv2p7tLglbcc4YkytJi036aBsnzGB5tWD0
        UFmVFXm+ycQNhnoBsqfwpCNuiTISd6E=
X-Google-Smtp-Source: APXvYqypKVMwDNnzn8M0SFFjQ6aY3XF1kQ3uwiC3wVSg8UcK3hqQWTCBzcMivEzWALHfizd5ewxJzA==
X-Received: by 2002:a63:4620:: with SMTP id t32mr13252675pga.363.1554486462092;
        Fri, 05 Apr 2019 10:47:42 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:41 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 8/9] cgroup: add tracing points for cgroup v2 freezer
Date:   Fri,  5 Apr 2019 10:47:07 -0700
Message-Id: <20190405174708.1010-9-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cgroup:cgroup_freeze and cgroup:cgroup_unfreeze events,
which are using the existing cgroup tracing infrastructure.

Add the cgroup_event event class, which is similar to the cgroup
class, but contains an additional integer field to store a new
value (the level field is dropped).

Also add two tracing events: cgroup_notify_populated and
cgroup_notify_frozen, which are raised in a generic way using
the TRACE_CGROUP_PATH() macro.

This allows to trace cgroup state transitions and is generally
helpful for debugging the cgroup freezer code.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/trace/events/cgroup.h | 55 +++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c        |  2 ++
 kernel/cgroup/freezer.c       | 15 +++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index a401ff5e7847..a566cc521476 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -103,6 +103,20 @@ DEFINE_EVENT(cgroup, cgroup_rename,
 	TP_ARGS(cgrp, path)
 );
 
+DEFINE_EVENT(cgroup, cgroup_freeze,
+
+	TP_PROTO(struct cgroup *cgrp, const char *path),
+
+	TP_ARGS(cgrp, path)
+);
+
+DEFINE_EVENT(cgroup, cgroup_unfreeze,
+
+	TP_PROTO(struct cgroup *cgrp, const char *path),
+
+	TP_ARGS(cgrp, path)
+);
+
 DECLARE_EVENT_CLASS(cgroup_migrate,
 
 	TP_PROTO(struct cgroup *dst_cgrp, const char *path,
@@ -149,6 +163,47 @@ DEFINE_EVENT(cgroup_migrate, cgroup_transfer_tasks,
 	TP_ARGS(dst_cgrp, path, task, threadgroup)
 );
 
+DECLARE_EVENT_CLASS(cgroup_event,
+
+	TP_PROTO(struct cgroup *cgrp, const char *path, int val),
+
+	TP_ARGS(cgrp, path, val),
+
+	TP_STRUCT__entry(
+		__field(	int,		root			)
+		__field(	int,		id			)
+		__field(	int,		level			)
+		__string(	path,		path			)
+		__field(	int,		val			)
+	),
+
+	TP_fast_assign(
+		__entry->root = cgrp->root->hierarchy_id;
+		__entry->id = cgrp->id;
+		__entry->level = cgrp->level;
+		__assign_str(path, path);
+		__entry->val = val;
+	),
+
+	TP_printk("root=%d id=%d level=%d path=%s val=%d",
+		  __entry->root, __entry->id, __entry->level, __get_str(path),
+		  __entry->val)
+);
+
+DEFINE_EVENT(cgroup_event, cgroup_notify_populated,
+
+	TP_PROTO(struct cgroup *cgrp, const char *path, int val),
+
+	TP_ARGS(cgrp, path, val)
+);
+
+DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
+
+	TP_PROTO(struct cgroup *cgrp, const char *path, int val),
+
+	TP_ARGS(cgrp, path, val)
+);
+
 #endif /* _TRACE_CGROUP_H */
 
 /* This part must be outside protection */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6895464b54c6..57edcf398d71 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -816,6 +816,8 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 			break;
 
 		cgroup1_check_for_release(cgrp);
+		TRACE_CGROUP_PATH(notify_populated, cgrp,
+				  cgroup_is_populated(cgrp));
 		cgroup_file_notify(&cgrp->events_file);
 
 		child = cgrp;
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 9d8cda478fc9..3bfbb3c8baf3 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -6,6 +6,8 @@
 
 #include "cgroup-internal.h"
 
+#include <trace/events/cgroup.h>
+
 /*
  * Propagate the cgroup frozen state upwards by the cgroup tree.
  */
@@ -28,6 +30,7 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 			    cgrp->nr_descendants) {
 				set_bit(CGRP_FROZEN, &cgrp->flags);
 				cgroup_file_notify(&cgrp->events_file);
+				TRACE_CGROUP_PATH(notify_frozen, cgrp, 1);
 				desc++;
 			}
 		} else {
@@ -35,6 +38,7 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 			if (test_bit(CGRP_FROZEN, &cgrp->flags)) {
 				clear_bit(CGRP_FROZEN, &cgrp->flags);
 				cgroup_file_notify(&cgrp->events_file);
+				TRACE_CGROUP_PATH(notify_frozen, cgrp, 0);
 				desc++;
 			}
 		}
@@ -73,6 +77,7 @@ void cgroup_update_frozen(struct cgroup *cgrp)
 		clear_bit(CGRP_FROZEN, &cgrp->flags);
 	}
 	cgroup_file_notify(&cgrp->events_file);
+	TRACE_CGROUP_PATH(notify_frozen, cgrp, frozen);
 
 	/* Update the state of ancestor cgroups. */
 	cgroup_propagate_frozen(cgrp, frozen);
@@ -189,6 +194,11 @@ static void cgroup_do_freeze(struct cgroup *cgrp, bool freeze)
 		clear_bit(CGRP_FREEZE, &cgrp->flags);
 	spin_unlock_irq(&css_set_lock);
 
+	if (freeze)
+		TRACE_CGROUP_PATH(freeze, cgrp);
+	else
+		TRACE_CGROUP_PATH(unfreeze, cgrp);
+
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((task = css_task_iter_next(&it))) {
 		/*
@@ -312,6 +322,9 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 	 * In both cases it's better to notify a user, that there is
 	 * nothing to wait for.
 	 */
-	if (!applied)
+	if (!applied) {
+		TRACE_CGROUP_PATH(notify_frozen, cgrp,
+				  test_bit(CGRP_FROZEN, &cgrp->flags));
 		cgroup_file_notify(&cgrp->events_file);
+	}
 }
-- 
2.20.1

