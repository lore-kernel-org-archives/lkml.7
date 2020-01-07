Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DCC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CC820678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="CrkbLA0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgAGK6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:58:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64552 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgAGK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:58:43 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007AwELc026248;
        Tue, 7 Jan 2020 05:58:14 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xaneaeu6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 05:58:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7TOPn1X4PoLoFyRW7vatooBJViixJIaXG+qvV0bSBIvUgHCekzKAjRShjYJQU+XDEAIftt5Kes8Y0zvWgPIwC5zMNVO+7sxx2ZkLkWjwhQ0JShpmUFeVPV2UEfxOxU4ee6VypXBTxVvd9Rz1reqMX/a5Pc9XXbsw+rOHUBlEtUHKxOJl4e9K81ta9SCL+9t37VrVOTYSeTODVEwjyBCqRUMwYR5gCWyMVmiWrqNOXr1d9dl8KhLlyK/WvxL+z6/piOfKPMqZuN2Y2avxRlUrWrXZGglGhCjfI+njiUH5aW2cWhlCmr/inZH0IbKv0RjE44uGFRU7VkKwtnydMvwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8ar9U71tuRi7WXQ5hK95iq1Hzf9qNmjZUzQE4BOjjM=;
 b=NSI0xwFTuLIbYPAC3jypAULjPtxUbWmGR6Lou1VwzB9KcputtotoInFArT3YqtiFknSUlESnAp4DPDBUvZSrvkd5oeBQijM/sETpoIYQlJGFOaHMz3fL60es+BpViqScjw2uunXJ1guaLfwz/SZp5AVBtNanK0ZhwHVoC2l0ty/obJqf0YiJzHviFZRgxwqBuGQ6LRZ91hdo/lMYz+0PNLkrC0Q5Cg489cAGMc6ZaJMAWK6LpfhXu+9wUAdHvHn3hwdPYlDi01FeMkQu1rn8mac2+wLjyklSqMW2QSWFD9crx7g6P6HNcK7TxUXvcWztNAfOENM+dqagnW0ME4gy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8ar9U71tuRi7WXQ5hK95iq1Hzf9qNmjZUzQE4BOjjM=;
 b=CrkbLA0dNuZM97NOGsAYxWiZqAALwr1H9Rmafn2N2Uq5Sl4raDzSzdJi17gcBhSdBE6k2rIs9zJ0Y52ai7X03WaEqTbOmd/SSaptu7VEzRpfjylDB3vRwUjDZJWnyg0BJ3nJ4SJPoC8mOST9QmMANGRFWn5DfqDxvk2r2SrMi28=
Received: from MWHPR03CA0019.namprd03.prod.outlook.com (2603:10b6:300:117::29)
 by CO2PR03MB2344.namprd03.prod.outlook.com (2603:10b6:100:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Tue, 7 Jan
 2020 10:58:12 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR03CA0019.outlook.office365.com
 (2603:10b6:300:117::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Tue, 7 Jan 2020 10:58:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 10:58:12 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 007Aw0Nc030987
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 02:58:00 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 05:58:10 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 05:58:10 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007Avvmo002960;
        Tue, 7 Jan 2020 05:58:07 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for ADM1177 driver
Date:   Tue, 7 Jan 2020 12:59:29 +0200
Message-ID: <20200107105929.18938-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107105929.18938-1-beniamin.bia@analog.com>
References: <20200107105929.18938-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(44832011)(54906003)(36756003)(2906002)(356004)(6666004)(246002)(86362001)(1076003)(6916009)(7636002)(316002)(26005)(186003)(7696005)(8676002)(2616005)(5660300002)(70206006)(70586007)(426003)(966005)(107886003)(4326008)(336012)(8936002)(4744005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2344;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aeff0ac-8efb-45d1-45f9-08d793607d39
X-MS-TrafficTypeDiagnostic: CO2PR03MB2344:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2344F9B0C6891EC82ABBEB53F03F0@CO2PR03MB2344.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPbzDqd/xtQpyYyOHAuYryr7y16HRTyuQsLgoy3ox/DC/Ku64J1Qgwyjd7QSOUrQWKM/JD+8Cljmv9eC2XD0kVm19WZychJV9tBc2TD0ei1BmFQhaqN0zZfpLs23kRSeuOztKM63Zi+zPoTXTGr44aLWSGI473I0tgoaqswn/+PNaC/m9Jt5OiMNC7nqboBMtcq6HqXcvkV1t08yK8CRRHPVxZnejN2asezKVpEVEYyycdgGK0nSxM2SZA5iPVCxPOUcs0vha11S/1KbvojMt6qWDAy1xc7qkdDTJOQt39lXORZrwb7q6XiCwhch1ua/BrEM/N4CAoJkiJ+2I9hZDYYYZ6n9Z4nNh00Dfn97wG3TwMmrYkoM4PLH1GWsGeE8/SyGdGJz8k+tcvJoP1Tqcz9E0s6ZKum5GiahkijLZTRreWjQr57sbSvo4qiqhz7m88Rw9a2zHNf94RlzMTqKQlzND+NjbsacG/L2B8FJfoKNguyh+yWTvdVoKWzxcHefaIBmqwTaW8r9rFiY8l68GA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 10:58:12.1872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aeff0ac-8efb-45d1-45f9-08d793607d39
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2344
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
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

