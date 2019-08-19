Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D49C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C7C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CEssCSTI";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CEssCSTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfHSICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:02:21 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:9894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfHSICU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/DME25WuBsi2PYPqZ0U2awKfR4yd6JAznpebH428no=;
 b=CEssCSTIorzkZMt1Wy6hEcqynDE5E8naCoTZKO7fCHpvFuw+CY6jyAZaQTEZWO5Xam/tbpD8yiQJK37rYDpeWIbwR3llP7m5TreVO1Qg3+OlvBdvaSwsh6hoRD90cLydlKW3dxmwF0b5bJTMkh3GiL1syUsgR5RuSk8FXmEPAH0=
Received: from AM6PR08CA0047.eurprd08.prod.outlook.com (2603:10a6:20b:c0::35)
 by AM0PR08MB4948.eurprd08.prod.outlook.com (2603:10a6:208:163::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Mon, 19 Aug
 2019 08:02:11 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM6PR08CA0047.outlook.office365.com
 (2603:10a6:20b:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Mon, 19 Aug 2019 08:02:11 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Mon, 19 Aug 2019 08:02:10 +0000
Received: ("Tessian outbound 40a263b748b4:v26"); Mon, 19 Aug 2019 08:02:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 01780a3e984ff5af
X-CR-MTA-TID: 64aa7808
Received: from 8dd404e3159b.2 (cr-mta-lb-1.cr-mta-net [104.47.1.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C1A31012-B687-4043-846C-2C30033FD0C5.1;
        Mon, 19 Aug 2019 08:02:01 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8dd404e3159b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 19 Aug 2019 08:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LufmhRifwAgbUDRMyf/6dVQYNYjD2chE1GPappTYMTsgTBexmH7vR+g+9ORiCblDpB9FSNaCRUBbq4i5vDrkHv0pjmXYBomx9uXXg+eJXWJgxTfR2Mazk20lT9j7fOZBamX1q9lh9JRRlyOOsZyMSs+Ltsxz711w7BvNt84rsX3kLliYCbsDVlVPngAqBXJAt++I5Jl0+6NBOlhbOaKZxBm+p27Ahosc2VdCH+j5vlSVagZ/DI6EkGn+wGqcY2aaicTjnCYlX/dj2ss6XyaIcQBB+l5oMbWgw9D2Aee8qlds/MulFYGzX25hvHIyMY1copB0VBJyqlZZpT3EIdNCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/DME25WuBsi2PYPqZ0U2awKfR4yd6JAznpebH428no=;
 b=FY0WKoJGmieDRkq33SuPxZKo4cYWH6OxjyxJLxfmQvkufxzLaSvjy+BU3RrTUz0V+SWWcYwDhXfWC8sEqQA4MJhndq+2AXWxpbw9IBRFss/geMMjkdZKfoy3iqFlofAgcxLeuoyPenJW8pLt5eprf+Xu0+ZqVZDuT1y//PuxpZec3++Gi54FrwVrfkErkbI+wUILjWSnSBUn2B93hNoDuO4rqLUZTPXCBK7TXrxgKdLuEfADI/aQKJjwfUqcRjBOXBSeOZ16DaOAkxikO0xNiT7QUqEsrwlZlhwB/oA7oX2uLGO8KuK8bWFBjavPU2MqNjbzU/iHcgHQUgoL4Yoirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/DME25WuBsi2PYPqZ0U2awKfR4yd6JAznpebH428no=;
 b=CEssCSTIorzkZMt1Wy6hEcqynDE5E8naCoTZKO7fCHpvFuw+CY6jyAZaQTEZWO5Xam/tbpD8yiQJK37rYDpeWIbwR3llP7m5TreVO1Qg3+OlvBdvaSwsh6hoRD90cLydlKW3dxmwF0b5bJTMkh3GiL1syUsgR5RuSk8FXmEPAH0=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4831.eurprd08.prod.outlook.com (10.255.113.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 08:01:57 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 08:01:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Fix error: not allocating enough data 1592 vs
 1584
Thread-Topic: [PATCH] drm/komeda: Fix error: not allocating enough data 1592
 vs 1584
Thread-Index: AQHVVmRfb2zs0H17zEmg1qVsSJCUdg==
Date:   Mon, 19 Aug 2019 08:01:57 +0000
Message-ID: <20190819080136.10190-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: be1da461-0ad3-42e8-cb05-08d7247b8992
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4831;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4831:|AM0PR08MB4948:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB49484BB0D959EC0CE9A7B07EB3A80@AM0PR08MB4948.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 0134AD334F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(81166006)(81156014)(26005)(6506007)(386003)(103116003)(186003)(102836004)(55236004)(2906002)(86362001)(14444005)(256004)(52116002)(6116002)(3846002)(110136005)(14454004)(2201001)(478600001)(316002)(7736002)(305945005)(8936002)(71190400001)(71200400001)(54906003)(66946007)(2501003)(99286004)(66556008)(66476007)(64756008)(1076003)(66446008)(50226002)(4326008)(6512007)(6486002)(25786009)(5660300002)(53936002)(66066001)(2616005)(476003)(6436002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4831;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: +u1Sgzi4RBdn7Zyh9VPwY+Mm+1SRaz33Pss/a82G/cROyJgokc5Bu9D2u9vekIRkAKo4/6rYtuXAJ7ztSztKjb3gJy4wEKWokUuK0pRqo6lq8DfS3mui1BVBqPtJ+JYdghoWruCjuKJ91hV2ytWIrvl7n3PwvaoNtk9+ROhRZYydfNyj+9w1dgTeN8w427tEscCH36sY++yaAjnQueWB5Lh7+ScBuQZhWuf0WqneWyf1lvEJP2sbV6KQc7rfYlZwqEBFVle5t3rWY1BCGbg/W+hM75nHOb0ta0MNPw7uuyhf8qEXA8oAN5eIKJ27B2/q+Ia+HK+tcf5kJAzXrSG7RHAPERZ6Y6I98H2zX/dIUq8I3OFz6sEepZ7D6t7M2nxARqble/cd8nyGCqifQ+YSJS4Gd23zDh9iCF0uloZqsMc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4831
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(199004)(189003)(126002)(110136005)(4326008)(14444005)(316002)(5660300002)(8936002)(22756006)(8746002)(386003)(50466002)(86362001)(54906003)(6506007)(6512007)(99286004)(186003)(6486002)(26826003)(478600001)(102836004)(76130400001)(36756003)(8676002)(14454004)(26005)(47776003)(81166006)(23756003)(63350400001)(70206006)(25786009)(50226002)(356004)(476003)(336012)(305945005)(1076003)(486006)(2201001)(2906002)(3846002)(6116002)(63370400001)(2501003)(103116003)(70586007)(7736002)(81156014)(2616005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4948;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b0c9aa84-d6e6-4c91-d537-08d7247b8163
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR08MB4948;
NoDisclaimer: True
X-Forefront-PRVS: 0134AD334F
X-Microsoft-Antispam-Message-Info: ObpWAG1z3PUmWANG4ze0riHV4PSs8IRqh7gOkMWyZ22zyCvXxKvJchFC4q9jKPHfXH2xD7wPcFjCcC0+VIm0WVrB1NkJHdkGR+ukgb9l0a8Xgwb4WvZpVdULyrdV2y8BmYLLVn5bZi+FEn561Hwnm/x2kUSRosQUfi9LtSPPrbPN2FfapoOdwmSUTsFV/Kpr0H7hPhr5nUaDbQTfjwBFlnX0ViiPHCYt6Xnh5NiKXjhwOcCIedD8oPf1/QNeP8KmmjH7S6UywTPEMVMCw2mOMKhwhdMfG4Prcj1KtP+fgJravlJYYgMHd3Pj+DnUEm5g6428mXzVfOBy/gnIyPm//mojJSeYD8NYYifEoQYN3Tr2QKc/sivcA7PbD/mGH46jGgAtYlU9kizjVtTkWAKL/qqNeFnrtmUPdI4s0BYxDN0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2019 08:02:10.3340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1da461-0ad3-42e8-cb05-08d7247b8992
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 5d51f6c0da1b: "drm/komeda: Add writeback support" from May
23, 2019, leads to the following static checker warning:

        drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c:151 komeda=
_wb_connector_add()
        error: not allocating enough data 1592 vs 1584

This is a typo which misuse "wb_conn" but which should be "kwb_conn" to
allocate the memory.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 617e1f7b8472..2851cac94d86 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -148,7 +148,7 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
 	if (!kcrtc->master->wb_layer)
 		return 0;
=20
-	kwb_conn =3D kzalloc(sizeof(*wb_conn), GFP_KERNEL);
+	kwb_conn =3D kzalloc(sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
=20
--=20
2.20.1

