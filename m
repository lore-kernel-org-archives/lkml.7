Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B66CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA120862
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z/RuR9P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfKANsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:48:22 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56062 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKANsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:48:22 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: TM4YLM2emM9dNpPk9Z2MLVhIu7oHIfVDKTPNMZEICmqVZ2Ls2OpmkR/EKABAXxUwTBIQJetNpv
 dFzBUCdq2Jm3ZSplaiyCdKiONV1XE9y7ZdIgG7YFKwscMWSNYFbQqMNV1g6zrLpvGhwoSf9HeO
 qtqJEGAEzzPvETFmgplt2h1nkFa9gM+9uN8ZQ841wmixARPXrR7Cjj13Wl36C4PTYsfAO9HTu4
 tq7MzpQ1iGZZIFz+3zHor5Zytm3Q9Azv1Z5Hcu+Piwj12a2xPMvfL4YcTda0ZfVBGTWRI/AWWd
 C1Y=
X-IronPort-AV: E=Sophos;i="5.68,255,1569308400"; 
   d="scan'208";a="54967953"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2019 06:48:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 1 Nov 2019 06:48:18 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 1 Nov 2019 06:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaW61mKrcN72jkr1L0ap8+hLUPgtsoERaPrXBQuBYRvdvYGSvI8obvTT2bYMSoscV2RE6F6jFWQKZt5wD0QnDYJ5NzwX/BCQ1Bg/QcDXX1E6YTCkuZQtijXIc4ifbeTmyVNsK8hI/bMCD4LqT1pEvDFr6AL7sshkV3jodzx8mUAHsMY0OtmWPaCyZxCs7ZsTJJMIJ0zAvPSSXXt+EtHcufCxaz+r7MGben87251HEOV0FEiF2Gz4lUSXr+1r85DTnw2hd17zMpxL8orYKSLpggA6Fh0F9tdOVvMlcwKnMUaypiGc439wrsW361XbBPzyZalLCUNCD1Inyd72RAmAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObPBdlFQTZW3zRCkN08jS2cHlBZ5QF+AjZzcTSsl+zQ=;
 b=iuDrNVEarOxdFiLmbjHG2CwotVxCNsn/NSWiVcwaBV9EC+VBUTfq+3+8awVN86UU7gpXLHNEogDrXVHI6nCNT0jPvTK+ds9+/qp7tqIkXXWcVT8zUOYQnWRvbxiBV30nX4N5Q9IfuNgTrnOmcI1R3pX4WgeGFF4Ys8eN+81HyE3ZYB9WIiKpOKt/62lXTd+LZwc6UrUijnnYNgUC3E7y/3WJvzDwVjMN4ZQzNlawh7M+7aXeFMK5aKYXsKM1iq/ayRQbzM7sA5xXnppbpKyTN9O6FGGvazeAMvG229GyHEbzfGHdEZ38fi5SAnj7wqmZWes6SnGV9qRmt7zqA4Cq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObPBdlFQTZW3zRCkN08jS2cHlBZ5QF+AjZzcTSsl+zQ=;
 b=Z/RuR9P37Anb8NXX/niYsM9Y8mwIPO0tiWNS+ESutorJLiliqGhuPtG914/ipI/j1udTfSOdy6OhfW8utG9XxKM/HMSejsXA3v8IHVZdzXCwUca3V9yfbbTwnB8epXvPn3n+IuPwrgzAcetAtVoFfm1ekgMDfHs25OnWOhGE6uU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4221.namprd11.prod.outlook.com (52.135.38.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 1 Nov 2019 13:48:18 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Fri, 1 Nov 2019
 13:48:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <manivannan.sadhasivam@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <robh+dt@kernel.org>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <darshak.patel@einfochips.com>, <prajose.john@einfochips.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Thread-Topic: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Thread-Index: AQHVjwDJaBck4npwFkmE20mgXgcXzqd2V+iA
Date:   Fri, 1 Nov 2019 13:48:17 +0000
Message-ID: <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0296.eurprd07.prod.outlook.com
 (2603:10a6:800:130::24) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dad48dc-79f4-40a3-d2a8-08d75ed22634
x-ms-traffictypediagnostic: MN2PR11MB4221:
x-microsoft-antispam-prvs: <MN2PR11MB42216FF965E9DA2511A11DE4F0620@MN2PR11MB4221.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(316002)(186003)(99286004)(6506007)(446003)(386003)(71190400001)(2616005)(53546011)(476003)(11346002)(71200400001)(26005)(31686004)(52116002)(486006)(76176011)(256004)(14444005)(25786009)(229853002)(6436002)(7416002)(6246003)(6512007)(3846002)(66446008)(66556008)(102836004)(64756008)(6116002)(81166006)(110136005)(36756003)(2501003)(8676002)(305945005)(31696002)(14454004)(8936002)(81156014)(66476007)(54906003)(6486002)(5660300002)(66946007)(2906002)(66066001)(7736002)(86362001)(4326008)(2201001)(478600001)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4221;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qX7HNG+m5o82OodOnBBHLsOjdqA2uS7DswUl0mWswEPUJ29RFqpI/GGUimCqJ1UhoEx2GwcFYdRP8IeiXCFDbbPG8CVxXc0zHtuIDNCZcqzbfUU2ENzTSPGcJiD/sBmv+MeM6yPN1P65QMMkmGdm+38/Itxbvb/Qv9MqWNCPjaY0y+rjIp69FsdgLliOU2DvNeoGJkmLo+rCqWhkZSfHo+4dY24L3HxjPGWn+ioP3E3vmhjzkAA7DpBpXAzQAx42IfGqXExOZ1MyngwBqL43xPVu0nNwlJ28dNzVGCMQf/SdEWZKnQ24Gdx8y21P2yrv9QqekUdvcM8IvP/dxY02ZiBvg5IgczWZep2T1iHwOTXkXbg4Df4l15RTM04Uj2CyZXlmraVWxeMPSddRHJmFsSHxVGcbXRkGypqff5FfwkLkj5z+FZ2JFA5Pqp329GC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <919B4C0A8FBB2E44A9EB9DE0E8E6A633@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dad48dc-79f4-40a3-d2a8-08d75ed22634
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:48:17.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNlTsyH3YD2CJqXa7C2MJTK0hcCUI3eFHx8X0SOZXIQlQCxSxNS5lpNHGJ0ovvdgdxsuXd3Zt1cdfvTKlkDzRGRjXcfzs2A9cxWvv4hcsPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMwLzIwMTkgMTE6MDEgQU0sIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4gRXh0ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gQWRkIE1URCBzdXBwb3J0IGZvciB3MjVxMjU2
ancgU1BJIE5PUiBjaGlwIGZyb20gV2luYm9uZC4gVGhpcyBjaGlwDQo+IHN1cHBvcnRzIGR1YWwv
cXVhZCBJL08gbW9kZSB3aXRoIDUxMiBibG9ja3Mgb2YgbWVtb3J5IG9yZ2FuaXplZCBpbg0KPiA2
NEtCIHNlY3RvcnMuIEluIGFkZGl0aW9uIHRvIHRoaXMsIHRoZXJlIGlzIGFsc28gc21hbGwgNEtC
IHNlY3RvcnMNCj4gYXZhaWxhYmxlIGZvciBmbGV4aWJpbGl0eS4gVGhlIGRldmljZSBoYXMgYmVl
biB2YWxpZGF0ZWQgdXNpbmcgVGhvcjk2DQo+IGJvYXJkLg0KPiANCj4gQ2M6IE1hcmVrIFZhc3V0
IDxtYXJlay52YXN1dEBnbWFpbC5jb20+DQo+IENjOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQo+IENjOiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVh
ZC5vcmc+DQo+IENjOiBCcmlhbiBOb3JyaXMgPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT4N
Cj4gQ2M6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IENjOiBS
aWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiBDYzogVmlnbmVzaCBSYWdoYXZl
bmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gU2lnbmVkLW9mZi1ieTogRGFyc2hhayBQYXRlbCA8ZGFyc2hhay5wYXRlbEBlaW5mb2No
aXBzLmNvbT4NCj4gW01hbmk6IGNsZWFuZWQgdXAgZm9yIHVwc3RyZWFtXQ0KDQpDYW4gd2Uga2Vl
cCBEYXJzaGFrJ3MgYXV0aG9yc2hpcD8gV2UgdXN1YWxseSBjaGFuZ2UgdGhlIGF1dGhvciBpZiB3
ZSBmZWVsIHRoYXQNCndlIG1hZGUgYSBzaWduaWZpY2FudCBjaGFuZ2UgdG8gd2hhdCB3YXMgb3Jp
Z2luYWxseSBwdWJsaXNoZWQuDQoNCklmIGl0J3MganVzdCBhYm91dCBjb3NtZXRpY3MsIGNsZWFu
aW5nIG9yIHJlYmFzZSwgeW91IGNhbiBzcGVjaWZ5IHdoYXQgeW91IGRpZA0KYWZ0ZXIgdGhlIGF1
dGhvcidzIFMtby1iIHRhZyBhbmQgdGhlbiBhZGQgeW91ciBTLW8tYiwgYXMgeW91IGRpZCBhYm92
ZS4NCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2QuDQoNCkNoZWVycywNCnRhDQoNCj4gU2lnbmVkLW9m
Zi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
DQo+IGluZGV4IDFkODYyMWQ0MzE2MC4uMmMyNWIzNzFkOWYwIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYw0KPiBAQCAtMjQ4Miw2ICsyNDgyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFz
aF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+ICAJeyAidzI1cTI1NiIsIElORk8oMHhlZjQwMTks
IDAsIDY0ICogMTAyNCwgNTEyLCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9S
X1FVQURfUkVBRCkgfSwNCj4gIAl7ICJ3MjVxMjU2anZtIiwgSU5GTygweGVmNzAxOSwgMCwgNjQg
KiAxMDI0LCA1MTIsDQo+ICAJCQkgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQ
SV9OT1JfUVVBRF9SRUFEKSB9LA0KPiArCXsgIncyNXEyNTZqdyIsIElORk8oMHhlZjYwMTksIDAs
IDY0ICogMTAyNCwgNTEyLA0KPiArCQkJICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQg
fCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gIAl7ICJ3MjVtNTEyanYiLCBJTkZPKDB4ZWY3MTE5
LCAwLCA2NCAqIDEwMjQsIDEwMjQsDQo+ICAJCQlTRUNUXzRLIHwgU1BJX05PUl9RVUFEX1JFQUQg
fCBTUElfTk9SX0RVQUxfUkVBRCkgfSwNCj4gIA0KPiANCg==
