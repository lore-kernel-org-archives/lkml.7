Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB121C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D732083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCLPg6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:36:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:14486 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfCLPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="154322835"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2019 08:36:57 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Mar 2019 08:36:57 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.86]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.3]) with mapi id 14.03.0415.000;
 Tue, 12 Mar 2019 08:36:56 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband: i40iw: fix potential NULL pointer
 dereferences
Thread-Topic: [PATCH] infiniband: i40iw: fix potential NULL pointer
 dereferences
Thread-Index: AQHU1jjcRI9xjU7ZKUeZYb8WAnw3mqYIJNzA
Date:   Tue, 12 Mar 2019 15:36:56 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5A6B1A0@fmsmsx124.amr.corp.intel.com>
References: <20190309052750.16139-1-kjlu@umn.edu>
In-Reply-To: <20190309052750.16139-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: [PATCH] infiniband: i40iw: fix potential NULL pointer dereferences
>
>alloc_ordered_workqueue may fail and return NULL. Let's check its return value
>to ensure it is not NULL so as to avoid potential NULL pointer dereferences.
>
>Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>---
> drivers/infiniband/hw/i40iw/i40iw_cm.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c
>b/drivers/infiniband/hw/i40iw/i40iw_cm.c
>index 206cfb0016f8..ad9b4f235e30 100644
>--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
>+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
>@@ -3256,9 +3256,21 @@ void i40iw_setup_cm_core(struct i40iw_device
>*iwdev)
>
> 	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
> 						    WQ_MEM_RECLAIM);
>+	if (!cm_core->event_wq) {
>+		i40iw_debug(cm_core->dev,
>+				I40IW_DEBUG_CM,
>+				"%s allocate event work queue failed\n",
>+				__func__);
>+	}
>
> 	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
> 						      WQ_MEM_RECLAIM);
>+	if (!cm_core->disconn_wq) {
>+		i40iw_debug(cm_core->dev,
>+				I40IW_DEBUG_CM,
>+				"%s allocate disconnect work queue failed\n",
>+				__func__);
>+	}
> }

Hi Kangjie - Just doing a debug print doesn't suffice. We need to fail the i40iw_open() and unwind correctly.

Perhaps something like this would be required.

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 2f2b442..8feec35 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -552,7 +552,7 @@ enum i40iw_status_code i40iw_obj_aligned_mem(struct i40iw_device *iwdev,

 void i40iw_request_reset(struct i40iw_device *iwdev);
 void i40iw_destroy_rdma_device(struct i40iw_ib_device *iwibdev);
-void i40iw_setup_cm_core(struct i40iw_device *iwdev);
+int i40iw_setup_cm_core(struct i40iw_device *iwdev);
 void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core);
 void i40iw_process_ceq(struct i40iw_device *, struct i40iw_ceq *iwceq);
 void i40iw_process_aeq(struct i40iw_device *);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 206cfb0..dcc5fea 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -3237,7 +3237,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
  * core
  * @iwdev: iwarp device structure
  */
-void i40iw_setup_cm_core(struct i40iw_device *iwdev)
+int i40iw_setup_cm_core(struct i40iw_device *iwdev)
 {
        struct i40iw_cm_core *cm_core = &iwdev->cm_core;

@@ -3256,9 +3256,20 @@ void i40iw_setup_cm_core(struct i40iw_device *iwdev)

        cm_core->event_wq = alloc_ordered_workqueue("iwewq",
                                                    WQ_MEM_RECLAIM);
-
+       if (!cm_core->event_wq)
+               goto error;
+       
        cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
                                                      WQ_MEM_RECLAIM);
+       if (!cm_core->disconn_wq)
+               goto error;
+
+       return 0;
+error:
+       i40iw_cleanup_cm_core(&iwdev->cm_core);
+       i40iw_pr_err("fail to setup CM core");
+
+       return -ENOMEM;
 }

 /**
@@ -3278,8 +3289,10 @@ void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core)
                del_timer_sync(&cm_core->tcp_timer);
        spin_unlock_irqrestore(&cm_core->ht_lock, flags);

-       destroy_workqueue(cm_core->event_wq);
-       destroy_workqueue(cm_core->disconn_wq);
+       if (cm_core->event_wq)
+               destroy_workqueue(cm_core->event_wq);
+       if (cm_core->disconn_wq)
+               destroy_workqueue(cm_core->disconn_wq);
 }

 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 68095f0..10932ba 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1641,7 +1641,10 @@ static int i40iw_open(struct i40e_info *ldev, struct i40e_client *client)
        iwdev = &hdl->device;
        iwdev->hdl = hdl;
        dev = &iwdev->sc_dev;
-       i40iw_setup_cm_core(iwdev);
+       if (i40iw_setup_cm_core(iwdev)) {
+               kfree(iwdev->hdl);
+               return -ENOMEM;
+       }

        dev->back_dev = (void *)iwdev;
        iwdev->ldev = &hdl->ldev;
-- 
1.8.3.1

Shiraz
