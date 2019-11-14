Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AFD206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7edExcp6";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7edExcp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNHTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:19:12 -0500
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:28387
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfKNHTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RxvFPIqym1fYqdb2W+49aDyvdLXHjumUE6tG4adzmQ=;
 b=7edExcp6tjFL7CYSrYDW+CZY6DQWnjPl8AjkKwE3vnXYoe0yYloJ6gr4p+o5fFzNL1WezVI+hfdLm67LJNh3TUFCPnL/pXYfs8/31yVXXDvVl3peWOMrFwMGAmcX01A0DTjIEpzKitmJs3h3cfN78G8q7Ime5jgxeIvYan0sabo=
Received: from VI1PR0802CA0026.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::12) by AM6PR08MB3381.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 07:19:05 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR0802CA0026.outlook.office365.com
 (2603:10a6:800:a9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 07:19:05 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 07:19:04 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Thu, 14 Nov 2019 07:19:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e19737817c3d43c2
X-CR-MTA-TID: 64aa7808
Received: from d2bf47018d18.3 (cr-mta-lb-1.cr-mta-net [104.47.2.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AE1563B8-C876-447E-9ACB-DCDC5C74013A.1;
        Thu, 14 Nov 2019 07:18:58 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d2bf47018d18.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 07:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G90Jk5rCQziaYCEoc88IpjjMpjEKMgwHxX7dAdOod+o82mugfKwZv68bLma77x9oM5vfHzpTp51az0HNUPVixbRZaLegLPxnjXINfLBz8p062oe7U5o6+cmi7pBI7ES5e0IepW1pSFoyPVXSKVyfilbpqqWE5Sm1Ee1lzhWFrilw0EP5OTyrjgGzvQsxhZGd/lZPKNB6mjbeRT0IQs9Lod4Lv1SX3wC9P2Trf5TBnHsT7veqFDDpkQ+2dC4CXuuZsPuyMfq0nPz4YC0YCtwddC0GFFMjCwmRws6ULhoQwUpFGv23ZIGtVnpV+eavZugGQTg7phIw7k+F9C/6YV8EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RxvFPIqym1fYqdb2W+49aDyvdLXHjumUE6tG4adzmQ=;
 b=PWh7TKtS+4BrQ674Dyg3sjjvHLfY+HODfsi7Xdhj1x6dMYIT6luAsnz+rAiHdPIyik9rLCPvIkB5lZ8mecODrAyi2UMtTGS64Z5mA1sk6UhACujkdg+/WfV3Tl/4QKVSXz08AOjGyB+nIWRv3G6kACynYMdgN4eYhw/Jj46TW6ZOLLPv6pjgv8fGpnO/VSQK9r4Tus8wi3jWkTn/zwq47uzN077jEq8BpvuEJXR0yQtOe5ehH1acEIwojWhDZGLeCV+zDT/FYrkIeVlKFBCBIBcKM2EQkvV/Iyod0DZ4J/psFntJ2k1OecZLe781prBXUOF7IwMdb/wN38wKMBWADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RxvFPIqym1fYqdb2W+49aDyvdLXHjumUE6tG4adzmQ=;
 b=7edExcp6tjFL7CYSrYDW+CZY6DQWnjPl8AjkKwE3vnXYoe0yYloJ6gr4p+o5fFzNL1WezVI+hfdLm67LJNh3TUFCPnL/pXYfs8/31yVXXDvVl3peWOMrFwMGAmcX01A0DTjIEpzKitmJs3h3cfN78G8q7Ime5jgxeIvYan0sabo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5056.eurprd08.prod.outlook.com (10.255.159.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 07:18:57 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 07:18:57 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "lowryli@arm.com" <lowryli@arm.com>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Index: AQHVmrvHSAACMS3tME+zvG9PBSu3eQ==
Date:   Thu, 14 Nov 2019 07:18:56 +0000
Message-ID: <20191114071839.29120-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a92ba83-37cf-43c7-3531-08d768d2ee80
X-MS-TrafficTypeDiagnostic: VE1PR08MB5056:|VE1PR08MB5056:|AM6PR08MB3381:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3381DD44EB2F5AABCB931D8DB3710@AM6PR08MB3381.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1728;OLM:1728;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(64756008)(305945005)(66066001)(1076003)(14454004)(36756003)(71200400001)(71190400001)(7736002)(99286004)(4326008)(486006)(81156014)(81166006)(25786009)(86362001)(476003)(50226002)(2616005)(8936002)(66476007)(52116002)(186003)(6486002)(55236004)(6506007)(386003)(6436002)(6512007)(478600001)(102836004)(26005)(316002)(5660300002)(54906003)(110136005)(256004)(14444005)(66556008)(3846002)(6116002)(103116003)(66446008)(6636002)(66946007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5056;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mHDl+taNtf6rJc3ENb+jkHsdOSs89++QaoC1opiywJGuW0c1YaJQH97zInZ8mjvHDG/mVSGMuJtPPRcMn7PG2H2JF5mEaCZXI3H6ATQS9gLj9Jdy+VHSGSkp6a2OEBG0BSR2NBUlplGC7tNUvJa5a0QxtaG5znKATB7CPL2ifVY42V2PT5ra9KLSDC0J58D/h5nqfvZVS4r7jmrbFZ6wtjOAPFMUkv98pYWDt4jwbipIVHrW1/Msh9BHR9xHVTXF/awnz8ybAll1zEOI67LzB2nwOaFMs2RfyYve/SoPZxxVwqbCkfIR/bqEEhzL4XLQwpO8tst/jNWsbHsKoJ15+kFsaZCeXX3Reg5ZeJYp73WqyJBw1bYvLEdDm5t29e31jEw1x0PW/DT1xIROblq6Oo5sK60XtOH2tMZYGe3uJdxdMvnv8ozbL1E9S3lBtawe
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CC6763886CF6545AB964D2FAC7F7354@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5056
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(1110001)(339900001)(189003)(199004)(2616005)(6116002)(3846002)(476003)(436003)(14454004)(22756006)(8936002)(186003)(81156014)(81166006)(356004)(50226002)(26005)(6486002)(336012)(102836004)(486006)(4326008)(36756003)(105606002)(103116003)(126002)(54906003)(110136005)(316002)(99286004)(66066001)(50466002)(2906002)(47776003)(76130400001)(6636002)(26826003)(14444005)(1076003)(5660300002)(25786009)(2486003)(23676004)(6506007)(386003)(70206006)(70586007)(478600001)(86362001)(305945005)(7736002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3381;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c2138615-3eb3-4c27-ec71-08d768d2e968
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCK8pr8sCm5VYMYHf2eXcx309JTWpXYkAfKa8Uuh3LIApO3VHKDNJ1OTPET3ajVqtxehYewZHgdAVZn/eDXE/Y4NPcq47xwpGCs+QtrHvfDVyLqJyneGqoV3vJ8RIX0xHhnlQotUxOzfASd9Xpun4x/gYrQXZKmTiCOsruMHxUMeZCqsNBLTtJbSnmn88mPpecjPPgzjcJ6adZxI7rfdooJOzUSZvvqnuxN73ba68kt5Q+i4oGnZ9shfBDgyJi+ngatpepEIqJOwYjiyApExVnyT2MuTNy9wcCskyU3c6VXBjUwfUTPo2a8DGczfBidDah6Yyiu0wVDoa6j7OvjKrfXE/XHT0ayho6W+jJQDq1aKdYrQHDkXChPIbPRYVv3VVWSe+LvwpwrGbx1muOaWG9q1jKtHFl2qsqx8i2oOEsokV/VFIlWPwCwhMpvUpmf8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 07:19:04.8904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a92ba83-37cf-43c7-3531-08d768d2ee80
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a29tZWRhL2tvbWVkYV9waXBlbGluZS5jOiBJbiBmdW5jdGlvbiDigJhrb21lZGFfY29tcG9uZW50
X2FkZOKAmToNCmtvbWVkYS9rb21lZGFfcGlwZWxpbmUuYzoyMTM6Mzogd2FybmluZzogZnVuY3Rp
b24g4oCYa29tZWRhX2NvbXBvbmVudF9hZGTigJkgbWlnaHQgYmUgYSBjYW5kaWRhdGUgZm9yIOKA
mGdudV9wcmludGbigJkgZm9ybWF0IGF0dHJpYnV0ZSBbLVdzdWdnZXN0LWF0dHJpYnV0ZT1mb3Jt
YXRdDQogICB2c25wcmludGYoYy0+bmFtZSwgc2l6ZW9mKGMtPm5hbWUpLCBuYW1lX2ZtdCwgYXJn
cyk7DQogICBefn5+fn5+fn4NCg0Ka29tZWRhL2tvbWVkYV9ldmVudC5jOiBJbiBmdW5jdGlvbiDi
gJhrb21lZGFfc3ByaW50ZuKAmToNCmtvbWVkYS9rb21lZGFfZXZlbnQuYzozMToyOiB3YXJuaW5n
OiBmdW5jdGlvbiDigJhrb21lZGFfc3ByaW50ZuKAmSBtaWdodCBiZSBhIGNhbmRpZGF0ZSBmb3Ig
4oCYZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRlIFstV3N1Z2dlc3QtYXR0cmlidXRlPWZv
cm1hdF0NCiAgbnVtID0gdnNucHJpbnRmKHN0ci0+c3RyICsgc3RyLT5sZW4sIGZyZWVfc3osIGZt
dCwgYXJncyk7DQoNClNpZ25lZC1vZmYtYnk6IGphbWVzIHFpYW4gd2FuZyAoQXJtIFRlY2hub2xv
Z3kgQ2hpbmEpIDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2ZW50LmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEva29tZWRhX2V2ZW50LmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkv
a29tZWRhL2tvbWVkYV9ldmVudC5jDQppbmRleCBiZjI2OTY4M2Y4MTEuLjk3N2MzOGQ1MTZkYSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2
ZW50LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2
ZW50LmMNCkBAIC0xNyw2ICsxNyw3IEBAIHN0cnVjdCBrb21lZGFfc3RyIHsNCiANCiAvKiByZXR1
cm4gMCBvbiBzdWNjZXNzLCAgPCAwIG9uIG5vIHNwYWNlLg0KICAqLw0KK19fcHJpbnRmKDIsIDMp
DQogc3RhdGljIGludCBrb21lZGFfc3ByaW50ZihzdHJ1Y3Qga29tZWRhX3N0ciAqc3RyLCBjb25z
dCBjaGFyICpmbXQsIC4uLikNCiB7DQogCXZhX2xpc3QgYXJnczsNCi0tIA0KMi4yMC4xDQoNCg==
