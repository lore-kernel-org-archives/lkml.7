Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C6C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2354822DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mAx89SzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfHUAO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:14:58 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:2981 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfHUAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:14:57 -0400
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 9460342C554;
        Tue, 20 Aug 2019 17:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1566346539;
        bh=9nvWetf9lqZs3dYeWxahRnA3U8FbuSbGvhyiG5L8URA=;
        h=From:To:Cc:Subject:Date;
        b=mAx89SzUhBPgIsHC15LD3TzdsSGZM2+XPBYX75qUCmMYCYzKMFsbLQ9cBjijLrhyt
         huG0P5qRAAdIxykc49TCKHRTt6IdpZjClY/xPoIbd0Xd38aDkNNbZy0fjH5pxuxI31
         wTzG2lMEU3xtygRGfcStEoUIRXG+fC11eG22isaGZUnFSfGOnbq8iTLgcJu/f/tSmI
         q7NHLw6C9A4HGen2lQF0e+c7Aci6XscxKjf65Von+tTx7Ce5J+ScwL8jZSaev7o4WX
         yWL5iNJhKP1x+Hi924ZayjEOz41i4Ak4Eu5UcZPO/KMrQjuXZ7G8nr0KcydkCAymR7
         JlPPPXhbG9a4g==
Received: from egc101.sjc.aristanetworks.com (unknown [172.20.210.50])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 90AE942C552;
        Tue, 20 Aug 2019 17:15:39 -0700 (PDT)
From:   Edward Chron <echron@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com,
        Edward Chron <echron@arista.com>
Subject: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process message
Date:   Tue, 20 Aug 2019 17:14:45 -0700
Message-Id: <20190821001445.32114-1-echron@arista.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For an OOM event: print oom_score_adj value for the OOM Killed process to
document what the oom score adjust value was at the time the process was
OOM Killed. The adjustment value can be set by user code and it affects
the resulting oom_score so it is used to influence kill process selection.

When eligible tasks are not printed (sysctl oom_dump_tasks = 0) printing
this value is the only documentation of the value for the process being
killed. Having this value on the Killed process message documents if a
miscconfiguration occurred or it can confirm that the oom_score_adj
value applies as expected.

An example which illustates both misconfiguration and validation that
the oom_score_adj was applied as expected is:

Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
 (systemd-udevd) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,
 shmem-rss:0kB oom_score_adj:1000

The systemd-udevd is a critical system application that should have an
oom_score_adj of -1000. Here it was misconfigured to have a adjustment
of 1000 making it a highly favored OOM kill target process. The output
documents both the misconfiguration and the fact that the process
was correctly targeted by OOM due to the miconfiguration. Having
the oom_score_adj on the Killed message ensures that it is documented.

Signed-off-by: Edward Chron <echron@arista.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..c781f73b6cd6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -884,12 +884,13 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
 	mark_oom_victim(victim);
-	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
+	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB oom_score_adj:%ld\n",
 		message, task_pid_nr(victim), victim->comm,
 		K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
 		K(get_mm_counter(victim->mm, MM_FILEPAGES)),
-		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
+		K(get_mm_counter(victim->mm, MM_SHMEMPAGES)),
+		(long)victim->signal->oom_score_adj);
 	task_unlock(victim);
 
 	/*
-- 
2.20.1

