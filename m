Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0439A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JsudExQm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vtYz0BKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfLKNJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:09:40 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:28216 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729370AbfLKNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:39 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD47HX020442;
        Wed, 11 Dec 2019 05:09:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EsXBl6jOEgG6N4KmBWXzUicj43VnC/VN09K6aFpHP94=;
 b=JsudExQmxxLXP/rJX5T2aB0wehlhBUB88yQ1Nq1U80QBfBzAKnd/LCMPQybKXuUkwdhi
 Gs0dmFKPQfCFpG02iJ4FseXq9vyJ6kDHBt6CAdfM9alE96n7QfVNdOxpthmH1UavZ7rC
 4+v8aW1evjeHz6zO+3M45IHkx/f+igp5bM1ZdhmTBLcjWLgRlbWjJPv38SWD4nXkBHRh
 w581qdldad1UcVRDzAR4hhrj/Tqu/sHl0iijGLpD2BGP4877HNQJ+p1X7zBqwvHwVVn0
 Rvm9BB/hotNsFpPzaqhh8PHqos8zD13z7r08/HEnzZcu4NahrdGaMjlGXJ4sVlahbxwz sA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp682-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy46Iuak2crElimme3/SUqOu6mGR6makEdSMSd3tK6tz5+bD9LotqvGDZxST1pMc2svtxhWsym+8LUcFghNsq1oSz8K7bjmyUZis0JPf8mvxE4RbJM12Iy9xhEa/+3jtMeogIGPxGe3tLCCvgo/d3e/Dog6m0I4J/OSE0+PeyxxVkuCwkPvr9tbn+CVlEaFG2pLOoubwk6spZ6LKoOFjSpJhkqrJdX2hEVOsPLRvBrXsK0Ic3NRML4CJiW43nmZRF7TsQ2QlZEnGILK5YU3etoI1TYlNYNtj/0Mz+9qnWo/8uzCdz2iZX/POJEdj7sbPhIPXWS2IqKtS0uWvYUC1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsXBl6jOEgG6N4KmBWXzUicj43VnC/VN09K6aFpHP94=;
 b=EGAQXTeMTy9ltEIv6z0yZ70DUSXbzj2i/OXDfRjL1qtsX0jJ3ylqlOnXTldmeWzIhLHGk7HqizvAWeUdp8Hqrkl1N87QXVwRzAb29ZaR++6DpIfxjuNOSR0bYYjK1ZzOciXie/AwzyEkH53oCr3u/XRvOGrYs6CahBWiuEGvfWtbP/HUOUWS0i/D0gVc81dQ2eY/KTiV9RUhrEZNjrrmRZCB0SqB3wMKmHmgYM9WkrQ4wAKBjlXgUzIT/d0NpfvGm0XIuXh6/xFTPBCkbE1mHq5IrgqDMHl7hqVfCL+2qaGJXzBxAqKwFF7UVmNr+tFy06wJSFs54Es4+lFjpHBXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsXBl6jOEgG6N4KmBWXzUicj43VnC/VN09K6aFpHP94=;
 b=vtYz0BKJ54a7v6vP9cYAmcnwyrwEhYUWfqS5RKibIPuH++k2Nap1T5UyTFMaDb3oS3GgMcMD9KVrLENfBxkIUZVr/5YRM0YjmYHo948y1Z0nY3lQW6O61kKp3+0tRBF54VZWIh+SPd7zvi5vmXGK0CoTQXxAm7gq6rcpmavCybg=
Received: from CY1PR07CA0001.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::11) by DM6PR07MB5835.namprd07.prod.outlook.com
 (2603:10b6:5:15e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 13:09:26 +0000
Received: from DM6NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::207) by CY1PR07CA0001.outlook.office365.com
 (2a01:111:e400:c60a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT042.mail.protection.outlook.com (10.13.178.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5a006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:24 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9LKQ011576;
        Wed, 11 Dec 2019 14:09:21 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9LXM011571;
        Wed, 11 Dec 2019 14:09:21 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 01/15] phy: Add DisplayPort configuration options
Date:   Wed, 11 Dec 2019 14:09:06 +0100
Message-ID: <1576069760-11473-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(36092001)(86362001)(4326008)(54906003)(107886003)(426003)(5660300002)(2906002)(316002)(42186006)(81156014)(2616005)(356004)(336012)(26005)(110136005)(186003)(8936002)(70586007)(70206006)(36756003)(6666004)(26826003)(8676002)(478600001)(81166006)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5835;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa816a0c-2522-44b7-e80f-08d77e3b593f
X-MS-TrafficTypeDiagnostic: DM6PR07MB5835:
X-Microsoft-Antispam-PRVS: <DM6PR07MB583597D6729B112D6E14654AD25A0@DM6PR07MB5835.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II7J3TzbtqLb+N/6ojgMkJ9pY1tL9/hszWHROeJTwerXspICaVQdsx4h5OUq0G5Q/xCuXoWrvGjklsyPbpkunEo657nsdkh+of5atVqQcI1Rr5TF9VzhlI2CPjxsuXNLB9WrVawuZN3F5qvImWrnRDn28wn3zDuV8j8ILla1GqL67WcGIXnaVY5Ry3DyWOBq1twrTljvuUiTTiob1QL4gKLGbC6u5NSY3nHSGheRV/trEpyevCIvBghnQIjdUx++/q+ZDsx4aXbD1sL0hnShkHb92YtAdrN+UNDULc+emh64zw8yDzwPq3jY7zcZui0C7Ew07XD3S9fdgPJem9iDPB7+9h4K7n61mnq0wFUXPuTef0GgO3niODPuvcjxqTk+Ngf2AR3/RwITzDWp5SmH6BttPSdAHdld1sHCTpvn15ChJXhaLJE2NEwCct1EJ4ETez2JOT5ncIIijxgslGue1OYVJNc2PKULXh3CaEpVChbOh74W7DKkyD9zG78THhax
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:26.1084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa816a0c-2522-44b7-e80f-08d77e3b593f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5835
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic DP API for configuring DisplayPort PHYs. The parameters
that will be configured are link rate, number of lanes, voltage swing
and pre-emphasis.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 include/linux/phy/phy-dp.h | 95 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h    |  4 ++
 2 files changed, 99 insertions(+)
 create mode 100644 include/linux/phy/phy-dp.h

diff --git a/include/linux/phy/phy-dp.h b/include/linux/phy/phy-dp.h
new file mode 100644
index 0000000..18cad23
--- /dev/null
+++ b/include/linux/phy/phy-dp.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Cadence Design Systems Inc.
+ */
+
+#ifndef __PHY_DP_H_
+#define __PHY_DP_H_
+
+#include <linux/types.h>
+
+/**
+ * struct phy_configure_opts_dp - DisplayPort PHY configuration set
+ *
+ * This structure is used to represent the configuration state of a
+ * DisplayPort phy.
+ */
+struct phy_configure_opts_dp {
+	/**
+	 * @link_rate:
+	 *
+	 * Link Rate, in Mb/s, of the main link.
+	 *
+	 * Allowed values: 1620, 2160, 2430, 2700, 3240, 4320, 5400, 8100 Mb/s
+	 */
+	unsigned int link_rate;
+
+	/**
+	 * @lanes:
+	 *
+	 * Number of active, consecutive, data lanes, starting from
+	 * lane 0, used for the transmissions on main link.
+	 *
+	 * Allowed values: 1, 2, 4
+	 */
+	unsigned int lanes;
+
+	/**
+	 * @voltage:
+	 *
+	 * Voltage swing levels, as specified by DisplayPort specification,
+	 * to be used by particular lanes. One value per lane.
+	 * voltage[0] is for lane 0, voltage[1] is for lane 1, etc.
+	 *
+	 * Maximum value: 3
+	 */
+	unsigned int voltage[4];
+
+	/**
+	 * @pre:
+	 *
+	 * Pre-emphasis levels, as specified by DisplayPort specification, to be
+	 * used by particular lanes. One value per lane.
+	 *
+	 * Maximum value: 3
+	 */
+	unsigned int pre[4];
+
+	/**
+	 * @ssc:
+	 *
+	 * Flag indicating, whether or not to enable spread-spectrum clocking.
+	 *
+	 */
+	u8 ssc : 1;
+
+	/**
+	 * @set_rate:
+	 *
+	 * Flag indicating, whether or not reconfigure link rate and SSC to
+	 * requested values.
+	 *
+	 */
+	u8 set_rate : 1;
+
+	/**
+	 * @set_lanes:
+	 *
+	 * Flag indicating, whether or not reconfigure lane count to
+	 * requested value.
+	 *
+	 */
+	u8 set_lanes : 1;
+
+	/**
+	 * @set_voltages:
+	 *
+	 * Flag indicating, whether or not reconfigure voltage swing
+	 * and pre-emphasis to requested values. Only lanes specified
+	 * by "lanes" parameter will be affected.
+	 *
+	 */
+	u8 set_voltages : 1;
+};
+
+#endif /* __PHY_DP_H_ */
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f14..ba0aab5 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/phy/phy-dp.h>
 #include <linux/phy/phy-mipi-dphy.h>
 
 struct phy;
@@ -46,9 +47,12 @@ enum phy_mode {
  *
  * @mipi_dphy:	Configuration set applicable for phys supporting
  *		the MIPI_DPHY phy mode.
+ * @dp:		Configuration set applicable for phys supporting
+ *		the DisplayPort protocol.
  */
 union phy_configure_opts {
 	struct phy_configure_opts_mipi_dphy	mipi_dphy;
+	struct phy_configure_opts_dp		dp;
 };
 
 /**
-- 
2.7.4

