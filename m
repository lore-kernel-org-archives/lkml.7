Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73775C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4163020873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="X3XPvY/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfEBIeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:34:08 -0400
Received: from mail-eopbgr800059.outbound.protection.outlook.com ([40.107.80.59]:43072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfEBIeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiBYKqmqGR3NyCC5ZhXK8tLVafGOWZvsftCc9bfQvC4=;
 b=X3XPvY/U+6FWs7XKs38r3IIu/LP/H/+eIc69JPzUt8DZiSn5sIuiO0SjSDmD6kI4QGUrTZcbyl68SZw18lmsTCvvcgZHbiJyE7/vwEkpBnv8hJAGd/Yxg7SDN1g4t0suyH/16/mNZ3r8DZVCdpa49mAZjy6FCjQvOlhHKUtAJJI=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5776.namprd08.prod.outlook.com (20.179.86.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 08:34:05 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b45d:52ac:9ad5:9549]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::b45d:52ac:9ad5:9549%4]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 08:34:05 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: RE: [EXT] Re: [PATCH 1/4] mtd: rawnand: Turn the ONFI support to
 generic
Thread-Topic: [EXT] Re: [PATCH 1/4] mtd: rawnand: Turn the ONFI support to
 generic
Thread-Index: AdTjwBGl+eQMQxE9TGefSYYUoa3ZUwbXjRqAAGjIC4A=
Date:   Thu, 2 May 2019 08:34:05 +0000
Message-ID: <MN2PR08MB59519933896248F923FB07E1B8340@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951BDBAC83D3D04B3B122A5B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
 <20190430083059.629e0bf1@xps13>
In-Reply-To: <20190430083059.629e0bf1@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4ab9a10-d6ad-4a49-5ce3-08d6ced8eff7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR08MB5776;
x-ms-traffictypediagnostic: MN2PR08MB5776:|MN2PR08MB5776:
x-microsoft-antispam-prvs: <MN2PR08MB57766D2064ABE79B928239AAB8340@MN2PR08MB5776.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(99286004)(76176011)(5660300002)(486006)(6436002)(81156014)(305945005)(7696005)(6916009)(7736002)(81166006)(33656002)(68736007)(74316002)(8676002)(8936002)(11346002)(25786009)(229853002)(54906003)(316002)(476003)(7416002)(52536014)(66446008)(4326008)(446003)(2906002)(186003)(6246003)(71200400001)(73956011)(64756008)(66556008)(76116006)(66946007)(66476007)(9686003)(55016002)(53936002)(6506007)(55236004)(26005)(14454004)(71190400001)(478600001)(66574012)(66066001)(102836004)(3846002)(6116002)(256004)(86362001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5776;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZorzBzN5QlcVFpkdG+D5MI2E8a1y9njxHabLLektX0QPn1B4r92S+RyefjeG1835L93ThXvPH4EkwwuwFDi5s5NzknO6QSBIn1dqqPa/LU64BgW08PDsELczqhjAZePjcf2kt4BG2ImMxsraZDiHtz2kTSXDRNETznXU7fRWLBwIiZW2J78lcWmWNcNXbpqtF5A/jf9pmvKFDGe8a97zxV72xiIi1yTTzyjtDas52z2NhdATAyTBehP+CsPBAWQBK2XPAOOWL1rjSF2ZWwkCLVfrBy9g1x7CuNnWl+lCKEBCIPBA2ojUiZa+8t27DDKd3ZLYYvXy/6Hc3RmIrXUvUlg1Qswyzeu7Ckwt35spJp7a8xWwxWY3s4xu5GGyDmeCjSmKlWmTwkCGwU8ewm/mBOkBgrzRTsk+biFi1VOhg68=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab9a10-d6ad-4a49-5ce3-08d6ced8eff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:34:05.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IEhpIFNoaXZhbXVydGh5LA0KPiANCj4gU29ycnkgZm9yIHRoZSBsb25n
IGRlbGF5IEkgd2FzIGEgYml0IG92ZXJsb2FkZWQuDQo+IA0KPiAiU2hpdmFtdXJ0aHkgU2hhc3Ry
aSAoc3NoaXZhbXVydGh5KSIgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPiB3cm90ZQ0KPiBvbg0K
PiBUdWUsIDI2IE1hciAyMDE5IDEwOjUxOjQ3ICswMDAwOg0KPiANCj4gPiBGaXggaGVhZGVycyB0
byBtYWtlIHdheSBmb3IgYWRkaW5nIGhlbHBlciBmdW5jdGlvbnMuDQo+ID4NCj4gPiBBZGQgb25m
aSBoZWxwZXIgc3RydWN0dXJlLg0KPiA+DQo+ID4gQWRkIGhlbHBlciBmdW5jdGlvbnMgaW4gcmF3
IE5BTkQgY29yZSwgd2hpY2ggbGF0ZXIgd2lsbCBiZSB1c2VkIGR1cmluZw0KPiA+IE9ORkkgZGV0
ZWN0aW9uLg0KPiA+DQo+IA0KPiBBcyB5b3UgYXJlIHRvdWNoaW5nIHRoZSBjb3JlLCBJIG5lZWQg
dG8gaWRlbnRpZnkgY2xlYXJseSBlYWNoIGNoYW5nZQ0KPiB5b3UgbWFrZTsgdHlwaWNhbGx5IGlu
IHRoaXMgY29tbWl0IHlvdSBkbyBzZXZlcmFsIGRpZmZlcmVudCBjaGFuZ2VzLg0KPiBQbGVhc2Ug
c3BsaXQgdGhpcyBwYXRjaCBpbiBzbWFsbCBtZWFuaW5nZnVsIHBlYWNlcy4NCj4gDQoNCkkgd2ls
bCBzZW5kIHRoZSBuZXcgdmVyc2lvbi4NCg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXZhbXVydGh5
IFNoYXN0cmkgPHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L210ZC9uYW5kL3Jhdy9pbnRlcm5hbHMuaCB8ICAgNiArLQ0KPiA+ICBkcml2ZXJzL210ZC9uYW5k
L3Jhdy9uYW5kX2Jhc2UuYyB8IDIzNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
DQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfb25maS5jIHwgMjE1ICsrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9tdGQvbmFuZC5oICAgICAgICAg
fCAgMzAgKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9yYXduYW5kLmggICAgICB8ICAgNSAr
DQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjg5IGluc2VydGlvbnMoKyksIDIwMyBkZWxldGlvbnMo
LSkNCj4gPg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQoNClRoYW5rcywNClNoaXZhDQo=
