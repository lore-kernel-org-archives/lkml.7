Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23332064A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nOkSRkUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbfFMPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:02 -0400
Received: from mail-eopbgr50117.outbound.protection.outlook.com ([40.107.5.117]:18670
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731626AbfFMJFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9Gh5ZuJt8AW5fUQtfhsxRWWsVWEyQj2kz4GoqpxY2k=;
 b=nOkSRkUN+vq9I5aNNrv2ENdBu4Znss7rAzyRIn7WVP+dv1TkxpgljUY2EhoWvRRmJEMWr22xb7jg2VhcExFtEDgSx3f7d0aXli7Zl2luYPvDY73kMQ/BtU6FItg+NV4d0zKge7j4vIMrHsZZt+Dz9Krj+9gacusMxOXNVlz/lT4=
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) by
 VI1PR05MB5599.eurprd05.prod.outlook.com (20.177.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 09:05:28 +0000
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c]) by VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 09:05:28 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Topic: [PATCH v1 2/6] ASoC: sgtl5000: add ADC mute control
Thread-Index: AQHVD9h3XsFBSZPO+0qHbd3KVI0xQKaZbpkA
Date:   Thu, 13 Jun 2019 09:05:28 +0000
Message-ID: <063a08453c5d0c1c88ccb1bc8f4b1512e99ab138.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe157206-9f83-4bc1-20fb-08d6efde47f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5599;
x-ms-traffictypediagnostic: VI1PR05MB5599:
x-microsoft-antispam-prvs: <VI1PR05MB559911E03714AABAF63160BFFBEF0@VI1PR05MB5599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(305945005)(186003)(118296001)(6636002)(11346002)(229853002)(26005)(6486002)(316002)(71190400001)(7736002)(71200400001)(54906003)(86362001)(478600001)(110136005)(14454004)(3846002)(6246003)(81156014)(99286004)(36756003)(76176011)(8676002)(6506007)(53936002)(476003)(6512007)(256004)(5660300002)(25786009)(4744005)(81166006)(6436002)(8936002)(66446008)(66066001)(4326008)(2501003)(66556008)(66476007)(64756008)(68736007)(66946007)(76116006)(44832011)(2616005)(2906002)(6116002)(486006)(446003)(102836004)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5599;H:VI1PR05MB6477.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UkmQQukRK6vUaAw3iqFI8oajIdla0G9a88RRHPka6/023s2x+kvAMCcKi1HpDvGTx2RS2ZfH9tA9MlKMUoHcg+fgrUGuOLlMq0GzrZ6A2UDBINx542vH89bjKX3WBPeAbQgXZJCIBl8WH3g4LrX041tVqJn1Rqr6okJrMH69DQSTWDb6z1I/NV3DN3S8XLsNIQaGEanJIo03mD/jNg1mMwZhpdtfcLDO8smEeCCjaKIQuz5JjG2dF1Nobv/WYvSviyyT0BAcOgDos3scQBWrvDV2uKeBeo1zNIJvyH5aLXH/jgH5OoK5BZ5l43CyDS+/6rJpx1CMEXcG47It6RRXExtZInZ2pdYozjEwXPmE9cE5iePKKyjA6T/4vSybq2dmrjROKpfoG9EupnMw1qyufVov93eJt7oMmJybUSnK+OQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <028F4CD25C14B6478349B18E20D4F554@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe157206-9f83-4bc1-20fb-08d6efde47f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:05:28.7044
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
ZToNCj4gVGhpcyBjb250cm9sIG11dGUvdW5tdXRlIHRoZSBBREMgaW5wdXQgb2YgU0dUTDUwMDAN
Cj4gdXNpbmcgaXRzIENISVBfQU5BX0NUUkwgcmVnaXN0ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQoNClJl
dmlld2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4N
Cg0KPiAtLS0NCj4gDQo+ICBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCAxICsNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBzb3VuZC9zb2Mv
Y29kZWNzL3NndGw1MDAwLmMgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+IGluZGV4IDVl
NDk1MjNlZTBiNi4uYmI1OGM5OTdjNjkxIDEwMDY0NA0KPiAtLS0gc291bmQvc29jL2NvZGVjcy9z
Z3RsNTAwMC5jDQo+ICsrKyBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gQEAgLTU1Niw2
ICs1NTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcNCj4gc2d0bDUw
MDBfc25kX2NvbnRyb2xzW10gPSB7DQo+ICAJCQlTR1RMNTAwMF9DSElQX0FOQV9BRENfQ1RSTCwN
Cj4gIAkJCTgsIDEsIDAsIGNhcHR1cmVfNmRiX2F0dGVudWF0ZSksDQo+ICAJU09DX1NJTkdMRSgi
Q2FwdHVyZSBaQyBTd2l0Y2giLCBTR1RMNTAwMF9DSElQX0FOQV9DVFJMLCAxLCAxLA0KPiAwKSwN
Cj4gKwlTT0NfU0lOR0xFKCJDYXB0dXJlIFN3aXRjaCIsIFNHVEw1MDAwX0NISVBfQU5BX0NUUkws
IDAsIDEsIDEpLA0KPiAgDQo+ICAJU09DX0RPVUJMRV9UTFYoIkhlYWRwaG9uZSBQbGF5YmFjayBW
b2x1bWUiLA0KPiAgCQkJU0dUTDUwMDBfQ0hJUF9BTkFfSFBfQ1RSTCwNCj4gLS0gDQo+IDIuMjAu
MQ0K
