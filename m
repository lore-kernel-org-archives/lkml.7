Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57372C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D08205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370282;
	bh=wRgNnsUMuvIVi/FLmXur1Evnh5aMf79zihpS+9xCeT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WpgHS5JULwT7cjcy2izSrxQKPora2hb4g7rzasTIHkua5h+feFrShX4mOSinuHtKl
	 C2qfySUDn4kh8zimkEc5uWZEE6XdAzzrr7WU9Tx2ZnJMq33se+/2wfsDrefpaYPsZ1
	 xtzkgXmeYoJZq7z6VGc0blTLvXRNDnnTNYk3SpHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfDDJJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfDDJJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D37C2075E;
        Thu,  4 Apr 2019 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368962;
        bh=wRgNnsUMuvIVi/FLmXur1Evnh5aMf79zihpS+9xCeT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbu/+Fvp5ZyHI+pYNalCTjqVDsaUn/i5GVqIxG2jSoyDS76/88+/vZ5yV6039WKq7
         APqZP1gfKxNAwzZutPxJBFyNW4je7KkRc5LWqK7N8Gny53OayTBFEF6Ee5m+HcvWoF
         l+r6GcJypvmfecPzGiZnKs4pvSnm0JkRefUf176w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 032/246] memcg: killed threads should not invoke memcg OOM killer
Date:   Thu,  4 Apr 2019 10:45:32 +0200
Message-Id: <20190404084620.204840918@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7775face207922ea62a4e96b9cd45abfdc7b9840 ]

If a memory cgroup contains a single process with many threads
(including different process group sharing the mm) then it is possible
to trigger a race when the oom killer complains that there are no oom
elible tasks and complain into the log which is both annoying and
confusing because there is no actual problem.  The race looks as
follows:

P1				oom_reaper		P2
try_charge						try_charge
  mem_cgroup_out_of_memory
    mutex_lock(oom_lock)
      out_of_memory
        oom_kill_process(P1,P2)
         wake_oom_reaper
    mutex_unlock(oom_lock)
    				oom_reap_task
							  mutex_lock(oom_lock)
							    select_bad_process # no victim

The problem is more visible with many threads.

Fix this by checking for fatal_signal_pending from
mem_cgroup_out_of_memory when the oom_lock is already held.

The oom bypass is safe because we do the same early in the try_charge
path already.  The situation migh have changed in the mean time.  It
should be safe to check for fatal_signal_pending and tsk_is_oom_victim
but for a better code readability abstract the current charge bypass
condition into should_force_charge and reuse it from that path.  "

Link: http://lkml.kernel.org/r/01370f70-e1f6-ebe4-b95e-0df21a0bc15e@i-love.sakura.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memcontrol.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b32389..79a7d2a06bba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -248,6 +248,12 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
+static inline bool should_force_charge(void)
+{
+	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
+		(current->flags & PF_EXITING);
+}
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -1389,8 +1395,13 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	};
 	bool ret;
 
-	mutex_lock(&oom_lock);
-	ret = out_of_memory(&oc);
+	if (mutex_lock_killable(&oom_lock))
+		return true;
+	/*
+	 * A few threads which were not waiting at mutex_lock_killable() can
+	 * fail to bail out. Therefore, check again after holding oom_lock.
+	 */
+	ret = should_force_charge() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
 }
@@ -2209,9 +2220,7 @@ retry:
 	 * bypass the last charges so that they can exit quickly and
 	 * free their memory.
 	 */
-	if (unlikely(tsk_is_oom_victim(current) ||
-		     fatal_signal_pending(current) ||
-		     current->flags & PF_EXITING))
+	if (unlikely(should_force_charge()))
 		goto force;
 
 	/*
-- 
2.19.1



