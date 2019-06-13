Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52501C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E682064A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cExGUxpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfFMPxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:00 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:50395
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731627AbfFMJFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfoLJ2uyi9gIFrIr9NFk5yTVsbbJ4EiE2IM2iDHLCjE=;
 b=cExGUxpVqAW2zkgRMRR5wQmmWL5iFJkDvQVVxwJKke7k1g+L6Xy7n9wFD3n00VVg5bL3Gzc1nTpTEfTyS/BFIy5iSTHfF4Y4axQiCQu3dCsV74N+1476SBsQR8a1eJkys4+65N4o0drif33Puih2XNWp05mNRMjSfU4rvrVIQzg=
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) by
 VI1PR05MB5599.eurprd05.prod.outlook.com (20.177.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 09:05:48 +0000
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c]) by VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 09:05:48 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v1 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVD9h3/DmKQS3aZk+Tx9Nq7fePFaaZbq+A
Date:   Thu, 13 Jun 2019 09:05:48 +0000
Message-ID: <fc1b98afcd1d243e035fddd9916241633b343404.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-4-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190521103619.4707-4-oleksandr.suvorov@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3eb22d0-de41-4705-2b9d-08d6efde53cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5599;
x-ms-traffictypediagnostic: VI1PR05MB5599:
x-microsoft-antispam-prvs: <VI1PR05MB55993A5B8AC7DA35329916A9FBEF0@VI1PR05MB5599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(305945005)(186003)(118296001)(6636002)(11346002)(229853002)(26005)(6486002)(316002)(71190400001)(7736002)(71200400001)(54906003)(86362001)(478600001)(110136005)(14454004)(3846002)(6246003)(81156014)(99286004)(36756003)(76176011)(8676002)(6506007)(53936002)(476003)(6512007)(256004)(5660300002)(25786009)(81166006)(14444005)(6436002)(8936002)(66446008)(66066001)(4326008)(2501003)(66556008)(66476007)(64756008)(68736007)(66946007)(76116006)(44832011)(2616005)(2906002)(6116002)(486006)(446003)(102836004)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5599;H:VI1PR05MB6477.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uQqAds9iyovgrsMxLgTlXs73Zr2OoIgLEQyB2tF+VQtfESpzOLZQrcoUXi8Q3ZAHvKtBOBeKj7RIgzRaprqm2KjH9WBSOneqX4R3NEq3flzjCxHDg77TOA1ip0oBH2svkpYTbCqbrwzKnSPLUqDC5uiZl7dbH7vlv+V5McAl/AvPVyXI8dk0dv7nDjrnHBjhZXewBGR+b24Q2bTOe3QWpypZ16u5w7v5HFKb1Yo0rVN218hIbY7Vq95NvAWMoIucwO9d4ibNZMy7LAltgCYp3tgNDPSaNu9xVGwzYQG1p1akJSNbQP4idc6AhxAMwvZ0lIPeFMtSX9mulFvoyN1qOM5EJyTUDIh4Anm+B6ov9vOR5020L0lbQvKPtg7Q9Jc8fkj/UXuFSqiKxZPJo6rc0QRemuPWsx716ljHGCY6o44=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBAE2C25A90D254DAE2D3621CFBE7757@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eb22d0-de41-4705-2b9d-08d6efde53cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:05:48.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjM2ICswMzAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90
ZToNCj4gVG8gZW5hYmxlICJ6ZXJvIGNyb3NzIGRldGVjdCIgZm9yIEFEQy9IUCwgY2hhbmdlDQo+
IEhQX1pDRF9FTi9BRENfWkNEX0VOIGJpdHMgb25seSBpbnN0ZWFkIG9mIHdyaXRpbmcgdGhlIHdo
b2xlDQo+IENISVBfQU5BX0NUUkwgcmVnaXN0ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVr
c2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQoNClJldmlld2Vk
LWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAt
LS0NCj4gDQo+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCA2ICsrKy0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIHNvdW5kL3NvYy9jb2RlY3Mvc2d0bDUw
MDAuYw0KPiBpbmRleCBiYjU4Yzk5N2M2OTEuLmU4MTNhMzc5MTBhZiAxMDA2NDQNCj4gLS0tIHNv
dW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KPiArKysgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAw
MC5jDQo+IEBAIC0xMjg5LDYgKzEyODksNyBAQCBzdGF0aWMgaW50IHNndGw1MDAwX3Byb2JlKHN0
cnVjdA0KPiBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50KQ0KPiAgCWludCByZXQ7DQo+ICAJ
dTE2IHJlZzsNCj4gIAlzdHJ1Y3Qgc2d0bDUwMDBfcHJpdiAqc2d0bDUwMDAgPQ0KPiBzbmRfc29j
X2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21wb25lbnQpOw0KPiArCXVuc2lnbmVkIGludCB6Y2Rf
bWFzayA9IFNHVEw1MDAwX0hQX1pDRF9FTiB8DQo+IFNHVEw1MDAwX0FEQ19aQ0RfRU47DQo+ICAN
Cj4gIAkvKiBwb3dlciB1cCBzZ3RsNTAwMCAqLw0KPiAgCXJldCA9IHNndGw1MDAwX3NldF9wb3dl
cl9yZWdzKGNvbXBvbmVudCk7DQo+IEBAIC0xMzE2LDkgKzEzMTcsOCBAQCBzdGF0aWMgaW50IHNn
dGw1MDAwX3Byb2JlKHN0cnVjdA0KPiBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50KQ0KPiAg
CSAgICAgICAweDFmKTsNCj4gIAlzbmRfc29jX2NvbXBvbmVudF93cml0ZShjb21wb25lbnQsIFNH
VEw1MDAwX0NISVBfUEFEX1NUUkVOR1RILA0KPiByZWcpOw0KPiAgDQo+IC0Jc25kX3NvY19jb21w
b25lbnRfd3JpdGUoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX0FOQV9DVFJMLA0KPiAtCQkJU0dU
TDUwMDBfSFBfWkNEX0VOIHwNCj4gLQkJCVNHVEw1MDAwX0FEQ19aQ0RfRU4pOw0KPiArCXNuZF9z
b2NfY29tcG9uZW50X3VwZGF0ZV9iaXRzKGNvbXBvbmVudCwNCj4gU0dUTDUwMDBfQ0hJUF9BTkFf
Q1RSTCwNCj4gKwkJemNkX21hc2ssIHpjZF9tYXNrKTsNCj4gIA0KPiAgCXNuZF9zb2NfY29tcG9u
ZW50X3VwZGF0ZV9iaXRzKGNvbXBvbmVudCwNCj4gU0dUTDUwMDBfQ0hJUF9NSUNfQ1RSTCwNCj4g
IAkJCVNHVEw1MDAwX0JJQVNfUl9NQVNLLA0KPiAtLSANCj4gMi4yMC4xDQo=
