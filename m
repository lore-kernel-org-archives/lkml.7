Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9320879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fDtDtmgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfEVPNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:13:01 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:54028
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbfEVPNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiGkAB161urwE6LNgmP9qZs/X35etwSopazKwRmACEQ=;
 b=fDtDtmgfkioFx5Opej6kXb2xIo0zn7pVffGEQPODF9qhjtH2paIh+5cKkMKQkqQWknKsFpWEYNtK8npt6VI1zrQzf/AiREUsqEZD1GNNBw2rBNso8TpKPAYZrmReQUuP/WmOcm4Fse87/NIShuFTeUdPG/o8MmDfo/Q8Rsvt/Ug=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4725.eurprd05.prod.outlook.com (10.168.22.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 15:12:53 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864%7]) with mapi id 15.20.1900.010; Wed, 22 May 2019
 15:12:53 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Thread-Index: AQHVDNjerktpZH/kD0q2FkOL+YtZAKZ0L50AgAAd9ECAABiUgIAAFpbggAC/kQCAAgbXQA==
Date:   Wed, 22 May 2019 15:12:53 +0000
Message-ID: <DB6PR05MB32231754807FF4CB957C0FACA1000@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-1-git-send-email-lsun@mellanox.com>
 <20190520155658.GA14165@kroah.com>
 <DB6PR05MB32232CA5DD05D1A923A28215A1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <20190520191209.GA29776@kroah.com>
 <DB6PR05MB3223F25A2E2B78053FE96D5BA1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <CAK8P3a0AfEo8+EDBoOS8PfOeKGZUhgXoT7xz+pG9YNUDPdfR_A@mail.gmail.com>
In-Reply-To: <CAK8P3a0AfEo8+EDBoOS8PfOeKGZUhgXoT7xz+pG9YNUDPdfR_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1329ac0-b745-4224-9412-08d6dec7f678
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB4725;
x-ms-traffictypediagnostic: DB6PR05MB4725:
x-microsoft-antispam-prvs: <DB6PR05MB4725C1BD0410AA13D52D1D0BA1000@DB6PR05MB4725.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(52314003)(13464003)(199004)(189003)(66066001)(3846002)(6116002)(2906002)(33656002)(74316002)(5660300002)(52536014)(86362001)(68736007)(256004)(446003)(14444005)(71200400001)(71190400001)(186003)(476003)(11346002)(229853002)(9686003)(66446008)(6436002)(73956011)(66476007)(76116006)(25786009)(316002)(54906003)(55016002)(110136005)(26005)(66556008)(64756008)(66946007)(486006)(6246003)(53546011)(6506007)(76176011)(8936002)(4326008)(7696005)(53936002)(478600001)(102836004)(14454004)(81166006)(81156014)(8676002)(99286004)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4725;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h2qRCb/N1GB5S8plxA7XHKluf4MOikGOT9WcDgFU3lP9M67eW8PPWUfSexPZXoTSHfntlXzmFtlfjmQrdRAVpgG8EG/cPLyh9fS/TDjKSAq81qH2OQ2wCOzaXnJBZ0UXrX6dsgO+j4j4fA/IrbWF879rZ57/kcsIi6qRwbgO6EZoLBizn6SYvrbFKAlwRz7Yx+gTwkx8E1oDYMXTb3f3RDv24P70M/EAj8VMxKjIGP/rfD/JR91gc8S8wgJRB0rPpaqi4Cm8RbnTLUh3sSXMm+axjk0019PcYSrdjR9+qBIUnEskH4Aqbq6JZh1M1sxVQkL05089MfOooCXJOmqKGWm798ra1+m4M02rH9QanF5Ht5EaYFgDgxIbqjd11h9RdVzAH3zgRVgE8mL7E9IVw0zJVlvEnq7oPLqTIeAGTH0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1329ac0-b745-4224-9412-08d6dec7f678
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 15:12:53.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFybmQgZm9yIHRoZSBjb21tZW50cyEgUGxlYXNlIGFsc28gc2VlIG15IHJlc3BvbnNl
IGJlbG93Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMSwgMjAxOSAzOjU5
IEFNDQo+IFRvOiBMaW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCj4gQ2M6IEdyZWcgS0gg
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJh
ZGVhZC5vcmc+OyBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBWYWRpbQ0KPiBQ
YXN0ZXJuYWsgPHZhZGltcEBtZWxsYW5veC5jb20+OyBEYXZpZCBXb29kcyA8ZHdvb2RzQG1lbGxh
bm94LmNvbT47IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMl0gcGxh
dGZvcm0vbWVsbGFub3g6IEFkZCBib290Y3RsIGRyaXZlciBmb3IgTWVsbGFub3ggQmx1ZUZpZWxk
IFNvYw0KPiANCj4gT24gTW9uLCBNYXkgMjAsIDIwMTkgYXQgMTA6NDQgUE0gTGltaW5nIFN1biA8
bHN1bkBtZWxsYW5veC5jb20+IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+
ID4gU2VudDogTW9uZGF5LCBNYXkgMjAsIDIwMTkgMzoxMiBQTQ0KPiA+ID4gVG86IExpbWluZyBT
dW4gPGxzdW5AbWVsbGFub3guY29tPg0KPiA+ID4gQ2M6IEFuZHkgU2hldmNoZW5rbyA8YW5keUBp
bmZyYWRlYWQub3JnPjsgRGFycmVuIEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsgVmFkaW0g
UGFzdGVybmFrIDx2YWRpbXBAbWVsbGFub3guY29tPjsNCj4gRGF2aWQNCj4gPiA+IFdvb2RzIDxk
d29vZHNAbWVsbGFub3guY29tPjsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djUgMS8yXSBwbGF0Zm9ybS9tZWxsYW5veDogQWRkIGJvb3RjdGwgZHJpdmVyIGZvciBNZWxsYW5v
eCBCbHVlRmllbGQgU29jDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBNYXkgMjAsIDIwMTkgYXQgMDY6
MDc6NDRQTSArMDAwMCwgTGltaW5nIFN1biB3cm90ZToNCj4gPiA+ID4gPiA+ICtzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBtbHhiZl9ib290Y3RsX2RyaXZlciA9IHsNCj4gPiA+ID4gPiA+
ICsgICAgICAgLnByb2JlID0gbWx4YmZfYm9vdGN0bF9wcm9iZSwNCj4gPiA+ID4gPiA+ICsgICAg
ICAgLmRyaXZlciA9IHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAubmFtZSA9ICJtbHhi
Zi1ib290Y3RsIiwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAuZ3JvdXBzID0gbWx4YmZf
Ym9vdGN0bF9ncm91cHMsDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgLmFjcGlfbWF0Y2hf
dGFibGUgPSBtbHhiZl9ib290Y3RsX2FjcGlfaWRzLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5
IGlzIGFuIGFjcGkgZHJpdmVyIGEgcGxhdGZvcm0gZHJpdmVyPyAgSXNuJ3QgdGhlcmUgYSAicmVh
bCIgYWNwaQ0KPiA+ID4gPiA+IGRyaXZlciBpbnRlcmZhY2UgeW91IHNob3VsZCBiZSB0aWVpbmcg
aW50byBpbnN0ZWFkPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT25seSB1c2UgYSBwbGF0Zm9ybSBk
cml2ZXIgYXMgYW4gYWJzb2x1dGUgbGFzdCByZXNvcnQuICBJIGRvbid0IHRoaW5rDQo+ID4gPiA+
ID4gdGhhdCBpcyB0aGUgY2FzZSBoZXJlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgZHJpdmVyIGlz
IHRyeWluZyB0byBjb25maWd1cmUgYm9vdC1zd2FwcGluZyBhbmQgZGlzcGxheSBzZWN1cmUgc3Rh
dGUsDQo+ID4gPiA+IGFuZCBpcyBkZWZpbmVkL2luaXRpYXRlZCBpbiBBQ1BJIHRhYmxlIGluIFVF
RkkuIEl0IHNlZW1zIGEgbGl0dGxlIGhhcmQgdG8NCj4gPiA+ID4gY2F0ZWdvcml6ZSB0aGlzIGRy
aXZlciB0byBhbnkgZXhpc3Rpbmcgc3Vic3lzdGVtLiBBbnkgc3VnZ2VzdGlvbg0KPiA+ID4gPiB3
aGVyZSBpdCBtaWdodCBiZSBhIGJldHRlciBmaXQgKGxpa2UgZHJpdmVycy9taXNjLCBkcml2ZXJz
L2Zpcm13YXJlLCBldGMpPw0KPiA+ID4gPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIG1pc3VuZGVy
c3RhbmQgdGhlIGNvbW1lbnRzLiBUaGFua3MhLg0KPiA+ID4NCj4gPiA+IFRoZSBjb21tZW50IHdh
cyBhc2tpbmcgd2h5IGFuIGFjcGkgZHJpdmVyIGlzIGEgcGxhdGZvcm0gZHJpdmVyLCBidXQgdGhl
bg0KPiA+ID4gSSB3ZW50IGFuZCBsb29rZWQgbm93IGF0IGEgYnVuY2ggb2YgYWNwaSBkcml2ZXJz
LCBhbmQgdGhleSBhbGwgYXJlDQo+ID4gPiBwbGF0Zm9ybSBkcml2ZXJzIDooDQo+ID4gPg0KPiA+
ID4gQW55d2F5LCBkcml2ZXJzL2FjcGkvIHNlZW1zIGxpa2UgdGhlIGJlc3QgcGxhY2UgZm9yIHRo
aXMgZmlsZSwgcmlnaHQ/DQo+ID4NCj4gPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlICJk
cml2ZXJzL2FjcGkiIGlzIG1haW5seSBmb3IgdGhlIGFjcGkgY29tbW9uIGNvZGUuDQo+ID4gVGhl
IHZlbmRvciBvciBwbGF0Zm9ybSBzcGVjaWZpYyBkcml2ZXJzIGFyZSBzcHJlYWQgaW4gb3RoZXIg
dmFyaW91cyBkaXJlY3RvcmllcywNCj4gPiBtb3N0IG9mIHdoaWNoIGFyZSAncGxhdGZvcm0nIGRy
aXZlcnMuDQo+IA0KPiBJdCBkZXBlbmRzIG9uIGhvdyBjbG9zZWx5IHlvdSBhcmUgZm9sbG93aW5n
IHRoZSBhY3BpIHNwZWNpZmljYXRpb24uDQo+IElmIHlvdSBqdXN0IGltcGxlbWVudCBhY2Nlc3Mg
dG8gYSBzdGFuZGFyZCBBQ1BJIGZlYXR1cmUsIG9yIHlvdSBoYXZlDQo+IGFkZGVkIHlvdXIgaW50
ZXJmYWNlIHRvIHRoZSBBQ1BJIHNwZWNpZmljYXRpb24sIHRoZW4gdGhlIGRyaXZlcg0KPiBzaG91
bGQgd29yayBvbiBhbnkgc3lzdGVtIHRoYXQgc3VwcG9ydHMgdGhpcyBmZWF0dXJlLg0KPiANCj4g
PiBGb3IgdGhpcyBkcml2ZXIsIHdlIGRpZG4ndCBmaW5kIGJldHRlciBzdWItY29tcG9uZW50IGZv
ciBpdCwgdGh1cyBwdXQgaXQgdW5kZXINCj4gPiAnZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veCcg
d2hpY2ggaXMgdmVuZG9yIHNwZWNpZmljIGRyaXZlciBieSBpdHMgbmFtZS4NCj4gDQo+IGRyaXZl
cnMvcGxhdGZvcm0vbWVsbGFub3gvIHdvdWxkIGJlIGEgZ29vZCBwbGFjZSBmb3IgZHJpdmVycyBy
dW5uaW5nIG9uDQo+IGEgaG9zdCBwbGF0Zm9ybSB3aXRoIGEgYmx1ZWZpZWxkIGFjY2VsZXJhdG9y
IGNhcmQgYXMgYW4gYWRkLW9uLCBidXQgYXMgSQ0KPiB1bmRlcnN0YW5kLCB0aGlzIGlzIGEgZHJp
dmVyIHRoYXQgYWN0dWFsbHkganVzdCBydW5zIGluIExpbnV4IG9uIHRoZSBibHVlZmllbGQNCj4g
aXRzZWxmLCBzbyBpdCBzaG91bGQgZ28gaW4gYSBkaWZmZXJlbnQgcGxhY2UuDQoNClllcywgdGhl
IGRyaXZlciBpcyBhY3R1YWxseSBydW5uaW5nIG9uIHRoZSBibHVlZmllbGQgaXRzZWxmLg0KU28g
bG9va3MgbGlrZSB3ZSdsbCBuZWVkIHRvIGZpbmQgYW5vdGhlciBsb2NhdGlvbiBmb3IgaXQuDQoN
Cj4gDQo+IFdlIHVzZSBkcml2ZXJzL3NvYy8gZm9yIHRoaW5ncyB0aGF0IGFyZSBzcGVjaWZpYyB0
byBvbmUgU29DLCBhbmQgdGhhdA0KPiBhcmUgdHlwaWNhbGx5IHVzZWQgYnkgb3RoZXIgZHJpdmVy
cywgYnV0IHRoYXQgZG9uJ3QgaGF2ZSAoYW5kIHNob3VsZCBub3QNCj4gaGF2ZSkgYSBnZW5lcmlj
IGFic3RyYWN0aW9uLCB3aGljaCBwcm9iYWJseSBpcyBub3QgdGhlIGNhc2UgaGVyZSBlaXRoZXIu
DQoNCkkgZGlkIGEgJ2dyZXAnIGZvciAnbW9kdWxlX3BsYXRmb3JtX2RyaXZlcicgYW5kICdERVZJ
Q0VfQVRUUicgdW5kZXINCmRyaXZlcnMvc29jLCBhbmQgZm91bmQgcXVpdGUgc29tZSB1bmRlciBk
cml2ZXJzL3NvYy4gVGhpcyAnYm9vdGN0bCcgZHJpdmVyDQppcyBTb0Mgc3BlY2lmaWMgYW5kIHRy
aWVzIHRvIGNvbnRyb2wgdGhlIGxvdy1sZXZlbCBib290IHBhcnRpdGlvbiAobm90DQpMaW51eCBy
ZWxhdGVkKS4gUGxlYXNlIGFsc28gc2VlIG15IHJlc3BvbnNlIHRvIE1hcmsncyBjb21tZW50cyBh
Ym91dA0KdGhlIFNvQyBib290IGZsb3cuIFByb2JhYmx5IHRoZSAnZHJpdmVycy9zb2MnIHdvdWxk
IGJlIGJldHRlciBmaXQgZm9yDQp0aGlzIGRyaXZlcj8gUGxlYXNlIGFkdmlzZS4NCg0KPiANCj4g
V2hhdCB3ZSBkbyBoYXZlIGluIGRyaXZlcnMvcG93ZXIvcmVzZXQgaXMgYSBjb3VwbGUgb2YgZHJp
dmVycyB0aGF0DQo+IHNldCB0aGUgInJlYm9vdCByZWFzb24iLCBjb21tdW5pY2F0aW5nIHRoYXQg
dG8gdGhlIGZpcm13YXJlIGZvciB0aGUNCj4gbmV4dCBib290LCB1c2luZyB0aGUgcmVib290X21v
ZGVfcmVnaXN0ZXIoKSBpbnRlcmZhY2UuIEkgZG9uJ3QNCj4ga25vdyB0b28gbXVjaCBhYm91dCB0
aGF0IGludGVyZmFjZSwgYnV0IG1heWJlIHlvdSBjYW4gdXNlIHRoYXQNCj4gaW5zdGVhZCBvZiBh
ZGRpbmcgYW5vdGhlciBzeXNmcyBpbnRlcmZhY2U/DQoNCkkgY2hlY2tlZCB0aGUgaGlzdG9yeSBv
ZiB0aGUgJ3JlYm9vdF9tb2RlJy4gTG9va3MgbGlrZSBpdCB0cmllcyB0bw0KY29udHJvbCBob3cg
TGludXggYm9vdHMsIHdoaWNoIGlzIGRpZmZlcmVudCB0aGFuIHdoYXQgdGhpcyBjb21taXQNCmRv
ZXMuIFRoaXMgY29tbWl0IHRyaWVzIHRvIGNvbnRyb2wgaG93IEFURi9VRUZJIGJvb3RzLCBub3Qg
aG93DQpMaW51eCBib290cy4NCg0KPiANCj4gSWYgeW91IGhhdmUgYSBjb21wbGV4IGZpcm13YXJl
IG9uIHRoZSBzeXN0ZW0gdGhhdCB5b3UgY2FuIHRhbGsNCj4gdG8sIHRoZXJlIGlzIGFsc28gZHJp
dmVycy9maXJtd2FyZS8gYXMgYW5vdGhlciBvcHRpb24gdG8gcHV0DQo+IGFic3RyYWN0aW9ucyBp
bnRvLg0KDQpJIGZlZWwgbGlrZSAnZHJpdmVycy9zb2MnIG1pZ2ggYmUgYmV0dGVyIGZpdC4gV2Ug
Y291bGQgY2VydGFpbmx5IHRyeQ0KZHJpdmVycy9maXJtd2FyZS8gYW5kIGFic3RyYWN0aW9ucyBp
ZiB5b3UgdGhpbmsgJ2RyaXZlcnMvc29jJyBpcyBub3QgDQphIGdvb2Qgb3B0aW9uLg0KDQo+IA0K
PiAgICAgICAgICBBcm5kDQo=
