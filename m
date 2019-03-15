Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29FB21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IDiC6JNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfCOG51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:57:27 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56600 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfCOG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:57:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E7C62C09
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8lDJMIWaSWpO for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:57:25 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B71F9BB2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:57:25 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id c2so6213694ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPNfkpeBW5V2f/HAgp3je5ReRyz7n0ARGZZVnnOf65Q=;
        b=IDiC6JNYks3AH5fC397ajhZcYqzISzFXmh0cOd0A33xSqRkFrWPnDJFrG2v0VLjd2Q
         4ZdewZCyR3q/Rtdl8lZSwt8GiK+Fa0ITMkGWdB3g1cjqKjDHANhoUmkZWC45rUo96zMr
         cBxye/86OcT4Ng1Fx6iJlGHS8N3nuypV07wkgo2VveN7Z9RCRMl4TJZA/z3Dtirtm63G
         NFnn1HN4PTy+6zJV+fIPC0g2ilE+vGslX9qlnpIND/PipIsK1mjxfl2DuT7YLyiu7+R8
         cwvK25i3dYaAErzku1RiCAeikClNPBk8Dx2cKZRkl9mNt2JtD5FoG5os4or6pl3ISyDd
         vCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPNfkpeBW5V2f/HAgp3je5ReRyz7n0ARGZZVnnOf65Q=;
        b=WKdU5AJQH/tOez51z6xCrJcEBrsEaECJ+8JiErvyQi50nICYO6pHN/kgXxFMglFCi8
         KygleSGoLRKaOsUXAL6vf3CJYOxTVoZbB3mYUriPf1jpshMis+2kL76vFzUwvfKykvOJ
         AjloRAinaPjBxhR9c0Dmnj5Aoh5n2juo3Jer5QdWBGB48rDISl3MElPhyro6NjRW4Aoh
         dn9AWK5mRfCymtDqZTh8/HllNp6W2wsAQ5Cxw1rpCCbxFwTRywluywmYrqegxyy0gw4a
         Zpvgd8lwp96fiBVP/QqTGNhMNaYX75FQsurumvX0RpcTMeDaQjCrAKYucMXORqirulFD
         HShQ==
X-Gm-Message-State: APjAAAWuFshd9qYJNvGB4CwT1+MxC23C3B7rseoLlQ4XVQY155kgllD0
        vLEcsdW9GRSwhwjbYJww4ZTH7uAATR0rqxqPGODi8RGAoXNpycgIQTJzLO3OWw/Ei9XLngt0J7O
        QPP5CHFJx5IlrH7RkSoUV4bGL6Exy
X-Received: by 2002:a5e:c019:: with SMTP id u25mr1290841iol.104.1552633045318;
        Thu, 14 Mar 2019 23:57:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwc8A5JeGaHQURUR8pEehrpiEwYMWfLHrxhiFaksxEsi2dRd18rLtQZ7UWsq1CZJgy0fzEnQ==
X-Received: by 2002:a5e:c019:: with SMTP id u25mr1290819iol.104.1552633044969;
        Thu, 14 Mar 2019 23:57:24 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id g186sm653821iof.41.2019.03.14.23.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:57:23 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] infiniband: i40iw: fix potential NULL pointer dereferences
Date:   Fri, 15 Mar 2019 01:57:14 -0500
Message-Id: <20190315065715.18249-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5A6FAA8@fmsmsx124.amr.corp.intel.com>
References: <9DD61F30A802C4429A01CA4200E302A7A5A6FAA8@fmsmsx124.amr.corp.intel.com>
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
---
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
index 206cfb0016f8..2e20786b9a57 100644
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
+	return -ENOMEM;
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

