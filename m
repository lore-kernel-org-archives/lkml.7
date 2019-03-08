Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15047C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC28620449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049640;
	bh=Jum0vySXMqLaQBofYTLAwsRSd6M8wmbOBBe3ADvG0X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lt5l5l+0pcFkfh+4CUoEp1XxBb2F4+XARxKtoho7uK5KN+Lw/js8dfkPDplWlAM/9
	 zIQuqtWsxoHwF6AXZQMBT8W2hMb6JTBUh0Uo7lrrZrEpvi9lnLe8ZiwHsGZ3TCId9+
	 QlYtb5c82+7KSa9d8hnft0SFoKUFArJ1MpQ7BTCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCHMx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfCHMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857D820449;
        Fri,  8 Mar 2019 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049636;
        bh=Jum0vySXMqLaQBofYTLAwsRSd6M8wmbOBBe3ADvG0X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RX3XEfbiQn5DxVx4fplDX8jqZkV2a+dN26I7OX1cBz0B8T7MrPdK+jbbF8MMDwfiY
         NhkXowPD0GAqAgHxsAxyeuCYqDis4QukFMdJ+i9mlVbzkI4d08DDo7fcpIHNcdFeCm
         PP7P7Lfi0aG/l6UkOT1hVJBpKC15EyYNjoHQpD34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4.20 17/76] staging: android: ashmem: Avoid range_alloc() allocation with ashmem_mutex held.
Date:   Fri,  8 Mar 2019 13:49:29 +0100
Message-Id: <20190308124915.389907586@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit ecd182cbf4e107928077866399100228d2359c60 upstream.

ashmem_pin() is calling range_shrink() without checking whether
range_alloc() succeeded. Also, doing memory allocation with ashmem_mutex
held should be avoided because ashmem_shrink_scan() tries to hold it.

Therefore, move memory allocation for range_alloc() to ashmem_pin_unpin()
and make range_alloc() not to fail.

This patch is mostly meant for backporting purpose for fuzz testing on
stable/distributor kernels, for there is a plan to remove this code in
near future.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: stable@vger.kernel.org
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ashmem.c |   42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -171,19 +171,15 @@ static inline void lru_del(struct ashmem
  * @end:	   The ending page (inclusive)
  *
  * This function is protected by ashmem_mutex.
- *
- * Return: 0 if successful, or -ENOMEM if there is an error
  */
-static int range_alloc(struct ashmem_area *asma,
-		       struct ashmem_range *prev_range, unsigned int purged,
-		       size_t start, size_t end)
+static void range_alloc(struct ashmem_area *asma,
+			struct ashmem_range *prev_range, unsigned int purged,
+			size_t start, size_t end,
+			struct ashmem_range **new_range)
 {
-	struct ashmem_range *range;
-
-	range = kmem_cache_zalloc(ashmem_range_cachep, GFP_KERNEL);
-	if (!range)
-		return -ENOMEM;
+	struct ashmem_range *range = *new_range;
 
+	*new_range = NULL;
 	range->asma = asma;
 	range->pgstart = start;
 	range->pgend = end;
@@ -193,8 +189,6 @@ static int range_alloc(struct ashmem_are
 
 	if (range_on_lru(range))
 		lru_add(range);
-
-	return 0;
 }
 
 /**
@@ -596,7 +590,8 @@ static int get_name(struct ashmem_area *
  *
  * Caller must hold ashmem_mutex.
  */
-static int ashmem_pin(struct ashmem_area *asma, size_t pgstart, size_t pgend)
+static int ashmem_pin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
+		      struct ashmem_range **new_range)
 {
 	struct ashmem_range *range, *next;
 	int ret = ASHMEM_NOT_PURGED;
@@ -649,7 +644,7 @@ static int ashmem_pin(struct ashmem_area
 			 * second half and adjust the first chunk's endpoint.
 			 */
 			range_alloc(asma, range, range->purged,
-				    pgend + 1, range->pgend);
+				    pgend + 1, range->pgend, new_range);
 			range_shrink(range, range->pgstart, pgstart - 1);
 			break;
 		}
@@ -663,7 +658,8 @@ static int ashmem_pin(struct ashmem_area
  *
  * Caller must hold ashmem_mutex.
  */
-static int ashmem_unpin(struct ashmem_area *asma, size_t pgstart, size_t pgend)
+static int ashmem_unpin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
+			struct ashmem_range **new_range)
 {
 	struct ashmem_range *range, *next;
 	unsigned int purged = ASHMEM_NOT_PURGED;
@@ -689,7 +685,8 @@ restart:
 		}
 	}
 
-	return range_alloc(asma, range, purged, pgstart, pgend);
+	range_alloc(asma, range, purged, pgstart, pgend, new_range);
+	return 0;
 }
 
 /*
@@ -722,10 +719,17 @@ static int ashmem_pin_unpin(struct ashme
 	struct ashmem_pin pin;
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
+	struct ashmem_range *range = NULL;
 
 	if (copy_from_user(&pin, p, sizeof(pin)))
 		return -EFAULT;
 
+	if (cmd == ASHMEM_PIN || cmd == ASHMEM_UNPIN) {
+		range = kmem_cache_zalloc(ashmem_range_cachep, GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+	}
+
 	mutex_lock(&ashmem_mutex);
 	wait_event(ashmem_shrink_wait, !atomic_read(&ashmem_shrink_inflight));
 
@@ -750,10 +754,10 @@ static int ashmem_pin_unpin(struct ashme
 
 	switch (cmd) {
 	case ASHMEM_PIN:
-		ret = ashmem_pin(asma, pgstart, pgend);
+		ret = ashmem_pin(asma, pgstart, pgend, &range);
 		break;
 	case ASHMEM_UNPIN:
-		ret = ashmem_unpin(asma, pgstart, pgend);
+		ret = ashmem_unpin(asma, pgstart, pgend, &range);
 		break;
 	case ASHMEM_GET_PIN_STATUS:
 		ret = ashmem_get_pin_status(asma, pgstart, pgend);
@@ -762,6 +766,8 @@ static int ashmem_pin_unpin(struct ashme
 
 out_unlock:
 	mutex_unlock(&ashmem_mutex);
+	if (range)
+		kmem_cache_free(ashmem_range_cachep, range);
 
 	return ret;
 }


