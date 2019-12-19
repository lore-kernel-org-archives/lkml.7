Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAFEC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB9324679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="hORTvP1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSLk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:40:58 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10398 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbfLSLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:40:57 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJBeDqW010166;
        Thu, 19 Dec 2019 06:40:31 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wvw8cv761-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 06:40:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7yftgj9mrGF9CRl1FazNOu1TfFEsU+8YCGNEg79REgI+6iS4SaEYv44X0iTvF7AXMoCc2//U7R21fTcuXrF+poiDKduaJX63gxC0ho9yfuia/w7Y4TEiutDETZy5jL6JS4Uw3uZYM3s1Y7SASB6+DCORdHeOZRnH638Kq7MBtRINy3jaOVaf8gboEl7Eha4g/aqoYnxYfQec0XW5RLmkwP1yBvUjCS2ymuAxkYJKD14Db1iFUiiSicwPyHXRxeK1A/NupF/sipMlv4m6F43Dn+3yNbUKTjSVhEDzfYFb86KuDrsHAn8WjQaxOmqUM+OJj5yOxXcfsNN4aUahb8jPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF93YnDD0scTyVQJe1yqDvyxk012fv/hY+6cFxH0iGU=;
 b=f7tqGcgMIe21H9iUzuvRqFtbNgvu9NMS/lZ0U9e+iLL3vFHlkj6rnXcbRZayjYAnX2HFJR+5ob41B5bY2HU1rh2RlvfwulKHLLW+SMtFe16FJgkbaFnsdarj6KjB/OkCq1z9AR+AgvnoQ6mHpsoXCJeYrDY2Vt3SFAqQaTsk6GVCZtmM8rnNLPeo3dkTi4fviz84hLBSKroDUn7vljmGmIZBY0agjUy+sF8ZPye7Z73g5P5y+G8BlJ3DqlyEfMWlIvefSabuW/ZnKy/LK8njbnIS0TMlrpaHBRgwaNfEOQYeGc4X4vovknwM5MDiW6RevY/pKVWMfXsJIcVyEqPKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF93YnDD0scTyVQJe1yqDvyxk012fv/hY+6cFxH0iGU=;
 b=hORTvP1mJrnPPQnPGoemIc/81sFxqLUhhuBFKIxnmQwIx8LZkBefwvfENsH6MOJrEXExBElIKsKBOqc9TbFC6kJcQrXhkAIsnGojniplwffYsQA0+ob6lKrw37ZZ59SL5Uj1iUDM93q7zBb3v6qMaFrBoNcKXwRSVtwrXAU27gc=
Received: from SN4PR0501CA0054.namprd05.prod.outlook.com
 (2603:10b6:803:41::31) by DM5PR03MB2905.namprd03.prod.outlook.com
 (2603:10b6:3:11d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Thu, 19 Dec
 2019 11:40:29 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::f0) by SN4PR0501CA0054.outlook.office365.com
 (2603:10b6:803:41::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.8 via Frontend
 Transport; Thu, 19 Dec 2019 11:40:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Thu, 19 Dec 2019 11:40:28 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBJBeR5I032147
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 03:40:27 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 06:40:26 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 06:40:26 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJBe815004004;
        Thu, 19 Dec 2019 06:40:23 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for ADM1177 driver
Date:   Thu, 19 Dec 2019 13:41:27 +0200
Message-ID: <20191219114127.21905-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219114127.21905-1-beniamin.bia@analog.com>
References: <20191219114127.21905-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(6916009)(8936002)(8676002)(316002)(246002)(70206006)(70586007)(7636002)(4744005)(426003)(107886003)(4326008)(7696005)(5660300002)(478600001)(966005)(86362001)(26005)(2906002)(36756003)(186003)(2616005)(44832011)(1076003)(54906003)(356004)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2905;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb39db5b-8ac2-4413-d669-08d784783f4d
X-MS-TrafficTypeDiagnostic: DM5PR03MB2905:
X-Microsoft-Antispam-PRVS: <DM5PR03MB290522593D3CE2B7714B50A6F0520@DM5PR03MB2905.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hdWZKbVaI4oEAh3LzRN6/H+tBDZKtftl1IAMfN2eBgm0dEcTUijNlVqFkC54CZaJ8jYYiRZugFfKojTb3Pk3pOjH6JMrjnGJESuR7tyutYEwrY13ZvOWVSwTJvvczWo3ZE96zzItV4mQOh8EgMl0qxXYOQGZwlnaMkv3CG1SLbhRClBl0eF90ccEL5++v5riheIJXfWO7dgyXmquTgaUeihADS/dB04hLH5pFuVSiGDdyL/a+BHSWQSaLX21bdO/m0dJgtW4UMm8mwSM6/N35jhgVBmYBzwlu+PG80J38nFMTkXNqmfTAfICWj5kjjNwUdtea0PSawHCCjZpVd8RMLrwOYeEy1mb42BNXvvtJDXmDgegeczW8s0Ji2r/KUyBVEP/KyUin3/sFwqbIsY9ppSjDVXN53TYQRsyW7lAL4y0HZzbB8vLHT4iAHl5vNI5+/yLIYARZzHb9/6+3cdqalsxiHTfZ4xrVgV9HLZ/LY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:40:28.8051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb39db5b-8ac2-4413-d669-08d784783f4d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2905
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-nothing changed

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ef731fc753b..bc19b624fcd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -978,6 +978,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
+ANALOG DEVICES INC ADM1177 DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux-hwmon@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/hwmon/adm1177.c
+F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.17.1

