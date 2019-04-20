Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD378C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6E208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfDTVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 17:49:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbfDTVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 17:49:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3KLmoQA085474
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:49:56 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ryykw9fa7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 17:49:56 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Sat, 20 Apr 2019 22:49:55 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Apr 2019 22:49:53 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3KLnnEg27001056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Apr 2019 21:49:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478017805F;
        Sat, 20 Apr 2019 21:49:49 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78FBC7805C;
        Sat, 20 Apr 2019 21:49:47 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.174.45])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Apr 2019 21:49:47 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 2/8] s390: vfio-ap: sysfs interface to display guest CRYCB
Date:   Sat, 20 Apr 2019 17:49:34 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555796980-27920-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042021-8235-0000-0000-00000E831FD6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010964; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191979; UDB=6.00624740; IPR=6.00972781;
 MB=3.00026529; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-20 21:49:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042021-8236-0000-0000-0000453A35DC
Message-Id: <1555796980-27920-3-git-send-email-akrowiak@linux.ibm.com>
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

Introduces a sysfs interface on the matrix mdev device to display the
contents of the shadow of the guest's CRYCB

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b0453e6c20d0..eae4ee24460a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -750,6 +750,63 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(matrix);
 
+static ssize_t guest_matrix_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	char *bufpos = buf;
+	unsigned long apid;
+	unsigned long apqi;
+	unsigned long apid1;
+	unsigned long apqi1;
+	unsigned long napm_bits = matrix_mdev->shadow_crycb->apm_max + 1;
+	unsigned long naqm_bits = matrix_mdev->shadow_crycb->aqm_max + 1;
+	int nchars = 0;
+	int n;
+
+	if (!matrix_mdev->shadow_crycb)
+		return -ENODEV;
+
+	apid1 = find_first_bit_inv(matrix_mdev->shadow_crycb->apm, napm_bits);
+	apqi1 = find_first_bit_inv(matrix_mdev->shadow_crycb->aqm, naqm_bits);
+
+	mutex_lock(&matrix_dev->lock);
+
+	if ((apid1 < napm_bits) && (apqi1 < naqm_bits)) {
+		for_each_set_bit_inv(apid, matrix_mdev->shadow_crycb->apm,
+				     napm_bits) {
+			for_each_set_bit_inv(apqi,
+					     matrix_mdev->shadow_crycb->aqm,
+					     naqm_bits) {
+				n = sprintf(bufpos, "%02lx.%04lx\n", apid,
+					    apqi);
+				bufpos += n;
+				nchars += n;
+			}
+		}
+	} else if (apid1 < napm_bits) {
+		for_each_set_bit_inv(apid, matrix_mdev->shadow_crycb->apm,
+				     napm_bits) {
+			n = sprintf(bufpos, "%02lx.\n", apid);
+			bufpos += n;
+			nchars += n;
+		}
+	} else if (apqi1 < naqm_bits) {
+		for_each_set_bit_inv(apqi, matrix_mdev->shadow_crycb->aqm,
+				     naqm_bits) {
+			n = sprintf(bufpos, ".%04lx\n", apqi);
+			bufpos += n;
+			nchars += n;
+		}
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return nchars;
+}
+static DEVICE_ATTR_RO(guest_matrix);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -759,6 +816,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_unassign_control_domain.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
+	&dev_attr_guest_matrix.attr,
 	NULL,
 };
 
-- 
2.7.4

