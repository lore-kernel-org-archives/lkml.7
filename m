Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874DC32759
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D1206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kDeKxJma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfHOHzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:55:48 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:18855
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfHOHzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIRzvtR+vkic7ItxZQeiPsmuHT8tLR2zUX0mvbc4B8nSffmaVYk1cbwt9NLvJ9rOXLtBQZM81tJGjJQhQ43EVnEdJSaJE7BFwoBswDiGDkEi3YOYcAg/DA97Gw7hdW5vqPWiaQHXWC9AS5Vk3Xh5G81FzT8NDYsQb0CGEFxEyTQUmLlHOT2wPvzOG+NYrVDxc+xP68lXeIWWCF7z2QUcE+35TCi74cTEeQV6n5YLf2DUS20DwD1OQDa0T1FYgFRB4PbynFRpws9vnXMl1yIczMKPwXhPJDabIHeIg5DbDe41g11t2FY8Xyf39NqJJtTphKF+hkOL/9c7r+drSQS3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svE1OLS8Z8Pte5T/2AGHzl5MKhKZonv/bSRijTuT4qk=;
 b=VCVeZlh+nl+5w5xF8bPUjvw4aHw4zt+7XGFT7nQRIukgZMFaRB8abi3PLA3zzjWAYmMunMlJdMiWg1xkXT/DBlzJcxaqT92KCm9pYz7t+/cw+gQGT23KqBOoW/0uCikp8AyQScauGpIMA5aDlRE9U+eYarqgieTpP/F+Bq869JW9sIDLmV2BpsKypHr6qIkDl1T6UKwYpMER62ReD6ukr6D+WN9E97B6LGpcqD4+HTcDbiYLoWkIfxBiatIAkjxrIYkmM6n1cf4pEXHiaSdUaowCllMeLlMt7NYD492/VfXBuI3v0DcnLoj5fqJGShFCPxHwur1I2aIOy2/JaiGdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svE1OLS8Z8Pte5T/2AGHzl5MKhKZonv/bSRijTuT4qk=;
 b=kDeKxJmaqwyZQxQ4iXCwt/b0l8h5G9aZTa03+xbHWF82vOVMtdtjfkl0sRSNt4KjoCFOHpK5UbZPUzxTmeT5QKuvWYdEsZ4bDztZrJXCbIOiGcvuOz2LkC18oXj/9phCk+9/RayYW/6k/mefo0G4WPWsXQpSwpo9mGN9k2b+ois=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB6237.eurprd05.prod.outlook.com (20.178.124.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 07:55:41 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 07:55:41 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 15/21] ARM: dts: imx6ull-colibri: reduce v_batt current
 in power off
Thread-Topic: [PATCH v4 15/21] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVUz3b4dDICZhooUyFMTSvItqHdg==
Date:   Thu, 15 Aug 2019 07:55:40 +0000
Message-ID: <CAGgjyvHSdFCZOsc+QRFwDRn2w1+oxwXgoAM3fF-Wcqgt6spKFA@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-16-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-16-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To VI1PR05MB6544.eurprd05.prod.outlook.com (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAXB7whwqWUDWr7/+87HCL9pcnLjUyTM/dYCTd67Mwm8R7DSJtVu
        GfDNAPWkntaEzXZSJxARHW8Q+1MNq3NrO1ofiBQ=
x-google-smtp-source: APXvYqw6uTKq7qbmt+Jco9TYFKCTCkllA65ZHuwMsE1yhT6eOr/bX5jDAoOgO6ejXDGoQaXVccdbts3/o9KLMBZHfUw=
x-received: by 2002:aa7:c899:: with SMTP id p25mr3904868eds.41.1565855333367;
 Thu, 15 Aug 2019 00:48:53 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvHSdFCZOsc+QRFwDRn2w1+oxwXgoAM3fF-Wcqgt6spKFA@mail.gmail.com>
x-originating-ip: [209.85.208.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c00bceb-1233-4064-552a-08d72155f7b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6237;
x-ms-traffictypediagnostic: VI1PR05MB6237:
x-microsoft-antispam-prvs: <VI1PR05MB623724B779128997DCF351B3F9AC0@VI1PR05MB6237.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39840400004)(366004)(396003)(346002)(136003)(199004)(189003)(5660300002)(81156014)(81166006)(8936002)(8676002)(229853002)(61726006)(14454004)(6636002)(26005)(86362001)(99286004)(186003)(54906003)(55446002)(53546011)(386003)(6506007)(478600001)(95326003)(102836004)(52116002)(76176011)(44832011)(446003)(11346002)(486006)(476003)(316002)(498394004)(25786009)(450100002)(4326008)(6436002)(256004)(6116002)(6512007)(9686003)(2906002)(3846002)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(6862004)(107886003)(53936002)(6486002)(61266001)(305945005)(7736002)(71200400001)(71190400001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6237;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JN2udrjafKPX/4tqBEz9QGprk7Kn78YJ+MQ/PpV33QiMxwSZeXOF81E9SdneSPNrwF4vTtShsG+oYWN2eiceG/YA4q5MvH9rJlGWm+HvxjywUI2j+Ul5wenXODj3wEbpBj0ZZY28kD1tk6Xzv5OhwtCMaZHXO//fniJnlITUr2Mr7dqQZHazdIse9EPOpsND3/PKe4PCEFGU41pRwsgVDWEsLl7ZeKC9p31A2bFX6nx8geyOgRgjVvWWo5F/az0sVOdVCKrFwby6Ez3KdLe+H7YZg2gASRWTwwKwQIRjRXoIVOtc30il62BhOmfq18eIeJFLm+CGtt+2aGuPPQZKBJ5QedAAEhajUu/NEbfXVZxPhIBtHY3vV+1XnF0Z08JtlKMP5XaazkR0pexIHYdlHHMvgCOUzQQCFOLTGblqbCo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8650092DA6EE4F9EF38209F776D038@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c00bceb-1233-4064-552a-08d72155f7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 07:55:40.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XT7+WnT32nOvL/utPulwfeWPmw0GMxEXulM+wY+1fpOuMVIG4wxsseDMxXzaZovNcGqqwAkR7ZwOvurrr+yVq/C5xVo2AAG2XsIYGd1f6GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyNCBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gRnJvbTogTWF4IEtydW1tZW5h
Y2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT4NCj4NCj4gUmVkdWNlIHRoZSBjdXJy
ZW50IGRyYXduIGZyb20gVkNDX0JBVFQgd2hlbiB0aGUgbWFpbiBwb3dlciBvbiB0aGUgM1YzDQo+
IHBpbnMgdG8gdGhlIG1vZHVsZSBhcmUgc3dpdGNoZWQgb2ZmLg0KPg0KPiBUaGlzIHN3aXRjaGVz
IG9mZiBTb0MgaW50ZXJuYWwgcHVsbCByZXNpc3RvcnMgd2hpY2ggYXJlIHByb3ZpZGVkIG9uIHRo
ZQ0KPiBtb2R1bGUgZm9yIFRBTVBFUjcgYW5kIFRBTVBFUjkgU29DIHBpbiBhbmQgc3dpdGNoZXMg
b24gYSBwdWxsIGRvd24NCj4gaW5zdGVhZCBvZiBhIHB1bGx1cCBmb3IgdGhlIFVTQkNfREVUIG1v
ZHVsZSBwaW4gKFRBTVBFUjIpLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggS3J1bW1lbmFjaGVy
IDxtYXgua3J1bW1lbmFjaGVyQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+IEFja2VkLWJ5OiBN
YXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3JvdkB0b3JhZGV4LmNvbT4NCg0K
Pg0KPiAtLS0NCj4NCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3Mg
QWNrDQo+DQo+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPg0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kgfCA2ICsrKy0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gaW5kZXggMTAxOWNlNjlhMjQyLi4x
ZjExMmVjNTVlNWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNp
DQo+IEBAIC01MzMsMTkgKzUzMywxOSBAQA0KPg0KPiAgICAgICAgIHBpbmN0cmxfc252c19hZDc4
NzlfaW50OiBzbnZzLWFkNzg3OS1pbnQtZ3JwIHsgLyogVE9VQ0ggSW50ZXJydXB0ICovDQo+ICAg
ICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgTVg2
VUxMX1BBRF9TTlZTX1RBTVBFUjdfX0dQSU81X0lPMDcgICAgIDB4MWIwYjANCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgTVg2VUxMX1BBRF9TTlZTX1RBTVBFUjdfX0dQSU81X0lPMDcgICAgIDB4
MTAwYjANCj4gICAgICAgICAgICAgICAgID47DQo+ICAgICAgICAgfTsNCj4NCj4gICAgICAgICBw
aW5jdHJsX3NudnNfcmVnX3NkOiBzbnZzLXJlZy1zZC1ncnAgew0KPiAgICAgICAgICAgICAgICAg
ZnNsLHBpbnMgPSA8DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIE1YNlVMTF9QQURfU05WU19U
QU1QRVI5X19HUElPNV9JTzA5ICAgICAweDQwMDFiOGIwDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIE1YNlVMTF9QQURfU05WU19UQU1QRVI5X19HUElPNV9JTzA5ICAgICAweDQwMDEwMGIwDQo+
ICAgICAgICAgICAgICAgICA+Ow0KPiAgICAgICAgIH07DQo+DQo+ICAgICAgICAgcGluY3RybF9z
bnZzX3VzYmNfZGV0OiBzbnZzLXVzYmMtZGV0LWdycCB7DQo+ICAgICAgICAgICAgICAgICBmc2ws
cGlucyA9IDwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgTVg2VUxMX1BBRF9TTlZTX1RBTVBF
UjJfX0dQSU81X0lPMDIgICAgIDB4MWIwYjANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg2
VUxMX1BBRF9TTlZTX1RBTVBFUjJfX0dQSU81X0lPMDIgICAgIDB4MTMwYjANCj4gICAgICAgICAg
ICAgICAgID47DQo+ICAgICAgICAgfTsNCj4NCj4gLS0NCj4gMi4yMi4wDQo+DQoNCg0KLS0NCkJl
c3QgcmVnYXJkcw0KT2xla3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJh
c3NlIDUgfCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0
ODAwIChtYWluIGxpbmUpDQo=
