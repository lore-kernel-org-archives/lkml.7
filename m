Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC5C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B84121744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9CCdO8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfD3N0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:26:02 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42272 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfD3NZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id f82so2010432qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5l0a3uzMK38mxhU43HR3pLkdTsHYkFU/5p0+WtYx5vA=;
        b=g9CCdO8J183ztwieMKtxq5bQgdPwn8MyKUl5zlyySPt09tOB1Gypd0bdF1FTgPWg9U
         vgl3VSH+QbfWqwQxuQNAq18fHGv2grDucix13/YUy3bvOI1BB9BrzAgOyNFI+ychptbo
         BVp24qrS90whe3PqSvAaQ8Kncxvv8pqzjLbVvi9smoyLBamx2Dg/fg59oj/C1VgTZmLk
         po6sIoVdSb935f+/5YJnlpWSaOQYjK3//t7Ql3k3IgbH35nE1TWkeZ08/rMUWbwR2R7Q
         rNZsAyxKMZqUS4nVVdVnnh9Mowjk/e6QvbUTkAZYjeM7AIkIVd6G6w9+5n4IsjstGWE8
         jwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5l0a3uzMK38mxhU43HR3pLkdTsHYkFU/5p0+WtYx5vA=;
        b=k+NVOKMp/8YWz5Nne28bAFBMTiZ2/d8lrKV/0qhccHtFm7rplh0zMnWs9uhpRhfBf3
         mjw79k8iwovR1ZKdOYtZGpyM6RDXqx5aAeF6lwsVDCxv86a7nilfDSp0KiwiSujK3Jhw
         GimzCf7hhgOTIMjU0hAZvT7F7htT9CtlzFlpjVW4GY4N6LLFKpNKHl/AlmmIWqOiX80f
         lzyEc1HQhnqcvrwgAA+YkW9ovirHNVEvXH2tmaDwwhxt0JlmgrDliWaUEokmW71U9BXH
         v3XXx35dp0TBAJWE+xMi+n1DRqZxC9ZVkw/pjLsIYNTM5yS8b1CloHSFg5QGvJGTLLp0
         Bs5A==
X-Gm-Message-State: APjAAAXUievqpMaygD1RSP1R26pVxtbh+SG0MfjNaz6dXJUcNG9Q192R
        fBUgDi0fZnIE9eR/tFUCn7B5kEHnSAAP4PLQ
X-Google-Smtp-Source: APXvYqzcKJMSJm3saTG/Jy9RV9wnqiRL/1GQ7HSUwiNcvOVWaTtiFz1xHas1LLHxgSsag1rnBPh3sxDf1Qf0ekUW
X-Received: by 2002:a05:6214:18d:: with SMTP id q13mr1705396qvr.213.1556630757432;
 Tue, 30 Apr 2019 06:25:57 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:09 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <05c0c078b8b5984af4cc3b105a58c711dcd83342.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 13/17] IB/mlx4, arm64: untag user pointers in mlx4_get_umem_mr
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 395379a480cb..9a35ed2c6a6f 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -378,6 +378,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
+		unsigned long untagged_start = untagged_addr(start);
 		struct vm_area_struct *vma;
 
 		down_read(&current->mm->mmap_sem);
@@ -386,9 +387,9 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 		 * cover the memory, but for now it requires a single vma to
 		 * entirely cover the MR to support RO mappings.
 		 */
-		vma = find_vma(current->mm, start);
-		if (vma && vma->vm_end >= start + length &&
-		    vma->vm_start <= start) {
+		vma = find_vma(current->mm, untagged_start);
+		if (vma && vma->vm_end >= untagged_start + length &&
+		    vma->vm_start <= untagged_start) {
 			if (vma->vm_flags & VM_WRITE)
 				access_flags |= IB_ACCESS_LOCAL_WRITE;
 		} else {
-- 
2.21.0.593.g511ec345e18-goog

