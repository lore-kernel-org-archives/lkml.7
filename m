Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2303217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDTVuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:50:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727881AbfDTVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:50:03 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3KLmZws052311
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:01 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ryyje24mx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:01 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Sat, 20 Apr 2019 22:50:00 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 22:49:57 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3KLnrgB28180706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 21:49:53 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CAFC78063;
        Sat, 20 Apr 2019 21:49:53 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91F497805C;
        Sat, 20 Apr 2019 21:49:51 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.174.45])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Apr 2019 21:49:51 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 4/8] s390: vfio-ap: allow hot plug/unplug of AP resources using mdev device
Date:   Sat, 20 Apr 2019 17:49:36 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042021-0004-0000-0000-000014FFE98A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010964; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191979; UDB=6.00624739; IPR=6.00972781;
 MB=3.00026529; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 21:49:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042021-0005-0000-0000-00008B563E1A
Message-Id: <1555796980-27920-5-git-send-email-akrowiak@linux.ibm.com>
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

Let's allow adapters, domains and control domains to be assigned to or
unassigned from an AP matrix mdev device while it is in use by a guest.
When an adapter, domain or control domain is assigned to or unassigned
from an mdev device while a guest is using it, the guest's CRYCB will be
updated thus giving access to the resource assigned, or taking access away
from the resource unassigned for the guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 49 ++++++++++++---------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 221491a9ba95..091804317c5e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -219,10 +219,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -237,10 +233,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 	 */
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);
-	if (ret)
-		goto done;
-
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
 	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
@@ -258,6 +250,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
@@ -296,10 +289,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of adapter */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apid);
 	if (ret)
 		return ret;
@@ -312,6 +301,8 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
+
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -360,10 +351,6 @@ static ssize_t assign_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_apqi = matrix_mdev->matrix.aqm_max;
 
-	/* If the guest is running, disallow assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -384,15 +371,16 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
-		goto share_err;
+		goto error;
 
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	ret = count;
 	goto done;
 
-share_err:
+error:
 	clear_bit_inv(apqi, matrix_mdev->matrix.aqm);
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -428,10 +416,6 @@ static ssize_t unassign_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow un-assignment of domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &apqi);
 	if (ret)
 		return ret;
@@ -445,6 +429,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -476,10 +461,6 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	struct mdev_device *mdev = mdev_from_dev(dev);
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
-	/* If the guest is running, disallow assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &id);
 	if (ret)
 		return ret;
@@ -487,10 +468,12 @@ static ssize_t assign_control_domain_store(struct device *dev,
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
@@ -498,6 +481,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(id, matrix_mdev->shadow_crycb->adm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -530,10 +514,6 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 	unsigned long max_domid =  matrix_mdev->matrix.adm_max;
 
-	/* If the guest is running, disallow un-assignment of control domain */
-	if (matrix_mdev->kvm)
-		return -EBUSY;
-
 	ret = kstrtoul(buf, 0, &domid);
 	if (ret)
 		return ret;
@@ -546,6 +526,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	if (matrix_mdev->shadow_crycb)
 		clear_bit_inv(domid, matrix_mdev->shadow_crycb->adm);
 
+	vfio_ap_mdev_update_crycb(matrix_mdev);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
-- 
2.7.4

