Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B787120643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a7NbhjeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfCSMGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:06:31 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:56967
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbfCSMGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDxC32/6Ct0nmE/TUoMV/kN0mp8yy43Q/L9/Q2fVM7s=;
 b=a7NbhjeQDDtqCNVz7d60tMxY1E4lpiZmToCI/HwNyHx1uuu7tzZELqtQMCNNM2MXRPNJsOmNMWNIOCoE6kHNxfDBU6R80ehv0RhtyPayaT9COfO6/gDxC6K2p069seiN3nVge4HK4ArxqoLO+VvTH/Wky9QED9Jsu9RZj/qckWU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 12:06:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::a51f:134d:b530:f185%5]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 12:06:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm: use memblocks_present
Thread-Topic: [PATCH] arm: use memblocks_present
Thread-Index: AQHUwgpk6mha5pabokK36jjcALV7pqXcbD0AgDamY4A=
Date:   Tue, 19 Mar 2019 12:06:26 +0000
Message-ID: <AM0PR04MB4481452226EC21AA7B90735288400@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190211131602.3294-1-peng.fan@nxp.com>
 <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
In-Reply-To: <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8b17759-9706-48f0-609c-08d6ac635053
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5299;
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB5299F51DA6DC5C0D87A66B2688400@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(13464003)(189003)(199004)(71190400001)(102836004)(316002)(99286004)(54906003)(26005)(186003)(71200400001)(68736007)(6116002)(97736004)(3846002)(5660300002)(86362001)(2906002)(52536014)(76176011)(53546011)(229853002)(7696005)(11346002)(6506007)(66066001)(446003)(305945005)(44832011)(8676002)(9686003)(55016002)(81166006)(81156014)(105586002)(6916009)(256004)(25786009)(33656002)(486006)(4326008)(53936002)(6306002)(476003)(7416002)(6436002)(478600001)(45080400002)(74316002)(966005)(7736002)(14454004)(6246003)(8936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rXYVT6DJ/u7VchkIm+C8avL64aB9J6jWCW/g7FNkM06swhZlGg3ZpZLq/kRr06aQGgPe8OfVPOTPFh/R5dcGwju3dzn9cvxO/K/32nbnPmcloXEkYR32j5maFlL5qY2bgFtQvObKUd/ifEEM8nEsB7zCYqQV0Mhu3LR36MuMyu+I1WrwvQdRUja0ZRm0+tEOZ3h1WJhip2W3RFo5HHCZvwnlWktri19/MTTggXH/hn60asLq8gn33oIIdbycLYwdO/oUWqqC617XbG87kZQxHjFuQ1c0/mwF94QRpAIyH6ERwc+CA4CIR28b3dVAqjnf8LqVYbJ+7NuE075ptzu3L3l93vrpO2nm8nhCLNzlAg1zG5b8oTxZUC4PbTaILxrDpWsY+cr6Sc4rlHsybCN/1xkD1YuzOt6rdCbczaPJZ2w=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b17759-9706-48f0-609c-08d6ac635053
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 12:06:26.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNz
ZWxsIEtpbmcgLSBBUk0gTGludXggYWRtaW4gW21haWx0bzpsaW51eEBhcm1saW51eC5vcmcudWtd
DQo+IFNlbnQ6IDIwMTnE6jLUwjEzyNUgMToyNw0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+IENjOiBhcm5kQGFybmRiLmRlOyBycHB0QGxpbnV4LnZuZXQuaWJtLmNvbTsgcm9i
aEBrZXJuZWwub3JnOw0KPiBmLmZhaW5lbGxpQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzsgbWhvY2tvQHN1c2UuY29tOw0KPiByb3N0ZWR0QGdvb2RtaXMub3JnOyBuaWNvbGFz
LnBpdHJlQGxpbmFyby5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdmFuLmZyZWVuaXhAZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTogdXNlIG1lbWJsb2Nrc19wcmVzZW50DQo+IA0K
PiBPbiBNb24sIEZlYiAxMSwgMjAxOSBhdCAwMTowNDo1OVBNICswMDAwLCBQZW5nIEZhbiB3cm90
ZToNCj4gPiBhcm1fbWVtb3J5X3ByZXNlbnQgaXMgZG9pbmcgc2FtZSB0aGluZyBhcyBtZW1ibG9j
a3NfcHJlc2VudCwgc28gbGV0J3MNCj4gPiB1c2UgY29tbW9uIGNvZGUgbWVtYmxvY2tzX3ByZXNl
bnQgaW5zdGVhZCBvZiBwbGF0Zm9ybSBzcGVjaWZpYw0KPiA+IGFybV9tZW1vcnlfcHJlc2VudC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAN
Cj4gTG9va3MgZ29vZCwgcGxlYXNlIHB1dCBpdCBpbiB0aGUgcGF0Y2ggc3lzdGVtLCB0aGFua3Mu
ICBEZXRhaWxzIGluIG15DQo+IHNpZ25hdHVyZS4NCg0KV291bGQgeW91IGFwcGx5IHRoaXMgcGF0
Y2g/IEkgZG8gbm90IGZpbmQgdGhpcyBwYXRjaCBpbiB5b3VyIHRyZWUuDQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL21tL2luaXQuYyB8IDE3ICstLS0tLS0t
LS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTYgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbW0vaW5pdC5jIGIvYXJjaC9h
cm0vbW0vaW5pdC5jIGluZGV4DQo+ID4gNDc4ZWE4YjdkYjg3Li42YzUwZGQ0MDdiYTggMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm0vbW0vaW5pdC5jDQo+ID4gKysrIGIvYXJjaC9hcm0vbW0vaW5p
dC5jDQo+ID4gQEAgLTE4MiwyMSArMTgyLDYgQEAgaW50IHBmbl92YWxpZCh1bnNpZ25lZCBsb25n
IHBmbikNCj4gPiBFWFBPUlRfU1lNQk9MKHBmbl92YWxpZCk7ICAjZW5kaWYNCj4gPg0KPiA+IC0j
aWZuZGVmIENPTkZJR19TUEFSU0VNRU0NCj4gPiAtc3RhdGljIHZvaWQgX19pbml0IGFybV9tZW1v
cnlfcHJlc2VudCh2b2lkKSAteyAtfSAtI2Vsc2UgLXN0YXRpYyB2b2lkDQo+ID4gX19pbml0IGFy
bV9tZW1vcnlfcHJlc2VudCh2b2lkKSAtew0KPiA+IC0Jc3RydWN0IG1lbWJsb2NrX3JlZ2lvbiAq
cmVnOw0KPiA+IC0NCj4gPiAtCWZvcl9lYWNoX21lbWJsb2NrKG1lbW9yeSwgcmVnKQ0KPiA+IC0J
CW1lbW9yeV9wcmVzZW50KDAsIG1lbWJsb2NrX3JlZ2lvbl9tZW1vcnlfYmFzZV9wZm4ocmVnKSwN
Cj4gPiAtCQkJICAgICAgIG1lbWJsb2NrX3JlZ2lvbl9tZW1vcnlfZW5kX3BmbihyZWcpKTsNCj4g
PiAtfQ0KPiA+IC0jZW5kaWYNCj4gPiAtDQo+ID4gIHN0YXRpYyBib29sIGFybV9tZW1ibG9ja19z
dGVhbF9wZXJtaXR0ZWQgPSB0cnVlOw0KPiA+DQo+ID4gIHBoeXNfYWRkcl90IF9faW5pdCBhcm1f
bWVtYmxvY2tfc3RlYWwocGh5c19hZGRyX3Qgc2l6ZSwgcGh5c19hZGRyX3QNCj4gPiBhbGlnbikg
QEAgLTI5Miw3ICsyNzcsNyBAQCB2b2lkIF9faW5pdCBib290bWVtX2luaXQodm9pZCkNCj4gPiAg
CSAqIFNwYXJzZW1lbSB0cmllcyB0byBhbGxvY2F0ZSBib290bWVtIGluIG1lbW9yeV9wcmVzZW50
KCksDQo+ID4gIAkgKiBzbyBtdXN0IGJlIGRvbmUgYWZ0ZXIgdGhlIGZpeGVkIHJlc2VydmF0aW9u
cw0KPiA+ICAJICovDQo+ID4gLQlhcm1fbWVtb3J5X3ByZXNlbnQoKTsNCj4gPiArCW1lbWJsb2Nr
c19wcmVzZW50KCk7DQo+ID4NCj4gPiAgCS8qDQo+ID4gIAkgKiBzcGFyc2VfaW5pdCgpIG5lZWRz
IHRoZSBib290bWVtIGFsbG9jYXRvciB1cCBhbmQgcnVubmluZy4NCj4gPiAtLQ0KPiA+IDIuMTYu
NA0KPiA+DQo+ID4NCj4gDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbToNCj4gaHR0cHM6Ly9l
bWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
Rnd3DQo+IHcuYXJtbGludXgub3JnLnVrJTJGZGV2ZWxvcGVyJTJGcGF0Y2hlcyUyRiZhbXA7ZGF0
YT0wMiU3QzAxJTdDcGUNCj4gbmcuZmFuJTQwbnhwLmNvbSU3Q2I3MTBjZTlmMTRjOTQyNDYzYzdi
MDhkNjkxMGY1NDhhJTdDNjg2ZWExZDNiDQo+IGMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzY4NTU4OTIzNTk5ODYwOTYmYW1wO3NkYXQNCj4gYT03eXFVSlZack5sNWx4VXduN2cw
Q3pnRjl5Zzc2NEFJZWlWRzd3SWslMkZndDAlM0QmYW1wO3Jlc2VydmVkPQ0KPiAwDQo+IEZUVEMg
YnJvYWRiYW5kIGZvciAwLjhtaWxlIGxpbmUgaW4gc3VidXJiaWE6IHN5bmMgYXQgMTIuMU1icHMg
ZG93biA2MjJrYnBzDQo+IHVwIEFjY29yZGluZyB0byBzcGVlZHRlc3QubmV0OiAxMS45TWJwcyBk
b3duIDUwMGticHMgdXANCg==
