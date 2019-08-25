Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB2EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A9C2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QKyz1SJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfHYNCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:02:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:39127 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:02:41 -0400
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
IronPort-SDR: qNABGxpzW1qSci7SKBrZbKYsHhdYTfOnSoZtPf67LSYcyDxukLEtbhPf13eUPPaynO8m1g52cD
 i4yEEBU/t/CDsA7VkcQlag0qfR+Tr1GB8LeJ2GGan5VkxgFvvIl9OAUQqlzoN4dvewaBjH2AoG
 lso5WFPHyzaCuF0DrRT76gksijKOtkUYC+4wLE7EDRG2OeL/f8dmowcjlattbkK1goSKxau10H
 CpCSnWXJvkTX25sCOSd2PxKYooN/KAqAS9/aA04C84PSaWfGxlALbEbFYeUE8ew11HWizbu4PK
 X+c=
X-IronPort-AV: E=Sophos;i="5.64,429,1559545200"; 
   d="scan'208";a="46445040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2019 06:02:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 25 Aug 2019 06:02:40 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sun, 25 Aug 2019 06:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpanFxQl7KVq+wvQ/8ACpfDKfdOFC9LlGmE/Oy0QUvFNGWphYa8O4H9fz8rHpx3jN2InOmikVTQ5aFx3RG4gBkWESfN2n1CvB015lGzpc3pLr671lNyvf365+KzKUiN3v7WeR5L6uDX4etprQORa3rgFm12wk7Co/puUi/M4xQcr+SceQ0pTrmsR41q4ZWDaqO2ol8Ic2ZwfZcwCDkdBUr2ZHywzSUHS/Jq1kHTC3WbbJ2gx/pXps30OIR7uSlEmMFnzcGwZyTPDbTTDyE2pDSl4hlm6W7X2HObqma6bZu2qRoAPFcWr7EIesbnCJW8Nu0D+5aQPepLLoWekkCubIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFr1F7mbUWaSWcoNHTD0kdIRdPsGuFTEZ+Wmdv6fF/Y=;
 b=Pn6PT0EwKw4uPDmZYxTtVXyvlmsCiqjFH1KTtIzNipChXg/CJEhYgfJqoiWyTH5/y6ijUzLYjHOGR+TqFB8eE2eRFy8Gx21ZaKzSFgp3AmiSxuD21BpDauN68MpOKYJ/icBmhvbVxrUnqHnHJUbG4J3qvmjvl3Gq2kmSsk1sxjgH3ekdM/U9krhTR2ZiMcD8Cc05UY6gXK1RDYgJPTQzCq9Oo+EG0tzzWk/GIK9zQmnEjDshtnO8L7fqI2WaigwQdi1bJf1T/3VpTOujVSU6Nsl/9XD1csSyFlRstuHSQHR1DHfyE7CLuetS6xh8rxAhYgOOzPUusFWirlNmvLtciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFr1F7mbUWaSWcoNHTD0kdIRdPsGuFTEZ+Wmdv6fF/Y=;
 b=QKyz1SJWGLNpFHFSpQreRbeR2KX9YqGnsAFh2zzfkksKiNVVdQYYDTCc61CJ1VsGttpqJyHPhQTvsXXViI1JZWTi5iWPPlTD+Gs3EXwHUn+i21NW8PF+r7Ja4E6IWOzkeqe0YaIIg9hcJjiIhXQrIy6tDsihxV2yyO8UpffcFRM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3549.namprd11.prod.outlook.com (20.178.250.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Sun, 25 Aug 2019 13:02:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Sun, 25 Aug 2019
 13:02:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] mtd: spi-nor: move manuf out of the core - batch 0
Thread-Topic: [PATCH 0/5] mtd: spi-nor: move manuf out of the core - batch 0
Thread-Index: AQHVWcrqkdBlY7ZNLEeSbvjl5RDoUqcLv8GAgAAXXwA=
Date:   Sun, 25 Aug 2019 13:02:38 +0000
Message-ID: <6098471f-ab8a-4887-7065-2d2266492ee8@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
 <20190825133853.32532641@collabora.com>
In-Reply-To: <20190825133853.32532641@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0304.eurprd07.prod.outlook.com
 (2603:10a6:800:130::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e65b71b2-372d-4b71-0f88-08d7295c81c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3549;
x-ms-traffictypediagnostic: MN2PR11MB3549:
x-microsoft-antispam-prvs: <MN2PR11MB35492DA34F9DDE0580AFFFD0F0A60@MN2PR11MB3549.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39850400004)(199004)(189003)(316002)(6246003)(54906003)(6512007)(446003)(31686004)(25786009)(476003)(2616005)(53936002)(486006)(11346002)(6486002)(4326008)(2906002)(76176011)(99286004)(229853002)(6436002)(71200400001)(71190400001)(31696002)(52116002)(86362001)(305945005)(14454004)(256004)(14444005)(66066001)(66476007)(66556008)(64756008)(66446008)(6916009)(66946007)(3846002)(6116002)(53546011)(6506007)(386003)(102836004)(26005)(186003)(8936002)(36756003)(8676002)(81166006)(81156014)(7736002)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3549;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lRgpjMT0aRfblOeWkx9uOd2FLVI1hg19H3h9vmJYMWrhVRuL85J1hfYmCROSOQuZCoCaCCifQ9mSCP2H6UMPjKlzm8lcwVbYO5UjPlVGtPJOsxyGpEVoTObQPVkjXXTsoI0plKU//rrA+ii7xxX7fW7UZyrZ0NMXtM5SYWxENBXnTIrU3zkZ6MtfTfvwU66X2nd1B8BWtrlYhRKELSt8AjRtEX7zQg8lnGafEmnTXS6t+tUynHB7xRTw6IJgUojwWu2FjywN347WFNLh0a7eHbKQBMae/DxI6F3mH8I6ddjsWkoCPmDN6Au3leH50ScSwEl7yisAOLo7Yj6s19tbd+oDpyXE6pDx9TEHopgW7unvmBr6ntLwb1l/w+/3vCcdZu4LeeA5UfVTE5/4Rr4kLj8kuX5qbkAAoIsoD3+HKfE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <781FEA68F19F6D4EB799DCD55D7C42CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e65b71b2-372d-4b71-0f88-08d7295c81c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 13:02:38.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrRcPxwZHHUjoo9SzOboNL36NRKZ5lwnvuufo3XLQCYb2FSiWtmm3+JbOUpB4huO+xKRtEb/bo1KUkD3+fiGIuUF2MweyV3NTWYx7bCzuxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI1LzIwMTkgMDI6MzggUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gRnJpLCAyMyBBdWcgMjAxOSAxNTo1MzozMyArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhpcyBz
ZXJpZXMgaXMgYSBwcmVyZXF1aXNpdGUgZm9yIHRoZSBlZmZvcnQgb2YgbW92aW5nIHRoZQ0KPj4g
bWFudWZhY3R1cmVyIHNwZWNpZmljIGNvZGUgb3V0IG9mIHRoZSBTUEkgTk9SIGNvcmUuDQo+Pg0K
Pj4gVGhlIHNjb3BlIGlzIHRvIG1vdmUgYWxsIFtGTEFTSC1TUEVDSUZJQ10gcGFyYW1ldGVycyBh
bmQgc2V0dGluZ3MNCj4+IGZyb20gJ3N0cnVjdCBzcGlfbm9yJyB0byAnc3RydWN0IHNwaV9ub3Jf
Zmxhc2hfcGFyYW1ldGVyJy4gV2Ugd2lsbA0KPj4gaGF2ZSBhIGNsZWFyIHNlcGFyYXRpb24gYmV0
d2VlbiB0aGUgU1BJIE5PUiBsYXllciBhbmQgdGhlIGZsYXNoDQo+PiBwYXJhbWV0ZXJzIGFuZCBz
ZXR0aW5ncy4NCj4+DQo+PiAnc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyJyBkZXNjcmli
ZXMgdGhlIGhhcmR3YXJlIGNhcGFiaWxpdGllcw0KPj4gYW5kIGFzc29jaWF0ZWQgc2V0dGluZ3Mg
b2YgdGhlIFNQSSBOT1IgZmxhc2ggbWVtb3J5LiBJdCBpbmNsdWRlcw0KPj4gbGVnYWN5IGZsYXNo
IHBhcmFtZXRlcnMgYW5kIHNldHRpbmdzIHRoYXQgY2FuIGJlIG92ZXJ3cml0dGVuIGJ5IHRoZQ0K
Pj4gc3BpX25vcl9maXh1cHMgaG9va3MsIG9yIGR5bmFtaWNhbGx5IHdoZW4gcGFyc2luZyB0aGUg
SkVTRDIxNg0KPj4gU2VyaWFsIEZsYXNoIERpc2NvdmVyYWJsZSBQYXJhbWV0ZXJzIChTRkRQKSB0
YWJsZXMuIEFsbCBTRkRQIHBhcmFtcw0KPj4gYW5kIHNldHRpbmdzIHdpbGwgZml0IGluc2lkZSAn
c3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyJy4NCj4gDQo+IFdoaWxlIHdlJ3JlIGF0IG1v
dmluZyB0aGluZ3MgYXJvdW5kLCBJIHRoaW5rIGl0J2QgbWFrZSBzZW5zZSB0byBtb3ZlDQo+IGFs
bCAnW0RSSVZFUiBTUEVDSUZJQ10nIGZpZWxkcyAod2hpY2ggYXJlIGFjdHVhbGx5IFNQSSBOT1Ig
Y29udHJvbGxlcg0KPiBkcml2ZXIgc3BlY2lmaWMgZmllbGRzKSB0byBhIHNlcGFyYXRlIHN0cnVj
dDoNCj4gDQo+IHN0cnVjdCBzcGlfbm9yX2NvbnRyb2xsZXJfb3BzIHsNCj4gCWludCAoKnByZXBh
cmUpKHN0cnVjdCBzcGlfbm9yICpub3IsIGVudW0gc3BpX25vcl9vcHMgb3BzKTsNCj4gCXZvaWQg
KCp1bnByZXBhcmUpKHN0cnVjdCBzcGlfbm9yICpub3IsIGVudW0gc3BpX25vcl9vcHMgb3BzKTsN
Cj4gCWludCAoKnJlYWRfcmVnKShzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCBvcGNvZGUsIHU4ICpi
dWYsIGludCBsZW4pOw0KPiAJaW50ICgqd3JpdGVfcmVnKShzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1
OCBvcGNvZGUsIHU4ICpidWYsIGludCBsZW4pOw0KPiAJc3NpemVfdCAoKnJlYWQpKHN0cnVjdCBz
cGlfbm9yICpub3IsIGxvZmZfdCBmcm9tLA0KPiAJCQlzaXplX3QgbGVuLCB1X2NoYXIgKnJlYWRf
YnVmKTsNCj4gCXNzaXplX3QgKCp3cml0ZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IHRv
LA0KPiAJCQlzaXplX3QgbGVuLCBjb25zdCB1X2NoYXIgKndyaXRlX2J1Zik7DQo+IAlpbnQgKCpl
cmFzZSkoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mZnMpOw0KPiB9Ow0KPiANCj4gc3Ry
dWN0IHNwaV9ub3Igew0KPiAuLi4NCj4gCWNvbnN0IHN0cnVjdCBzcGlfbm9yX2NvbnRyb2xsZXJf
b3BzICpjb250cm9sbGVyX29wczsNCj4gLi4uDQo+IH07DQoNClllcCwgdGhpcyBpcyBhIGdvb2Qg
aWRlYS4gSSdsbCBtYWtlIGEgcGF0Y2ggYW5kIGFkZCB5b3VyIFN1Z2dlc3RlZC1ieSB0YWcuDQoN
ClRoYW5rcyENCg0KPiANCj4+DQo+PiBUZXN0ZWQgdW5pZm9ybSBhbmQgbm9uLXVuaWZvcm0gZXJh
c2Ugb24gc3N0MjZ2ZjA2NGIgZmxhc2ggdXNpbmcgdGhlDQo+PiBhdG1lbC1xdWFkc3BpIGRyaXZl
ci4NCj4+DQo+PiBJbiBvcmRlciB0byB0ZXN0IHRoaXMsIHlvdSdsbCBoYXZlIHRvIG1lcmdlIHY1
LjMtcmM1IGluIHNwaS1ub3IvbmV4dC4NCj4+IFRoaXMgcGF0Y2ggZGVwZW5kcyBvbg0KPj4gJ2Nv
bW1pdCA4MzRkZTVjMWFhNzYgKCJtdGQ6IHNwaS1ub3I6IEZpeCB0aGUgZGlzYWJsaW5nIG9mIHdy
aXRlIHByb3RlY3Rpb24gYXQgaW5pdCIpDQo+Pg0KPj4gVHVkb3IgQW1iYXJ1cyAoNSk6DQo+PiAg
IG10ZDogc3BpLW5vcjogUmVncm91cCBmbGFzaCBwYXJhbWV0ZXIgYW5kIHNldHRpbmdzDQo+PiAg
IG10ZDogc3BpLW5vcjogVXNlIG5vci0+cGFyYW1zDQo+PiAgIG10ZDogc3BpLW5vcjogRHJvcCBx
dWFkX2VuYWJsZSgpIGZyb20gJ3N0cnVjdCBzcGktbm9yJw0KPj4gICBtdGQ6IHNwaS1ub3I6IE1v
dmUgY2xlYXJfc3JfYnAoKSB0byAnc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyJw0KPj4g
ICBtdGQ6IHNwaS1ub3I6IE1vdmUgZXJhc2VfbWFwIHRvICdzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9w
YXJhbWV0ZXInDQo+Pg0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMjM2ICsr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIGluY2x1ZGUvbGludXgv
bXRkL3NwaS1ub3IuaCAgIHwgMjU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMjY5IGluc2VydGlvbnMoKyksIDIyMSBkZWxl
dGlvbnMoLSkNCj4+DQo+IA0KPiANCj4gDQo=
