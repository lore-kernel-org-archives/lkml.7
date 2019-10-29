Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C4FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8B5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FC4xXf2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfJ2Qcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:32:50 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48287 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390458AbfJ2Qcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:32:47 -0400
Received: by mail-vk1-f201.google.com with SMTP id x65so2176492vkd.15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5pfhpJx7UO/QNtR11zCiFnLuGkt6GlpMBjgSmMf75Tg=;
        b=FC4xXf2uZAMPwsrS2OpWFIPtkzQx1/R/4h+oW4oVwrQSAmMY3j5rAXXvMIeTt9HmO9
         bMgeC7X+vkpdUJYjwYDUosbLI4zFUtwgcVTuzIWYTJ9hUePQyte5w3EAEsvviWkBiDBw
         ZvatJYjaTa//8dRWOc9DabyKXKa7mCRRFBFM1LTwR2cQ6+Fn89H6Txtv25QUDc8ApcUh
         DCvHhH1qFVpZ78NPfAOQdj2EGmuC0sFyJ/fiN3XEPYw+XSTxfk+ZPF3+Ww2kZSkK9H0X
         om/im8oCdPDqb+vmEjGkPIrKOJ4wy/QciLWGnGESCIAjXG98sVXNPhY5BNk1hcMY2nep
         Zm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5pfhpJx7UO/QNtR11zCiFnLuGkt6GlpMBjgSmMf75Tg=;
        b=bMINYd8wKTtdqzUXcFEdvjdBJPUlWAxDFtPdOsWdNtWsxgl3KbAXpD8yuk7pI9Qopy
         0qlUzOMIFstVeINFDMMyhkPSrvKpHwnAoWhUHyWr0gJcYWuCyo+WQC/7PlohoexyPS6S
         m6IYCfdcNtwYe+gI/j8cgqH5/UIhyabfDBa8qnP9h9Zc1Au/ciCy5rBPJqPF/GlCklck
         Gf5pBsWqUXh1nzrT6xPelaZtZDvNH4ABEc4H9yKUBO1HcGxH+PjQY8Nh0H/UfGpZwx7d
         tP11p/M28hhlhOA7oNSOdhsoM9/BeKOOHicvCZ2tXZIqgMYeFghU7pQbdi2FIDIcf/Cs
         MvZQ==
X-Gm-Message-State: APjAAAXAW8IYMjoTnCkO7AD/M+LpumDZVhSEygK4JjTtRRgnCwYeOp55
        JYUwujJ3CdY3Yftel+cTU456t7ysmhc46XXF
X-Google-Smtp-Source: APXvYqxnbDwJOsZb5FOgMj5h3yqf55yEZtrdQcWRE/7f4Xr3yFQjgNOipnGlkQAkFoahpht83RtnwLlnW8nrG+uK
X-Received: by 2002:a1f:41c4:: with SMTP id o187mr12070271vka.102.1572366766673;
 Tue, 29 Oct 2019 09:32:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:32:29 +0100
In-Reply-To: <cover.1572366574.git.andreyknvl@google.com>
Message-Id: <e49d5d154e5da6c9ada521d2b7ce10a49ce9f98b.1572366574.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1572366574.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 3/3] vhost, kcov: collect coverage from vhost_worker
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds kcov_remote_start()/kcov_remote_stop() annotations to the
vhost_worker() function, which is responsible for processing vhost works.
Since vhost_worker() threads are spawned per vhost device instance
the common kcov handle is used for kcov_remote_start()/stop() annotations
(see Documentation/dev-tools/kcov.rst for details). As the result kcov can
now be used to collect coverage from vhost worker threads.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vhost/vhost.c | 6 ++++++
 drivers/vhost/vhost.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 36ca2cf419bf..f44340b41494 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -30,6 +30,7 @@
 #include <linux/sched/signal.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/nospec.h>
+#include <linux/kcov.h>
 
 #include "vhost.h"
 
@@ -357,7 +358,9 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
+			kcov_remote_start_common(dev->kcov_handle);
 			work->fn(work);
+			kcov_remote_stop();
 			if (need_resched())
 				schedule();
 		}
@@ -546,6 +549,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	/* No owner, become one */
 	dev->mm = get_task_mm(current);
+	dev->kcov_handle = kcov_common_handle();
 	worker = kthread_create(vhost_worker, dev, "vhost-%d", current->pid);
 	if (IS_ERR(worker)) {
 		err = PTR_ERR(worker);
@@ -571,6 +575,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 	if (dev->mm)
 		mmput(dev->mm);
 	dev->mm = NULL;
+	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -682,6 +687,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	if (dev->worker) {
 		kthread_stop(dev->worker);
 		dev->worker = NULL;
+		dev->kcov_handle = 0;
 	}
 	if (dev->mm)
 		mmput(dev->mm);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index e9ed2722b633..a123fd70847e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -173,6 +173,7 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
+	u64 kcov_handle;
 };
 
 bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
-- 
2.24.0.rc0.303.g954a862665-goog

