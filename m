Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F2C761A8
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89942084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ajaTNfaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfG0IeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:34:08 -0400
Received: from mail-eopbgr780042.outbound.protection.outlook.com ([40.107.78.42]:49550
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728633AbfG0IeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:34:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0yDUVZ0J+RtNCwgBAj8EziPm5JpUg+CnctAvRV+LzhGDMf5S9iu+LFyIWrTMhngrJ7musYygwzDSXBAEPdTlv7wuL1Sm2t1SbYo80OPdaLBSca6B4zx/xNKofoRg+wosRlOqfk8tlT2ZRm9TIfFhe+Zcqa7wQia4hY2IjGhW6dlUWLbsBo/9bPQ2cx8i3j4zYPSgTcUdo9aRc0bXAph71biOswDsKaQJWRybckGVJqTW4jZpWxhZ8hCSw658WFg0TAeVDzjGqXhYjGZDlbRTuFKdjrw2S7fD3OojlivwXg1Ixs0mbUYA4c57Qg7JZAwmX4/IqqkBEwuqCJeKMxOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwbDJkzilP7DmymYO/JI/NbOe5Mi309nAY5nqBncFYA=;
 b=Cs9FfY2tYH8TdDJLIKZuzcS0PopsD/lcZaLiMCpHqafr5Lv0sULggdf9vhvTk37ASdv8ZeHxyeokm01fcKc0gF9wrewS0P3NelgBGVkuaiCBs3/Cqi1pTyTku4Tkz7wSawxrkh0Ic6ohHkPhT+zYq7Eyuds8ItL81rpzLIK8NgmqkPKHReB3c5lbRDVNzJ2E4RB8o3KN1CzV2aIAd64QqJZ5j9rQWT0SI/8uXodUKsV00CDU6WJtItycA1e8zOcydZ9RsM+TYAST/wXX07wgmX0S4ExgDlcqNM+fW6FQiGaDwDzA2mqxq5bX3Lsx12P7R2t9YIceooEQm0hF8iah+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwbDJkzilP7DmymYO/JI/NbOe5Mi309nAY5nqBncFYA=;
 b=ajaTNfaRn8toiZyL0CTv5+U8GiW3Ioeb/OyuHaD8mvmOjcCcH2SIu8Vy+Y5QmpTdAcq+ltBPEyTzA2PAjJ0pyTsS2i02FSuSRn2GOtCl5FVnGbap9tdDScC4TW+ykpjCK6lpmqOTA+/B7Oby0bTKVXCAyYG0UHuP729W/gu5G/Y=
Received: from DM6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:5:177::24)
 by BY5PR02MB6740.namprd02.prod.outlook.com (2603:10b6:a03:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Sat, 27 Jul
 2019 08:34:05 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM6PR02CA0047.outlook.office365.com
 (2603:10b6:5:177::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Sat, 27 Jul 2019 08:34:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2115.10 via Frontend Transport; Sat, 27 Jul 2019 08:34:04 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Jul 2019 09:34:00 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Jul 2019 09:33:59 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=40508 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hrI9Q-00027X-09; Sat, 27 Jul 2019 09:34:00 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V9 7/8] Docs: misc: xilinx_sdfec: Add documentation
Date:   Sat, 27 Jul 2019 09:33:57 +0100
Message-ID: <1564216438-322406-8-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564216438-322406-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1564216438-322406-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(2201001)(336012)(44832011)(446003)(2616005)(476003)(126002)(956004)(426003)(486006)(11346002)(50226002)(9786002)(51416003)(28376004)(7696005)(76176011)(60926002)(71366001)(110136005)(16586007)(54906003)(36906005)(316002)(106002)(26005)(186003)(47776003)(4326008)(107886003)(2906002)(305945005)(36756003)(7636002)(50466002)(48376002)(76130400001)(70586007)(478600001)(5660300002)(26826003)(4744005)(246002)(8676002)(356004)(70206006)(6666004)(8936002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6740;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b8f0595-fa74-48a7-4a6d-08d7126d2f47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY5PR02MB6740;
X-MS-TrafficTypeDiagnostic: BY5PR02MB6740:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6740961BAD20C819A5FC16B8CBC30@BY5PR02MB6740.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 01110342A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OrXA50F1SiHfk2zfEAurS1UhT85Yin0lhc9GZ/rt/7Nd0kfZA/6vcvi6hZuJvcYQBQ23YvbrpxeQD0LnTgEJ6mK07uHjCFx7vWMzbNOeOemXjUkYpQtcXU1BhONnGDecJAFtdt0vu+7sw/vE2U1M1xgsQLJ1A3wUvcbGhXCqAov64JioEA8T39856Kmvz6G3imSSEX3gWqWhm0ASU0HVBHIVTz3DkCYGZUZlfn+YyG+P5D3ATH0XvbU9boY/mtI6fbK++ZYNIMyWbg0IBraE1ZvM4zGEUngo0KoMtDmE+FYiJes/c3HAIAy0FxdAfBANpSTqAnM0zw/0rh3+dAJVlk0MavJYUk4xMHFyfnbA8LdFPWFr4145LoeSYncPRO028Wqo+Kt2+5x2o6wkWZZDFOHh7RaFtiVBc97u/bJbWXk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2019 08:34:04.8519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8f0595-fa74-48a7-4a6d-08d7126d2f47
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD-FEC driver documentation.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 Documentation/misc-devices/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index a57f92d..f11c5da 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -20,3 +20,4 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
+   xilinx_sdfec
-- 
2.7.4

