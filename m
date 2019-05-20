Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C371C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593FF216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="ikQNp1Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392520AbfETQjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:39:04 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:28806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391435AbfETQjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og0PnaNza6onIJhiXro6yK7zsL9PED1HTB/PMaWfCFk=;
 b=ikQNp1Fj0CsLAAUxS/aKJmSsLWqc/BuKAG38dEDISXQc/8ZdpFeXb2i97SbasS262WPGyYbnQe8TBt9DYECSEWljqQcc9EY0s5cqiXEaIXPQxdprspPo2MHLxyZFwMscOr3q8hAozhjq5BaJ3EIDWSt8kDZ+QQjic0Pp8kX4dM4=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 16:39:00 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 16:39:00 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] staging: vt6656: clean-up error path on init
Thread-Topic: [PATCH 0/7] staging: vt6656: clean-up error path on init
Thread-Index: AQHVDyqGUbtNfkS200GqmtMAdXIo5Q==
Date:   Mon, 20 May 2019 16:39:00 +0000
Message-ID: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::14) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4453e1a5-9621-41b2-aaa5-08d6dd41a925
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3662;
x-ms-traffictypediagnostic: VI1PR08MB3662:
x-microsoft-antispam-prvs: <VI1PR08MB36623642FBB39527EF5B173AB3060@VI1PR08MB3662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(1730700003)(2501003)(14454004)(73956011)(486006)(8936002)(44832011)(71190400001)(71200400001)(50226002)(81156014)(81166006)(4326008)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(53936002)(316002)(476003)(2616005)(305945005)(6436002)(66066001)(508600001)(6486002)(7736002)(5640700003)(68736007)(25786009)(186003)(6512007)(14444005)(86362001)(256004)(6116002)(3846002)(1076003)(5660300002)(26005)(36756003)(99286004)(6916009)(6506007)(386003)(52116002)(102836004)(2351001)(54906003)(74482002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3662;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NN+hMD3SiF4gYP0avxWbs7azNF0sH9XX6GrPHjAejSnFt5dhtTTabq87o7qyu8a7lylbyccP48TI0sTJeP86Li+AErE2qKMfRRG/Ui7YeLD7+3nv5PqKTxt1ZrWcWLqQaKVnCnXmpYVEZpT6C4KYpSj/UHYEvcpYlB7AeY+0TBw5K+WUEwlfhi3F5pyB+kO5LWBmWqUcExM6mWrJAaKlnQCkJ7iUbplbS4JiKZRL49CPASbDkyi0LiWmTcjgfvbFxR0N8vm2XIKvu+TaoRUQqQRtVHXyc7YhmXjxlIsT3AU4MjeltW8JIcpKff1/ncjm/mLz2vqdgdF3hlAm2AJZXFj23Ar0GPQziUe2kDgqTonmIDpFH5xZj6Mhhxd41AjfxNcHalpIgihg+2/NQJYsiy2hvO5NstLp0u9VIGPSbnY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4453e1a5-9621-41b2-aaa5-08d6dd41a925
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 16:39:00.2703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhaW1zIHRvIGNsZWFudXAgdnQ2NjU2IGRyaXZlcidzIGVycm9yIHBhdGgg
ZHVyaW5nIHRoZQ0KaW5pdGlhbGl6YXRpb24gcHJvY2Vzcy4NCg0KRHVyaW5nIGEgY2FsbCB0byB2
bnRfc3RhcnQoKSwgbm9uZSBvZiB0aGUgZnVuY3Rpb25zIGNhbGxlZCB3b3VsZCByZXR1cm4NCmEg
bWVhbmluZ2Z1bCBlcnJvciBjb2RlIG5vciBoYW5kbGUgdGhlIG9uZSByZXR1cm5lZCBmcm9tIHRo
ZSBmdW5jdGlvbnMNCnRoZXkgY2FsbCB0aGVtc2VsdmVzLg0KDQpUaGUgZmlyc3QgcGF0Y2ggb2Yg
dGhlIHNlcmllcyBmaXhlcyBhIHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2luZy4N
CkFsbCB0aGUgb3RoZXIgcGF0Y2hlcyB1cGRhdGUgZnVuY3Rpb24ncyBlcnJvciBtYW5hZ2VtZW50
IHdvcmtmbG93IGFuZCBwcm90b3R5cGUNCndoZW4gbmVlZGVkLg0KDQpNb3JlIGZ1bmN0aW9ucyB3
b3VsZCBuZWVkIHRvIGJlIHVwZGF0ZWQsIGJ1dCBmb2N1c2luZyBvbiBpbml0aWFsaXphdGlvbg0K
cHJvY2VzcyBmb3JjZSB0byBjaGFuZ2Ugb25seSBhIHJlYXNvbmFibGUgYW1vdW50IG9mIGNvZGUu
DQoNClRoYW5rIHlvdSwNClF1ZW50aW4NCg0KUXVlbnRpbiBEZXNsYW5kZXMgKDcpOg0KICBzdGFn
aW5nOiB2dDY2NTY6IGZpeCBwb3RlbnRpYWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQogIHN0
YWdpbmc6IHZ0NjY1NjogY2xlYW4gZnVuY3Rpb24ncyBlcnJvciBwYXRoIGluIHVzYnBpcGUuYw0K
ICBzdGFnaW5nOiB2dDY2NTY6IGF2b2lkIGRpc2NhcmRpbmcgY2FsbGVkIGZ1bmN0aW9uJ3MgcmV0
dXJuIGNvZGUNCiAgc3RhZ2luZzogdnQ2NjU2OiBjbGVhbiBlcnJvciBwYXRoIGZvciBmaXJtd2Fy
ZSBtYW5hZ2VtZW50DQogIHN0YWdpbmc6IHZ0NjY1NjogdXNlIG1lYW5pbmdmdWwgZXJyb3IgY29k
ZSBkdXJpbmcgYnVmZmVyIGFsbG9jYXRpb24NCiAgc3RhZ2luZzogdnQ2NjU2OiBjbGVhbi11cCBy
ZWdpc3RlcnMgaW5pdGlhbGl6YXRpb24gZXJyb3IgcGF0aA0KICBzdGFnaW5nOiB2dDY2NTY6IG1h
bmFnZSBlcnJvciBwYXRoIGR1cmluZyBkZXZpY2UgaW5pdGlhbGl6YXRpb24NCg0KIGRyaXZlcnMv
c3RhZ2luZy92dDY2NTYvYmFzZWJhbmQuYyB8IDEzMCArKysrKysrKysrKy0tLS0tLQ0KIGRyaXZl
cnMvc3RhZ2luZy92dDY2NTYvYmFzZWJhbmQuaCB8ICAgOCArLQ0KIGRyaXZlcnMvc3RhZ2luZy92
dDY2NTYvY2FyZC5jICAgICB8ICAyMCArKy0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2Zpcm13
YXJlLmMgfCAgOTEgKysrKysrLS0tLS0tDQogZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9pbnQuYyAg
ICAgIHwgICA4ICstDQogZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9pbnQuaCAgICAgIHwgICAyICst
DQogZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWMuYyAgICAgIHwgIDE5ICsrLQ0KIGRyaXZlcnMv
c3RhZ2luZy92dDY2NTYvbWFjLmggICAgICB8ICAgNiArLQ0KIGRyaXZlcnMvc3RhZ2luZy92dDY2
NTYvbWFpbl91c2IuYyB8IDIzMCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCiBkcml2
ZXJzL3N0YWdpbmcvdnQ2NjU2L3JmLmMgICAgICAgfCAgMzggKysrLS0NCiBkcml2ZXJzL3N0YWdp
bmcvdnQ2NjU2L3JmLmggICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L3Vz
YnBpcGUuYyAgfCAxMTUgKysrKysrKystLS0tLS0tDQogZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni91
c2JwaXBlLmggIHwgICA0ICstDQogMTMgZmlsZXMgY2hhbmdlZCwgNDAwIGluc2VydGlvbnMoKyks
IDI3MyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
