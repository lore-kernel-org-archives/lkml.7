Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70D1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9769620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEGTgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:36:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfEGTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:36:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47JVhgd081746
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 15:35:59 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbg248p1h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:35:58 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 7 May 2019 20:35:58 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 20:35:56 +0100
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x47JZt9B50987226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 19:35:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33B3978064;
        Tue,  7 May 2019 19:35:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B482078063;
        Tue,  7 May 2019 19:35:54 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 19:35:54 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon (occ): Switch power average to between poll responses
Date:   Tue,  7 May 2019 14:35:51 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19050719-0016-0000-0000-000009AE47F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011067; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200009; UDB=6.00629605; IPR=6.00980892;
 MB=3.00026773; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-07 19:35:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050719-0017-0000-0000-0000431F33F3
Message-Id: <1557257751-12995-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The average power reported in the hwmon OCC driver is not useful
because the time it represents is too short. Instead, store the
previous power accumulator reported by the OCC and average it with the
latest accumulator to obtain an average between poll responses. This
does operate under the assumption that the user polls regularly.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 133 ++++++++++++++++++++++++++++++++-------------
 drivers/hwmon/occ/common.h |   7 +++
 2 files changed, 103 insertions(+), 37 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index e6d3fb5..6ffcee7 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -118,6 +118,53 @@ struct extended_sensor {
 	u8 data[6];
 } __packed;
 
+static void occ_update_prev_power_avgs(struct occ *occ)
+{
+	u8 i;
+	struct power_sensor_1 *ps1;
+	struct power_sensor_2 *ps2;
+	struct power_sensor_a0 *psa0;
+	struct occ_sensor *power = &occ->sensors.power;
+	struct occ_power_avg *prevs = occ->prev_power_avgs;
+
+	switch (power->version) {
+	case 1:
+		for (i = 0; i < power->num_sensors; ++i) {
+			ps1 = ((struct power_sensor_1 *)power->data) + i;
+
+			prevs[i].accumulator =
+				get_unaligned_be32(&ps1->accumulator);
+			prevs[i].update_tag =
+				get_unaligned_be32(&ps1->update_tag);
+		}
+		break;
+	case 2:
+		for (i = 0; i < power->num_sensors; ++i) {
+			ps2 = ((struct power_sensor_2 *)power->data) + i;
+
+			prevs[i].accumulator =
+				get_unaligned_be64(&ps2->accumulator);
+			prevs[i].update_tag =
+				get_unaligned_be32(&ps2->update_tag);
+		}
+		break;
+	case 0xA0:
+		for (i = 0; i < power->num_sensors; ++i) {
+			psa0 = ((struct power_sensor_a0 *)power->data) + i;
+
+			prevs[i].accumulator = psa0->system.accumulator;
+			prevs[i].update_tag = psa0->system.update_tag;
+			prevs[i + 1].accumulator = psa0->proc.accumulator;
+			prevs[i + 1].update_tag = psa0->proc.update_tag;
+			prevs[i + 2].accumulator = psa0->vdd.accumulator;
+			prevs[i + 2].update_tag = psa0->vdd.update_tag;
+			prevs[i + 3].accumulator = psa0->vdn.accumulator;
+			prevs[i + 3].update_tag = psa0->vdn.update_tag;
+		}
+		break;
+	}
+}
+
 static int occ_poll(struct occ *occ)
 {
 	int rc;
@@ -135,6 +182,8 @@ static int occ_poll(struct occ *occ)
 	cmd[6] = checksum & 0xFF;	/* checksum lsb */
 	cmd[7] = 0;
 
+	occ_update_prev_power_avgs(occ);
+
 	/* mutex should already be locked if necessary */
 	rc = occ->send_cmd(occ, cmd);
 	if (rc) {
@@ -208,6 +257,7 @@ int occ_update_response(struct occ *occ)
 	/* limit the maximum rate of polling the OCC */
 	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
 		rc = occ_poll(occ);
+		occ->prev_update = occ->last_update;
 		occ->last_update = jiffies;
 	} else {
 		rc = occ->last_error;
@@ -364,6 +414,14 @@ static ssize_t occ_show_freq_2(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
 }
 
+static u64 occ_power_avg(struct occ *occ, u8 idx, u64 accum, u32 samples)
+{
+	struct occ_power_avg *avg = &occ->prev_power_avgs[idx];
+
+	return div_u64((accum - avg->accumulator) * 1000000ULL,
+		       samples - avg->update_tag);
+}
+
 static ssize_t occ_show_power_1(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -385,13 +443,12 @@ static ssize_t occ_show_power_1(struct device *dev,
 		val = get_unaligned_be16(&power->sensor_id);
 		break;
 	case 1:
-		val = get_unaligned_be32(&power->accumulator) /
-			get_unaligned_be32(&power->update_tag);
-		val *= 1000000ULL;
+		val = occ_power_avg(occ, sattr->index,
+				    get_unaligned_be32(&power->accumulator),
+				    get_unaligned_be32(&power->update_tag));
 		break;
 	case 2:
-		val = (u64)get_unaligned_be32(&power->update_tag) *
-			   occ->powr_sample_time_us;
+		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
 		break;
 	case 3:
 		val = get_unaligned_be16(&power->value) * 1000000ULL;
@@ -403,12 +460,6 @@ static ssize_t occ_show_power_1(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
 }
 
-static u64 occ_get_powr_avg(u64 *accum, u32 *samples)
-{
-	return div64_u64(get_unaligned_be64(accum) * 1000000ULL,
-			 get_unaligned_be32(samples));
-}
-
 static ssize_t occ_show_power_2(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -431,12 +482,12 @@ static ssize_t occ_show_power_2(struct device *dev,
 				get_unaligned_be32(&power->sensor_id),
 				power->function_id, power->apss_channel);
 	case 1:
-		val = occ_get_powr_avg(&power->accumulator,
-				       &power->update_tag);
+		val = occ_power_avg(occ, sattr->index,
+				    get_unaligned_be64(&power->accumulator),
+				    get_unaligned_be32(&power->update_tag));
 		break;
 	case 2:
-		val = (u64)get_unaligned_be32(&power->update_tag) *
-			   occ->powr_sample_time_us;
+		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
 		break;
 	case 3:
 		val = get_unaligned_be16(&power->value) * 1000000ULL;
@@ -452,6 +503,8 @@ static ssize_t occ_show_power_a0(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	int rc;
+	u32 samples;
+	u64 accum;
 	u64 val = 0;
 	struct power_sensor_a0 *power;
 	struct occ *occ = dev_get_drvdata(dev);
@@ -469,12 +522,15 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_system\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 1:
-		val = occ_get_powr_avg(&power->system.accumulator,
-				       &power->system.update_tag);
+		accum = get_unaligned_be64(&power->system.accumulator);
+		samples = get_unaligned_be32(&power->system.update_tag);
+		val = occ_power_avg(occ, sattr->index, accum, samples);
 		break;
 	case 2:
-		val = (u64)get_unaligned_be32(&power->system.update_tag) *
-			   occ->powr_sample_time_us;
+	case 6:
+	case 10:
+	case 14:
+		val = jiffies_to_usecs(occ->last_update - occ->prev_update);
 		break;
 	case 3:
 		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
@@ -483,12 +539,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_proc\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 5:
-		val = occ_get_powr_avg(&power->proc.accumulator,
-				       &power->proc.update_tag);
-		break;
-	case 6:
-		val = (u64)get_unaligned_be32(&power->proc.update_tag) *
-			   occ->powr_sample_time_us;
+		accum = get_unaligned_be64(&power->proc.accumulator);
+		samples = get_unaligned_be32(&power->proc.update_tag);
+		val = occ_power_avg(occ, sattr->index + 1, accum, samples);
 		break;
 	case 7:
 		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
@@ -497,12 +550,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_vdd\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 9:
-		val = occ_get_powr_avg(&power->vdd.accumulator,
-				       &power->vdd.update_tag);
-		break;
-	case 10:
-		val = (u64)get_unaligned_be32(&power->vdd.update_tag) *
-			   occ->powr_sample_time_us;
+		accum = get_unaligned_be64(&power->vdd.accumulator);
+		samples = get_unaligned_be32(&power->vdd.update_tag);
+		val = occ_power_avg(occ, sattr->index + 2, accum, samples);
 		break;
 	case 11:
 		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
@@ -511,12 +561,9 @@ static ssize_t occ_show_power_a0(struct device *dev,
 		return snprintf(buf, PAGE_SIZE - 1, "%u_vdn\n",
 				get_unaligned_be32(&power->sensor_id));
 	case 13:
-		val = occ_get_powr_avg(&power->vdn.accumulator,
-				       &power->vdn.update_tag);
-		break;
-	case 14:
-		val = (u64)get_unaligned_be32(&power->vdn.update_tag) *
-			   occ->powr_sample_time_us;
+		accum = get_unaligned_be64(&power->vdn.accumulator);
+		samples = get_unaligned_be32(&power->vdn.update_tag);
+		val = occ_power_avg(occ, sattr->index + 3, accum, samples);
 		break;
 	case 15:
 		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;
@@ -719,6 +766,7 @@ static ssize_t occ_show_extended(struct device *dev,
 static int occ_setup_sensor_attrs(struct occ *occ)
 {
 	unsigned int i, s, num_attrs = 0;
+	unsigned int power_avgs_size = 0;
 	struct device *dev = occ->bus_dev;
 	struct occ_sensors *sensors = &occ->sensors;
 	struct occ_attribute *attr;
@@ -761,9 +809,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		/* fall through */
 	case 1:
 		num_attrs += (sensors->power.num_sensors * 4);
+		power_avgs_size = sizeof(struct occ_power_avg) *
+			sensors->power.num_sensors;
 		break;
 	case 0xA0:
 		num_attrs += (sensors->power.num_sensors * 16);
+		power_avgs_size = sizeof(struct occ_power_avg) *
+			sensors->power.num_sensors * 4;
 		show_power = occ_show_power_a0;
 		break;
 	default:
@@ -792,6 +844,13 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 		sensors->extended.num_sensors = 0;
 	}
 
+	if (power_avgs_size) {
+		occ->prev_power_avgs = devm_kzalloc(dev, power_avgs_size,
+						    GFP_KERNEL);
+		if (!occ->prev_power_avgs)
+			return -ENOMEM;
+	}
+
 	occ->attrs = devm_kzalloc(dev, sizeof(*occ->attrs) * num_attrs,
 				  GFP_KERNEL);
 	if (!occ->attrs)
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index c676e48..08970f8 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -87,17 +87,24 @@ struct occ_attribute {
 	struct sensor_device_attribute_2 sensor;
 };
 
+struct occ_power_avg {
+	u64 accumulator;
+	u32 update_tag;
+};
+
 struct occ {
 	struct device *bus_dev;
 
 	struct occ_response resp;
 	struct occ_sensors sensors;
+	struct occ_power_avg *prev_power_avgs;
 
 	int powr_sample_time_us;	/* average power sample time */
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
 
 	unsigned long last_update;
+	unsigned long prev_update;
 	struct mutex lock;		/* lock OCC access */
 
 	struct device *hwmon;
-- 
1.8.3.1

