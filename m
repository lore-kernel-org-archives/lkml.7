Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDDE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139946;
	bh=ZrYRu+KzVZ9sDLamHmf+86m8060dm5AcAEW+8GFR7kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxbAhT+h8SthQILZ1HMziMeliSKxlRcpNyLav9nFJ4f3BjAF22TKm+UjyJFF06VKL
	 9mLwwTxX5ZLunlYDI20Xj1w+zxKnZpB2l/zSR+b2tOZHLxw8UcgmYGiZk74BDvpvOB
	 nELCt3reFivsuoS1HOfyigGchkOS4wRZu2rA2AZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfDARcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfDARcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E9620880;
        Mon,  1 Apr 2019 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139941;
        bh=ZrYRu+KzVZ9sDLamHmf+86m8060dm5AcAEW+8GFR7kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qMMybO2ftffdkg++mAPpVZEqwJkOXzaKzh6Pinlk1hWo/GL9NHaGa71xtPwhVmguC
         fin3cqn536Wq3cDHsuihfjL9kCzMi/r+hTpf9OnRo/baFC0LhaGHuDbNzSmGMczgYy
         9zW9IlKMSEC04N4UYx6vPoflBUoyegMBGc/DwfWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 059/131] stm class: Fix link list locking
Date:   Mon,  1 Apr 2019 19:02:09 +0200
Message-Id: <20190401170057.249309376@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c74f7e8281add80bdfa0ad2998b8df287b13df73 ]

Currently, the list of stm_sources linked to an stm device is protected by
a spinlock, which also means that sources' .unlink() method is called under
this spinlock. However, this method may (and does) sleep, which means
trouble.

This patch slightly reworks locking around stm::link_list so that bits that
might_sleep() are called with a mutex held instead. Modification of this
list requires both mutex and spinlock to be held, while looking at the list
can be done under either mutex or spinlock.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 38 +++++++++++++++++++++++++++---------
 drivers/hwtracing/stm/stm.h  |  1 +
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 92ab51aa8a74..f286de2e86af 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -647,6 +647,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	if (err)
 		goto err_device;
 
+	mutex_init(&stm->link_mutex);
 	spin_lock_init(&stm->link_lock);
 	INIT_LIST_HEAD(&stm->link_list);
 
@@ -677,11 +678,11 @@ void stm_unregister_device(struct stm_data *stm_data)
 	struct stm_source_device *src, *iter;
 	int i;
 
-	spin_lock(&stm->link_lock);
+	mutex_lock(&stm->link_mutex);
 	list_for_each_entry_safe(src, iter, &stm->link_list, link_entry) {
 		__stm_source_link_drop(src, stm);
 	}
-	spin_unlock(&stm->link_lock);
+	mutex_unlock(&stm->link_mutex);
 
 	synchronize_srcu(&stm_source_srcu);
 
@@ -700,6 +701,17 @@ void stm_unregister_device(struct stm_data *stm_data)
 }
 EXPORT_SYMBOL_GPL(stm_unregister_device);
 
+/*
+ * stm::link_list access serialization uses a spinlock and a mutex; holding
+ * either of them guarantees that the list is stable; modification requires
+ * holding both of them.
+ *
+ * Lock ordering is as follows:
+ *   stm::link_mutex
+ *     stm::link_lock
+ *       src::link_lock
+ */
+
 /**
  * stm_source_link_add() - connect an stm_source device to an stm device
  * @src:	stm_source device
@@ -716,6 +728,7 @@ static int stm_source_link_add(struct stm_source_device *src,
 	char *id;
 	int err;
 
+	mutex_lock(&stm->link_mutex);
 	spin_lock(&stm->link_lock);
 	spin_lock(&src->link_lock);
 
@@ -725,6 +738,7 @@ static int stm_source_link_add(struct stm_source_device *src,
 
 	spin_unlock(&src->link_lock);
 	spin_unlock(&stm->link_lock);
+	mutex_unlock(&stm->link_mutex);
 
 	id = kstrdup(src->data->name, GFP_KERNEL);
 	if (id) {
@@ -762,6 +776,7 @@ static int stm_source_link_add(struct stm_source_device *src,
 	stm_put_device(stm);
 
 fail_detach:
+	mutex_lock(&stm->link_mutex);
 	spin_lock(&stm->link_lock);
 	spin_lock(&src->link_lock);
 
@@ -770,6 +785,7 @@ static int stm_source_link_add(struct stm_source_device *src,
 
 	spin_unlock(&src->link_lock);
 	spin_unlock(&stm->link_lock);
+	mutex_unlock(&stm->link_mutex);
 
 	return err;
 }
@@ -782,13 +798,20 @@ static int stm_source_link_add(struct stm_source_device *src,
  * If @stm is @src::link, disconnect them from one another and put the
  * reference on the @stm device.
  *
- * Caller must hold stm::link_lock.
+ * Caller must hold stm::link_mutex.
  */
 static void __stm_source_link_drop(struct stm_source_device *src,
 				   struct stm_device *stm)
 {
 	struct stm_device *link;
 
+	lockdep_assert_held(&stm->link_mutex);
+
+	if (src->data->unlink)
+		src->data->unlink(src->data);
+
+	/* for stm::link_list modification, we hold both mutex and spinlock */
+	spin_lock(&stm->link_lock);
 	spin_lock(&src->link_lock);
 	link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
 	if (WARN_ON_ONCE(link != stm)) {
@@ -797,13 +820,13 @@ static void __stm_source_link_drop(struct stm_source_device *src,
 	}
 
 	stm_output_free(link, &src->output);
-	/* caller must hold stm::link_lock */
 	list_del_init(&src->link_entry);
 	/* matches stm_find_device() from stm_source_link_store() */
 	stm_put_device(link);
 	rcu_assign_pointer(src->link, NULL);
 
 	spin_unlock(&src->link_lock);
+	spin_unlock(&stm->link_lock);
 }
 
 /**
@@ -825,12 +848,9 @@ static void stm_source_link_drop(struct stm_source_device *src)
 	stm = srcu_dereference(src->link, &stm_source_srcu);
 
 	if (stm) {
-		if (src->data->unlink)
-			src->data->unlink(src->data);
-
-		spin_lock(&stm->link_lock);
+		mutex_lock(&stm->link_mutex);
 		__stm_source_link_drop(src, stm);
-		spin_unlock(&stm->link_lock);
+		mutex_unlock(&stm->link_mutex);
 	}
 
 	srcu_read_unlock(&stm_source_srcu, idx);
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 95ece0292c99..97ee02241440 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -45,6 +45,7 @@ struct stm_device {
 	int			major;
 	unsigned int		sw_nmasters;
 	struct stm_data		*data;
+	struct mutex		link_mutex;
 	spinlock_t		link_lock;
 	struct list_head	link_list;
 	/* master allocation */
-- 
2.19.1



