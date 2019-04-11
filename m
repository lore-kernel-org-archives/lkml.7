Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BC7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC532070D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDKVEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:04:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbfDKVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:03:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BKnqjH095436
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:03:39 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtc9v261e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:03:38 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 11 Apr 2019 22:03:37 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 22:03:34 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BL3U5429294784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 21:03:31 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96B26AE05C;
        Thu, 11 Apr 2019 21:03:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4692DAE05F;
        Thu, 11 Apr 2019 21:03:30 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.endicott.ibm.com (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Apr 2019 21:03:30 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 2/7] s390: vfio-ap: implement in-use callback for vfio_ap driver
Date:   Thu, 11 Apr 2019 17:03:19 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041121-0064-0000-0000-000003C9BCC9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010910; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187698; UDB=6.00622145; IPR=6.00968461;
 MB=3.00026399; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 21:03:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041121-0065-0000-0000-00003D07C1D1
Message-Id: <1555016604-2008-3-git-send-email-akrowiak@linux.ibm.com>
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

Let's implement the callback to indicate when an APQN
is in use by the vfio_ap device driver. The callback is
invoked whenever a change to the apmask or aqmask may
result in one or APQNs being removed from the driver. The
vfio_ap device driver will indicate a resource is in use
if any of the removed APQNs are assigned to any of the matrix
mdev devices.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index e9824c35c34f..f340a28c1d65 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -139,6 +139,28 @@ static void vfio_ap_matrix_dev_destroy(void)
 	root_device_unregister(root_device);
 }
 
+static bool vfio_ap_resource_in_use(unsigned long *apm, unsigned long *aqm)
+{
+	bool in_use = false;
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->lock);
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (bitmap_intersects(matrix_mdev->matrix.apm,
+				      apm, AP_DEVICES) &&
+		    bitmap_intersects(matrix_mdev->matrix.aqm,
+				      aqm, AP_DOMAINS)) {
+			in_use = true;
+			break;
+		}
+	}
+
+	mutex_unlock(&matrix_dev->lock);
+
+	return in_use;
+}
+
 static int __init vfio_ap_init(void)
 {
 	int ret;
@@ -154,6 +176,7 @@ static int __init vfio_ap_init(void)
 	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
 	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
 	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.in_use = vfio_ap_resource_in_use;
 	vfio_ap_drv.ids = ap_queue_ids;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
-- 
2.7.4

