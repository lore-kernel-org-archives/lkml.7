Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751552083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JQssBqN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCAXGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:06:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38908 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAXGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:06:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so12125853pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwRwUOwBbuqqde4cgzaMzPICNmEeL7GCcGUf5rgy3ZA=;
        b=JQssBqN1rIGozFmTM+mNcJLXnphppLxnyckzsC9gT3n8Mvm/OR7+YEXl5ZZOGpJ2ri
         +y8kHEKbKGIV7uiNnL5hE+qlsorZn9r4fXnnmRBm0+1vJMR5jhDr7C+kvFu1D0Juzr0c
         EngPIoq8ey/335MtPofwRRPsW1WRabB5nLsT8pEJ+f6gMsUxtZ+da14Tmat7YDiFslbf
         EZrDEkoelt3FOr5tpDt+REEsB10e7ApJ7QcVC7R8FtbuLGSXUE3cwvz+iXygSfa6EmK+
         tw84yTt0EvwfUrbOfR94m7oH7ZERcrLflkkFrJxUOhEbRBWAd7ZZOUtZR9zXQCHagkyB
         oEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WwRwUOwBbuqqde4cgzaMzPICNmEeL7GCcGUf5rgy3ZA=;
        b=oP6WwF5N3G8QGt++tui7nc5cSfjIi2pm22RfRnW3BVoJ/h8a5a1B5+rbhNDkKTj5pf
         BU1n+v3HCrcU/hJUvapO0PjKEGqOPBaCbcaEr5qA2Na0NG6SdmSyq6ebQXOCUNyPmjpn
         k4CdWmcBCsGVLchQr0clp8wLZbqELIqH2JnBVw+taDSL9WrV4qKtyBGHjrRo/BT+H8HU
         omUkGyX6irDGjG793TOx2sQV/lpp2ErJGOTdHbp9rHU+vuu5DGC8io5+M+Cqk7V93WlT
         bTReGirwTkTk5CKhxF+zBgDmd153SYAaXr/Zi+MmtCmMtrVX+KcLbr1263aliL7z32Ar
         kSNg==
X-Gm-Message-State: APjAAAWkBTyTrtAAyb3HAXdq6EstH8za1nd8Iwvwr1Cp4C0vFfOJsL3n
        gos3EMidwJDRgMwozQPEUh0J9A==
X-Google-Smtp-Source: APXvYqyjoyHI3j6XtKcXk0PR+CvaiwLZvBVP5Jmr8U3qpm67Dt/GHPDniOkH6++1SG7Den2vio3O5w==
X-Received: by 2002:a63:1723:: with SMTP id x35mr7120923pgl.364.1551481577713;
        Fri, 01 Mar 2019 15:06:17 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id e22sm13252259pfi.126.2019.03.01.15.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 15:06:17 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH] binder: fix race between munmap() and direct reclaim
Date:   Fri,  1 Mar 2019 15:06:06 -0800
Message-Id: <20190301230606.8302-1-tkjos@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An munmap() on a binder device causes binder_vma_close() to be called
which clears the alloc->vma pointer.

If direct reclaim causes binder_alloc_free_page() to be called, there
is a race where alloc->vma is read into a local vma pointer and then
used later after the mm->mmap_sem is acquired. This can result in
calling zap_page_range() with an invalid vma which manifests as a
use-after-free in zap_page_range().

The fix is to check alloc->vma after acquiring the mmap_sem (which we
were acquiring anyway) and skip zap_page_range() if it has changed
to NULL.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 6389467670a0b..195f120c4e8c9 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -927,14 +927,13 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 	index = page - alloc->pages;
 	page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
+
+	mm = alloc->vma_vm_mm;
+	if (!mmget_not_zero(mm))
+		goto err_mmget;
+	if (!down_write_trylock(&mm->mmap_sem))
+		goto err_down_write_mmap_sem_failed;
 	vma = binder_alloc_get_vma(alloc);
-	if (vma) {
-		if (!mmget_not_zero(alloc->vma_vm_mm))
-			goto err_mmget;
-		mm = alloc->vma_vm_mm;
-		if (!down_read_trylock(&mm->mmap_sem))
-			goto err_down_write_mmap_sem_failed;
-	}
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -945,10 +944,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		zap_page_range(vma, page_addr, PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
-
-		up_read(&mm->mmap_sem);
-		mmput(mm);
 	}
+	up_write(&mm->mmap_sem);
+	mmput(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
 
-- 
2.21.0.352.gf09ad66450-goog

