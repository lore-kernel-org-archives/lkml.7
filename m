Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6777CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362C620643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCMQGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:06:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726688AbfCMQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:05:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DG4JIU098555
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:05:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r74xhrgd6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:05:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 13 Mar 2019 16:05:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 16:05:11 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DG59uZ48234616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 16:05:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59625A405D;
        Wed, 13 Mar 2019 16:05:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9A24A4055;
        Wed, 13 Mar 2019 16:05:08 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 16:05:08 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v5 3/7] vfio: ap: register IOMMU VFIO notifier
Date:   Wed, 13 Mar 2019 17:05:00 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19031316-0028-0000-0000-00000353939D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031316-0029-0000-0000-000024121C99
Message-Id: <1552493104-30510-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to use the VFIO interface to facilitate the
mediated device memory pinning/unpinning we need to register
a notifier for IOMMU.

While we will start to pin one guest page for the interrupt indicator
byte, this is still ok with ballooning as this page will never be
used by the guest virtio-balloon driver.
So the pinned page will never be freed. And even a broken guest does
so, that would not impact the host as the original page is still
in control by vfio.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 53 ++++++++++++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 485595c..0f8952c23 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -757,6 +757,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 };
 
 /**
+ * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
+ *
+ * @nb: The notifier block
+ * @action: Action to be taken
+ * @data: data associated with the request
+ *
+ * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
+ * pinned before). Other requests are ignored.
+ *
+ */
+static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
+
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		struct vfio_iommu_type1_dma_unmap *unmap = data;
+		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
+
+		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+
+/**
  * vfio_ap_mdev_set_kvm
  *
  * @matrix_mdev: a mediated matrix device
@@ -855,12 +885,25 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 
 	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				     &events, &matrix_mdev->group_notifier);
-	if (ret) {
-		module_put(THIS_MODULE);
-		return ret;
-	}
+	if (ret)
+		goto err_group;
+
+	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
+	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &matrix_mdev->iommu_notifier);
+	if (ret)
+		goto err_iommu;
 
 	return 0;
+
+err_iommu:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+err_group:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static void vfio_ap_mdev_release(struct mdev_device *mdev)
@@ -872,6 +915,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 
 	matrix_mdev->kvm = NULL;
 	vfio_ap_mdev_reset_queues(mdev);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	module_put(THIS_MODULE);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 3e6940c..4a287c8 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -82,9 +82,11 @@ struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
+	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
 	struct list_head qlist;
+	struct mdev_device *mdev;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
2.7.4

