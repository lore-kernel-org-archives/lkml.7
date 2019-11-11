Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4284821655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ivge+mjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKKT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:26:19 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6066 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:26:18 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 8EWy9KoymLLNVzwsaTAtdbSWF5lmsKTAY4vbuwswWbksUIs71FZfOP+xnudc80kiE8krXHoKQJ
 irOTknxjJ7+QBxMC/6suyEamYiLBvvBWk8EwZLsZLz/Nn4vHH3Kg9xe5YbOdg+s5GG/pQT70J3
 29nrec5Ic5A3Jce5GJxmU8Po8GjgMaPYYXOvYVr3PY6BdgNb52+MLgmCXTehqbcDb2s9OdBlHr
 dxC+DoAm4mbc2ZNC6vG963D11LXTvq7XEbCVW0RkJVAd3HDNP3hl+5HOsF9M4C+tYkwpZtjPUc
 5Og=
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="56544654"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2019 12:26:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Nov 2019 12:26:16 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 12:26:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm9eOviSplmhYxp+RlyQIA1Bm4EN0rF7UTPX2O7bNRbn5qUm8ZcCXdVOvM6nxiDhs9qd8Jh3030gFWIUDL3LsPnwyC/nzppwfaY8oO1KfBKUpBCP9ZDonax/dApbVZaFDUX9vUBh8ZBHU8eJL0y6LE7gXBOyXMtisdEVsP9XX1TuuEBhkRbaWOWIYiF7/Bv0fk+7MQY7pxYVeGX98Ofe47HN2vV4fTDdNNIO+QPfOAW+jdwVMGwurwhU3jTD4P8WjawrVzZ6iMoLVlKMsuSd6REvKD5vlxX11nvhNsfeCESyhRr3uZFkjqa21SGUiFArR99aesJw/vPTbW7LU0gJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5+H0lxdDpsSTsnmPtFxMGlW+bDdT/vdVt7wekU+384=;
 b=eBoSyuBJDnD82jS4YEaFMPLyzkJDjPsz8bQl2kF439oCeZFy5XeuOK+Wkg5qrq2KaJnz/QaAKKPOHai8+g0LBlgmEBaKs+HVaq84i7tewvk9+l9wx9ByiynSh6gYshadpFydUgqSDFv+CDlD3f2vY1BbWxbcWeui+jzx/+7oe6D6vYnIwP7D96ySd0jr+xA6micI2ST3pr4oD5vaVs4J4HlKsTqyeDZfyqDrD0WUrXrjtPZpeozBAwNocIBY2mxiiBclz4hEZfQe3636zO8zkEWHnLqsmKcEKcHzLxAxzM+0btol76eH33fanbINWsAbvTy1Ckm7HJPOgn5Ai8R4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5+H0lxdDpsSTsnmPtFxMGlW+bDdT/vdVt7wekU+384=;
 b=ivge+mjCjFbQT4KhJydDvgkIZRQz5Vk9Dx2IWYs21X32IK0ykr5UiAqdQHT43B15jotU2LugUSgFvQ0qHTPhuEIXquLArU2CawKT0xqUBdVt12nkZcETYMSiZ2CA60adq2KgniSWWPSE3N9EHzrZC07TeuETqG35qtPGUf8xDmg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4352.namprd11.prod.outlook.com (52.135.38.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 19:26:14 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 19:26:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 0/6] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Topic: [PATCH v5 0/6] mtd: spi-nor: Quad Enable and (un)lock methods
Thread-Index: AQHVlUcxNfurCR7UA0az+I+u2JP03qeGYSqA
Date:   Mon, 11 Nov 2019 19:26:14 +0000
Message-ID: <f5b97a15-b75b-cdea-6a7e-bbd67138fe2e@microchip.com>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191107084135.22122-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0147.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::31) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.12.60.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4bfaba0-d365-4792-30e5-08d766dd0411
x-ms-traffictypediagnostic: MN2PR11MB4352:
x-microsoft-antispam-prvs: <MN2PR11MB43529766B0A7C8333E51F394F0740@MN2PR11MB4352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6512007)(446003)(11346002)(26005)(186003)(66066001)(6116002)(3846002)(2906002)(52116002)(102836004)(476003)(486006)(386003)(6506007)(53546011)(71200400001)(66476007)(4326008)(6246003)(31696002)(99286004)(14454004)(71190400001)(478600001)(76176011)(2501003)(86362001)(2616005)(66946007)(110136005)(229853002)(316002)(305945005)(8676002)(31686004)(7736002)(66446008)(36756003)(6436002)(8936002)(54906003)(5660300002)(64756008)(66556008)(6486002)(14444005)(256004)(81166006)(81156014)(25786009)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4352;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VEngF/PehdVBf3A2orfqB2LFbg8qUg1PSAsNZExPzZc24DYVrMp53PL4lUQbD9l2fgvc1p9opJ2/GOynHG/iD37XLJXGU+aMhU6lvrWbXBEwY1U3U8OfkFUFc51upEgfYvWJMmHG5i3bjAv0bWkLrcV0XBeHUlZd+b9+8dq7UQruaCx2BJdgpn+k3wrR6OqWYiwUELN7cC5Gm2Gt1dat09NOTZQU5bMCRI4qTpFG9mubFndG3dbU+uad/0wjM299zsuFejab/Z/0iKcSp5oAQX/2wXIyPSj7t2TKtwI3MLIyP6e1HD5lzlRFP8dEursuHFFtMdnq9TcXBFQqEABnMuljbZSTj22BEOuV7irT4XxQwI/IVGwli+Fw1frnKLyj2Jc1/UUryuNwiEIQxjz1uuITaWEt7lCpGDBjc3UnK/3STQYw4UKXGS+y6irz0Bvb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F4F086FFDC8FF48BF4AACA022E036FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bfaba0-d365-4792-30e5-08d766dd0411
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 19:26:14.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/WrYG3zyHO1htII8TUE8SMPz2NNlcPdUAUYjNmIcAXyzvQ5ZDJgYBUHEX7w4eKoA4zqUJdnpYpfwhtV7bC1mNOwr8lZUqn17SwCwvVqXj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA3LzIwMTkgMTA6NDEgQU0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29t
Pg0KPiANCj4gVGVzdGVkIG9uIHcyNXExMjhqdnEuDQo+IA0KPiBGaXhlZCB0aGUgY2xlYXJpbmcg
b2YgUUUgYml0IG9uICh1bilsb2NrKCkgb3BlcmF0aW9ucy4gUmV3b3JrZWQgdGhlDQo+IFF1YWQg
RW5hYmxlIG1ldGhvZHMgYW5kIHRoZSBkaXNhYmxpbmcgb2YgdGhlIGJsb2NrIHdyaXRlIHByb3Rl
Y3Rpb24NCj4gYXQgcG93ZXItdXAuDQo+IA0KPiB2NToNCj4gLSBSZW5hbWUgYWxsIFF1YWQgRW5h
YmxlIG1ldGhvZHMgaW4gb25lIHBhdGNoDQo+IC0gRXh0ZW5kIHRoZSBSZWFkIEJhY2sgdGVzdCB0
byBib3RoIFNSMSBhbmQgU1IyIGluIG9uZSBwYXRjaA0KPiAtIFJlb3JkZXIgcGF0Y2hlcywgc28g
dGhhdCB0aGUgZml4ZXMgY29tZSBvbmUgYWZ0ZXIgYW5vdGhlcg0KPiAtIENvbGxlY3QgUi1iIHRh
Z3MuDQo+IA0KPiB2NDoNCj4gLSBVc2UgZGV2X2RiZyBpbnN0ZWQgb2YgZGV2X2VyciBmb3IgbG93
IGxldmVsIGluZm8NCj4gLSByZXBsYWNlICImbm9yLT5ib3VuY2VidWZbMF0iIHdpdGggIm5vci0+
Ym91bmNlYnVmIiBhbmQgIiZzcl9jclswXSIgd2l0aA0KPiAgICJzcl9jciIuIFVwZGF0ZSBhY3Jv
c3MgYWxsIHBhdGNoZXMuDQo+IA0KPiB2Mzogc3BsaXQgcGF0Y2hlcywgdXBkYXRlIHJldGxlbiBo
YW5kbGluZyBpbiBzc3Rfd3JpdGUuDQo+IA0KPiB2MjoNCj4gLSBJbnRyb2R1Y2Ugc3BpX25vcl93
cml0ZV8xNmJpdF9jcl9hbmRfY2hlY2soKSBhcyBwZXIgVmlnbmVzaCdzIHN1Z2dlc3Rpb24uIFRo
ZQ0KPiAgIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgY29udGFpbnMgYml0cyB0aGF0IGNhbiBiZSB1
cGRhdGVkIGluIGZ1dHVyZTogRlJFRVpFLA0KPiAgIENNUC4gUHJvdmlkZSBhIGdlbmVyaWMgbWV0
aG9kIHRoYXQgYWxsb3dzIHVwZGF0aW5nIGFsbCBiaXRzIG9mIHRoZQ0KPiAgIENvbmZpZ3VyYXRp
b24gUmVnaXN0ZXIuDQo+IC0gRml4IFNOT1JfRl9OT19SRUFEX0NSIGNhc2UgaW4NCj4gICAibXRk
OiBzcGktbm9yOiBSZXdvcmsgdGhlIGRpc2FibGluZyBvZiBibG9jayB3cml0ZSBwcm90ZWN0aW9u
Ii4gV2hlbiB0aGUgZmxhc2gNCj4gICBkb2Vzbid0IHN1cHBvcnQgdGhlIENSIFJlYWQgY29tbWFu
ZCwgd2UgbWFrZSBhbiBhc3N1bXB0aW9uIGFib3V0IHRoZSB2YWx1ZSBvZg0KPiAgIHRoZSBRRSBi
aXQuIEluIHNwaV9ub3JfaW5pdCgpLCBjYWxsIHNwaV9ub3JfcXVhZF9lbmFibGUoKSBmaXJzdCwg
dGhlbg0KPiAgIHNwaV9ub3JfdW5sb2NrX2FsbCgpLCBzbyB0aGF0IGF0IHRoZSBzcGlfbm9yX3Vu
bG9ja19hbGwoKSB0aW1lIHdlIGNhbiBiZSBzdXJlDQo+ICAgdGhlIFFFIGJpdCBoYXMgdmFsdWUg
b25lLCBiZWNhdXNlIG9mIHRoZSBwcmV2aW91cyBjYWxsIHRvIHNwaV9ub3JfcXVhZF9lbmFibGUo
KS4NCj4gLSBGaXggaWYgc3RhdGVtZW50IGluIHNwaV9ub3Jfd3JpdGVfc3JfYW5kX2NoZWNrKCk6
DQo+ICAgaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTXzE2QklUX1NSKQ0KPiAtIEZpeCBkb2N1
bWVudGF0aW9uIHdhcm5pbmdzLg0KPiAtIE5ldyBwYXRjaDogIm10ZDogc3BpLW5vcjogQ2hlY2sg
YWxsIHRoZSBiaXRzIHdyaXR0ZW4sIG5vdCBqdXN0IHRoZSBCUCBvbmVzIi4NCj4gLSBEcm9wIEds
b2JhbCBVbmxvY2sgcGF0Y2hlcywgd2lsbCBzZW5kIHRoZW0gaW4gYSBkaWZmZXJlbnQgcGF0Y2gg
c2V0Lg0KPiANCj4gVGhlIHBhdGNoIHNldCBjYW4gYmUgdGVzdGVkIHVzaW5nIG10ZC11dGlsczoN
Cj4gMS8gZG8gYSByZWFkLWVyYXNlLXdyaXRlLXJlYWQtYmFjayB0ZXN0IGltbWVkaWF0ZWx5IGFm
dGVyIGJvb3QsIHRvIGNoZWNrDQo+IHRoZSBzcGlfbm9yX3VubG9ja19hbGwoKSBtZXRob2QuIFRo
ZSBmb2N1cyBpcyBvbiB0aGUgZXJhc2Uvd3JpdGUNCj4gbWV0aG9kcywgd2Ugd2FudCB0byBzZWUg
aWYgdGhlIGZsYXNoIGlzIHVubG9ja2VkIGF0IHBvd2VyLXVwLg0KPiAgICAgICAgIG10ZF9kZWJ1
ZyByZWFkIC9kZXYvbXRkLXlvdXJzIG9mZnNldCBzaXplIHJlYWQtZmlsZQ0KPiAgICAgICAgIGhl
eGR1bXAgcmVhZC1maWxlDQo+ICAgICAgICAgbXRkX2RlYnVnIGVyYXNlIC9kZXYvbXRkLXlvdXJz
IG9mZnNldCBzaXplDQo+ICAgICAgICAgZGQgaWY9L2Rldi91cmFuZG9tIG9mPXdyaXRlLWZpbGUg
YnM9cGxlYXNlLWNob29zZSBjb3VudD1wbGVhc2UtY2hvb3NlDQo+ICAgICAgICAgbXRkX2RlYnVn
IHdyaXRlIC9kZXYvbXRkLXlvdXJzIG9mZnNldCB3cml0ZS1maWxlLXNpemUgd3JpdGUtZmlsZQ0K
PiAgICAgICAgIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkLXlvdXJzIG9mZnNldCB3cml0ZS1maWxl
LXNpemUgcmVhZC1maWxlDQo+ICAgICAgICAgc2hhMXN1bSByZWFkLWZpbGUgd3JpdGUtZmlsZQ0K
PiAyLyBsb2NrIGZsYXNoIHRoZW4gdHJ5IHRvIGVyYXNlL3dyaXRlIGl0LCB0byBzZWUgaWYgdGhl
IGxvY2sgd29ya3MNCj4gICAgICAgICBmbGFzaF9sb2NrIC9kZXYvbXRkLXlvdXJzIG9mZnNldCBi
bG9jay1jb3VudA0KPiAgICAgICAgIERvIHRoZSByZWFkLWVyYXNlLXdyaXRlLXJlYWQtYmFjayB0
ZXN0IGZyb20gMS8uIFRoZSBjb250ZW50cyBvZg0KPiAgICAgICAgIGZsYXNoIHNob3VsZCBub3Qg
Y2hhbmdlIGluIHRoZSBlcmFzZSBhbmQgd3JpdGUgc3RlcHMuDQo+IDMvIHVubG9jayBmbGFzaCBh
bmQgZG8gdGhlIHJlYWQtZXJhc2Utd3JpdGUtcmVhZC1iYWNrIGZyb20gMS8uIFRoZSB2YWx1ZSBv
ZiB0aGUNCj4gICAgUUVFIHNob3VsZCBub3QgY2hhbmdlIGFuZCB5b3Ugc2hvdWxkIGJlIGFibGUg
dG8gZXJhc2UgYW5kIHdyaXRlIHRoZSBmbGFzaC4NCj4gICAgVGVzdCAxLyBzaG91bGQgYmUgc3Vj
Y2Vzc2Z1bC4NCj4gDQo+IFR1ZG9yIEFtYmFydXMgKDYpOg0KPiAgIG10ZDogc3BpLW5vcjogRml4
IGNsZWFyaW5nIG9mIFFFIGJpdCBvbiBsb2NrKCkvdW5sb2NrKCkNCj4gICBtdGQ6IHNwaS1ub3I6
IFJld29yayB0aGUgZGlzYWJsaW5nIG9mIGJsb2NrIHdyaXRlIHByb3RlY3Rpb24NCj4gICBtdGQ6
IHNwaS1ub3I6IEV4dGVuZCB0aGUgU1IgUmVhZCBCYWNrIHRlc3QNCj4gICBtdGQ6IHNwaS1ub3I6
IFJlbmFtZSBDUl9RVUFEX0VOX1NQQU4gdG8gU1IyX1FVQURfRU5fQklUMQ0KPiAgIG10ZDogc3Bp
LW5vcjogTWVyZ2Ugc3BhbnNpb24gUXVhZCBFbmFibGUgbWV0aG9kcw0KPiAgIG10ZDogc3BpLW5v
cjogUmVuYW1lIFF1YWQgRW5hYmxlIG1ldGhvZHMNCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYyB8IDQzOCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0NCj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgIHwgIDEyICstDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDI1NCBpbnNlcnRpb25zKCspLCAxOTYgZGVsZXRpb25zKC0pDQo+IA0KDQpBbWVu
ZCBjb21taXQgZGVzY3JpcHRpb24gZm9yIHBhdGNoIDIvNiwgcy90aGUgdGhlL3RoZS4NCkFsbCBh
cHBsaWVkIHRvIHNwaS1ub3IvbmV4dC4NCg==
