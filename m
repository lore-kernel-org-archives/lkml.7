Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E886CC3B184
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AA7246B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YQiQG7cM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfLMPW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:22:28 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:50659
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727840AbfLMPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqVWoqLuwMxesZwMRiylbrRVVzzjRykS0XEBm4ZHgfmzAZ0Eu7cpjexHcEB/9hV3BdLNl22LbaDyP8YP79naPRnKsBQ6gVlgJnDocbz7w38E4495HO55ci+lZF/ifTZSjg8IOC+YkZKTNG8UyfpDRrEwzcI1h4CzQl0h4W04z4ikq/uRf9qfzX6YOOF1uJi4xcsqTcalYSLm82eiEOLB/HerC2Lswao3QeWpP7RiB763gUd6Ane7Lqy8KHM1FX2+WkndRF7JTUPxVSdDpESZLorwfrZmpeXTRvTFSC1ujazDVtHSbzw225qf4xSDFc225+C/M4z7h16aQHqJouHNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEjKG8q5pBMISXiQ5qDsnGu0nigh1a8c3aVgIuEIk1Q=;
 b=eRQbuhLQ2B/DsPc1T7s8RYOurnlemhuVYjHqFskUsWM+UMqMadra3tDvZX/McCeHnulLRi0lPzoGYVVhqtta+lkITnliT0NjgBdqgrFvPzpP87KffNxmPngT1a4F9127/YL2fFAiUdFtPxD5szv+C8MD2RHfrndqRRYLBqhdsuZZ/PtG888MXMkAykc3ea4QLi5v8CyODkbFEemwOnBd2dTiJpmMPkn/Oy9ex8++YD4ImYny4gl0do27bayqpWiqfIWLFS304w2FJr4nroTsd5aX9k1wMYmpT2qxu13o7eTsqRpK9dkZr2PmNPVlkzWk8ygbDmB6qc06vJBebSuHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEjKG8q5pBMISXiQ5qDsnGu0nigh1a8c3aVgIuEIk1Q=;
 b=YQiQG7cMSs18xnlT3FOnauVWbcYdy3A6v32zr3dlS3WAcJOeRMBae3WOQrq0D0Rm8uCnF+7fSltM8dtKBdilfRxbJ5RyHP14r7zm61dyB3E+oVhuE/yjvJbPVj8O/O+Ha3xzad9sbT39MjJAQh/iXEOHBX1mg2C8/kLUg52v3e8=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3157.eurprd05.prod.outlook.com (10.170.220.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 15:22:22 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::4127:4f1a:a073:a987%4]) with mapi id 15.20.2516.019; Fri, 13 Dec 2019
 15:22:22 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Topic: [PATCH v1 1/1] platform/mellanox: fix the mlx-bootctl sysfs
Thread-Index: AQHVrsYzUl5YWvnJj0GywOQUtaqWFqe34JMAgABT9MA=
Date:   Fri, 13 Dec 2019 15:22:22 +0000
Message-ID: <DB6PR05MB3223B0F68E3E4EE3A20AD193A1540@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <94727fab054309cd98c876748fd27b130ce5031f.1575918870.git.lsun@mellanox.com>
 <CAHp75VcY9syYZoaOLWUHQQ6n5CXwvUnarDJPovLtyLTyZE_ifw@mail.gmail.com>
In-Reply-To: <CAHp75VcY9syYZoaOLWUHQQ6n5CXwvUnarDJPovLtyLTyZE_ifw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af39b36d-5971-4c6c-4664-08d77fe04043
x-ms-traffictypediagnostic: DB6PR05MB3157:|DB6PR05MB3157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR05MB315752FED45E501AED4E4DEEA1540@DB6PR05MB3157.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(13464003)(86362001)(8936002)(66946007)(81166006)(316002)(81156014)(4744005)(8676002)(76116006)(26005)(4326008)(2906002)(478600001)(54906003)(53546011)(6506007)(52536014)(55016002)(5660300002)(71200400001)(7696005)(6916009)(33656002)(66556008)(64756008)(66476007)(9686003)(186003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3157;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xO0807CNNBedzxFTYLyHi7DZI9DM+0XWLJJK5xYN3AXD4Rphp0NZN6v3iRW/IoSxnmYfOj3CfTp3DUkbzPutY2aC+M8ehVm63VKFiYr2TNS3rR8BMOg1uu+HH5PypYelVfCgi/xrdbCKVvbVncde9RQwZDhSymB/F6sC9gRYE8bv7C2kzxG+LugXGJqsR93zaUELK9t4WzEY2QyG7AByhcq+TJUCwwrnSS03XOKxUgQJrz6MzYLf3Debb7Eccp6APkv6KPiOiA/mDuzkdAWbldCzzwrSoInQVb7Qd4s4xNGF4DuUT21xKFO6mCoYcnbgrjPyftvrTy+8xP923Rr6jWWC5FSJWW636HmzFKxkyuBU5XMxfZkP5W1BCMon6OEQ4/kojv3oCQolZNJPbG8bzEBVCOHaHQqgZSZgZtszGRoGWQd3V7pe7E8SsLUyKbBv5iBlAVlC/RyKmBipKek4AyyxUIcX9+U9kjijbv34183qw2tUOcAm4RWOjqbmqsUj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af39b36d-5971-4c6c-4664-08d77fe04043
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 15:22:22.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIe8RFIcQS5hx0F4cyKnLO1G5q0F3Te0rhSpbHsU64qOW1yPLpXgs8dSsRtve9a8SlVOXmQDzNKwKyNpcMfPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzISBVcGRhdGVkIGluIHYyLg0KDQotIExpbWluZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxMywgMjAxOSA1OjIxIEFNDQo+IFRvOiBM
aW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCj4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5k
eUBpbmZyYWRlYWQub3JnPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsgVmFk
aW0gUGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPjsgRGF2aWQNCj4gV29vZHMgPGR3b29k
c0BtZWxsYW5veC5jb20+OyBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZAdmdl
ci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBwbGF0Zm9y
bS9tZWxsYW5veDogZml4IHRoZSBtbHgtYm9vdGN0bCBzeXNmcw0KPiANCj4gT24gTW9uLCBEZWMg
OSwgMjAxOSBhdCA5OjI0IFBNIExpbWluZyBTdW4gPGxzdW5AbWVsbGFub3guY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFRoaXMgaXMgYSBmb2xsb3ctdXAgY29tbWl0IGZvciB0aGUgc3lzZnMgYXR0cmli
dXRlcyB0byBjaGFuZ2UNCj4gPiBmcm9tIERSSVZFUl9BVFRSIHRvIERFVklDRV9BVFRSIGFjY29y
ZGluZyB0byBzb21lIGluaXRpYWwgY29tbWVudHMuDQo+ID4gSW4gc3VjaCBjYXNlLCBpdCdzIGJl
dHRlciB0byBwb2ludCB0aGUgc3lzZnMgcGF0aCB0byB0aGUgZGV2aWNlDQo+ID4gaXRzZWxmIGlu
c3RlYWQgb2YgdGhlIGRyaXZlci4gVGhpcyBjb21taXQgYWRkcyB0aGUgbWlzc2luZw0KPiA+IHN5
c2ZzX2NyZWF0ZV9ncm91cCgpIHNvIHRoZSBhdHRyaWJ1dGVzIGNhbiBiZSBjcmVhdGVkIHVuZGVy
IHRoZQ0KPiA+IGRldmljZS4gVGhlIEFCSSBkb2N1bWVudCBpcyBhbHNvIHVwZGF0ZWQuDQo+ID4N
Cj4gDQo+IEZpeGVzIHRhZywgcGxlYXNlLg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMs
DQo+IEFuZHkgU2hldmNoZW5rbw0K
