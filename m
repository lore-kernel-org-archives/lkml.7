Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A921530
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKmZgoHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfD2RNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:13:49 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53169 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfD2RNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:13:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id j49so10857084qtk.19
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eAfjg0nGPcLWfxJJhGXBjl7FIwajcYkmLSUZC9BoAVo=;
        b=FKmZgoHbVGCO97K3BcQ+ic4v++s8rwzSXFy75ckZdej+bpKpVXnUNuY3AXrL33BVgJ
         Hqz2qDXRzmxVtOoIbcV+h21LE3UduSmU2SvSZoF6iZ6fTU/Uda98vcUkpqI6iB9iB4m3
         ts6v/RxvQwZAPpQgbA2bqqm1snmfVmcGk/alcHvia2mC0gY7WxDx3MzXcsdnuqA/gMZJ
         XBYlW9aAVRGre8B6TOocT9qUo0Kl2vE6THP1e5dwTEiMa3I9hqxw/zuSjkYo1tPPGfr0
         F47SccgEZEd4YLwQlE/5seZLLVVmyOrAhtyFNqs1W697mP3Z5oznCNev6CK6HYxdQwla
         tG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eAfjg0nGPcLWfxJJhGXBjl7FIwajcYkmLSUZC9BoAVo=;
        b=ibDovIR4ZlsAsWo2EGO5NK1A8GIFfGCZ+vqMXFLiPHdbgkz2wgqDhRTHZ6YTbV5Es7
         uDZXdNclA4vvOYC1n7dATWGNkkvFLdtdTlpMhNCs18GOsmxCkGMQ+m40wN3/OxqNJA/Y
         po/IZGO+dpoeO2cujny6RR3oh6LfYiL0+lxIy0aRCVk6YvCCwhKt94coP+PzUpp+h2m9
         dHC18IfN4DFoB2K7d5WbX1T9OdCHThWcYKzrOLyYzUKTdk0erEzKFdlINBS4Gpl4//je
         kmtyZffnY3KEtIklbla2OpcrtfKbgDduxu0OpBrpgIwdJb5S+vQ74vHZIxsPuhvOWxm/
         zTlg==
X-Gm-Message-State: APjAAAVdrMEHoKCX8Axz8PbXS7Ln6fAIKlUln41dDt/GPT50pU7WWpBk
        bJAV1xri5xU4eWt6oRvnPIm0UVhIuXB9Fg==
X-Google-Smtp-Source: APXvYqwwgWs3zy3FLOkSJFSV4QCkVGyC8pGPoFtNLJRMe+t9+l0sHrdTDJroLj5qqsGFZEw5ucWIBmehPElR7Q==
X-Received: by 2002:a0c:c18d:: with SMTP id n13mr19796452qvh.109.1556558027954;
 Mon, 29 Apr 2019 10:13:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:13:31 -0700
Message-Id: <20190429171332.152992-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 1/2] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
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

The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
OOM killer will not be triggered and indeed the page alloc does not
invoke OOM killer for such allocations. However we do trigger memcg
OOM killer for __GFP_RETRY_MAYFAIL. Fix that. This flag will used later
to not trigger oom-killer in the charging path for fanotify and inotify
event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog since v1:
- commit message updated.

 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2713b45ec3f0..99eca724ed3b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
-	bool oomed = false;
 	enum oom_status oom_status;
 
 	if (mem_cgroup_is_root(memcg))
@@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_retries--)
 		goto retry;
 
-	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
+	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
 	if (gfp_mask & __GFP_NOFAIL)
@@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	switch (oom_status) {
 	case OOM_SUCCESS:
 		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
-		oomed = true;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
-- 
2.21.0.593.g511ec345e18-goog

