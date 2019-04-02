Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EEDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3929220883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="qcuBIgvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfDBLTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:19:00 -0400
Received: from mail-eopbgr770084.outbound.protection.outlook.com ([40.107.77.84]:31392
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfDBLS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRdywoguATeSpvo7V/p5Azh5giD+ZO2EBqTZiM8OyDo=;
 b=qcuBIgvymWHtYPPD01GZdl0VP27EFTBdqFIAjMndyG+8BF1qEzGXuSc83KJ7wHCT+ljfCsuzX9hZCMV6DvPyrc8Om0WdYK5cX27XRcK67u90IDxi35j5GrGeQxog86D0ZNWt4GHHKaTs3bQswig1s/iIXJKFt69KZkU1Z9j7/SI=
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by SN2PR03MB2270.namprd03.prod.outlook.com (2603:10b6:804:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16; Tue, 2 Apr
 2019 11:18:56 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.17 via Frontend
 Transport; Tue, 2 Apr 2019 11:18:56 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 11:18:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x32BIsNl026635
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Apr 2019 04:18:54 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 2 Apr 2019 07:18:54 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 3/3] dt-bindings: iio: adc: Add AD7616 ADC documentation
Date:   Tue, 2 Apr 2019 16:18:41 +0300
Message-ID: <20190402131841.8430-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402131841.8430-1-beniamin.bia@analog.com>
References: <20190402131841.8430-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(189003)(199004)(72206003)(5660300002)(4326008)(36756003)(106466001)(4744005)(51416003)(50226002)(7696005)(54906003)(76176011)(44832011)(53416004)(106002)(50466002)(478600001)(126002)(107886003)(6916009)(8936002)(86362001)(2351001)(2906002)(186003)(7636002)(1076003)(2616005)(246002)(446003)(486006)(77096007)(47776003)(305945005)(16586007)(336012)(7416002)(6666004)(48376002)(316002)(476003)(26005)(8676002)(11346002)(426003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2270;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc432e2-a97f-4720-1b1c-08d6b75cfec2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN2PR03MB2270;
X-MS-TrafficTypeDiagnostic: SN2PR03MB2270:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2270FA4DFB319003C2909BCBF0560@SN2PR03MB2270.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2BRpxF8QXX0c3xVNBOEcQstYolmx0c9UBCdU4dLakKJx1f8NsrZJS/vVZJM95UvF46mRYyU63CRtrVIlcnFqq3sOqIT164khFtLSPemP48py8XqI37vfHNc7f5jNNgKQXQ4DBLDLFOJwwlzDHPgGmOIE9KCAlfKsMt8fUHPXs57paVNBG+xZDYessRAX8ciWLB2+Ou/keMD5HYa+wfAzS6PdcQDt6r+V2sgP75KrmWUH/JAsagZRxJ0Ec/WYRHnXukS6iimh2ffzJVed7y48TB+b+73MEAPKpg6R84BOsEaD4PsAa/PnEhx463f7O9OYZu+ZLMjJiIlmNS2RtPhnQfcmpSviXumSZ99ahgZuSUBM/A1czPz3Su0xfQM4cuMbMZR1iH3R9/ywNffg52CTXjQ9uSaMB/ghCQ2DPUgBxjk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 11:18:55.3507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efc432e2-a97f-4720-1b1c-08d6b75cfec2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7616 Analog to Digital Converter.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
index d7b6241ca881..d8652460198e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -7,6 +7,7 @@ Required properties for the AD7606:
 	* "adi,ad7606-8"
 	* "adi,ad7606-6"
 	* "adi,ad7606-4"
+	* "adi,ad7616"
 - reg: SPI chip select number for the device
 - spi-max-frequency: Max SPI frequency to use
 	see: Documentation/devicetree/bindings/spi/spi-bus.txt
-- 
2.17.1

