Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B15218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYX37Q7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfDERrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDERre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so3441657pgo.7;
        Fri, 05 Apr 2019 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pj7WA03mP3oNwX6qE6zfP09vbwa2yYIzNAhT0cJRXXI=;
        b=kYX37Q7YMZBgxmmbjJ7RHh/xcKkq99Q4b0sjfszkujTyvZ5yvOK8+qX7ntFiKc36QT
         T3Ht34RWF++R3ZKcnSJNmkSuVNoDC5rHFvgFQwUJNwIEjkK/sZOg2frsrQ5AZ8zderS3
         Y87Wcz8BWnUz2mdvhy0wemDgNfVMQiFnkNNRE1R3OOdA+WHfb8xg7oYMhYaqbRHUUbiB
         CJh545kflaMiipWQQL2IvlKSpk+sxcmEQBsHgnLWkIFtAVmDiwc1FaR6sfTvIue8rL8g
         eL9RkjHqlcYE/oZ8XWoEXFf76o0OpoeeL97KPM5a7dGTk6Nb+U/osL9fVzuyIqF192Na
         gmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pj7WA03mP3oNwX6qE6zfP09vbwa2yYIzNAhT0cJRXXI=;
        b=JgnwJjEQ2/dSJJT3aTolPDxNYa/+CwMS0eVA5qBOW8zIPhSIYNE8CrKvL9KJcifPJV
         1WKyDhGM708un56UUu8PNefb1MeusbomIdNZvaDPpKW0xXOpqjXm1CRQr667ZKND0Izr
         m/fN/yfsURhJ5viLSKtLT/yljVOn2rERvkZGUM8mnafRUFZI6iRcwrfsLQVGw6q3mWdF
         vsw0BinUJYj2ZE/PIw1ouYhD1sdTyCPEDmO2BuW5xA8uxiC8HWOurdKoIWl7RBjeUYql
         bIIfALf+uk9vdqG/gPugF4QTplC3VtKwqjmy+ycigusX5H9G9Ak4p+IgQA9ujp2k7v7K
         9M1Q==
X-Gm-Message-State: APjAAAUoqyoTK5h5MWkbpwREd21ObKu/MlVj1UjtWk/mz3nP3i56PAm0
        NJiF8zWiNSp381GMqKu+DNc=
X-Google-Smtp-Source: APXvYqzSsob1FA3JAUHS7yPs/FBxLYTHIlUSAL5d4AnDKyXlvLLiFDHkUu3hAq/VB7xGwUiUrf9LGw==
X-Received: by 2002:a63:e653:: with SMTP id p19mr13251517pgj.284.1554486453785;
        Fri, 05 Apr 2019 10:47:33 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:ad20])
        by smtp.gmail.com with ESMTPSA id m2sm33169135pgr.74.2019.04.05.10.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:47:32 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v10 2/9] cgroup: implement __cgroup_task_count() helper
Date:   Fri,  5 Apr 2019 10:47:01 -0700
Message-Id: <20190405174708.1010-3-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
References: <20190405174708.1010-1-guro@fb.com>
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
index 30e39f3932ad..02c001ffe2e2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -240,6 +240,7 @@ int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
 
+int __cgroup_task_count(const struct cgroup *cgrp);
 int cgroup_task_count(const struct cgroup *cgrp);
 
 /*
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index c126b34fd4ff..68ca5de7ec27 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -342,22 +342,6 @@ static struct cgroup_pidlist *cgroup_pidlist_find_create(struct cgroup *cgrp,
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
index f219c195a9a5..3008ea684aa0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -593,6 +593,39 @@ static void cgroup_get_live(struct cgroup *cgrp)
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

