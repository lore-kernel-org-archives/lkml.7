Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85806C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B51121582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521871;
	bh=PelHHQEbbBbSlIejTyVCKNHJCPc14wPvz8tFO4VEpLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wt2qPkyAQyd+qhIOFdjTBmhUPDHnZfjVrTqk8d3R3EFNbyF+zklAoDrpToGQ7tDwo
	 jB3t0c8PIpdRZXbEOGz1yPy/wWE6t/xfK0bxTy0uKSnU7TVrCnCg9JO2CHzWg8TBIo
	 WtVi2demplsZ3PLnlGw/G6BYL/O6DVTJgDXioWcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfLPSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfLPR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92EAC21739;
        Mon, 16 Dec 2019 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519115;
        bh=PelHHQEbbBbSlIejTyVCKNHJCPc14wPvz8tFO4VEpLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI8TlHwLUvKN7zuY3KKCJnuz/E4yWIffbfT359VmXFnVGhlBTROuti0SrcEceKF1H
         emrW43BtvwzcqRz6cWaFY3/gIgPzfXd0+NAMT7aqPfaf2HOQJBnYUNVKngm+BjEdGS
         NYTOt6NsAGpwEPo4FbYUuDwoWPHYUxXMJ41TYFgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "Williams, Gerald S" <gerald.s.williams@intel.com>,
        NeilBrown <neilb@suse.de>
Subject: [PATCH 4.14 202/267] workqueue: Fix pwq ref leak in rescuer_thread()
Date:   Mon, 16 Dec 2019 18:48:48 +0100
Message-Id: <20191216174913.600404151@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit e66b39af00f426b3356b96433d620cb3367ba1ff upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/workqueue.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2366,8 +2366,14 @@ repeat:
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
@@ -4413,7 +4419,8 @@ static void show_pwq(struct pool_workque
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d%s\n", pwq->nr_active, pwq->max_active,
+	pr_cont(" active=%d/%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->max_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {


