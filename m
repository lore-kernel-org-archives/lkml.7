Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A213FC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vLg5izCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCRKIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:08:10 -0400
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:47781
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbfCRKII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZojZbAKiy9FpuY1dimnac767H/pQuxDX4/JCNH+n20=;
 b=vLg5izCsEJbXyb+YlQGcqpmYkA8UxCGfQgSesxKMJ61shhg6bzYuVTmKwRaQqpdhyusUeT16QEZO2gpB2+vxnyJCxObHpmjRDlx++i41lvnoJqdyyB1Zmrgay/Sdo1BxGZfHoVgIdMGuvG7wR4SsS6NKkIfGtm8hvuxlAM0vXb8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 10:08:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 10:08:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2siU0bWGOMWkiUi6PBGed50RsKYMb0wAgARM6KCAAFGOgIAAHj9g
Date:   Mon, 18 Mar 2019 10:08:01 +0000
Message-ID: <DB3PR0402MB391627A8C741C84A2057E576F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
 <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
 <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190318080743.xumj6e72bzumszvp@pengutronix.de>
In-Reply-To: <20190318080743.xumj6e72bzumszvp@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a10fb3-5f3c-4415-261a-08d6ab899abc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3754C5700D7C1AC0FBC2F0F2F5470@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(136003)(39860400002)(346002)(396003)(13464003)(189003)(199004)(105586002)(7736002)(106356001)(71190400001)(71200400001)(305945005)(7416002)(966005)(476003)(74316002)(316002)(33656002)(9686003)(6306002)(55016002)(229853002)(14454004)(52536014)(6436002)(53936002)(54906003)(446003)(6346003)(11346002)(2906002)(93886005)(81156014)(8676002)(81166006)(8936002)(5660300002)(97736004)(53546011)(68736007)(102836004)(6506007)(66066001)(4326008)(186003)(45080400002)(3846002)(6116002)(478600001)(6246003)(256004)(76176011)(14444005)(26005)(99286004)(7696005)(486006)(44832011)(66574012)(25786009)(86362001)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rETmMLHvzr1rQr90DAu8GpcIioJrc7sNQUyvr1t8oFkvVHPxMwYq6mSMPkqo1sWec7CNXCCTTB2oQxyKO6U6UxbfV1rYmLu0J2WVryXYk406q3FTH9I5RdVlMZJ76iCJOlzdCXkP8rAOXzi0kRiVzSxfup90oEqmH2VgI2U8zbS0mEw678THQI8OegGk/xIi/7NYzYo7OtHKLtPWYBHOZWaXna3CmZGyvPExQQlKLGhwfMH6tTOcdNzqGYDfJmOpSZKKKr+6AuQ22yOX5u9OzGkeHCBQomiNAA+JxFcsGKX8ozCXGDBiq6b5YjXcvbRvtZfYOYWLfKBwwXaGqb/lPc1IUhf1Roteu/qZy5zUGQ2fljIZa2TVVmddtMtyP5DsATzq5RnDsUdHBceHeeti7Ayi0L/G2tWFxEyTiCNIR6A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a10fb3-5f3c-4415-261a-08d6ab899abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 10:08:01.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIFttYWlsdG86dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE55bm0M+aciDE45pelIDE2OjA4DQo+
IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHRoaWVycnkucmVk
aW5nQGdtYWlsLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsN
Cj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsgb3RhdmlvQG9zc3lzdGVtcy5jb20uYnI7DQo+IHN0ZWZhbkBhZ25lci5jaDsgTGVvbmFyZCBD
cmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47DQo+IHNjaG5pdHplbHRvbnlAZ21haWwu
Y29tOyBqYW4udHVlcmtAZW10cmlvbi5jb207IFJvYmluIEdvbmcNCj4gPHlpYmluLmdvbmdAbnhw
LmNvbT47IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvNV0gcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGRyaXZl
ciBzdXBwb3J0DQo+IA0KPiBPbiBNb24sIE1hciAxOCwgMjAxOSBhdCAwNzo0MTowMkFNICswMDAw
LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBIaSxVd2UNCj4gPiA+ID4gKwl2YWwgJj0gflBXTV9J
TVhfVFBNX1NDX0NNT0Q7DQo+ID4gPiA+ICsJd3JpdGVsKHZhbCwgdHBtLT5iYXNlICsgUFdNX0lN
WF9UUE1fU0MpOw0KPiA+ID4NCj4gPiA+IEFzIHRoaXMgaW50ZXJydXB0cyB0aGUgb3V0cHV0LCBw
bGVhc2Ugb25seSBkbyBpdCBpZiBuZWNlc3NhcnkuDQo+ID4NCj4gPiBPSywgd2lsbCBkbyBpdCBP
TkxZIHdoZW4gaXQgaXMgZW5hYmxlZCBwcmV2aW91c2x5Lg0KPiANCj4gSSB0aGluayB5b3Ugb25s
eSBuZWVkIHRvIGRvIHRoYXQgd2hlbiB0aGUgdmFsdWUgYWN0dWFsbHkgY2hhbmdlcy4NCg0KT0ss
IEkgd2lsbCBzYXZlIHRoZSBwZXJpb2QvZGl2IGNvdW50IGFuZCBPTkxZIGRvIGl0IHdoZW4gdGhl
IHZhbHVlIGFjdHVhbGx5IGNoYW5nZXMuDQoNCj4gDQo+ID4gPiA+ICsJLyogc2V0IGR1dHkgY291
bnRlciAqLw0KPiA+ID4gPiArCXRtcCA9IHJlYWRsKHRwbS0+YmFzZSArIFBXTV9JTVhfVFBNX01P
RCkgJg0KPiA+ID4gPiArUFdNX0lNWF9UUE1fTU9EX01PRF9NQVNLOw0KPiA+ID4NCj4gPiA+IEkg
cmVjb21tZW5kIHN0b3JpbmcgdGhpcyB2YWx1ZSBpbiBkcml2ZXIgZGF0YS4NCj4gPg0KPiA+IE5P
VCBxdWl0ZSB1bmRlcnN0YW5kLCBhcyB3ZSBkaWQgTk9UIHVzZSBpdCBpbiBvdGhlciBwbGFjZXMg
ZXhjZXB0IHRoZQ0KPiA+IGdldF9zdGF0ZSwganVzdCByZWFkaW5nIHRoZSByZWdpc3RlciBvbmNl
IHNob3VsZCBiZSBPSyB0aGVyZS4NCj4gDQo+IEkgaGFkIHRoZSBpbXByZXNzaW9uIGl0IGlzIHVz
ZWQgbW9yZSB0aGFuIG9uY2UuIFdpbGwgbG9vayBhZ2FpbiBpbiB0aGUgbmV4dA0KPiBpdGVyYXRp
b24uIEJ1dCBhbHNvIG5vdGUgdGhhdCBzaGFkb3dpbmcgdGhlIHZhbHVlIG1pZ2h0IGFscmVhZHkg
YmUgYmVuZWZpY2lhbA0KPiBmb3IgYSBzaW5nbGUgY2FsbCBzaXRlIGFzIGRyaXZlciBkYXRhIG1p
Z2h0IG9jY3VweSBtb3JlIFJBTSB0aGFuIG5lY2Vzc2FyeQ0KPiBhbnlob3cgYW5kIHJlYWRpbmcg
ZnJvbSBSQU0gaXMgZmFzdGVyIHRoYW4gZnJvbSB0aGUgaGFyZHdhcmUncyByZWdpc3Rlci4NCj4g
UHJvYmFibHkgdGhpcyBpcyBub3QgYSBmYXN0IHBhdGgsIHNvIG5vdCB3b3J0aCB0aGUgb3B0aW1p
c2F0aW9uPyENCg0KT0ssIHdpbGwgc2F2ZSBpdCBpbiBkcml2ZXIgZGF0YSBhbmQgYXZvaWQgYWNj
ZXNzaW5nIHJlZ2lzdGVyIGFnYWluLg0KDQo+IA0KPiA+ID4gSSB3b25kZXIgd2h5IE1TQSBhbmQg
TVNCIGFyZSB0d28gYml0cyBpbnN0ZWFkIG9mIG1ha2luZyB0aGlzIGEgZmllbGQNCj4gPiA+IG9m
IHdpZHRoIDIgd2l0aCAyYjEwIG1lYW5pbmcgUFdNIG1vZGUuIEJ1dCBtYXliZSBpdCdzIGp1c3Qg
bWUgbm90DQo+ID4gPiB1bmRlcnN0YW5kaW5nIHRoZSBpbmRlcGVuZGVudCBzZW1hbnRpYyBvZiB0
aGVzZSB0d28gYml0cz8NCj4gPg0KPiA+IEkgdGhpbmsgbWFraW5nIHRoZW0gYSBmaWVsZCBtYWtl
cyBtb3JlIHNlbnNlLCBidXQgYW55d2F5IHdlIGp1c3QNCj4gPiBmb2xsb3cgdGhlIFJNLg0KPiAN
Cj4gSWYgaXQgbWFrZXMgdGhlIGRyaXZlciBlYXNpZXIgdG8gdW5kZXJzdGFuZCAod2hpY2ggSSB0
aGluayBpdCBkb2VzKSBmZWVsIGZyZWUgdG8NCj4gZGVyaXZhdGUgZnJvbSB0aGUgUk0uIEp1c3Qg
YWRkIGEgY29tbWVudCB0byB0aGUgZGVmaW5pdGlvbiwgdGhlbiBpdCdzIGZpbmUuDQoNCk9LLCBJ
IHdpbGwgY2hhbmdlIHRoZSByZWdpc3RlciBkZWZpbml0aW9uIGFuZCBhIGNvbW1lbnQgZm9yIGl0
Lg0KDQo+IA0KPiA+ID4gUmVhZGluZyB0aGUgcmVmZXJlbmNlIG1hbnVhbCBJJ2Qgc2F5IGluIFBX
TSBtb2RlIHRoZSBzZW1hbnRpYyBvZg0KPiA+ID4gRUxTQSBhbmQgRUxTQiBpczoNCj4gPiA+DQo+
ID4gPiAJT24gY291bnRlciByZWxvYWQgc2V0IHRoZSBvdXRwdXQgdG8gRUxTQg0KPiA+ID4gCU9u
IGNvdW50ZXIgbWF0Y2ggc2V0IHRoZSBvdXRwdXQgdG8gRUxTQQ0KPiA+ID4NCj4gPiA+IE5vdGlu
ZyB0aGF0IGluIGEgY29tbWVudCB3b3VsZCBlYXNlIHVuZGVyc3RhbmRpbmcgdGhlIGNvZGUgaGVy
ZS4NCj4gPg0KPiA+IEkgYWRkZWQgYmVsb3cgY29tbWVudCBmb3IgUFdNIG1vZGVzOg0KPiA+DQo+
ID4gMTM3ICAgICAgICAgLyoNCj4gPiAxMzggICAgICAgICAgKiBzZXQgcG9sYXJpdHkgKGZvciBl
ZGdlLWFsaWduZWQgUFdNIG1vZGVzKQ0KPiA+IDEzOSAgICAgICAgICAqDQo+ID4gMTQwICAgICAg
ICAgICogQ1BXTVMgIE1TQjpNU0EgIEVMU0I6RUxTQSAgTW9kZSAgQ29uZmlndXJhdGlvbg0KPiA+
IDE0MSAgICAgICAgICAqIDAgICAgICAxMCAgICAgICAxMCAgICAgICAgIFBXTSAgIEhpZ2gtdHJ1
ZSBwdWxzZQ0KPiA+IDE0MiAgICAgICAgICAqIDAgICAgICAxMCAgICAgICAwMCAgICAgICAgIFBX
TSAgIFJlc2VydmVkDQo+ID4gMTQzICAgICAgICAgICogMCAgICAgIDEwICAgICAgIDAxICAgICAg
ICAgUFdNICAgTG93LXRydWUgcHVsc2UNCj4gPiAxNDQgICAgICAgICAgKiAwICAgICAgMTAgICAg
ICAgMTEgICAgICAgICBQV00gICBSZXNlcnZlZA0KPiA+IDE0NSAgICAgICAgICAqDQo+ID4gMTQ2
ICAgICAgICAgICogSGlnaC10cnVlIHB1bHNlOiBjbGVhciBvdXRwdXQgb24gY291bnRlciBtYXRj
aCwgc2V0IG91dHB1dCBvbg0KPiA+IDE0NyAgICAgICAgICAqIGNvdW50ZXIgcmVsb2FkLCBzZXQg
b3V0cHV0IHdoZW4gY291bnRlciBmaXJzdCBlbmFibGVkIG9yIHBhdXNlZC4NCj4gPiAxNDggICAg
ICAgICAgKg0KPiA+IDE0OSAgICAgICAgICAqIExvdy10cnVlIHB1bHNlOiBzZXQgb3V0cHV0IG9u
IGNvdW50ZXIgbWF0Y2gsIGNsZWFyIG91dHB1dCBvbg0KPiA+IDE1MCAgICAgICAgICAqIGNvdW50
ZXIgcmVsb2FkLCBjbGVhciBvdXRwdXQgd2hlbiBjb3VudGVyIGZpcnN0IGVuYWJsZWQgb3INCj4g
cGF1c2VkLg0KPiA+IDE1MSAgICAgICAgICAqLw0KPiANCj4gSSBzdHVtYmxlZCBvdmVyICJoaWdo
LXRydWUiIGFuZCAibG93LXRydWUiIGluIHRoZSBSTSwgdG9vLiBJbiBteSBidWJibGUgdGhpcw0K
PiBpcyBhbiB1bmNvbW1vbiB3b3JkaW5nLiBJJ2Qgd3JpdGUgaW5zdGVhZDoNCj4gDQo+IAkvKg0K
PiAJICogc2V0IHBvbGFyaXR5DQo+IAkgKg0KPiAJICogRUxTQjpFTFNBID0gMmIxMCB5aWVsZHMg
bm9ybWFsIHBvbGFyaXR5IGJlaGF2aW91ciwgRUxTQjpFTFNBDQo+IAkgKiA9IDJiMDEgeWllbGRz
IGludmVyc2VkIHBvbGFyaXR5LiBUaGUgb3RoZXIgdmFsdWVzIGFyZQ0KPiAJICogcmVzZXJ2ZWQu
DQo+IAkgKi8NCj4gDQo+IEFuZCBkb24ndCB3cml0ZSBhYm91dCBDUFdNLCBNU0EgYW5kIE1TQiB3
aGljaCBhcmUgYWx3YXlzIHVzZWQgd2l0aA0KPiBmaXhlZCB2YWx1ZXMgYW55aG93IGluIHRoZSBk
cml2ZXIuDQo+IA0KDQpPSy4NCg0KPiA+ID4gPiArCQkvKiBkaXNhYmxlIGNoYW5uZWwgKi8NCj4g
PiA+ID4gKwkJd3JpdGVsKFBXTV9JTVhfVFBNX0NuU0NfQ0hGLA0KPiA+ID4gPiArCQkJdHBtLT5i
YXNlICsgUFdNX0lNWF9UUE1fQ25TQyhwd20tPmh3cHdtKSk7DQo+ID4gPg0KPiA+ID4gQ2xlYXJp
bmcgQ0hGIGRvZW5zJ3QgZGlzYWJsZSB0aGUgY2hhbm5lbCBhcyBJIHJlYWQgdGhlIG1hbnVhbC4N
Cj4gPg0KPiA+IFRoaXMgd3JpdGUgY2xlYXJzIENIRiBhcyB3ZWxsIGFzIHdyaXRpbmcgb3RoZXIg
Yml0cyAwLCB0byBkaXNhYmxlIHRoZQ0KPiA+IG91dHB1dC4gTWF5YmUgSSBjYW4gZXhwbGljaXRs
eSBjbGVhciBNU0EvTVNCL0VMU0EvRUxTQiB0byBhdm9pZA0KPiBjb25mdXNpb24uDQo+IA0KPiBB
aCwgSSBtaXNpbnRlcnByZXRlZCB0aGUgdmFsdWUgd3JpdHRlbi4NCj4gDQo+ID4gPiA+ICtzdGF0
aWMgaW50IHB3bV9pbXhfdHBtX2FwcGx5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0DQo+
IHB3bV9kZXZpY2UgKnB3bSwNCj4gPiA+ID4gKwkJCSAgICAgc3RydWN0IHB3bV9zdGF0ZSAqc3Rh
dGUpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IGlteF90cG1fcHdtX2NoaXAgKnRwbSA9
IHRvX2lteF90cG1fcHdtX2NoaXAoY2hpcCk7DQo+ID4gPiA+ICsJc3RydWN0IHB3bV9zdGF0ZSBj
dXJzdGF0ZTsNCj4gPiA+ID4gKwl1MzIgZHV0eV9jeWNsZSA9IHN0YXRlLT5kdXR5X2N5Y2xlOw0K
PiA+ID4gPiArCWludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlwd21faW14X3RwbV9nZXRf
c3RhdGUoY2hpcCwgcHdtLCAmY3Vyc3RhdGUpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbXV0ZXhf
bG9jaygmdHBtLT5sb2NrKTsNCj4gPiA+DQo+ID4gPiBXaGF0IHNob3VsZCB0aGlzIGxvY2sgcHJv
dGVjdD8gRG9lcyBpdCBodXJ0IGlmIHRoZSBzdGF0ZSBjaGFuZ2VzDQo+ID4gPiBiZXR3ZWVuIHB3
bV9pbXhfdHBtX2dldF9zdGF0ZSByZWxlYXNpbmcgdGhlIGxvY2sgYW5kDQo+ID4gPiBwd21faW14
X3RwbV9hcHBseSB0YWtpbmcgaXQ/DQo+ID4NCj4gPiBUaGUgaWRlYSBpcyB0byBwcm90ZWN0IHRo
ZSBzaGFyZSByZXNvdXJjZWQgYnkgbXVsdGlwbGUgY2hhbm5lbHMsIGJ1dCBJDQo+ID4gdGhpbmsg
SSBjYW4gbWFrZSB0aGUgbXV0ZXhfbG9jayBpbmNsdWRlcyBnZXRfc3RhdGUgYW5kIHJlbW92ZSB0
aGUgbG9jayBpbg0KPiBnZXRfc3RhdGUgZnVuY3Rpb24uDQo+IEENCj4gWW91IG1pZ2h0IG5lZWQg
aXQgaW4gLmdldF9zdGF0ZSB0byByZXR1cm4gYSBjb25zaXN0ZW50IHN0YXRlIHRvIHRoZSBjYWxs
ZXIuIEluDQo+IHRoaXMgY2FzZSBqdXN0IGludHJvZHVjZSBhbiB1bmxvY2tlZCB2YXJpYW50IG9m
IC5nZXRfc3RhdGUgdG8gc2hhcmUgY29kZQ0KPiBiZXR3ZWVuIHRoZSB0d28gZnVuY3Rpb25zLg0K
PiANCj4gQW5kIEJUVyB0aGUgcXVlc3Rpb24gd2FzIGhvbmVzdC4gSSdtIG5vdCBlbnRpcmVseSBz
dXJlIHRoYXQgeW91IG5lZWQgdG8NCj4gaG9sZCB0aGUgbG9jay4NCg0KQWdyZWVkLCBpZiB0aGUg
ZGlmZmVyZW50IGNoYW5uZWwgY29uZmlndXJhdGlvbiBPTkxZIGFjY2VzcyBpdHMgb3duIHJlZ2lz
dGVyLCBOT1QNCmFueSBzaGFyZWQgcmVnaXN0ZXJzLCB0aGVuIEkgdGhpbmsgdGhpcyBsb2NrIGlz
IHVubmVjZXNzYXJ5Lg0KDQo+IA0KPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gKwkJaWYgKHRwbS0+
dXNlcl9jb3VudCAhPSAxKQ0KPiA+ID4gPiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gPiA+DQo+ID4g
PiBJZGVhbGx5IGlmIHNheSBwZXJpb2QgPSAzNyBpcyByZXF1ZXN0ZWQgYnV0IGN1cnJlbnRseSB3
ZSBoYXZlIHBlcmlvZA0KPiA+ID4gPQ0KPiA+ID4gMzYgYW5kIGNvbmZpZ3VyaW5nIDM3IHdvdWxk
IHJlc3VsdCBpbiAzNiBhbnlob3csIGRvbid0IHJldHVybiBFQlVTWS4NCj4gPg0KPiA+IEkgdGhp
bmsgaGVyZSB0aGUgcHJvdGVjdGlvbiBpcyBqdXN0IGZvciBtYWtpbmcgc3VyZSB0aGF0IGlzIHRo
ZXJlIGFyZQ0KPiA+IG11bHRpcGxlIHVzZXJzLCBwZXJpb2QgY2FuIE5PVCBiZSBjaGFuZ2VkLCBz
aW5jZSBhbGwgY2hhbm5lbHMgd2lsbCBiZQ0KPiBpbXBhY3RlZC4NCj4gDQo+IEkgdGhpbmsgeW91
IG1pc3VuZGVyc3Rvb2Qgd2hhdCBJIGludGVuZGVkIHRvIHNheSBoZXJlLg0KPiANCj4gQ29uc2lk
ZXIgdGhhdCBpbiB0aGUgY2FzZSB0aGF0IHRoZXJlIGlzIG9ubHkgYSBzaW5nbGUgUFdNIGluIHVz
ZSBjb25maWd1cmluZw0KPiBmb3IgYSBwZXJpb2Qgb2YgMzcgbnMgYWN0dWFsbHkgeWllbGRzIDM2
IG5zIGJlY2F1c2UgdGhlIGhhcmR3YXJlIGNhbm5vdA0KPiBwcm92aWRlIDM3IG5zIGFuZCAzNiBu
cyBpcyB0aGUgYmVzdCBtYXRjaC4NCj4gDQo+IFRoZW4gaWYgYSBzZWNvbmQgdXNlciBjb21lcyBh
bmQgcmVxdWVzdHMgMzcgbnMsIHRoZSByZXN1bHQgaGVyZSBpcywgdGhhdCB0aGUNCj4gc2Vjb25k
IHVzZXIgZ2V0cyB0aGUgLUVCVVNZLiBUaGlzIGlzIHJpZGljdWxvdXMgaG93ZXZlciBiZWNhdXNl
IHRoZSByZXF1ZXN0DQo+IGlzIGRlbmllZCBldmVuIHRob3VnaCB0aGUgcGVyaW9kIGlzIGFscmVh
ZHkgY29uZmlndXJlZCBmb3IgdGhlIGxlbmd0aCB0aGF0DQo+IHdvdWxkIGJlIGNvbmZpZ3VyZWQg
aWYgdGhlIHNlY29uZCB1c2VyIHdlcmUgdGhlIG9ubHkgb25lLg0KDQpBaCwgaWYgSSB1bmRlcnN0
YW5kIGNvcnJlY3RseSwgSSB0aGluayBJIGNhbiBjaGFuZ2UgaXQgdG8sIGlmIHNlY29uZCB1c2Vy
IHRyeSB0byBzZXQgYSBwZXJpb2QNCmRpZmZlcmVudCBmcm9tIGZpcnN0IHVzZXIsIHRoZW4gcmV0
dXJuIC1FQlVTWSwgb3RoZXJ3aXNlLCByZXR1cm4gc3VjY2Vzcy4NCg0KPiANCj4gPiA+ID4gKwl0
cG0tPmNoaXAuZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ID4gKwl0cG0tPmNoaXAub3BzID0gJmlt
eF90cG1fcHdtX29wczsNCj4gPiA+ID4gKwl0cG0tPmNoaXAuYmFzZSA9IC0xOw0KPiA+ID4gPiAr
CXRwbS0+Y2hpcC5ucHdtID0gUFdNX0lNWF9UUE1fTUFYX0NIQU5ORUxfTlVNOw0KPiA+ID4NCj4g
PiA+IFRoaXMgaXMgd3JvbmcsIGFzIHNvbWUgb25seSBoYXZlIDIgY2hhbm5lbHM/DQo+ID4NCj4g
PiBJIHNhdyB3ZSBjYW4gZ2V0IGNoYW5uZWwgbnVtYmVyIGZyb20gcmVnaXN0ZXIsIHdpbGwgcmVh
ZCByZWdpc3RlciB0bw0KPiA+IGRldGVybWluZSB0aGUgY2hhbm5lbCBudW1iZXIsIGJ1dCBmb3Ig
dGhlIGNoYW5uZWwgY29uZmlnIGFuZCBzdGF0dXMNCj4gPiBzYXZlZCBpbiBzdHJ1Y3QsIEkgd2ls
bCBzdGlsbCB1c2UgdGhlIE1BWCBjaGFubmVsIG51bWJlciB0byBkZWZpbmUgdGhlIGFycmF5Lg0K
PiANCj4gWWVhaCwgdGhhdCBpcyBzZW5zaWJsZS4NCg0KSSB3aWxsIHJlc2VuZCBWNSBwYXRjaCBz
ZXQsIHNpbmNlIHRoZXJlIGFyZSBzb21lIG1pcy11bmRlcnN0YW5kaW5nIGZvciBwcmV2aW91cyBj
b21tZW50cy4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UN
Cj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8
IFV3ZSBLbGVpbmUtS8O2bmlnICAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4IFNvbHV0
aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy5wDQo+IGVuZ3V0cm9uaXguZGUl
MkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzMxDQo+IGQxMGQz
ZjRhN2M0NmVlYTlkNzA4ZDZhYjc4ZDk2NSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAx
NjMNCj4gNSU3QzAlN0MwJTdDNjM2ODg0OTMyODU5ODA4ODE2JmFtcDtzZGF0YT1MRDJEJTJCd0Vo
TktGbGxLMkZhSQ0KPiBXdmp0dG1yZTBZUFYlMkJYd3Y3c2R2a1pTcG8lM0QmYW1wO3Jlc2VydmVk
PTAgIHwNCg==
