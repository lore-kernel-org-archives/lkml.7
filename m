Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A8C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA95208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370836;
	bh=An5phQpq7aWiAOCZ323cp9UcJjDhRvvPkOFdLDUsgBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MUIQeKUIX3YtZjzEt1sCfye++vIXtjNnNl9NHkAKWuZ6c/wqS69j+YSdUrrRNaXH6
	 Xj+u8t6Y28G7lXM8yL5HjEi/7fdENEgImDBdz4lQ8bZyRlJSLMGGfHJj8VoCiVGE/N
	 4VloakpdTevXt9/B4N+Ysd81ahgC8ZclfYkrUBmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfFXKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfFXKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:07:11 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7842089F;
        Mon, 24 Jun 2019 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370830;
        bh=An5phQpq7aWiAOCZ323cp9UcJjDhRvvPkOFdLDUsgBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0VrSZgOEZNkvGKvco9RWHjAZPZoze+M08katqXZuCJhvrDbiH9DioZlYp0ydT5hm
         G/qg8QEBveOlucfueTwLxRPH+g9kvFRXu1Z0Zo78xWJlFk0xLJhpKMLxbUVvWdOXdM
         yY88oVtIP0csVYgeLKfRW+gTfRv3m/cyc/gf4R7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 5.1 017/121] IB/hfi1: Avoid hardlockup with flushlist_lock
Date:   Mon, 24 Jun 2019 17:55:49 +0800
Message-Id: <20190624092321.503399665@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit cf131a81967583ae737df6383a0893b9fee75b4e upstream.

Heavy contention of the sde flushlist_lock can cause hard lockups at
extreme scale when the flushing logic is under stress.

Mitigate by replacing the item at a time copy to the local list with
an O(1) list_splice_init() and using the high priority work queue to
do the flushes.

Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Cc: <stable@vger.kernel.org>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/sdma.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -410,10 +410,7 @@ static void sdma_flush(struct sdma_engin
 	sdma_flush_descq(sde);
 	spin_lock_irqsave(&sde->flushlist_lock, flags);
 	/* copy flush list */
-	list_for_each_entry_safe(txp, txp_next, &sde->flushlist, list) {
-		list_del_init(&txp->list);
-		list_add_tail(&txp->list, &flushlist);
-	}
+	list_splice_init(&sde->flushlist, &flushlist);
 	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
 	/* flush from flush list */
 	list_for_each_entry_safe(txp, txp_next, &flushlist, list)
@@ -2413,7 +2410,7 @@ unlock_noconn:
 	list_add_tail(&tx->list, &sde->flushlist);
 	spin_unlock(&sde->flushlist_lock);
 	iowait_inc_wait_count(wait, tx->num_desc);
-	schedule_work(&sde->flush_worker);
+	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
 	ret = -ECOMM;
 	goto unlock;
 nodesc:
@@ -2511,7 +2508,7 @@ unlock_noconn:
 		iowait_inc_wait_count(wait, tx->num_desc);
 	}
 	spin_unlock(&sde->flushlist_lock);
-	schedule_work(&sde->flush_worker);
+	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
 	ret = -ECOMM;
 	goto update_tail;
 nodesc:


