Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6617206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lq4deyuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEPILF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:11:05 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:33414
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfEPILF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9P/09x3Otf3gsGErdz9/UD0SkkwXeb2fIk1WzUPeYs=;
 b=lq4deyuLwrpRjJB7mWWw0LfcmVqsN98QyoMLO4Elj1Q9CDGHRpgqzv/hq2lqZ4WopKkbjUb8ySLFXcln4u6aopFR6eQ96Rch1Z9tdbYo1PkW/wsQlA2ICrbLn1oiS0eQwfZNv2G/MICmk8nyJEYCND29LXbaoH2G7RUkxhApRW0=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.177.40.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 08:10:22 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1878.028; Thu, 16 May 2019
 08:10:22 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "liviu.dudau@arm.com" <liviu.dudau@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Thread-Topic: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Thread-Index: AQHVCsfKc9H8v6XkZkyzoxWRKfwkRaZsVOSAgADQNCA=
Date:   Thu, 16 May 2019 08:10:21 +0000
Message-ID: <AM0PR04MB48658C4B7AADE1E3FFCA7ED7E20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
 <20190515154530.GX15144@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190515154530.GX15144@e110455-lin.cambridge.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01ee7b0c-068c-4bcc-434f-08d6d9d5f166
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49489FCF408CBBEE1B874958E20A0@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(13464003)(189003)(25786009)(5660300002)(52536014)(478600001)(73956011)(7736002)(2351001)(55016002)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(9686003)(4326008)(6246003)(53936002)(5640700003)(229853002)(14454004)(305945005)(86362001)(6436002)(11346002)(3846002)(446003)(71200400001)(476003)(102836004)(8936002)(26005)(2501003)(186003)(53546011)(486006)(76176011)(316002)(74316002)(66066001)(14444005)(256004)(81156014)(6916009)(8676002)(81166006)(68736007)(6506007)(2906002)(6116002)(99286004)(7696005)(54906003)(71190400001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YXf6gElhnG3Yourkloh1F4zVwIxRfifwtGq+5WWTr8le4GpETMIhX1uT9VBUhxjAcycW2qxnqbCayHgqu9VlTKPvcTtgXm/Wkv1uJbckga94DWzj6t2mCLakBdr+izei06xsfolCgbA6dZs6Cf9KeVNuHg/5nfSEy/NTOrPkzVws0TUuE4wVpP8f07WHSDT5NsuSAoEkoFNDQm6RJYv57Bq9We06/eY25A+j2kB/rzelxPvVQhhHmVE6lWzp7eqxFNWctR+YYQStL1BWpvyfFkXjhTfAj/mrWvWJQb9Wu4KlxWrcx2AzB7V6zZE9Jed+THfYqmuQ4vtKyz5ivkNWj8FyAQgEtvxCcnR1yDSMZKoCiGL1opKlkyuZ9byewDsMPyV2lunZxVZYq7ZVd1rD5ak49MSK+FUdJ7OCGYGu4tI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ee7b0c-068c-4bcc-434f-08d6d9d5f166
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 08:10:21.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGl2aXUuZHVkYXVAYXJt
LmNvbSBbbWFpbHRvOmxpdml1LmR1ZGF1QGFybS5jb21dDQo+IFNlbnQ6IDIwMTnlubQ15pyIMTXm
l6UgMjM6NDYNCj4gVG86IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT4NCj4gQ2M6IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExl
byBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW3YxXSBk
cm0vYXJtL21hbGktZHA6IERpc2FibGUgY2hlY2tpbmcgZm9yIHJlcXVpcmVkIHBpeGVsDQo+IGNs
b2NrIHJhdGUNCj4gDQo+IA0KPiBIaSBXZW4sDQoNCkhpIExpdml1LA0KDQo+IA0KPiBPbiBXZWQs
IE1heSAxNSwgMjAxOSBhdCAwMjo0MjowOEFNICswMDAwLCBXZW4gSGUgd3JvdGU6DQo+ID4gRGlz
YWJsZSBjaGVja2luZyBmb3IgcmVxdWlyZWQgcGl4ZWwgY2xvY2sgcmF0ZSBpZiBBUkNIX0xBWUVS
U0NQQUUgaXMNCj4gPiBlbmFibGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlzb24gV2Fu
ZyA8YWxpc29uLndhbmdAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5o
ZV8xQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gY2hhbmdlIGluIGRlc2NyaXB0aW9uOg0KPiA+ICAg
ICAgIC0gVGhpcyBjaGVjayB0aGF0IG9ubHkgc3VwcG9ydGVkIG9uZSBwaXhlbCBjbG9jayByZXF1
aXJlZCBjbG9jayByYXRlDQo+ID4gICAgICAgY29tcGFyZSB3aXRoIGR0cyBub2RlIHZhbHVlLiBi
dXQgd2UgaGF2ZSBzdXBwb3J0cyA0IHBpeGVsIGNsb2NrDQo+ID4gICAgICAgZm9yIGxzMTAyOGEg
Ym9hcmQuDQo+IA0KPiBTbywgeW91ciBEVCBzYXlzIHlvdXIgcGl4ZWwgY2xvY2sgcHJvdmlkZXIg
aXMgYSBmaXhlZCBjbG9jaz8gSWYgeW91IHN1cHBvcnQgbW9yZQ0KPiB0aGFuIG9uZSByYXRlLCB5
b3Ugc2hvdWxkIGluc3RlYWQgdXNlIGEgcmVhbCBwcm92aWRlciBmb3IgaXQuIEhvdyBkbyB5b3UN
Cj4gc3VwcG9ydCB0aGUgNCBwaXhlbCBjbG9ja3M/DQo+IA0KIA0KWWVzICwgdGhlIERUIG5vZGUg
b25seSBjYW4gcHJvdmlkZWQgb25lIHBpeGVsIGNsb2NrIGJ5IHVzaW5nIGEgZml4ZWQgY2xvY2su
DQpCdXQgd2UgRGlzcGxheSBQb3J0IGNvbnRyb2xsZXIgc3VwcG9ydCA0IG9yIG1vcmUgcmVzb2x1
dGlvbnMsIGVhY2ggb2Ygd2hpY2gNCnJlcXVpcmVzIGEgc2V0IG9mIHBpeGVsIGNsb2NrcyB0byBk
cml2ZSwgYW5kIHdlIGhvcGUgdGhleSBjYW4gc3dpdGNoIGFueSByZXNvbHV0aW9uDQp3ZSB3YW50
IGJ5IHNvbWUgcHJvZ3JhbSBldmVyeSB0aW1lcy4NCg0KRm9yIGV4YW1wbGUsIGlmIHdlIHNldCB0
aGF0IGZpeGVkIHBpeGVsIGNsb2NrIGlzIDI3MDAwMDAwICgyN01oeiksIGJ1dCB1c2VyIGhvcGUg
Y2FuIHNlZQ0KYSBncm91cCAxMDgwcCByZXNvbHV0aW9uIHBlbmd1aW5zIGR1cmluZyBzdGFydHVw
ICwgYW5kIGhvcGUgcGxheWluZyBhIDRrIHZpZGVvIG9uY2UNCnN5c3RlbSBib290IHVwIGRvbmUu
IA0KQnR3LCBJbiBvdXIgYm9hcmQsIHRoZSAxMDgwcCByZXNvbHV0aW9uIGlzIGRyaXZlbiBieSBh
IDE0OC41TWh6IHBpeGVsIGNsb2NrLCA0ayBpcyBkcml2ZW4NCmJ5IGEgNTk0TWh6LiAyN01oeiBv
bmx5IGNhbiBkcml2ZSA0ODBwIHJlc29sdXRpb24uDQoNClRvIG1lZXQgdGhlIGFib3ZlIHVzZXIg
cmVxdWlyZW1lbnRzLCBJIHdhcyB0byBzZXR1cCBmb2xsb3dpbmcgc3RlcHMsDQoxLiBBZGQgdGhl
ICJ2aWRlbz0xOTIweDEwODAtMzJANjAiIHRvIGJvb3RhcmdzIGNvbW1hbmQgbGluZSBbc3BlY2lm
eSBwZW5ndWlucyBzaXplXQ0KMi4gUGxheSBhIDRLIHZpZGVvIHdpdGggNGsgcmVzb2x1dGlvbiB3
aGVuIHN5c3RlbSBib290IHVwIGRvbmUuDQoNCj4gQWxzbywgbm90IHN1cmUgd2hhdCB0aGUgcGFy
YWdyYXBoIGFib3ZlIGlzIG1lYW50IHRvIGJlLiBTaG91bGQgaXQgYmUgcGFydCBvZg0KPiB0aGUg
Y29tbWl0IG1lc3NhZ2U/DQo+IA0KDQpUaGVzZSBjb21tZW50cyBqdXN0IHdhbnQgdG8gbGV0IHlv
dSBrbm93Lg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gTGl2aXUNCj4gDQo+IA0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYXJtL21hbGlkcF9jcnRjLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJt
L21hbGlkcF9jcnRjLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2NydGMuYw0K
PiA+IGluZGV4IDU2YWFkMjg4NjY2ZS4uYmI3OTIyM2Q5OTgxIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2NydGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hcm0vbWFsaWRwX2NydGMuYw0KPiA+IEBAIC0zNiwxMSArMzYsMTMgQEAgc3RhdGljIGVudW0g
ZHJtX21vZGVfc3RhdHVzDQo+ID4gbWFsaWRwX2NydGNfbW9kZV92YWxpZChzdHJ1Y3QgZHJtX2Ny
dGMgKmNydGMsDQo+ID4NCg0KQWNjb3JkaW5nIHRvIG91ciBwaXhlbCBjb25maWd1cmF0aW9uIGFi
b3ZlLA0KTm93IHRoZSB2YXJpYWJsZSByZXFfcmF0ZSB2YWx1ZSBpcyAxNDg1MDAwMDAgb3IgNTk0
MDAwMDAsIGFub3RoZXIgdmFyaWFibGUgcmF0ZSB2YWx1ZSBpcw0KMjcwMDAwMDAsIHNvIHdlIHdp
bGwgZ2V0IGEgd2FybmluZyBhbmQgZGlzcGxheSB3aWxsIGNhbm5vdCB3b3JrcyB3ZWxsLiANCg0K
V2UncmUgbm90IHN1cmUgd2hpY2ggcmVzb2x1dGlvbiBhcmUgdXNlciB3YW50LCBhbmQgd2UgYWxz
byBjYW4ndCBqdXN0IG9mZmVyZWQgb25lIHJlc29sdXRpb24NCnRvIHVzZXIuIHNvIEkgcmVtb3Zl
IHRoaXMgY2hlY2sgb24gb3VyIGJvYXJkLCBtYXliZSBpdCdzIG5vdCBnb29kIGNoYW5nZS4NCg0K
SSB3YW50IHRvIGtub3cgZG8geW91IGhhdmUgb3RoZXIgZ29vZCBzdWdnZXN0aW9uPyBUaGFua3Mu
DQoNCkJlc3QgUmVnYXJkcywNCldlbg0KDQo+ID4gICAgICAgaWYgKHJlcV9yYXRlKSB7DQo+ID4g
ICAgICAgICAgICAgICByYXRlID0gY2xrX3JvdW5kX3JhdGUoaHdkZXYtPnB4bGNsaywgcmVxX3Jh
dGUpOw0KPiA+ICsjaWZuZGVmIENPTkZJR19BUkNIX0xBWUVSU0NBUEUNCj4gPiAgICAgICAgICAg
ICAgIGlmIChyYXRlICE9IHJlcV9yYXRlKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIERS
TV9ERUJVR19EUklWRVIoInB4bGNsayBkb2Vzbid0IHN1cHBvcnQgJWxkDQo+IEh6XG4iLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlcV9yYXRlKTsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE1PREVfTk9DTE9DSzsNCj4gPiAgICAgICAgICAg
ICAgIH0NCj4gPiArI2VuZGlmDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgcmV0dXJuIE1P
REVfT0s7DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiANCj4gLS0NCj4gPT09PT09PT09PT09
PT09PT09PT0NCj4gfCBJIHdvdWxkIGxpa2UgdG8gfA0KPiB8IGZpeCB0aGUgd29ybGQsICB8DQo+
IHwgYnV0IHRoZXkncmUgbm90IHwNCj4gfCBnaXZpbmcgbWUgdGhlICAgfA0KPiAgXCBzb3VyY2Ug
Y29kZSEgIC8NCj4gICAtLS0tLS0tLS0tLS0tLS0NCj4gICAgIMKvXF8o44OEKV8vwq8NCg==
