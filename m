Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3776CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1696A20873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbfJDQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:11:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45430 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbfJDQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:11:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so3984212pgi.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoFlbvlBuPYoreFXSYvVJO4y1E3a8kjq+ixQvB/BlKw=;
        b=IRAqZrn1bbZioavQPgxwiYIeM8Ixz2uVeOhc/xonEhzb21uK4HinrTLrg7anQ/kJuS
         +qkh/UOsTOilFp0xvi33D2ZHjfGvhHhH3T/pAwNq2LQZlSRgC/MHwycz/MXnajulI+hc
         mC1dIDESONBEGFS0jcogz7EASVfFa9cfQqI1ylZOojvdpEtQKsrnWKo4Kr54moLcrxg6
         Uzgf4H71kdsP16gTjtvChuaYVW6m8yVkq+skh+NbtkqK7yLOTCoQDnh7dSxvgZ8eeE+1
         +W2rkp7Ph/vt5swDmYV7fVNXS8jBxoosUEQNna296vAXZtrw4hFxmKXMivuBIBUPoBJm
         GPrg==
X-Gm-Message-State: APjAAAVzXU1jbpbqNZQvWrk+3pJhdlJgmxK9su7bBhRbRPFLO9ME4tkG
        dJ525+VIbRWz9Iw59ue7OMStMO2T
X-Google-Smtp-Source: APXvYqxxLn0aiEHMLVcVJ/0qTWDgQUXSRYx22oB3mV27nKuqtSCFBGpxei/FWcvieJBDm8fVt/oijg==
X-Received: by 2002:aa7:9a48:: with SMTP id x8mr17403227pfj.201.1570205491660;
        Fri, 04 Oct 2019 09:11:31 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j24sm7080988pff.71.2019.10.04.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:11:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Dave Jones <davej@redhat.com>
Subject: [PATCH] kernfs: Improve lockdep annotation for files which implement mmap
Date:   Fri,  4 Oct 2019 09:11:24 -0700
Message-Id: <20191004161124.111376-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using one lockdep key for files that do not implement mmap
and another lockdep key for files that implement mmap, use a separate
lockdep key for each file that implements mmap.

This patch does not affect the size of struct kernfs_open_file if
CONFIG_LOCKDEP=n since in that case lock_class_key has size zero.

This patch is an improvement for commit 027a485d12e0 ("sysfs: use a
separate locking class for open files depending on mmap"; v3.13).

Cc: Dave Jones <davej@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/kernfs/file.c       | 34 +++++++++++++++++-----------------
 include/linux/kernfs.h |  1 +
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e8c792b49616..a6980a8f9ffc 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -649,24 +649,17 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 		goto err_out;
 
 	/*
-	 * The following is done to give a different lockdep key to
-	 * @of->mutex for files which implement mmap.  This is a rather
-	 * crude way to avoid false positive lockdep warning around
-	 * mm->mmap_sem - mmap nests @of->mutex under mm->mmap_sem and
-	 * reading /sys/block/sda/trace/act_mask grabs sr_mutex, under
-	 * which mm->mmap_sem nests, while holding @of->mutex.  As each
-	 * open file has a separate mutex, it's okay as long as those don't
-	 * happen on the same file.  At this point, we can't easily give
-	 * each file a separate locking class.  Let's differentiate on
-	 * whether the file has mmap or not for now.
-	 *
-	 * Both paths of the branch look the same.  They're supposed to
-	 * look that way and give @of->mutex different static lockdep keys.
+	 * Assign a unique lockdep key to @of->mutex for files which implement
+	 * mmap. This is necessary to avoid a false positive lockdep warning
+	 * around mm->mmap_sem - mmap nests @of->mutex under mm->mmap_sem and
+	 * reading /sys/block/sda/trace/act_mask grabs sr_mutex, under which
+	 * mm->mmap_sem nests, while holding @of->mutex.
 	 */
-	if (has_mmap)
-		mutex_init(&of->mutex);
-	else
-		mutex_init(&of->mutex);
+	mutex_init(&of->mutex);
+	if (has_mmap) {
+		lockdep_register_key(&of->mutex_key);
+		lockdep_set_class(&of->mutex, &of->mutex_key);
+	}
 
 	of->kn = kn;
 	of->file = file;
@@ -734,6 +727,9 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
 err_seq_release:
 	seq_release(inode, file);
 err_free:
+	mutex_destroy(&of->mutex);
+	if (has_mmap)
+		lockdep_unregister_key(&of->mutex_key);
 	kfree(of->prealloc_buf);
 	kfree(of);
 err_out:
@@ -769,6 +765,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
+	const bool has_mmap = kn->attr.ops->mmap != NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
 		mutex_lock(&kernfs_open_file_mutex);
@@ -778,6 +775,9 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 
 	kernfs_put_open_node(kn, of);
 	seq_release(inode, filp);
+	mutex_destroy(&of->mutex);
+	if (has_mmap)
+		lockdep_unregister_key(&of->mutex_key);
 	kfree(of->prealloc_buf);
 	kfree(of);
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 936b61bd504e..6680fae5f0f6 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -204,6 +204,7 @@ struct kernfs_open_file {
 	void			*priv;
 
 	/* private fields, do not use outside kernfs proper */
+	struct lock_class_key	mutex_key;
 	struct mutex		mutex;
 	struct mutex		prealloc_mutex;
 	int			event;
-- 
2.23.0.581.g78d2f28ef7-goog

