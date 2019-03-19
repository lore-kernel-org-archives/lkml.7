Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5EF217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEDIRq0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCSX4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:56:47 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:34557 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfCSX4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:56:43 -0400
Received: by mail-qt1-f201.google.com with SMTP id x58so654764qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CF4+E5UIa39xAKg6YCWVn7zIouVA3+WI4DKW8uAVCQw=;
        b=JEDIRq0NpHszfqFfgtVD61U2sHtyH+5HwG104koBNiR1CVnOdbZIQ4T7vm1xgqB50H
         thW4tUOnS/p6aXoascAN+Dz6Gdx60R0hL2NJtBGym4V5OdgxsWlooDMVXhqauD5dvIf0
         9+CLQTjHPP5q5QCRpzsZTUK0lbWDcn9aM5ow9098GJcCbaDlHtZLL8xqoZoW3weRMuVU
         Kgiw2eXJz/3tDBSIvexT6rGnLTcBKSeiNpmE4SWVOOBbgwyWNVKTStkLtZKteam1R6sI
         KT563q/OieuZG9lPrc1cm2wdB93lDHzC3hFQkJ9EXZhD7gqcLNh6exFuVacN12aIAOqa
         yjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CF4+E5UIa39xAKg6YCWVn7zIouVA3+WI4DKW8uAVCQw=;
        b=DrlvoSXv+6XIAtjkfepG73rdHthUfCueBfhDiY8OOjfRdS3Pcpsbko2Nzrtm61J4I0
         DrszV1EcmgsGCUVTvZdyMfI1E00NWfN3y+uKE4/9UqMY1ugb7UsjpW3IYHkqb9lx681X
         UXg0C6UMh/JpLQAY9deVP3RTZguu+3E+xPgrVEdMkmkubQiQ4GM1CfGnsLX/xpX0vqd+
         KmwZA6I8chq+8J1SdStcF3gieesD1STF8oc/0xCkvzoPneFNu801T6lUZxfhSaS3AFj8
         WiS6Lh4xHyrFOfsbREw57slBvB6s+/CbLEOwGd0xvY6OKBzYfHmtkyRuVUn6vp2EQn9J
         e5ew==
X-Gm-Message-State: APjAAAVGnYEZTaCYXyG/BH0Nx2dPGWkP6PzNnz1cLWebXHKnoN4jI2kk
        nq0HYMsZ3CYxI+6kmQSGi2dIadQ+AdA=
X-Google-Smtp-Source: APXvYqwuz5jKuNXMD5ZfZA8ooeSpOd7bbNe9/PlToDa4czqg8Eac9fU4fj1gxy1+OtwlgZ9K0uuqCz4n/Cc=
X-Received: by 2002:ac8:277d:: with SMTP id h58mr4998590qth.31.1553039802970;
 Tue, 19 Mar 2019 16:56:42 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:56:18 -0700
In-Reply-To: <20190319235619.260832-1-surenb@google.com>
Message-Id: <20190319235619.260832-7-surenb@google.com>
Mime-Version: 1.0
References: <20190319235619.260832-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v6 6/7] refactor header includes to allow kthread.h inclusion
 in psi_types.h
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kthread.h can't be included in psi_types.h because it creates a circular
inclusion with kthread.h eventually including psi_types.h and complaining
on kthread structures not being defined because they are defined further
in the kthread.h. Resolve this by removing psi_types.h inclusion from the
headers included from kthread.h.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 drivers/spi/spi-rockchip.c | 1 +
 include/linux/kthread.h    | 3 ++-
 include/linux/sched.h      | 1 -
 kernel/kthread.c           | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 3912526ead66..cdb613d38062 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -15,6 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2c89e60bc752..0f9da966934e 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -4,7 +4,6 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
-#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -198,6 +197,8 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+struct cgroup_subsys_state;
+
 #ifdef CONFIG_BLK_CGROUP
 void kthread_associate_blkcg(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *kthread_blkcg(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1549584a1538..20b9f03399a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -26,7 +26,6 @@
 #include <linux/latencytop.h>
 #include <linux/sched/prio.h>
 #include <linux/signal_types.h>
-#include <linux/psi_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/rseq.h>
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5942eeafb9ac..be4e8795561a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -11,6 +11,7 @@
 #include <linux/kthread.h>
 #include <linux/completion.h>
 #include <linux/err.h>
+#include <linux/cgroup.h>
 #include <linux/cpuset.h>
 #include <linux/unistd.h>
 #include <linux/file.h>
-- 
2.21.0.225.g810b269d1ac-goog

