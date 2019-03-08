Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D830C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CF520661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050261;
	bh=HhpyA9SlxQyZzhW83zy6W0aqUiyD4EPXzT7rHqCafBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+7uRQSTjsATvQLAaIZ2vSpBHaPS4WLba7dEqc8I3sQ841fLpy2VmXgDFAYvTJ9MV
	 BujSMpP3BLG5gJplBDsQaonm0OLDLs0YT/hzGVY//RVbKQZdn0SODPtM3FXZhQRGkP
	 fzSTltAOxH0k5RxjfqhQXAaQbPV8fhy7x754uiHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCHM5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfCHM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:57:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBA620449;
        Fri,  8 Mar 2019 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049864;
        bh=HhpyA9SlxQyZzhW83zy6W0aqUiyD4EPXzT7rHqCafBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euTFf2n9MTLVwZIJFJ+fMuVFvbAAss8MUcX4sqpI2rt/E/rByGNbiNsNTDA1hfvzY
         0u9CQB9pzK2n7noU+eWnjYVP9FrwpM+bnPPkfPd3LYnd+j/PJMgWAvJrwVueRKZwm9
         E/Muj//QXq/XNnWQFvpIKm6/C9UWG98YbpSVzWuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com>,
        syzbot <syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com>,
        syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 4.19 11/68] staging: android: ashmem: Dont call fallocate() with ashmem_mutex held.
Date:   Fri,  8 Mar 2019 13:49:41 +0100
Message-Id: <20190308124911.357363186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit fb4415a12632f0b9078a0aa80c16745d48fcfc74 upstream.

syzbot is hitting lockdep warnings [1][2][3]. This patch tries to fix
the warning by eliminating ashmem_shrink_scan() => {shmem|vfs}_fallocate()
sequence.

[1] https://syzkaller.appspot.com/bug?id=87c399f6fa6955006080b24142e2ce7680295ad4
[2] https://syzkaller.appspot.com/bug?id=7ebea492de7521048355fc84210220e1038a7908
[3] https://syzkaller.appspot.com/bug?id=e02419c12131c24e2a957ea050c2ab6dcbbc3270

Reported-by: syzbot <syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+4b8b031b89e6b96c4b2e@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable@vger.kernel.org
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -75,6 +75,9 @@ struct ashmem_range {
 /* LRU list of unpinned pages, protected by ashmem_mutex */
 static LIST_HEAD(ashmem_lru_list);
 
+static atomic_t ashmem_shrink_inflight = ATOMIC_INIT(0);
+static DECLARE_WAIT_QUEUE_HEAD(ashmem_shrink_wait);
+
 /*
  * long lru_count - The count of pages on our LRU list.
  *
@@ -438,7 +441,6 @@ out:
 static unsigned long
 ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct ashmem_range *range, *next;
 	unsigned long freed = 0;
 
 	/* We might recurse into filesystem code, so bail out if necessary */
@@ -448,21 +450,33 @@ ashmem_shrink_scan(struct shrinker *shri
 	if (!mutex_trylock(&ashmem_mutex))
 		return -1;
 
-	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
+	while (!list_empty(&ashmem_lru_list)) {
+		struct ashmem_range *range =
+			list_first_entry(&ashmem_lru_list, typeof(*range), lru);
 		loff_t start = range->pgstart * PAGE_SIZE;
 		loff_t end = (range->pgend + 1) * PAGE_SIZE;
+		struct file *f = range->asma->file;
 
-		range->asma->file->f_op->fallocate(range->asma->file,
-				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				start, end - start);
+		get_file(f);
+		atomic_inc(&ashmem_shrink_inflight);
 		range->purged = ASHMEM_WAS_PURGED;
 		lru_del(range);
 
 		freed += range_size(range);
+		mutex_unlock(&ashmem_mutex);
+		f->f_op->fallocate(f,
+				   FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				   start, end - start);
+		fput(f);
+		if (atomic_dec_and_test(&ashmem_shrink_inflight))
+			wake_up_all(&ashmem_shrink_wait);
+		if (!mutex_trylock(&ashmem_mutex))
+			goto out;
 		if (--sc->nr_to_scan <= 0)
 			break;
 	}
 	mutex_unlock(&ashmem_mutex);
+out:
 	return freed;
 }
 
@@ -713,6 +727,7 @@ static int ashmem_pin_unpin(struct ashme
 		return -EFAULT;
 
 	mutex_lock(&ashmem_mutex);
+	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
 
 	if (!asma->file)
 		goto out_unlock;


