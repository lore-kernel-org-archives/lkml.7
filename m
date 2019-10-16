Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53382FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295EE21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWleaYVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbfJPPBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:01:33 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:44490 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388424AbfJPPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:33 -0400
Received: by mail-wr1-f73.google.com with SMTP id n18so11842854wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J/niWMSCWOkU3FiiC/BCaEkIRU5HgEsVvmugtdWHpiU=;
        b=AWleaYVzPfogOuND6XsrqmkQdiZxuNLN56ZJsxj5/YScOsRzNhfiI52GlFsNTIeKf1
         HXE7HyK7Mb706yj8/QV5fTJSvjJ3tcLta9yoVpe0v7vyAQz4cMHkMmI3+S9qeBGLx159
         ODEOad5Jjfz42lo7SCw2SOEL1lWINyDaY/+N6nVkmpJtGkm5w4Kj0EK/j25tF2XJcqmg
         u69o7MyCqHqD6FEWT1QmlGMiSgYNUuIClgTGo77gpSg+0CPCzkUlteCMJIariG5J3puf
         VgpK2PJeYV4L/J5SDF9ChR/8GoffM+K8+E4Yw/BGT6imoMWf11rxXD0Bcvx9QMFzjiT0
         xK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J/niWMSCWOkU3FiiC/BCaEkIRU5HgEsVvmugtdWHpiU=;
        b=BqFre87Qm1mwMasQVjdFXXMURPZCxnEYKA+WICySE+1AAzrlLh1/11mx+e0W9VXHxB
         wOKl6zoslZIf/hMhOmoNAQlATbZ5n+rXv/2EtIjY0W3oahMYMsDe8rIcg/T9qykZ289q
         XN4V3GBE23Shwdw+hP16Pa4qWqnkWd8sFOQdC42IyROVdysgOa+NP+hPLbcvywazCxQW
         YzZwMtA1T+pQEHkOkIgjDSDpemu93d2n4UGTP8I13ln3eOhqqX2oxaUE3hzyy1VlSS18
         f1AbzmKp8oT6sUkaXdE16CNW8QcYyvADC2TJ1mLL+Li9a/AZ6QuLLawft05yAX/YG5Ce
         3YMQ==
X-Gm-Message-State: APjAAAXAsuu0KbSFlZIZyvya57yO9L2LysUwswSq72SBQLQ8wGUlWroS
        qB4EKh4rLrAFpTtFwIBu8evp5MArqQ==
X-Google-Smtp-Source: APXvYqyocMgs+6OGpViQxfVV1xDmH8jmVPfAkkza78APbcuoCqa4HN6Jil/nm0+Zajjc7bM8J/ma2uxh+g==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr3056203wrw.369.1571238090230;
 Wed, 16 Oct 2019 08:01:30 -0700 (PDT)
Date:   Wed, 16 Oct 2019 17:01:18 +0200
Message-Id: <20191016150119.154756-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 1/2] binder: Don't modify VMA bounds in ->mmap handler
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder_mmap() tries to prevent the creation of overly big binder mappings
by silently truncating the size of the VMA to 4MiB. However, this violates
the API contract of mmap(). If userspace attempts to create a large binder
VMA, and later attempts to unmap that VMA, it will call munmap() on a range
beyond the end of the VMA, which may have been allocated to another VMA in
the meantime. This can lead to userspace memory corruption.

The following sequence of calls leads to a segfault without this commit:

int main(void) {
  int binder_fd = open("/dev/binder", O_RDWR);
  if (binder_fd == -1) err(1, "open binder");
  void *binder_mapping = mmap(NULL, 0x800000UL, PROT_READ, MAP_SHARED,
                              binder_fd, 0);
  if (binder_mapping == MAP_FAILED) err(1, "mmap binder");
  void *data_mapping = mmap(NULL, 0x400000UL, PROT_READ|PROT_WRITE,
                            MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
  if (data_mapping == MAP_FAILED) err(1, "mmap data");
  munmap(binder_mapping, 0x800000UL);
  *(char*)data_mapping = 1;
  return 0;
}

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder.c       | 7 -------
 drivers/android/binder_alloc.c | 6 ++++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5b9ac2122e89..265d9dd46a5e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -97,10 +97,6 @@ DEFINE_SHOW_ATTRIBUTE(proc);
 #define SZ_1K                               0x400
 #endif
 
-#ifndef SZ_4M
-#define SZ_4M                               0x400000
-#endif
-
 #define FORBIDDEN_MMAP_FLAGS                (VM_WRITE)
 
 enum {
@@ -5177,9 +5173,6 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (proc->tsk != current->group_leader)
 		return -EINVAL;
 
-	if ((vma->vm_end - vma->vm_start) > SZ_4M)
-		vma->vm_end = vma->vm_start + SZ_4M;
-
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%s: %d %lx-%lx (%ld K) vma %lx pagep %lx\n",
 		     __func__, proc->pid, vma->vm_start, vma->vm_end,
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d42a8b2f636a..eb76a823fbb2 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -22,6 +22,7 @@
 #include <asm/cacheflush.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/sizes.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
@@ -689,7 +690,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	alloc->buffer = (void __user *)vma->vm_start;
 	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->pages = kcalloc((vma->vm_end - vma->vm_start) / PAGE_SIZE,
+	alloc->buffer_size = min_t(unsigned long, vma->vm_end - vma->vm_start,
+				   SZ_4M);
+	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
 	if (alloc->pages == NULL) {
@@ -697,7 +700,6 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		failure_string = "alloc page array";
 		goto err_alloc_pages_failed;
 	}
-	alloc->buffer_size = vma->vm_end - vma->vm_start;
 
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer) {
-- 
2.23.0.700.g56cf767bdb-goog

