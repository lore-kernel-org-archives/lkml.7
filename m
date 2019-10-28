Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8073ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA020717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1chaKZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfJ1CNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:13:18 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:27830
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbfJ1CNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:13:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHINfj3ThzuhLOPfzmgbUA+MozzOYcZGzMLTwRvpQvOLInHq2bATx8h5cIoNs/BH/xVJ2bFhCUNzcH2dgGWJJnPpNPXDfldNIGwoN8uK4S0CELeRr/pyswEgCxrZyRuSrvP7pAyBwNRpft5YSxtfxcFzBekwZsphYhDz0cF1T2ZruaFXS209syjvgsv+EcL8L4UvErZPGP13tlZaBsCNZn1/ETicdaetws9lXz+yeOSCHoD6RxT8EEwgswDc4/z9KdpXeh+kvsO+P4TCkbJ4cDv3khoXGGQu2JdJR4GV7HZqIuVvXSDgVQ/xqDUgWhFHn0C05HiiXp2dxjhSRFI9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqs6vbjOCH+WFyqe4S55ilinaqwQq7Q92glopob7e98=;
 b=EVIUeOs8jrUe1tUrDPBbF6ZqfAD+P3FJJ1EhF2s+mrBRW8i+vwI9iQTF8O4Ss/BfyQsBpXHuw6L25YYi65y5u8piS5yf1Z6309/uH+j8zZua7rnHIlwyWYPGU+WG6MmRizHY8Zf0DWSXg4LhRioj/+UTVvBPFruzIXgU10yqfJT0iZANZ1A5AmcyEJL1VZHywXUWhegi24wfNwfhJJmYwfRZQ7ovcRq5mRjm2SU1vDwJFOH3CC5nI+N/38CxvjnwGjjC0P5QTQJslNkOgdf9NuJQhva3wh0rxv7jzCTNOhgeo7VdyQMycQxjgGI+l+vmFU5h2xX505zFZPVM/mfCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqs6vbjOCH+WFyqe4S55ilinaqwQq7Q92glopob7e98=;
 b=k1chaKZiS4Frszmo/8oBqF6Gwn5fiGOX2grjZSgpF4ExK6MnepWvrFtABTYOQ76oOXfiLvA0oaQp83eIkh5o6j5mOiTGVOA9nQeBh2CqTM0TvDqz72+1WY8gEs56ZJ2ngefGqegex37m3OgvzPvxm+xLONp9BJVhR/WUKeRkDqE=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4025.eurprd04.prod.outlook.com (52.135.130.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 02:13:13 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::b0:e68e:128e:ac4a]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::b0:e68e:128e:ac4a%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 02:13:13 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v3] arm64: dts: ls1028a: Update the property of the DT
 node dpclk
Thread-Topic: [EXT] Re: [v3] arm64: dts: ls1028a: Update the property of the
 DT node dpclk
Thread-Index: AQHVgmBnGoVD0YRR/EynnuzHLzYuHadswKiAgAKiWCA=
Date:   Mon, 28 Oct 2019 02:13:13 +0000
Message-ID: <DB7PR04MB5195FAB44737BE8473DEBF6FE2660@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191014071327.28961-1-wen.he_1@nxp.com>
 <20191026094948.GF14401@dragon>
In-Reply-To: <20191026094948.GF14401@dragon>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85aea96d-fe37-47b6-97d8-08d75b4c6344
x-ms-traffictypediagnostic: DB7PR04MB4025:|DB7PR04MB4025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB402519799B12FF01CE8AC28AE2660@DB7PR04MB4025.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(13464003)(305945005)(11346002)(33656002)(102836004)(54906003)(476003)(53546011)(316002)(6506007)(6916009)(55016002)(7736002)(5660300002)(186003)(66556008)(64756008)(6246003)(66476007)(99286004)(9686003)(14444005)(7696005)(26005)(256004)(76176011)(66446008)(81156014)(8676002)(3846002)(71200400001)(66066001)(6116002)(81166006)(71190400001)(76116006)(446003)(66946007)(486006)(229853002)(4326008)(52536014)(8936002)(2906002)(86362001)(14454004)(6436002)(25786009)(478600001)(15650500001)(74316002)(17423001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4025;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YC87o/8o4s6nXO4UUvNF227iDBsjoVr069PtVZ/RjPJbhAZqDwpuNrLjKdGZpNJHkqeADSOupq20AyX/hhntFveq5yrsdJD1PvowbNp8M76Ke2R2Zc+aK/yWDCG36vKKYzlhSaOM0QhEwEAGsCWzJQjFoO5DKpN38LYKHsXH7ZkYgS3Hva+geWMPtADlTl1RGN4uZ+CpU6bKWMYW7/PZnkzHBi65K2v1Ha5QPHxIV7CHPUyUHNI6ARdilSTkx/KW/iHPLDI7N0Q/yUedKxvvTB46Cz8Bu3R4skfYaIFbm4NllGskqB5/SoUIqTjITip3Z4ThGqy75snY/n9r5NN27iis3ZrqRTHWJx9V10LpEv2fqh39hL0+3ZDqB1kiOJ7rD8FV8jRXrAek7MxYR7ZLZKWq0XFtenzKgtxq+aDmkGOWeKk0E5bow+1/a2VrTemy
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aea96d-fe37-47b6-97d8-08d75b4c6344
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 02:13:13.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIxH0isWpdXiTwFQ2rXzlzgv5agXguGFrU4QmP/MCVDSqxf2/EWxpVXsV5ZbmOKMmf29UPRnAF9k84rKeTgh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOoxMNTCMjbI1SAxNzo1MA0KPiBUbzogV2Vu
IEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiBDYzogbGludXgtZGV2ZWxAbGludXgubnhkaS5ueHAu
Y29tOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW3YzXSBhcm02NDogZHRzOiBsczEwMjhhOiBVcGRhdGUgdGhlIHByb3BlcnR5IG9mIHRoZSBE
VCBub2RlDQo+IGRwY2xrDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIE1vbiwg
T2N0IDE0LCAyMDE5IGF0IDAzOjEzOjI3UE0gKzA4MDAsIFdlbiBIZSB3cm90ZToNCj4gPiBVcGRh
dGUgdGhlIHByb3BlcnR5ICNjbG9jay1jZWxscyA9IDwxPiB0byAjY2xvY2stY2VsbHMgPSA8MD4g
b2YgdGhlDQo+ID4gZHBjbGssIHNpbmNlIHRoZSBEaXNwbGF5IG91dHB1dCBwaXhlbCBjbG9jayBk
cml2ZXIgcHJvdmlkZXMgc2luZ2xlDQo+ID4gY2xvY2sgb3V0cHV0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPiANCj4gVGhlIHBhdGNoIHN1Ympl
Y3QgY2FuIGJlIG1vcmUgc3BlY2lmaWMgbGlrZToNCj4gDQo+ICAgYXJtNjQ6IGR0czogbHMxMDI4
YTogVXBkYXRlICNjbG9jay1jZWxscyBvZiBkcGNsayBub2RlDQo+IA0KPiBJIHVwZGF0ZWQgaXQg
YW5kIGFwcGxpZWQgcGF0Y2guDQoNClRoYW5rcyBmb3IgeW91ciB1cGRhdGUsIHRoYW5rIHlvdS4g
DQoNCkJlc3QgUmVnYXJkcywNCldlbg0KDQo+IA0KPiBTaGF3bg0KPiANCj4gPiAtLS0NCj4gPiBj
aGFuZ2UgaW4gdjM6DQo+ID4gICAgICAgICAtIGFjY29yZGluZyB0aGUgbWFpbnRhaW5lciBjb3Jy
ZWN0aW9uIG5vZGUgbmFtZQ0KPiA+ICAgICAgICAgLSB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdl
DQo+ID4NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRz
aSB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwMjhhLmR0c2kNCj4gPiBpbmRleCA1MWZhOGY1N2ZkYWMuLjYxNmIxNTBhMTVhYSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4
YS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAy
OGEuZHRzaQ0KPiA+IEBAIC04Miw3ICs4Miw3IEBADQo+ID4gICAgICAgZHBjbGs6IGNsb2NrLWNv
bnRyb2xsZXJAZjFmMDAwMCB7DQo+ID4gICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxs
czEwMjhhLXBsbGRpZyI7DQo+ID4gICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ZjFmMDAwMCAw
eDAgMHhmZmZmPjsNCj4gPiAtICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiAgICAgICAgICAgICAgIGNsb2Nr
cyA9IDwmb3NjXzI3bT47DQo+ID4gICAgICAgfTsNCj4gPg0KPiA+IEBAIC02NjUsNyArNjY1LDcg
QEANCj4gPiAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCAyMjIgSVJRX1RZUEVfTEVWRUxf
SElHSD4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMjIzIElSUV9UWVBFX0xF
VkVMX0hJR0g+Ow0KPiA+ICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gIkRFIiwgIlNF
IjsNCj4gPiAtICAgICAgICAgICAgIGNsb2NrcyA9IDwmZHBjbGsgMD4sIDwmY2xvY2tnZW4gMiAy
PiwgPCZjbG9ja2dlbiAyIDI+LA0KPiA+ICsgICAgICAgICAgICAgY2xvY2tzID0gPCZkcGNsaz4s
IDwmY2xvY2tnZW4gMiAyPiwgPCZjbG9ja2dlbiAyIDI+LA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgPCZjbG9ja2dlbiAyIDI+Ow0KPiA+ICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAi
cHhsY2xrIiwgIm1jbGsiLCAiYWNsayIsICJwY2xrIjsNCj4gPiAgICAgICAgICAgICAgIGFybSxt
YWxpZHAtb3V0cHV0LXBvcnQtbGluZXMgPSAvYml0cy8gOCA8OCA4IDg+Ow0KPiA+IC0tDQo+ID4g
Mi4xNy4xDQo+ID4NCg==
