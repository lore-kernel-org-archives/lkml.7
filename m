Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA74C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D64C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6Xa/aEge";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="6Xa/aEge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfHLLYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:24:08 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:47643
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728002AbfHLLYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwvrO/kOs3+z6gFb60TK+YsV/xoyeIh4O1M6zkLUyk=;
 b=6Xa/aEgeTa2DKKy32MWLK1AlOMhW22MITqETLSpbS4mnrCsMWBEY1AptpLByozG0ZsHlYEqE12IQdo+hb5ZK58UF6KiDjEWRQsU5rARUZ+KLluDHJeqXFvdyDTkIz4Uw3Jsd1IW5gqofsHcXcYGwRO0kTh4Eu0IaDC3nNK+2rEk=
Received: from VI1PR08CA0093.eurprd08.prod.outlook.com (2603:10a6:800:d3::19)
 by AM6PR08MB4951.eurprd08.prod.outlook.com (2603:10a6:20b:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.20; Mon, 12 Aug
 2019 11:23:58 +0000
Received: from DB5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by VI1PR08CA0093.outlook.office365.com
 (2603:10a6:800:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Mon, 12 Aug 2019 11:23:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT042.mail.protection.outlook.com (10.152.21.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 12 Aug 2019 11:23:56 +0000
Received: ("Tessian outbound 220137ab7b0b:v26"); Mon, 12 Aug 2019 11:23:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 323d3c2d88360b0d
X-CR-MTA-TID: 64aa7808
Received: from ce5c56fa0c00.2 (cr-mta-lb-1.cr-mta-net [104.47.12.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EF7AE42F-3064-498F-B5E0-C089E330F6C0.1;
        Mon, 12 Aug 2019 11:23:44 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ce5c56fa0c00.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Aug 2019 11:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbnTSnQ8wJu4aM4U2tcWO2ExAwnlnEqW/aFrfAc0vCheANQpEhaASpmLuyUGV9Anvz4Mo9J/cLC84DI4sgEOeAUDu3bHiYTW9zIJxauiq6rlI30A5K2J0o1zYdDMVC6pGr9ysL3AvoeSgF9THDKdLfhnjZdSZsAzqDbz+trDKe954kgVHrNdLDBtodp0EZ7/1F+AyYKbcneXhY/gikCeLaog6a20WNIyK40LcZauLaKsugrJZngQRcoTQhT3yzCU5sXFmTW5TUEx19SHRE+kTDdIKfKTjEAI0jZiNvACDH9o/z7pd9jWcJJ4h5TEI3KFIDTN4LHlGPJpzF2tmG7EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwvrO/kOs3+z6gFb60TK+YsV/xoyeIh4O1M6zkLUyk=;
 b=ZTWlBuXz3PgWANrAMkGYk1xPPzxN05Sg+f4gPLtuPKL/g8okGdvas4j4SMoFY5IQTB6PIkVznBNFsmPaK7Ky1ddxLIv0+z8F/qnqFgFvdPiKYpRuo3ZRM2uCbJy1dn0tpGECx+gK1oLVpDHPXg0c9aeiIcL0pLqRn5Oc9hFAX9/Go0SFdKPkOsg74UwzqyiIKApdnED3yhfgYdNIPSo28CQ623EPUi9UZ6pckV8A85aPWWqta573u0iVUxndavJqRQ2tgMmKN4b91bKR+VEugdP3nuptdfDXHxQgz3Qdp3xW1CkfqgdAjf5FN5QNCKRs/KOLJ0OwbGdyOQh+lnNJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LwvrO/kOs3+z6gFb60TK+YsV/xoyeIh4O1M6zkLUyk=;
 b=6Xa/aEgeTa2DKKy32MWLK1AlOMhW22MITqETLSpbS4mnrCsMWBEY1AptpLByozG0ZsHlYEqE12IQdo+hb5ZK58UF6KiDjEWRQsU5rARUZ+KLluDHJeqXFvdyDTkIz4Uw3Jsd1IW5gqofsHcXcYGwRO0kTh4Eu0IaDC3nNK+2rEk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4848.eurprd08.prod.outlook.com (10.255.113.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 11:23:42 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 11:23:42 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Fix warning -Wunused-but-set-variable
Thread-Topic: [PATCH] drm/komeda: Fix warning -Wunused-but-set-variable
Thread-Index: AQHVUQBlSm03MEg+uUyspl7GAMnBGw==
Date:   Mon, 12 Aug 2019 11:23:41 +0000
Message-ID: <20190812112322.15990-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed0bff7-9692-407b-6f57-08d71f1790a9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4848;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4848:|AM6PR08MB4951:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB495163B50A4860F251573736B3D30@AM6PR08MB4951.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 012792EC17
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(316002)(25786009)(110136005)(52116002)(55236004)(102836004)(386003)(26005)(6506007)(66066001)(99286004)(305945005)(486006)(2616005)(2201001)(476003)(86362001)(186003)(6436002)(66446008)(6486002)(64756008)(7736002)(2501003)(5660300002)(6512007)(53936002)(66556008)(66476007)(3846002)(6116002)(66946007)(71190400001)(71200400001)(2906002)(478600001)(103116003)(256004)(1076003)(36756003)(14444005)(14454004)(50226002)(4326008)(8936002)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4848;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: WX9Q2zIozC2d8RljIUTqKcFWuDIQnCY1KZLHmTze2lYCC6OFVLP4qNQ/SxXhRaTqkFgeb1/jHHz1UmAkGflPTRzDGAA90qpHw3NTP/0JfIkm0zjKSWWNaldJetNIGoPRxJGyamopWb+OUoAWYWUnue0+JziwoQNCFmV7AIq4L/gz1IKaCe2L+1Ss3YH1e5HOvQYJ4cPz5WQD246H394+hsDMG3PAUT2ZxsJajzsc9FhQNBQSzOF/Fk/E/cB+8RfjcBcLo/YgEO4zcsRi9nOO9VZFjYZ8LdWbxUPBFXFPbNTkbflr6LQx0qlBV3gjVKu8H2vlIemQV+7SBXYpUCecXygOzy3QD69CskXdITNtQrhix4xAGjea5q/+AF12qDNZ268q4IbBMCmLmKiyBHC9kn2wNAUp5HNV6pOd9VZVg58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F3B854AC12F54886BF971DAE7373A6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4848
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(189003)(199004)(6512007)(54906003)(110136005)(316002)(356004)(2616005)(5660300002)(2486003)(23676004)(126002)(25786009)(476003)(6506007)(386003)(2501003)(14454004)(7736002)(99286004)(50226002)(6116002)(81166006)(86362001)(305945005)(8676002)(81156014)(8936002)(3846002)(36756003)(2201001)(70586007)(2906002)(486006)(70206006)(478600001)(47776003)(66066001)(6486002)(186003)(103116003)(76130400001)(14444005)(1076003)(336012)(26826003)(102836004)(436003)(63370400001)(63350400001)(22756006)(4326008)(26005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4951;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a1671436-ce1f-45ab-3650-08d71f1787b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB4951;
NoDisclaimer: True
X-Forefront-PRVS: 012792EC17
X-Microsoft-Antispam-Message-Info: E2193ZA8dtRlCTpHw9CPUS5rYDeffwY92W22yG3WIqTfGl+ZFgZJgHVOU1ERh0Jq70FLuZNMBvXTAFqACKjfN4mOXE4PRVxQU5IUxgSISZ/45woX4eZ5S8iSUYP7wgSLFlCetid81aILrGDuY0Y8YwppCVLuhDyCNDIBASq+QEj0NIDodE4+oHUcyTRPB2Zq+N/bV4tlXr5lzBnZxzpItIq/2qHEYIBUVOc/98nsEJIOyQwCiMMtHbK3/32JdKWzeItc54Q0RmeFFa8DRh8zen45IYuWeQCXyzkvHLKM8AyFrP0yOiAr7HSoXXTCotXRVlIJDGmgvo4wtNYb8EXWX+JNqUU6F1bdrMG6LHrGCXEgGRk276DibkgWL70UKXw/KW3MRHYj8K/gO1cqGhlWVGEmovYl53XO6s3gaeqNKTA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 11:23:56.7396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed0bff7-9692-407b-6f57-08d71f1790a9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4ZWQgdHdvIC1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgd2FybmluZ3M6DQoNCi9hcm0vbGlu
dXgvZGlzcGxheS9hb3NwLTQuMTQtZHJtLW5leHQvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5
L2tvbWVkYS9rb21lZGFfa21zLmM6IEluIGZ1bmN0aW9uIOKAmGtvbWVkYV9jcnRjX25vcm1hbGl6
ZV96cG9z4oCZOg0KL2FybS9saW51eC9kaXNwbGF5L2Fvc3AtNC4xNC1kcm0tbmV4dC9kcml2ZXJz
L2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9rbXMuYzoxNTA6MjY6IHdhcm5pbmc6
IHZhcmlhYmxlIOKAmGZi4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFy
aWFibGVdDQogIHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICBefg0KL2FybS9saW51eC9kaXNwbGF5L2Fvc3AtNC4xNC1kcm0tbmV4dC9kcml2ZXJz
L2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9rbXMuYzogSW4gZnVuY3Rpb24g4oCY
a29tZWRhX2ttc19jaGVja+KAmToNCi9hcm0vbGludXgvZGlzcGxheS9hb3NwLTQuMTQtZHJtLW5l
eHQvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfa21zLmM6MjA5OjI1
OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhvbGRfY3J0Y19zdOKAmSBzZXQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KICBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm9sZF9j
cnRjX3N0LCAqbmV3X2NydGNfc3Q7DQogICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn4NCg0KU2lnbmVkLW9mZi1ieTogamFtZXMgcWlhbiB3YW5nIChBcm0gVGVjaG5vbG9neSBDaGlu
YSkgPGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FybS9k
aXNwbGF5L2tvbWVkYS9rb21lZGFfa21zLmMgfCA2ICsrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEva29tZWRhX2ttcy5jDQppbmRleCBkNTBlNzVmMGIyYmQuLjFmMGUz
ZjRlOGQ3NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEv
a29tZWRhX2ttcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tv
bWVkYV9rbXMuYw0KQEAgLTE0Nyw3ICsxNDcsNiBAQCBzdGF0aWMgaW50IGtvbWVkYV9jcnRjX25v
cm1hbGl6ZV96cG9zKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCiAJc3RydWN0IGtvbWVkYV9jcnRj
X3N0YXRlICprY3J0Y19zdCA9IHRvX2tjcnRjX3N0KGNydGNfc3QpOw0KIAlzdHJ1Y3Qga29tZWRh
X3BsYW5lX3N0YXRlICprcGxhbmVfc3Q7DQogCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKnBsYW5l
X3N0Ow0KLQlzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYjsNCiAJc3RydWN0IGRybV9wbGFuZSAq
cGxhbmU7DQogCXN0cnVjdCBsaXN0X2hlYWQgem9yZGVyX2xpc3Q7DQogCWludCBvcmRlciA9IDAs
IGVycjsNCkBAIC0xNzMsNyArMTcyLDYgQEAgc3RhdGljIGludCBrb21lZGFfY3J0Y19ub3JtYWxp
emVfenBvcyhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogDQogCWxpc3RfZm9yX2VhY2hfZW50cnko
a3BsYW5lX3N0LCAmem9yZGVyX2xpc3QsIHpsaXN0X25vZGUpIHsNCiAJCXBsYW5lX3N0ID0gJmtw
bGFuZV9zdC0+YmFzZTsNCi0JCWZiID0gcGxhbmVfc3QtPmZiOw0KIAkJcGxhbmUgPSBwbGFuZV9z
dC0+cGxhbmU7DQogDQogCQlwbGFuZV9zdC0+bm9ybWFsaXplZF96cG9zID0gb3JkZXIrKzsNCkBA
IC0yMDYsNyArMjA0LDcgQEAgc3RhdGljIGludCBrb21lZGFfa21zX2NoZWNrKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsDQogCQkJICAgIHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkNCiB7
DQogCXN0cnVjdCBkcm1fY3J0YyAqY3J0YzsNCi0Jc3RydWN0IGRybV9jcnRjX3N0YXRlICpvbGRf
Y3J0Y19zdCwgKm5ld19jcnRjX3N0Ow0KKwlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm5ld19jcnRj
X3N0Ow0KIAlpbnQgaSwgZXJyOw0KIA0KIAllcnIgPSBkcm1fYXRvbWljX2hlbHBlcl9jaGVja19t
b2Rlc2V0KGRldiwgc3RhdGUpOw0KQEAgLTIxNyw3ICsyMTUsNyBAQCBzdGF0aWMgaW50IGtvbWVk
YV9rbXNfY2hlY2soc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCiAJICogc28gbmVlZCB0byBhZGQg
YWxsIGFmZmVjdGVkX3BsYW5lcyAoZXZlbiB1bmNoYW5nZWQpIHRvDQogCSAqIGRybV9hdG9taWNf
c3RhdGUuDQogCSAqLw0KLQlmb3JfZWFjaF9vbGRuZXdfY3J0Y19pbl9zdGF0ZShzdGF0ZSwgY3J0
Yywgb2xkX2NydGNfc3QsIG5ld19jcnRjX3N0LCBpKSB7DQorCWZvcl9lYWNoX25ld19jcnRjX2lu
X3N0YXRlKHN0YXRlLCBjcnRjLCBuZXdfY3J0Y19zdCwgaSkgew0KIAkJZXJyID0gZHJtX2F0b21p
Y19hZGRfYWZmZWN0ZWRfcGxhbmVzKHN0YXRlLCBjcnRjKTsNCiAJCWlmIChlcnIpDQogCQkJcmV0
dXJuIGVycjsNCi0tIA0KMi4yMC4xDQoNCg==
