Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1DE218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KaOZitfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfCUObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:31:01 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:50085
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbfCUObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXLCcK1JVgwZITKMXToYb89BibY5Di317ob/qimVnnE=;
 b=KaOZitfgsQO+38J+3un70RgXhnmvudYIKpBlylSdO9ysNkt8uV+Nkw4Q22Kf2aXcFNYpStoyRUNmWD5oVFyzYQTKd5u3XgaWisl7ZOO23o6wPrdFOyOGWzVx7u9YP9/IIlP4fV7Wpd+7zlZCuawX02oH/62ZAx3NTCURSqd81Y8=
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com (10.172.226.16) by
 DB6PR0501MB2277.eurprd05.prod.outlook.com (10.168.55.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 14:30:55 +0000
Received: from DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7]) by DB6PR0501MB2709.eurprd05.prod.outlook.com
 ([fe80::e595:dbdf:132d:3ef7%7]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 14:30:55 +0000
From:   Junhan Zhou <Junhan@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Liming Sun <lsun@mellanox.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Topic: [PATCH v2] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Index: AQHU3bnnCVZsl7M9ekuQKIg4AeI5waYRw3IAgARaC0A=
Date:   Thu, 21 Mar 2019 14:30:55 +0000
Message-ID: <DB6PR0501MB270922D61D8F228A31A664CDB3420@DB6PR0501MB2709.eurprd05.prod.outlook.com>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1552934340-10103-1-git-send-email-Junhan@mellanox.com>
 <6a56e799-b5fd-8437-6339-9c88acb3bbe5@infradead.org>
In-Reply-To: <6a56e799-b5fd-8437-6339-9c88acb3bbe5@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db403722-775b-4476-8e4d-08d6ae09d423
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2277;
x-ms-traffictypediagnostic: DB6PR0501MB2277:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Junhan@mellanox.com; 
x-microsoft-antispam-prvs: <DB6PR0501MB227797991C20125A20052945B3420@DB6PR0501MB2277.eurprd05.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(6116002)(8676002)(8936002)(81156014)(81166006)(3846002)(6436002)(68736007)(305945005)(74316002)(72206003)(7736002)(106356001)(33656002)(71200400001)(4326008)(53936002)(105586002)(6246003)(54906003)(71190400001)(256004)(110136005)(316002)(99286004)(478600001)(229853002)(97736004)(66066001)(186003)(102836004)(476003)(486006)(25786009)(446003)(2906002)(80792005)(26005)(9686003)(6506007)(55016002)(5660300002)(52536014)(14454004)(11346002)(7696005)(86362001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2277;H:DB6PR0501MB2709.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rmf9uTQKcUay0ugVlJ6Rq52iE0toNxXh9AvgRMMiVNktzMKdRwlgLng8qQrpDU68Afmhontq6xrcE8JOjZr9jrWkYashIe58oAug8q73bD5w5gtIqXYwCWiahVStvFyirRC7zJiwTHATeevKsLyntgEc+8ivvx3AglOa4I6bdQwfFNca32NWohXf5deQ8zlZuJDkpVyjVcwfWliz8BUoPf4Ou49DzlMvl7xIp3mgRLJHDM/XWKDkxZEyXH5ptYW+hpBVGcCA0p5bdYYAve3UmTM0qLqK0THPwx5/1ykfJKU6k3XYAeJ2R+cJU7irCRswP3yAlxtb4UMp1LjxVFexjSFJ4YC07nO4ebE34RjZUGDGDc+Q4/CVtw3CacgYGLg6B2Unh4Y5matLCJ9eX+WgaYEfemUOdn9TgQ6R0TO98M0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db403722-775b-4476-8e4d-08d6ae09d423
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 14:30:55.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtjb25maWcgRURBQ19CTFVFRklFTEQNCj4gPiArCXRyaXN0YXRlICJNZWxsYW5veCBCbHVl
RmllbGQgTWVtb3J5IEVDQyINCj4gPiArCWRlcGVuZHMgb24gKE1FTExBTk9YX1BMQVRGT1JNICYm
IEFSTTY0ICYmIEFDUEkpIHx8DQo+IENPTVBJTEVfVEVTVA0KPiANCj4gSGksDQo+IA0KPiBXaGls
ZSBJIGFtIGluIGZhdm9yIG9mIHVzaW5nIENPTVBJTEVfVEVTVCB3aGVuZXZlciBwb3NzaWJsZSwg
SSBkb24ndCBzZWUNCj4gaG93IHRoYXQgaXMgcG9zc2libGUgaGVyZSBpZjoNCj4gDQo+ICMgTUVM
TEFOT1hfUExBVEZPUk0gaXMgbm90IHNldA0KPiAjIEFSTTY0IGlzIG5vdCBzZXQNCj4gIyBBQ1BJ
IGlzIG5vdCBzZXQNCj4gQ09NUElMRV9URVNUPXkNCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4cGxh
aW4/DQo+IA0KPiBUaGFua3MuDQo+IA0KPiB+UmFuZHkNCg0KR29vZCBwb2ludC4gSSB0cmllZCBj
b21waWxpbmcgaXQgYWdhaW5zdCB0aGUgeDg2IGFyY2hpdGVjdHVyZSBhbmQgaXQgZmFpbHMgYmVj
YXVzZSBpdCBjYW4ndCBmaW5kIHRoZSBkZWZpbml0aW9uIGZvciBhcm1fc21jY2Nfc21jKCkuIEJ1
dCBpdCB3b3VsZCBjb21waWxlIGZvciB0aGUgQVJNNjQgYXJjaGl0ZWN0dXJlIHdpdGggYm90aCBB
Q1BJIGFuZCBNRUxMQU5PWCBfUExBVEZPUk0gbm90IHNldCwgc28gSSdsbCBjaGFuZ2UgaXQgdG8g
QVJNNjQgJiYgKChNRUxMQU5PWF9QTEFURk9STSAmJiBBQ1BJKSB8fCBDT01QSUxFX1RFU1QpIGlu
c3RlYWQuDQpUaGUgZGVwZW5kZW5jeSBvbiBBQ1BJIGlzIGJlY2F1c2Ugb3VyIEJsdWVGaWVsZCBT
b0MgZmlybXdhcmUgb25seSB1c2VzIEFDUEkgdG8gcGFzcyB0aGUgZGV2aWNlIG1hcHBpbmdzLCBh
bmQgTUVMTEFOT1hfUExBVEZPUk0gYmVjYXVzZSB0aGlzIGRldmljZSBpcyBvbmx5IHNlZW4gb24g
dGhlIE1lbGxhbm94IEJsdWVGaWVsZCBTb0Mgc28gaXQgd291bGQgYmUgcG9pbnRsZXNzIHRvIGJl
IHVzZWQgZWxzZXdoZXJlLCBidXQgdGhlc2UgZG9lc24ndCBwcmV2ZW50IGl0IGZyb20gYmVpbmcg
Y29tcGlsZWQuDQoNCi1KdW5oYW4NCg==
