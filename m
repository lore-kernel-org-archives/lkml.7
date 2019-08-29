Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC035C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2991233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567075957;
	bh=L1yVC3rnPFRRolPJlkmoEEORLM7PJgCXDPecs1CxcTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2lsXfq4/xX63tX1d0vzjd+dmFgQ8vKkxC3p9mkaFRtpL3ifl9COzIrHw2Vy5uOq+
	 PSFdVmIUbiLmJp2KqfZrfwGBl9rFZ3tgflFmzoFeJxBPo95YKup3BuckqE6p5l31PP
	 iky2kSVIm1sFeTmnymbbF+kTzOQA5H5Z1qRpK8U8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfH2KvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbfH2Kuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:50:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA412173E;
        Thu, 29 Aug 2019 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567075849;
        bh=L1yVC3rnPFRRolPJlkmoEEORLM7PJgCXDPecs1CxcTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilPqGS73Z/N0d4nvJJQ+AkbPPI6iP2RnNbr1gsxoGXINDheHjck+G0zWwZ1OSpUQV
         KldS1Nlw757lhEXd1rMnXOnKzE3dSWIT/RjUkKelsG5SWA8AmHYtYk7NZ0DdBkf1TR
         NjL2c7frt/GHwPphnE1ZM6VYpggQaYpTcHnCLL50=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@canonical.com>, Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 05/14] binder: take read mode of mmap_sem in binder_alloc_free_page()
Date:   Thu, 29 Aug 2019 06:50:34 -0400
Message-Id: <20190829105043.2508-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829105043.2508-1-sashal@kernel.org>
References: <20190829105043.2508-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tyler Hicks <tyhicks@canonical.com>

[ Upstream commit 60d4885710836595192c42d3e04b27551d30ec91 ]

Restore the behavior of locking mmap_sem for reading in
binder_alloc_free_page(), as was first done in commit 3013bf62b67a
("binder: reduce mmap_sem write-side lock"). That change was
inadvertently reverted by commit 5cec2d2e5839 ("binder: fix race between
munmap() and direct reclaim").

In addition, change the name of the label for the error path to
accurately reflect that we're taking the lock for reading.

Backporting note: This fix is only needed when *both* of the commits
mentioned above are applied. That's an unlikely situation since they
both landed during the development of v5.1 but only one of them is
targeted for stable.

Fixes: 5cec2d2e5839 ("binder: fix race between munmap() and direct reclaim")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Acked-by: Todd Kjos <tkjos@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/android/binder_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e0b0399ff7ec8..81c67459259ec 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -949,8 +949,8 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mm = alloc->vma_vm_mm;
 	if (!mmget_not_zero(mm))
 		goto err_mmget;
-	if (!down_write_trylock(&mm->mmap_sem))
-		goto err_down_write_mmap_sem_failed;
+	if (!down_read_trylock(&mm->mmap_sem))
+		goto err_down_read_mmap_sem_failed;
 	vma = binder_alloc_get_vma(alloc);
 
 	list_lru_isolate(lru, item);
@@ -965,7 +965,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
-	up_write(&mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 	mmput(mm);
 
 	trace_binder_unmap_kernel_start(alloc, index);
@@ -980,7 +980,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	mutex_unlock(&alloc->mutex);
 	return LRU_REMOVED_RETRY;
 
-err_down_write_mmap_sem_failed:
+err_down_read_mmap_sem_failed:
 	mmput_async(mm);
 err_mmget:
 err_page_already_freed:
-- 
2.20.1

