Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1560C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03520898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="A1whSk6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKUHJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:09:05 -0500
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:63488
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbfKUHJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:09:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzvmrc9miFUA0DMroZFtI9kO5PMwcCKfDX9Q9FZgNEPxoBCkGH6rp+Z8IHN0uqidjU3B6t3mC3WYhemcWbOcE3fUdndwur5Vxuiq7ZqpDLRHNteWbJeG2t2FwSlpD2sdpKqyU6j9dw7vroyBDGQc4+4BOQh/kYqI+2SqJLSSSDq9qknh6xG4i3cfkm3z6HPhMeuOT5gwA+lz90ZY216js14j0KOq+Fx8JBzCLMkNFQjOdjwydVXCojhOuR+kGlHdJUi1kGXkj1O+Yn6MDNlhF1tYR8UvAvnS36PyWRLI5loFQZ5BVvKq4PagLIWJkh/mqISQlk1fl9Wg5k90RsdphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6WlEpUSXxY/bCqzlPa9lhjhx2jppTVScHnwCz/HOJA=;
 b=TiSOhJVb4el6Duk4IjirFJktaa/7wQDCqrrBNnUIUQvA6QRH1QmKes5Jt9cI66oUy+9IImz+iuxBcaJXVHsUUItA+qYvkJT43K3M7QvsoiXU7S3+8g6rjI26UwsjrVnoGZe23z6ypr3Lbo7haXLRDjFQBb4aw4aQ18qCbOrwKqq8GoHOk9x/eNCOCYZgn9O0rajJ4SrIQ+Qp1Uh/k/y3rQAC0edum+TLxpndIgvpc/TnXt64IOuKEtlD1KJcxNxdRbqtgu6jpgQgvm1nX24NOOXxcXqOoYncE4hUNL1BQr6oY+/i/8O7ay5IHjha+VywkahKNg7CsOIxCF98//V8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6WlEpUSXxY/bCqzlPa9lhjhx2jppTVScHnwCz/HOJA=;
 b=A1whSk6CWVTO1a6dhKXrm6I9TYeyqiZuWu/Y0TjdQ1hqL8HAM0lOxbcX8r7klUkVNMaz/kgpQ2c9By77G3D3e+b0D7y/t6KLfmiXHREDyAZyyGiE+7yz+KV2JxNyF9ESzh8M5flLdhGKWPuGKrJ0iWYBvNamWFL0aGX157bMYMk=
Received: from MN2PR02MB6029.namprd02.prod.outlook.com (52.132.174.207) by
 MN2PR02MB6144.namprd02.prod.outlook.com (52.132.175.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 07:08:57 +0000
Received: from MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7c98:7d3:f15a:27f]) by MN2PR02MB6029.namprd02.prod.outlook.com
 ([fe80::7c98:7d3:f15a:27f%3]) with mapi id 15.20.2451.032; Thu, 21 Nov 2019
 07:08:57 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v6 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays
 Handling
Thread-Topic: [PATCH v6 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays
 Handling
Thread-Index: AQHVn25tGCkl+xQ8X0m6HeJEn7Tt8qeUBb8AgAEuXKA=
Date:   Thu, 21 Nov 2019 07:08:56 +0000
Message-ID: <MN2PR02MB6029E25E0DC26BD79DA58A4EC14E0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFprcjgrcbT3jpT7pyM+FFWL8RAm5AtFAjVLcPMDiDzUvA@mail.gmail.com>
In-Reply-To: <CAPDyKFprcjgrcbT3jpT7pyM+FFWL8RAm5AtFAjVLcPMDiDzUvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02644b03-d4cd-429c-dd8b-08d76e51ad30
x-ms-traffictypediagnostic: MN2PR02MB6144:|MN2PR02MB6144:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB61447645514E14D522B232C3C14E0@MN2PR02MB6144.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(13464003)(53546011)(3846002)(256004)(6116002)(14454004)(86362001)(478600001)(33656002)(5660300002)(99286004)(76116006)(110136005)(4326008)(316002)(2906002)(6436002)(54906003)(14444005)(6246003)(107886003)(55016002)(9686003)(6506007)(446003)(8936002)(25786009)(229853002)(71190400001)(76176011)(74316002)(102836004)(71200400001)(26005)(66066001)(7696005)(305945005)(8676002)(7416002)(52536014)(81166006)(81156014)(7736002)(66446008)(66476007)(66946007)(66556008)(64756008)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6144;H:MN2PR02MB6029.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qshEcglT9BEgl2Lbt/KxBDbXDdXScNSHAIpQHgDQJg9hgTgXg3YfB56+qSY0xo1devVBOpYHndAI0ZRk8zXryJ2S1DWasU5ytXPsZ0+OqqgnpuiN5ltBi1Qc+VW69bS/zy4OIP4mgci+zTPUOSEshFaipGB7ULJIXIUq7y+ga2VRfvTnZ/lpCCU4TZJR4sSnTrr3pN9jJUoqEXYYzxJSqH0casLCR7XAq+K3IiIq+fa0iT/xl+yYkMqvUkOD1XPGs6HML2gqwl06v7/IVN1ENM8E48mBqo4UFSgCieAM2tWnng/EwljfkB8ox0ehq+BDLAsl1TY9Vx3JqcWh43N3vFE787X3GfHFugkhkuPG4G1lI/W0e2jyxV5YA8Z52RTFZZLjJd0944U/u2frGzXtYz+jeX/Hqm4uzSSYi9zu4PznswPKEavKIr53J2ObKAA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02644b03-d4cd-429c-dd8b-08d76e51ad30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 07:08:56.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esj90CV8cMt+IhuNufaw9cwAphvri1QVIl48V8aJ67A/9ashd7p+3vuLxF7YjtFUtb3xW5elwM+7MjNBNFLrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwgUm9iIGFuZCBBZHJpYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgNjoyOSBQTQ0KPiBUbzogTWFuaXNoIE5hcmFuaSA8
TU5BUkFOSUB4aWxpbnguY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9y
Zz47IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBZHJpYW4gSHVudGVy
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPjsgSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBSYWphbg0KPiBWYWphIDxS
QUpBTlZAeGlsaW54LmNvbT47IE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YW1AeGlsaW54LmNvbT47
DQo+IE1vcml0eiBGaXNjaGVyIDxtZGZAa2VybmVsLm9yZz47IGxpbnV4LW1tY0B2Z2VyLmtlcm5l
bC5vcmc7IERUTUwNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVs
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBB
Uk0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBnaXQgPGdpdEB4
aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvOF0gQXJhc2FuIFNESENJIGVu
aGFuY2VtZW50cyBhbmQgWnlucU1QIFRhcA0KPiBEZWxheXMgSGFuZGxpbmcNCj4gDQo+IE9uIFdl
ZCwgMjAgTm92IDIwMTkgYXQgMDc6NDcsIE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGls
aW54LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBkb2VzIHRoZSBm
b2xsb3dpbmc6DQo+ID4gIC0gUmVvcmdhbml6ZSB0aGUgQ2xvY2sgSGFuZGxpbmcgaW4gQXJhc2Fu
IFNEIGRyaXZlcg0KPiA+ICAtIEFkZHMgbmV3IHNhbXBsaW5nIGNsb2NrIGluIEFyYXNhbiBTRCBk
cml2ZXINCj4gPiAgLSBBZGRzIHN1cHBvcnQgdG8gc2V0IENsb2NrIERlbGF5cyBpbiBTRCBBcmFz
YW4gRHJpdmVyDQo+ID4gIC0gQWRkIFNESU8gVGFwIERlbGF5IGhhbmRsaW5nIGluIFp5bnFNUCBm
aXJtd2FyZSBkcml2ZXINCj4gPiAgLSBBZGQgc3VwcG9ydCBmb3IgWnlucU1QIFRhcCBEZWxheXMg
c2V0dGluZyBpbiBBcmFzYW4gU0QgZHJpdmVyDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+
ICAgICAgICAgLSBSZXBsYWNlZCB0aGUgZGVwcmVjYXRlZCBjYWxscyB0byBjbG9jayBmcmFtZXdv
cmsgQVBJcw0KPiA+ICAgICAgICAgLSBBZGRlZCBzdXBwb3J0IGZvciBkZXZfY2xrX2dldCgpIGNh
bGwgdG8gd29yayBmb3IgU0QgY2FyZCBjbG9jaw0KPiA+ICAgICAgICAgLSBTZXBhcmF0ZWQgdGhl
IGNsb2NrIGRhdGEgc3RydWN0DQo+ID4gICAgICAgICAtIEZyYWdtZW50ZWQgdGhlIHBhdGNoIHNl
cmllcyBpbiBzbWFsbGVyIHBhdGNoZXMgdG8gbWFrZSBpdCBtb3JlDQo+ID4gICAgICAgICAgIHJl
YWRhYmxlDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICAgICAgICAgLSBSZXZlcnRlZCAi
UmVwbGFjZWQgdGhlIGRlcHJlY2F0ZWQgY2FsbHMgdG8gY2xvY2sgZnJhbWV3b3JrIEFQSXMiDQo+
ID4gICAgICAgICAtIFJlbW92ZWQgZGV2bV9jbGtfZ2V0KCkgY2FsbCB3aGljaCB3YXMgYWRkZWQg
aW4gdjINCj4gPg0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gICAgICAgICAtIE1hZGUgdGhlIFBo
YXNlIERlbGF5IHByb3BlcnRpZXMgQXJhc2FuIHNwZWNpZmljDQo+ID4NCj4gPiBDaGFuZ2VzIGlu
IHY1Og0KPiA+ICAgICAgICAgLSBNYWRlIENsb2NrIFBoYXNlIERlbGF5IHByb3BlcnRpZXMgY29t
bW9uDQo+ID4gICAgICAgICAtIE1vdmVkIGRvY3VtZW50YXRpb24gb2YgdGhlbSB0byB0aGUgY29t
bW9uIG1tYyBkb2N1bWVudGF0aW9uLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2NjoNCj4gPiAgICAg
ICAgIC0gQ2x1YmJlZCBhbGwgQ2xrIFBoYXNlIERlbGF5IHByb3BlcnRpZXMnIGludG8gYSBwYXR0
ZXJuDQo+ID4gICAgICAgICAgIFByb3BlcnR5DQo+ID4NCj4gPiBNYW5pc2ggTmFyYW5pICg4KToN
Cj4gPiAgIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBTZXBhcmF0ZSBvdXQgY2xrIHJlbGF0ZWQgZGF0
YSB0byBhbm90aGVyDQo+ID4gICAgIHN0cnVjdHVyZQ0KPiA+ICAgZHQtYmluZGluZ3M6IG1tYzog
YXJhc2FuOiBVcGRhdGUgRG9jdW1lbnRhdGlvbiBmb3IgdGhlIGlucHV0IGNsb2NrDQo+ID4gICBt
bWM6IHNkaGNpLW9mLWFyYXNhbjogQWRkIHNhbXBsaW5nIGNsb2NrIGZvciBhIHBoeSB0byB1c2UN
Cj4gPiAgIGR0LWJpbmRpbmdzOiBtbWM6IEFkZCBvcHRpb25hbCBnZW5lcmljIHByb3BlcnRpZXMg
Zm9yIG1tYw0KPiA+ICAgbW1jOiBzZGhjaS1vZi1hcmFzYW46IEFkZCBzdXBwb3J0IHRvIHNldCBj
bG9jayBwaGFzZSBkZWxheXMgZm9yIFNEDQo+ID4gICBmaXJtd2FyZTogeGlsaW54OiBBZGQgU0RJ
TyBUYXAgRGVsYXkgbm9kZXMNCj4gPiAgIGR0LWJpbmRpbmdzOiBtbWM6IGFyYXNhbjogRG9jdW1l
bnQgJ3hsbngsenlucW1wLTguOWEnIGNvbnRyb2xsZXINCj4gPiAgIG1tYzogc2RoY2ktb2YtYXJh
c2FuOiBBZGQgc3VwcG9ydCBmb3IgWnlucU1QIFBsYXRmb3JtIFRhcCBEZWxheXMgU2V0dXANCj4g
Pg0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dCAgfCAg
MjUgKy0NCj4gPiAgLi4uL2JpbmRpbmdzL21tYy9tbWMtY29udHJvbGxlci55YW1sICAgICAgICAg
IHwgIDEzICsNCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYyAgICAgICAg
ICAgIHwgNDc4ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJl
L3hsbngtenlucW1wLmggICAgICAgICAgfCAgMTMgKy0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA0
OTcgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcu
MQ0KPiA+DQo+IA0KPiBBcHBsaWVkIGZvciBuZXh0LCBhc3N1bWluZyBSb2IgaXMgb2theSB3aXRo
IHBhdGNoNCwgb3RoZXJ3aXNlIHlvdSBuZWVkDQo+IHRvIHNlbmQgYSBmaXggb24gdG9wLCB0aGFu
a3MhDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQpUaGFuayB5b3Ugc28gbXVjaCBmb3Ig
eW91ciByZXZpZXdzIGFuZCBjb250aW51b3VzIHN1cHBvcnQhIDopDQpMb29raW5nIGZvcndhcmQg
dG8gd29yayBtb3JlIHdpdGggeW91IG9uIHRoaXMuDQoNClJlZ2FyZHMsDQpNYW5pc2gNCg==
