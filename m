Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ECC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76FF206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCn54CQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfL3TQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:16:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34199 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:16:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id z22so29474405ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2D2t+eSg4QG+s4jK6O1pZ5X/RZmpvggD5itTQSAD5wU=;
        b=lCn54CQu5YO9edKRzdlhiFDVb1Lu+wlktqN/uSZ1qzEUej2czty2dLQcP8wCNnfSXS
         bearQKxSDyBVvOvT9orrboNag58xow+bTU6n1LxUfT19xkhwUU/tA/sFCGG5yekYuvc7
         jQvWaOgtTGLJYiZcco9yCZuC0ZzCfA8aIJNtb918loeg4QuSBw0G8s5UzGEOvuGLsHTX
         9w+a2/QMf3rO1lt8WboOy82jaBMo8DuJAjz7jBxKDh6Oh7vfS8oQAwWQpllG3tnW5gjk
         ay+s/b69/5T1dHiLArN0CumJHu3IG/ZKB8Rs5MGGu7Oo0ExQlfIYwCXgKg+A0hX2aoKb
         5XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2D2t+eSg4QG+s4jK6O1pZ5X/RZmpvggD5itTQSAD5wU=;
        b=tWzz0RzYyyzmPTARvWmirHnnn9VOyc74358d2N61qGnuwEmgMoY/6eJBVLGCHyv9Od
         g+aMu+aaht2+4GARtcB8F0pU2L+ZayJ9zI+FdMjS74vmB4BQf+1suPqX6SB9H/Zl3b8O
         E0cpLN8eeouVlyqplgLV/MVE0YpUZJbwxM4UV84xUr6eBrPaMle3rKE1B8ogdJVuRmQm
         8EcRZNc2Br1QqLb8NnjK6zUsL758VBGE4Nj/EOODWQztNNeX5lOi4SyTBxDRCG2HuM+b
         NVr+8jJKuWprN8LU9Pg1oenyYC3E/ho2ySE1PkcqPH2Mtmfc2x94jYRm6qtFUlVacXNI
         fXoA==
X-Gm-Message-State: APjAAAW3ir5byjZLY/qEyTvgIEE9nwb1onEHrrf32ffg18hZVj3fpHdf
        Ej9hq7wu5LMF5WQQdzmeOKX4ADiSvvQ=
X-Google-Smtp-Source: APXvYqwQbW7GM/1og1qFIYXhk9BYNhR5LXeP1g7+F+E3JS+BKC1EgNjYtGtzZISMqSiMtxeC3JixHw==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr23559034ljj.90.1577733414069;
        Mon, 30 Dec 2019 11:16:54 -0800 (PST)
Received: from localhost.localdomain (188.146.101.166.nat.umts.dynamic.t-mobile.pl. [188.146.101.166])
        by smtp.gmail.com with ESMTPSA id b19sm13410788ljk.25.2019.12.30.11.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:16:53 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>,
        gregkh@linuxfoundation.org, tj@kernel.org
Subject: [PATCH] fs/kernfs/dir.c: Clean code by removing always true condition
Date:   Mon, 30 Dec 2019 20:16:28 +0100
Message-Id: <20191230191628.21099-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously there was an additional check if variable pos is not null.
However, this check happens after entering while loop and only then,
which can happen only if pos is not null.
Therefore the additional check is redundant and can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 fs/kernfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9d96e6871e1a..9aec80b9d7c6 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1266,7 +1266,7 @@ void kernfs_activate(struct kernfs_node *kn)
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (!pos || (pos->flags & KERNFS_ACTIVATED))
+		if (pos->flags & KERNFS_ACTIVATED)
 			continue;
 
 		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
-- 
2.17.1

