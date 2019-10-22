Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E0BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C55E20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czPv6bG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfJVQqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:46:50 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:42551 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389555AbfJVQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:46:49 -0400
Received: by mail-vs1-f74.google.com with SMTP id p6so3912501vsq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xeTajp2gTwNneRzmHl8dZLgjRVR+or7Oc8/MveRSES4=;
        b=czPv6bG/woLawvFL6EeJ3IomrWe7WJLXIS8Q5s7BYzv4jeVZUhKcqUrBD6MHE4X3Wy
         gaVhDh9xU1/SIXHSLB3HhPMakMrFItvpEYLIRd8RhTeumsOEr/W5opNycN3wSNR5Nfq+
         8Uvg/NpAVip0msYuEOWDd/Xwyy3mpXkakREkO3YQmRdtrusv2aVekVFQ4qy0KchHUYZk
         +EJV75GDzrZF1ylqrZahxNQZVzB02D9UYp4RkPTJWVv8C3gzX45NJnepvMKF4XDAM3hC
         Al/gAJqFg/Q7YP5ygCC7hd/ANdsR33IrEuArt2jLW5EYKkKEipmUTt4vKFi6vvM+JTA0
         rQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xeTajp2gTwNneRzmHl8dZLgjRVR+or7Oc8/MveRSES4=;
        b=MVJzcdc+0SPn8NNIwPCzotvOX5sbUygbJhj5hbzRXhmGCaoKaq+FYCMWDLglMEoFxJ
         2+P/N5/x9JF2ysZnQALX9AFpxqx50Lgr6f5f+PsVW1CSdipFqiOIfwZHiEPCPqR7XK4J
         Uqyl3mCFm+R5N+4Z7HYUl6V7O90FvnIUzKWD+Xy1TPAqVJvKB7aXASu20cSnbqiEp3r9
         f/+yFaRU+Utm6hIXJs4/U5Ek17mYMgg4sLfxFXLsE55PD1hYNWj0k+r365iMF4S3agQf
         f3S3jH0mdWV10l0AIISXRojnGdfUIQCZj6oKBDIepnx5/kLj5pTIcDFf7RiqycuBhvyM
         OWZA==
X-Gm-Message-State: APjAAAVCOs3dOAs6DDhw73o0Zxdr1OMoLPZ9qNTIFre0wfO20kJqAgKu
        sX1hyFyoEy6/TNtfb5L8/m8Xr+9Uway0+a4k
X-Google-Smtp-Source: APXvYqztA3K2JUb94+WtUgiu0B8Mrp7aoBsl8U36U8bVoUlttXs4+RNS1hzM4glUCN7mveu0ffdpO/JosmE95cWz
X-Received: by 2002:ab0:1896:: with SMTP id t22mr2506869uag.82.1571762807067;
 Tue, 22 Oct 2019 09:46:47 -0700 (PDT)
Date:   Tue, 22 Oct 2019 18:46:33 +0200
In-Reply-To: <cover.1571762488.git.andreyknvl@google.com>
Message-Id: <26e088ae3ebcaa30afe957aeabaa9f0c653df7d0.1571762488.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1571762488.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 3/3] vhost, kcov: collect coverage from vhost_worker
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
index 36ca2cf419bf..a5a557c4b67f 100644
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
+			kcov_remote_start(dev->kcov_handle);
 			work->fn(work);
+			kcov_remote_stop();
 			if (need_resched())
 				schedule();
 		}
@@ -546,6 +549,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	/* No owner, become one */
 	dev->mm = get_task_mm(current);
+	dev->kcov_handle = current->kcov_handle;
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
2.23.0.866.gb869b98d4c-goog

