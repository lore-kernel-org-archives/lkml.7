Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23116CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23EA21920
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNIhRIVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJ2Ay2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:54:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38336 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfJ2Ay2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:54:28 -0400
Received: by mail-qk1-f202.google.com with SMTP id 64so9713665qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CJNyfCkSt7mazdpKxm+NauccC7aNCXbzHO2WmG+WXZI=;
        b=VNIhRIVznNTE4231t1PB9Y892IckjdElWezZZVpfEZj80/mzanDBafaCAPwbWdo/2+
         A2IlnsRAL2Blt3IvIwX0ISb+ZmFwG9yrBZ55rX1/xuj9NUAqSD3FHneUmyprKlV5yl3q
         tTlgF3TG2RXMaFaXAlfpSDe9OiAODZDJ/pnsUOZfcjt++CXArvZZTjQ5fY2m5Jz4KDJj
         UImudqlau9RYfYGT+aEy1/m9RTwJwhjIFgij71FJyZX0avIJ5/L6Yy34dJ5ovk87MzOg
         vpUccTmI91a3yMxtIvMawk0rByNgb7F2mUfDUfz6Bqs+0lifTZdjCcjDQGftK7LTeiXB
         t6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CJNyfCkSt7mazdpKxm+NauccC7aNCXbzHO2WmG+WXZI=;
        b=j3ZRf6cRMMdwq4VuGTlYlOKt+pBv+9odPRayXVRczixCm3rmJCk7Ui3HZN3SBZZETR
         m+vUgWeel4vQqn5j40g9rKW6dv3/TwOvKSgx5f2U2eV/Ck0d13UZGBmRoquxB9rATql9
         aYyGyLd8pjkVYvMgr9ZG6r6SGlmog55zOfaQRH6u+7uIO0Gr4N3kAlq0MbZdPx0tPZZ/
         /vxSzcbUouPsG1pPgY+y9U7gdEevPh5qjKYcz96ZBnnOij4ryUujWVMvBfWd6Se5utoh
         T4MhjX7BG+4W1+dtUUwObttfoeghS3XBQTMdoiE4xFMObVaKu6Wsw89RLk3UFKy0IhOj
         3mEg==
X-Gm-Message-State: APjAAAUaMYCYn1sZu2C2qd33wyWgFHdLzS3hA44KAxru+Bdce54D+Lmf
        tMo7Ti4iUaVUTPV/5UB9726g9t14yYmisg==
X-Google-Smtp-Source: APXvYqyuC1vSPb0iXXoyj+RX6tq0hHQYQPJSlVZL8/Xu5SdTk1tHt39Bxai/8EbXawqb+7npXxeAku+T+G4lIw==
X-Received: by 2002:a37:9d15:: with SMTP id g21mr4415148qke.71.1572310467233;
 Mon, 28 Oct 2019 17:54:27 -0700 (PDT)
Date:   Mon, 28 Oct 2019 17:54:05 -0700
Message-Id: <20191029005405.201986-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] mm: memcontrol: fix data race in mem_cgroup_select_victim_node
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported the following bug:

BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node

write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
 mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
 try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
 reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
 mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
 prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
 swapgs_restore_regs_and_return_to_usermode+0x0/0x40

read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
 mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
 try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
 reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
 mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
 prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
 swapgs_restore_regs_and_return_to_usermode+0x0/0x40

mem_cgroup_select_victim_node() can be called concurrently which reads
and modifies memcg->last_scanned_node without any synchrnonization. So,
read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
to stop potential reordering.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: Greg Thelen <gthelen@google.com>
Reported-by: syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4c555055a72..5a06739dd3e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1667,7 +1667,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
 	int node;
 
 	mem_cgroup_may_update_nodemask(memcg);
-	node = memcg->last_scanned_node;
+	node = READ_ONCE(memcg->last_scanned_node);
 
 	node = next_node_in(node, memcg->scan_nodes);
 	/*
@@ -1678,7 +1678,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
 	if (unlikely(node == MAX_NUMNODES))
 		node = numa_node_id();
 
-	memcg->last_scanned_node = node;
+	WRITE_ONCE(memcg->last_scanned_node, node);
 	return node;
 }
 #else
-- 
2.24.0.rc0.303.g954a862665-goog

