Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487CEC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D35E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sma.de header.i=@sma.de header.b="Qk2J4PYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfFRLHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:07:45 -0400
Received: from mail-eopbgr140131.outbound.protection.outlook.com ([40.107.14.131]:28322
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729471AbfFRLHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sma.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZgUGLX+mVY01DJhWFIEGjDMyfoInk/K6yNSjb4TF08=;
 b=Qk2J4PYpH4fg+Sp5uG0n7UOKXWsPCURBRooTecyMKZ4kfYAttnDACUc5tuQwGagE8vVu4AQibbXUv59X575V+qlArTPgmkddEz9LfKGc/mr8tXMuDCFDwRYNNf+G2jlbYBXML6uBlisJAzOI8xn5yo8OnGuOrnaDyvGYqb5nFr4=
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com (20.178.114.156) by
 AM0PR04MB4321.eurprd04.prod.outlook.com (52.134.126.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 11:07:41 +0000
Received: from AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::542a:ddc6:d453:1cbf]) by AM0PR04MB5427.eurprd04.prod.outlook.com
 ([fe80::542a:ddc6:d453:1cbf%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 11:07:40 +0000
From:   Felix Riemann <Felix.Riemann@sma.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: AW: [PATCH] regulator: da9062: Adjust LDO voltage selection minimum
 value
Thread-Topic: [PATCH] regulator: da9062: Adjust LDO voltage selection minimum
 value
Thread-Index: AQHVIegnySQaEkg2rkmYypP32O58i6aZmuWwgAesEDA=
Date:   Tue, 18 Jun 2019 11:07:40 +0000
Message-ID: <AM0PR04MB54276B6CFB2F8188A5AAA10C88EA0@AM0PR04MB5427.eurprd04.prod.outlook.com>
References: <20190613130058.10480-1-felix.riemann@sma.de>
 <AM6PR10MB2181F17B2265BEE8EB80EC21FEEF0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB2181F17B2265BEE8EB80EC21FEEF0@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Riemann@sma.de; 
x-originating-ip: [62.157.91.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa925b69-9ba9-4e20-8e5e-08d6f3dd2e51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR04MB4321;
x-ms-traffictypediagnostic: AM0PR04MB4321:
x-microsoft-antispam-prvs: <AM0PR04MB4321B8C52467EC2B5E263D1888EA0@AM0PR04MB4321.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(73956011)(7736002)(99286004)(26005)(476003)(486006)(66946007)(76116006)(6436002)(9686003)(54906003)(446003)(11346002)(478600001)(86362001)(305945005)(66556008)(66476007)(52536014)(64756008)(53936002)(102836004)(7696005)(110136005)(55016002)(5660300002)(186003)(14454004)(76176011)(8936002)(66446008)(2501003)(316002)(72206003)(6506007)(81166006)(71200400001)(256004)(53546011)(66066001)(81156014)(8676002)(71190400001)(74482002)(74316002)(3846002)(4326008)(25786009)(75402003)(6116002)(33656002)(2906002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR04MB4321;H:AM0PR04MB5427.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sma.de does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3GTlubUBGWucj9S9x3KAymQc1dS5xnvOrDkG+dxP5LqNq3To2RF/HRCwzzSMOuFJ0JAZ/CrFJs5/Pe3KmOVvov22r6TxTthXIOhwEop6nx6HotPzLHADPtc6I00KT0f3bH+C79OL4TqwXaFnyZZFYUChur0LMx4eKlTElqyb5E/j/4H5h9J6uk3NzWDA250F9bqNZZtSQsAANjkZ7DBceQc47+zrhtbs90O+wtNNMB7wVLVzgFdcHzHhniz8pcdXTsOwa87Xt55okpFpdMp3P9WZZnGOtfpFrVc/Res3OXUdC/nmo95yz9mkX/mYsfLVhM32ZHIgP6UxoKwsFne/UmgLD2rBmdFrCYbVlgsgR/WHIjwLhlXjuHpdQiD6WpyHgsm66afq4lioJ1mRhtfaNHtR7RNWMAB6AGdY/cTDeds=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sma.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa925b69-9ba9-4e20-8e5e-08d6f3dd2e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 11:07:40.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a059b96c-2829-4d11-8837-4cc1ff84735d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riemann@SMA.DE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RldmUsDQoNCkEgY29sbGVhZ3VlIHRvbGQgbWUgdGhhdCBoZSBzYXcgb3VyIG1haWwgc2Vy
dmVyIG1peC11cCB3aGl0ZXNwYWNlcyBpbiB0ZXh0IG1haWxzIGJlZm9yZSwgYWx0aG91Z2ggdGhl
IGNvcHkgdGhhdCBnb3QgcmVsYXllZCBiYWNrIHRvIG1lIGxvb2tzIG9rYXkuIElzIHRoZSBwYXRj
aCB1c2FibGUgb3Igc2hvdWxkIEkgdHJ5IHRvIHJlc2VuZCBpdCB0aHJvdWdoIGFub3RoZXIgc2Vy
dmVyPw0KDQpSZWdhcmRzLA0KRmVsaXgNCg0KLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQt
LS0tLQ0KVm9uOiBTdGV2ZSBUd2lzcyA8c3R3aXNzLm9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQpH
ZXNlbmRldDogRG9ubmVyc3RhZywgMTMuIEp1bmkgMjAxOSAxNjowMA0KQW46IEZlbGl4IFJpZW1h
bm4gPEZlbGl4LlJpZW1hbm5Ac21hLmRlPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
Q2M6IGxlZS5qb25lc0BsaW5hcm8ub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxnaXJkd29vZEBn
bWFpbC5jb207IFN1cHBvcnQgT3BlbnNvdXJjZSA8U3VwcG9ydC5PcGVuc291cmNlQGRpYXNlbWku
Y29tPg0KQmV0cmVmZjogUkU6IFtQQVRDSF0gcmVndWxhdG9yOiBkYTkwNjI6IEFkanVzdCBMRE8g
dm9sdGFnZSBzZWxlY3Rpb24gbWluaW11bSB2YWx1ZQ0KDQpIaSBGZWxpeCwNCg0KT24gMTMgSnVu
ZSAyMDE5IDE0OjAyLCBGZWxpeCBSaWVtYW5uIHdyb3RlOg0KDQo+IFN1YmplY3Q6IFtQQVRDSF0g
cmVndWxhdG9yOiBkYTkwNjI6IEFkanVzdCBMRE8gdm9sdGFnZSBzZWxlY3Rpb24NCj4gbWluaW11
bSB2YWx1ZQ0KPg0KPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCB0aGUgTERPJ3Mgdm9sdGFn
ZSBzZWxlY3Rpb24gcmVnaXN0ZXJzIGhhdmUNCj4gYSBtaW5pbXVtIHZhbHVlIG9mIDB4Mi4gVGhp
cyBvZmZzZXQgd2FzIG5vdCBvYnNlcnZlZCBieSB0aGUgZHJpdmVyLA0KPiBjYXVzaW5nIHRoZSBM
RE8gb3V0cHV0IGJlaW5nIHR3byBzdGVwcyAoPSAwLjFWKSBsb3dlciB0aGFuIHJlcXVlc3RlZC4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggUmllbWFubiA8ZmVsaXgucmllbWFubkBzbWEuZGU+
DQoNClVoLg0KDQpUaGF0IGxvb2tzIHJpZ2h0LiBCdXQgSSB3YW50IHRvIHRha2UgYSBjbG9zZXIg
bG9vayB0b21vcnJvdyBhbG9uZyB3aXRoIG15IHRlc3RzLCB3aGljaCBtdXN0IHBhc3MgdGhpcyBi
ZWhhdmlvdXIuDQoNCkdpdmUgbWUgYSBkYXkgb3IgdHdvIHBsZWFzZS4NCg0KUmVnYXJkcywNClN0
ZXZlDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQoNClNNQSBTb2xhciBUZWNobm9sb2d5IEFHDQpBdWZzaWNodHNyYXQ6IERyLiBFcmlrIEVo
cmVudHJhdXQgKFZvcnNpdHplbmRlcikNClZvcnN0YW5kOiBVbHJpY2ggSGFkZGluZywgRHIuLUlu
Zy4gSnVlcmdlbiBSZWluZXJ0DQpIYW5kZWxzcmVnaXN0ZXI6IEFtdHNnZXJpY2h0IEthc3NlbCBI
UkIgMzk3Mg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiAzNDI2NiBOaWVzdGV0YWwNClVTdC1JRC1O
ci4gREUgMTEzIDA4IDU5IDU0DQpXRUVFLVJlZy4tTnIuIERFIDk1ODgxMTUwDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg==
