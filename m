Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F2021473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139966;
	bh=EWYuy86ytO58Hfp5f8HnZdh8f0FZ9lzLCSM/tXjXDdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qHQ9ffrLL13wXVgUMa5rTlx39B6mYL4zczzvba0OCX20B1DNCk0iFOqpKi4kGJfz
	 R/Xg+6eGp2tTPtqZ6wq5Y0iDF6oYMHO5GBT6oj8VOtyRQ8q+5dClwelTTPShjdhxUV
	 sFkO/teJHYcWQ1kDjiO0qBFrcSz3oGHsVQrlWGhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfDARcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732841AbfDARcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC34C2146E;
        Mon,  1 Apr 2019 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139961;
        bh=EWYuy86ytO58Hfp5f8HnZdh8f0FZ9lzLCSM/tXjXDdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5rMRCnAsUNxLemXqra14Ywtc+IvWaglBHX59D1GiDwUSEFUPrJVnyfClJnHMhWoR
         JHYaugSzgAQrDNTzoR2uHEjqCLsTwPq8nVqggbkBTVAsoM8xDzVO92mbdD6TZvHI60
         mUU7Wmc44jV9118qXc3qWaDUVBicbt1vizHQM9Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 065/131] stm class: Fix a race in unlinking
Date:   Mon,  1 Apr 2019 19:02:15 +0200
Message-Id: <20190401170057.667707604@linuxfoundation.org>
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

[ Upstream commit b4ca34aaf78ed0cdfc15956d377064104257a437 ]

There is a window in stm_source_link_drop(), during which the source's
link may change before locks are acquired. When this happens, it throws
a warning, since this is not an expected scenario.

This patch handles the race in such a way that if the link appears to
have changed by the time we took the locks, it will release them and
repeat the whole unlinking procedure from the beginning, unless the
other contender beat us to it.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/stm/core.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index cdc692d6cedd..03b34dcff7f2 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -695,18 +695,26 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 }
 EXPORT_SYMBOL_GPL(stm_register_device);
 
-static void __stm_source_link_drop(struct stm_source_device *src,
-				   struct stm_device *stm);
+static int __stm_source_link_drop(struct stm_source_device *src,
+				  struct stm_device *stm);
 
 void stm_unregister_device(struct stm_data *stm_data)
 {
 	struct stm_device *stm = stm_data->stm;
 	struct stm_source_device *src, *iter;
-	int i;
+	int i, ret;
 
 	mutex_lock(&stm->link_mutex);
 	list_for_each_entry_safe(src, iter, &stm->link_list, link_entry) {
-		__stm_source_link_drop(src, stm);
+		ret = __stm_source_link_drop(src, stm);
+		/*
+		 * src <-> stm link must not change under the same
+		 * stm::link_mutex, so complain loudly if it has;
+		 * also in this situation ret!=0 means this src is
+		 * not connected to this stm and it should be otherwise
+		 * safe to proceed with the tear-down of stm.
+		 */
+		WARN_ON_ONCE(ret);
 	}
 	mutex_unlock(&stm->link_mutex);
 
@@ -825,22 +833,28 @@ static int stm_source_link_add(struct stm_source_device *src,
  *
  * Caller must hold stm::link_mutex.
  */
-static void __stm_source_link_drop(struct stm_source_device *src,
-				   struct stm_device *stm)
+static int __stm_source_link_drop(struct stm_source_device *src,
+				  struct stm_device *stm)
 {
 	struct stm_device *link;
+	int ret = 0;
 
 	lockdep_assert_held(&stm->link_mutex);
 
-	if (src->data->unlink)
-		src->data->unlink(src->data);
-
 	/* for stm::link_list modification, we hold both mutex and spinlock */
 	spin_lock(&stm->link_lock);
 	spin_lock(&src->link_lock);
 	link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
-	if (WARN_ON_ONCE(link != stm))
+
+	/*
+	 * The linked device may have changed since we last looked, because
+	 * we weren't holding the src::link_lock back then; if this is the
+	 * case, tell the caller to retry.
+	 */
+	if (link != stm) {
+		ret = -EAGAIN;
 		goto unlock;
+	}
 
 	stm_output_free(link, &src->output);
 	list_del_init(&src->link_entry);
@@ -851,6 +865,11 @@ static void __stm_source_link_drop(struct stm_source_device *src,
 unlock:
 	spin_unlock(&src->link_lock);
 	spin_unlock(&stm->link_lock);
+
+	if (!ret && src->data->unlink)
+		src->data->unlink(src->data);
+
+	return ret;
 }
 
 /**
@@ -866,18 +885,29 @@ static void __stm_source_link_drop(struct stm_source_device *src,
 static void stm_source_link_drop(struct stm_source_device *src)
 {
 	struct stm_device *stm;
-	int idx;
+	int idx, ret;
 
+retry:
 	idx = srcu_read_lock(&stm_source_srcu);
+	/*
+	 * The stm device will be valid for the duration of this
+	 * read section, but the link may change before we grab
+	 * the src::link_lock in __stm_source_link_drop().
+	 */
 	stm = srcu_dereference(src->link, &stm_source_srcu);
 
+	ret = 0;
 	if (stm) {
 		mutex_lock(&stm->link_mutex);
-		__stm_source_link_drop(src, stm);
+		ret = __stm_source_link_drop(src, stm);
 		mutex_unlock(&stm->link_mutex);
 	}
 
 	srcu_read_unlock(&stm_source_srcu, idx);
+
+	/* if it did change, retry */
+	if (ret == -EAGAIN)
+		goto retry;
 }
 
 static ssize_t stm_source_link_show(struct device *dev,
-- 
2.19.1



