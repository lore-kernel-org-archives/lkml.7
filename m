Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633FEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B972087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfDPPoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbfDPPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GFdJtr046622
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:10 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rwgtwukrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:44:09 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 16 Apr 2019 16:44:09 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Apr 2019 16:44:06 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3GFi5g524903904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 15:44:05 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73FD56E053;
        Tue, 16 Apr 2019 15:44:05 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E62446E062;
        Tue, 16 Apr 2019 15:44:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Apr 2019 15:44:04 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        andrew@aj.id.au, mine260309@gmail.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/3] hwmon (occ): Prevent sysfs error attribute from returning error
Date:   Tue, 16 Apr 2019 15:43:49 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
References: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19041615-0020-0000-0000-00000ED8612F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010938; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189952; UDB=6.00623517; IPR=6.00970747;
 MB=3.00026468; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 15:44:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041615-0021-0000-0000-00006574719A
Message-Id: <1555429430-23118-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=950 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error sysfs attribute returns the stored error state of the OCC and
doesn't depend on the OCC poll response. Therefore, split the error
attribute into it's own function to avoid failing out of the function if
the poll response fails.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/sysfs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
index 1cb1e65..c73be07 100644
--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -63,9 +63,6 @@ static ssize_t occ_sysfs_show(struct device *dev,
 		else
 			val = 1;
 		break;
-	case 8:
-		val = occ->error;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -73,6 +70,16 @@ static ssize_t occ_sysfs_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%d\n", val);
 }
 
+static ssize_t occ_error_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct occ *occ = dev_get_drvdata(dev);
+
+	occ_update_response(occ);
+
+	return snprintf(buf, PAGE_SIZE - 1, "%d\n", occ->error);
+}
+
 static SENSOR_DEVICE_ATTR(occ_master, 0444, occ_sysfs_show, NULL, 0);
 static SENSOR_DEVICE_ATTR(occ_active, 0444, occ_sysfs_show, NULL, 1);
 static SENSOR_DEVICE_ATTR(occ_dvfs_overtemp, 0444, occ_sysfs_show, NULL, 2);
@@ -81,7 +88,7 @@ static SENSOR_DEVICE_ATTR(occ_mem_throttle, 0444, occ_sysfs_show, NULL, 4);
 static SENSOR_DEVICE_ATTR(occ_quick_pwr_drop, 0444, occ_sysfs_show, NULL, 5);
 static SENSOR_DEVICE_ATTR(occ_state, 0444, occ_sysfs_show, NULL, 6);
 static SENSOR_DEVICE_ATTR(occs_present, 0444, occ_sysfs_show, NULL, 7);
-static SENSOR_DEVICE_ATTR(occ_error, 0444, occ_sysfs_show, NULL, 8);
+static DEVICE_ATTR_RO(occ_error);
 
 static struct attribute *occ_attributes[] = {
 	&sensor_dev_attr_occ_master.dev_attr.attr,
@@ -92,7 +99,7 @@ static struct attribute *occ_attributes[] = {
 	&sensor_dev_attr_occ_quick_pwr_drop.dev_attr.attr,
 	&sensor_dev_attr_occ_state.dev_attr.attr,
 	&sensor_dev_attr_occs_present.dev_attr.attr,
-	&sensor_dev_attr_occ_error.dev_attr.attr,
+	&dev_attr_occ_error.attr,
 	NULL
 };
 
@@ -156,7 +163,7 @@ void occ_sysfs_poll_done(struct occ *occ)
 	}
 
 	if (occ->error && occ->error != occ->prev_error) {
-		name = sensor_dev_attr_occ_error.dev_attr.attr.name;
+		name = dev_attr_occ_error.attr.name;
 		sysfs_notify(&occ->bus_dev->kobj, NULL, name);
 	}
 
-- 
2.7.4

