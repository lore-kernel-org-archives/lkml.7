Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA50C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F59020643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfCMQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:05:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbfCMQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:05:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DG4ISn008100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:05:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r73htn9sr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:05:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Mar 2019 16:05:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 16:05:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DG5Ddd19857654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 16:05:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF826A4053;
        Wed, 13 Mar 2019 16:05:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B84EA4051;
        Wed, 13 Mar 2019 16:05:13 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 16:05:13 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v5 6/7] s390: ap: Cleanup on removing the AP device
Date:   Wed, 13 Mar 2019 17:05:03 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031316-0012-0000-0000-000003022B96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031316-0013-0000-0000-000021395279
Message-Id: <1552493104-30510-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a AP device is remove, clear the queue's APID bit in the guest CRYCB.
to be sure that the guest will not access the AP queue anymore.

Then we clear the interruptions and reset the AP device properly.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 36 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     | 16 +++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 796e73d4..850ba6e 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2018
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  */
 
 #include <linux/module.h>
@@ -12,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <asm/facility.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
@@ -65,6 +68,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 }
 
 /**
+ * vfio_ap_update_crycb
+ * @q: A pointer to the queue being removed
+ *
+ * We clear the APID of the queue, making this queue unusable for the guest.
+ * After this function we can reset the queue without to fear a race with
+ * the guest to access the queue again.
+ * We do not fear race with the host as we still get the device.
+ */
+static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
+{
+	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
+
+	if (!matrix_mdev)
+		return;
+
+	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
+
+	if (!matrix_mdev->kvm)
+		return;
+
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
+				  matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
+}
+
+/**
  * vfio_ap_queue_dev_remove:
  *
  * Free the associated vfio_ap_queue structure
@@ -74,7 +104,13 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	q = dev_get_drvdata(&apdev->device);
+	if (!q)
+		return;
+
 	mutex_lock(&matrix_dev->lock);
+	vfio_ap_update_crycb(q);
+	vfio_ap_mdev_reset_queue(q);
+	vfio_ap_free_irq(q);
 	list_del(&q->list);
 	mutex_unlock(&matrix_dev->lock);
 	kfree(q);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index dc3454f..dc3caa7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -43,15 +43,22 @@ struct vfio_ap_queue *vfio_ap_get_queue(int apqn, struct list_head *l)
 	return NULL;
 }
 
-static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 {
 	struct ap_queue_status status;
-	int retry = 1;
+	int retry = 20;
 
 	do {
 		status = ap_zapq(q->apqn);
 		switch (status.response_code) {
 		case AP_RESPONSE_NORMAL:
+			while (!status.queue_empty && retry--) {
+				msleep(20);
+				status = ap_tapq(q->apqn, NULL);
+			}
+			if (retry <= 0)
+				pr_warn("%s: queue 0x%04x not empty\n",
+					__func__, q->apqn);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -74,7 +81,7 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
  * Unregister the ISC from the GIB alert
  * Clear the vfio_ap_queue intern fields
  */
-static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+void vfio_ap_free_irq(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
@@ -300,6 +307,7 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	list_for_each_entry_safe(q, qtmp, &matrix_mdev->qlist, list) {
 		q->matrix_mdev = NULL;
 		vfio_ap_mdev_reset_queue(q);
+		vfio_ap_free_irq(q);
 		list_move(&q->list, &matrix_dev->free_list);
 	}
 	list_del(&matrix_mdev->node);
@@ -362,6 +370,7 @@ static void vfio_ap_free_queue(int apqn, struct ap_matrix_mdev *matrix_mdev)
 		return;
 	q->matrix_mdev = NULL;
 	vfio_ap_mdev_reset_queue(q);
+	vfio_ap_free_irq(q);
 	list_move(&q->list, &matrix_dev->free_list);
 }
 
@@ -1041,6 +1050,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 
 	list_for_each_entry(q, &matrix_mdev->qlist, list) {
 		ret = vfio_ap_mdev_reset_queue(q);
+		vfio_ap_free_irq(q);
 		/*
 		 * Regardless whether a queue turns out to be busy, or
 		 * is not operational, we need to continue resetting
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 968d8aa..9fe580b 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -4,6 +4,7 @@
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
  *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  *
  * Copyright IBM Corp. 2018
  */
@@ -103,4 +104,6 @@ struct vfio_ap_queue {
 	unsigned char a_isc;
 	unsigned char p_isc;
 };
+void vfio_ap_free_irq(struct vfio_ap_queue *q);
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4

