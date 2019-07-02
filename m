Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE3C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47F20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bT3Jpw+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGBHXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:23:23 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:7784
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGBHXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4phgZ0oXJW3NebKtTOHR7O8YFRECprhDvSWrn6tFXOE=;
 b=bT3Jpw+fo80aWn1reu6UV5SziZkpvhMAeT2sRJX9YOAR7RvF9kG8cYMIkXEmtfJCVuOduedqKjEMGfiUigLjxfIjjxi5Txdt/RV+BYMK4hdd+b4TX5hpp5xweiKc/m8gpZTjxvczfy5gwOqURRpe2sDnYFTJEwC+g6igzm1plMA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 07:23:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 07:23:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Topic: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Index: AQHVK+2BIBe0XayoFkyLTDr8gJYgQqat4TYAgADJtNCAAGSDAIAABGlggAfW5ACAAAm1EA==
Date:   Tue, 2 Jul 2019 07:23:16 +0000
Message-ID: <DB3PR0402MB39160FC8EA2B5BAC56375D99F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190626070706.24930-1-Anson.Huang@nxp.com>
 <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
 <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZDzFBzgwugaK-CihQNaa=1SPPNsKm6QKOh9LqWACeFGTg@mail.gmail.com>
 <DB3PR0402MB3916DFE339C802871F18F9ABF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190702064218.25vzkxds3bjfzy3m@pengutronix.de>
In-Reply-To: <20190702064218.25vzkxds3bjfzy3m@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deaf0fc2-a521-4fd5-c140-08d6febe267b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-antispam-prvs: <DB3PR0402MB3818FDB69D3B2E2CDBB95B31F5F80@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(189003)(74316002)(14444005)(11346002)(478600001)(476003)(256004)(66066001)(76116006)(2906002)(52536014)(7736002)(33656002)(446003)(86362001)(66446008)(64756008)(66946007)(73956011)(305945005)(68736007)(66556008)(44832011)(486006)(76176011)(5660300002)(6116002)(6916009)(3846002)(102836004)(53936002)(8676002)(54906003)(55016002)(9686003)(7696005)(14454004)(316002)(6436002)(6506007)(4326008)(71200400001)(26005)(25786009)(99286004)(71190400001)(6246003)(53546011)(229853002)(66476007)(81166006)(8936002)(186003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U9OQXpWLJclApDN34zv1Ax9O+CRdC2uON42pgE9JlxZ/wBSgPlKLWB1gaftm2R28c5H7i9SGKhY9lNRqDnm/hmFImQQI9S7vCtU2thDHv+U0V+arqgCZPSekoLKBDKQnYrKE0vFzoBJcCTBbDkduUfgDmMbksWq/TcwiI5qnZPRLMxaSR9KpQY5m2Lfr9qcqh3AtcqzKbyeUl69/WMOAy7AH2fSfaT1g0nGv1X/6ZTRcYw/agKtXqqH1roio4sg6pQCTfvAD83IWMWPwn12VH+M6hj/FbJYVqQfkn423TP9v2PLPw4p4amdWyJ6mcn9qPuvle3lAUnbeGwsXde9i3tYC3C1ifmQ+u2CxNX3sqa/4d4GsdbApePCuNsGm5m1jaSIIaDyqo0Bjc1nuGKtNE3MAZSp0JI4/yjdU9EpDYqA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deaf0fc2-a521-4fd5-c140-08d6febe267b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 07:23:16.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gSGkgQW5zb24sDQo+IA0KPiBPbiAxOS0wNi0yNyAwNzowMSwgQW5zb24g
SHVhbmcgd3JvdGU6DQo+ID4gSGksIERhbmllbA0KPiA+DQo+ID4gPiBPbiBUaHUsIEp1biAyNywg
MjAxOSBhdCAzOjQ4IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhpLCBEYW5pZWwNCj4gPiA+ID4NCj4gPiA+ID4gPiBP
biBXZWQsIEp1biAyNiwgMjAxOSBhdCAxMDowNiBBTSA8QW5zb24uSHVhbmdAbnhwLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWRkIGkuTVggU0NVIFNvQydz
IFVJRCh1bmlxdWUgaWRlbnRpZmllcikgc3VwcG9ydCwgdXNlciBjYW4NCj4gPiA+ID4gPiA+IHJl
YWQgaXQgZnJvbSBzeXNmczoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiByb290QGlteDhxeHBt
ZWs6fiMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL3NvY191aWQNCj4gPiA+ID4gPiA+IDdCNjQyODBC
NTdBQzE4OTgNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
IGRyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jIHwgMzUNCj4gPiA+ID4gPiA+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDM1IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9zb2Mv
aW14L3NvYy1pbXgtc2N1LmMgaW5kZXggNjc2ZjYxMi4uOGQzMjJhMSAxMDA2NDQNCj4gPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jDQo+ID4gPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiA+ID4gPiA+ID4gQEAgLTI3LDYgKzI3
LDM2IEBAIHN0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3NvY19pZCB7DQo+ID4gPiA+ID4gPiAg
ICAgICAgIH0gZGF0YTsNCj4gPiA+ID4gPiA+ICB9IF9fcGFja2VkOw0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ICtzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfdWlkIHsNCj4gPiA+ID4g
PiA+ICsgICAgICAgc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiA+ID4gPiA+ICsgICAg
ICAgdTMyIHVpZF9sb3c7DQo+ID4gPiA+ID4gPiArICAgICAgIHUzMiB1aWRfaGlnaDsNCj4gPiA+
ID4gPiA+ICt9IF9fcGFja2VkOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3N0YXRpYyBz
c2l6ZV90IHNvY191aWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+
ID4gPiA+ID4gPiArY2hhcg0KPiA+ID4gPiA+ID4gKypidWYpIHsNCj4gPiA+ID4gPiA+ICsgICAg
ICAgc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX3VpZCBtc2c7DQo+ID4gPiA+ID4gPiAr
ICAgICAgIHN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gPiA+ID4g
PiArICAgICAgIHU2NCBzb2NfdWlkOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyAgICAg
ICBoZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiA+ID4gPiA+ICsgICAgICAgaGRy
LT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KPiA+ID4gPiA+ID4gKyAgICAgICBoZHItPmZ1
bmMgPSBJTVhfU0NfTUlTQ19GVU5DX1VOSVFVRV9JRDsNCj4gPiA+ID4gPiA+ICsgICAgICAgaGRy
LT5zaXplID0gMTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsgICAgICAgLyogdGhlIHJl
dHVybiB2YWx1ZSBvZiBTQ1UgRlcgaXMgaW4gY29ycmVjdCwgc2tpcA0KPiA+ID4gPiA+ID4gKyBy
ZXR1cm4gdmFsdWUgY2hlY2sgKi8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoeSBkbyB5b3UgbWVh
biBieSAiaW4gY29ycmVjdCI/DQo+ID4gPiA+DQo+ID4gPiA+IEkgbWFkZSBhIG1pc3Rha2UsIGl0
IHNob3VsZCBiZSAiaW5jb3JyZWN0IiwgdGhlIGV4aXN0aW5nIFNDRlcgb2YNCj4gPiA+ID4gdGhp
cyBBUEkgcmV0dXJucyBhbiBlcnJvciB2YWx1ZSBldmVuIHRoaXMgQVBJIGlzIHN1Y2Nlc3NmdWxs
eQ0KPiA+ID4gPiBjYWxsZWQsIHRvIG1ha2UgaXQgd29yayB3aXRoIGN1cnJlbnQgU0NGVywgSSBo
YXZlIHRvIHNraXAgdGhlDQo+ID4gPiA+IHJldHVybiB2YWx1ZSBjaGVjayBmb3IgdGhpcyBBUEkg
Zm9yIG5vdy4gV2lsbCBzZW5kIFYyIHBhdGNoIHRvIGZpeCB0aGlzDQo+IHR5cG8uDQo+ID4gPg0K
PiA+ID4gVGhhbmtzIEFuc29uISBJdCBtYWtlcyBzZW5zZSBub3cuIEl0IGlzIGEgbGl0dGxlIGJp
dCBzYWQgdGhvdWdoDQo+ID4gPiBiZWNhdXNlIHdlIHdvbid0IGtub3cgd2hlbiB0aGVyZSBpcyBh
ICJyZWFsIiBlcnJvciA6KS4NCj4gPiA+DQo+ID4gPiBMZXRzIHVwZGF0ZSB0aGUgY29tbWVudCB0
byBiZSBtb3JlIHNwZWNpZmljOg0KPiA+ID4NCj4gPiA+IC8qIFNDRlcgRlcgQVBJIGFsd2F5cyBy
ZXR1cm5zIGFuIGVycm9yIGV2ZW4gdGhlIGZ1bmN0aW9uIGlzDQo+ID4gPiBzdWNjZXNzZnVsbHkg
ZXhlY3V0ZWQsIHNvIHNraXAgcmV0dXJuZWQgdmFsdWUgKi8NCj4gPg0KPiA+IE9LLCBhcyBmb3Ig
ZXh0ZXJuYWwgdXNlcnMsIHRoZSBTQ0ZXIGZvcm1hbGx5IHJlbGVhc2VkIGhhcyB0aGlzIGlzc3Vl
LA0KPiA+IHNvIGZvciBub3cgSSBoYXZlIHRvIHNraXAgdGhlIHJldHVybiB2YWx1ZSBjaGVjayBm
b3IgdGhpcyBBUEksIG9uY2UNCj4gPiBuZXh0IFNDRlcgcmVsZWFzZSBoYXMgdGhpcyBpc3N1ZSBm
aXhlZCwgSSB3aWxsIGFkZCBhIHBhdGNoIHRvIGNoZWNrIHRoZSByZXR1cm4NCj4gdmFsdWUuDQo+
IA0KPiBEbyB5b3UgcmVhbGx5IGtlZXAgdHJhY2sgb2YgdGhhdD8gUGxlYXNlIGNhbiB5b3UgYWRk
IGEgRklYTUU6IG9yIFRPRE86DQo+IHRhZyBhbmQgYWRkIHRoZSBmaXJtd2FyZSB2ZXJzaW9uIGNv
bnRhaW5pbmcgdGhhdCBidWc/DQoNClRoYW5rcyBmb3IgcmVtaW5kZXIsIEkganVzdCBkb3VibGUg
Y2hlY2tlZCB0aGUgU0NVIEZXIGNvZGUsIGl0IGlzIGFjdHVhbGx5IGEgbWlzdGFrZSwgdGhlIFND
VSBGVw0KQVBJIG9mIHNjX21pc2NfdW5pcXVlX2lkKCkgaXMgYWN0dWFsbHkgYSB2b2lkIGZ1bmN0
aW9uLCB3aGljaCBtZWFucyBpdCBkb2VzIE5PVCByZXR1cm4gYW55dGhpbmcuDQpXaGlsZSBpbiBv
dXIgaW50ZXJuYWwga2VybmVsIHRyZWUsIHdlIG1ha2UgU0NVIElQQyBjYWxsIHRvIHNjX21pc2Nf
dW5pcXVlX2lkKCkgd2l0aCByZXR1cm4gdmFsdWUNCmNoZWNrLCBhbmQgdGhlIHJldHVybiB2YWx1
ZSBpcyBmYWlsdXJlICgtNSkgYWx3YXlzLiBXaGVuIEkgY2xlYW4gdXAgdGhlIGNvZGUgZm9yIHVw
c3RyZWFtLCBJIGRpZCBOT1Qgbm90aWNlIGl0Lg0KU28gdGhlIGNvcnJlY3QgY29tbWVudCBzaG91
bGQgYmUsIHRoaXMgQVBJIGRvZXMgTk9UIHJldHVybiBhbnl0aGluZywgbm8gbmVlZCB0byBjaGVj
ayB0aGUgcmV0dXJuZWQgdmFsdWUuDQpJIHdpbGwgZml4IHRoZSBjb21tZW50IGluIG5leHQgdmVy
c2lvbi4NCg0Kdm9pZCBzY19taXNjX3VuaXF1ZV9pZChzY19pcGNfdCBpcGMsIHVpbnQzMl90ICpp
ZF9sLCB1aW50MzJfdCAqaWRfaCkNCg0KVGhhbmtzLA0KQW5zb24NCg0KPiANCj4gUmVnYXJkcywN
Cj4gICBNYXJjbw0KPiANCj4gPiBUaGFua3MsDQo+ID4gQW5zb24uDQo+ID4gPg0KPiA+ID4NCj4g
PiA+ID4gPiA+ICsgICAgICAgaW14X3NjdV9jYWxsX3JwYyhzb2NfaXBjX2hhbmRsZSwgJm1zZywg
dHJ1ZSk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAgIHNvY191aWQgPSBtc2cu
dWlkX2hpZ2g7DQo+ID4gPiA+ID4gPiArICAgICAgIHNvY191aWQgPDw9IDMyOw0KPiA+ID4gPiA+
ID4gKyAgICAgICBzb2NfdWlkIHw9IG1zZy51aWRfbG93Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ID4gKyAgICAgICByZXR1cm4gc3ByaW50ZihidWYsICIlMDE2bGxYXG4iLCBzb2NfdWlkKTsN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IHNucHJpbnRmPw0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgc25w
cmludGYgaXMgdG8gYXZvaWQgYnVmZmVyIG92ZXJmbG93LCB3aGljaCBpbiB0aGlzIGNhc2UsIEkN
Cj4gPiA+ID4gZG9uJ3Qga25vdyB0aGUgc2l6ZSBvZiAiYnVmIiwgYW5kIHRoZSB2YWx1ZSh1NjQp
IHRvIGJlIHByaW50ZWQgaXMNCj4gPiA+ID4gd2l0aCBmaXhlZCBsZW5ndGggb2YgNjQsIHNvIEkg
dGhpbmsgc3ByaW50IGlzIGp1c3QgT0suDQo+ID4gPg0KPiA+ID4gT2suDQo+IA0KPiAtLQ0KDQo=
