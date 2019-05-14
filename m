Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA83C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5BB20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMT1RFNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfENVX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:23:26 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:36658 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfENVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:23:24 -0400
Received: by mail-ot1-f74.google.com with SMTP id f92so185738otb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/OYdIOpBJWCaBVUA2Ic/FHOWBWsqkzG28ElRwkV1PdY=;
        b=sMT1RFNIRx5Pslx1X+QRbggc6ZXdETqqUAmpYgQSfraDuAQ8m+rCMJk9uGbN6XrtHs
         tNkvdtsnGfHoH0GanvDXD+Fs6bm/IXQXFezj+d5P3ki8zYgnqAS/EoN5nDZJYNmbLDDZ
         AD+gARqdfYcjkA8KcwkxfSVO5a9PAtkxFAxt3FbP4bS2eGGNq3CxcOuewuBwbiFTdBqU
         r7UgPx4uwRpQE1MDB1pPgHNp+1PjjD8hA3bPI3U9YQ0+0oF6F4BpTGINJsrUutnPzVQ4
         YwgfaJcSrkTC6Jzttdasq2d0xMgnfgYbpVVOKTamjEKDeaSR84z3dR/se+nCH6uaSBCN
         i3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/OYdIOpBJWCaBVUA2Ic/FHOWBWsqkzG28ElRwkV1PdY=;
        b=r+MKWO1WorxgFy8OyngmAAwgwcLZJfNPW/ZX/px4IKzxmZcrNoEGylSlnLEYdcb5wy
         jKHgFNYOu7J/aWXUrfoqcdhbNafd5G9Br6K+zUpYtHfKnEn0RZlgP3HH2V6CtOy7MrQ/
         Cog+iKIyytZdbo+Mp9ynmewwvBYANOpdoytI99IZHmCymcA0D3eu5OtqcpngaDLrrBF8
         80GimypKhzunKUztluDAGuYTRWlW28wpXdUV0mIMeXP5yioH+GOAPaeStDoRGRCxJxuW
         ZQUxTQffKNdJFwWrq6yP7IEo8uhJNb1jbx2Gua0MxMh6OIU7m4VKw85lcVr9KAb+dgdG
         Uf1A==
X-Gm-Message-State: APjAAAVtzuVpgb3uAbKjbE7exGZx8mtyZS3eMF63JRCvZDxkEl665uB6
        ynjvb5qGsliHE/FdGPhl6JQobVcbuEscrw==
X-Google-Smtp-Source: APXvYqym1Fqm5pNm2/VExHxbmxANidF+rxgp75ZamTBrHNj9XD2E4iXLCfQcbSoRxPswid69DBp+ecjJ3EluAg==
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr121436oti.219.1557869003332;
 Tue, 14 May 2019 14:23:23 -0700 (PDT)
Date:   Tue, 14 May 2019 14:22:59 -0700
In-Reply-To: <20190514212259.156585-1-shakeelb@google.com>
Message-Id: <20190514212259.156585-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190514212259.156585-1-shakeelb@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
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
Reviewed-by: Roman Gushchin <guro@fb.com>
---
Changelog since v2:
- updated the comments.

Changelog since v1:
- Fixed usage of __GFP_RETRY_MAYFAIL flag.

 fs/notify/fanotify/fanotify.c        | 5 ++++-
 fs/notify/inotify/inotify_fsnotify.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..8047d2fd4f27 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -288,10 +288,13 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
-	 * memory is short.
+	 * memory is short. For the limited size queues, avoid OOM killer in the
+	 * target monitoring memcg as it may have security repercussion.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
+	else
+		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
 	memalloc_use_memcg(group->memcg);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index ff30abd6a49b..ca1a9dfff0b5 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -99,9 +99,13 @@ int inotify_handle_event(struct fsnotify_group *group,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
-	/* Whoever is interested in the event, pays for the allocation. */
+	/*
+	 * Whoever is interested in the event, pays for the allocation. Do not
+	 * trigger OOM killer in the target monitoring memcg as it may have
+	 * security repercussion.
+	 */
 	memalloc_use_memcg(group->memcg);
-	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
+	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	memalloc_unuse_memcg();
 
 	if (unlikely(!event)) {
-- 
2.21.0.1020.gf2820cf01a-goog

