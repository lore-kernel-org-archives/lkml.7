Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC65C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7880E215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570210539;
	bh=vswXn9bVUS1NjpLa4r3F9UqpE+nv0AHEu7eaTUx/4YA=;
	h=Date:From:To:Subject:List-ID:From;
	b=tkojx7x0UX99N3TIgzGzzCFYfNMX5/tw0M+4FZgTlE64fPNJ+2m2MEsZSViU0XqdB
	 gEyQl84yoimNHPfsCb9U6jh8oMPjysV3G5K/WKJBl7WNNjF+lQUCNqsnGfYn5gE9WP
	 FcT390g0ThXQhzGHpJCByuoHKrWlppSh1IhPl9EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfJDRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:35:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45028 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfJDRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:35:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so9596636qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a144TA2Cr2FVasjy1SZyP/1P9SMWRYxWQqK2LgWfLko=;
        b=pzYP/mPyt+H2P666eIidvb2nAvhWbgF4v/Io84aPNYmqpoP+ZWHrY0ulTEbIJlraYs
         OLpqbHnP1EBsrzd9ebRjqEad2CpkV+p+k/LRKd/DHhoAM9bb2iKEnLezEsgHYaFtTrQ8
         Am+9APYie1SHv1j4trsQbDMsfbH5+0/q0RpB3nRO5adW+taXLMwzWy6+p9rZH7MUBe+1
         yaOl+ZBIontECJe5yQhHOZWM6p0Y0dSR0F4d/7rCjNKFBLu1oD8bjdjZ+KSe95G/s/Vw
         /vXCDMmUMxga97ujMURtnmNMrVAoj4v63yu19UWEcs0iR9AFhmHfcWi8MRqqkBpZI1fx
         jpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=a144TA2Cr2FVasjy1SZyP/1P9SMWRYxWQqK2LgWfLko=;
        b=jsnMwXLhdcc2+iZudIdhcTWxDMOmpnp6QhzYlFa0C8iw3up2sFh8JZnIk0paVlwUcZ
         gdSW1WNDzFC8hky+OuzR2w601wLxawOxTyTLASEHx4cRfofyzVIsci5HVz07mf+asj1a
         kuTP3wESWql39FrmsQKN2xKyGRRS+xzahRIHBwbOuWEvvXWE8q5pP6NdiNAkb8Uf5gZ3
         TZFnPqtxD9Cv4fWRCvhkjY4wiEUYE+IdPslD0PZBn6i9mzha5kguLfz/Lg46px9Cm6x+
         FRSqcwFzviO3In+ocp82XQD2cpt7LXQ+Cuc834oQEZY9pzfpcR11XEQJHNMf6peWPToQ
         WFKw==
X-Gm-Message-State: APjAAAUd3n3OB6TiKmoDxeF3q+GrxNpyYlK+L/s3kEw1tIKlEfvl+TR7
        o3XTBGNhL3SC9dgSZaYGV5Q=
X-Google-Smtp-Source: APXvYqz0oqBlfhQ77EB8UiEY7M6mHeNtnzsg0NKbUob40PGFg8KylYzwJQqJOePfAf8Ep9S7IAXcPA==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr2965266qvb.50.1570210537389;
        Fri, 04 Oct 2019 10:35:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::91c3])
        by smtp.gmail.com with ESMTPSA id d55sm3971449qta.41.2019.10.04.10.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:35:36 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:35:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH wq/for-5.4-fixes] workqueue: more destroy_workqueue() fixes
Message-ID: <20191004173534.GA3404308@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From c29eb85386880750130a01aabf288408a6614d65 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 23 Sep 2019 11:08:58 -0700
Subject: [PATCH] workqueue: more destroy_workqueue() fixes

destroy_workqueue() warnings still, at a lower frequency, trigger
spuriously.  The problem seems to be in-flight operations which
haven't reached put_pwq() yet.

* Make sanity check grab all the related locks so that it's
  synchronized against operations which puts pwq at the end.

* Always print out the offending pwq.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Williams, Gerald S" <gerald.s.williams@intel.com>
---
Applying to wq/for-5.4-fixes to plug the remaining holes during
destruction sanity checks.

Thanks.

 kernel/workqueue.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7f7aa45dac37..4a3c30177b94 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -355,6 +355,7 @@ EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
+static void show_pwq(struct pool_workqueue *pwq);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
@@ -4314,6 +4315,22 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 }
 EXPORT_SYMBOL_GPL(alloc_workqueue);
 
+static bool pwq_busy(struct pool_workqueue *pwq)
+{
+	int i;
+
+	for (i = 0; i < WORK_NR_COLORS; i++)
+		if (pwq->nr_in_flight[i])
+			return true;
+
+	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
+		return true;
+	if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+		return true;
+
+	return false;
+}
+
 /**
  * destroy_workqueue - safely terminate a workqueue
  * @wq: target workqueue
@@ -4348,28 +4365,28 @@ void destroy_workqueue(struct workqueue_struct *wq)
 		kfree(rescuer);
 	}
 
-	/* sanity checks */
+	/*
+	 * Sanity checks - grab all the locks so that we wait for all
+	 * in-flight operations which may do put_pwq().
+	 */
+	mutex_lock(&wq_pool_mutex);
 	mutex_lock(&wq->mutex);
 	for_each_pwq(pwq, wq) {
-		int i;
-
-		for (i = 0; i < WORK_NR_COLORS; i++) {
-			if (WARN_ON(pwq->nr_in_flight[i])) {
-				mutex_unlock(&wq->mutex);
-				show_workqueue_state();
-				return;
-			}
-		}
-
-		if (WARN_ON((pwq != wq->dfl_pwq) && (pwq->refcnt > 1)) ||
-		    WARN_ON(pwq->nr_active) ||
-		    WARN_ON(!list_empty(&pwq->delayed_works))) {
+		spin_lock_irq(&pwq->pool->lock);
+		if (WARN_ON(pwq_busy(pwq))) {
+			pr_warning("%s: %s has the following busy pwq (refcnt=%d)\n",
+				   __func__, wq->name, pwq->refcnt);
+			show_pwq(pwq);
+			spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
+			mutex_unlock(&wq_pool_mutex);
 			show_workqueue_state();
 			return;
 		}
+		spin_unlock_irq(&pwq->pool->lock);
 	}
 	mutex_unlock(&wq->mutex);
+	mutex_unlock(&wq_pool_mutex);
 
 	/*
 	 * wq list is used to freeze wq, remove from list after
-- 
2.17.1

