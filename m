Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EFCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A37D262EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ieNj+yxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfE3XMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:12:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbfE3XML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:12:11 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UN9Y06030401
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:12:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=L+Xo4JtXD536apqmBpEwKLsnjYbEVrCerp8o0Fqlvl8=;
 b=ieNj+yxWu54i17/IIDJ3/sRL8AHZZ+waW9dmChEeyYvd6xbK0fTpseG9rwzauQZFlmdR
 2YZ/WwoMcUCn9Kvk8OF61nfe21gCVi29TQysQg8BW46xcPoN564htbwE7jsjjxDb1ZPm
 O7pA2TN466aTQiYHL1K681zDHWUA5vClPO8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2stgjuhud9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:12:11 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 30 May 2019 16:12:07 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 0C898E9320CC; Thu, 30 May 2019 16:12:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <sdasari@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Date:   Thu, 30 May 2019 16:11:57 -0700
Message-ID: <20190530231159.222188-2-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530231159.222188-1-vijaykhemka@fb.com>
References: <20190530231159.222188-1-vijaykhemka@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300162
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for Infenion PXE1610 driver

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
Changes in v2:
incorporated all the feedback from Guenter Roeck <linux@roeck-us.net>

 Documentation/hwmon/pxe1610 | 90 +++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/hwmon/pxe1610

diff --git a/Documentation/hwmon/pxe1610 b/Documentation/hwmon/pxe1610
new file mode 100644
index 000000000000..24825db8736f
--- /dev/null
+++ b/Documentation/hwmon/pxe1610
@@ -0,0 +1,90 @@
+Kernel driver pxe1610
+=====================
+
+Supported chips:
+  * Infinion PXE1610
+    Prefix: 'pxe1610'
+    Addresses scanned: -
+    Datasheet: Datasheet is not publicly available.
+
+  * Infinion PXE1110
+    Prefix: 'pxe1110'
+    Addresses scanned: -
+    Datasheet: Datasheet is not publicly available.
+
+  * Infinion PXM1310
+    Prefix: 'pxm1310'
+    Addresses scanned: -
+    Datasheet: Datasheet is not publicly available.
+
+Author: Vijay Khemka <vijaykhemka@fb.com>
+
+
+Description
+-----------
+
+PXE1610/PXE1110 are Multi-rail/Multiphase Digital Controllers
+and compliant to
+	-- Intel VR13 DC-DC converter specifications.
+	-- Intel SVID protocol.
+Used for Vcore power regulation for Intel VR13 based microprocessors
+	-- Servers, Workstations, and High-end desktops
+
+PXM1310 is a Multi-rail Controllers and it is compliant to
+	-- Intel VR13 DC-DC converter specifications.
+	-- Intel SVID protocol.
+Used for DDR3/DDR4 Memory power regulation for Intel VR13 and
+IMVP8 based systems
+
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have
+to instantiate devices explicitly.
+
+Example: the following commands will load the driver for an PXE1610
+at address 0x70 on I2C bus #4:
+
+# modprobe pxe1610
+# echo pxe1610 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
+
+It can also be instantiated by declaring in device tree
+
+
+Sysfs attributes
+----------------
+
+curr1_label		"iin"
+curr1_input		Measured input current
+curr1_alarm		Current high alarm
+
+curr[2-4]_label		"iout[1-3]"
+curr[2-4]_input		Measured output current
+curr[2-4]_crit		Critical maximum current
+curr[2-4]_crit_alarm	Current critical high alarm
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_crit		Critical maximum input voltage
+in1_crit_alarm		Input voltage critical high alarm
+
+in[2-4]_label		"vout[1-3]"
+in[2-4]_input		Measured output voltage
+in[2-4]_lcrit		Critical minimum output voltage
+in[2-4]_lcrit_alarm	Output voltage critical low alarm
+in[2-4]_crit		Critical maximum output voltage
+in[2-4]_crit_alarm	Output voltage critical high alarm
+
+power1_label		"pin"
+power1_input		Measured input power
+power1_alarm		Input power high alarm
+
+power[2-4]_label	"pout[1-3]"
+power[2-4]_input	Measured output power
+
+temp[1-3]_input		Measured temperature
+temp[1-3]_crit		Critical high temperature
+temp[1-3]_crit_alarm	Chip temperature critical high alarm
+temp[1-3]_max		Maximum temperature
+temp[1-3]_max_alarm	Chip temperature high alarm
-- 
2.17.1

