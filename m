Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3CEC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B352085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CPcPXxyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfFYHuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:50:04 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com ([40.107.14.105]:31334
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729550AbfFYHt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlrYSI6NJNMzc5F5VtbWjDtAr+NLewjZB+1Lvsa2+kE=;
 b=CPcPXxyrd8YvBJmlSclq/cOfzrZG7qj8kIldUHV/tJBn+r87zfULZe3Xic8bp82q2s4DuWH7wWX1qf/DsW5HnnnYPh1YQN2r8QTB1nDaa6nqwzpo9xm9BY/XVI8uH6H3Y4NEX4fLMFybkdzc0+HmiFpEkdW3zOp6M5+E7lPn8PI=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5352.eurprd05.prod.outlook.com (20.177.197.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 07:49:54 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:54 +0000
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
Subject: [PATCH v2 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Topic: [PATCH v2 5/6] ASoC: Define a set of DAPM pre/post-up events
Thread-Index: AQHVKyqTBIBQWMm3EkqLR+kyuDcDbg==
Date:   Tue, 25 Jun 2019 07:49:54 +0000
Message-ID: <20190625074937.2621-6-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::40) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6672e5bf-c7e1-4735-05fe-08d6f941b60b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5352;
x-ms-traffictypediagnostic: AM6PR05MB5352:
x-microsoft-antispam-prvs: <AM6PR05MB53529F4308EFC4B5FFFE59CFF9E30@AM6PR05MB5352.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39850400004)(376002)(199004)(189003)(26005)(5660300002)(1076003)(54906003)(71190400001)(1411001)(71200400001)(2906002)(4744005)(36756003)(305945005)(86362001)(53936002)(6486002)(8676002)(478600001)(6512007)(25786009)(50226002)(14454004)(6436002)(6116002)(3846002)(7736002)(316002)(68736007)(44832011)(486006)(476003)(2616005)(66556008)(81166006)(4326008)(6916009)(256004)(66476007)(81156014)(64756008)(66446008)(8936002)(66946007)(73956011)(386003)(102836004)(6506007)(52116002)(11346002)(446003)(76176011)(99286004)(186003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5352;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zmoKYidnks2WQtSDY0VwOyWRoB89F5I0H60ctVz4NnORnDeZRkS9onWfGrRrwS/ZkN+w+B6Y1zcI2lqTV1EqNWn/H2XJ6PDIxSGrVAczs1chq/xOsXIaWQY0jhZFOIXGFHZekDUr2vgju2XW4+mrTx96d3YvZ5OEJoJgTCmPDUJX8WhQoDPZpswA8oYycFvRC51LGlXOMn/wunBJEabrObO6W45XPig7yB47eeVtZQmMaTTT6NSeCIL5VsdmClsYUWM/6ZGFrO9wAL8+etZG8c+HZzvIQE5MTmDghFGt/jgLQ22HcvPUmny1bU3zWby5hdHyb9Jk4gtj95sHhQs8xBIc6ZGewW+50W5wDmgLVhXEuJNDfkLa3D/7v2VLv+1YSQbJH5iwdQju0EP/fiw2Pbg43O5JZBFwEZbVO9z4kOM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672e5bf-c7e1-4735-05fe-08d6f941b60b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:54.3629
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

UHJlcGFyZSB0byB1c2UgU05EX1NPQ19EQVBNX1BSRV9QT1NUX1BNVSBkZWZpbml0aW9uIHRvDQpy
ZWR1Y2UgY29taW5nIGNvZGUgc2l6ZSBhbmQgbWFrZSBpdCBtb3JlIHJlYWRhYmxlLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5j
b20+DQotLS0NCg0KIGluY2x1ZGUvc291bmQvc29jLWRhcG0uaCB8IDIgKysNCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvdW5kL3NvYy1k
YXBtLmggYi9pbmNsdWRlL3NvdW5kL3NvYy1kYXBtLmgNCmluZGV4IGMwMGEwYjhhZGUwODYuLjZj
NjY5NDE2MDEzMDcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3NvdW5kL3NvYy1kYXBtLmgNCisrKyBi
L2luY2x1ZGUvc291bmQvc29jLWRhcG0uaA0KQEAgLTM1Myw2ICszNTMsOCBAQCBzdHJ1Y3QgZGV2
aWNlOw0KICNkZWZpbmUgU05EX1NPQ19EQVBNX1dJTExfUE1EICAgMHg4MCAgICAvKiBjYWxsZWQg
YXQgc3RhcnQgb2Ygc2VxdWVuY2UgKi8NCiAjZGVmaW5lIFNORF9TT0NfREFQTV9QUkVfUE9TVF9Q
TUQgXA0KIAkJCQkoU05EX1NPQ19EQVBNX1BSRV9QTUQgfCBTTkRfU09DX0RBUE1fUE9TVF9QTUQp
DQorI2RlZmluZSBTTkRfU09DX0RBUE1fUFJFX1BPU1RfUE1VIFwNCisJCQkJKFNORF9TT0NfREFQ
TV9QUkVfUE1VIHwgU05EX1NPQ19EQVBNX1BPU1RfUE1VKQ0KIA0KIC8qIGNvbnZlbmllbmNlIGV2
ZW50IHR5cGUgZGV0ZWN0aW9uICovDQogI2RlZmluZSBTTkRfU09DX0RBUE1fRVZFTlRfT04oZSkJ
XA0KLS0gDQoyLjIwLjENCg0K
