Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E18C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0E82082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pPMMgfgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEFIqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:46:11 -0400
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:44148
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfEFIqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhqinn/fTkT2CCk6OS8uqagWWGsSiQ0BvrKZJyrhaKs=;
 b=pPMMgfgtCz5JJdbfUk88q3r3ESup/OPSpcnOcDYks8Iqg6EML4hvgbAZLYKCP1/M8bA+mwSze5Cd54Q2yHKEuCYXDaqJvFa56m44oylmpT9/ujG/TpOnL3i3lcwPsq43KjoWnxqRqarcR0/zd7Ervg2Xgu+0pDXXI6xbc/sgYJk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5956.eurprd04.prod.outlook.com (20.178.113.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 08:45:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:45:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Topic: [PATCH 2/4] nvmem: imx: add i.MX8 nvmem driver
Thread-Index: AQHVA0ZmyuV26b+HdU+wzmbIrs3FtKZdxl6AgAACjxA=
Date:   Mon, 6 May 2019 08:45:27 +0000
Message-ID: <AM0PR04MB44819A6FA84A71ED01CC9C4E88300@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
 <20190505134130.28071-2-peng.fan@nxp.com>
 <AM0PR04MB421139D3806F75ED9426C8DB80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB421139D3806F75ED9426C8DB80300@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dee24b2-5fd9-4ab2-cc8b-08d6d1ff3054
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5956;
x-ms-traffictypediagnostic: AM0PR04MB5956:
x-microsoft-antispam-prvs: <AM0PR04MB5956B6CBF9E0531EAEA7C57488300@AM0PR04MB5956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(2201001)(68736007)(2906002)(33656002)(7736002)(110136005)(316002)(54906003)(53936002)(11346002)(446003)(8936002)(476003)(86362001)(81156014)(81166006)(7696005)(76176011)(53546011)(102836004)(486006)(6506007)(44832011)(26005)(478600001)(99286004)(8676002)(2501003)(186003)(4326008)(6436002)(66446008)(66066001)(66476007)(74316002)(66556008)(64756008)(229853002)(256004)(14444005)(25786009)(52536014)(305945005)(14454004)(6246003)(5660300002)(71190400001)(71200400001)(55016002)(7416002)(3846002)(6116002)(73956011)(66946007)(9686003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5956;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FYOzvaaQyjkKb15ktyq94j3Rz5cT03yfaXl25s+jk+EGH/7MvQmi5YE+PKMtr2eGnJXYIeALu1ken6sW8FQLk8xapnwIi/m3LkAgbxFysbJ8hS7lcSmJ2212KbDEbVBaM9MATsOeNNuIk59gEOFslJ6cfTfCOanNuYZsto6+MuJ6K/Nus2Bavi8PM7zpaKwJILeXL3K9Z8udEkG+wMeVFdgGlgc0hTKwnQ4Nz4C2Oa5WBDlzmWwFTjOV1oa9dMJyAOwc5bAR/Vcs4fE4QvK3H0cNY/f4W2AwvUUrdLkbBah2NjxSXBH4J7feIp36+p4v3jDTKFrMneB/jqYu+0HWaWhoSU61SeI5IWANvL2BfmabUwxXsbyoWfep44R73rtsjzGSUzZVKMzcP4/3zJFTLMd9iHjYnUuT8QBiBlSbu4s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dee24b2-5fd9-4ab2-cc8b-08d6d1ff3054
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:45:27.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWlzaGVuZywNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvNF0gbnZtZW06IGlteDogYWRk
IGkuTVg4IG52bWVtIGRyaXZlcg0KPiANCj4gPiBGcm9tOiBQZW5nIEZhbg0KPiA+IFNlbnQ6IFN1
bmRheSwgTWF5IDUsIDIwMTkgOToyOCBQTQ0KPiA+IFN1YmplY3Q6IFtQQVRDSCAyLzRdIG52bWVt
OiBpbXg6IGFkZCBpLk1YOCBudm1lbSBkcml2ZXINCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBp
Lk1YOCBudm1lbSBvY290cCBkcml2ZXIgdG8gYWNjZXNzIGZ1c2UgdmlhIFJQQyB0bw0KPiA+IGku
TVg4IHN5c3RlbSBjb250cm9sbGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBPbmx5IGEgZmV3IG1pbm9yIGNvbW1lbnRzLg0KPiBP
dGhlcndpc2UsIHRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEZpcnN0LCB0aGUg
cGF0Y2ggdGl0bGUgcHJvYmFibHkgYmV0dGVyIHRvIGJlOg0KPiBudm1lbTogaW14OiBhZGQgaS5N
WDggU0NVIGJhc2VkIG9jb3RwIGRyaXZlciBzdXBwb3J0DQoNCkZpeCBpbiBWMi4NCg0KPiANCj4g
PiBDYzogU3Jpbml2YXMgS2FuZGFnYXRsYSA8c3Jpbml2YXMua2FuZGFnYXRsYUBsaW5hcm8ub3Jn
Pg0KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFNhc2No
YSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4NCj4gPiBDYzogUGVuZ3V0cm9uaXggS2Vy
bmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4NCj4gPiBDYzogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiA+IENjOiBOWFAgTGludXggVGVhbSA8bGludXgtaW14QG54
cC5jb20+DQo+ID4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL252bWVtL0tjb25maWcgICAgICAgICB8ICAgNyArKysNCj4gPiAg
ZHJpdmVycy9udm1lbS9NYWtlZmlsZSAgICAgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL252bWVt
L2lteC1vY290cC1zY3UuYyB8IDEzNQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspDQo+
ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYw0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vS2NvbmZpZyBiL2RyaXZlcnMvbnZtZW0v
S2NvbmZpZyBpbmRleA0KPiA+IDUzMGQ1NzA3MjRjOS4uMGU3MDVjMDRiZDhjIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbnZtZW0vS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZW0vS2Nv
bmZpZw0KPiA+IEBAIC0zNiw2ICszNiwxMyBAQCBjb25maWcgTlZNRU1fSU1YX09DT1RQDQo+ID4g
IAkgIFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzbywgdGhl
IG1vZHVsZQ0KPiA+ICAJICB3aWxsIGJlIGNhbGxlZCBudm1lbS1pbXgtb2NvdHAuDQo+ID4NCj4g
PiArY29uZmlnIE5WTUVNX0lNWF9PQ09UUF9TQ1UNCj4gPiArCXRyaXN0YXRlICJpLk1YOCBPbi1D
aGlwIE9UUCBDb250cm9sbGVyIHN1cHBvcnQiDQo+IA0KPiBpLk1YOCBTQ1UgT24tQ2hpcCBPVFAg
Q29udHJvbGxlciBzdXBwb3J0DQpGaXggaW4gVjINCj4gDQo+ID4gKwlkZXBlbmRzIG9uIElNWF9T
Q1UNCj4gPiArCWhlbHANCj4gPiArCSAgVGhpcyBpcyBhIGRyaXZlciBmb3IgdGhlIE9uLUNoaXAg
T1RQIENvbnRyb2xsZXIgKE9DT1RQKQ0KPiANCj4gU0NVIE9uLUNoaXAgT1RQDQpGaXggaW4gVjIu
DQo+IA0KPiA+ICsJICBhdmFpbGFibGUgb24gaS5NWDggU29Dcy4NCj4gPiArDQpbLi4uLi5dDQoN
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgaW14X3NjdV9vY290cF9yZWFkKHZvaWQgKmNvbnRleHQs
IHVuc2lnbmVkIGludCBvZmZzZXQsDQo+ID4gKwkJCSAgICAgIHZvaWQgKnZhbCwgc2l6ZV90IGJ5
dGVzKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgb2NvdHBfcHJpdiAqcHJpdiA9IGNvbnRleHQ7DQo+
ID4gKwl1MzIgY291bnQsIGluZGV4LCBudW1fYnl0ZXM7DQo+ID4gKwl1OCAqYnVmLCAqcDsNCj4g
DQo+IEl0IHNlZW1zIGJ1ZiBoYXMgbmV2ZXIgYmVlbiB1c2VkIGFzIHU4Lg0KPiBTbyBwcm9iYWJs
eSBhIGJldHRlciB3YXkgaXM6DQo+IFUzMiAqYnVmOw0KPiBWb2lkICpwLg0KPiBUaGVuIHdlIGNh
biBzYXZlIGFsbCB0aGUgZXhwbGljaXQgY29udmVyc2lvbiBvZiB1MzIuDQoNCkZpeCBpbiBWMi4N
Cg0KPiANCj4gPiArCWludCBpLCByZXQ7DQo+ID4gKw0KPiA+ICsJaW5kZXggPSBvZmZzZXQgPj4g
MjsNCj4gPiArCW51bV9ieXRlcyA9IHJvdW5kX3VwKChvZmZzZXQgJSA0KSArIGJ5dGVzLCA0KTsN
Cj4gPiArCWNvdW50ID0gbnVtX2J5dGVzID4+IDI7DQo+ID4gKw0KPiA+ICsJaWYgKGNvdW50ID4g
KHByaXYtPmRhdGEtPm5yZWdzIC0gaW5kZXgpKQ0KPiA+ICsJCWNvdW50ID0gcHJpdi0+ZGF0YS0+
bnJlZ3MgLSBpbmRleDsNCj4gPiArDQo+ID4gKwlwID0ga3phbGxvYyhudW1fYnl0ZXMsIEdGUF9L
RVJORUwpOw0KPiA+ICsJaWYgKCFwKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4g
PiArCWJ1ZiA9IHA7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gaW5kZXg7IGkgPCAoaW5kZXggKyBj
b3VudCk7IGkrKykgew0KPiA+ICsJCWlmIChwcml2LT5kYXRhLT5kZXZ0eXBlID09IElNWDhRWFAp
IHsNCj4gPiArCQkJaWYgKChpID4gMjcxKSAmJiAoaSA8IDU0NCkpIHsNCj4gPiArCQkJCSoodTMy
ICopYnVmID0gMDsNCj4gPiArCQkJCWJ1ZiArPSA0Ow0KPiA+ICsJCQkJY29udGludWU7DQo+ID4g
KwkJCX0NCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXJldCA9IGlteF9zY19taXNjX290cF9mdXNl
X3JlYWQocHJpdi0+bnZtZW1faXBjLCBpLA0KPiA+ICsJCQkJCQkodTMyICopYnVmKTsNCj4gDQo+
IElzIHRoaXMgQVBJIGFscmVhZHkgaW4ga2VybmVsPw0KDQpBaC4gSSBmb3Jnb3QgdG8gcG9zdCBv
dXQgdGhhdCBBUEkgaW4gdGhpcyBwYXRjaHNldC4gV2lsbCBhZGQgdGhhdCBpbiBWMi4NCg0KWy4u
Li5dDQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4iKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJpLk1YOFFNIE9DT1RQIGZ1c2UgYm94IGRy
aXZlciIpOw0KPiANCj4gaS5NWDggU0NVIE9DT1RQIGZ1c2UgYm94IGRyaXZlcg0KDQpGaXggaW4g
VjIuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5nDQo+
IA0KPiA+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+ID4gLS0NCj4gPiAyLjE2LjQNCg0K
