Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38589C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D0E21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCpdonsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH3I2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:28:09 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:55941
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfH3I2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:28:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUDe7t9hGERPcTGBwn196GggUFzVYAL+d6akfWcMXUJHlCoDl1kGuQJWxtAEt9f5uDEofRFqQzzjP/8scmr5MWfav4+EwcyYpwRwEEH5Z0IfARGpD9OIMaC3eI6vO2jJ3sTfigyL1w9W4muiLxS3zdBifk/iX8Xv+lBGX3Ul7ZwG6bUGcyf1oYGzfpszAmkp8hS3j0GCRo9r/oY4+Ja6kCOmEzcdPOzg6v6WM/GfDMaYcRKZy9bUQUm8GCzHBTFII5XwFl4z2OacEO5BS4uDF6HtoZPW6mXq7edPeFfsMRPSgawtPFkQBNm+MEzM9jXsA88CYk0sbVkt5OljwY6HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeM9B4AEgx+nzadsr56zJ3s/4xI+/RUFmp3jOP96Fg8=;
 b=PYUqcVOL3FNkOupoOISuNaFiQNpfi9EnWGGD/zXay4hi2oVQlPisbY6s9F8sOKqRqTWIVKneE1F0D+4h1NRhHbOs7Iyqk+zqR+2cMvTogtgUWhU98Oq8UilxF8/NmfNSahFL1wOjbShQngz8+8zIB8eFygvEOZnHIsG3LudcYJvZeEeBI67Dkh2Re6xjIVgXzHjqy6J+v9L/fK7p957xwLiep60tf9fS2hMG99TIzndiHe8fVJmh5qpmCuBGKwwLVYcOrL4xjhxSAsffh2RI5vw0MKMKgh7Hw5Ar+4tWRy/Ohi3pE4ZLxl5IlcnyY7E6e2uoSgkWfonpAtHD9bT7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeM9B4AEgx+nzadsr56zJ3s/4xI+/RUFmp3jOP96Fg8=;
 b=LCpdonswKbofkmE59ENr6wOLHqLsBsCQvmafBOXeI+diYGEfFVNEWo/hMLUAMWknYQsQN+7ixCwwVqzNYDpmNsNnRm94GEEimc94b+TiuK9KNbrYAYJbVnTXM6tAc1dxM8TBJdpJeV6UkOgs3aLQcn0k7Jz46OBhcueHk64PvWw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4818.eurprd04.prod.outlook.com (20.176.215.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 30 Aug 2019 08:28:01 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 08:28:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+CAABGfAIAAAKjwgAAICwCAAAHRcIAAA7iAgAAARlA=
Date:   Fri, 30 Aug 2019 08:28:01 +0000
Message-ID: <AM0PR04MB4481253297D017FF847CF60288BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
 <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
 <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
In-Reply-To: <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85a9f389-4049-4988-28c3-08d72d23f8de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4818;
x-ms-traffictypediagnostic: AM0PR04MB4818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB481862D7FDB389F0D1147A7988BD0@AM0PR04MB4818.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(43544003)(199004)(189003)(66066001)(44832011)(478600001)(52536014)(5660300002)(66946007)(476003)(74316002)(1411001)(66476007)(25786009)(6916009)(76116006)(66446008)(66556008)(64756008)(3846002)(71190400001)(4326008)(71200400001)(2906002)(14454004)(9686003)(86362001)(15650500001)(486006)(6116002)(8936002)(186003)(53546011)(7696005)(6246003)(81166006)(8676002)(81156014)(26005)(99286004)(33656002)(256004)(6506007)(229853002)(305945005)(446003)(7736002)(11346002)(6436002)(55016002)(54906003)(102836004)(53936002)(76176011)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4818;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gcbh/OO7MLhkAPnsHlA1nUxPbJNTgSrfX3SvSPugXzEjzKxBOWn3eBMmtlsaoobqOz1yU4b5AulgPR20DhNATsshz4Es2yd6YvYxh0kBmeujgBo9M4hwKJCINMeUZpObnqiZMRoPT/ZQQ8NQoAf2jnznrRIuPmgkUGfKx7kDD/S/ri9/BfRGgiTSTnZGBtPWoGCg0UZS6UlwhWs5+z9iwas82aX9G5nPdaIFlNO0EXKImARaVlE6YitOKykORcCMtBb1AuvD0gT6prpriEKynAbLPcgx4i/KOmifm5jmk8EC/t2UUqXdiN/r5DkxdYlQ630tFH3hCI2TGFPll80G5hu5lRik4WAPEG5PW7HxjmbLu19D5ECMWiD+tYlxPV69vcALs6c7JdvIR/CZVB1ULAOxAEF8/wlHWbjchBcAh1U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a9f389-4049-4988-28c3-08d72d23f8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 08:28:01.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dx3R9xh39E/FR89RrBGJBCDBmCpvYIz627rN7x3AfETb+Lk5ZcTQhA0iV0m+j/H0GQCnIs4XLiv8dlC3RcfKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczogbWFpbGJveDogYWRk
IGJpbmRpbmcgZG9jIGZvciB0aGUgQVJNDQo+IFNNQy9IVkMgbWFpbGJveA0KPiANCj4gT24gRnJp
LCBBdWcgMzAsIDIwMTkgYXQgMzowNyBBTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8yXSBkdC1iaW5kaW5nczog
bWFpbGJveDogYWRkIGJpbmRpbmcgZG9jDQo+ID4gPiBmb3IgdGhlIEFSTSBTTUMvSFZDIG1haWxi
b3gNCj4gPiA+DQo+ID4gPiBPbiBGcmksIEF1ZyAzMCwgMjAxOSBhdCAyOjM3IEFNIFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSGkgSmFzc2ksDQo+
ID4gPiA+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzJdIGR0LWJpbmRpbmdz
OiBtYWlsYm94OiBhZGQgYmluZGluZw0KPiA+ID4gPiA+IGRvYyBmb3IgdGhlIEFSTSBTTUMvSFZD
IG1haWxib3gNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIEZyaSwgQXVnIDMwLCAyMDE5IGF0IDE6
MjggQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gK2V4YW1wbGVzOg0KPiA+ID4gPiA+ID4gPiA+ICsgIC0gfA0KPiA+ID4gPiA+
ID4gPiA+ICsgICAgc3JhbUA5MTAwMDAgew0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBjb21wYXRp
YmxlID0gIm1taW8tc3JhbSI7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgIHJlZyA9IDwweDAgMHg5
M2YwMDAgMHgwIDB4MTAwMD47DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiA+
ID4gPiA+ID4gPiArICAgICAgcmFuZ2VzID0gPDAgMHgwIDB4OTNmMDAwIDB4MTAwMD47DQo+ID4g
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBjcHVfc2NwX2xwcmk6IHNjcC1z
aG1lbUAwIHsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICBjb21wYXRpYmxlID0gImFybSxzY21p
LXNobWVtIjsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICByZWcgPSA8MHgwIDB4MjAwPjsNCj4g
PiA+ID4gPiA+ID4gPiArICAgICAgfTsNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+
ID4gKyAgICAgIGNwdV9zY3BfaHByaTogc2NwLXNobWVtQDIwMCB7DQo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sc2NtaS1zaG1lbSI7DQo+ID4gPiA+ID4gPiA+ID4g
KyAgICAgICAgcmVnID0gPDB4MjAwIDB4MjAwPjsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgfTsN
Cj4gPiA+ID4gPiA+ID4gPiArICAgIH07DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
PiA+ICsgICAgZmlybXdhcmUgew0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBzbWNfbWJveDogbWFp
bGJveCB7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgI21ib3gtY2VsbHMgPSA8MT47DQo+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sc21jLW1ib3giOw0KPiA+ID4g
PiA+ID4gPiA+ICsgICAgICAgIG1ldGhvZCA9ICJzbWMiOw0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgIGFybSxudW0tY2hhbnMgPSA8MHgyPjsNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgICB0cmFu
c3BvcnRzID0gIm1lbSI7DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgLyogT3B0aW9uYWwgKi8N
Cj4gPiA+ID4gPiA+ID4gPiArICAgICAgICBhcm0sZnVuYy1pZHMgPSA8MHhjMjAwMDBmZT4sIDww
eGMyMDAwMGZmPjsNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTTUMvSFZDIGlzIHN5
bmNocm9ub3VzbHkoYmxvY2spIHJ1bm5pbmcgaW4gInNlY3VyZSBtb2RlIiwNCj4gPiA+ID4gPiA+
ID4gaS5lLCB0aGVyZSBjYW4gb25seSBiZSBvbmUgaW5zdGFuY2UgcnVubmluZyBwbGF0Zm9ybSB3
aWRlLiBSaWdodD8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIHRoaW5rIHRoZXJlIGNvdWxk
IGJlIGNoYW5uZWwgZm9yIFRFRSwgYW5kIGNoYW5uZWwgZm9yIExpbnV4Lg0KPiA+ID4gPiA+ID4g
Rm9yIHZpcnR1YWxpemF0aW9uIGNhc2UsIHRoZXJlIGNvdWxkIGJlIGRlZGljYXRlZCBjaGFubmVs
IGZvciBlYWNoDQo+IFZNLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGFtIHRhbGtpbmcgZnJv
bSBMaW51eCBwb3YuIEZ1bmN0aW9ucyAweGZlIGFuZCAweGZmIGFib3ZlLA0KPiA+ID4gPiA+IGNh
bid0IGJvdGggYmUgYWN0aXZlIGF0IHRoZSBzYW1lIHRpbWUsIHJpZ2h0Pw0KPiA+ID4gPg0KPiA+
ID4gPiBJZiBJIGdldCB5b3VyIHBvaW50IGNvcnJlY3RseSwNCj4gPiA+ID4gT24gVVAsIGJvdGgg
Y291bGQgbm90IGJlIGFjdGl2ZS4gT24gU01QLCB0eC9yeCBjb3VsZCBiZSBib3RoDQo+ID4gPiA+
IGFjdGl2ZSwgYW55d2F5IHRoaXMgZGVwZW5kcyBvbiBzZWN1cmUgZmlybXdhcmUgYW5kIExpbnV4
IGZpcm13YXJlDQo+IGRlc2lnbi4NCj4gPiA+ID4NCj4gPiA+ID4gRG8geW91IGhhdmUgYW55IHN1
Z2dlc3Rpb25zIGFib3V0IGFybSxmdW5jLWlkcyBoZXJlPw0KPiA+ID4gPg0KPiA+ID4gSSB3YXMg
dGhpbmtpbmcgaWYgdGhpcyBpcyBqdXN0IGFuIGluc3RydWN0aW9uLCB3aHkgY2FuJ3QgZWFjaA0K
PiA+ID4gY2hhbm5lbCBiZSByZXByZXNlbnRlZCBhcyBhIGNvbnRyb2xsZXIsIGkuZSwgaGF2ZSBl
eGFjdGx5IG9uZSBmdW5jLWlkIHBlcg0KPiBjb250cm9sbGVyIG5vZGUuDQo+ID4gPiBEZWZpbmUg
YXMgbWFueSBjb250cm9sbGVycyBhcyB5b3UgbmVlZCBjaGFubmVscyA/DQo+ID4NCj4gPiBJIGFt
IG9rLCB0aGlzIGNvdWxkIG1ha2UgZHJpdmVyIGNvZGUgc2ltcGxlci4gU29tZXRoaW5nIGFzIGJl
bG93Pw0KPiA+DQo+ID4gICAgIHNtY190eF9tYm94OiB0eF9tYm94IHsNCj4gPiAgICAgICAjbWJv
eC1jZWxscyA9IDwwPjsNCj4gPiAgICAgICBjb21wYXRpYmxlID0gImFybSxzbWMtbWJveCI7DQo+
ID4gICAgICAgbWV0aG9kID0gInNtYyI7DQo+ID4gICAgICAgdHJhbnNwb3J0cyA9ICJtZW0iOw0K
PiA+ICAgICAgIGFybSxmdW5jLWlkID0gPDB4YzIwMDAwZmU+Ow0KPiA+ICAgICB9Ow0KPiA+DQo+
ID4gICAgIHNtY19yeF9tYm94OiByeF9tYm94IHsNCj4gPiAgICAgICAjbWJveC1jZWxscyA9IDww
PjsNCj4gPiAgICAgICBjb21wYXRpYmxlID0gImFybSxzbWMtbWJveCI7DQo+ID4gICAgICAgbWV0
aG9kID0gInNtYyI7DQo+ID4gICAgICAgdHJhbnNwb3J0cyA9ICJtZW0iOw0KPiA+ICAgICAgIGFy
bSxmdW5jLWlkID0gPDB4YzIwMDAwZmY+Ow0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgZmlybXdh
cmUgew0KPiA+ICAgICAgIHNjbWkgew0KPiA+ICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0sc2Nt
aSI7DQo+ID4gICAgICAgICBtYm94ZXMgPSA8JnNtY190eF9tYm94PiwgPCZzbWNfcnhfbWJveCAx
PjsNCj4gPiAgICAgICAgIG1ib3gtbmFtZXMgPSAidHgiLCAicngiOw0KPiA+ICAgICAgICAgc2ht
ZW0gPSA8JmNwdV9zY3BfbHByaT4sIDwmY3B1X3NjcF9ocHJpPjsNCj4gPiAgICAgICB9Ow0KPiA+
ICAgICB9Ow0KPiA+DQo+IFllcywgdGhlIGNoYW5uZWwgcGFydCBpcyBnb29kLg0KPiBCdXQgSSBh
bSBub3QgY29udmluY2VkIGJ5IHRoZSBuZWVkIHRvIGhhdmUgU0NNSSBzcGVjaWZpYyAidHJhbnNw
b3J0IiBtb2RlLg0KDQpTQ01JIHNwZWMgb25seSBzdXBwb3J0IHNoYXJlZCBtZW1vcnkgbWVzc2Fn
ZS4gSG93ZXZlciB0byBtYWtlIHRoaXMgZHJpdmVyDQpnZW5lcmljLCBuZWVkIHRvIHRha2UgY2Fy
ZSBvZiBtZXNzYWdlIHVzaW5nIEFSTSByZWdpc3RlcnMuDQoNCklmIHVzaW5nIHNoYXJlZCBtZW1v
cnkgbWVzc2FnZSwgdGhlIGNhbGwgd2lsbCBiZQ0KaW52b2tlX3NtY19tYm94X2ZuKGZ1bmN0aW9u
X2lkLCBjaGFuX2lkLCAwLCAwLCAwLCAwLCAwLCAwKTsNCklmIHVzaW5nIEFSTSByZWdpc3RlcnMg
dG8gdHJhbnNmZXIgbWVzc2FnZSwgdGhlIGNhbGwgd2lsbCBiZQ0KaW52b2tlX3NtY19tYm94X2Zu
KGNtZC0+YTAsIGNtZC0+YTEsIGNtZC0+YTIsIGNtZC0+YTMsIA0KY21kLT5hNCwgY21kLT5hNSwg
Y21kLT5hNiwgY21kLT5hNyk7DQoNClNvIEkgYWRkZWQgInRyYW5zcG9ydHMiIG1vZGUuDQoNCkNv
ZGUgYXMgYmVsb3c6DQogICAgICAgIGlmIChjaGFuX2RhdGEtPmZsYWdzICYgQVJNX1NNQ19NQk9Y
X01FTV9UUkFOUykgew0KICAgICAgICAgICAgICAgIGlmIChjaGFuX2RhdGEtPmZ1bmN0aW9uX2lk
ICE9IFVJTlRfTUFYKQ0KICAgICAgICAgICAgICAgICAgICAgICAgZnVuY3Rpb25faWQgPSBjaGFu
X2RhdGEtPmZ1bmN0aW9uX2lkOw0KICAgICAgICAgICAgICAgIGVsc2UNCiAgICAgICAgICAgICAg
ICAgICAgICAgIGZ1bmN0aW9uX2lkID0gY21kLT5hMDsNCiAgICAgICAgICAgICAgICBjaGFuX2lk
ID0gY2hhbl9kYXRhLT5jaGFuX2lkOw0KICAgICAgICAgICAgICAgIHJldCA9IGludm9rZV9zbWNf
bWJveF9mbihmdW5jdGlvbl9pZCwgY2hhbl9pZCwgMCwgMCwgMCwgMCwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgMCk7DQogICAgICAgIH0gZWxzZSB7DQogICAg
ICAgICAgICAgICAgcmV0ID0gaW52b2tlX3NtY19tYm94X2ZuKGNtZC0+YTAsIGNtZC0+YTEsIGNt
ZC0+YTIsIGNtZC0+YTMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNtZC0+YTQsIGNtZC0+YTUsIGNtZC0+YTYsIGNtZC0+YTcpOw0KICAgICAgICB9DQoNCg0KUGVy
IFN1ZGVlcCdzIGNvbW1lbnRzIGluIHByZXZpb3VzIHZlcnNpb24sIGJldHRlciBwYXNzIGNoYW5f
aWQNCnRvIHNlY3VyZSBmaXJtd2FyZS4NCklmIGRyb3AgdGhlICJ0cmFuc3BvcnRzIiBtb2RlLCBJ
IGRvIG5vdCBoYXZlIGEgZ29vZCBpZGVhIGhvdyB0byBkaWZmZXJlbnRpYXRlDQp0aGUgdHdvIGNh
c2VzLCByZWcgYW5kIG1lbS4gQW55IHN1Z2dlc3Rpb25zPw0KDQpUaGFua3MsDQpQZW5nLg0KDQoN
Cj4gDQo+IHRoYW5rcw0K
