Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF1C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE1B214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WaEizigp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbfKGMaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:30:11 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35502 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:30:11 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hyqxdnrkHqeqYdU3NUIKD5CtJN3Ls1GrwoSHawvnrCfeJ/QLJ1Cz3Ubr78nHPkQHaESiwHVqPf
 gHJMjuFpIRD9v9xmKw/t1ohxMSmEPIXtIyym5tjwTPKN6s8LBB8taUfdohySEm4MZXqD2ZvOjJ
 amawTrnEVTee2A+5qtetdMH9SDQvoMtJsLDuq3Zt7ZsbdQphfuVdpHfJaPxv3wXtmG8zYRtlpz
 iYt6yL14qAw3ceHjkK+WJmQt7ofPn/m3WrADi7IfFXB84aBo9fzjZYpeNh2cAJFKUMb+YyZxEl
 5SI=
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="53299603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 05:30:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 05:30:07 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 05:30:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQgkL90mDP9ollLSnCoUOoLIPl/pR/+bD44DaFdnztxy7dfx/46PFaEXnzM+3soZTLwWVH8GwCc9z5Ocb8kEgk3S+LhnpSjX6vol18gscidK+eP/oHJ0zSyToih8yoKtbEdlYnxvsVVasThbn/E1NB/I/8CBLyfX6w9+Eyx6NhVKswqeInaB22ko8tDarCjk0OGIS0lQQDb62m1M+ennCBWxDp1kQWCJlMx9xIAB1iWXH5DSFp3Yi50iIuR1wFLWpdKt/aAYOML4aWS87HVQybEc+eTLz4EL9M4VHol5TPpjBOD02nVvg6lTWKSWb30YPHeWm68hUB77yMvZHnFOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+OS1/bTdZjxWrE2+suuMT9UTjZU5G+HXIdfyRqCpe4=;
 b=kYV+2d/4EqPu0TMorakn/Q213vGKI+lUbGXyck879uDFHn1s0twzlzNfBMWe416edHcvJW4kgmtZJ0E00ySFcgWjGyxTJhcGLsi/kMi/AQdqUcrV8L/fDOGw59jVpkJjQfFn+IjShWCefgx8pQzhyz95cZ1QQB0N1q7V4x9d25j668GPqEHgpMVwjdlJ4O4/d1ks64b05JtxQKiaOR1ebEzDRpUrlOpo1/D3ID0pwNwY7PPrBspQLnuQ4L5qZtYJzdoMRBlTtg+/bYSy+gsfr5J4F9ZP09rkd+7j48Bs8Q7XFJuYlqB//umh4rWE9ySbf2j24OnVBSp+lKtyt9rAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+OS1/bTdZjxWrE2+suuMT9UTjZU5G+HXIdfyRqCpe4=;
 b=WaEizigpacVYUsiP0S2tjWZMchJck7flm7Qrubhmwl4DYJrrDDv90Ac0SVnB/nz1DSfUNyrcYF5GR4UIQyysr4wNYb+DCCez34YfIuQ5PeuOpGER0v5aEu3IDb051WLrfBVoMFEOO+i9eUea7/nvc4pIuKReJFqO2AfeBWhgxl8=
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (10.255.89.94) by
 BY5PR11MB4386.namprd11.prod.outlook.com (52.132.252.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 12:30:05 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::d128:6959:f7a2:9d17]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::d128:6959:f7a2:9d17%4]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 12:30:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <manivannan.sadhasivam@linaro.org>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <robh+dt@kernel.org>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <darshak.patel@einfochips.com>, <prajose.john@einfochips.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Thread-Topic: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Thread-Index: AQHVjwDJaBck4npwFkmE20mgXgcXzqd2V+iAgAATnwCAAA/HAIAABDuAgAkwhAA=
Date:   Thu, 7 Nov 2019 12:30:05 +0000
Message-ID: <ba29a5dd-df80-841b-68cd-66cffd6ae7cf@microchip.com>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
 <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
 <20191101145806.GB13101@Mani-XPS-13-9360>
 <beb8e7fc-02c2-8267-3612-20a526ac07fd@microchip.com>
 <20191101160943.GA20347@Mani-XPS-13-9360>
In-Reply-To: <20191101160943.GA20347@Mani-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::11) To BY5PR11MB4435.namprd11.prod.outlook.com
 (2603:10b6:a03:1ce::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.12.60.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 458d75eb-7436-4ea0-84f0-08d7637e37d0
x-ms-traffictypediagnostic: BY5PR11MB4386:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR11MB43862A60A79D3E966BE0D897F0780@BY5PR11MB4386.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(186003)(446003)(66446008)(71200400001)(31686004)(66476007)(54906003)(64756008)(66556008)(102836004)(14454004)(386003)(26005)(6486002)(478600001)(25786009)(6506007)(81156014)(6436002)(486006)(52116002)(86362001)(76176011)(476003)(11346002)(36756003)(53546011)(81166006)(2616005)(66946007)(8936002)(7736002)(6916009)(6306002)(316002)(229853002)(6512007)(7416002)(966005)(66066001)(8676002)(305945005)(6246003)(14444005)(3846002)(5660300002)(4326008)(256004)(6116002)(31696002)(71190400001)(99286004)(2906002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4386;H:BY5PR11MB4435.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFqVQNkpppX2VagXZU6ZOFkxEOZFcLyTdOqHl1FTa8vubbjDd19p58AWBFWmKHuppNuPDR1vaD2zUnAW8NJ7WZwl0vEcRbF4c4Od5kKAzICXaW2kZAmIhO1MjMjGUg1fLxyXjcUAvlEYUBs6Adczk6IJQy78qtaLZQqFVJf9VOQYFTkHJ6Cd5kl8RKv09/UOP3Hai4fRnhGZ9EUwWb6s7pkSOWV076a3Nl9CXlIwtj+9ClrITS5wuQuv1RwC9vaCL6Y7NTScsPMDNi1sgCEImQW7BluFW5MfweX0hkEYfwzujZ30NYw5TxPS4/nO5eO9355ZzXqR1Ak6fEUqtHzQdeRrQGXKE1SKGHG/knk76Kg0K17FGarNjCNfhWEiVKoPoPbZmWjlICSsOPO43EkNXonMb1jRpVr3ie7op4sp3xaPCduXfDsi6r5hbZxGGFhZtMij94rZr0MfRrGPdhB0pQcSS5IUDkYyfi92m5xmu4E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <441416B7DA2EE9449842D86732C2BEDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 458d75eb-7436-4ea0-84f0-08d7637e37d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 12:30:05.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrE3zcOs8YWidhMGEeLEuxZHhFwhr6fw7+jFRXvrTl+MSaWHJxuBMHwgJ8jOuQ4GCu2LOgzaUXBdXu864PRqbfZB6XcglmzZnLVYU0sMq7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4386
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzAxLzIwMTkgMDY6MDkgUE0sIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4+IE9uIDExLzAxLzIwMTkgMDQ6NTggUE0sIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4+Pj4+IEFkZCBNVEQgc3VwcG9ydCBmb3IgdzI1cTI1Nmp3IFNQSSBOT1IgY2hpcCBmcm9tIFdp
bmJvbmQuIFRoaXMgY2hpcA0KPj4+Pj4gc3VwcG9ydHMgZHVhbC9xdWFkIEkvTyBtb2RlIHdpdGgg
NTEyIGJsb2NrcyBvZiBtZW1vcnkgb3JnYW5pemVkIGluDQo+Pj4+PiA2NEtCIHNlY3RvcnMuIElu
IGFkZGl0aW9uIHRvIHRoaXMsIHRoZXJlIGlzIGFsc28gc21hbGwgNEtCIHNlY3RvcnMNCj4+Pj4+
IGF2YWlsYWJsZSBmb3IgZmxleGliaWxpdHkuIFRoZSBkZXZpY2UgaGFzIGJlZW4gdmFsaWRhdGVk
IHVzaW5nIFRob3I5Ng0KPj4+Pj4gYm9hcmQuDQo+Pj4+Pg0KPj4+Pj4gQ2M6IE1hcmVrIFZhc3V0
IDxtYXJlay52YXN1dEBnbWFpbC5jb20+DQo+Pj4+PiBDYzogVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+Pj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJA
aW5mcmFkZWFkLm9yZz4NCj4+Pj4+IENjOiBCcmlhbiBOb3JyaXMgPGNvbXB1dGVyc2ZvcnBlYWNl
QGdtYWlsLmNvbT4NCj4+Pj4+IENjOiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPg0KPj4+Pj4gQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+DQo+
Pj4+PiBDYzogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPj4+Pj4gQ2M6
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEYXJz
aGFrIFBhdGVsIDxkYXJzaGFrLnBhdGVsQGVpbmZvY2hpcHMuY29tPg0KPj4+Pj4gW01hbmk6IGNs
ZWFuZWQgdXAgZm9yIHVwc3RyZWFtXQ0KPj4+PiBDYW4gd2Uga2VlcCBEYXJzaGFrJ3MgYXV0aG9y
c2hpcD8gV2UgdXN1YWxseSBjaGFuZ2UgdGhlIGF1dGhvciBpZiB3ZSBmZWVsIHRoYXQNCj4+Pj4g
d2UgbWFkZSBhIHNpZ25pZmljYW50IGNoYW5nZSB0byB3aGF0IHdhcyBvcmlnaW5hbGx5IHB1Ymxp
c2hlZC4NCj4+Pj4NCj4+Pj4gSWYgaXQncyBqdXN0IGFib3V0IGNvc21ldGljcywgY2xlYW5pbmcg
b3IgcmViYXNlLCB5b3UgY2FuIHNwZWNpZnkgd2hhdCB5b3UgZGlkDQo+Pj4+IGFmdGVyIHRoZSBh
dXRob3IncyBTLW8tYiB0YWcgYW5kIHRoZW4gYWRkIHlvdXIgUy1vLWIsIGFzIHlvdSBkaWQgYWJv
dmUuDQo+Pj4+DQo+Pj4gSSdkIHN1Z2dlc3QgdG8ga2VlcCBEYXJzaGFrJ3MgYXV0aG9yc2hpcCBz
aW5jZSBoZSBkaWQgdGhlIGFjdHVhbCBjaGFuZ2UgaW4NCj4+PiB0aGUgYnNwLiBJIGhhdmUgdG8g
Y2xlYW4gaXQgdXAgYmVmb3JlIHN1Ym1pdHRpbmcgdXBzdHJlYW0gYW5kIEkgbWVudGlvbmVkDQo+
Pj4gdGhlIHNhbWUgYWJvdmUuDQo+Pj4NCj4+IE9rLCBJJ2xsIGFtZW5kIHRoZSBhdXRob3Igd2hl
biBhcHBseWluZywgaXQgd2lsbCBiZSBEYXJzaGFrLg0KPj4NCj4gQWggbm8uIEkgd2FzIHNheWlu
ZyB3ZSBzaG91bGQga2VlcCBib3RoIG9mIG91cnMgYXV0aG9yc2hpcC4gSXQgc2hvdWxkbid0DQo+
IGJlIGFuIGlzc3VlIGJlY2F1c2Ugd2UgYm90aCBhcmUgaW52b2x2ZWQgaW4gdGhlIHByb2Nlc3Mu
DQoNClRoZXJlIGNhbiBiZSBvbmx5IG9uZSBhdXRob3IgaW4gYSBwYXRjaCwgYW5kIG11bHRpcGxl
IHNpZ25lcnMgaWYgbmVlZGVkOg0KDQpBdXRob3I6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFu
aXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQpEYXRlOiAgIFdlZCBPY3QgMzAgMTQ6MzE6
MjQgMjAxOSArMDUzMA0KDQogICAgbXRkOiBzcGktbm9yOiBBZGQgc3VwcG9ydCBmb3IgdzI1cTI1
Nmp3DQpbY3V0XQ0KICAgIFNpZ25lZC1vZmYtYnk6IERhcnNoYWsgUGF0ZWwgPGRhcnNoYWsucGF0
ZWxAZWluZm9jaGlwcy5jb20+DQogICAgW01hbmk6IGNsZWFuZWQgdXAgZm9yIHVwc3RyZWFtXQ0K
ICAgIFNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRo
YXNpdmFtQGxpbmFyby5vcmc+DQoNClBsZWFzZSByZWFkDQpodHRwczovL3d3dy5rZXJuZWwub3Jn
L2RvYy9odG1sL3Y1LjMvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCwgcGFyYWdyYXBo
DQoxMSksIGFuZCB0ZWxsIG1lIGlmIHlvdSB3YW50IG1lIHRvIGFtZW5kIHRoZSBhdXRob3IgdG8g
a2VlcCBEYXJzaGFrJ3MgYXV0aG9yc2hpcA0Kb3IgeW91IHdhbnQgdG8ga2VlcCB5b3Vycy4NCg==
