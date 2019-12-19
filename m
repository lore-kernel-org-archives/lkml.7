Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4321D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QbO79ZKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLSODc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:03:32 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45381 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:03:32 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so2225144qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/86+9PxURS1PQBnix3pheL2A04bXWYpuuyTROrqZ7Wc=;
        b=QbO79ZKawoP8XAcJckmP0LG2hZT4q1FdnrMZLFoYOT3jZ/DXYoP7/cZ3zGjQITWXli
         orBn76S7PlcbhEVk/utor6hoAwOi0RTW/Ug6UhTNdV4O63YzZwW02zwwGllgmGFPymnF
         4C8QSWH/KrLPhpn3rVW2D6GB7IZ3+ewdd/OaibPjFprU5j+H+OXySl0D5qdQZLpQJPbD
         e3ICOogCcrWEjrurnCP6xHtJFQ/UYv2WFoN56F//NDMh0n7gZIf8ntS+v/wYuZnpL5A3
         gEiahV3+f94dHTk2BxKmmEdvnIFkSok9nP/Lz1uMepqtG7oH/auLXAvJY/LJBLujzxpT
         Perg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/86+9PxURS1PQBnix3pheL2A04bXWYpuuyTROrqZ7Wc=;
        b=GP2Mz0He/BpewNmkrltfENsqVcSO0WTsFhaR8s53Cwnv6VQM0nhzGbVjriSEjhcQEo
         xeUQ42Mwyp7GSNTJzWYgK3BWEH29r7DLhufj5AP83+/C6/bfqSnaPiKmtLSISmTCI5Ew
         QhvkiwEp+bGBfnU0ubOY6Tb9MkdgBY5QvVLONNp7I1gLRIRc5HSNnkdbWY+g9hfDxAmi
         fjEfsr/m3jN+5VjbW5u7Sz9QaPmfyCgFZ+yEB0bwyozConENsV0tyqzKNCkfNCTWlgsu
         MelgfVyAkhh7oFO0Ls5EwxinY1+m5Wx6Ff4oAHeIp3yPhdSrTvgCOZpXN2vgYL8Dupgd
         +kKg==
X-Gm-Message-State: APjAAAXAYdaltU3CLy+XC0HAxJpY/H7kgUnhQHD09I/tTN1hWZTnhy2q
        yY9cv+O0ARAZ2IlyyJJR3+IrOw==
X-Google-Smtp-Source: APXvYqxxpuJ8KQrE88lbK5/DSzWzoqcsbFTaFZ5CHKJarEqp0VJsgk1k3I6MXvD0MTSPlyBP4/mlDw==
X-Received: by 2002:a0c:ffc8:: with SMTP id h8mr7807761qvv.146.1576764211430;
        Thu, 19 Dec 2019 06:03:31 -0800 (PST)
Received: from ovpn-122-120.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c6sm1726585qka.111.2019.12.19.06.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:03:30 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] sched/core: fix variable "delta" set but not used
Date:   Thu, 19 Dec 2019 09:03:14 -0500
Message-Id: <20191219140314.1252-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5443a0be6121 ("sched: Use fair:prio_changed() instead of
ad-hoc implementation") left behind an unused variable.

kernel/sched/core.c: In function 'set_user_nice':
kernel/sched/core.c:4507:16: warning: variable 'delta' set but not used
[-Wunused-but-set-variable]
  int old_prio, delta;
                ^~~~~

Fixes: 5443a0be6121 ("sched: Use fair:prio_changed() instead of ad-hoc implementation")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/sched/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15508c202bf5..1f6c094520e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4504,7 +4504,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio, delta;
+	int old_prio;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -4538,7 +4538,6 @@ void set_user_nice(struct task_struct *p, long nice)
 	set_load_weight(p, true);
 	old_prio = p->prio;
 	p->prio = effective_prio(p);
-	delta = p->prio - old_prio;
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-- 
2.21.0 (Apple Git-122.2)

