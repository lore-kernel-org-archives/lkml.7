Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB74BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E380233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 05:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WyWuUyHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfH2FyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 01:54:10 -0400
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:58629
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfH2FyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 01:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aetxGRViGWU2D5NmCkGi/0l7KG7qskbwPKB2ysy3SAG5gaoyYnT2FYM3ubhlu7hG78YLG2bkmCrVVyN9vhu+VGlyT4CJhOzioyg4/uWUccBCLk1Uj3gTzrLYXp8arQDxNiBD+enh8dwGoKVMl2SvzKOhB0i/4mlq1ut3QjWADVgOKn+7q7vxNZh7tBiyZbo1Cn5LkmDv58c1D2ng4ZtqH6IF7yUgQiW0C7od5xZHlAtkPbSGkAWm/SBsHpSLlw65cRFjDKlES7Y488ynnkpsIESt+uQEwGrHAgFQAfMQQ3aSDcuwwMCxJLfjmgnkb4hFxXR0H4kH+xndmLP0fAfzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GpcQxMSD5OOj9xAgT55psiSkzC2rtt0dkuIbyibMXk=;
 b=BxEQC9iL1aO84/JjZNKRA8wOtofHBSdv0uRANAqkOgKXdmqABEcPZO4yhI4P/B2WHzlrQqdy+0e3CVxJg5A5g0XtWm3NXron/TVgd9Bm+46pqXm6TH4IhKnHsjwdYMaQ1hAhbIcuGe4pJ0m3LkkkvuamCnm+UEHVr+KO8knClZ1kAPPMt73STVHDVB9pQOSUCbcoT/01vw7mOfg2HXvQFhyscDQDSSkBpLtPmruVQxlc7NEBbmIG3oBh5rqtSJXutSLJVEVTaehvcRNcTv/ouzrl0LpcwQB7IVY4Xbn+iC8j2vh/vFufcIi68su8N6hBdFlJny2vRMfd70bNI8stUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GpcQxMSD5OOj9xAgT55psiSkzC2rtt0dkuIbyibMXk=;
 b=WyWuUyHqcodSFPAjXuhiYqEw3Uql0x7i4VJcLXscW9e5KW0qTQePZtI4ktHt8UDLg/ftkNxJJDOVaTuOvhwFq9pRwRciaIUzPqML6viaqUcoNOxrkQP6wGima8j9qrpq+gLG26z2oJk4R9TatZfjaVmLzGKuEAP2BwiBP0lXB6Y=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4441.eurprd04.prod.outlook.com (52.135.141.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 05:54:00 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::8947:6eac:82bb:b197]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::8947:6eac:82bb:b197%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 05:54:00 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v3 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v3 2/2] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVWI/y1YP/S4kQzkGc4gznTbwERacH8pYAgAm4V2A=
Date:   Thu, 29 Aug 2019 05:54:00 +0000
Message-ID: <DB7PR04MB5195C5E97B791A48D39B10E6E2A20@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190822020847.10159-1-wen.he_1@nxp.com>
 <20190822020847.10159-2-wen.he_1@nxp.com>
 <20190823012658.DB213233A2@mail.kernel.org>
In-Reply-To: <20190823012658.DB213233A2@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36cb8fa0-168d-47da-5144-08d72c454a03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4441;
x-ms-traffictypediagnostic: DB7PR04MB4441:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB444103BF141B12A1000D286DE2A20@DB7PR04MB4441.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(13464003)(51914003)(189003)(199004)(66556008)(478600001)(2201001)(7520500002)(86362001)(33656002)(8936002)(81166006)(8676002)(110136005)(71200400001)(71190400001)(81156014)(3846002)(2906002)(14454004)(54906003)(53936002)(6246003)(229853002)(66946007)(7696005)(25786009)(52536014)(66476007)(2501003)(66446008)(316002)(9686003)(256004)(64756008)(6436002)(14444005)(66066001)(7736002)(476003)(53546011)(486006)(6506007)(11346002)(76176011)(5660300002)(26005)(446003)(74316002)(4326008)(55016002)(305945005)(6116002)(76116006)(99286004)(186003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4441;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VypZY6oNRn1jg6RsPfR2PodAQbD8NKQQvutR15jmOyqmoSZGJ9flVMCiK+dqbAvd8+1LJGkuoZsIdgcT2egBoPgINnWyPi5OJ/ZJLZUIbCmQpOPITD9GvEtGcxqW1affMvCG9HUK7GkE0KegSzdx+XoU3iu7vd2PbPYcWyyioAx6ZRtnjLnxEonQ8bOR+BgGr0QS/EK/RFKrio1suxSQue+EXk2qt5Cl+vMgQbiVI+OUPxpKH2fhJumW3NfPEpmdFC8KnDWyZy9MWkysLF2STYgjRpV6v7hgJFK7OdIYtHggFodikMVnRCOanJS+FppH3lOQ1TEyxiyEE6kb+M1s9KJd/2vqi/xs9uHtkb9pooyQ1Lgx1qddpUX7IYei57LVq1VnGF11h7SPQgFz+IQ4BNzke7xE3BYtq1mzIevPvMI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb8fa0-168d-47da-5144-08d72c454a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 05:54:00.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWvMGCiCivrcte9npKcs0kfHaLC+IPs6UOERPMhV08L2w6ky52JSEWxiI9LhnzJyzVy01tsFQq5We7akLZ0xsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4441
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDIz5pelIDk6MjcNCj4gVG86IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgV2VuIEhlDQo+IDx3ZW4uaGVfMUBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGku
bnhwLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGVvIExpIDxsZW95
YW5nLmxpQG54cC5jb20+OyBsaXZpdS5kdWRhdUBhcm0uY29tOyBXZW4gSGUNCj4gPHdlbi5oZV8x
QG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbdjMgMi8yXSBjbGs6IGxzMTAyOGE6IEFk
ZCBjbG9jayBkcml2ZXIgZm9yIERpc3BsYXkgb3V0cHV0DQo+IGludGVyZmFjZQ0KPiANCj4gQ2F1
dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBRdW90aW5nIFdlbiBIZSAoMjAxOS0wOC0yMSAxOTowODo0
NykNCj4gPiBBZGQgY2xvY2sgZHJpdmVyIGZvciBRb3JJUSBMUzEwMjhBIERpc3BsYXkgb3V0cHV0
IGludGVyZmFjZXMoTENELA0KPiA+IERQSFkpLCBhcyBpbXBsZW1lbnRlZCBpbiBUU01DIENMTjI4
SFBNIFBMTCwgdGhpcyBQTEwgc3VwcG9ydHMgdGhlDQo+ID4gcHJvZ3JhbW1hYmxlIGludGVnZXIg
ZGl2aXNpb24gYW5kIHJhbmdlIG9mIHRoZSBkaXNwbGF5IG91dHB1dCBwaXhlbCBjbG9jaydzDQo+
IDI3LTU5NE1Iei4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbiBIZSA8d2VuLmhlXzFAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2UgaW4gdjM6DQo+ID4gICAgICAgICAtIHJlbW92ZSB0
aGUgT0YgZGVwZW5kZW5jeQ0KPiA+ICAgICAgICAgLSB1c2UgY2xrX3BhcmVudF9kYXRhIGluc3Rl
YWQgb2YgcGFyZW50X25hbWUNCj4gPg0KPiA+ICBkcml2ZXJzL2Nsay9LY29uZmlnICAgICAgfCAg
MTAgKysNCj4gPiAgZHJpdmVycy9jbGsvTWFrZWZpbGUgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9jbGsvY2xrLXBsbGRpZy5jIHwgMjgzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjk0IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL2Nsay1wbGxkaWcuYw0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9LY29uZmlnIGlu
ZGV4DQo+ID4gODAxZmExY2QwMzIxLi5hYjA1ZjM0MmFmMDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9jbGsvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL0tjb25maWcNCj4gPiBAQCAt
MjIzLDYgKzIyMywxNiBAQCBjb25maWcgQ0xLX1FPUklRDQo+ID4gICAgICAgICAgIFRoaXMgYWRk
cyB0aGUgY2xvY2sgZHJpdmVyIHN1cHBvcnQgZm9yIEZyZWVzY2FsZSBRb3JJUSBwbGF0Zm9ybXMN
Cj4gPiAgICAgICAgICAgdXNpbmcgY29tbW9uIGNsb2NrIGZyYW1ld29yay4NCj4gPg0KPiA+ICtj
b25maWcgQ0xLX0xTMTAyOEFfUExMRElHDQo+ID4gKyAgICAgICAgYm9vbCAiQ2xvY2sgZHJpdmVy
IGZvciBMUzEwMjhBIERpc3BsYXkgb3V0cHV0Ig0KPiA+ICsgICAgICAgIGRlcGVuZHMgb24gQVJD
SF9MQVlFUlNDQVBFIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsgICAgICAgIGRlZmF1bHQgQVJDSF9M
QVlFUlNDQVBFDQo+ID4gKyAgICAgICAgaGVscA0KPiA+ICsgICAgICAgICAgVGhpcyBkcml2ZXIg
c3VwcG9ydCB0aGUgRGlzcGxheSBvdXRwdXQgaW50ZXJmYWNlcyhMQ0QsIERQSFkpDQo+IHBpeGVs
IGNsb2Nrcw0KPiA+ICsgICAgICAgICAgb2YgdGhlIFFvcklRIExheWVyc2NhcGUgTFMxMDI4QSwg
YXMgaW1wbGVtZW50ZWQgVFNNQw0KPiBDTE4yOEhQTSBQTEwuIE5vdCBhbGwNCj4gPiArICAgICAg
ICAgIGZlYXR1cmVzIG9mIHRoZSBQTEwgYXJlIGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkgdGhlIGRy
aXZlci4gQnkNCj4gZGVmYXVsdCwNCj4gPiArICAgICAgICAgIGNvbmZpZ3VyZWQgYnlwYXNzIG1v
ZGUgd2l0aCB0aGlzIFBMTC4NCj4gPiArDQo+ID4gIGNvbmZpZyBDT01NT05fQ0xLX1hHRU5FDQo+
ID4gICAgICAgICBib29sICJDbG9jayBkcml2ZXIgZm9yIEFQTSBYR2VuZSBTb0MiDQo+ID4gICAg
ICAgICBkZWZhdWx0IEFSQ0hfWEdFTkUNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvTWFr
ZWZpbGUgYi9kcml2ZXJzL2Nsay9NYWtlZmlsZSBpbmRleA0KPiA+IDBjYWQ3NjAyMTI5Ny4uYzhl
MjJhNzY0YzRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL01ha2VmaWxlDQo+ID4gKysr
IGIvZHJpdmVycy9jbGsvTWFrZWZpbGUNCj4gPiBAQCAtNDQsNiArNDQsNyBAQCBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19PWE5BUykNCj4gKz0gY2xrLW94bmFzLm8NCj4gPiAgb2JqLSQoQ09ORklH
X0NPTU1PTl9DTEtfUEFMTUFTKSAgICAgICAgICAgICAgICArPSBjbGstcGFsbWFzLm8NCj4gPiAg
b2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfUFdNKSAgICAgICAgICAgKz0gY2xrLXB3bS5vDQo+ID4g
IG9iai0kKENPTkZJR19DTEtfUU9SSVEpICAgICAgICAgICAgICAgICAgICAgICAgKz0gY2xrLXFv
cmlxLm8NCj4gPiArb2JqLSQoQ09ORklHX0NMS19MUzEwMjhBX1BMTERJRykgICAgICAgKz0gY2xr
LXBsbGRpZy5vDQo+ID4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX1JLODA4KSAgICAgICAgICs9
IGNsay1yazgwOC5vDQo+ID4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX0hJNjU1WCkgICAgICAg
ICAgICAgICAgKz0gY2xrLWhpNjU1eC5vDQo+ID4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX1My
TVBTMTEpICAgICAgICs9IGNsay1zMm1wczExLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvY2xrLXBsbGRpZy5jIGIvZHJpdmVycy9jbGsvY2xrLXBsbGRpZy5jIG5ldw0KPiA+IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMDAwMDAwLi5jNWNlODBhNDZmZDQNCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXBsbGRpZy5jDQo+ID4gQEAgLTAsMCAr
MSwyODMgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiAr
Ly8gQ29weXJpZ2h0IDIwMTkgTlhQDQo+IA0KPiBQbGVhc2UgbGVhdmUgdGhpcyBhcyBDIHN0eWxl
IC8qICovIGNvbW1lbnQgZm9yIHRoZSBOWFAgcGFydCwgYnV0IGNvbXBseSB3aXRoDQo+IHRoZSBT
UERYIGNvbW1lbnQgc3R5bGUgb2YgLy8gb24gdGhlIGZpcnN0IGxpbmUuDQo+IA0KPiA+ICsNCj4g
PiArc3RhdGljIGxvbmcgcGxsZGlnX3JvdW5kX3JhdGUoc3RydWN0IGNsa19odyAqaHcsIHVuc2ln
bmVkIGxvbmcgcmF0ZSwNCj4gPiArICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyAqcGFyZW50
KSB7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlID0gKnBhcmVudDsNCj4g
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgcm91bmRfcmF0ZTsNCj4gPiArICAgICAgIHUzMiBtdWx0
ID0gMCwgcmZkcGhpMSA9IDA7DQo+ID4gKyAgICAgICBib29sIGZvdW5kID0gZmFsc2U7DQo+ID4g
Kw0KPiA+ICsgICAgICAgZm91bmQgPSBwbGxkaWdfaXNfdmFsaWRfcmFuZ2UocmF0ZSwgcGFyZW50
X3JhdGUsICZtdWx0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmcmZkcGhpMSwgJnJvdW5kX3JhdGUpOw0KPiA+ICsgICAgICAgaWYgKCFmb3VuZCkgew0KPiA+
ICsgICAgICAgICAgICAgICBwcl93YXJuKCIlczogdW5hYmxlIHRvIHJvdW5kIHJhdGUgJWx1LCBw
YXJlbnQNCj4gcmF0ZSA6JWx1XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2xrX2h3X2dldF9uYW1lKGh3KSwgcmF0ZSwNCj4gcGFyZW50X3JhdGUpOw0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gDQo+IFRoaXMgY2FuIHJldHVybiBhbiBlcnJvciBpbnN0
ZWFkPyBJbiBmYWN0LCB5b3UgbWF5IHdhbnQgdG8gdXNlIGRldGVybWluZV9yYXRlDQo+IGNsayBv
cCBpbnN0ZWFkLg0KPiANCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4g
cm91bmRfcmF0ZSAvIHJmZHBoaTE7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgcGxs
ZGlnX3NldF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQo+ID4g
KyAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpIHsNCj4gPiArICAgICAg
IHN0cnVjdCBjbGtfcGxsZGlnICpkYXRhID0gdG9fY2xrX3BsbGRpZyhodyk7DQo+ID4gKyAgICAg
ICBib29sIHZhbGlkID0gZmFsc2U7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIHJvdW5kX3Jh
dGUgPSAwOw0KPiA+ICsgICAgICAgdTMyIHJmZHBoaTEgPSAwLCB2YWwsIG11bHQgPSAwLCBjb25k
ID0gMDsNCj4gPiArICAgICAgIGludCByZXQgPSAtRVRJTUVET1VUOw0KPiA+ICsNCj4gPiArICAg
ICAgIHZhbGlkID0gcGxsZGlnX2lzX3ZhbGlkX3JhbmdlKHJhdGUsIHBhcmVudF9yYXRlLCAmbXVs
dCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJmZHBoaTEs
ICZyb3VuZF9yYXRlKTsNCj4gPiArICAgICAgIGlmICghdmFsaWQpIHsNCj4gPiArICAgICAgICAg
ICAgICAgcHJfd2FybigiJXM6IHVuYWJsZSB0byBzdXBwb3J0IHJhdGUgJWx1LA0KPiBwYXJlbnRf
cmF0ZTogJWx1XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xrX2h3
X2dldF9uYW1lKGh3KSwgcmF0ZSwNCj4gPiArIHBhcmVudF9yYXRlKTsNCj4gDQo+IFNob3VsZG4n
dCBkZXRlcm1pbmVfcmF0ZSBvciByb3VuZF9yYXRlIG1ha2UgdGhpcyBpbXBvc3NpYmxlIHRvIGhp
dCBpbiBwcmFjdGljZT8NCj4gSSBtZWFuIHRoYXQgdGhvc2Ugb3BzIHNob3VsZCBwcmV2ZW50IHRo
ZSByYXRlIGZyb20gYmVpbmcgcm91bmRlZCB0byBzdWNoIGENCj4gZnJlcXVlbmN5IHRoYXQgaXQg
YmVjb21lcyBpbnZhbGlkLg0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgdmFsID0gcmVhZGwoZGF0YS0+cmVn
cyArIFBMTERJR19SRUdfUExMRFYpOw0KPiA+ICsgICAgICAgdmFsID0gbXVsdDsNCj4gPiArICAg
ICAgIHJmZHBoaTEgPSBQTExESUdfU0VUX1JGRFBISTEocmZkcGhpMSk7DQo+ID4gKyAgICAgICB2
YWwgfD0gcmZkcGhpMTsNCj4gPiArDQo+ID4gKyAgICAgICB3cml0ZWwodmFsLCBkYXRhLT5yZWdz
ICsgUExMRElHX1JFR19QTExEVik7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZGVsYXkgMjAwdXMg
bWFrZSBzdXJlIHRoYXQgb2xkIGxvY2sgc3RhdGUgaXMgY2xlYXJlZCAqLw0KPiA+ICsgICAgICAg
dWRlbGF5KDIwMCk7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogV2FpdCB1bnRpbCBQTEwgaXMgbG9j
a2VkIG9yIHRpbWVvdXQgKG1heGltdW0gMTAwMCB1c2VjcykgKi8NCj4gPiArICAgICAgIHJldCA9
IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoZGF0YS0+cmVncyArIFBMTERJR19SRUdfUExMU1Is
DQo+IGNvbmQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bmQgJiBQTExESUdfTE9DS19NQVNLLA0KPiAwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBVU0VDX1BFUl9NU0VDKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMg
cGxsZGlnX2Nsa19vcHMgPSB7DQo+ID4gKyAgICAgICAuZW5hYmxlID0gcGxsZGlnX2VuYWJsZSwN
Cj4gPiArICAgICAgIC5kaXNhYmxlID0gcGxsZGlnX2Rpc2FibGUsDQo+ID4gKyAgICAgICAuaXNf
ZW5hYmxlZCA9IHBsbGRpZ19pc19lbmFibGVkLA0KPiA+ICsgICAgICAgLnJlY2FsY19yYXRlID0g
cGxsZGlnX3JlY2FsY19yYXRlLA0KPiA+ICsgICAgICAgLnJvdW5kX3JhdGUgPSBwbGxkaWdfcm91
bmRfcmF0ZSwNCj4gPiArICAgICAgIC5zZXRfcmF0ZSA9IHBsbGRpZ19zZXRfcmF0ZSwNCj4gPiAr
fTsNCj4gWy4uLl0NCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBkZXZtX2Nsa19od19yZWdpc3Rl
cihkZXYsICZkYXRhLT5odyk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVyICVzIGNsb2NrXG4iLCBpbml0
Lm5hbWUpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgIHJldCA9IGRldm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcihkZXYs
IG9mX2Nsa19od19zaW1wbGVfZ2V0LA0KPiAmZGF0YS0+aHcpOw0KPiA+ICsgICAgICAgaWYgKHJl
dCkNCj4gPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgYWRkaW5nIHRoZSBj
bG9jayBwcm92aWRlclxuIik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBwbGxkaWdfY2xrX3JlbW92ZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgICBvZl9jbGtfZGVsX3Byb3ZpZGVyKHBkZXYt
PmRldi5vZl9ub2RlKTsNCj4gDQo+IFRoaXMgaXNuJ3QgcmVxdWlyZWQuIGRldm0gYWxyZWFkeSBk
b2VzIGl0Lg0KPiANCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBwbGxkaWdfY2xrX2lkW10gPSB7DQo+ID4g
KyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxsczEwMjhhLXBsbGRpZyIsIC5kYXRhID0gTlVM
TH0sDQo+IA0KPiBZb3UgY2FuIGxlYXZlIG91dCB0aGUgZGF0YSBhc3NpZ25tZW50Lg0KDQpUaGFu
a3MgZm9yIHRoZSBkZXRhaWxzIHJldmlldywgd2lsbCBzZW5kIG5leHQgdmVyc2lvbi4NCg0KQmVz
dCBSZWdhcmRzLA0KV2VuDQoNCg==
