Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F6C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F84821734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625100;
	bh=QMKhlt3BS7uu0HAFlCN4qcRiUtHGvuEBPQthGHlGW0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyefnEeBPw+Y8dGlSmccO2d1w6O4v+m36JyH3XrhvRNd+j8Hw7FvtFpDuXkXL+gPc
	 v5+KvzEzWBNa6einRYo99CvM6ZKTU4XnwXHywMWfuvEN0ovAeoY0UXef6Mq1okvfFV
	 Aj8szW5GpCZlCO1bVibpq3y/Ert2Xm9yijvRdEos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfD3Lvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbfD3Lvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F222054F;
        Tue, 30 Apr 2019 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625095;
        bh=QMKhlt3BS7uu0HAFlCN4qcRiUtHGvuEBPQthGHlGW0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDjVcFvhxFPTwLc/tr6/aLKmxCDwV2xAes1ooWP0qShVWVIZHSG48wai8Q/rftFjG
         V13G6rmijzspsPGTMHJ8pxCvy9sXEugsA/QL4qULCjmnnRl5CXwJLRxGwqWYRvGSOC
         Z2U3zBBqHN9lFJDFoUYbTk9ZTcmXO9JWxO5kmsMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
Subject: [PATCH 5.0 53/89] binder: fix handling of misaligned binder object
Date:   Tue, 30 Apr 2019 13:38:44 +0200
Message-Id: <20190430113612.171167211@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@android.com>

commit 26528be6720bb40bc8844e97ee73a37e530e9c5e upstream.

Fixes crash found by syzbot:
kernel BUG at drivers/android/binder_alloc.c:LINE! (2)

Reported-and-tested-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
Signed-off-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: stable <stable@vger.kernel.org> # 5.0, 4.19, 4.14
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder_alloc.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -959,14 +959,13 @@ enum lru_status binder_alloc_free_page(s
 
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
@@ -979,10 +978,9 @@ enum lru_status binder_alloc_free_page(s
 			       PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
-
-		up_write(&mm->mmap_sem);
-		mmput(mm);
 	}
+	up_write(&mm->mmap_sem);
+	mmput(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
 


