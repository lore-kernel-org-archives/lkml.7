Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D00C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="FCjkUYP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfFYHtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:49:52 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:61105
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729236AbfFYHtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1s9YIQjrFEXLpr6/0iaQWEqmYN/FBkd2qBsYzcdpxE=;
 b=FCjkUYP3RpZjxCfd/W/WQvT5Crf0X0S/CAi4E+gDdYXJpYsWoCu3Nef5J5qfy4jHXyQNGTTsaNlaMM4dPTytxdU4fKVWNWT+U7oKpi/P4rhC01k8WUrpymvbq/1All7aVbNmt/2pW9nHxMatINjw1ohyim/1+mbDE3uXKod2Spw=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB4150.eurprd05.prod.outlook.com (52.135.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 07:49:47 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:47 +0000
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
Subject: [PATCH v2 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Thread-Topic: [PATCH v2 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp
 Control
Thread-Index: AQHVKyqP9Y3ACmV7XEOmUoCTUILA2w==
Date:   Tue, 25 Jun 2019 07:49:47 +0000
Message-ID: <20190625074937.2621-2-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0081.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::22) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f1a194-789a-4bd8-ce0b-08d6f941b1a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB4150;
x-ms-traffictypediagnostic: AM6PR05MB4150:
x-microsoft-antispam-prvs: <AM6PR05MB41505FAB360F3C42AD32185DF9E30@AM6PR05MB4150.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(189003)(199004)(6436002)(86362001)(8936002)(6116002)(3846002)(186003)(6486002)(81166006)(81156014)(446003)(102836004)(6506007)(386003)(26005)(486006)(2616005)(11346002)(478600001)(44832011)(8676002)(476003)(305945005)(71190400001)(7736002)(6512007)(54906003)(2906002)(316002)(4326008)(68736007)(71200400001)(66066001)(53936002)(25786009)(50226002)(66946007)(36756003)(73956011)(64756008)(66446008)(14454004)(66556008)(1076003)(66476007)(6916009)(5660300002)(52116002)(76176011)(99286004)(256004)(14444005)(1411001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4150;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tz43gHLNDwL32L7ZqIsn8e5q6Jhow0zPPsSkt21XGKydP+IVjqzJ6upamSpydx6C7G0QWzlIjDHFInq+LiWw/e8aUKrqAe9eUbWorrqeDqZe/+I0iZYTGXeS21vkN/tH5qLFwD59I0AAbMPtvhDLc7xDqoF6g6XbM1Gmz0b/4d7o5nAufZDRj1r1OK7afcXcaKQFIKRAV1lrBkhRY9WeLJ/1H0TgzjjUjyxiTcvyOl2QtRiT33ak3+t8+6clsGm7B2AF05AEPgKFwD34uk0KYR/Mn2W07hMREkOW1CZ8PRcvznA3mIABz9t7gikSqnVzRiPOXDzw35x1zXsBgBBdjoVewPhcjUObzBXmEnDGNqviMLGbRh2YbtPv+cxG0C33v1OzBcfBviUfBmlc2KOKrmC/TrNlHFFr21osqY+rrgg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f1a194-789a-4bd8-ce0b-08d6f941b1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:47.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oleksandr.suvorov@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U0dUTDUwMDBfU01BTExfUE9QIGlzIGEgYml0IG1hc2ssIG5vdCBhIHZhbHVlLiBVc2FnZSBvZg0K
Y29ycmVjdCBkZWZpbml0aW9uIG1ha2VzIGRldmljZSBwcm9iaW5nIGNvZGUgbW9yZSBjbGVhci4N
Cg0KU2lnbmVkLW9mZi1ieTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QHRv
cmFkZXguY29tPg0KLS0tDQoNCiBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMgfCAyICstDQog
c291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5oIHwgMiArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2Nv
ZGVjcy9zZ3RsNTAwMC5jIGIvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQppbmRleCBhNmE0
NzQ4Yzk3ZjlkLi41ZTQ5NTIzZWUwYjY3IDEwMDY0NA0KLS0tIGEvc291bmQvc29jL2NvZGVjcy9z
Z3RsNTAwMC5jDQorKysgYi9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCkBAIC0xMjk2LDcg
KzEyOTYsNyBAQCBzdGF0aWMgaW50IHNndGw1MDAwX3Byb2JlKHN0cnVjdCBzbmRfc29jX2NvbXBv
bmVudCAqY29tcG9uZW50KQ0KIA0KIAkvKiBlbmFibGUgc21hbGwgcG9wLCBpbnRyb2R1Y2UgNDAw
bXMgZGVsYXkgaW4gdHVybmluZyBvZmYgKi8NCiAJc25kX3NvY19jb21wb25lbnRfdXBkYXRlX2Jp
dHMoY29tcG9uZW50LCBTR1RMNTAwMF9DSElQX1JFRl9DVFJMLA0KLQkJCQlTR1RMNTAwMF9TTUFM
TF9QT1AsIDEpOw0KKwkJCQlTR1RMNTAwMF9TTUFMTF9QT1AsIFNHVEw1MDAwX1NNQUxMX1BPUCk7
DQogDQogCS8qIGRpc2FibGUgc2hvcnQgY3V0IGRldGVjdG9yICovDQogCXNuZF9zb2NfY29tcG9u
ZW50X3dyaXRlKGNvbXBvbmVudCwgU0dUTDUwMDBfQ0hJUF9TSE9SVF9DVFJMLCAwKTsNCmRpZmYg
LS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmggYi9zb3VuZC9zb2MvY29kZWNzL3Nn
dGw1MDAwLmgNCmluZGV4IDE4Y2FlMDhiYmQzYTYuLmE0YmY0YmNhOTViZjcgMTAwNjQ0DQotLS0g
YS9zb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmgNCisrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvc2d0
bDUwMDAuaA0KQEAgLTI3Myw3ICsyNzMsNyBAQA0KICNkZWZpbmUgU0dUTDUwMDBfQklBU19DVFJM
X01BU0sJCQkweDAwMGUNCiAjZGVmaW5lIFNHVEw1MDAwX0JJQVNfQ1RSTF9TSElGVAkJMQ0KICNk
ZWZpbmUgU0dUTDUwMDBfQklBU19DVFJMX1dJRFRICQkzDQotI2RlZmluZSBTR1RMNTAwMF9TTUFM
TF9QT1AJCQkxDQorI2RlZmluZSBTR1RMNTAwMF9TTUFMTF9QT1AJCQkweDAwMDENCiANCiAvKg0K
ICAqIFNHVEw1MDAwX0NISVBfTUlDX0NUUkwNCi0tIA0KMi4yMC4xDQoNCg==
