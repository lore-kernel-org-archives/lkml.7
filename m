Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E30C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBB72147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfDTVuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:50:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727850AbfDTVuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:50:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3KLnCVt086240
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ryykw9fb9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:50:00 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Sat, 20 Apr 2019 22:49:59 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 22:49:55 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3KLnpqd61079772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 21:49:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5816F7805C;
        Sat, 20 Apr 2019 21:49:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F99F78060;
        Sat, 20 Apr 2019 21:49:49 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.174.45])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Apr 2019 21:49:49 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 3/8] s390: vfio-ap: allow assignment of unavailable AP resources to mdev device
Date:   Sat, 20 Apr 2019 17:49:35 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042021-0020-0000-0000-00000EDA1D93
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010964; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191979; UDB=6.00624739; IPR=6.00972781;
 MB=3.00026529; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 21:49:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042021-0021-0000-0000-000065813CCE
Message-Id: <1555796980-27920-4-git-send-email-akrowiak@linux.ibm.com>
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

The AP architecture does not preclude assignment of AP resources that are
not yet in the AP configuration (i.e., not available or not online).
Let's go ahead and implement this facet of the AP architecture for linux
guests.

Access to AP resources is controlled by bit masks in a guest's SIE
state description (i.e., the control block containing the state of a
guest). When an AP instruction is executed on the guest, the firmware
combines the masks from the guest's SIE state description with the masks
from the host by doing a logical bitwise AND of the masks to create what
are defined as effective masks. The effective masks determine which AP
resources can be accessed by the guest.

Effective masking allows the assignment of AP resources to a guest even
if the underlying device is not in the AP configuration. If the device
subsequently becomes configured, the guest will automatically have access
to the associated AP resources (e.g., AP queues).

The current implementation does not allow assignment of AP resources to
an mdev device if the AP queues identified by the assignment are not
bound to the vfio_ap device driver. This patch allows assignment of AP
resources to the mdev device even if the AP queues are not bound to the
vfio_ap device driver, as long as the AP queues are not reserved by the
AP BUS for use by the zcrypt device drivers. If the queues are subsequently
bound to the vfio_ap device driver while a running guest is using the mdev
device, the guest will automatically gain access to the queues. Effective
masking prevents access to queues until such time as they become available.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 160 +++++---------------------------------
 1 file changed, 18 insertions(+), 142 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index eae4ee24460a..221491a9ba95 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -113,122 +113,6 @@ static struct attribute_group *vfio_ap_mdev_type_groups[] = {
 	NULL,
 };
 
-struct vfio_ap_queue_reserved {
-	unsigned long *apid;
-	unsigned long *apqi;
-	bool reserved;
-};
-
-/**
- * vfio_ap_has_queue
- *
- * @dev: an AP queue device
- * @data: a struct vfio_ap_queue_reserved reference
- *
- * Flags whether the AP queue device (@dev) has a queue ID containing the APQN,
- * apid or apqi specified in @data:
- *
- * - If @data contains both an apid and apqi value, then @data will be flagged
- *   as reserved if the APID and APQI fields for the AP queue device matches
- *
- * - If @data contains only an apid value, @data will be flagged as
- *   reserved if the APID field in the AP queue device matches
- *
- * - If @data contains only an apqi value, @data will be flagged as
- *   reserved if the APQI field in the AP queue device matches
- *
- * Returns 0 to indicate the input to function succeeded. Returns -EINVAL if
- * @data does not contain either an apid or apqi.
- */
-static int vfio_ap_has_queue(struct device *dev, void *data)
-{
-	struct vfio_ap_queue_reserved *qres = data;
-	struct ap_queue *ap_queue = to_ap_queue(dev);
-	ap_qid_t qid;
-	unsigned long id;
-
-	if (qres->apid && qres->apqi) {
-		qid = AP_MKQID(*qres->apid, *qres->apqi);
-		if (qid == ap_queue->qid)
-			qres->reserved = true;
-	} else if (qres->apid && !qres->apqi) {
-		id = AP_QID_CARD(ap_queue->qid);
-		if (id == *qres->apid)
-			qres->reserved = true;
-	} else if (!qres->apid && qres->apqi) {
-		id = AP_QID_QUEUE(ap_queue->qid);
-		if (id == *qres->apqi)
-			qres->reserved = true;
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-/**
- * vfio_ap_verify_queue_reserved
- *
- * @matrix_dev: a mediated matrix device
- * @apid: an AP adapter ID
- * @apqi: an AP queue index
- *
- * Verifies that the AP queue with @apid/@apqi is reserved by the VFIO AP device
- * driver according to the following rules:
- *
- * - If both @apid and @apqi are not NULL, then there must be an AP queue
- *   device bound to the vfio_ap driver with the APQN identified by @apid and
- *   @apqi
- *
- * - If only @apid is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apid
- *
- * - If only @apqi is not NULL, then there must be an AP queue device bound
- *   to the vfio_ap driver with an APQN containing @apqi
- *
- * Returns 0 if the AP queue is reserved; otherwise, returns -EADDRNOTAVAIL.
- */
-static int vfio_ap_verify_queue_reserved(unsigned long *apid,
-					 unsigned long *apqi)
-{
-	int ret;
-	struct vfio_ap_queue_reserved qres;
-
-	qres.apid = apid;
-	qres.apqi = apqi;
-	qres.reserved = false;
-
-	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
-				     &qres, vfio_ap_has_queue);
-	if (ret)
-		return ret;
-
-	if (qres.reserved)
-		return 0;
-
-	return -EADDRNOTAVAIL;
-}
-
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apid(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apid)
-{
-	int ret;
-	unsigned long apqi;
-	unsigned long nbits = matrix_mdev->matrix.aqm_max + 1;
-
-	if (find_first_bit_inv(matrix_mdev->matrix.aqm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(&apid, NULL);
-
-	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * vfio_ap_mdev_verify_no_sharing
  *
@@ -359,9 +243,17 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	set_bit_inv(apid, matrix_mdev->matrix.apm);
 
+	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
+						 matrix_mdev->matrix.aqm);
+
+	/* If any APQN is owned by a default driver */
+	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
+	if (ret)
+		goto error;
+
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
-		goto share_err;
+		goto error;
 
 	if (matrix_mdev->shadow_crycb)
 		set_bit_inv(apid, matrix_mdev->shadow_crycb->apm);
@@ -369,7 +261,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	ret = count;
 	goto done;
 
-share_err:
+error:
 	clear_bit_inv(apid, matrix_mdev->matrix.apm);
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -426,26 +318,6 @@ static ssize_t unassign_adapter_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(unassign_adapter);
 
-static int
-vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
-					     unsigned long apqi)
-{
-	int ret;
-	unsigned long apid;
-	unsigned long nbits = matrix_mdev->matrix.apm_max + 1;
-
-	if (find_first_bit_inv(matrix_mdev->matrix.apm, nbits) >= nbits)
-		return vfio_ap_verify_queue_reserved(NULL, &apqi);
-
-	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, nbits) {
-		ret = vfio_ap_verify_queue_reserved(&apid, &apqi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 /**
  * assign_domain_store
  *
@@ -500,12 +372,16 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 
-	ret = vfio_ap_mdev_verify_queues_reserved_for_apqi(matrix_mdev, apqi);
-	if (ret)
-		goto done;
-
 	set_bit_inv(apqi, matrix_mdev->matrix.aqm);
 
+	ret = ap_apqn_in_matrix_owned_by_def_drv(matrix_mdev->matrix.apm,
+						 matrix_mdev->matrix.aqm);
+
+	/* If any APQN is owned by a default driver */
+	ret = (ret == 1) ? -EADDRNOTAVAIL : ret;
+	if (ret)
+		goto error;
+
 	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
 	if (ret)
 		goto share_err;
-- 
2.7.4

