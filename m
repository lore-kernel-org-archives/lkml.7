Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E5620700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ZUbD1xdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:49:50 -0400
Received: from mail-eopbgr30100.outbound.protection.outlook.com ([40.107.3.100]:8517
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfDCNtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f73qeV4XSnJ24FCJifZQYLvyAkVEHdX2kQEobFgm4L4=;
 b=ZUbD1xdutYaJ6IDmijh+VLk3YQUUhxyQJcrvShv7+YWPei7XyJOfxdJNbOIW2w+t/YGjlGKn+i9y6MC4C1NUGqg9Ixs8//zxCigHYVgOfsacJNUVC7xh+0aWZUxRbVKxbgZOD5BhPflO7YcK4k2fFi+O1j+BLY3aTSKzTnY8kok=
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com (20.177.190.218) by
 AM6PR07MB4982.eurprd07.prod.outlook.com (20.177.197.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Wed, 3 Apr 2019 13:49:42 +0000
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825]) by AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825%4]) with mapi id 15.20.1771.011; Wed, 3 Apr 2019
 13:49:42 +0000
From:   "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
CC:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] tcp: Accept ECT on SYN in the presence of RFC8311
Thread-Topic: [PATCH net-next] tcp: Accept ECT on SYN in the presence of
 RFC8311
Thread-Index: AQHU6iQWzH1Le8ioyUObPwH5oCvg1Q==
Date:   Wed, 3 Apr 2019 13:49:42 +0000
Message-ID: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To AM6PR07MB4821.eurprd07.prod.outlook.com
 (2603:10a6:20b:3c::26)
x-mailer: git-send-email 2.21.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olivier.tilmans@nokia-bell-labs.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [135.245.212.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5668181-6131-4a81-b9c9-08d6b83b391d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR07MB4982;
x-ms-traffictypediagnostic: AM6PR07MB4982:
x-microsoft-antispam-prvs: <AM6PR07MB49826C69B05BA2E52A74E352E0570@AM6PR07MB4982.eurprd07.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(59246006)(386003)(5660300002)(1671002)(6506007)(478600001)(6116002)(3846002)(7736002)(305945005)(99286004)(316002)(186003)(102836004)(6486002)(36756003)(106356001)(54906003)(105586002)(256004)(14444005)(6436002)(14454004)(26005)(68736007)(50226002)(2616005)(66066001)(1076003)(486006)(476003)(8936002)(52116002)(81166006)(53936002)(109986005)(8676002)(97736004)(81156014)(6512007)(2906002)(4326008)(25786009)(86362001)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR07MB4982;H:AM6PR07MB4821.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: nokia-bell-labs.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OPS7p0xk6B5efNWZNoN7KVBkV1d41FBbyGIQCCqX4/BWf9TosWKbtJsEeZin+cYnulhRSoVY7NYCKbDsa43cW3SdcM5yljQWW6bWe19ERhu5dy1tD0g0RH61ijGRDA1dphR/Wa8yuOmDVInfY0vjeIXXzWstzgP3TCOUoDZFiL6XJsrshoGUaMW+opXLQOSgHESZ4hrVoc7oYgLfxfyKzxMSWGDOl+Gf20RJqQJ5hIvyZAD8ZeYRigM7rFFEDMp5Jgzn8Z8j3yEjy2Uw3Vvi/xOF/0ezfon9vSOdYwoeW/iY6uhxubLktJI5NEeLTQu5MkbfnlLBWHpktmpQYoNcIyL5uDS6ub/KaIurb/jYOzhi/AfUu1YIme+FC8YMqGONwtIXoAYkD8gLrHCLa115NR9huAomsID2LVkZj8ba8dg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D04A8D65155C184EBABD9329E2DA838D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5668181-6131-4a81-b9c9-08d6b83b391d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 13:49:42.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4982
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGludXggY3VycmVudGx5IGRpc2FibGUgRUNOIGZvciBpbmNvbWluZyBjb25uZWN0aW9ucyB3aGVu
IHRoZSBTWU4NCnJlcXVlc3RzIEVDTiBhbmQgdGhlIElQIGhlYWRlciBoYXMgRUNUKDApL0VDVCgx
KSBzZXQsIGFzIHNvbWUNCm5ldHdvcmtzIHdlcmUgcmVwb3J0ZWRseSBtYW5nbGluZyB0aGUgVG9T
IGJ5dGUsIGhlbmNlIGNvdWxkIGxhdGVyDQp0cmlnZ2VyIGZhbHNlIGNvbmdlc3Rpb24gbm90aWZp
Y2F0aW9ucy4NCg0KUkZDODMxMSDCpzQuMyByZWxheGVzIFJGQzMxNjgncyByZXF1aXJlbWVudHMg
c3VjaCB0aGF0IEVDVCBjYW4gYmUgc2V0DQpvbmUgVENQIGNvbnRyb2wgcGFja2V0cyAoaW5jbHVk
aW5nIFNZTnMpLiBUaGUgbWFpbiBiZW5lZml0IG9mIHRoaXMNCmlzIHRoZSBkZWNyZWFzZWQgcHJv
YmFiaWxpdHkgb2YgbG9zaW5nIGEgU1lOIGluIGEgY29uZ2VzdGVkDQpFQ04tY2FwYWJsZSBuZXR3
b3JrIChpLmUuLCBpdCBhdm9pZHMgdGhlIGluaXRpYWwgMXMgdGltZW91dCkuDQpBZGRpdGlvbmFs
bHksIHRoaXMgYWxsb3dzIHRoZSBkZXZlbG9wbWVudCBvZiBuZXdlciBUQ1AgZXh0ZW5zaW9ucywN
CnN1Y2ggYXMgQWNjRUNOLg0KDQpUaGlzIHBhdGNoIHJlbGF4ZXMgdGhlIHByZXZpb3VzIGNoZWNr
LCBieSBlbmFibGluZyBFQ04gb24gaW5jb21pbmcNCmNvbm5lY3Rpb25zIHVzaW5nIFNZTitFQ1Qg
aWYgYXQgbGVhc3Qgb25lIGJpdCBvZiB0aGUgcmVzZXJ2ZWQgZmxhZ3MNCm9mIHRoZSBUQ1AgaGVh
ZGVyIGlzIHNldC4gU3VjaCBiaXQgd291bGQgaW5kaWNhdGUgdGhhdCB0aGUgc2VuZGVyIG9mDQp0
aGUgU1lOIGlzIHVzaW5nIGEgbmV3ZXIgVENQIGZlYXR1cmUgdGhhbiB3aGF0IHRoZSBob3N0IGlt
cGxlbWVudHMsDQpzdWNoIGFzIEFjY0VDTiwgYW5kIGlzIHRodXMgaW1wbGVtZW50aW5nIFJGQzgz
MTEuIFRoaXMgZW5hYmxlcw0KZW5kLWhvc3RzIG5vdCBzdXBwb3J0aW5nIHN1Y2ggZXh0ZW5zaW9u
cyB0byBzdGlsbCBuZWdvY2lhdGUgRUNOLCBhbmQNCnRvIGhhdmUgc29tZSBvZiB0aGUgYmVuZWZp
dHMgb2YgdXNpbmcgRUNOIG9uIGNvbnRyb2wgcGFja2V0cy4NCg0KU2lnbmVkLW9mZi1ieTogT2xp
dmllciBUaWxtYW5zIDxvbGl2aWVyLnRpbG1hbnNAbm9raWEtYmVsbC1sYWJzLmNvbT4NClN1Z2dl
c3RlZC1ieTogQm9iIEJyaXNjb2UgPHJlc2VhcmNoQGJvYmJyaXNjb2UubmV0Pg0KQ2M6IEtvZW4g
RGUgU2NoZXBwZXIgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT4NCi0tLQ0K
IG5ldC9pcHY0L3RjcF9pbnB1dC5jIHwgNyArKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX2lu
cHV0LmMgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYw0KaW5kZXggNWRmYmMzMzNlNzlhLi42NjYwY2Uy
YTczMzMgMTAwNjQ0DQotLS0gYS9uZXQvaXB2NC90Y3BfaW5wdXQuYw0KKysrIGIvbmV0L2lwdjQv
dGNwX2lucHV0LmMNCkBAIC02MjYzLDYgKzYyNjMsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIHBy
X2Ryb3BfcmVxKHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwgX191MTYgcG9ydCwgaW50IGZhbWls
eSkNCiAgKiBjb25nZXN0aW9uIGNvbnRyb2w6IExpbnV4IERDVENQIGFzc2VydHMgRUNUIG9uIGFs
bCBwYWNrZXRzLA0KICAqIGluY2x1ZGluZyBTWU4sIHdoaWNoIGlzIG1vc3Qgb3B0aW1hbCBzb2x1
dGlvbjsgaG93ZXZlciwNCiAgKiBvdGhlcnMsIHN1Y2ggYXMgRnJlZUJTRCBkbyBub3QuDQorICoN
CisgKiBFeGNlcHRpb246IEF0IGxlYXN0IG9uZSBvZiB0aGUgcmVzZXJ2ZWQgYml0cyBvZiB0aGUg
VENQIGhlYWRlciAodGgtPnJlczEpIGlzDQorICogc2V0LCBpbmRpY2F0aW5nIHRoZSB1c2Ugb2Yg
YSBmdXR1cmUgVENQIGV4dGVuc2lvbiAoc3VjaCBhcyBBY2NFQ04pLiBTZWUNCisgKiBSRkM4MzEx
IMKnNC4zIHdoaWNoIHVwZGF0ZXMgUkZDMzE2OCB0byBhbGxvdyB0aGUgZGV2ZWxvcG1lbnQgb2Yg
c3VjaA0KKyAqIGV4dGVuc2lvbnMuDQogICovDQogc3RhdGljIHZvaWQgdGNwX2Vjbl9jcmVhdGVf
cmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsDQogCQkJCSAgIGNvbnN0IHN0cnVjdCBz
a19idWZmICpza2IsDQpAQCAtNjI4Miw3ICs2Mjg3LDcgQEAgc3RhdGljIHZvaWQgdGNwX2Vjbl9j
cmVhdGVfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsDQogCWVjbl9va19kc3QgPSBk
c3RfZmVhdHVyZShkc3QsIERTVF9GRUFUVVJFX0VDTl9NQVNLKTsNCiAJZWNuX29rID0gbmV0LT5p
cHY0LnN5c2N0bF90Y3BfZWNuIHx8IGVjbl9va19kc3Q7DQogDQotCWlmICgoIWVjdCAmJiBlY25f
b2spIHx8IHRjcF9jYV9uZWVkc19lY24obGlzdGVuX3NrKSB8fA0KKwlpZiAoKCghZWN0IHx8IHRo
LT5yZXMxKSAmJiBlY25fb2spIHx8IHRjcF9jYV9uZWVkc19lY24obGlzdGVuX3NrKSB8fA0KIAkg
ICAgKGVjbl9va19kc3QgJiBEU1RfRkVBVFVSRV9FQ05fQ0EpIHx8DQogCSAgICB0Y3BfYnBmX2Nh
X25lZWRzX2Vjbigoc3RydWN0IHNvY2sgKilyZXEpKQ0KIAkJaW5ldF9yc2socmVxKS0+ZWNuX29r
ID0gMTsNCi0tIA0KMi4yMS4wDQoNCg==
