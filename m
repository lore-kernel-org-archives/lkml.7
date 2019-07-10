Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C5C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B202084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGJJb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:31:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:56414 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfGJJbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:31:25 -0400
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1hl8wV-0003b5-Nx; Wed, 10 Jul 2019 12:31:15 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Andrey Jr . Melnikov" <temnota.am@gmail.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH v2 2/2] scsi: aacraid: Remove references to Series-9 (only)
Date:   Wed, 10 Jul 2019 12:31:13 +0300
Message-Id: <20190710093113.27936-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20190710093113.27936-1-khorenko@virtuozzo.com>
References: <2a6f5cc2-40cb-647c-003d-aae594d05062@virtuozzo.com>
 <20190710093113.27936-1-khorenko@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes references to Series 9 adapters following
395e5df79a95 ("scsi: aacraid: Remove reference to Series-9"),
but doesn't touch Series 6 adapters logic.

Leaving Series 6 adapters untouched avoids controller
hungs/resets under high io load.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1777586
https://bugzilla.redhat.com/show_bug.cgi?id=1724077
https://jira.sw.ru/browse/PSBM-95736

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/scsi/aacraid/aacraid.h  | 1 -
 drivers/scsi/aacraid/comminit.c | 9 +++------
 drivers/scsi/aacraid/commsup.c  | 3 +--
 drivers/scsi/aacraid/linit.c    | 8 +++-----
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index aef47d0e718c..b674fb645523 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -416,7 +416,6 @@ struct aac_ciss_identify_pd {
 #define PMC_DEVICE_S6	0x28b
 #define PMC_DEVICE_S7	0x28c
 #define PMC_DEVICE_S8	0x28d
-#define PMC_DEVICE_S9	0x28f
 
 #define aac_phys_to_logical(x)  ((x)+1)
 #define aac_logical_to_phys(x)  ((x)?(x)-1:0)
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index edaa2d53e704..c8db6614b712 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -353,8 +353,7 @@ int aac_send_shutdown(struct aac_dev * dev)
 	if (status != -ERESTARTSYS)
 		aac_fib_free(fibctx);
 	if ((dev->pdev->device == PMC_DEVICE_S7 ||
-	     dev->pdev->device == PMC_DEVICE_S8 ||
-	     dev->pdev->device == PMC_DEVICE_S9) &&
+	     dev->pdev->device == PMC_DEVICE_S8) &&
 	     dev->msi_enabled)
 		aac_set_intx_mode(dev);
 	return status;
@@ -611,8 +610,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 		host->sg_tablesize = status[2] >> 16;
 		dev->sg_tablesize = status[2] & 0xFFFF;
 		if (dev->pdev->device == PMC_DEVICE_S7 ||
-		    dev->pdev->device == PMC_DEVICE_S8 ||
-		    dev->pdev->device == PMC_DEVICE_S9) {
+		    dev->pdev->device == PMC_DEVICE_S8) {
 			if (host->can_queue > (status[3] >> 16) -
 					AAC_NUM_MGT_FIB)
 				host->can_queue = (status[3] >> 16) -
@@ -633,8 +631,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
 
 	if (dev->pdev->device == PMC_DEVICE_S6 ||
 	    dev->pdev->device == PMC_DEVICE_S7 ||
-	    dev->pdev->device == PMC_DEVICE_S8 ||
-	    dev->pdev->device == PMC_DEVICE_S9)
+	    dev->pdev->device == PMC_DEVICE_S8)
 		aac_define_int_mode(dev);
 	/*
 	 *	Ok now init the communication subsystem
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index b047b1e2215a..705e003caa95 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -2576,8 +2576,7 @@ void aac_free_irq(struct aac_dev *dev)
 
 	if (dev->pdev->device == PMC_DEVICE_S6 ||
 	    dev->pdev->device == PMC_DEVICE_S7 ||
-	    dev->pdev->device == PMC_DEVICE_S8 ||
-	    dev->pdev->device == PMC_DEVICE_S9) {
+	    dev->pdev->device == PMC_DEVICE_S8) {
 		if (dev->max_msix > 1) {
 			for (i = 0; i < dev->max_msix; i++)
 				free_irq(pci_irq_vector(dev->pdev, i),
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index f669a4405217..d5082b191aa8 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1561,8 +1561,7 @@ static void __aac_shutdown(struct aac_dev * aac)
 	aac_adapter_disable_int(aac);
 	if (aac->pdev->device == PMC_DEVICE_S6 ||
 	    aac->pdev->device == PMC_DEVICE_S7 ||
-	    aac->pdev->device == PMC_DEVICE_S8 ||
-	    aac->pdev->device == PMC_DEVICE_S9) {
+	    aac->pdev->device == PMC_DEVICE_S8) {
 		if (aac->max_msix > 1) {
 			for (i = 0; i < aac->max_msix; i++) {
 				free_irq(pci_irq_vector(aac->pdev, i),
@@ -1837,9 +1836,8 @@ static int aac_acquire_resources(struct aac_dev *dev)
 	aac_adapter_enable_int(dev);
 
 
-	if ((dev->pdev->device == PMC_DEVICE_S7 ||
-	     dev->pdev->device == PMC_DEVICE_S8 ||
-	     dev->pdev->device == PMC_DEVICE_S9))
+	if (dev->pdev->device == PMC_DEVICE_S7 ||
+	    dev->pdev->device == PMC_DEVICE_S8)
 		aac_define_int_mode(dev);
 
 	if (dev->msi_enabled)
-- 
2.15.1

