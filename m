Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C957DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9120850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDKVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:04:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726667AbfDKVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:04:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BKn5lo018560
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:04:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rtc2cb02j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:04:51 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 11 Apr 2019 22:03:39 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 22:03:37 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BL3XvI33554676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 21:03:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AFCAAE05F;
        Thu, 11 Apr 2019 21:03:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A2CBAE062;
        Thu, 11 Apr 2019 21:03:33 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.endicott.ibm.com (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Apr 2019 21:03:33 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 4/7] s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
Date:   Thu, 11 Apr 2019 17:03:21 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041121-0060-0000-0000-0000032BC104
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010910; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187697; UDB=6.00622146; IPR=6.00968461;
 MB=3.00026399; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 21:03:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041121-0061-0000-0000-000048EAC352
Message-Id: <1555016604-2008-5-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow adapters, domains and control domains to be assigned to or
unassigned from an AP matrix mdev device while it is in use by a guest.
When an adapter, domain or control domain is assigned to or unassigned
from an mdev device while a guest is using it, the guest's CRYCB will be
updated thus giving access to the resource assigned, or taking access away
from the resource unassigned for the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 68 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index cb3e4f7671be..cda1d216ee38 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -155,6 +155,24 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+/*
+ * vfio_ap_mdev_update_crycb
+ *
+ * @matrix_mdev: the mediated matrix device
+ *
+ * Updates the AP matrix in the guest's CRYCB from the masks configured for the
+ * mediated matrix device via its sysfs interfaces.
+ */
+static void vfio_ap_mdev_update_crycb(struct ap_matrix_mdev *matrix_mdev)
+{
+	if (matrix_mdev->kvm) {
+		kvm_arch_crypto_set_masks(matrix_mdev->kvm,
+					  matrix_mdev->matrix.apm,
+					  matrix_mdev->matrix.aqm,
+					  matrix_mdev->matrix.adm);
+	}
+}
+
 /**
  * assign_adapter_store
  *
@@ -196,10 +214,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -214,16 +228,12 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 */
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
-	if (ret)
-		goto done;
-
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
 	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
 						 matrix_mdev->matrix.aqm);
 
-	/* If any APQN is reserved for used by the default drivers */
+	/* If any APQN is owned by the default drivers */
 	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
 	if (ret)
 		goto error;
@@ -232,6 +242,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (ret)
 		goto error;
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
@@ -270,10 +281,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -283,6 +290,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -331,10 +339,6 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
-	/* If the guest is running, disallow assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -355,12 +359,13 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
-		goto share_err;
+		goto error;
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
-share_err:
+error:
 	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -396,10 +401,6 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -409,6 +410,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -440,10 +442,6 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -451,13 +449,16 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	if (id > matrix_mdev->matrix.adm_max)
 		return -ENODEV;
 
-	/* Set the bit in the ADM (bitmask) corresponding to the AP control
-	 * domain number (id). The bits in the mask, from most significant to
-	 * least significant, correspond to IDs 0 up to the one less than the
-	 * number of control domains that can be assigned.
+	/*
+	 * Set the bits in the ADM (bitmask) corresponding to the AP control
+	 * domain numbers in dommask. The bits in the mask, from left to right,
+	 * correspond to IDs 0 up to the one less than the number of control
+	 * domains that can be assigned.
+	 *
 	 */
 	mutex_lock(&matrix_dev->lock);
 	set_bit_inv(id, matrix_mdev->matrix.adm);
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -490,10 +491,6 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
-	/* If the guest is running, disallow un-assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -502,6 +499,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv(domid, matrix_mdev->matrix.adm);
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
-- 
2.7.4

