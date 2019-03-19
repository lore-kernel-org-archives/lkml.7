Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCSVCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:02:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfCSVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:02:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKx89b099836
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:02:05 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb7eg1d4u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:02:04 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 19 Mar 2019 21:02:08 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 21:02:05 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JL1xPV26345610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:02:00 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB3BC6055;
        Tue, 19 Mar 2019 21:01:59 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85D84C6057;
        Tue, 19 Mar 2019 21:01:59 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 21:01:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: occ: Fix power sensor indexing
Date:   Tue, 19 Mar 2019 16:01:58 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19031921-0036-0000-0000-00000A9B5EB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010787; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176766; UDB=6.00615534; IPR=6.00957453;
 MB=3.00026060; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-19 21:02:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031921-0037-0000-0000-00004B1661F9
Message-Id: <1553029318-31703-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of power sensor version 0xA0, the sensor indexing overlapped
with the "caps" power sensors, resulting in probe failure and kernel
warnings. Fix this by specifying the next index for each power sensor
version.

Fixes: 54076cb ("hwmon (occ): Add sensor attributes and register ...")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 391118c..c888f4a 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -889,6 +889,8 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 				s++;
 			}
 		}
+
+		s = (sensors->power.num_sensors * 4) + 1;
 	} else {
 		for (i = 0; i < sensors->power.num_sensors; ++i) {
 			s = i + 1;
@@ -917,11 +919,11 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 						     show_power, NULL, 3, i);
 			attr++;
 		}
-	}
 
-	if (sensors->caps.num_sensors >= 1) {
 		s = sensors->power.num_sensors + 1;
+	}
 
+	if (sensors->caps.num_sensors >= 1) {
 		snprintf(attr->name, sizeof(attr->name), "power%d_label", s);
 		attr->sensor = OCC_INIT_ATTR(attr->name, 0444, show_caps, NULL,
 					     0, 0);
-- 
1.8.3.1

