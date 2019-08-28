Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF29AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB520679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfH1Ciq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:38:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:42206 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfH1Ciq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:38:46 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id C8DE32C0026731BBC7D6;
        Wed, 28 Aug 2019 10:38:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x7S2cSgM036933;
        Wed, 28 Aug 2019 10:38:28 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019082810384754-3227041 ;
          Wed, 28 Aug 2019 10:38:47 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        shakeelb@google.com, yuzhoujian@didichuxing.com,
        jglisse@redhat.com, ebiederm@xmission.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH] mm/oom_kill.c: fox oom_cpuset_eligible() comment
Date:   Wed, 28 Aug 2019 10:38:49 +0800
Message-Id: <1566959929-10638-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-08-28 10:38:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-08-28 10:38:31,
        Serialize complete at 2019-08-28 10:38:31
X-MAIL: mse-fl2.zte.com.cn x7S2cSgM036933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac311a14c682 ("oom: decouple mems_allowed from oom_unkillable_task")
changed the function has_intersects_mems_allowed() to
oom_cpuset_eligible(), but didn't change the comment meanwhile.

Let's fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a..65c092e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -73,7 +73,7 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 /**
  * oom_cpuset_eligible() - check task eligiblity for kill
  * @start: task struct of which task to consider
- * @mask: nodemask passed to page allocator for mempolicy ooms
+ * @oc: pointer to struct oom_control
  *
  * Task eligibility is determined by whether or not a candidate task, @tsk,
  * shares the same mempolicy nodes as current if it is bound by such a policy
-- 
1.8.3.1

