Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8327CC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE1D2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQ8uE7fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDKBoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:44:05 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:40187 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKBoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:44:03 -0400
Received: by mail-vk1-f202.google.com with SMTP id d64so1884417vkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 18:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1R5t7+lNOeidJ8ZneBm0ViFTLutFvxRUicyozCMV/Ds=;
        b=VQ8uE7fSnqdKErP7/p4dHAFIDW6jI3qLUsMTULdhHlqde5jIwhtKd6+qPR5tAHjXPL
         XCNL9Aj0wz1Y7vECvW1Ugi2US2rH7DQDFoCij9lkUZImbDw3EM60HOoIkNqQuLwD/34g
         3tkLTC/C2K922qnKAdHrHfX5GUD5eAl/+jQVn+GKGwbvYi9D4E30VgYgQkFCWpd31AeC
         TcxaOdDnIXkLAs0ERzKVT0n7FojrV/2A/02wTu15JMLHIOBjxOHCuDEJEqLdE6/3f6rP
         aZrtWVlzwBTUACFHg6sNWtO5or9++2FlOLH+28Exhs/7J9gbHRoXdTz/CNKP+55GGjd2
         3raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1R5t7+lNOeidJ8ZneBm0ViFTLutFvxRUicyozCMV/Ds=;
        b=e7me+F1Xg+kPlr19rMj2zEsdwd9H7ZawimjDbYi/XwsjyJqpe1emmp8fdC41wQTmDE
         URUCWl88ovPu8Qjuxly3Q2UUt3LDCqsv/GoBdI8Ju1kZVXn2syfozBZrry0OoNg39bdA
         gXr9caY2hIopocaDyod/IqNCmyZgRqaNGa+WsLxwtet+4Z4OGkzooWVyoSgW2kVv3Hgj
         VIUev7iYNM9h2mzSy8nVMP5lJx9ssxgXng/vi+qX2EGmpoMHNnDI+zNjGrOEuf/Ifuid
         t2+Ce17DfEeWr8eF+n/uxCcfzhKDEwH3UzzSfr8kMcr7fUNDvZlxoAOmg/0IA8LuPjNB
         aSlg==
X-Gm-Message-State: APjAAAWqQDjZ1zC3VqSHBmrmsr5FKbSClXCLGLC5WLuRFIXE4dSh3Dnk
        XpNgWSn0GSZG9bMCgVqf+3lXiGTazhg=
X-Google-Smtp-Source: APXvYqx9ebEgF18enAdLfuKzN1eizWR9w5VxGzxkPww+DyZ2FJ0mMzOj/JkBJbSd9g/xUnj4BFlUP2Quw3o=
X-Received: by 2002:a1f:10a5:: with SMTP id 37mr5464480vkq.6.1554947042655;
 Wed, 10 Apr 2019 18:44:02 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:43:52 -0700
In-Reply-To: <20190411014353.113252-1-surenb@google.com>
Message-Id: <20190411014353.113252-2-surenb@google.com>
Mime-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC 1/2] mm: oom: expose expedite_reclaim to use oom_reaper outside
 of oom_kill.c
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        ebiederm@xmission.com, shakeelb@google.com, christian@brauner.io,
        minchan@kernel.org, timmurray@google.com, dancol@google.com,
        joel@joelfernandes.org, jannh@google.com, surenb@google.com,
        linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an API to allow users outside of oom_kill.c to mark a victim and
wake up oom_reaper thread for expedited memory reclaim of the process being
killed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/oom.h |  1 +
 mm/oom_kill.c       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index d07992009265..6c043c7518c1 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -112,6 +112,7 @@ extern unsigned long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
 
 extern bool out_of_memory(struct oom_control *oc);
+extern bool expedite_reclaim(struct task_struct *task);
 
 extern void exit_oom_victim(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3a2484884cfd..6449710c8a06 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1102,6 +1102,21 @@ bool out_of_memory(struct oom_control *oc)
 	return !!oc->chosen;
 }
 
+bool expedite_reclaim(struct task_struct *task)
+{
+	bool res = false;
+
+	task_lock(task);
+	if (task_will_free_mem(task)) {
+		mark_oom_victim(task);
+		wake_oom_reaper(task);
+		res = true;
+	}
+	task_unlock(task);
+
+	return res;
+}
+
 /*
  * The pagefault handler calls here because it is out of memory, so kill a
  * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
-- 
2.21.0.392.gf8f6787159e-goog

