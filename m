Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63148C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DE220659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="JBO9nOnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfFYHt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:49:57 -0400
Received: from mail-eopbgr140122.outbound.protection.outlook.com ([40.107.14.122]:13894
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729236AbfFYHty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf5nvvR9LrPigaH67L4LIaaoXletuhguZISx8ggsOa4=;
 b=JBO9nOnrs8rDGBf8WFyddXyiP5G7Qmq4MkiF7LViPV7c1S1UCHHtbj5/dTBaUqA9/97BC/fzXrXzo468HphNjNrbdq7L3QAj5KgJYfVTPM6rm8QosmkT22M6REyajduoZ4umxMltNhkowPenRxgUoDwWRmQM96QG6TVWZdA18I0=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5352.eurprd05.prod.outlook.com (20.177.197.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 07:49:51 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:51 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Topic: [PATCH v2 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Thread-Index: AQHVKyqRNsGfUx+RZUSiM76rxvu/oA==
Date:   Tue, 25 Jun 2019 07:49:51 +0000
Message-ID: <20190625074937.2621-4-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:15::18) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ec7df5-ea4b-435a-04af-08d6f941b42c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5352;
x-ms-traffictypediagnostic: AM6PR05MB5352:
x-microsoft-antispam-prvs: <AM6PR05MB5352C30DCAEC2348EBA949CDF9E30@AM6PR05MB5352.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39850400004)(376002)(199004)(189003)(26005)(5660300002)(1076003)(54906003)(71190400001)(1411001)(71200400001)(2906002)(36756003)(305945005)(86362001)(53936002)(6486002)(8676002)(478600001)(6512007)(25786009)(50226002)(14454004)(6436002)(6116002)(3846002)(7736002)(316002)(68736007)(44832011)(486006)(476003)(2616005)(66556008)(81166006)(4326008)(6916009)(256004)(66476007)(81156014)(64756008)(66446008)(8936002)(66946007)(73956011)(14444005)(386003)(102836004)(6506007)(52116002)(11346002)(446003)(76176011)(99286004)(186003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5352;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e8vGEqrjFDSxcrrFXRbFXdP2cYQe2SN4412HMLbTB5ISTREtw9IBGmAS7ohwtUF/otKOACXlgphI7blzcHRmyKFhJwY03MqJMe9WxylMW6GHHdPbw1BuQi/LshaA2uYTbzx6/R9wmiqxSQIWlZaEUW7j21Lwg6CV0bzFlZ2G2MbN0R7sGOTAWXkPZceGJwVpzJLcKB/eB70KuNf/1iqiOpAdsTGjSFUqiit0gzxraA6hI/iKaXY2Lj0FyzINrUFazT/+74qIIBBbue3vdSntXk5X/JTyT+Wdi/gxo7PqUm6OOUIBA4XrSXQ6C17lesQk5itDMU+cveLSV/14IfkgActqTQSUV19ODWNiYPPb+7J1iauvyJNElEdlgS/u8iJhm3LH/v8Gsvl6vsDkD6Dwh81pam2ogbXxSd4qjPpg1nU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ec7df5-ea4b-435a-04af-08d6f941b42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:51.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VG8gZW5hYmxlICJ6ZXJvIGNyb3NzIGRldGVjdCIgZm9yIEFEQy9IUCwgY2hhbmdlDQpIUF9aQ0Rf
RU4vQURDX1pDRF9FTiBiaXRzIG9ubHkgaW5zdGVhZCBvZiB3cml0aW5nIHRoZSB3aG9sZQ0KQ0hJ
UF9BTkFfQ1RSTCByZWdpc3Rlci4NCg0KU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFN1dm9yb3Yg
PG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXguY29tPg0KLS0tDQoNCiBzb3VuZC9zb2MvY29kZWNz
L3NndGw1MDAwLmMgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAw
LmMgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCmluZGV4IGJiNThjOTk3YzY5MTQuLmU4
MTNhMzc5MTBhZjQgMTAwNjQ0DQotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCisr
KyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0bDUwMDAuYw0KQEAgLTEyODksNiArMTI4OSw3IEBAIHN0
YXRpYyBpbnQgc2d0bDUwMDBfcHJvYmUoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25l
bnQpDQogCWludCByZXQ7DQogCXUxNiByZWc7DQogCXN0cnVjdCBzZ3RsNTAwMF9wcml2ICpzZ3Rs
NTAwMCA9IHNuZF9zb2NfY29tcG9uZW50X2dldF9kcnZkYXRhKGNvbXBvbmVudCk7DQorCXVuc2ln
bmVkIGludCB6Y2RfbWFzayA9IFNHVEw1MDAwX0hQX1pDRF9FTiB8IFNHVEw1MDAwX0FEQ19aQ0Rf
RU47DQogDQogCS8qIHBvd2VyIHVwIHNndGw1MDAwICovDQogCXJldCA9IHNndGw1MDAwX3NldF9w
b3dlcl9yZWdzKGNvbXBvbmVudCk7DQpAQCAtMTMxNiw5ICsxMzE3LDggQEAgc3RhdGljIGludCBz
Z3RsNTAwMF9wcm9iZShzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCiAJICAg
ICAgIDB4MWYpOw0KIAlzbmRfc29jX2NvbXBvbmVudF93cml0ZShjb21wb25lbnQsIFNHVEw1MDAw
X0NISVBfUEFEX1NUUkVOR1RILCByZWcpOw0KIA0KLQlzbmRfc29jX2NvbXBvbmVudF93cml0ZShj
b21wb25lbnQsIFNHVEw1MDAwX0NISVBfQU5BX0NUUkwsDQotCQkJU0dUTDUwMDBfSFBfWkNEX0VO
IHwNCi0JCQlTR1RMNTAwMF9BRENfWkNEX0VOKTsNCisJc25kX3NvY19jb21wb25lbnRfdXBkYXRl
X2JpdHMoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX0FOQV9DVFJMLA0KKwkJemNkX21hc2ssIHpj
ZF9tYXNrKTsNCiANCiAJc25kX3NvY19jb21wb25lbnRfdXBkYXRlX2JpdHMoY29tcG9uZW50LCBT
R1RMNTAwMF9DSElQX01JQ19DVFJMLA0KIAkJCVNHVEw1MDAwX0JJQVNfUl9NQVNLLA0KLS0gDQoy
LjIwLjENCg0K
