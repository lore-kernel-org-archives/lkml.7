Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00915CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82262070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4NpAEXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506050AbfJRU4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:56:51 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:54171 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbfJRU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:56:49 -0400
Received: by mail-wr1-f73.google.com with SMTP id i10so3246368wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rSf3nIyWZKMYSfUuilEe+uzzHebaBT4JOp0k6bHBoK4=;
        b=U4NpAEXN5/lXUpumdw+t+ry2JvKAgZeKwdGqMbAo6/rXn4uR382MxTVjKHE0cLCRV+
         ziWtm7ZLVF8hfqGcaNpAxuklijBqedBaJcqOliX/xZfPJ4AFojVNO5lRmCdGP4HWFCj3
         Pdvb6C6YL58kLovWjY2w0bmcIWjRiUsWvMps7w9g4o6JGPH+/F0LEFdCCnl8pe6NsttV
         yAi5SMuNYc31z1Y+ZSEDZmzIuzQahY2kkHG0vDG/Pllz2u3etqP52KytyCIUZYdhSr4A
         EWT2UKHjWyh5UVgLhlHHVHIfXQAFRonY0uSifEdh2REYnWiqaQxVgiPJ3YOQoWQDYfEf
         iPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rSf3nIyWZKMYSfUuilEe+uzzHebaBT4JOp0k6bHBoK4=;
        b=DehnDWXBkJohVVjXT3MXCdQ55mN1W95a4/Tp9GyHcDJrFCfFyHBT4oLQKw5AWzLL8b
         MMwGHJARBq/fIkgInry+2ovmJGTd4PwN1FvdVFNmhU9p6ZqSZuIRccDyAiu5DravpDHJ
         78rTy4Pnw/ad90xO91riXfKvaO5SFhThGIuLiiIJOWCHrw1gEQTePH8HAXL8qfc+xyjG
         DDQlIL3u8XpuVIMltyOfdE1GAZllr5blzI/BaNmbpMSweG8QhryBJt552MgONaCdFN7Q
         NEtx3lfd8eRBhbcZQ+EzFKJ8/y/pTayn4DB/L+qqz3GiAgTZi1HgY0KOahw/xf60m2zz
         +rcQ==
X-Gm-Message-State: APjAAAW1rlkXnNNYLdwVtBYBz86urn8gUE59XMvIE4x6WQpcwdGQTw5n
        GQDVx8P62BUNtQF2ImTpdTBEQXqjLQ==
X-Google-Smtp-Source: APXvYqzlSay8l7D7nwGmRtoHF5tVY73mNeqS/VnG/mqmfszIKt2jJP8+W/12gpolZeK4d18GXwIjV/BR7g==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr9028179wri.130.1571432206880;
 Fri, 18 Oct 2019 13:56:46 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:56:30 +0200
In-Reply-To: <20191018205631.248274-1-jannh@google.com>
Message-Id: <20191018205631.248274-2-jannh@google.com>
Mime-Version: 1.0
References: <20191018205631.248274-1-jannh@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 2/3] binder: Prevent repeated use of ->mmap() via NULL mapping
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

binder_alloc_mmap_handler() attempts to detect the use of ->mmap() on a
binder_proc whose binder_alloc has already been initialized by checking
whether alloc->buffer is non-zero.

Before commit 880211667b20 ("binder: remove kernel vm_area for buffer
space"), alloc->buffer was a kernel mapping address, which is always
non-zero, but since that commit, it is a userspace mapping address.

A sufficiently privileged user can map /dev/binder at NULL, tricking
binder_alloc_mmap_handler() into assuming that the binder_proc has not been
mapped yet. This leads to memory unsafety.
Luckily, no context on Android has such privileges, and on a typical Linux
desktop system, you need to be root to do that.

Fix it by using the mapping size instead of the mapping address to
distinguish the mapped case. A valid VMA can't have size zero.

Fixes: 880211667b20 ("binder: remove kernel vm_area for buffer space")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder_alloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 21952dfa147d..539385634151 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -681,17 +681,17 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	struct binder_buffer *buffer;
 
 	mutex_lock(&binder_alloc_mmap_lock);
-	if (alloc->buffer) {
+	if (alloc->buffer_size) {
 		ret = -EBUSY;
 		failure_string = "already mapped";
 		goto err_already_mapped;
 	}
+	alloc->buffer_size = min_t(unsigned long, vma->vm_end - vma->vm_start,
+				   SZ_4M);
+	mutex_unlock(&binder_alloc_mmap_lock);
 
 	alloc->buffer = (void __user *)vma->vm_start;
-	mutex_unlock(&binder_alloc_mmap_lock);
 
-	alloc->buffer_size = min_t(unsigned long, vma->vm_end - vma->vm_start,
-				   SZ_4M);
 	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
@@ -722,8 +722,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	kfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
-	mutex_lock(&binder_alloc_mmap_lock);
 	alloc->buffer = NULL;
+	mutex_lock(&binder_alloc_mmap_lock);
+	alloc->buffer_size = 0;
 err_already_mapped:
 	mutex_unlock(&binder_alloc_mmap_lock);
 	binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
-- 
2.23.0.866.gb869b98d4c-goog

