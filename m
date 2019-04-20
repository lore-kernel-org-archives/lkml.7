Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1ADC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981272147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfDTVt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:49:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfDTVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:49:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3KLmZD1078564
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:49:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ryyjvsrrf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:49:54 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Sat, 20 Apr 2019 22:49:53 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 22:49:51 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3KLnlQY23003290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 21:49:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41A207805E;
        Sat, 20 Apr 2019 21:49:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62B297805C;
        Sat, 20 Apr 2019 21:49:45 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.174.45])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Apr 2019 21:49:45 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 1/8] s390: vfio-ap: maintain a shadow of the CRYCB in use by a guest
Date:   Sat, 20 Apr 2019 17:49:33 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042021-0016-0000-0000-000009A31B7B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010964; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191979; UDB=6.00624740; IPR=6.00972781;
 MB=3.00026529; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 21:49:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042021-0017-0000-0000-000042E47067
Message-Id: <1555796980-27920-2-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904200165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a shadow of the CRYCB being used by a guest. This
will enable to more effectively manage dynamic changes to the AP
resources installed on the host that may be assigned to an mdev device
and being used by a guest. For example:

* AP adapter cards can be dynamically added to and removed from the AP
  configuration via the SE or an SCLP command.

* AP resources that disappear and reappear due to hardware malfunctions.

* AP queues bound to and unbound from the vfio_ap device driver by a
  root user.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 69 ++++++++++++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  2 +
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf20ca5..b0453e6c20d0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -271,6 +271,29 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+/*
+ * vfio_ap_mdev_update_crycb
+ *
+ * @matrix_mdev: the mediated matrix device
+ *
+ * Updates the AP matrix in the guest's CRYCB from it's shadow masks.
+ *
+ * Returns zero if the guest's CRYCB is successfully updated; otherwise,
+ * returns -ENODEV if a guest is not running or does not have a CRYCB.
+ */
+static int vfio_ap_mdev_update_crycb(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (!matrix_mdev->kvm || !matrix_mdev->kvm->arch.crypto.crycbd)
+		return -ENODEV;
+
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
+				  matrix_mdev->shadow_crycb->apm,
+				  matrix_mdev->shadow_crycb->aqm,
+				  matrix_mdev->shadow_crycb->adm);
+
+	return 0;
+}
+
 /**
  * assign_adapter_store
  *
@@ -340,6 +363,9 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	if (matrix_mdev->shadow_crycb)
+		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
+
 	ret = count;
 	goto done;
 
@@ -391,6 +417,9 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+
+	if (matrix_mdev->shadow_crycb)
+		clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -481,6 +510,9 @@ static ssize_t assign_domain_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	if (matrix_mdev->shadow_crycb)
+		set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
+
 	ret = count;
 	goto done;
 
@@ -533,6 +565,10 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+
+	if (matrix_mdev->shadow_crycb)
+		clear_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -582,6 +618,10 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 */
 	mutex_lock(&matrix_dev->lock);
 	set_bit_inv(id, matrix_mdev->matrix.adm);
+
+	if (matrix_mdev->shadow_crycb)
+		set_bit_inv(id, matrix_mdev->shadow_crycb->adm);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -626,6 +666,10 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv(domid, matrix_mdev->matrix.adm);
+
+	if (matrix_mdev->shadow_crycb)
+		clear_bit_inv(domid, matrix_mdev->shadow_crycb->adm);
+
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -779,14 +823,9 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (ret)
 		return NOTIFY_DONE;
 
-	/* If there is no CRYCB pointer, then we can't copy the masks */
-	if (!matrix_mdev->kvm->arch.crypto.crycbd)
+	if (vfio_ap_mdev_update_crycb(matrix_mdev))
 		return NOTIFY_DONE;
 
-	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
-				  matrix_mdev->matrix.aqm,
-				  matrix_mdev->matrix.adm);
-
 	return NOTIFY_OK;
 }
 
@@ -838,12 +877,28 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 	return rc;
 }
 
+static int vfio_ap_mdev_create_shadow_crycb(struct ap_matrix_mdev *matrix_mdev)
+{
+	matrix_mdev->shadow_crycb = kzalloc(sizeof(*matrix_mdev->shadow_crycb),
+					    GFP_KERNEL);
+	if (!matrix_mdev->shadow_crycb)
+		return -ENOMEM;
+
+	memcpy(matrix_mdev->shadow_crycb, &matrix_mdev->matrix,
+	       sizeof(matrix_mdev->matrix));
+
+	return 0;
+}
+
 static int vfio_ap_mdev_open(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long events;
 	int ret;
 
+	ret = vfio_ap_mdev_create_shadow_crycb(matrix_mdev);
+	if (ret)
+		return ret;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
@@ -873,6 +928,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
 	module_put(THIS_MODULE);
+	kfree(matrix_mdev->shadow_crycb);
+	matrix_mdev->shadow_crycb = NULL;
 }
 
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 76b7f98e47e9..e8457aa61976 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -72,6 +72,7 @@ struct ap_matrix {
  * @list:	allows the ap_matrix_mdev struct to be added to a list
  * @matrix:	the adapters, usage domains and control domains assigned to the
  *		mediated matrix device.
+ * @shadow_crycb: a shadow copy of the crycb in use by a guest
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
  * @kvm:	the struct holding guest's state
@@ -79,6 +80,7 @@ struct ap_matrix {
 struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
+	struct ap_matrix *shadow_crycb;
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
 };
-- 
2.7.4

