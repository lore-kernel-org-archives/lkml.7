Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FCC21473
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922387;
	bh=s47Uhp1iUbxMZiQQeK4TXSLc0gqXh9q1+g404qyEEcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BO+pSv7JbwGfVy/xhExays8pD7UJg3KagpmnwQoWtOIk0gUiKZ0scKQetwaIpWkXW
	 sqRlFl1jSvJK4yN0+a0rndnVh8RfGR+ZIRrIBY02c++ypQZpVy8fE9vARiPws9+vEp
	 0ILNgWk5RR5lrbWeWDwWKp8HK6QF+z1H2IIUZhwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfFGPq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfFGPqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:46:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392B7212F5;
        Fri,  7 Jun 2019 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922382;
        bh=s47Uhp1iUbxMZiQQeK4TXSLc0gqXh9q1+g404qyEEcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2LZeNzwlG3W1bEXVo9Cx24FzP4UaLJ09ylRsMzOilsHxZ4i4bBviwoIM5wPYYc2Zs
         3mdCYX7SvLLtJhkz+h6qajN0akyPWlIAZuTRP2rawgPNZzCBUQb6Iyrp0zUVYfo/DZ
         gdbc/WvxoDgZJF72R85TU20tOqLTPlGIqibQs5uA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "ben.hutchings@codethink.co.uk, Alexander.Levin@microsoft.com, Joel
        Fernandes" <joel@joelfernandes.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4.19 66/73] binder: fix race between munmap() and direct reclaim
Date:   Fri,  7 Jun 2019 17:39:53 +0200
Message-Id: <20190607153856.244707743@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@android.com>

commit 5cec2d2e5839f9c0fec319c523a911e0a7fd299f upstream.

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

Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder_alloc.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -958,14 +958,13 @@ enum lru_status binder_alloc_free_page(s
 
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
-		if (!down_write_trylock(&mm->mmap_sem))
-			goto err_down_write_mmap_sem_failed;
-	}
 
 	list_lru_isolate(lru, item);
 	spin_unlock(lock);
@@ -978,10 +977,9 @@ enum lru_status binder_alloc_free_page(s
 			       PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
-
-		up_write(&mm->mmap_sem);
-		mmput(mm);
 	}
+	up_write(&mm->mmap_sem);
+	mmput(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
 


