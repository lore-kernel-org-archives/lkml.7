Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC2C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A73620659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tdIt9xu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfFYHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:50:01 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com ([40.107.14.105]:31334
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729493AbfFYHt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRYYtmonHvUYBlSVfDtQqNr2C/uSAPqA/UDX95NWOc0=;
 b=tdIt9xu7f1hdMGuCMugHWpx5ZSReOxSQjZbo+DO0pRpSkVveytxvI2CcTbkInN2nhwZmibr2Qf7TWFRLutLf9Ontms22uF8p/U3kVkAOw1jYFYB2Tq87nr8ocnWDZJgoD7i/KNF5blHERsVdC0eogqhDnDk9HccYkVm6MLqQoOQ=
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com (20.179.18.16) by
 AM6PR05MB5352.eurprd05.prod.outlook.com (20.177.197.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 07:49:53 +0000
Received: from AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397]) by AM6PR05MB6535.eurprd05.prod.outlook.com
 ([fe80::2c23:fdba:9ce4:7397%7]) with mapi id 15.20.2008.007; Tue, 25 Jun 2019
 07:49:53 +0000
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
Subject: [PATCH v2 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Topic: [PATCH v2 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Index: AQHVKyqSr5wMwMJHy0K1cP447Sh3EA==
Date:   Tue, 25 Jun 2019 07:49:52 +0000
Message-ID: <20190625074937.2621-5-oleksandr.suvorov@toradex.com>
References: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190625074937.2621-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To AM6PR05MB6535.eurprd05.prod.outlook.com
 (2603:10a6:20b:71::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3bb7b01-6c20-4153-cfed-08d6f941b52e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR05MB5352;
x-ms-traffictypediagnostic: AM6PR05MB5352:
x-microsoft-antispam-prvs: <AM6PR05MB535271CF2EEF55CE0719F169F9E30@AM6PR05MB5352.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39850400004)(376002)(199004)(189003)(26005)(5660300002)(1076003)(54906003)(71190400001)(1411001)(71200400001)(2906002)(36756003)(305945005)(86362001)(53936002)(6486002)(8676002)(478600001)(6512007)(25786009)(50226002)(14454004)(6436002)(6116002)(3846002)(7736002)(316002)(68736007)(44832011)(486006)(476003)(2616005)(66556008)(81166006)(4326008)(6916009)(256004)(66476007)(81156014)(64756008)(66446008)(8936002)(66946007)(73956011)(386003)(102836004)(6506007)(52116002)(11346002)(446003)(76176011)(99286004)(186003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB5352;H:AM6PR05MB6535.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ef6ANZ1qvLppuojL7sNZv/S8kWvL1O5Fp95SpeRnmj6Sn5WLDYOuX16l0hcZoX0dY+AjFFNP18xMa+Nm2b2gmbuhsNd5bbM6GwYPzUkxAdnIWBoiQ1SHeJ/pj3TfYENOdtNsJF8/ZOm1N3JReNJ9IUuUcRWH7BebYIfDVW/n9U3cwwFlaAHYI/65cXUh6vJ/wto8WTEhIzEaxMH11rQwhAAdFhfd70v1jSTtgSYFEt6LBCru1DC2yvnJRoG3q+uJqgAEzwvd/Pt2NuEpTrsrWWT1ynA6wzRKwAzrYeNMAugKdMhCUO5WJSt2vbUqzMPsarpxtYVBUWOaXt7yE5Y0pUg7uvhPiqJx798fKMSfdloBiEyL+kOTLKnisE7yitLVC/KWMrC2uPlm08bMJEtKpU3hJMDSQQAR9fcFr36oeUQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bb7b01-6c20-4153-cfed-08d6f941b52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:49:52.9587
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

SWYgVkREQSAhPSBWRERJTyBhbmQgYW55IG9mIHRoZW0gaXMgZ3JlYXRlciB0aGFuIDMuMVYsIGNo
YXJnZSBwdW1wDQpzb3VyY2UgY2FuIGJlIGFzc2lnbmVkIGF1dG9tYXRpY2FsbHkuDQoNClNpZ25l
ZC1vZmYtYnk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNv
bT4NCi0tLQ0KDQogc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIHwgMTQgKysrKysrKysrLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jIGIvc291bmQvc29jL2NvZGVj
cy9zZ3RsNTAwMC5jDQppbmRleCBlODEzYTM3OTEwYWY0Li5lZTFlNGJmNjEzMjI3IDEwMDY0NA0K
LS0tIGEvc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQorKysgYi9zb3VuZC9zb2MvY29kZWNz
L3NndGw1MDAwLmMNCkBAIC0xMTc0LDEyICsxMTc0LDE2IEBAIHN0YXRpYyBpbnQgc2d0bDUwMDBf
c2V0X3Bvd2VyX3JlZ3Moc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpDQogCQkJ
CQlTR1RMNTAwMF9JTlRfT1NDX0VOKTsNCiAJCS8qIEVuYWJsZSBWRERDIGNoYXJnZSBwdW1wICov
DQogCQlhbmFfcHdyIHw9IFNHVEw1MDAwX1ZERENfQ0hSR1BNUF9QT1dFUlVQOw0KLQl9IGVsc2Ug
aWYgKHZkZGlvID49IDMxMDAgJiYgdmRkYSA+PSAzMTAwKSB7DQorCX0gZWxzZSB7DQogCQlhbmFf
cHdyICY9IH5TR1RMNTAwMF9WRERDX0NIUkdQTVBfUE9XRVJVUDsNCi0JCS8qIFZEREMgdXNlIFZE
RElPIHJhaWwgKi8NCi0JCWxyZWdfY3RybCB8PSBTR1RMNTAwMF9WRERDX0FTU05fT1ZSRDsNCi0J
CWxyZWdfY3RybCB8PSBTR1RMNTAwMF9WRERDX01BTl9BU1NOX1ZERElPIDw8DQotCQkJICAgIFNH
VEw1MDAwX1ZERENfTUFOX0FTU05fU0hJRlQ7DQorCQkvKiBpZiB2ZGRpbyA9PSB2ZGRhIHRoZSBz
b3VyY2Ugb2YgY2hhcmdlIHB1bXAgc2hvdWxkIGJlDQorCQkgKiBhc3NpZ25lZCBtYW51YWxseSB0
byBWRERJTw0KKwkJICovDQorCQlpZiAodmRkaW8gPT0gdmRkYSkgew0KKwkJCWxyZWdfY3RybCB8
PSBTR1RMNTAwMF9WRERDX0FTU05fT1ZSRDsNCisJCQlscmVnX2N0cmwgfD0gU0dUTDUwMDBfVkRE
Q19NQU5fQVNTTl9WRERJTyA8PA0KKwkJCQkgICAgU0dUTDUwMDBfVkREQ19NQU5fQVNTTl9TSElG
VDsNCisJCX0NCiAJfQ0KIA0KIAlzbmRfc29jX2NvbXBvbmVudF93cml0ZShjb21wb25lbnQsIFNH
VEw1MDAwX0NISVBfTElOUkVHX0NUUkwsIGxyZWdfY3RybCk7DQotLSANCjIuMjAuMQ0KDQo=
