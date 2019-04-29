Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8AAC04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7720675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LNHMaVmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfD2ROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:14:04 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39041 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfD2ROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:14:04 -0400
Received: by mail-pf1-f201.google.com with SMTP id a17so7598101pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJZw+a1zAAS2yXCulVsapzFNzx2HgPG8quVXkMNIzRA=;
        b=LNHMaVmcposMzXiBxo+LfVRrsXl/hzH7pjhT+t1iPGrPl3ttT6JqRtwLI+LmJZzfO3
         6dooMjOh7leRjuHd+y/PjbfED8ng26vganF2W2sFFNwLnXk6AO6Gnk27hUJRFq6vMHnD
         V/8GhLSaHioBm8HlcVfQcAoSlyZLZXgu6P3IdkSFLTkVAt1kTaAXh3IygzCUzwkRkMO2
         ABs/JrSSCGKRasEP9mu0SQTJMLHuHvq8LSeIkgusJW0LAXLmHG7xmCeCdF9OyEsbz3k2
         Ag2CxRX2t31eXoE9nTs+JsO7/i88GZiSYPqm/ZR7APmhOvzuNg5tIpU4XhI4eSSqDaiw
         t5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJZw+a1zAAS2yXCulVsapzFNzx2HgPG8quVXkMNIzRA=;
        b=bHAjoVIhzRM7z0Y1kZ4sgcMJ6LAlSW5C8AtJItVoJ2KwFB0LjwMgVJr+RNkiFzvbrA
         yozGpb4Q1WqD3OaHSe/MfmDkHdCdMMsVwSHRy+GaLTK4RJF7BzDEVDVkerkp5WRxcgHY
         FjJQgzdlxCT6q1UPX6R308LnHoOWKnkxoGDiNZUUrO48TAMwDy+pPBmTcFiH0HZ8O5yM
         WtHACi/lR8duQ6GzJlwQsX3B7a4I5qUq46HRoaGy70H59VDlBaIuPER10+CobQPWQLV8
         3lK1+0FUNhRbsbPRXM/w3uPm6AgSpqejLN80Mcvj/w2d05N0cM+yTe/W34H3Mbd8tUGO
         XXZQ==
X-Gm-Message-State: APjAAAXrdqZ6OvpSPAlmJSYozlXC65XSVh5snzWXOp1k88Lgy8BydIg7
        eVpPZ5T+kbl5uDmuQ0WTTrKoI9lG64uxnA==
X-Google-Smtp-Source: APXvYqzTjNvJrvL+jBUcp6W9VnuxIBNtyu3+LblRTc2xOWy1Rbb1xQgUwgBIVo88fNW8fifpkQ8drzhLbu6dhw==
X-Received: by 2002:a65:5941:: with SMTP id g1mr60655155pgu.51.1556558043109;
 Mon, 29 Apr 2019 10:14:03 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:13:32 -0700
In-Reply-To: <20190429171332.152992-1-shakeelb@google.com>
Message-Id: <20190429171332.152992-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190429171332.152992-1-shakeelb@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d46eb14b735b ("fs: fsnotify: account fsnotify metadata to
kmemcg") added remote memcg charging for fanotify and inotify event
objects. The aim was to charge the memory to the listener who is
interested in the events but without triggering the OOM killer.
Otherwise there would be security concerns for the listener. At the
time, oom-kill trigger was not in the charging path. A parallel work
added the oom-kill back to charging path i.e. commit 29ef680ae7c2
("memcg, oom: move out_of_memory back to the charge path"). So to not
trigger oom-killer in the remote memcg, explicitly add
__GFP_RETRY_MAYFAIL to the fanotify and inotify event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/notify/fanotify/fanotify.c        | 4 +++-
 fs/notify/inotify/inotify_fsnotify.c | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..9aa5d325e6d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -282,13 +282,15 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    __kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
-	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
 	 * memory is short.
+	 *
+	 * Note: __GFP_NOFAIL takes precedence over __GFP_RETRY_MAYFAIL.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index ff30abd6a49b..17c08daa1ba7 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -99,9 +99,12 @@ int inotify_handle_event(struct fsnotify_group *group,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
-	/* Whoever is interested in the event, pays for the allocation. */
+	/*
+	 * Whoever is interested in the event, pays for the allocation. However
+	 * do not trigger the OOM killer in the target memcg.
+	 */
 	memalloc_use_memcg(group->memcg);
-	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
+	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	memalloc_unuse_memcg();
 
 	if (unlikely(!event)) {
-- 
2.21.0.593.g511ec345e18-goog

