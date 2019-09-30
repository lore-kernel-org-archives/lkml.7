Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E03C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C460520815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tjnp9S5B";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tjnp9S5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbfI3MXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:23:36 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:39416
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730437AbfI3MXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZoM4csAWllibZNge6xkf7ey9lPmsgCJMlJZuMLI2q0=;
 b=tjnp9S5B2DvvDJKefW2/kGsEw4w+j0+HJ5I5h/r39Pp9q9AaLjXTICP4q8caRqvuNE9IWolRS9ODvkvRTuhk7vkmxdWjqeEmnD5Mpgt8PRCNOmYiGhDTEVMA6OBU4nfXWhYBdlg2wguEAAGOPOMIhgamTv/R6JWk2R4Gqoavp4c=
Received: from VI1PR0802CA0005.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::15) by HE1PR0801MB1836.eurprd08.prod.outlook.com
 (2603:10a6:3:89::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Mon, 30 Sep
 2019 12:23:25 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR0802CA0005.outlook.office365.com
 (2603:10a6:800:aa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Mon, 30 Sep 2019 12:23:25 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 12:23:23 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 30 Sep 2019 12:23:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bb7266d763c3a4b5
X-CR-MTA-TID: 64aa7808
Received: from f5b55834488d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DEC88F23-6C67-4D03-947B-5FC63903E5BF.1;
        Mon, 30 Sep 2019 12:23:10 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f5b55834488d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 12:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo14CVLk+GyMvPAyEi4nTEq1MmKnXG8iaPm7EW7rZliRztI8EIbRwa5y9aUGGX0DWy/St/sncK9Fci3GhsA9wbiPZK7LmE8Ap7A9wo8PXXSC2e1un4uJUDgGMPT9au3G3tsEt1hRx4tb+EuRO1HUycCHm1YZbmBiUn3h60q8EFgEWfN3qR8nW4A1hNzppOmE/X6IJdiUvnfF9nFpqjApN9EALtFCXuh/xlPAr1DH/iY+sUysiOqoo3qgl0tda6XrizQnEqxPUPoGet4HWbKLZGry8Lc0g3yYia/LAND/FP8RfA7E2D6Z9WOJJsI3xGKrv90kLkD3Ut+PVFMylwvasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZoM4csAWllibZNge6xkf7ey9lPmsgCJMlJZuMLI2q0=;
 b=EEVqGQfsY4pLMS1Z/NICcN+JZ5F4KG0CdkrLvIkblKHjgxV5W9U7NPvlWlPYuPWiKfEB3mdz7xULssm3Uz2rpXZKfaKhhhaPx/DxFOo4OsojVIiyTnyd0iUherNas6HuFmQwbFFRI/Mlj1UFnhbhbgmk93yRRdBDLXlRlANl4X+P5r106PBzV7CbnPFoDLgs9k2aEjZQFHPdwfCI3EFTYbrNrcT5hgmI+n5B1vL5fbq2vhf/UPO2EX5Dn77YMrWKNwvaZ/bd+DJMSHOlMInYmbFv3hQtxtU9Z/q3DH911h54s9MQam4OdhhJ5ku+08wGphAlMt0pw67XVUQ6Nt6cRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZoM4csAWllibZNge6xkf7ey9lPmsgCJMlJZuMLI2q0=;
 b=tjnp9S5B2DvvDJKefW2/kGsEw4w+j0+HJ5I5h/r39Pp9q9AaLjXTICP4q8caRqvuNE9IWolRS9ODvkvRTuhk7vkmxdWjqeEmnD5Mpgt8PRCNOmYiGhDTEVMA6OBU4nfXWhYBdlg2wguEAAGOPOMIhgamTv/R6JWk2R4Gqoavp4c=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4238.eurprd08.prod.outlook.com (20.179.24.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 12:23:07 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 12:23:07 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Topic: [PATCH v2] drm/komeda: Fix typos in komeda_splitter_validate
Thread-Index: AQHVd4nQ0Duce8hWsE+OMvz2QKX5Dg==
Date:   Mon, 30 Sep 2019 12:23:07 +0000
Message-ID: <20190930122231.33029-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P123CA0038.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::26)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f6caf8c8-4123-44fe-9811-08d745a0fcab
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4238:|VI1PR08MB4238:|HE1PR0801MB1836:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB183620D8E14D479755F93F318F820@HE1PR0801MB1836.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(25786009)(36756003)(5640700003)(6916009)(1076003)(2351001)(6436002)(6116002)(3846002)(478600001)(6512007)(2906002)(5660300002)(4744005)(4326008)(7736002)(305945005)(6486002)(66446008)(64756008)(66946007)(66476007)(66556008)(2501003)(50226002)(8676002)(44832011)(26005)(186003)(8936002)(486006)(99286004)(54906003)(2616005)(52116002)(81156014)(81166006)(316002)(476003)(86362001)(71190400001)(71200400001)(14454004)(66066001)(102836004)(386003)(256004)(14444005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4238;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IjeiUP1KyBBn/DAcS8s7FAQy5Zn5GAvOjR2zyTbD7OMlJJeMqqh39JiJWRUgAKwboaadBVA2xkSgHPS0rnn3/hmp9daaAe19afwjJJf54BMMqGfJlHOSu+Xu2aJu99rJ2jpZ7BeJjyucR8vDEA4ZEbjOvjPfWx/yPJV2nedG6AiVS5bO4RsxCyiED/VKv0t5mG7zLoCl/Fcw+aPiQI4mHdFK/v8ksX/wravYf6IPSeIXQSTxxTm+M/nEKzR/G4fOingjaKFWJxecBDZ6xdRPkRb1TNaTqF13o6BKVwxPD4y/VNmNKWJe9KJq3BEkJe96RjcZBRJqvNQrlXE8qVsVNe8H68ToDC9WcS45tHH7TV8Wr+iFsVZLp/J67Tg5z5qkcKVbEbAbtviPxOXjvjXQZ+wbxE14V/cq8au2q5v02hw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4238
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(102836004)(47776003)(6486002)(86362001)(6512007)(25786009)(6116002)(66066001)(50226002)(5640700003)(3846002)(4744005)(2906002)(1076003)(186003)(50466002)(6862004)(4326008)(54906003)(386003)(6506007)(478600001)(26005)(8746002)(5660300002)(8936002)(8676002)(14454004)(81166006)(81156014)(99286004)(2616005)(26826003)(22756006)(23756003)(7736002)(316002)(36756003)(36906005)(63350400001)(14444005)(70586007)(336012)(2351001)(70206006)(356004)(126002)(486006)(476003)(76130400001)(2501003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1836;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c9c873ca-3468-470a-acfe-08d745a0f329
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5GahCXF6UCfOiXu+7IWL2DzQtdcGJg6AB6vAB2/nobw4/BS3TgSaJjFjOe635ZXkZV9KiZU2W9UKR5T+q9u2dm3kf5JuNxKMZMCsNP5lxkvsWOSzUoRML3ktpERtnqFf2+L9419t6Q/2cfJDPsYIu8HNRr+1B0UgEIneNQjQ5LULae0yQxwbiiHcSWP/Tjtvdh8kfzrBNjt1oh5cU5/rpyxoRfRS/OUmnPefGSt8V1A1T5oSYdY3/c7iRnQJKlMQKXX1NEbLLM7X0yn0MVcctNDBOuXWg2aHsWRQ1CNalalMWcwUqzgxhS+Missw8KAWq0pf1NIhAykFv9Rmjs7JiTTAQOVmbMSdfhLYdeEyOwVTOqRZLzsy6/v0F7M56TzJpUOtmxTF5dimCldQpRFRNWPB2fe0vjCRseuRGfoQxs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 12:23:23.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6caf8c8-4123-44fe-9811-08d745a0fcab
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix both the string and the struct member being printed.

Changes since v1:
 - Now with a bonus grammar fix, too.

Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 950235af1e79..2b624bfe1751 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *splitt=
er,
 	}
=20
 	if (!in_range(&splitter->vsize, dflow->in_h)) {
-		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
-				 dflow->in_w);
+		DRM_DEBUG_ATOMIC("split in_h: %d exceeds the acceptable range.\n",
+				 dflow->in_h);
 		return -EINVAL;
 	}
=20
--=20
2.23.0

