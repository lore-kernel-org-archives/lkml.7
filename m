Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A28C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8C222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570210615;
	bh=sISQanEjzFpY/RAhi5A98nittePx1Tfph3y8mF1LNcE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=k+lJd6mtxx7p3QOOcURX5GtA4IPpo6L0kkOrHdyi/E9UUrdH4fdlE8y2K7KOKzwRz
	 bMmrDxgvXnEbkd1iCefIfDv4FCCfcgEmwAv6y1h9JE7u3B4DAR4icjOrNR/T3PR3F0
	 /Dh2O8ACotlc6TrXbM4R155oSP9T9llnLihqVtXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfJDRgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:36:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43433 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbfJDRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:36:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id c3so9592484qtv.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tQp69CMduGluA1D0MZmOAUieHPqXQtBrgypg0X/UGOE=;
        b=jKYMK0tGEB6amKtMisibuzttvgEttmiNjpp/OjgXekKWRoTXBl86ID7HNcuoLdK4nB
         i24gwQIQPRN1LzT9h9FuyE8PSYRyLYrDRJoVqrSXkkehof0TNvZrE0H5axeePr27RBDX
         t3yjWruJ1y9d68wjdlqnWjQ2WKS7W58wrzysgP6y7RoS2/8bGpogpCIlXbY5b9Dll4us
         0wYYJ4Rt6GCUpyUviWgvP5HgIh8gikH8AmhAGLAZYac8a7swKGhryAgP5tImXIA/1j8Z
         4ZIIPgpvFS9rDa3XfchZDGP0G7CfqG2Wm8vPVvZMljrgxS0/VjgdGkciLw8NCXRDq+OA
         k8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tQp69CMduGluA1D0MZmOAUieHPqXQtBrgypg0X/UGOE=;
        b=medonlcECWnIbV884W1iZb7uvFkdX/Fq/fT/vQ1Ziv/5liEhN8Q9NyVuT6WOldUlCS
         BU9MoTakwWklyrTCF6iVfdtw6Dy002BFfg4M56a/VTC7cjYntgQHUCdlGCDUm49WUf//
         /OjGBoOVFWh+K5r8TWheHNr/rHyHKmUtlgwbI1Uu9G9meW/w3c/mCul+ya7NsEewvAEE
         vUUFK5rgiGpAfmgTv4316h3jzObTvNUh4yKRWpY5qGyi6IjIY+rKrAe6jJKZAjXWxhFy
         /Jhw0CQig7KkmUzhrTA832VzMYTO4wYZoQrrVHVnPlE9Ec8k+pw1fUoA3u3HWaJHoh5T
         u3mg==
X-Gm-Message-State: APjAAAV6x9IUCT071U1iPWzzuAb188yXYOwLRl30LiRREvqDZWPWqn7z
        cAu6UKHZNC1IDmiO6+odz74=
X-Google-Smtp-Source: APXvYqwXrmxcRPcNzhrsWK9AOyiAhAeE+HPLtOkyFY7czOs0eCDpTyuIcgD8M7z8m8VFbOhTCRGxrA==
X-Received: by 2002:a0c:8ad0:: with SMTP id 16mr15217167qvw.237.1570210611142;
        Fri, 04 Oct 2019 10:36:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::91c3])
        by smtp.gmail.com with ESMTPSA id 54sm4866213qts.75.2019.10.04.10.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:36:50 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:36:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        NeilBrown <neilb@suse.de>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>
Subject: [PATCH wq/for-5.2-fixes] workqueue: Fix pwq ref leak in
 rescuer_thread()
Message-ID: <20191004173649.GB3404308@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e66b39af00f426b3356b96433d620cb3367ba1ff Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 25 Sep 2019 06:59:15 -0700
Subject: [PATCH 2/2] workqueue: Fix pwq ref leak in rescuer_thread()

008847f66c3 ("workqueue: allow rescuer thread to do more work.") made
the rescuer worker requeue the pwq immediately if there may be more
work items which need rescuing instead of waiting for the next mayday
timer expiration.  Unfortunately, it doesn't check whether the pwq is
already on the mayday list and unconditionally gets the ref and moves
it onto the list.  This doesn't corrupt the list but creates an
additional reference to the pwq.  It got queued twice but will only be
removed once.

This leak later can trigger pwq refcnt warning on workqueue
destruction and prevent freeing of the workqueue.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "Williams, Gerald S" <gerald.s.williams@intel.com>
Cc: NeilBrown <neilb@suse.de>
Cc: stable@vger.kernel.org # v3.19+
---
Applying to wq/for-5.4-fixes.

Thanks.

 kernel/workqueue.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4a3c30177b94..4dc8270326d7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2533,8 +2533,14 @@ static int rescuer_thread(void *__rescuer)
 			 */
 			if (need_to_create_worker(pool)) {
 				spin_lock(&wq_mayday_lock);
-				get_pwq(pwq);
-				list_move_tail(&pwq->mayday_node, &wq->maydays);
+				/*
+				 * Queue iff we aren't racing destruction
+				 * and somebody else hasn't queued it already.
+				 */
+				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
+					get_pwq(pwq);
+					list_add_tail(&pwq->mayday_node, &wq->maydays);
+				}
 				spin_unlock(&wq_mayday_lock);
 			}
 		}
@@ -4374,8 +4380,8 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	for_each_pwq(pwq, wq) {
 		spin_lock_irq(&pwq->pool->lock);
 		if (WARN_ON(pwq_busy(pwq))) {
-			pr_warning("%s: %s has the following busy pwq (refcnt=%d)\n",
-				   __func__, wq->name, pwq->refcnt);
+			pr_warning("%s: %s has the following busy pwq\n",
+				   __func__, wq->name);
 			show_pwq(pwq);
 			spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
@@ -4670,7 +4676,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d%s\n", pwq->nr_active, pwq->max_active,
+	pr_cont(" active=%d/%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->max_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
-- 
2.17.1

