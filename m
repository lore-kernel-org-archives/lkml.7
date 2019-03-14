Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5B2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mP37e+Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCNFhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:37:53 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:35860 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNFhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:37:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 8691FC99
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RrJxtf9QTtTD for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 00:37:51 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 3FA0CC8F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:37:51 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id y6so1102549itj.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4BgKTwjSHraz7yEVSQOk8vICxaXzsZbztKpzAHEoZts=;
        b=mP37e+XwAkRjRcKD4syXajWtCechYM0nBZI/1JUzm8IeBNHWi9qVLQlPhAoDWKhZmD
         sVDD9E+F1uBckftF77VOF1FFZq0cdQDYuhVfMzTsDeiFtT5Swf7YCEuzMEmCvoS9oLhj
         0uRXLiwZXDCMufo3q7/mGM6eqQiuaVL42E2k1AmzYs4ItyLzHyV5LtnAR2jq9Q7TP2M9
         fBceMfNMtQdQ7eRM7HO1eu5xz3gK8k4FgrYjZcqItWQ1gmmcoYWcS15NkX4Kmxbf0/fI
         uvhofjLjbKYfH+Lih2d4LCnF0qKtpidolLWPiVGs34el8w3li5SvoLJXLCQEEI0rTk+Y
         uDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4BgKTwjSHraz7yEVSQOk8vICxaXzsZbztKpzAHEoZts=;
        b=ZCDPgMfgiW6sl7WiNrujk0oHpoQA4cmqLIMNJ5cVUVV25Tn/BYDotKpXzKalIp8lJr
         dyrtOdHTBjXGD3lqX+f34elB7DCBw7Li/rJtWWDjamaKcJHdOHsfP4nfn9/Ua6rergSF
         WXaWVic3POh4Rpltww51O6V01B8QpDSewMFakx2/jZglhpx3U815YHnciD2BlTL49N+6
         bZhUeainkpSFuD2Vs3kf9/PwSFsshSD3FexyklxELIRqM4fl5CXuSK0KUS930j82jsav
         iiPCMcEpUq4ZRTv0nFwzfdOG/9CVR0GC18pTYSkJQwhSdKeeHxRWvtMDgevyrEnD9elg
         CcGQ==
X-Gm-Message-State: APjAAAVxAhctL3A4EqiXTMJmWE8ljirQdHveBHQX/x5hv5gMAh2HIypE
        88Qeba2I5eyoYmHNSBtDxNtkOjTivM3WV61PRv6Qzxz/Eqz/o6AD8VMCwgVNwp2gT8gwxhjwkM4
        WpFODuDtwePVMp0B1H5zguU/c4J7K
X-Received: by 2002:a24:64b:: with SMTP id 72mr1035158itv.53.1552541870653;
        Wed, 13 Mar 2019 22:37:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKfQroquDhj2cJKrNFXry/58qO7Zi4WoIsVSp3mZnQpg4WuuhxgZwj0ozthzs7LLrqA/Mc8Q==
X-Received: by 2002:a24:64b:: with SMTP id 72mr1035146itv.53.1552541870396;
        Wed, 13 Mar 2019 22:37:50 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id g2sm6364240iom.7.2019.03.13.22.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:37:49 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: i40iw: fix potential NULL pointer dereferences
Date:   Thu, 14 Mar 2019 00:37:34 -0500
Message-Id: <20190314053735.31863-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5A6B1A0@fmsmsx124.amr.corp.intel.com>
References: <9DD61F30A802C4429A01CA4200E302A7A5A6B1A0@fmsmsx124.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_ordered_workqueue may fail and return NULL.
The fix captures the failure and handles it properly to avoid
potential NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: add return value to capture the error code

 drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c   | 19 ++++++++++++++++---
 drivers/infiniband/hw/i40iw/i40iw_main.c |  5 ++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 2f2b4426ded7..8feec35f95a7 100644
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
index 206cfb0016f8..dda24f44239b 100644
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
+	if (!cm_core->event_wq)
+		goto error;
 
 	cm_core->disconn_wq = alloc_ordered_workqueue("iwdwq",
 						      WQ_MEM_RECLAIM);
+	if (!cm_core->disconn_wq)
+		goto error;
+
+	return 0;
+error:
+	i40iw_cleanup_cm_core(&iwdev->cm_core);
+	i40iw_pr_err("fail to setup CM core");
+
+	return return -ENOMEM;
 }
 
 /**
@@ -3278,8 +3289,10 @@ void i40iw_cleanup_cm_core(struct i40iw_cm_core *cm_core)
 		del_timer_sync(&cm_core->tcp_timer);
 	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 
-	destroy_workqueue(cm_core->event_wq);
-	destroy_workqueue(cm_core->disconn_wq);
+	if (cm_core->event_wq)
+		destroy_workqueue(cm_core->event_wq);
+	if (cm_core->disconn_wq)
+		destroy_workqueue(cm_core->disconn_wq);
 }
 
 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 68095f00d08f..10932baee279 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1641,7 +1641,10 @@ static int i40iw_open(struct i40e_info *ldev, struct i40e_client *client)
 	iwdev = &hdl->device;
 	iwdev->hdl = hdl;
 	dev = &iwdev->sc_dev;
-	i40iw_setup_cm_core(iwdev);
+	if (i40iw_setup_cm_core(iwdev)) {
+		kfree(iwdev->hdl);
+		return -ENOMEM;
+	}
 
 	dev->back_dev = (void *)iwdev;
 	iwdev->ldev = &hdl->ldev;
-- 
2.17.1

