Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB25C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D52084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NXxnl1vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfFTITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:19:46 -0400
Received: from mail-eopbgr790051.outbound.protection.outlook.com ([40.107.79.51]:26589
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfFTITq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxFLcLXTH3avGmzL0qDla75pWUlBsAhIzMnBQJy0aFg=;
 b=NXxnl1vcPo8H6RKEl6nP2DhhJliI+ZVjSiNZmvU4gh9Ld1Gs7MidJI3j2X5gm9VU5FAFTRYuCT0qkj9l80pvXLmNSgbx4GiQH4o0awtc1E0CRAY7xBbPnJTnnJxehUCJgYMumSK8kogZYcXCyrLh7lt9DDx4LIhmS6TdqDhenYw=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (10.255.7.10) by
 MN2PR02MB5917.namprd02.prod.outlook.com (20.179.87.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 08:19:38 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::e55a:e2d1:953f:ed3b%4]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 08:19:38 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Thread-Topic: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP
 Platform Tap Delays Setup
Thread-Index: AQHVIDwWKZKZdF95gUaFGq/oqBvspKafu1mAgAADioCAAA8FAIAAIhYAgAAJ3oCAAOY6IIACOVsAgAEmWkA=
Date:   Thu, 20 Jun 2019 08:19:38 +0000
Message-ID: <MN2PR02MB6029D633F47B3B0DDF77D841C1E40@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
 <948514a0-e310-75fd-e8a8-6ef8bb14e41f@xilinx.com>
 <CAPDyKFp6O8rPZDZS4iKJam2+tXeen_ZMOXKw=WVzJNpBXcSc9g@mail.gmail.com>
 <MN2PR02MB60296837F9D1B3088667BE59C1EA0@MN2PR02MB6029.namprd02.prod.outlook.com>
 <CAPDyKFqC7aGX+BSP7U162Viq8qoL_df+N=zP_6P9xbzSZseipw@mail.gmail.com>
In-Reply-To: <CAPDyKFqC7aGX+BSP7U162Viq8qoL_df+N=zP_6P9xbzSZseipw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e4b6462-fa33-4251-c521-08d6f5580972
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR02MB5917;
x-ms-traffictypediagnostic: MN2PR02MB5917:
x-microsoft-antispam-prvs: <MN2PR02MB5917D40104C78CC9F3653074C1E40@MN2PR02MB5917.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(51914003)(199004)(13464003)(189003)(186003)(6436002)(76116006)(86362001)(66946007)(476003)(66556008)(66476007)(81156014)(486006)(2906002)(7736002)(64756008)(6916009)(6116002)(3846002)(71190400001)(55016002)(81166006)(71200400001)(7696005)(66446008)(9686003)(66066001)(8676002)(8936002)(68736007)(33656002)(316002)(76176011)(73956011)(52536014)(305945005)(53936002)(6246003)(25786009)(54906003)(229853002)(99286004)(102836004)(74316002)(6506007)(14454004)(53546011)(5660300002)(26005)(11346002)(446003)(72206003)(4326008)(256004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5917;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2VR0q9Hp+svW2sMD+E3V49XuUCy32IUIL0sIdInb2zhO2O/LNuzDBhk9eDLsODFDv40xFNK7H9pCR7YrowZ+AwBH7j6nWD7E9Dtfa8co6opj+/VjSh+4AYjsNSNyNt1bNwJO58kgbeNgnJdhAn3upxYP8d1SXUKk5i+Kce9WvoN7heVpBCliyM3VzmuQxEBLrq+Xsr5hwWuvCM4MEy5puk+iKEM7garaIhY1x64ACfohB4uzxXpgZHFSuAUYVF2hkg1Tr76ALdTDUih6dr1/t5xiuRQFN3CUe/o6gCB8XpRQkOx6JWq7s5D6kJOYlZ5Ppp3EskIM/7OuoF4knuavlJt28WP05MXU5jDXlXxeIqQ7pYhnK/+Biuu/TO03FRvzEEhJUsuIK03VD5FQmGK58tykwIa/GG5MQ9OZ4B2aQ/U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4b6462-fa33-4251-c521-08d6f5580972
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 08:19:38.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnarani@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBI
YW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUg
MTksIDIwMTkgODoxMSBQTQ0KPiBUbzogTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbnguY29t
Pg0KPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBSb2IgSGVycmluZyA8
cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNv
bT47IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgUmFqYW4gVmFq
YSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47
IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47IE9sb2YNCj4gSm9oYW5zc29u
IDxvbG9mQGxpeG9tLm5ldD47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IERUTUwNCj4gPGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIG1tYzog
c2RoY2ktb2YtYXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgWnlucU1QDQo+IFBsYXRmb3JtIFRhcCBE
ZWxheXMgU2V0dXANCj4gDQo+IE9uIFR1ZSwgMTggSnVuIDIwMTkgYXQgMDY6NTksIE1hbmlzaCBO
YXJhbmkgPE1OQVJBTklAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBVZmZlLA0KPiA+
DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBQbGVhc2UgZmluZCBteSBjb21tZW50cyBiZWxv
dy4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogTW9uZGF5LCBK
dW5lIDE3LCAyMDE5IDg6MjkgUE0NCj4gPiA+IFRvOiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGls
aW54LmNvbT4NCj4gPiA+IENjOiBNYW5pc2ggTmFyYW5pIDxNTkFSQU5JQHhpbGlueC5jb20+OyBS
b2IgSGVycmluZw0KPiA+ID4gPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFy
ay5ydXRsYW5kQGFybS5jb20+OyBBZHJpYW4NCj4gPiA+IEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+OyBSYWphbiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IEpvbGx5DQo+ID4gPiBT
aGFoIDxKT0xMWVNAeGlsaW54LmNvbT47IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54
LmNvbT47DQo+IE9sb2YNCj4gPiA+IEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+OyBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBEVE1MDQo+ID4gPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gbW1jOiBzZGhjaS1vZi1h
cmFzYW46IEFkZCBzdXBwb3J0IGZvciBaeW5xTVANCj4gPiA+IFBsYXRmb3JtIFRhcCBEZWxheXMg
U2V0dXANCj4gPiA+DQo+ID4gPiBbLi4uXQ0KPiA+ID4NCj4gPiA+ID4gPj4NCj4gPiA+ID4gPj4N
Cj4gPiA+ID4gPj4+IEluIHJlZ2FyZHMgdG8gdGhlIG1tYyBkYXRhIHBhcnQsIEkgc3VnZ2VzdCB0
byBkcm9wIHRoZQ0KPiA+ID4gPiA+Pj4gLT5zZXRfdGFwX2RlbGF5KCkgY2FsbGJhY2ssIGJ1dCBy
YXRoZXIgdXNlIGEgYm9vbGVhbiBmbGFnIHRvIGluZGljYXRlDQo+ID4gPiA+ID4+PiB3aGV0aGVy
IGNsb2NrIHBoYXNlcyBuZWVkcyB0byBiZSBjaGFuZ2VkIGZvciB0aGUgdmFyaWFudC4gUG90ZW50
aWFsbHkNCj4gPiA+ID4gPj4+IHRoYXQgY291bGQgZXZlbiBiZSBza2lwcGVkIGFuZCBpbnN0ZWFk
IGNhbGwgY2xrX3NldF9waGFzZSgpDQo+ID4gPiA+ID4+PiB1bmNvbmRpdGlvbmFsbHksIGFzIHRo
ZSBjbG9jayBjb3JlIGRlYWxzIGZpbmUgd2l0aCBjbG9jayBwcm92aWRlcnMNCj4gPiA+ID4gPj4+
IHRoYXQgZG9lc24ndCBzdXBwb3J0IHRoZSAtPnNldF9waGFzZSgpIGNhbGxiYWNrLg0KPiA+DQo+
ID4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIEkgYW0gdGFraW5nIGNhcmUgb2YgYm90
aCB0aGUgaW5wdXQgYW5kDQo+ID4gb3V0cHV0IGNsb2NrIGRlbGF5cyB3aXRoIHRoZSBzaW5nbGUg
Y2xvY2sgKHdoaWNoIGlzIG91dHB1dCBjbG9jaykgcmVnaXN0cmF0aW9uDQo+ID4gYW5kIGRpZmZl
cmVudGlhdGluZyB0aGVzZSB0YXAgZGVsYXlzIGJhc2VkIG9uIHRoZWlyIHZhbHVlcw0KPiA+ICg8
MjU2IHRoZW4gaW5wdXQgZGVsYXkgYW5kICA+PSAyNTYgdGhlbiBvdXRwdXQgZGVsYXkpLCBiZWNh
dXNlIHRoYXQgaXMNCj4gPiB6eW5xbXAgc3BlY2lmaWMuIElmIHdlIHdhbnQgdG8gbWFrZSB0aGlz
IGdlbmVyaWMsIHdlIG1heSBuZWVkIHRvDQo+ID4gcmVnaXN0ZXIgJ2Fub3RoZXInIGNsb2NrIHdo
aWNoIHdpbGwgYmUgdGhlcmUgYXMgYW4gaW5wdXQgKHNhbXBsaW5nKSBjbG9jaw0KPiA+IGFuZCB0
aGVuIHdlIGNhbiBtYWtlIHRoaXMgJ2Nsa19zZXRfcGhhc2UoKScgYmUgY2FsbGVkIHVuY29uZGl0
aW9uYWxseQ0KPiA+IGVhY2ggZm9yIGJvdGggdGhlIGNsb2NrcyBhbmQgbGV0IHRoZSBwbGF0Zm9y
bXMgaGFuZGxlIHRoZWlyIGNsb2NrIHBhcnQuDQo+ID4gV2hhdCdzIHlvdXIgdGFrZSBvbiB0aGlz
Pw0KPiANCj4gTm90IHN1cmUgZXhhY3RseSB3aGF0IHlvdSBhcmUgc3VnZ2VzdGluZywgYnV0IG15
IGd1dCBmZWVsaW5nIHNheXMgaXQNCj4gc291bmRzIGdvb2QuDQo+IA0KPiBIb3cgaXMgdGFwIGRl
bGF5cyBtYW5hZ2VkIGZvciBib3RoIHRoZSBpbnB1dCBjbG9jayBhbmQgdGhlIG91dHB1dA0KPiBj
bG9jaz8gSXMgc29tZSBtYW5hZ2VkIGJ5IHRoZSBjbG9jayBwcm92aWRlciAod2hpY2ggaXMgcHJv
YmFibHkNCj4gZmlybXdhcmUgaW4geW91ciBjYXNlKSBhbmQgc29tZSBtYW5hZ2VkIGJ5IHRoZSBN
TUMgY29udHJvbGxlcj8NCg0KWWVzLCBmb3IgdGhlIGV4aXN0aW5nICJ4bG54LHp5bnFtcC04Ljlh
IiBjb250cm9sbGVyLCB0aGUgdGFwIGRlbGF5cyB3aWxsIGJlIG1hbmFnZWQgYnkgdGhlIGZpcm13
YXJlLCBob3dldmVyIGluIHRoZSB1cGNvbWluZyAieGxueCx2ZXJzYWwtOC45YSIgdmFyaWFudCB0
aGUgdGFwIGRlbGF5cyB3aWxsIGJlIG1hbmFnZWQgYnkgdGhlIE1NQyBjb250cm9sbGVyIGl0c2Vs
Zi4NCkkgd2lsbCBpbmNsdWRlIHRoZSBWZXJzYWwgb25lIGluIHRoZSBuZXh0IHNlcmllcyBvZiBw
YXRjaGVzLg0KDQpUaGFua3MsDQpNYW5pc2gNCg==
