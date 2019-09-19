Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C46C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E121907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568857425;
	bh=DxkPIN5q1bDPJjnyOnTw/QYproW8RsagYJ4Dk4DagXQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HJbNROMewKtifBDC0FK5EnSrkuB0XYtu2kKl7MiMGEvQHqEuH1mCYgVHc2NkBrSSc
	 LufskMsCsj4f1cJcL0kfPVj7KGVgZXVu8pwwRNGz7xKQos5b+T6RNkv/K4jZdVL9wH
	 G01WafukbNVhoCkpbn3ow1YmOF/vxoExtst3oPFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfISBno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:43:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37434 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbfISBno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:43:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id d2so2245435qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UTN59gM/vyx2lD4S+2HFhKfHWL0kjNEkrb9+F6F5o+s=;
        b=Cy3X3UKKlPjIFMsLRjynfczd7s+hFjsfHv+BIskevMEjBnAFPyOTJ4iuF7iXaMYnsj
         zXp9EJwWbI/RrEoKEBg2a1j9Tfm8XGxLD6P2ljOjrIL5+oVo2qKMMBEG6J4y9ATXjPv1
         weTLqk+cDUYb+FmoUWT3ls4ojXaPCnAgR1nGiYI292KVheLX1O8IwKEJfF8EUs/vdKS5
         zhZcNk08kSZyNp7oIuqYkfaV+NXjykPUIx7LepGY5Es3FXX44YSw0rUT3hu+7V6lnRsV
         DKKIvw9fn+5DObKd+ASyIcIDYYd6epcfq+/JZVfy8MQoj7slwFZmvlOupOgwDw6iPb2C
         wvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=UTN59gM/vyx2lD4S+2HFhKfHWL0kjNEkrb9+F6F5o+s=;
        b=SuP5+odtuI0HeQivhBwtpPJ8AfUVnii335VpCeGuIoJ9WXO11otiy9x7PJom8c1zh2
         F7ynecUQe5mj0Cn6LO5+sGcrh/Y3pm4rtiOFw59LpkWO3Sqt5M5iRhkS6bYwKcB6R0G1
         5El7l/Q6IidOY6YJurG8e5T39Cs1YsPb2wuPs12PwmV7DLy9yApYRJ5H9q1h0GVPwhdz
         o7YvSdzH1K6sngDW88w3ZblmD/RMvucTbbxH0GfL67xp3F2n3H0i2FH7df3UkdQtF0y5
         Ew8JyHpevO7gOkSqRs2v6mcpfSbyPYH+WN+Q6BhV7s7KOP6nbhuoPeqEq0RyuuffAdSv
         gZjA==
X-Gm-Message-State: APjAAAXjc0oRRtsxhEVEJQMJdzndV7m5xBPG9+QPmeMKszL8B2rDVcdc
        /905Q2V/FAIKaT+bVLwmWmI=
X-Google-Smtp-Source: APXvYqxcABJXfAo1puryMUbJH9MGBWbFBYl3RedZRwbNLKN29Rm13DPKAjg6Xxz7pgXtlz14dBUPHg==
X-Received: by 2002:ac8:1a32:: with SMTP id v47mr753441qtj.289.1568857422880;
        Wed, 18 Sep 2019 18:43:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::67e])
        by smtp.gmail.com with ESMTPSA id g33sm3344741qtd.12.2019.09.18.18.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 18:43:42 -0700 (PDT)
Date:   Wed, 18 Sep 2019 18:43:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        ~@devbig004.ftw2.facebook.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Marcin Pawlowski <mpawlowski@fb.com>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Subject: [PATCH] workqueue: Fix spurious sanity check failures in
 destroy_workqueue()
Message-ID: <20190919014340.GM3084169@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Applying to wq/for-5.4.

Thanks.

 kernel/workqueue.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 95aea04ff722..73e3ea9e31d3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4318,9 +4318,28 @@ void destroy_workqueue(struct workqueue_struct *wq)
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
@@ -4352,11 +4371,6 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	list_del_rcu(&wq->list);
 	mutex_unlock(&wq_pool_mutex);
 
-	workqueue_sysfs_unregister(wq);
-
-	if (wq->rescuer)
-		kthread_stop(wq->rescuer->task);
-
 	if (!(wq->flags & WQ_UNBOUND)) {
 		wq_unregister_lockdep(wq);
 		/*
-- 
2.17.1

