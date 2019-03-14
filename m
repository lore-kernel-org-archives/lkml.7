Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52454C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5762077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCNSb2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:31:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:2120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfCNSb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:31:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 11:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="155092127"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2019 11:31:26 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.86]) by
 FMSMSX106.amr.corp.intel.com ([169.254.5.96]) with mapi id 14.03.0415.000;
 Thu, 14 Mar 2019 11:31:25 -0700
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
Thread-Index: AQHU1jjcRI9xjU7ZKUeZYb8WAnw3mqYIJNzAgAL0FwCAAGJIwA==
Date:   Thu, 14 Mar 2019 18:31:25 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5A6FAA8@fmsmsx124.amr.corp.intel.com>
References: <9DD61F30A802C4429A01CA4200E302A7A5A6B1A0@fmsmsx124.amr.corp.intel.com>
 <20190314053735.31863-1-kjlu@umn.edu>
In-Reply-To: <20190314053735.31863-1-kjlu@umn.edu>
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
>alloc_ordered_workqueue may fail and return NULL.
>The fix captures the failure and handles it properly to avoid potential NULL pointer
>dereferences.
>
>Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>---
>V2: add return value to capture the error code
>
> drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
> drivers/infiniband/hw/i40iw/i40iw_cm.c   | 19 ++++++++++++++++---
> drivers/infiniband/hw/i40iw/i40iw_main.c |  5 ++++-
> 3 files changed, 21 insertions(+), 5 deletions(-)
[....]

>a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
>index 206cfb0016f8..dda24f44239b 100644
>--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
>+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
>@@ -3237,7 +3237,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct
>i40iw_puda_buf *rbuf)
>  * core
>  * @iwdev: iwarp device structure
>  */
>-void i40iw_setup_cm_core(struct i40iw_device *iwdev)
>+int i40iw_setup_cm_core(struct i40iw_device *iwdev)
> {
> 	struct i40iw_cm_core *cm_core = &iwdev->cm_core;
>
>@@ -3256,9 +3256,20 @@ void i40iw_setup_cm_core(struct i40iw_device *iwdev)
>
> 	cm_core->event_wq = alloc_ordered_workqueue("iwewq",
> 						    WQ_MEM_RECLAIM);
>+	if (!cm_core->event_wq)
>+		goto error;
>
> 	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
> 						      WQ_MEM_RECLAIM);
>+	if (!cm_core->disconn_wq)
>+		goto error;
>+
>+	return 0;
>+error:
>+	i40iw_cleanup_cm_core(&iwdev->cm_core);
>+	i40iw_pr_err("fail to setup CM core");
>+
>+	return return -ENOMEM;

please fix :)

> }
>

