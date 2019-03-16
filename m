Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D6EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33639218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdkLG8w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCPR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:59:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44715 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfCPR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:58:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so8486210pff.11;
        Sat, 16 Mar 2019 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=kdkLG8w2jLU2Q+wYZHK4jJVemS6eEurY7WT5V+pbp3DY3kO+9NesXJQhACj5QFf+ay
         uwAO6/lNJdsPUTgG5tRbh5K7owEceI+mtDKwLOBVcv8aUDLre2eZcWtGIi92ksgJp/W/
         wdkJguUgI+fqAhL+DlzXJqglM1R2bWlUGQnkeBpgH8ThaM1BnIP1C8hM+RVIGKjZaPv/
         ckg2uK0E2iB2B8rW1IQJJVSzdd/53okARBrrmtvq8TBEWBCgI1C+om3KKui/Yk5/z6uf
         2beRIdboU2slOvukfpo/S9QKkuqDAO0fDNnmDcTPSxrWSPRqiPfYEwu4BXOMQCeoIEVK
         w4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJ4P00vx6U5PVt2qTIPEjoDmQITn36JjYHqlVjlSqjo=;
        b=Vr7//RE6jFf4++Wrd9VkPr/vzlA4W4vnDIDJ5Q0Na8aT88Ds02vu5X6TVoLLXNEhJ0
         bNxqiDRs5fwmuLaflwV2DTbkEkti/gBjm90hr/JrhD810RkeHVhJ/4pJ8hYA/HhXKdto
         EfYW6jjEMgAzsnJyzkIvMjuMTEr6+YIjMMGMftOhYyjPJGz3/eMTVgzYQU1S7ziJfHQq
         yN6QDjaftWvaJqgT2mIcjOMEqqABSdRyPo4u7WH91047PHnW7ciMF06ipPcUMUiOvpKO
         GIk3Ds6fFGIoyb/t4QdjxjLdiLGmSaZnpV9tO5XcOu4tSSWJ/CQTx3FpYIxYVHEgkh+4
         QTrA==
X-Gm-Message-State: APjAAAWteofz3wVm7GFEBprlkyeAOgKQbKHW6UJy/8sH3USv/kaRiP/w
        CfdknOfypTpSnMJWdulg7yA=
X-Google-Smtp-Source: APXvYqzv5Cz+STzl4Z6Eiqvr9+LryqjV2g5yZsEOZLIgT96r+P7K4IPdhzLMLTllYrbfjxsa84xzlQ==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr10956439plp.34.1552759100425;
        Sat, 16 Mar 2019 10:58:20 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id p86sm11025638pfa.104.2019.03.16.10.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 10:58:19 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/9] cgroup: implement __cgroup_task_count() helper
Date:   Sat, 16 Mar 2019 10:58:05 -0700
Message-Id: <20190316175812.6787-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
References: <20190316175812.6787-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper is identical to the existing cgroup_task_count()
except it doesn't take the css_set_lock by itself, assuming
that the caller does.

Also, move cgroup_task_count() implementation into
kernel/cgroup/cgroup.c, as there is nothing specific to cgroup v1.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup-v1.c       | 16 ----------------
 kernel/cgroup/cgroup.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c950864016e2..a195328431ce 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -226,6 +226,7 @@ int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
 
+int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 583b969b0c0e..29c0ca8f76cf 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -339,22 +339,6 @@ static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
 	return l;
 }
 
-/**
- * cgroup_task_count - count the number of tasks in a cgroup.
- * @cgrp: the cgroup in question
- */
-int cgroup_task_count(const struct cgroup *cgrp)
-{
-	int count = 0;
-	struct cgrp_cset_link *link;
-
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		count += link->cset->nr_tasks;
-	spin_unlock_irq(&css_set_lock);
-	return count;
-}
-
 /*
  * Load a cgroup's pidarray with either procs' tgids or tasks' pids
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f4418371c83b..b230afccf635 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -592,6 +592,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
 	css_get(&cgrp->self);
 }
 
+/**
+ * __cgroup_task_count - count the number of tasks in a cgroup. The caller
+ * is responsible for taking the css_set_lock.
+ * @cgrp: the cgroup in question
+ */
+int __cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count = 0;
+	struct cgrp_cset_link *link;
+
+	lockdep_assert_held(&css_set_lock);
+
+	list_for_each_entry(link, &cgrp->cset_links, cset_link)
+		count += link->cset->nr_tasks;
+
+	return count;
+}
+
+/**
+ * cgroup_task_count - count the number of tasks in a cgroup.
+ * @cgrp: the cgroup in question
+ */
+int cgroup_task_count(const struct cgroup *cgrp)
+{
+	int count;
+
+	spin_lock_irq(&css_set_lock);
+	count = __cgroup_task_count(cgrp);
+	spin_unlock_irq(&css_set_lock);
+
+	return count;
+}
+
 struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 {
 	struct cgroup *cgrp = of->kn->parent->priv;
-- 
2.20.1

