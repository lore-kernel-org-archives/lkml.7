Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6ADCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC411208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="r8WvupAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfKAPzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:55:04 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43259 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKAPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:55:04 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9xlI5ct+7fEVSOrqr624V0E+A3FHmz6NOgviF8b+lpjLYpeB/SboFKxeToieNy6Dtsi87eLJjO
 TOqLqsd9whrUjbkr8Yrtv0W7huUqLO+6PasaXrhRH2Sb7Fj0C0VxVpQiFh5FQFspfp56BpjHKh
 WB5CrzWJ4AwxEi+ulTiY6bh+JNCjDfGkAM+ZN7RZGTceAdNIsDbBTxtZCExVTWhTpflnU0kzNl
 Res52rUUD77yLQk9GuVVMxh68sWB1w7+JAzs4P7Vgjk7b0Ooq5NKdXyFOmE5d9u6/zsimUg3ZG
 M78=
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="56657132"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2019 08:55:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Nov 2019 08:54:59 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Nov 2019 08:55:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyUUu9uRZcfkCSMa3VYDMhVyz77KUyILqZf5bL46lPHS9aK0PRHhIQOnYrKkByX8voAqNvHxAphzKSIseU7QhYDMDR/IBKKg6flLoMW6HcQGa2q14kLC7I3INeE0M3zI2OYtV+L5gS+K4acTZQYxDvIinEeNsaI3KgYNsfi9a5xFUK6bwyLFJZjw/N6HYY6oHxvueYbSOki9xAoRWFaNcG4OsLN21pn6CTGB9TiQkwJv87kY/6kGB7uNzq4nMu/0qQMxbWrlJKtONotnOaGvyBE0q+ZW/tgknPxey/qyWzEoQfgwkdGCTET/awLSXI399lt64JII85ELFW2RRc+CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxNitJxKhn/9cc0TcqfztTY4wTbAxVQZ8yqzYr0F1uE=;
 b=Arrw51zru4dcr4OfzU4sU1fExI8sK5n+T9bO7/sQX6Ik/RMwrISZBSCOisgYn3YGnBRTr1LCEeJl2BggZdQZ0AT9b9eh74qB6kzQ2Zb+ORzN44bNAJM9npwzRN0BIk64IsPs7OqFHR+UP4kpyut7MkFEblb7ETtulk6RfjavfCz2nWEzqX8ExsHyBXibdzj1yhqYExY2OSpwiSUC9uybisPQNdkEOagJ/WD4N/4wNvi/RHKHt7LsupvtKktzkNtqzNUdcRqpgm9KwtoxfGc8qO/OphaIKSsjXA7nIEY50xeGbBOW0+420N3rqfvWdI4kSQahLUrBi7nrR8i38IBJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxNitJxKhn/9cc0TcqfztTY4wTbAxVQZ8yqzYr0F1uE=;
 b=r8WvupAGrDv38qDxvGJQm0eLVH5fNRYG8fNXvIbWyGBIiMRQDXMv8pStIryfQaEyhgw5G1aN8oZzqPblNfVXN0qiZxotbQjmBt6/60OlBSTkcs3J2dxNQSxuUqbuhTGsWe/spm4IotztX5+HjpWTtiwlLZdW9DrX5Q4W1t3RMZo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4272.namprd11.prod.outlook.com (10.255.90.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 15:55:01 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Fri, 1 Nov 2019
 15:55:01 +0000
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
Thread-Index: AQHVjwDJaBck4npwFkmE20mgXgcXzqd2V+iAgAATnwCAAA/HAA==
Date:   Fri, 1 Nov 2019 15:55:01 +0000
Message-ID: <beb8e7fc-02c2-8267-3612-20a526ac07fd@microchip.com>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
 <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
 <20191101145806.GB13101@Mani-XPS-13-9360>
In-Reply-To: <20191101145806.GB13101@Mani-XPS-13-9360>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0131.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::29) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8125261-263e-48bd-66ab-08d75ee3da64
x-ms-traffictypediagnostic: MN2PR11MB4272:
x-microsoft-antispam-prvs: <MN2PR11MB427289AC235C1824A5F59278F0620@MN2PR11MB4272.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(14454004)(53546011)(76176011)(66066001)(102836004)(31696002)(6506007)(386003)(71200400001)(7416002)(86362001)(8936002)(81166006)(8676002)(229853002)(5660300002)(186003)(54906003)(6436002)(81156014)(26005)(6486002)(71190400001)(11346002)(7736002)(478600001)(476003)(486006)(305945005)(446003)(2616005)(2906002)(52116002)(6916009)(316002)(66446008)(64756008)(66556008)(66946007)(6116002)(3846002)(25786009)(256004)(36756003)(14444005)(6512007)(31686004)(4326008)(99286004)(6246003)(66476007)(138113003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4272;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lY61EpP2OcIHIr7rpElivG9liRtZeRgFf2/KBOAqpyhdWHYGawXbkuwTWWedg0GPfXcDkrIAQEJr8ezuz5Er8ry8+aK3RN6/cVPZijFYhCGsp/J1ZEb5CgaZKxLMMk9hTZDesKY5IyfY9MDT4qFo0PcXluvlbZWk8VPtApOJK4qIKHrxNisYqXvD/kRXp3zwjiviDNgDqh0mm1JhY0GEPfi2+Qii2XaFwuK9bqlOD2i5eGwiiPjOmUavN7nX2VqRDvVuZuIgvRYnCOBDwTMJ9XkGowJiVyZJpun/kHpbaPaISooHIPgePBDVDKGPLLWbnYxiaJtoWFJrd3TbWaFGNo0JX3a2BL4pzhXMc7vK8AAKkQ3FHs8PUTjofrlK8evACXy/kf1vfVK+KUqz3XaiBqlgTgKGzfiiomUeW4JT+IJ+1hrGzfDJEcwtojliecbO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <26340E6D4F8B2B47A7889F0967A379DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8125261-263e-48bd-66ab-08d75ee3da64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:55:01.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+ZwZ0L8ZWh8fVXlatockgfCPUXcwuxwc6plgh/q4bC8E61zChH0vOmu32zB+a1nLyCVjqFcSU9IEU7K3jVLjNMX5IIe5QLzV3R/4aZ2e9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzAxLzIwMTkgMDQ6NTggUE0sIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4+PiBBZGQgTVREIHN1cHBvcnQgZm9yIHcyNXEyNTZqdyBTUEkgTk9SIGNoaXAgZnJvbSBXaW5i
b25kLiBUaGlzIGNoaXANCj4+PiBzdXBwb3J0cyBkdWFsL3F1YWQgSS9PIG1vZGUgd2l0aCA1MTIg
YmxvY2tzIG9mIG1lbW9yeSBvcmdhbml6ZWQgaW4NCj4+PiA2NEtCIHNlY3RvcnMuIEluIGFkZGl0
aW9uIHRvIHRoaXMsIHRoZXJlIGlzIGFsc28gc21hbGwgNEtCIHNlY3RvcnMNCj4+PiBhdmFpbGFi
bGUgZm9yIGZsZXhpYmlsaXR5LiBUaGUgZGV2aWNlIGhhcyBiZWVuIHZhbGlkYXRlZCB1c2luZyBU
aG9yOTYNCj4+PiBib2FyZC4NCj4+Pg0KPj4+IENjOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRA
Z21haWwuY29tPg0KPj4+IENjOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQo+Pj4gQ2M6IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCj4+
PiBDYzogQnJpYW4gTm9ycmlzIDxjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb20+DQo+Pj4gQ2M6
IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+Pj4gQ2M6IFJpY2hh
cmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+DQo+Pj4gQ2M6IFZpZ25lc2ggUmFnaGF2ZW5k
cmEgPHZpZ25lc2hyQHRpLmNvbT4NCj4+PiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4+PiBTaWduZWQtb2ZmLWJ5OiBEYXJzaGFrIFBhdGVsIDxkYXJzaGFrLnBhdGVsQGVpbmZv
Y2hpcHMuY29tPg0KPj4+IFtNYW5pOiBjbGVhbmVkIHVwIGZvciB1cHN0cmVhbV0NCj4+IENhbiB3
ZSBrZWVwIERhcnNoYWsncyBhdXRob3JzaGlwPyBXZSB1c3VhbGx5IGNoYW5nZSB0aGUgYXV0aG9y
IGlmIHdlIGZlZWwgdGhhdA0KPj4gd2UgbWFkZSBhIHNpZ25pZmljYW50IGNoYW5nZSB0byB3aGF0
IHdhcyBvcmlnaW5hbGx5IHB1Ymxpc2hlZC4NCj4+DQo+PiBJZiBpdCdzIGp1c3QgYWJvdXQgY29z
bWV0aWNzLCBjbGVhbmluZyBvciByZWJhc2UsIHlvdSBjYW4gc3BlY2lmeSB3aGF0IHlvdSBkaWQN
Cj4+IGFmdGVyIHRoZSBhdXRob3IncyBTLW8tYiB0YWcgYW5kIHRoZW4gYWRkIHlvdXIgUy1vLWIs
IGFzIHlvdSBkaWQgYWJvdmUuDQo+Pg0KPiBJJ2Qgc3VnZ2VzdCB0byBrZWVwIERhcnNoYWsncyBh
dXRob3JzaGlwIHNpbmNlIGhlIGRpZCB0aGUgYWN0dWFsIGNoYW5nZSBpbg0KPiB0aGUgYnNwLiBJ
IGhhdmUgdG8gY2xlYW4gaXQgdXAgYmVmb3JlIHN1Ym1pdHRpbmcgdXBzdHJlYW0gYW5kIEkgbWVu
dGlvbmVkDQo+IHRoZSBzYW1lIGFib3ZlLg0KPiANCg0KT2ssIEknbGwgYW1lbmQgdGhlIGF1dGhv
ciB3aGVuIGFwcGx5aW5nLCBpdCB3aWxsIGJlIERhcnNoYWsuDQoNClRoYW5rcywNCnRhDQo=
