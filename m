Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC7C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F8E21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvYXkMLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfICBae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:30:34 -0400
Received: from mail-eopbgr50063.outbound.protection.outlook.com ([40.107.5.63]:5281
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfICBad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVvlneYlJTWB0kA6Vz1uED0YcbchO3eJjLEIE8a1E3vpf45ZjaRW97zOw04IrWJJ+855P6/ssLhV+WWQ1QTUA6ncsaPqmdtkeXFk6WfjhkVhigzktOQVyA4YsAjOnuVySzhAQrd13QEfue+Vc1ANgEUFqw8yv3P7xtfPj3iRmEsujjuoRkOkHMskXEviMA9YgA5ya4YpDwO6iW4U2lJygEC5V770vKMoXKkCxMJYGQnBdMX/PHuQVjDmirKDoP4f9TSDug0YV/BewukypmOPPHWEJI2JYmcIdZUJI5MyAcbYEfDZ4jy+zp0/eSMh1ENvWw1gznaSduu++Cu6O+pfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sLXu1hTekGFHMH77eq+mpfv4IUSEXIjcvHHtWRzrng=;
 b=L6vljOSVJFWJe+DKnlQj1NhLQjFHBS2AnsXQ3gTig2iZih0W+K74SH6ehY5hqpKYZu+P9mdL/Z1rnUnNKVTeubZTlysl78Y1SI9vvUFPaxG2m4HuTzE6dVKRmYK/SgJzZIJeRRito7vKO1fu5eF7XoevbaieNOWw4uhda9ErZFA1Q7oqI8vFmuXI/THk6OpVMb2v5lSaGHVFokXTPT3nH2i+25mXkavSNsd25sRSE/A/gb5aqXQrhWT0k1dp2ZS+j2tHJGOyicyYSjj+TQNHqUUrI3XnEzVbFDDSncs2Dk0xoW60Zuiz10w6X9j2sMIv+W/rdpWgyZPMqWd3UPaOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sLXu1hTekGFHMH77eq+mpfv4IUSEXIjcvHHtWRzrng=;
 b=cvYXkMLM4gB1xKYdY9uK3wYbAlZvx8jmnM0JL4c811MN+wM6DT5Zdo8NOa3F30UpSqkveU/nUFTJgxhl82MDgMImd2SOf4HAWhjnZ2VxNRxO7SYJ1Q5GyEAZSbBBWsJJMdVVjgzSaKr4Uo4zqZGVTDl0HbsYKy17ZZA4o+IMpgM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Tue, 3 Sep 2019 01:30:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2199.021; Tue, 3 Sep 2019
 01:30:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mn-ddr4-evk: Enable GPIO LED
Thread-Topic: [PATCH] arm64: dts: imx8mn-ddr4-evk: Enable GPIO LED
Thread-Index: AQHVYWrrg3PTEyasrEi6IvuVESLdoacY2AgAgABS8lA=
Date:   Tue, 3 Sep 2019 01:30:28 +0000
Message-ID: <DB3PR0402MB39163A67EBD2E00310973D97F5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567457138-3002-1-git-send-email-Anson.Huang@nxp.com>
 <20190902203144.GA4787@bug>
In-Reply-To: <20190902203144.GA4787@bug>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0345a1ae-cd9b-41b6-d119-08d7300e4dbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:|DB3PR0402MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3739DCB3C7F5779B7EB3B82DF5B90@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(446003)(478600001)(11346002)(186003)(4744005)(66946007)(66476007)(66556008)(81156014)(26005)(81166006)(256004)(8676002)(74316002)(6506007)(7416002)(66066001)(99286004)(5660300002)(476003)(76176011)(8936002)(52536014)(44832011)(102836004)(486006)(7696005)(14454004)(2906002)(6116002)(316002)(229853002)(33656002)(53936002)(6916009)(4326008)(9686003)(6436002)(305945005)(7736002)(71190400001)(71200400001)(3846002)(6246003)(54906003)(25786009)(76116006)(55016002)(66446008)(86362001)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VY7sL36u/UrkLyrkbgqdHqSBaMFBjdVMye7mSeYy0UKjNf499N3xBft87imFF5d6pLy6yT1kWXCBTRCD11t7VoM1eye2hyF7CYCpLvTtlJEe6qFIKKV0bDTFWsJoIj6SOm4SZbm85z7e/lgD2bFeg3/uabDfrhX2IRkayB8YfLYTZQtEGaTsmDgu8BGJH+IxWS7XsDqr75uF7ARe/nOe9ZqpA6pgtKNE5AQxyKudR4RhXnRmKAKx8lKDS7maAV7tbRxTXvvgaP4bZ09WfBKtbdcoX/oO/IByVp3eEWo4Y8dUs1190DxoHsK8qNbOKUAAK/AmBJlJ+tJfmCjHlkz/reM4MAo7annNAaUq+PA6KfKQQkeTx1o1AgzEBXLLklS2maqrKm9xX49mn7ZhNKAe60Yaewibt036qQNku5Ym4L4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0345a1ae-cd9b-41b6-d119-08d7300e4dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 01:30:28.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frrhyE+QJ/zDPGTw1zL1WgDQyJb4tyToYqvKmfDzm48fx58QuNoAosQUBNBB4NK8T1TrH0leQXXv3fZsDpk05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBhdmVsDQoNCj4gT24gTW9uIDIwMTktMDktMDIgMTY6NDU6MzgsIEFuc29uIEh1YW5nIHdy
b3RlOg0KPiA+IGkuTVg4TU4gRERSNCBFVksgYm9hcmQgaGFzIGEgR1BJTyBMRUQgdG8gaW5kaWNh
dGUgc3RhdHVzLCBhZGQgc3VwcG9ydA0KPiA+IGZvciBpdC4NCj4gDQo+IExFRCBtYWludGFpbmVy
cyB3YW50IHRvIGJlIG9uIHRoZSBjYyBsaXN0Li4uDQoNClRoZSBnZXRfbWFpbnRhaW5lci5wbCBk
b2VzIE5PVCBzaG93IHRoZSBMRUQgbWFpbnRhaW5lcnMuLi5CdXQgSSBoYXZlIGFkZGVkIGl0DQpp
biBWMi4NCg0KPiANCj4gPiBAQCAtMTUsNiArMTUsMTggQEANCj4gPiAgCQlzdGRvdXQtcGF0aCA9
ICZ1YXJ0MjsNCj4gPiAgCX07DQo+ID4NCj4gPiArCWxlZHMgew0KPiA+ICsJCWNvbXBhdGlibGUg
PSAiZ3Bpby1sZWRzIjsNCj4gPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJ
CXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvX2xlZD47DQo+ID4gKw0KPiA+ICsJCXN0YXR1cyB7
DQo+ID4gKwkJCWxhYmVsID0gInN0YXR1cyI7DQo+ID4gKwkJCWdwaW9zID0gPCZncGlvMyAxNiBH
UElPX0FDVElWRV9ISUdIPjsNCj4gPiArCQkJZGVmYXVsdC1zdGF0ZSA9ICJvbiI7DQo+ID4gKwkJ
fTsNCj4gDQo+IEFuZCB3ZSBzaG91bGQgcmVhbGx5IHN0YW5kYXJkaXplIGxhYmVscyBmb3IgdXNl
ci1jb250cm9sbGVkIHN0YXR1cyBMRURzLg0KPiBNZW50aW9uaW5nIGNvbG9yIHdvdWxkIGJlIG5p
Y2UsIGZvciBhIHN0YXJ0Lg0KDQpPSywgSSBjaGFuZ2UgdGhlIGxhYmVsIHRvICJ5ZWxsb3c6c3Rh
dHVzIiBpbiBWMiwgcGxlYXNlIGhlbHAgcmV2aWV3LCB0aGFua3MuDQoNCkFuc29uDQoNCg==
