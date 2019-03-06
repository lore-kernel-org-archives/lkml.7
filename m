Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3F9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AA9208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897184;
	bh=obCm7kvIGQhFEiwp/NeB0jUB6rfqphpJZYWc8O0++bo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hE7lZXoL2rBC0k4LDr/gi4OGZU6mHlaIOCnMr1MSO8kee2NedZeyjsnH5MqmzWrsx
	 WCY4tVhVPMWREustnEdMWyZm9X2bHtNFfxa+/EFMAN0LhNHAZy9b6ehD0vFapr27R4
	 QelypDVkD6G/HRhUHd16vDtAVp1W73J7Q4M450bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfCFSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:33:02 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46032 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfCFSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:33:01 -0500
Received: by mail-yw1-f65.google.com with SMTP id r188so10807964ywb.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GiR0KC9MFJL5pChBH/Fpr9kRr5m6tSZpizNaUarRicE=;
        b=buW0XFOxv3due+kdauEdgGNvpzshDu/hzth+rHXfPDKUr48WksNIZvVcq2Zt+6lki8
         6H6ytidUtQZZ4ab/QB4wF1wMF8s3+lIBITNTbz+a0QmNOkw23lEjYg/GXO/QAsD+dy6/
         mgXdJcWH7R2kiALAIVLez8St5c/WFha2FojwFra/X5jDfRtxptj0bzG/JL+QoS6xMU+a
         TMaFFQXc95zWt2/4iwHdrWUnbMFxkAY2dXvtTcTee9rONKdUKMLWQRMGNHSmhy126Fkh
         u1kkVxn/Wi3dBF8QT4xwAbLoigk8jMa1k1K50goivYWZegfMMuOmMiCpcRvxj1IKh28F
         QtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=GiR0KC9MFJL5pChBH/Fpr9kRr5m6tSZpizNaUarRicE=;
        b=XpEo5TzeGsVbd3GXDdb0W9kapF1CkkmGeDZONUWs8uQ4xtYjZDK+UjSqYjBr8Y1Jx5
         z/Pu83TEAw0oXlXi/5gugjD8VFgZ3SY+pLivdFoe9PTdlCkC9j4zKg7QOe7BmHF38w4y
         hlryz0izbi0lHaf+6rjqQJBI1u2h3o9mfeQvLrzBu15hGpketCw1a/610kxny3I8h08f
         rCZxqMSIrhSVIDWgeYCakaC1AAc4fhy68JGhLh7UANroJKv/ZI43ggzsdqYsUdbSSXO0
         MZC6uvJboxGADrEurC6YdCatqGi5sAU64BqzgbdJhGM/DZDoSOU0Ed11wKhLQcFRBY5Y
         SUhg==
X-Gm-Message-State: APjAAAWwCo0m4AcqUxHgPKJal3eT5AgDF2yAP7AhDGDA8x2ssSoqpo/M
        hIePExqZcxKSW10aXRgtWKRX96C/
X-Google-Smtp-Source: APXvYqwjxc7ptOQ2dFtEtxGwUAma5m+A6U2+ZcmlSwU2z0HPFjRvEp610aNuujDaNap7LOWAs7crhg==
X-Received: by 2002:a25:42d8:: with SMTP id p207mr7846249yba.279.1551897179757;
        Wed, 06 Mar 2019 10:32:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::2:a2f4])
        by smtp.gmail.com with ESMTPSA id o132sm964630ywd.4.2019.03.06.10.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 10:32:59 -0800 (PST)
Date:   Wed, 6 Mar 2019 10:32:57 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.1-rc1
Message-ID: <20190306183257.GH50184@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

All trivial.  Two comment updates and one more initialization sanity
check in flush_work().

Thanks.

The following changes since commit d73aba1115cf40630cc8b4b7aed049ed8117b458:

  Merge tag 'drm-fixes-2019-01-25-1' of git://anongit.freedesktop.org/drm/drm (2019-01-25 12:19:10 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.1

for you to fetch changes up to bf393fd4a3c888e6d407968f461900481bd0c041:

  workqueue: Fix spelling in source code comments (2019-03-05 07:52:39 -0800)

----------------------------------------------------------------
Bart Van Assche (1):
      workqueue: Fix spelling in source code comments

Liu Song (1):
      workqueue: fix typo in comment

Tetsuo Handa (1):
      workqueue: Try to catch flush_work() without INIT_WORK().

 kernel/workqueue.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 392be4b252f6..1ef68ac89162 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -646,7 +646,7 @@ static void set_work_pool_and_clear_pending(struct work_struct *work,
 	 * The following mb guarantees that previous clear of a PENDING bit
 	 * will not be reordered with any speculative LOADS or STORES from
 	 * work->current_func, which is executed afterwards.  This possible
-	 * reordering can lead to a missed execution on attempt to qeueue
+	 * reordering can lead to a missed execution on attempt to queue
 	 * the same @work.  E.g. consider this case:
 	 *
 	 *   CPU#0                         CPU#1
@@ -1321,7 +1321,7 @@ static bool is_chained_work(struct workqueue_struct *wq)
 
 	worker = current_wq_worker();
 	/*
-	 * Return %true iff I'm a worker execuing a work item on @wq.  If
+	 * Return %true iff I'm a worker executing a work item on @wq.  If
 	 * I'm @worker, it's safe to dereference it without locking.
 	 */
 	return worker && worker->current_pwq->wq == wq;
@@ -1619,7 +1619,7 @@ static void rcu_work_rcufn(struct rcu_head *rcu)
  *
  * Return: %false if @rwork was already pending, %true otherwise.  Note
  * that a full RCU grace period is guaranteed only after a %true return.
- * While @rwork is guarnateed to be executed after a %false return, the
+ * While @rwork is guaranteed to be executed after a %false return, the
  * execution may happen before a full RCU grace period has passed.
  */
 bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
@@ -2908,6 +2908,9 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!wq_online))
 		return false;
 
+	if (WARN_ON(!work->func))
+		return false;
+
 	if (!from_cancel) {
 		lock_map_acquire(&work->lockdep_map);
 		lock_map_release(&work->lockdep_map);
