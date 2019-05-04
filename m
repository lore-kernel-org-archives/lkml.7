Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D458FC04AAA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59B720862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFtjqSrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEDOww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:52:52 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49048 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:52:51 -0400
Received: by mail-qt1-f201.google.com with SMTP id d39so9442068qtc.15
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q+yvnmyjVEzdFHEWBcoadDmmU/3yK5ganIOIoyEwouc=;
        b=qFtjqSrcM4UGgRoJ8/RzfeaVyMan+d7Ts2pByis/59NTZYLaxr1drG0H5BJleMrsrh
         MfXyUTFpANjtUv9d/3lln9gmv0JiZwKgSmPn/unKXf6ckvtwaiukK2EpBgYXSp2zaMVT
         oBZSmqvUFGBLW+493GEBswqRKrbAhreW7h3pvJZKJyvSY9xqc6PSChOyIBpwKVl7OcOV
         OYC8eGUnH5wq7H0Hf6xM8doNcgTcKdvF+OGgfSn2qK2KmkPDC1b9x7Pj9K9UegrblR69
         dmm+H2DsQQ2Abc1ZsllHD5tiuI6keEcXuEUtH1k4JAzFM/AERoSNSFeerIz2sPD+jA9M
         2gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q+yvnmyjVEzdFHEWBcoadDmmU/3yK5ganIOIoyEwouc=;
        b=rotXRxheaNQAlMrhzP2q0G51XB8mY7LOVy4Pda6KKcJYy/5poNAIo8LSRVay04Qz65
         EcdGr3uWcjFCW3qR1Fj665GkYmk3/uhBY/iocgZjf0nHhZDkCbk76kFEGYdgbNYCdxMq
         oyEH85iOthz0v6IcwcNPoo9NkIbTXPF2E9J0PxlqZNaktDT2zg/Ow7uO1GG0J7Q2EpQr
         BKFgbZrIR0l4czQcUnNnP6kNax+qjxAa6tjonDH9vWjAewIferEWUrwNiPN28uhpw06w
         dRceUWxgT9x3wYRDKkGA6P1h3ehSz7dOvT2uqpmjLk4uPxQ1zgHmewsVfZpvm6zieInS
         hZZQ==
X-Gm-Message-State: APjAAAV4jOIGiXkodBSusT6gLQaBLxbZ9uw9P8fgMglbIqqovY6e3CCV
        XC6d7K6Pr6oK/+NFwQneED9MaOAuLjy0VQ==
X-Google-Smtp-Source: APXvYqzaEcIiqQDURcZKk/Ciux9eOBC26QDYKJQb+X0sd9obaCdABR9WDozc3I83/n6peCeKM9N158e14DQdFQ==
X-Received: by 2002:a05:620a:1015:: with SMTP id z21mr3134470qkj.229.1556981570541;
 Sat, 04 May 2019 07:52:50 -0700 (PDT)
Date:   Sat,  4 May 2019 07:52:42 -0700
Message-Id: <20190504145242.258875-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] memcg, fsnotify: no oom-kill for remote memcg charging
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
__GFP_RETRY_MAYFAIL to the fanotigy and inotify event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v1:
- Fixed usage of __GFP_RETRY_MAYFAIL flag.

 fs/notify/fanotify/fanotify.c        | 5 ++++-
 fs/notify/inotify/inotify_fsnotify.c | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..f78fd4c8f12d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -288,10 +288,13 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
-	 * memory is short.
+	 * memory is short. Also make sure to not trigger OOM killer in the
+	 * target memcg for the limited size queues.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
+	else
+		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
 	memalloc_use_memcg(group->memcg);
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
2.21.0.1020.gf2820cf01a-goog

