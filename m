Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8981218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257109;
	bh=Iq+Ny7L2wG7JaGUfjKW6jJoaC0LzPCvFIksQDEJGD34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMa1xhLQyBWZJe9oSkybUeu+juyOT6sKeOilH4ZieZjhUlCtReiLSxAXy7gJTOrM/
	 5kJkVOPuNqenecPnLQZzrH5ZE/jXMNEgqaq/LvKDIrTlZXvUYjVX7oGcu/eJiw89eV
	 OH0LkASAe1PfvrqmbieZmIrxaLToqkMwjT7mSjnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbfCVMS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390297AbfCVMS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CC42083D;
        Fri, 22 Mar 2019 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257105;
        bh=Iq+Ny7L2wG7JaGUfjKW6jJoaC0LzPCvFIksQDEJGD34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDLTiIrDGmA3wjXdplR+4iai/Rec2nsCC8RsbrilFh3ffl0XV3TB3N+MQ7yYqEWgH
         PbvnQlSwHniIOV9CFecjY7KiSFOIJGqYYcVT3WyCes3D8G2mIwY3nwZFWpckO44YaT
         HT4FwUfmVem/jxiQJFTVtRlNfYRQFGJ5pGpot9fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 134/238] IB/hfi1: Close race condition on user context disable and close
Date:   Fri, 22 Mar 2019 12:15:53 +0100
Message-Id: <20190322111306.366752229@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit bc5add09764c123f58942a37c8335247e683d234 upstream.

When disabling and removing a receive context, it is possible for an
asynchronous event (i.e IRQ) to occur.  Because of this, there is a race
between cleaning up the context, and the context being used by the
asynchronous event.

cpu 0  (context cleanup)
    rc->ref_count-- (ref_count == 0)
    hfi1_rcd_free()
cpu 1  (IRQ (with rcd index))
	rcd_get_by_index()
	lock
	ref_count+++     <-- reference count race (WARNING)
	return rcd
	unlock
cpu 0
    hfi1_free_ctxtdata() <-- incorrect free location
    lock
    remove rcd from array
    unlock
    free rcd

This race will cause the following WARNING trace:

WARNING: CPU: 0 PID: 175027 at include/linux/kref.h:52 hfi1_rcd_get_by_index+0x84/0xa0 [hfi1]
CPU: 0 PID: 175027 Comm: IMB-MPI1 Kdump: loaded Tainted: G OE ------------ 3.10.0-957.el7.x86_64 #1
Hardware name: Intel Corporation S2600KP/S2600KP, BIOS SE5C610.86B.11.01.0076.C4.111920150602 11/19/2015
Call Trace:
  dump_stack+0x19/0x1b
  __warn+0xd8/0x100
  warn_slowpath_null+0x1d/0x20
  hfi1_rcd_get_by_index+0x84/0xa0 [hfi1]
  is_rcv_urgent_int+0x24/0x90 [hfi1]
  general_interrupt+0x1b6/0x210 [hfi1]
  __handle_irq_event_percpu+0x44/0x1c0
  handle_irq_event_percpu+0x32/0x80
  handle_irq_event+0x3c/0x60
  handle_edge_irq+0x7f/0x150
  handle_irq+0xe4/0x1a0
  do_IRQ+0x4d/0xf0
  common_interrupt+0x162/0x162

The race can also lead to a use after free which could be similar to:

general protection fault: 0000 1 SMP
CPU: 71 PID: 177147 Comm: IMB-MPI1 Kdump: loaded Tainted: G W OE ------------ 3.10.0-957.el7.x86_64 #1
Hardware name: Intel Corporation S2600KP/S2600KP, BIOS SE5C610.86B.11.01.0076.C4.111920150602 11/19/2015
task: ffff9962a8098000 ti: ffff99717a508000 task.ti: ffff99717a508000 __kmalloc+0x94/0x230
Call Trace:
  ? hfi1_user_sdma_process_request+0x9c8/0x1250 [hfi1]
  hfi1_user_sdma_process_request+0x9c8/0x1250 [hfi1]
  hfi1_aio_write+0xba/0x110 [hfi1]
  do_sync_readv_writev+0x7b/0xd0
  do_readv_writev+0xce/0x260
  ? handle_mm_fault+0x39d/0x9b0
  ? pick_next_task_fair+0x5f/0x1b0
  ? sched_clock_cpu+0x85/0xc0
  ? __schedule+0x13a/0x890
  vfs_writev+0x35/0x60
  SyS_writev+0x7f/0x110
  system_call_fastpath+0x22/0x27

Use the appropriate kref API to verify access.

Reorder context cleanup to ensure context removal before cleanup occurs
correctly.

Cc: stable@vger.kernel.org # v4.14.0+
Fixes: f683c80ca68e ("IB/hfi1: Resolve kernel panics by reference counting receive contexts")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/hfi.h  |    2 +-
 drivers/infiniband/hw/hfi1/init.c |   14 +++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1435,7 +1435,7 @@ void hfi1_init_pportdata(struct pci_dev
 			 struct hfi1_devdata *dd, u8 hw_pidx, u8 port);
 void hfi1_free_ctxtdata(struct hfi1_devdata *dd, struct hfi1_ctxtdata *rcd);
 int hfi1_rcd_put(struct hfi1_ctxtdata *rcd);
-void hfi1_rcd_get(struct hfi1_ctxtdata *rcd);
+int hfi1_rcd_get(struct hfi1_ctxtdata *rcd);
 struct hfi1_ctxtdata *hfi1_rcd_get_by_index_safe(struct hfi1_devdata *dd,
 						 u16 ctxt);
 struct hfi1_ctxtdata *hfi1_rcd_get_by_index(struct hfi1_devdata *dd, u16 ctxt);
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -215,12 +215,12 @@ static void hfi1_rcd_free(struct kref *k
 	struct hfi1_ctxtdata *rcd =
 		container_of(kref, struct hfi1_ctxtdata, kref);
 
-	hfi1_free_ctxtdata(rcd->dd, rcd);
-
 	spin_lock_irqsave(&rcd->dd->uctxt_lock, flags);
 	rcd->dd->rcd[rcd->ctxt] = NULL;
 	spin_unlock_irqrestore(&rcd->dd->uctxt_lock, flags);
 
+	hfi1_free_ctxtdata(rcd->dd, rcd);
+
 	kfree(rcd);
 }
 
@@ -243,10 +243,13 @@ int hfi1_rcd_put(struct hfi1_ctxtdata *r
  * @rcd: pointer to an initialized rcd data structure
  *
  * Use this to get a reference after the init.
+ *
+ * Return : reflect kref_get_unless_zero(), which returns non-zero on
+ * increment, otherwise 0.
  */
-void hfi1_rcd_get(struct hfi1_ctxtdata *rcd)
+int hfi1_rcd_get(struct hfi1_ctxtdata *rcd)
 {
-	kref_get(&rcd->kref);
+	return kref_get_unless_zero(&rcd->kref);
 }
 
 /**
@@ -326,7 +329,8 @@ struct hfi1_ctxtdata *hfi1_rcd_get_by_in
 	spin_lock_irqsave(&dd->uctxt_lock, flags);
 	if (dd->rcd[ctxt]) {
 		rcd = dd->rcd[ctxt];
-		hfi1_rcd_get(rcd);
+		if (!hfi1_rcd_get(rcd))
+			rcd = NULL;
 	}
 	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
 


