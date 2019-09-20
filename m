Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39541C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92DD207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jsgHIxGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437576AbfITHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:40:49 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:63505
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437540AbfITHks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okj6K6bL2Zc2gNJeSKiVv3rd/EWVZr9TuWOehz/zqtXy2G6NpAnZ0WTAc+yV/dlRZwkT5rtiYZef+ymwLFEKRK5mzRUrHfyexS6yQWosDh357IXstND9HOTPnsvbvv56dXiCO9xKOQhf/ZIrvESYkC2voo9GPv1gHz9LqKYE6qyS9iL+Pu32YfAeDmEa1h5Ec8LF04m920UM2onR1x6H2v//IbgIMlYT532U0ZCfJMdnNfNgL/XpR2vh+IN0d0xpZu28sqKkLYDXlflOoKQEfegbrmFomyO3MflpCkUusInbFr8nxkH1R/6qgC5k8y9zNWmsepYGNqSnLR4zztJkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyYvUJBRRY2TyGo7GDQ3F1UwyyTjaiCqJTyNK8rgOCs=;
 b=DpGMg70vOwMapeXvScy8XPFXVe/DKrlDMwv0HgEWtdurOAm2upNvZxTXsYcyeXW7jypEuQpr/R5QsIsZXjDYubjVYeHFtsA6C5lSHm1Nph43HcJ8oVa8EW8Uk2jEhJTeA5fgJDIskTzPwa0TeqAPhVtIq0xn+1Az8KrxXT7fknS0gzsqkKtPQSWGp8krLLW67XN2PJUZOjjprEbVQ+7hTkcLC/FndIl7VhX9OY6rbF1MprvV+wIFiWimKXi0vyHdeT1BwqSYbGEL0T78ITbYYqnv03ToDhyQNCrqleOCxRDSWeoZdK9yEyAvXUu6jRCP17f3X8ht7HCDBTjhY5isEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyYvUJBRRY2TyGo7GDQ3F1UwyyTjaiCqJTyNK8rgOCs=;
 b=jsgHIxGCUtnl2bNM4lsdfd5auqM/PBGpMFCLzxMjILTD0H1Dg9V329Ymdy46sxa8M484dwFKps9sWFVKNacklNQqXWDfKbxvepKpKq0ybfGTjGMJrukBwnqKY+tvIvv/ymQD/FMhWnzEPoV7UmJ46LVkN6dNX5LEAhrmqmLloCg=
Received: from AM6PR05MB5288.eurprd05.prod.outlook.com (20.177.198.151) by
 AM6PR05MB5253.eurprd05.prod.outlook.com (20.177.191.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 07:40:46 +0000
Received: from AM6PR05MB5288.eurprd05.prod.outlook.com
 ([fe80::255f:e232:1ad8:65fb]) by AM6PR05MB5288.eurprd05.prod.outlook.com
 ([fe80::255f:e232:1ad8:65fb%5]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 07:40:46 +0000
From:   Tal Gilboa <talgi@mellanox.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <uwe@kleine-koenig.org>,
        Saeed Mahameed <saeedm@mellanox.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dimlib: should it really be enabled by default? [Was: [PATCH]
 trivial: lib/Kconfig: typo modertion -> moderation]
Thread-Topic: dimlib: should it really be enabled by default? [Was: [PATCH]
 trivial: lib/Kconfig: typo modertion -> moderation]
Thread-Index: AQHVby5BqYDJgSPbmUCEc8FyduAIAac0LvyA
Date:   Fri, 20 Sep 2019 07:40:45 +0000
Message-ID: <28e1c85f-ca1c-b624-fad7-65d21a352fa7@mellanox.com>
References: <20190919210314.22110-1-uwe@kleine-koenig.org>
 <7acc93c7-d689-1fb2-e237-931560dfd8cb@kleine-koenig.org>
In-Reply-To: <7acc93c7-d689-1fb2-e237-931560dfd8cb@kleine-koenig.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.47.165.251]
x-clientproxiedby: AM4PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:200:89::12) To AM6PR05MB5288.eurprd05.prod.outlook.com
 (2603:10a6:20b:6b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8030bd2c-48e0-45e9-0248-08d73d9dd8bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5253;
x-ms-traffictypediagnostic: AM6PR05MB5253:|AM6PR05MB5253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5253AC6198B34C21BF222EF6D2880@AM6PR05MB5253.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(54094003)(189003)(25786009)(66574012)(71190400001)(4326008)(4744005)(2906002)(11346002)(81156014)(81166006)(446003)(8676002)(31686004)(2616005)(476003)(8936002)(486006)(6436002)(316002)(66066001)(6486002)(6512007)(110136005)(5660300002)(229853002)(102836004)(256004)(7736002)(3846002)(6116002)(76176011)(14444005)(6246003)(14454004)(305945005)(6506007)(386003)(53546011)(478600001)(186003)(31696002)(66946007)(66446008)(64756008)(66556008)(36756003)(66476007)(86362001)(6636002)(52116002)(26005)(99286004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5253;H:AM6PR05MB5288.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g78OzJht70f3b/JG2jwj117ZiB3lp73fYF/3mLblM2OR/kQ7dbwpuSyKTbUe3jrZG7+jicqjcyeQ1Yv+vBIUA12bt1K/1RqZz9npoyZzfPafdSulRui2/lBA9vMJPb6oBUJa9h0854jHbxynM278zAWEX/DxKPmq8/J8eZ/UOZaOdvQtBZn/LSqCkiqwD45DjbMBheXg1uXJyBcAcSRrBPzNPTrsbEevOLfAZlpamtdchX15+eZFByKbagY12IYamSCkLmsMkflJ/z+SQ8Eq1DQ/hw1mQ4+344LBTtD3sewN1oxxGxagGepPUTwjD9LZpNQ9Tc4nRkPbIGpTv2gxFbJlXyT0jQs93SNsadRqkKrUr7JhFZWiOpfSEYVtNGUXd144KdyPAGO7Qqu6gEljr7+rRe06yC3VT8shIFxBeRo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AB30F2E3F6A4D4FB317AC2F5BA0CF7E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8030bd2c-48e0-45e9-0248-08d73d9dd8bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 07:40:45.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUmr5OC4QLaFDGIVKJCMlOMgDsQX3/juAfIpYzLDJWP5FBeY0vjytGG359ZqOWTe0c/dTcglxJQePWDBOYx2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMC8yMDE5IDEyOjA3IEFNLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gT24gOS8x
OS8xOSAxMTowMyBQTSwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+PiBGaXhlczogNGY3NWRh
MzY2NmMwICgibGludXgvZGltOiBNb3ZlIGltcGxlbWVudGF0aW9uIHRvIC5jIGZpbGVzIikNCj4+
IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+
DQo+PiAtLS0NCj4+ICAgbGliL0tjb25maWcgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9saWIvS2Nv
bmZpZyBiL2xpYi9LY29uZmlnDQo+PiBpbmRleCA0ZTZiMWMzZTRjOTguLmNjMDQxMjRlZDhmNyAx
MDA2NDQNCj4+IC0tLSBhL2xpYi9LY29uZmlnDQo+PiArKysgYi9saWIvS2NvbmZpZw0KPj4gQEAg
LTU1OSw3ICs1NTksNyBAQCBjb25maWcgRElNTElCDQo+PiAgIAlkZWZhdWx0IHkNCj4gDQo+IEJU
VywgSSB3b25kZXIgYWJvdXQgdGhpcyAiZGVmYXVsdCB5Ii4gSSBzZWUgdGhlcmUgYXJlIHNvbWUg
ZHJpdmVycyB0aGF0DQo+IHNlbGVjdCBESU1MSUIsIHNvIEkgd29uZGVyIGlmIEkgYmVuZWZpdCBm
cm9tIGl0IGF0IGFsbCBpZiBJIGRvbid0IHVzZQ0KPiBzdWNoIGEgZHJpdmVyPyENCg0KVGhhbmtz
IGZvciBicmluZ2luZyB0aGlzIHVwLiBUaGUgb25seSBiZW5lZml0IGZyb20gRElNIGNvbWVzIGZy
b20gYSANCmRyaXZlciB0aGF0IHVzZSBpdC4gSSBkb24ndCBtaW5kIHRoZSBkZWZhdWx0IHdvdWxk
IGJlIGNoYW5nZWQgYnV0IGZyb20gDQp3aGF0IEkgc2VlIG5vdCBhbGwgZHJpdmVycyB0aGF0IHVz
ZSBESU0gaGF2ZSB0aGUgc2VsZWN0IERJTUxJQiBsaW5lIGluIA0KdGhlaXIgS2NvbmZpZyBmaWxl
cywgc28gc3VjaCBhIGNoYW5nZSBzaG91bGQgbWFrZSBzdXJlIG5vIGZ1bmN0aW9uYWxpdHkgDQpp
cyBicm9rZW4uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCg==
