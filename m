Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F2C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mlVIG4mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfF0HBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:01:39 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:29523
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfF0HBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=AvbBldxWy4o7H/GULf5Haoz/FF0G2u58CKuv11LiDNTYM4Lo2OyiNU7F83fMrpK5dqOKetJowZyQEY7cfJXjJnyusNKqvHP50CrUWuE7pj7ahnFBFm/txY+Mf9yYxa5PddkBHJlw3pN7Pf+wQ6vytTqSF1r2ongM1Aa1ZRtcjoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzR6ag0Y9d3jrufjXi7kurctLagV/hCB7EIQNznRGRs=;
 b=WbqOi4BsTXYUjd3ZHNhHg6wDL2boQwgV8MxhudUYqt8JjBw2cgCk7Jl7cxycu/ikegx6GhSr/sn+dEci615LHXWrlAsM0BgPmJDG3ds6Ppa4IV1wy20lvuxRVQwidjZ5lOvytIj0B8BhQPSZ1kyBf8owUYPilozVNOl9jrvJ/ro=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzR6ag0Y9d3jrufjXi7kurctLagV/hCB7EIQNznRGRs=;
 b=mlVIG4mEKaSfXJCqb95NXDO0y/B/CYFnSMpwejx3NMG7HT43h1Ahs/swxcHo6smv0deEp18zhd2Z3Py7AtdpxuJsj6jitnfUOPFmBMM/oRBMhlS4RlB25Dga2XBy/rzlijyXeXjFos7cNSh0dweCNlZjJ6a1eNFCTEH+KrTGNOk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 07:01:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 07:01:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Topic: [PATCH] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Index: AQHVK+2BIBe0XayoFkyLTDr8gJYgQqat4TYAgADJtNCAAGSDAIAABGlg
Date:   Thu, 27 Jun 2019 07:01:31 +0000
Message-ID: <DB3PR0402MB3916DFE339C802871F18F9ABF5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190626070706.24930-1-Anson.Huang@nxp.com>
 <CAEnQRZBsT=KY3-Gk8p1byJOqx1_y_EX-KqiBs6WnroWkT5oe_Q@mail.gmail.com>
 <DB3PR0402MB3916A4093CFB363B51523AA7F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZDzFBzgwugaK-CihQNaa=1SPPNsKm6QKOh9LqWACeFGTg@mail.gmail.com>
In-Reply-To: <CAEnQRZDzFBzgwugaK-CihQNaa=1SPPNsKm6QKOh9LqWACeFGTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5483a03-efa1-4dfb-f38a-08d6facd490c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-microsoft-antispam-prvs: <DB3PR0402MB3754E86AB162A251B03C747EF5FD0@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(376002)(39860400002)(346002)(396003)(199004)(13464003)(189003)(3846002)(6436002)(81166006)(6506007)(64756008)(74316002)(186003)(7736002)(99286004)(68736007)(6116002)(102836004)(53546011)(305945005)(55016002)(6246003)(33656002)(4326008)(2906002)(66066001)(53936002)(8676002)(76176011)(9686003)(81156014)(8936002)(478600001)(7696005)(25786009)(316002)(14454004)(14444005)(229853002)(476003)(66946007)(6916009)(11346002)(73956011)(66446008)(44832011)(446003)(256004)(54906003)(26005)(71190400001)(52536014)(71200400001)(5660300002)(86362001)(76116006)(66556008)(486006)(66476007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 36TJwpaBZXbDhkMEg3lntAHfe7V6mmDhfElLgBdHaePfW1PK9HB2luHIoQEH1I78qHdCL8d1CzLdxNTIm0us/UpGasmgdDTtfScD2dof1WSH12hIAigpLLmM4FPwwfpG0Q7mj/npXpy6lULvDGn16lR3yBKSDnhqYxZChN6ZZJjpa/bH/jFSNrAaDjMorlmirEUGoQGaF36ycBs90myp53J25QomL4SLmevGXANHq+sJYU2ucBWvXQjv60tYtXu486miOXTzAsljQoygokbtGEyw347KZnxz1lHArEDcwkJ1AWcaqo9pjZT7CDCIllhxRdI0ewqeyopiI99gf3FYfeY0RZ4qaLhPHDnpy+GX+XVaVCGFKGAE0ZZBg/AoBvlgJoKpYpt1vz8zkfAPDtSAsxpMa4Nw5pjBqkxspV7s1nE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5483a03-efa1-4dfb-f38a-08d6facd490c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 07:01:31.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAyNywgMjAxOSAyOjQ0IFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0K
PiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
OyBBaXNoZW5nDQo+IERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgQWJlbCBWZXNhIDxhYmVs
LnZlc2FAbnhwLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
IERhbmllbA0KPiBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gc29jOiBpbXgtc2N1OiBBZGQgU29DIFVJRCh1bmlxdWUgaWRlbnRpZmllcikgc3Vw
cG9ydA0KPiANCj4gT24gVGh1LCBKdW4gMjcsIDIwMTkgYXQgMzo0OCBBTSBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSwgRGFuaWVsDQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVu
ZSAyNiwgMjAxOSA4OjQyIFBNDQo+ID4gPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54
cC5jb20+DQo+ID4gPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hh
IEhhdWVyDQo+ID4gPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5l
bCBUZWFtDQo+ID4gPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPjsNCj4gQWlzaGVuZw0KPiA+ID4gRG9uZyA8YWlzaGVuZy5kb25nQG54
cC5jb20+OyBBYmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsgbGludXgtDQo+ID4gPiBhcm0t
a2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJu
ZWwNCj4gPiA+IE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGRs
LWxpbnV4LWlteA0KPiA+ID4gPGxpbnV4LWlteEBueHAuY29tPjsgRGFuaWVsIEJhbHV0YSA8ZGFu
aWVsLmJhbHV0YUBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXgt
c2N1OiBBZGQgU29DIFVJRCh1bmlxdWUgaWRlbnRpZmllcikNCj4gPiA+IHN1cHBvcnQNCj4gPiA+
DQo+ID4gPiBPbiBXZWQsIEp1biAyNiwgMjAxOSBhdCAxMDowNiBBTSA8QW5zb24uSHVhbmdAbnhw
LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgaS5NWCBTQ1UgU29DJ3MgVUlEKHVu
aXF1ZSBpZGVudGlmaWVyKSBzdXBwb3J0LCB1c2VyIGNhbiByZWFkDQo+ID4gPiA+IGl0IGZyb20g
c3lzZnM6DQo+ID4gPiA+DQo+ID4gPiA+IHJvb3RAaW14OHF4cG1lazp+IyBjYXQgL3N5cy9kZXZp
Y2VzL3NvYzAvc29jX3VpZA0KPiA+ID4gPiA3QjY0MjgwQjU3QUMxODk4DQo+ID4gPiA+DQo+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jIHwgMzUNCj4g
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiA+ID4gPiBiL2RyaXZlcnMvc29jL2lt
eC9zb2MtaW14LXNjdS5jIGluZGV4IDY3NmY2MTIuLjhkMzIyYTEgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
c29jL2lteC9zb2MtaW14LXNjdS5jDQo+ID4gPiA+IEBAIC0yNyw2ICsyNywzNiBAQCBzdHJ1Y3Qg
aW14X3NjX21zZ19taXNjX2dldF9zb2NfaWQgew0KPiA+ID4gPiAgICAgICAgIH0gZGF0YTsNCj4g
PiA+ID4gIH0gX19wYWNrZWQ7DQo+ID4gPiA+DQo+ID4gPiA+ICtzdHJ1Y3QgaW14X3NjX21zZ19t
aXNjX2dldF9zb2NfdWlkIHsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgaW14X3NjX3JwY19tc2cg
aGRyOw0KPiA+ID4gPiArICAgICAgIHUzMiB1aWRfbG93Ow0KPiA+ID4gPiArICAgICAgIHUzMiB1
aWRfaGlnaDsNCj4gPiA+ID4gK30gX19wYWNrZWQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRp
YyBzc2l6ZV90IHNvY191aWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hh
cg0KPiA+ID4gPiArKmJ1Zikgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBpbXhfc2NfbXNnX21p
c2NfZ2V0X3NvY191aWQgbXNnOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBpbXhfc2NfcnBjX21z
ZyAqaGRyID0gJm1zZy5oZHI7DQo+ID4gPiA+ICsgICAgICAgdTY0IHNvY191aWQ7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKyAgICAgICBoZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiA+
ID4gKyAgICAgICBoZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX01JU0M7DQo+ID4gPiA+ICsgICAg
ICAgaGRyLT5mdW5jID0gSU1YX1NDX01JU0NfRlVOQ19VTklRVUVfSUQ7DQo+ID4gPiA+ICsgICAg
ICAgaGRyLT5zaXplID0gMTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIHRoZSByZXR1
cm4gdmFsdWUgb2YgU0NVIEZXIGlzIGluIGNvcnJlY3QsIHNraXAgcmV0dXJuDQo+ID4gPiA+ICsg
dmFsdWUgY2hlY2sgKi8NCj4gPiA+DQo+ID4gPiBXaHkgZG8geW91IG1lYW4gYnkgImluIGNvcnJl
Y3QiPw0KPiA+DQo+ID4gSSBtYWRlIGEgbWlzdGFrZSwgaXQgc2hvdWxkIGJlICJpbmNvcnJlY3Qi
LCB0aGUgZXhpc3RpbmcgU0NGVyBvZiB0aGlzDQo+ID4gQVBJIHJldHVybnMgYW4gZXJyb3IgdmFs
dWUgZXZlbiB0aGlzIEFQSSBpcyBzdWNjZXNzZnVsbHkgY2FsbGVkLCB0bw0KPiA+IG1ha2UgaXQg
d29yayB3aXRoIGN1cnJlbnQgU0NGVywgSSBoYXZlIHRvIHNraXAgdGhlIHJldHVybiB2YWx1ZSBj
aGVjaw0KPiA+IGZvciB0aGlzIEFQSSBmb3Igbm93LiBXaWxsIHNlbmQgVjIgcGF0Y2ggdG8gZml4
IHRoaXMgdHlwby4NCj4gDQo+IFRoYW5rcyBBbnNvbiEgSXQgbWFrZXMgc2Vuc2Ugbm93LiBJdCBp
cyBhIGxpdHRsZSBiaXQgc2FkIHRob3VnaCBiZWNhdXNlIHdlDQo+IHdvbid0IGtub3cgd2hlbiB0
aGVyZSBpcyBhICJyZWFsIiBlcnJvciA6KS4NCj4gDQo+IExldHMgdXBkYXRlIHRoZSBjb21tZW50
IHRvIGJlIG1vcmUgc3BlY2lmaWM6DQo+IA0KPiAvKiBTQ0ZXIEZXIEFQSSBhbHdheXMgcmV0dXJu
cyBhbiBlcnJvciBldmVuIHRoZSBmdW5jdGlvbiBpcyBzdWNjZXNzZnVsbHkNCj4gZXhlY3V0ZWQs
IHNvIHNraXAgcmV0dXJuZWQgdmFsdWUgKi8NCg0KT0ssIGFzIGZvciBleHRlcm5hbCB1c2Vycywg
dGhlIFNDRlcgZm9ybWFsbHkgcmVsZWFzZWQgaGFzIHRoaXMgaXNzdWUsIHNvIGZvciBub3cNCkkg
aGF2ZSB0byBza2lwIHRoZSByZXR1cm4gdmFsdWUgY2hlY2sgZm9yIHRoaXMgQVBJLCBvbmNlIG5l
eHQgU0NGVyByZWxlYXNlIGhhcyB0aGlzIGlzc3VlDQpmaXhlZCwgSSB3aWxsIGFkZCBhIHBhdGNo
IHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUuDQoNClRoYW5rcywNCkFuc29uLg0KPiANCj4gDQo+
ID4gPiA+ICsgICAgICAgaW14X3NjdV9jYWxsX3JwYyhzb2NfaXBjX2hhbmRsZSwgJm1zZywgdHJ1
ZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBzb2NfdWlkID0gbXNnLnVpZF9oaWdoOw0K
PiA+ID4gPiArICAgICAgIHNvY191aWQgPDw9IDMyOw0KPiA+ID4gPiArICAgICAgIHNvY191aWQg
fD0gbXNnLnVpZF9sb3c7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gc3ByaW50
ZihidWYsICIlMDE2bGxYXG4iLCBzb2NfdWlkKTsNCj4gPiA+DQo+ID4gPiBzbnByaW50Zj8NCj4g
Pg0KPiA+IFRoZSBzbnByaW50ZiBpcyB0byBhdm9pZCBidWZmZXIgb3ZlcmZsb3csIHdoaWNoIGlu
IHRoaXMgY2FzZSwgSSBkb24ndA0KPiA+IGtub3cgdGhlIHNpemUgb2YgImJ1ZiIsIGFuZCB0aGUg
dmFsdWUodTY0KSB0byBiZSBwcmludGVkIGlzIHdpdGggZml4ZWQNCj4gPiBsZW5ndGggb2YgNjQs
IHNvIEkgdGhpbmsgc3ByaW50IGlzIGp1c3QgT0suDQo+IA0KPiBPay4NCg==
