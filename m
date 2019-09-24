Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF661C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1920882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pmy/NP8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408831AbfIXCzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:55:13 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:32676
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbfIXCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:55:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GESaykoAR2nUCoh7v3fA76DTNUNGsFZdt/3kqJKe6lCcldtAql+nWSJwjuSp/+Y2epNo3tZzqbea0Y6C2rz9m1HVWnc4mhdPZ4SCwlu45bFLVkUHL4PdhYoLW7MQNHd+cufgrTWyx/RADWPv+N8/hmvLvjjaVK/Et5yanBpzm6Tu00xdeH+sotjd+ZjbqoWoroOF/UGwr1yZbKicMyfhJRQ7oX1u7irs4UIbr+LQZLpYVTdwc62DH8tvQ3Sja3FYbYACEzPWVZGr/hXyhUjGP/u5MQkcQsKaQ0zgCvJfzB8nGOnvil6BZ4+wBEnk9/H8jtEvw4X7tyf562nAcYcYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjl4MKyaiL/mqRDszJCfjHKT/WoFTDMaW0kLmCM2dGw=;
 b=dP71ocDUftQHUxfEA0leFFvyapWM7A5DUnlspiEzv7wMQRfOoxKOLfoEN8Z2bENnY9Eo9/a4J97vpCFlzrroPQAEH3vuFxqUtq5Jz5M9MiFGKtx5lP0Bc2emuB/LrbLXrkgE0RhqHPJp5abyTU+9k9kCtWMkuks5zj3svmB0/SD1l/0uKD60BI8KPRi35XaQ868Gm3yijAUtSJyuE6iRX9VQJ65f6RlIIsPPwduMFwOd6r39DIGFl8f+RxPWXCDs9BLzjUpZ6IH3RrduKw87WyoypYPG4GHrX1yHgrcHixdU8cTBjPiicEMGNhoilEKJeA0ZWasbcarV64olk+dXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjl4MKyaiL/mqRDszJCfjHKT/WoFTDMaW0kLmCM2dGw=;
 b=pmy/NP8BUTxptP2YI+O5VMUm4rBw0/5IHEKmn1CZvR1qNhjZR+RMoSqCkfcpcYLFn8xGXS1YXfb70zw/bCEMzDCIF0K6506+Va+IETeF3oH73WG7v9nmrKeEmLg7OSyeyPTmlTt0ehYPMsGG181NpKumz911j3OQXmF4W4+QD6M=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6291.eurprd04.prod.outlook.com (20.179.33.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 02:54:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 02:54:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V8 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V8 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVcnVfRZj6+kc000W2JZMWqMWPIac6ICmAgAABN5A=
Date:   Tue, 24 Sep 2019 02:54:29 +0000
Message-ID: <AM0PR04MB4481500C3000D2CCEE548DC288840@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1569287538-10854-1-git-send-email-peng.fan@nxp.com>
 <1569287538-10854-3-git-send-email-peng.fan@nxp.com>
 <1f01ea8e-8953-82ae-933c-721385dc0c13@gmail.com>
In-Reply-To: <1f01ea8e-8953-82ae-933c-721385dc0c13@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c9f9dc-c759-4f39-e432-08d7409a8509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6291;
x-ms-traffictypediagnostic: AM0PR04MB6291:|AM0PR04MB6291:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62910133B3C8EE8273E0EA6388840@AM0PR04MB6291.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(102836004)(316002)(110136005)(6116002)(66946007)(64756008)(66556008)(66476007)(76116006)(53546011)(54906003)(86362001)(66446008)(5660300002)(44832011)(52536014)(6246003)(71200400001)(71190400001)(305945005)(2201001)(11346002)(446003)(81156014)(81166006)(2906002)(3846002)(7736002)(9686003)(476003)(74316002)(8676002)(6306002)(55016002)(256004)(486006)(6436002)(66066001)(2501003)(45080400002)(15650500001)(966005)(14454004)(4326008)(478600001)(76176011)(186003)(8936002)(26005)(99286004)(229853002)(6506007)(33656002)(25786009)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6291;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ASCQ8gIcHqk4t395BdK9OdVSjROl9+fZYI7025NBpIfEnd4VAebqXSCWdX84D8NIp7F0r8/tHcIlXGqKxEiO78rEhnuMbslRCyTF86zmoquwyG1ly4Ge5jzWQbOFdHVTWjjViNs2cw6yKa0kn/O+tebAewyBDg95RKXsMkANZOVcdU6NWMPDCVjly+FRBjUMyPv+u89clQ/hZTFJisGV+NfSiy3KfkXoGRe/jAZVtaF/R4EhxP1ga287n0o+a8DGM0PZ3A7BG87ML3cvq3wikPqT4ofWtwRg8fgvY2IHTuIshSGl+EUkHFiHCMKUcYtmgLEXTi/LG0m+bWEWRGKofmdudxjLibWztWbM07/FO84RGXshSakX60SyfyLq6A/L6z0JCl9as6qY2iCQeRBvObg16Yn9k+YwUgY9HN5RCuA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c9f9dc-c759-4f39-e432-08d7409a8509
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 02:54:29.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TggDN0lVKDSNLoMmAKKBcsjRoXAIW7qGd5wTKNc6MZvnk+rB6awYkFTI5+Bkx1JhcMjBXrLc3+lJ3X64zT0qug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmxvcmlhbg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjggMi8yXSBtYWlsYm94OiBpbnRy
b2R1Y2UgQVJNIFNNQyBiYXNlZCBtYWlsYm94DQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gOS8y
My8yMDE5IDY6MTQgUE0sIFBlbmcgRmFuIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBtYWlsYm94IGRyaXZlciBpbXBsZW1lbnRzIGEg
bWFpbGJveCB3aGljaCBzaWduYWxzIHRyYW5zbWl0dGVkDQo+ID4gZGF0YSB2aWEgYW4gQVJNIHNt
YyAoc2VjdXJlIG1vbml0b3IgY2FsbCkgaW5zdHJ1Y3Rpb24uIFRoZSBtYWlsYm94DQo+ID4gcmVj
ZWl2ZXIgaXMgaW1wbGVtZW50ZWQgaW4gZmlybXdhcmUgYW5kIGNhbiBzeW5jaHJvbm91c2x5IHJl
dHVybiBkYXRhDQo+ID4gd2hlbiBpdCByZXR1cm5zIGV4ZWN1dGlvbiB0byB0aGUgbm9uLXNlY3Vy
ZSB3b3JsZCBhZ2Fpbi4NCj4gPiBBbiBhc3luY2hyb25vdXMgcmVjZWl2ZSBwYXRoIGlzIG5vdCBp
bXBsZW1lbnRlZC4NCj4gPiBUaGlzIGFsbG93cyB0aGUgdXNhZ2Ugb2YgYSBtYWlsYm94IHRvIHRy
aWdnZXIgZmlybXdhcmUgYWN0aW9ucyBvbiBTb0NzDQo+ID4gd2hpY2ggZWl0aGVyIGRvbid0IGhh
dmUgYSBzZXBhcmF0ZSBtYW5hZ2VtZW50IHByb2Nlc3NvciBvciBvbiB3aGljaA0KPiA+IHN1Y2gg
YSBjb3JlIGlzIG5vdCBhdmFpbGFibGUuIEEgdXNlciBvZiB0aGlzIG1haWxib3ggY291bGQgYmUg
dGhlIFNDUA0KPiA+IGludGVyZmFjZS4NCj4gPg0KPiA+IE1vZGlmaWVkIGZyb20gQW5kcmUgUHJ6
eXdhcmEncyB2MiBwYXRjaA0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRnBh
dGNod29yayUyRnBhdGNoJTJGODEyOTk5JTJGJmFtcDtkYXRhPTAyJTdDMDElNw0KPiBDcGVuZy5m
YQ0KPiA+DQo+IG4lNDBueHAuY29tJTdDMjk2YzdjZDIyMjVlNGNhMzJiYjgwOGQ3NDA5OWFmYjIl
N0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkDQo+ID4NCj4gOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzNzA0ODkwMTE0NDA5MTEyNiZhbXA7c2RhdGE9SkRvJTJCZTdUdA0KPiBob2k0anZlME8NCj4g
PiBTOHFlMyUyRnBqaTRnOENnUnhMN250Q1F4M0ZnJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4NCj4g
PiBDYzogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25p
cF0NCj4gDQo+ID4gK3R5cGVkZWYgdW5zaWduZWQgbG9uZyAoc21jX21ib3hfZm4pKHVuc2lnbmVk
IGludCwgdW5zaWduZWQgbG9uZywNCj4gPiArCQkJCSAgICB1bnNpZ25lZCBsb25nLCB1bnNpZ25l
ZCBsb25nLA0KPiA+ICsJCQkJICAgIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsDQo+ID4g
KwkJCQkgICAgdW5zaWduZWQgbG9uZyk7DQo+ID4gK3N0YXRpYyBzbWNfbWJveF9mbiAqaW52b2tl
X3NtY19tYm94X2ZuOw0KPiANCj4gU29ycnkgZm9yIHNwb3R0aW5nIHRoaXMgc28gbGF0ZSwgdGhl
IG9ubHkgdGhpbmcgdGhhdCBjb25jZXJucyBtZSBoZXJlIHdpdGggdGhpcw0KPiBzaW5nbGV0b24g
aXMgaWYgd2UgaGFwcGVuIHRvIGhhdmUgYm90aCBhbiBhcm0sc21jLW1ib3ggYW5kIGFybSxodmMt
bWJveA0KPiBjb25maWd1cmVkIGluIHRoZSBzeXN0ZW0sIHRoaXMgd291bGQgbm90IHdvcmsuDQoN
Clllcy4gVGhhbmtzIGZvciBzcG90dGluZyB0aGlzLg0KDQogSSBkbyBub3QgYmVsaWV2ZSB0aGlz
IGNvdWxkIGJlIGENCj4gZnVuY3Rpb25hbCB1c2UgY2FzZSwgYnV0IHdlIHNob3VsZCBwcm9iYWJs
eSBndWFyZCBhZ2FpbnN0IHRoYXQgb3IgYmV0dGVyIHlldCwNCj4gbW92ZSB0aGF0IGludG8gdGhl
IGFybV9zbWNfY2hhbl9kYXRhIHByaXZhdGUgc3RydWN0dXJlPw0KDQpBZ3JlZS4gV2lsbCBGaXgg
aW4gdjkuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gLS0NCj4gRmxvcmlhbg0K
