Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A74C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558592086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K+hnBYCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfHSHaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:30:55 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:59249
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbfHSHay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH1ZF1iuPjy8HHx9R0tnZiMDM2PYXrO/WN0BJtq0utcxpiNyhEAmEK3UMAk+s7jM5/FM6Esv6Vg0FGSRAdlRCW1dUIfH1XvTYeulQsv4yW779KEP/Kc7cPQMVTW+6bXsJXYaa7UJ1Rvz0QI9HHVocZJ0aC6llOrUHFS1eRgy/FcD+j/nwqfGie87wjF/36iV05FPD/m6rqxVOWrwv3wWS5wb2nKe6VBgL5hi2SN8BfiBd3EgnVSfnLPazaJdw5YA3XnJLh0Zqfg7LuEJmrolwI2KdzXvesa+s8MLCM9V34DoLz/djdR2J7eLzGdW8biY3B2Vs537eBYTzmSJgA2yzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrX/WN8XFIbL4nK+2o/lXTxkY7X7mn5sjirk1m42TQc=;
 b=AGnKLFrlukrcuqpW+gIU4TjYr+20v4F7rgOdXvBTWckRgmxYo9CMk+GrUHfDE9c9Th0IO9QPT1LPe7DhKIJhbbebnsW82+1FOOKkCRHVYrz337uIt+oDc9aHHxfBfeojovS+EPeJsE4r+t+3DyIL0jczqmcMzebgQf5GGXIgaPqlHekNK6vM8zFIP31wZE6p5f2c07ju+N+ZCti/s/gM9o4qJAxhBdY8cyc8K356MS2zlNH8yJ0XWGamei24sbt11TPGOC+IGHZdFGyLe8R84XG+0qC2QL98TZt3PAYEd7LrqsaMtmU6WA53/LoIkYk6FIrbmuh1JfhNWK++zazS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrX/WN8XFIbL4nK+2o/lXTxkY7X7mn5sjirk1m42TQc=;
 b=K+hnBYCrESyBP6N0Lexd43KlhUIBjMsKK4qERjm5na1k8e6AXySevyYWQbBWPmoty9jlbNrZSbpwyxfPbVoD3092I3bWQkvqV63DPVjy1A3uutwd4vbseBZ/J340ibFYwI57DitLecGKAswnFIcSIX6/WE2VsXaYavtqomGTAHI=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4985.eurprd04.prod.outlook.com (20.176.234.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 07:30:49 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e854:ffa9:a285:88a4%5]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 07:30:49 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Subject: RE: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Topic: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display
 output interface
Thread-Index: AQHVU1PbObDpg5VHhkiHRWFbV1fnLab+DmGAgAO1CpA=
Date:   Mon, 19 Aug 2019 07:30:49 +0000
Message-ID: <DB7PR04MB51952DF4E1EE7FF10A947347E2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com>
 <20190815101613.22872-2-wen.he_1@nxp.com>
 <20190816174624.115FC205F4@mail.kernel.org>
In-Reply-To: <20190816174624.115FC205F4@mail.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 449f33ed-de2c-441e-96c3-08d724772872
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4985;
x-ms-traffictypediagnostic: DB7PR04MB4985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4985B643D410D261593EBEB1E2A80@DB7PR04MB4985.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(13464003)(199004)(189003)(478600001)(486006)(2906002)(86362001)(52536014)(7736002)(66446008)(8936002)(55016002)(66946007)(64756008)(316002)(110136005)(66476007)(6436002)(81156014)(54906003)(8676002)(229853002)(81166006)(6116002)(6506007)(53546011)(102836004)(5660300002)(66066001)(446003)(9686003)(476003)(3846002)(66556008)(71190400001)(2501003)(71200400001)(25786009)(99286004)(53936002)(74316002)(76116006)(2201001)(76176011)(305945005)(186003)(6246003)(11346002)(26005)(256004)(7696005)(4326008)(33656002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4985;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SvDq2T+a/Et9uR7Z/soz3HiM+SXVLdb8fTowHqStKBJqSHVEq4IgTZPey7StyDtHdgrIh3G63DJSSd0kAZQw16zrDJnzAvbmqxJm1BDQknxPf0QB6HWz/t6t0y/jMkgYARxugB2CTFLu3W0sGTu9/Gb3n5BEb/oaRfCQ3aThGn/1tNyCEX/JzZWny+jgggBUipATpEsmhgaUvXUZfE+F5A0F/9o5Yt29smixp2GvbF1ry1meWhNPDEnsC5+p1OulTfSzY7CmF9n+SuwBQlIX4roa8TnUegmmxVdzPLOQ+8SN1U6NML2T59gS5jhOdZO1d6x3oC4BY1qFGtKWDZKGPkAuNNi4VvEQVMkrGavtsa+Ta+iO08wCTqucHJkdK5XTOlaIK5I7DipiF39hrwh7J1dI7Q/gKWrXQq8i22X7pHs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449f33ed-de2c-441e-96c3-08d724772872
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 07:30:49.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lY0nLMhorw6iBBiixsm5vd6fK612Rz6E7JGnpfivXxsCukd+LZUqT0PysV2vKeAKliUi4xgyPdJoRAqmfO1RqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlcGhlbiBCb3lkIDxz
Ym95ZEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0OOaciDE35pelIDE6NDYNCj4gVG86IE1h
cmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgV2VuIEhlIDx3ZW4uaGVfMUBu
eHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LWRldmVsQGxpbnV4Lm54ZGkubnhwLmNvbTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBsaXZp
dS5kdWRhdUBhcm0uY29tOyBXZW4gSGUNCj4gPHdlbi5oZV8xQG54cC5jb20+DQo+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbdjIgMi8zXSBjbGs6IGxzMTAyOGE6IEFkZCBjbG9jayBkcml2ZXIgZm9yIERp
c3BsYXkgb3V0cHV0DQo+IGludGVyZmFjZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0K
PiBRdW90aW5nIFdlbiBIZSAoMjAxOS0wOC0xNSAwMzoxNjoxMikNCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL0tjb25maWcgaW5kZXgNCj4gPiA4MDFm
YTFjZDAzMjEuLjNjOTVkOGVjMzFkNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9LY29u
ZmlnDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvS2NvbmZpZw0KPiA+IEBAIC0yMjMsNiArMjIzLDE2
IEBAIGNvbmZpZyBDTEtfUU9SSVENCj4gPiAgICAgICAgICAgVGhpcyBhZGRzIHRoZSBjbG9jayBk
cml2ZXIgc3VwcG9ydCBmb3IgRnJlZXNjYWxlIFFvcklRIHBsYXRmb3Jtcw0KPiA+ICAgICAgICAg
ICB1c2luZyBjb21tb24gY2xvY2sgZnJhbWV3b3JrLg0KPiA+DQo+ID4gK2NvbmZpZyBDTEtfTFMx
MDI4QV9QTExESUcNCj4gPiArICAgICAgICBib29sICJDbG9jayBkcml2ZXIgZm9yIExTMTAyOEEg
RGlzcGxheSBvdXRwdXQiDQo+ID4gKyAgICAgICBkZXBlbmRzIG9uIChBUkNIX0xBWUVSU0NBUEUg
fHwgQ09NUElMRV9URVNUKSAmJiBPRg0KPiANCj4gV2hlcmUgaXMgdGhlIE9GIGRlcGVuZGVuY3kg
dG8gYnVpbGQgYW55dGhpbmc/IERvZXNuJ3QgdGhpcyBzdGlsbCBjb21waWxlDQo+IHdpdGhvdXQg
Q09ORklHX09GIHNldD8NCg0KWWVzLCBjdXJyZW50IGluY2x1ZGVkIHNvbWUgQVBJcyBvZiB0aGUg
T0YsIGxpa2Ugb2ZfZ2V0X3BhcmVudF9uYW1lKCkNCg0KPiANCj4gPiArICAgICAgIGRlZmF1bHQg
QVJDSF9MQVlFUlNDQVBFDQo+ID4gKyAgICAgICAgaGVscA0KPiA+ICsgICAgICAgICAgVGhpcyBk
cml2ZXIgc3VwcG9ydCB0aGUgRGlzcGxheSBvdXRwdXQgaW50ZXJmYWNlcyhMQ0QsIERQSFkpDQo+
IHBpeGVsIGNsb2Nrcw0KPiA+ICsgICAgICAgICAgb2YgdGhlIFFvcklRIExheWVyc2NhcGUgTFMx
MDI4QSwgYXMgaW1wbGVtZW50ZWQgVFNNQw0KPiBDTE4yOEhQTSBQTEwuIE5vdCBhbGwNCj4gPiAr
ICAgICAgICAgIGZlYXR1cmVzIG9mIHRoZSBQTEwgYXJlIGN1cnJlbnRseSBzdXBwb3J0ZWQgYnkg
dGhlIGRyaXZlci4gQnkNCj4gZGVmYXVsdCwNCj4gPiArICAgICAgICAgIGNvbmZpZ3VyZWQgYnlw
YXNzIG1vZGUgd2l0aCB0aGlzIFBMTC4NCj4gDQo+IFRoZXNlIGxpbmVzIGxvb2sgc29ydCBvZiBs
b25nLiBBcmUgdGhleSB1bmRlciA4MCBjb2x1bW5zPw0KPiANCg0KWWVzLCB0aGV5IGhhZCBiZWVu
IGNoZWNrZWQgYnkgdGhlIGNoZWNrcGF0Y2gucGwuIA0KDQo+ID4gKw0KPiA+ICBjb25maWcgQ09N
TU9OX0NMS19YR0VORQ0KPiA+ICAgICAgICAgYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBBUE0gWEdl
bmUgU29DIg0KPiA+ICAgICAgICAgZGVmYXVsdCBBUkNIX1hHRU5FDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL01ha2VmaWxlIGIvZHJpdmVycy9jbGsvTWFrZWZpbGUgaW5kZXgNCj4gPiAw
Y2FkNzYwMjEyOTcuLmM4ZTIyYTc2NGM0ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9N
YWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL01ha2VmaWxlDQo+ID4gQEAgLTQ0LDYgKzQ0
LDcgQEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfT1hOQVMpDQo+ICs9IGNsay1veG5hcy5vDQo+
ID4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX1BBTE1BUykgICAgICAgICAgICAgICAgKz0gY2xr
LXBhbG1hcy5vDQo+ID4gIG9iai0kKENPTkZJR19DT01NT05fQ0xLX1BXTSkgICAgICAgICAgICs9
IGNsay1wd20ubw0KPiA+ICBvYmotJChDT05GSUdfQ0xLX1FPUklRKSAgICAgICAgICAgICAgICAg
ICAgICAgICs9IGNsay1xb3JpcS5vDQo+ID4gK29iai0kKENPTkZJR19DTEtfTFMxMDI4QV9QTExE
SUcpICAgICAgICs9IGNsay1wbGxkaWcubw0KPiA+ICBvYmotJChDT05GSUdfQ09NTU9OX0NMS19S
SzgwOCkgICAgICAgICArPSBjbGstcms4MDgubw0KPiA+ICBvYmotJChDT05GSUdfQ09NTU9OX0NM
S19ISTY1NVgpICAgICAgICAgICAgICAgICs9IGNsay1oaTY1NXgubw0KPiA+ICBvYmotJChDT05G
SUdfQ09NTU9OX0NMS19TMk1QUzExKSAgICAgICArPSBjbGstczJtcHMxMS5vDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1wbGxkaWcuYyBiL2RyaXZlcnMvY2xrL2Nsay1wbGxkaWcu
YyBuZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uNjA5ODhiMGVh
MjBhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1wbGxkaWcu
Yw0KPiA+IEBAIC0wLDAgKzEsMjc4IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ID4gKy8vIENvcHlyaWdodCAyMDE5IE5YUA0KPiA+ICsNCj4gPiArLyoNCj4g
PiArICogQ2xvY2sgZHJpdmVyIGZvciBMUzEwMjhBIERpc3BsYXkgb3V0cHV0IGludGVyZmFjZXMo
TENELCBEUEhZKS4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLXBy
b3ZpZGVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9pby5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9vZi5oPg0KPiBbLi4uXQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBwbGxk
aWdfY2xrX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICAg
IHN0cnVjdCBjbGtfcGxsZGlnICpkYXRhOw0KPiA+ICsgICAgICAgc3RydWN0IHJlc291cmNlICpt
ZW07DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpwYXJlbnRfbmFtZTsNCj4gPiArICAgICAgIHN0
cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQgPSB7fTsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAg
ICAgIGRhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsN
Cj4gPiArICAgICAgIGlmICghZGF0YSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+ID4gKw0KPiA+ICsgICAgICAgbWVtID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiArICAgICAgIGRhdGEtPnJlZ3MgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoZGV2LCBtZW0pOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihkYXRhLT5yZWdz
KSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZGF0YS0+cmVncyk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgaW5pdC5uYW1lID0gZGV2LT5vZl9ub2RlLT5uYW1lOw0KPiA+ICsgICAg
ICAgaW5pdC5vcHMgPSAmcGxsZGlnX2Nsa19vcHM7DQo+ID4gKyAgICAgICBwYXJlbnRfbmFtZSA9
IG9mX2Nsa19nZXRfcGFyZW50X25hbWUoZGV2LT5vZl9ub2RlLCAwKTsNCj4gPiArICAgICAgIGlu
aXQucGFyZW50X25hbWVzID0gJnBhcmVudF9uYW1lOw0KPiANCj4gQ2FuIHlvdSB1c2UgdGhlIG5l
dyB3YXkgb2Ygc3BlY2lmeWluZyBjbGsgcGFyZW50cyB3aXRoIHRoZSBwYXJlbnRfZGF0YQ0KPiBt
ZW1iZXIgb2YgY2xrX2luaXQ/DQoNCk9mIGNvdXJzZSwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgbmVlZCByZWNvbW1lbmQgdG8gdXNlIHRoaXMgbWVtYmVyPw0KSXMgdGhhdCB0aGUgbWVtYmVy
IHBhcmVudF9uYW1lcyB3aWxsIGJlIGRpc2NhcmQgaW4gZnV0dXJlPw0KDQpIZXJlIGFyZSBkZWZp
bml0aW9uIG9mIHRoZSBjbGstcHJvdmlkZXIuaA0KLyogT25seSBvbmUgb2YgdGhlIGZvbGxvd2lu
ZyB0aHJlZSBzaG91bGQgYmUgYXNzaWduZWQgKi8NCmNvbnN0IGNoYXIgICAgICAgICAgICAgICog
Y29uc3QgKnBhcmVudF9uYW1lczsNCmNvbnN0IHN0cnVjdCBjbGtfcGFyZW50X2RhdGEgICAgKnBh
cmVudF9kYXRhOw0KY29uc3Qgc3RydWN0IGNsa19odyAgICAgICAgICAgICAqKnBhcmVudF9od3M7
DQoNCkZvciBQTExESUcsIGl0IG9ubHkgaGFzIG9uZSBwYXJlbnQuDQoNCg0KPiANCj4gPiArICAg
ICAgIGluaXQubnVtX3BhcmVudHMgPSAxOw0KPiA+ICsNCj4gPiArICAgICAgIGRhdGEtPmh3Lmlu
aXQgPSAmaW5pdDsNCj4gPiArICAgICAgIGRhdGEtPmRldiA9IGRldjsNCj4gPiArDQo+ID4gKyAg
ICAgICByZXQgPSBkZXZtX2Nsa19od19yZWdpc3RlcihkZXYsICZkYXRhLT5odyk7DQo+ID4gKyAg
ICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHJlZ2lzdGVyICVzIGNsb2NrXG4iLCBpbml0Lm5hbWUpOw0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBv
Zl9jbGtfYWRkX2h3X3Byb3ZpZGVyKGRldi0+b2Zfbm9kZSwNCj4gPiArIG9mX2Nsa19od19zaW1w
bGVfZ2V0LA0KPiANCj4gVXNlIGRldm0/IFNvIHRoYXQgZHJpdmVyIHJlbW92ZSBmcmVlcyB0aGlz
Lg0KDQpZZXMsIGhlcmUgYWxzbyBzaG91bGQgYmUgdXNpbmcgZGV2bV9vZl9jbGtfYWRkX2h3X3By
b3ZpZGVyKCkuDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgJmRhdGEtPmh3KTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBwbGxkaWdfY2xrX3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKyAgICAgICBvZl9jbGtfZGVsX3Byb3ZpZGVy
KHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBwbGxkaWdfY2xrX2lkW10g
PSB7DQo+ID4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gImZzbCxsczEwMjhhLXBsbGRpZyIsIC5k
YXRhID0gTlVMTH0sDQo+ID4gKyAgICAgICB7IH0NCj4gPiArfTsNCj4gDQo+IEFkZCBhIE1PRFVM
RV9ERVZJQ0VfVEFCTEUob2YsIHBsbGRpZ19jbGtfaWQpIGhlcmUuDQo+IA0KT0ssDQoNCj4gPiAr
DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHBsbGRpZ19jbGtfZHJpdmVyID0g
ew0KPiA+ICsgICAgICAgLmRyaXZlciA9IHsNCj4gPiArICAgICAgICAgICAgICAgLm5hbWUgPSAi
cGxsZGlnLWNsb2NrIiwNCj4gPiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gcGxs
ZGlnX2Nsa19pZCwNCj4gPiArICAgICAgIH0sDQo+ID4gKyAgICAgICAucHJvYmUgPSBwbGxkaWdf
Y2xrX3Byb2JlLA0KPiA+ICsgICAgICAgLnJlbW92ZSA9IHBsbGRpZ19jbGtfcmVtb3ZlLA0KPiA+
ICt9Ow0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKHBsbGRpZ19jbGtfZHJpdmVyKTsNCj4g
PiArDQo+ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gPiArTU9EVUxFX0FVVEhPUigi
V2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPiIpOw0KPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkxT
MTAyOEEgRGlzcGxheSBvdXRwdXQgaW50ZXJmYWNlIHBpeGVsIGNsb2NrDQo+ID4gK2RyaXZlciIp
OyBNT0RVTEVfQUxJQVMoInBsYXRmb3JtOmxzMTAyOGEtcGxsZGlnIik7DQo+IA0KPiBEcm9wIE1P
RFVMRV9BTElBUywgaXQncyBub3QgdXNlZnVsLg0KDQpPSywgDQoNCkJlc3QgUmVnYXJkcywNCldl
bg0K
