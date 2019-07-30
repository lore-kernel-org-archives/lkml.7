Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB05206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZV5K3sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfG3BdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:33:24 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:54351 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfG3BdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:33:24 -0400
Received: by mail-vs1-f73.google.com with SMTP id b188so16471859vsc.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Frj/SS/W3AFZFbyzaOV4LWLnrMlPxcryoFLQjik2HTI=;
        b=HZV5K3snh9+hZYi0hyCp//JyWT/fXpO3R4ntivO3tTKVGtiJDw32+qKHYjRImOIIZW
         VxTiXkHj+VspcOQwMQmsA2V4AKt/XjP3LHtr1xFiKnUbnM3QWXE/wSzzzjwb8HARp0NL
         NnuTKiG3/MUCJOwH8yeiqO0PT9JR5nFtwF6U8A53/0E2cI+PwTcE9W+5puIoSJsXHcYY
         pGpqdjgsz/Gm/zNNZuQ/PWKC68R/embIB/nPMOQPIpfTsQj4rmJs4brzVzJl1hn7d19A
         ijF6rMV/AiriXix/ERN3pm4aTwkganjyHVi9+SBcKd4uYnPHslwXHHddmjlMGT2iycj7
         WlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Frj/SS/W3AFZFbyzaOV4LWLnrMlPxcryoFLQjik2HTI=;
        b=dGyTAdGB2sjRCiaF0uiHtDB1ZduPGX7POREz1SjE2UVV2O6GfWCp8MdTGlZ6PCuqJF
         3tmJfZuEN80mp6lGKWtwT/0r2IUvvOIw14jI3mszfG0sagaOmfzzlglD5Fn6w0GXJNbA
         GTOoZFk8eaof46I0tmoP6mzWa8vk+kbk5DNh6yinaoAvHLPxdSYdDQnm8Zz1iC6pkMhn
         hHNa08pnF9pOUkDH4x0nHFcvcvJFRAsF/Xf4ABxlWUd069E15D0K2eShghlbKY+/M7kC
         dW5v58X3VIvojYU56dN8u5W2G1rh4++SNUbcLAGcrS6MWPkr6VToXwWuc+/ruUvzdwtQ
         BAjQ==
X-Gm-Message-State: APjAAAXTlSfgzZQ7BA4YNS3C9BBPUt1kTwSUesdl/TrWvbXWxl8Cdn+H
        fOHE2DwCjUqRuY/EqJKEM2LJdMTvSgI=
X-Google-Smtp-Source: APXvYqzqfX8t1uXNFJXNaDwGRiqkwrH6h4jiFWfc6T5iZhZ57KmlPWww1KkuiFIxc6pVEcoJJlMga4+hqnw=
X-Received: by 2002:ab0:740e:: with SMTP id r14mr68442936uap.108.1564450403321;
 Mon, 29 Jul 2019 18:33:23 -0700 (PDT)
Date:   Mon, 29 Jul 2019 18:33:10 -0700
Message-Id: <20190730013310.162367-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH 1/1] psi: do not require setsched permission from the trigger creator
From:   Suren Baghdasaryan <surenb@google.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, axboe@kernel.dk,
        dennis@kernel.org, dennisszhou@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process creates a new trigger by writing into /proc/pressure/*
files, permissions to write such a file should be used to determine whether
the process is allowed to do so or not. Current implementation would also
require such a process to have setsched capability. Setting of psi trigger
thread's scheduling policy is an implementation detail and should not be
exposed to the user level. Remove the permission check by using _nocheck
version of the function.

Suggested-by: Nick Kralevich <nnk@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632c3b82..ed9a1d573cb1 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			mutex_unlock(&group->trigger_lock);
 			return ERR_CAST(kworker);
 		}
-		sched_setscheduler(kworker->task, SCHED_FIFO, &param);
+		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
 		kthread_init_delayed_work(&group->poll_work,
 				psi_poll_work);
 		rcu_assign_pointer(group->poll_kworker, kworker);
-- 
2.22.0.709.g102302147b-goog

