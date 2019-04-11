Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8AEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1A52186A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKVDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfDKVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:03:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BKn52M002013
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:03:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtc83ac13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:03:36 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 11 Apr 2019 22:03:35 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 22:03:33 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BL3TLq34734090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 21:03:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 379C4AE063;
        Thu, 11 Apr 2019 21:03:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C07E1AE060;
        Thu, 11 Apr 2019 21:03:28 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.endicott.ibm.com (unknown [9.60.75.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Apr 2019 21:03:28 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource in use
Date:   Thu, 11 Apr 2019 17:03:18 -0400
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041121-2213-0000-0000-000003752B8D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010910; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187698; UDB=6.00622145; IPR=6.00968461;
 MB=3.00026399; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 21:03:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041121-2214-0000-0000-00005DFD1D12
Message-Id: <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
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

Introduces a new driver callback to prevent a root user from unbinding
an AP queue from its device driver if the queue is in use. This prevents
a root user from inadvertently taking a queue away from a guest and
giving it to the host, or vice versa. The callback will be invoked
whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
result in one or more AP queues being removed from its driver. If the
callback responds in the affirmative for any driver queried, the change
to the apmask or aqmask will be rejected with a device in use error.

For this patch, only non-default drivers will be queried. Currently,
there is only one non-default driver, the vfio_ap device driver. The
vfio_ap device driver manages AP queues passed through to one or more
guests and we don't want to unexpectedly take AP resources away from
guests which are most likely independently administered.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
 drivers/s390/crypto/ap_bus.h |   3 +
 2 files changed, 135 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 1546389d71db..66a5a9d9fae6 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -35,6 +35,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/debugfs.h>
 #include <linux/ctype.h>
+#include <linux/module.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -980,9 +981,11 @@ int ap_parse_mask_str(const char *str,
 	newmap = kmalloc(size, GFP_KERNEL);
 	if (!newmap)
 		return -ENOMEM;
-	if (mutex_lock_interruptible(lock)) {
-		kfree(newmap);
-		return -ERESTARTSYS;
+	if (lock) {
+		if (mutex_lock_interruptible(lock)) {
+			kfree(newmap);
+			return -ERESTARTSYS;
+		}
 	}
 
 	if (*str == '+' || *str == '-') {
@@ -994,7 +997,10 @@ int ap_parse_mask_str(const char *str,
 	}
 	if (rc == 0)
 		memcpy(bitmap, newmap, size);
-	mutex_unlock(lock);
+
+	if (lock)
+		mutex_unlock(lock);
+
 	kfree(newmap);
 	return rc;
 }
@@ -1181,12 +1187,72 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
 	return rc;
 }
 
+static int __verify_card_reservations(struct device_driver *drv, void *data)
+{
+	int rc = 0;
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+	unsigned long *newapm = (unsigned long *)data;
+
+	/*
+	 * If the reserved bits do not identify cards reserved for use by the
+	 * non-default driver, there is no need to verify the driver is using
+	 * the queues.
+	 */
+	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
+		return 0;
+
+	/* Pin the driver's module code */
+	if (!try_module_get(drv->owner))
+		return 0;
+
+	if (ap_drv->in_use)
+		if (ap_drv->in_use(newapm, ap_perms.aqm))
+			rc = -EADDRINUSE;
+
+	module_put(drv->owner);
+
+	return rc;
+}
+
+static int apmask_commit(unsigned long *newapm)
+{
+	int rc;
+	unsigned long reserved[BITS_TO_LONGS(AP_DEVICES)];
+
+	/*
+	 * Check if any bits in the apmask have been set which will
+	 * result in queues being removed from non-default drivers
+	 */
+	if (bitmap_andnot(reserved, newapm, ap_perms.apm, AP_DEVICES)) {
+		rc = (bus_for_each_drv(&ap_bus_type, NULL, reserved,
+				       __verify_card_reservations));
+		if (rc)
+			return rc;
+	}
+
+	memcpy(ap_perms.apm, newapm, APMASKSIZE);
+
+	return 0;
+}
+
 static ssize_t apmask_store(struct bus_type *bus, const char *buf,
 			    size_t count)
 {
 	int rc;
+	unsigned long newapm[BITS_TO_LONGS(AP_DEVICES)];
+
+	memcpy(newapm, ap_perms.apm, APMASKSIZE);
+
+	rc = ap_parse_mask_str(buf, newapm, AP_DEVICES, NULL);
+	if (rc)
+		return rc;
+
+	if (mutex_lock_interruptible(&ap_perms_mutex))
+		return -ERESTARTSYS;
+
+	rc = apmask_commit(newapm);
+	mutex_unlock(&ap_perms_mutex);
 
-	rc = ap_parse_mask_str(buf, ap_perms.apm, AP_DEVICES, &ap_perms_mutex);
 	if (rc)
 		return rc;
 
@@ -1212,12 +1278,72 @@ static ssize_t aqmask_show(struct bus_type *bus, char *buf)
 	return rc;
 }
 
+static int __verify_queue_reservations(struct device_driver *drv, void *data)
+{
+	int rc = 0;
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+	unsigned long *newaqm = (unsigned long *)data;
+
+	/*
+	 * If the reserved bits do not identify queues reserved for use by the
+	 * non-default driver, there is no need to verify the driver is using
+	 * the queues.
+	 */
+	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
+		return 0;
+
+	/* Pin the driver's module code */
+	if (!try_module_get(drv->owner))
+		return 0;
+
+	if (ap_drv->in_use)
+		if (ap_drv->in_use(ap_perms.apm, newaqm))
+			rc = -EADDRINUSE;
+
+	module_put(drv->owner);
+
+	return rc;
+}
+
+static int aqmask_commit(unsigned long *newaqm)
+{
+	int rc;
+	unsigned long reserved[BITS_TO_LONGS(AP_DOMAINS)];
+
+	/*
+	 * Check if any bits in the aqmask have been set which will
+	 * result in queues being removed from non-default drivers
+	 */
+	if (bitmap_andnot(reserved, newaqm, ap_perms.aqm, AP_DOMAINS)) {
+		rc = (bus_for_each_drv(&ap_bus_type, NULL, reserved,
+				       __verify_queue_reservations));
+		if (rc)
+			return rc;
+	}
+
+	memcpy(ap_perms.aqm, newaqm, APMASKSIZE);
+
+	return 0;
+}
+
 static ssize_t aqmask_store(struct bus_type *bus, const char *buf,
 			    size_t count)
 {
 	int rc;
+	unsigned long newaqm[BITS_TO_LONGS(AP_DOMAINS)];
+
+	memcpy(newaqm, ap_perms.aqm, AQMASKSIZE);
+
+	rc = ap_parse_mask_str(buf, newaqm, AP_DOMAINS, NULL);
+	if (rc)
+		return rc;
+
+	if (mutex_lock_interruptible(&ap_perms_mutex))
+		return -ERESTARTSYS;
+
+	rc = aqmask_commit(newaqm);
+	mutex_unlock(&ap_perms_mutex);
 
-	rc = ap_parse_mask_str(buf, ap_perms.aqm, AP_DOMAINS, &ap_perms_mutex);
 	if (rc)
 		return rc;
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 15a98a673c5c..b00952d5fdbb 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -137,6 +137,7 @@ struct ap_driver {
 	void (*remove)(struct ap_device *);
 	void (*suspend)(struct ap_device *);
 	void (*resume)(struct ap_device *);
+	bool (*in_use)(unsigned long *apm, unsigned long *aqm);
 };
 
 #define to_ap_drv(x) container_of((x), struct ap_driver, driver)
@@ -262,6 +263,8 @@ void ap_queue_reinit_state(struct ap_queue *aq);
 struct ap_card *ap_card_create(int id, int queue_depth, int raw_device_type,
 			       int comp_device_type, unsigned int functions);
 
+#define APMASKSIZE (BITS_TO_LONGS(AP_DEVICES) * sizeof(unsigned long))
+#define AQMASKSIZE (BITS_TO_LONGS(AP_DOMAINS) * sizeof(unsigned long))
 struct ap_perms {
 	unsigned long ioctlm[BITS_TO_LONGS(AP_IOCTLS)];
 	unsigned long apm[BITS_TO_LONGS(AP_DEVICES)];
-- 
2.7.4

