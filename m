Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D53C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A81206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i8DPB1GR";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i8DPB1GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfKNKEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:04:50 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:12433
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbfKNKEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lyZ44VspJlaQ60fUka0Ht3AmSiCGd+bgytxjiodpDs=;
 b=i8DPB1GRkp0z9Dqvvv9kGk14KKhGwZ0ySUcc2ofqxY808naljLDoPJRdLL9nEq+mAf5YFn+vaT4dSDh0pP+6MhSoZWjgyrRcu5WUt17KzlPE8+wcGv/H4TWhCrhWp6YXc2prNeMTK10gAqO77JeI8cfAgdKaep73N/kzt5FsDxw=
Received: from VI1PR08CA0211.eurprd08.prod.outlook.com (2603:10a6:802:15::20)
 by AM6PR08MB4039.eurprd08.prod.outlook.com (2603:10a6:20b:a1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Thu, 14 Nov
 2019 10:04:45 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0211.outlook.office365.com
 (2603:10a6:802:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.26 via Frontend
 Transport; Thu, 14 Nov 2019 10:04:45 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 10:04:45 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Thu, 14 Nov 2019 10:04:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a1b27f95d2c3e9e
X-CR-MTA-TID: 64aa7808
Received: from 308c7ddb3458.2 (cr-mta-lb-1.cr-mta-net [104.47.8.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DEEFED6F-19DC-4180-8954-B7B4DB82286B.1;
        Thu, 14 Nov 2019 10:04:39 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 308c7ddb3458.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 10:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zzpo5Qr6QMM+4KdTRI3Vny/xPyflhZAtyxRL5l377zP1eCqn6nqOnTiUMh8j/8tfVgxyqEwgWuptF1rPEndp26nOjgFaWs+RcUhdVgD6ENASs65h712ALdovxI7SGSTrXabQgZ3tzwVB0mUu/F3eXZ80S0CgnkEMTZY3Y/XK2FQFv7Eih4/QZSfo5owdfoyQWBvNGPMKUc8xMEmANZZtFt2F6sZGJiagxjDJ1c79OEGdhW6EkEWWqBN952oSNpZcK7uN0FqEG+yTI18JQhSBGHVe0pxB9BE91LS07kmTeEtWa9QxzU6IQ2VzCAkmFT6ezcl4RYXwTEazz5bnceR0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lyZ44VspJlaQ60fUka0Ht3AmSiCGd+bgytxjiodpDs=;
 b=m9huMDB+ROMOYvwSS0wJ6oBcaQnuFRe/8K+Xt4t6aUmc8rNVAIT3wI3YEC2qVJHBJPZuNfrp1dDiE4FHjy9iEBSD9IvK+MLskJRWBYTLtWMffcdTuGGjzNHkMZwTJzZkP4z24zm92sfNUYq50zkNPaLunO3+WzxykkDhgN0Wh3LSs/43mjMYdJ+viE+CjoetRgoqyct2tc1ZeCTj7GpSM95tiHoLYNjAGCAaLjwm/HMpFdkV1PoOBhatgqFp+nq/uCfqa/Pc0DMZZLm/u4p8vhAyZBJLdgCuL1/KK1GuM80o/03ys1SWfg+n054Pqf4FVBvkdFNijaujx4cTOJ4wEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lyZ44VspJlaQ60fUka0Ht3AmSiCGd+bgytxjiodpDs=;
 b=i8DPB1GRkp0z9Dqvvv9kGk14KKhGwZ0ySUcc2ofqxY808naljLDoPJRdLL9nEq+mAf5YFn+vaT4dSDh0pP+6MhSoZWjgyrRcu5WUt17KzlPE8+wcGv/H4TWhCrhWp6YXc2prNeMTK10gAqO77JeI8cfAgdKaep73N/kzt5FsDxw=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5245.eurprd08.prod.outlook.com (20.179.30.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 10:04:38 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 10:04:38 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Index: AQHVmtLsTLvLo3Z9SUGqMMXb28Jv4Q==
Date:   Thu, 14 Nov 2019 10:04:37 +0000
Message-ID: <20191114100421.30510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8be1562-f4c1-4279-1fec-08d768ea135a
X-MS-TrafficTypeDiagnostic: VE1PR08MB5245:|VE1PR08MB5245:|AM6PR08MB4039:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4039087A2B4C04349ABC79E8B3710@AM6PR08MB4039.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;OLM:3276;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(71200400001)(478600001)(6486002)(14454004)(305945005)(476003)(486006)(2616005)(86362001)(7736002)(54906003)(256004)(316002)(110136005)(103116003)(4326008)(36756003)(6512007)(6436002)(50226002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(2906002)(71190400001)(14444005)(81166006)(25786009)(4744005)(81156014)(5660300002)(386003)(6636002)(8936002)(55236004)(26005)(99286004)(52116002)(1076003)(186003)(66066001)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5245;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: P+JqnhGtf9bOVbWaubrIs0ZPphlnPZadO6UAra+6MHDiG5N+HZHwnZ+/FtmRxTVEDc1Au4pMUppRhU8KZFwBexqTh29oPzi5bIwC23O4yuO+e4Ojk/w/+IdhojKCqL3DTfkKwTsaP8VdafV3b84OYmCCf5F6yzyiLVmT/RNmyCSnp3IqNv0yp3G9ONB2n9MdUBIk+stHLD69t4XeqANssTmzHCsRhmVnkm8PtEdtfdahZIythkKpNBP97B2Iyj8fZd4ZQbOW68B5gpIlMORFnlNuPy7qJAkROyRjAGaiyXUwHkdradYCOmdH6XhrBHHbkk55Ypgk9TO12Yb7Nr34YwGhhRL/VQ/7oxl2zYaym02xqRgfHHrFhV/usIFubDRLeHJg5ljUf3r2YPR6mJKeHz6GiUeZzeOiUlUM7JIlcW7FY2W1CjOWa4DJK+5If9ZY
Content-Type: text/plain; charset="utf-8"
Content-ID: <0069856B13181A42882D7609F4000A00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5245
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(1110001)(339900001)(199004)(189003)(386003)(6506007)(6116002)(3846002)(476003)(186003)(436003)(305945005)(2616005)(7736002)(4744005)(2906002)(316002)(6512007)(6636002)(36906005)(110136005)(5660300002)(1076003)(14444005)(102836004)(23676004)(26005)(6486002)(486006)(336012)(4326008)(126002)(76130400001)(2486003)(81166006)(47776003)(50226002)(36756003)(66066001)(81156014)(86362001)(50466002)(25786009)(8936002)(54906003)(14454004)(103116003)(70206006)(70586007)(26826003)(356004)(99286004)(478600001)(22756006)(105606002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4039;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5f3c8d88-0a80-4858-3845-08d768ea0ebc
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP5J2c/pCBFJUg6ZOL/FPY6KTF+Pyk6is3vDfwEj+ElXk7Nyz5OuLhfRveHjZjlhgk4H5TZame24keIdyZzTwprb03Xl095+XsyTrUfIWLsnwuSVS2K2JdxNVtBo8UAI2niWgH2AGUN2BEiqV0TKZvtYBgwLMLW7NvwPEZCeMeG/S/yv5kVQ8rKyn5a9R6ARy9lFQ+PrX0tsAaeMLmkh76qQnF4VfhKiSwJLXvhBBGiQMJOQ+BosUP5s5iO75z5YY2x6aAT3/tVQR9FgOxqn1ytonrI1sQzb/uv/LuDHKiZWcVJ44hLLzjln9HiIez+jixN8QyJn3bDMv79+jUP5sEz6Naba7NnPWJxehccY51U9eebvzlefu1+k1t7ii6dECNBNQIsyG+mXLQNPLGewktLVBD62WqumsIM6yfEgM3ZHvLgUYx3EGzePA1rv6WlP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 10:04:45.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8be1562-f4c1-4279-1fec-08d768ea135a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a29tZWRhL2tvbWVkYV9ldmVudC5jOiBJbiBmdW5jdGlvbiDigJhrb21lZGFfc3ByaW50ZuKAmToN
CmtvbWVkYS9rb21lZGFfZXZlbnQuYzozMToyOiB3YXJuaW5nOiBmdW5jdGlvbiDigJhrb21lZGFf
c3ByaW50ZuKAmSBtaWdodCBiZSBhIGNhbmRpZGF0ZSBmb3Ig4oCYZ251X3ByaW50ZuKAmSBmb3Jt
YXQgYXR0cmlidXRlIFstV3N1Z2dlc3QtYXR0cmlidXRlPWZvcm1hdF0NCiAgbnVtID0gdnNucHJp
bnRmKHN0ci0+c3RyICsgc3RyLT5sZW4sIGZyZWVfc3osIGZtdCwgYXJncyk7DQoNCnYyOiBVcGRh
dGUgdGhlIGNvbW1lbnQgbXNnLg0KDQpTaWduZWQtb2ZmLWJ5OiBqYW1lcyBxaWFuIHdhbmcgKEFy
bSBUZWNobm9sb2d5IENoaW5hKSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+DQotLS0NCiBkcml2
ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5jIHwgMSArDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5jIGIvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZXZlbnQuYw0KaW5kZXggYmYyNjk2ODNmODExLi45Nzdj
MzhkNTE2ZGEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRh
L2tvbWVkYV9ldmVudC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRh
L2tvbWVkYV9ldmVudC5jDQpAQCAtMTcsNiArMTcsNyBAQCBzdHJ1Y3Qga29tZWRhX3N0ciB7DQog
DQogLyogcmV0dXJuIDAgb24gc3VjY2VzcywgIDwgMCBvbiBubyBzcGFjZS4NCiAgKi8NCitfX3By
aW50ZigyLCAzKQ0KIHN0YXRpYyBpbnQga29tZWRhX3NwcmludGYoc3RydWN0IGtvbWVkYV9zdHIg
KnN0ciwgY29uc3QgY2hhciAqZm10LCAuLi4pDQogew0KIAl2YV9saXN0IGFyZ3M7DQotLSANCjIu
MjAuMQ0KDQo=
