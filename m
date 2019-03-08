Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135BE20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1B9mpz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfCHSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:43 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:55065 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfCHSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:40 -0500
Received: by mail-vk1-f202.google.com with SMTP id b123so9823709vka.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CEhrqtVYU2GGjH6ppRjAuHHm7jjOcyih+GpEA+oebn8=;
        b=c1B9mpz6Jdou6pRY5OyrvSpDJl27rnNzP0KEjEWa2lnSzKi/TY8GKvZho04eqIPWmf
         Mbevkjhd2kB1p4b+u2RldlGvn2Q8iDTxMc777xOikyWl3V3hnX65J+i46DkaENmm3zXP
         ozcooURxLG/exN3rOJjFJdR1Ogw7wIrCqH2mzI50xZsiMCTvriahuZwLjq2O1Cljiul0
         K0ygd6c+lQS5P2P2rKrX8m+cmDot+mdoua/nr3GSl9KtOOGf5I97XVGRs4twCtOTiwdC
         aQoZP+Pvr8fOhYrbuPvxicE4lRRk5dgLyBHNiYroYQyHmB/+K5WjqAJKLwrTKLEZiYWj
         0MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CEhrqtVYU2GGjH6ppRjAuHHm7jjOcyih+GpEA+oebn8=;
        b=M+5Er33rnYIvZAznMzCP++IOjWkPOE35sqLNsjdj+utBghtcgpQDFbkVPl/C0WeDJK
         +elC3A23JfNshoZRPBtcD4H33Yf1RiMOQffsMvdkeUGuR+ByCmbmObYqxggUr6zibkQN
         xEig25lYMP6BoUM90z4iOcAuAxwblubpPbEWDCmXsUxupyyxDKJPZBfHwa3ZUKfwIGOz
         8PfeUQ9dKte/4DdQNScNMJFxg/10Dn+1VvhQecgIZ5lNI3l7Jn5RDFezBSjWs+/DZ1ei
         isKa9YIIZl5M0wKqR1MZYHLxPSH7cfP4rkXGXUXxUPsh8e73k9PmhHU10sx4du7NzxtK
         dyqA==
X-Gm-Message-State: APjAAAXi5f6IxXSjaqHAIacYwS+Aidet/Z0SKYGviMg7EmoPnOvNQbUm
        jfV5OeFccbjvtCKUpljFa2s+I2MFmio=
X-Google-Smtp-Source: APXvYqwN0/Nf7GBGjuQW1wdXf6SKvccB1lEA9aOmPCgozi8YOkJIIOWvh+1BhGa6Czel6AwwlTaUyObxUrY=
X-Received: by 2002:a1f:7d06:: with SMTP id y6mr12317055vkc.19.1552070619702;
 Fri, 08 Mar 2019 10:43:39 -0800 (PST)
Date:   Fri,  8 Mar 2019 10:43:10 -0800
In-Reply-To: <20190308184311.144521-1-surenb@google.com>
Message-Id: <20190308184311.144521-7-surenb@google.com>
Mime-Version: 1.0
References: <20190308184311.144521-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v5 6/7] refactor header includes to allow kthread.h inclusion
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
 include/linux/kthread.h | 3 ++-
 include/linux/sched.h   | 1 -
 kernel/kthread.c        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

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
2.21.0.360.g471c308f928-goog

