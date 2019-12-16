Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1034207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521497;
	bh=HgPfHR2KUSol7AKE/2FX+6KbJnirQrJZGXCrdNQMvlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1gzoPijpMKByhFe7OQi+0hMl/G/9nkesxjI9KMVTx8QSUkLgW50rUE+7rNR1JzS9+
	 K9CmBpIb0WRpn+5UTR4iSgyIjDAEM+txFv/9+xg/HaQVz8t5hiTMoTYKKf0kX0PKNi
	 qIUZSCyMoUDMxF7uah9lYUR4w2MPOAVw4kT4YPMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfLPSiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfLPSFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:05:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ACED20700;
        Mon, 16 Dec 2019 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519506;
        bh=HgPfHR2KUSol7AKE/2FX+6KbJnirQrJZGXCrdNQMvlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OYA72B8QfHFKqnaffvmD64wai/jicAw7T55GKRER1fOmejHIH4w8kz/3pEvfgFtZ
         RK2vX3yWQTofKNHw4xiaTd7Ah0vBSrLBCHrkEqCvmiyK95aWh9o1GRsNrDh8dJDh0Y
         8e3Qq54ZxQl9xxmeOgDojCx4OYl1da9B85Tzl7Tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Subject: [PATCH 4.19 053/140] workqueue: Fix spurious sanity check failures in destroy_workqueue()
Date:   Mon, 16 Dec 2019 18:48:41 +0100
Message-Id: <20191216174802.938835002@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit def98c84b6cdf2eeea19ec5736e90e316df5206b upstream.

Before actually destrying a workqueue, destroy_workqueue() checks
whether it's actually idle.  If it isn't, it prints out a bunch of
warning messages and leaves the workqueue dangling.  It unfortunately
has a couple issues.

* Mayday list queueing increments pwq's refcnts which gets detected as
  busy and fails the sanity checks.  However, because mayday list
  queueing is asynchronous, this condition can happen without any
  actual work items left in the workqueue.

* Sanity check failure leaves the sysfs interface behind too which can
  lead to init failure of newer instances of the workqueue.

This patch fixes the above two by

* If a workqueue has a rescuer, disable and kill the rescuer before
  sanity checks.  Disabling and killing is guaranteed to flush the
  existing mayday list.

* Remove sysfs interface before sanity checks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marcin Pawlowski <mpawlowski@fb.com>
Reported-by: "Williams, Gerald S" <gerald.s.williams@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/workqueue.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4154,9 +4154,28 @@ void destroy_workqueue(struct workqueue_
 	struct pool_workqueue *pwq;
 	int node;
 
+	/*
+	 * Remove it from sysfs first so that sanity check failure doesn't
+	 * lead to sysfs name conflicts.
+	 */
+	workqueue_sysfs_unregister(wq);
+
 	/* drain it before proceeding with destruction */
 	drain_workqueue(wq);
 
+	/* kill rescuer, if sanity checks fail, leave it w/o rescuer */
+	if (wq->rescuer) {
+		struct worker *rescuer = wq->rescuer;
+
+		/* this prevents new queueing */
+		spin_lock_irq(&wq_mayday_lock);
+		wq->rescuer = NULL;
+		spin_unlock_irq(&wq_mayday_lock);
+
+		/* rescuer will empty maydays list before exiting */
+		kthread_stop(rescuer->task);
+	}
+
 	/* sanity checks */
 	mutex_lock(&wq->mutex);
 	for_each_pwq(pwq, wq) {
@@ -4188,11 +4207,6 @@ void destroy_workqueue(struct workqueue_
 	list_del_rcu(&wq->list);
 	mutex_unlock(&wq_pool_mutex);
 
-	workqueue_sysfs_unregister(wq);
-
-	if (wq->rescuer)
-		kthread_stop(wq->rescuer->task);
-
 	if (!(wq->flags & WQ_UNBOUND)) {
 		/*
 		 * The base ref is never dropped on per-cpu pwqs.  Directly


