Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC58C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6126B20409
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="FSwMrlCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLCN5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:04 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37406 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726195AbfLCN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:02 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3DhKuB026549;
        Tue, 3 Dec 2019 08:56:33 -0500
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wknx8rg30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Dec 2019 08:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCKlFFfvJBHTzFalMb5m8+BxGNCEJ7IeLgEyPcEjlxF+kcso42t93H04dQqOcyZp0tQQ0dvck8RAfZBwryjb0xgUNX+enBMlwdJ3Mib3dXiOMN7CooEF3No/bQkECjeZkzhscOqAayUJldd/cU+e6nRMr6dNIB2DMeaSItAKzufB2sOO+A3/rSTgxwNuDrCWSh1/IwtxMmWEkHrG9PflkeSwNW4LxgfjJw75187ECEzF22QTh9TNP010JeGP0I4G/vgWqouSRVP01fmEdMdleYQ/Y9LzwGgSMC0Xz78EK4B282yPvJ1eEVLIb2u/DNCA/ESE3+CawtW4sgf2pLMmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni+sBV613/ZlkuzoAipntnzGl48V3R+j++o2aqo2MqU=;
 b=Yf6OjL/t60NJiSmVG94bQqmmrYoQYSQCleHRPSMnLyTh4mj1nEeXlaw/sXD+mGwhU9xYFS2U+M/LKtDToqjlr1yXg7RREvqU+Tdl3BHx/ElwUWvZUfWUuoObzYiSu9ZWDmvNfDFthFEWONTnNFWU3kgo1ReytkgpC4RF3lihcB3/W9L3Mgoc3AZJ6d68ZosjzQI9zOadGKuFqjTN0ytKbTRgVI7oS6Z98wY0DEzeTXjktgXfF4IIaYFY4uCve6du3Nft2QlICepLQQQBxSG2SXe6iu2L1mqc7gGZ6TJblWv/WDmdOWwoCcDdDSJeTa89aNsMyUyCUxSSiV92+YYinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=suse.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni+sBV613/ZlkuzoAipntnzGl48V3R+j++o2aqo2MqU=;
 b=FSwMrlCzLAKimYEq0XgknjBQNJVyNjKzqFbCaiohbUgRbAF7AQpDtH5jfxl9mgZzWcWzyeY1dWSlQCTgLWEpT2KUX8q8cmW77VrcVIF7hU5WcuzNylfIsVNh4rymibACmwZFfLrZUzlIRwN//l3PEOinHd79fyjpIjxjuxwpUiM=
Received: from BN6PR03CA0103.namprd03.prod.outlook.com (2603:10b6:404:10::17)
 by CY1PR03MB2395.namprd03.prod.outlook.com (2a01:111:e400:c612::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Tue, 3 Dec
 2019 13:56:31 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR03CA0103.outlook.office365.com
 (2603:10b6:404:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Tue, 3 Dec 2019 13:56:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Tue, 3 Dec 2019 13:56:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xB3DuVur007919
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 3 Dec 2019 05:56:31 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 3 Dec 2019 08:56:30 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for ADM1177 driver
Date:   Tue, 3 Dec 2019 15:57:11 +0200
Message-ID: <20191203135711.13972-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203135711.13972-1-beniamin.bia@analog.com>
References: <20191203135711.13972-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(16586007)(186003)(26005)(6306002)(86362001)(50226002)(446003)(426003)(305945005)(50466002)(4326008)(70586007)(246002)(478600001)(6916009)(8936002)(36756003)(4744005)(966005)(2351001)(1076003)(2616005)(336012)(11346002)(316002)(8676002)(70206006)(5660300002)(7636002)(44832011)(54906003)(7696005)(48376002)(51416003)(2906002)(76176011)(6666004)(356004)(106002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2395;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bd7b1b3-ae14-4b53-42a6-08d777f89a0d
X-MS-TrafficTypeDiagnostic: CY1PR03MB2395:
X-Microsoft-Antispam-PRVS: <CY1PR03MB2395F2CA4854083ED1BAA003F0420@CY1PR03MB2395.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 02408926C4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhuMspzlIO3YAEd0ibBOYen1GSMEOp91IupRvZNHq7UvMzdGr/x7usn4z0ZwQvbGSR+FY96AiaU2MTCV6C/oEWQRTa4qDVx2q7CD7hW0LiYNcXI5sXwgOAhkPOuLBOVIPc751k/HEOKJVTICEuboyXe5d4zKQ6JGsMcSK2IUMNUTHMXFCQP7os4iPQ9uRUVIbzQLkEZidOpra3HKqp/jFgZht0DADslqp3QYMYaDF6ULQvJhkCGsemPlpsYkNeZfhmojQxOveeWShn/dpbSIP1Vqzmw1HqnVaqVbrFB/vkSbcnmHh/wuffv+R9fNXweEgt6ZEsRMK5MlCPHAqFch189sOFI+jUpeC9pqhxoZgvZf/cGBMrvkjSO11M9UJrLGuB/7uJPKnYr2XmQHiG3BKgNatentcbSlHYylsirNqNkpRKiVA3dw/G9wD30E+SKfJCKQjolLtBJi/wOLAc9/5ZxiXouc5xePHhXnKmJdJvM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 13:56:31.5829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd7b1b3-ae14-4b53-42a6-08d777f89a0d
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2395
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_03:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=1 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
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

