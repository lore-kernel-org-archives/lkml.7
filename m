Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8715C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85608206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jGtivY4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:25:44 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6933 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAFJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:25:44 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rzlpXnb4R/Y5PrZmMefld8E2qociqRlrBzMNWznJSDb0pjgKZwK8iSE+GSmj8cMuZwYDvmJEsK
 XDS9QhiI9VVV9HPmncQJh3RSUzg/CcfY08456xPkneejAS7gHYLyoBNEBnhBbH53m1Uf19M7T3
 U99P8CsPFDapK/7fcmxEfzJ8PSgTHBX0taQjdEhDiSyB4XQJpDfMXcPt4pdWDFP6cHg3lwxKKw
 LI/covz2/5p98sWpp8xnNmQB4wDQZQG1I7YBeVO7zhMzVj5uGJ+uwSuvSX4gSoaAFwdV41Zbvg
 XOc=
X-IronPort-AV: E=Sophos;i="5.69,402,1571727600"; 
   d="scan'208";a="62299730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jan 2020 02:25:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 02:25:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jan 2020 02:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEmIibhvltiP9C/80oHSQcc+Kxy/S2Nv8fZweefhFfBhbvsHfJta+RDd4D24TXzyfiGVLXojjiXzMEhrA2TQ3DE2zZLFpnbTOjAEgu9YuNLWpJPgeiqAgTpBGUcCicvpBFBhe0ik+Ln+ktIQ3FXxxdbEp6hzd1vic0fPXLTuc2NPGzb5N9/9w+xTZwy5VM1nI5jciSPKiOBTjB8n5h+/p4zRflSx6U2VyZ8xjGAHJF7PkvP/m6d6/KNY3LDUZILCPh6i+bXNasKiUQlo+u0TCHTRmTqaKg4afnNM6DIMfTMbYFYfQzbSx4gFeKxdMSDpqo2B1KqOWcy63sNmiN4SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=941kcKZhBhh+TxPpX85cVntgP0aJ0WJ8gW+fsaOfafE=;
 b=JEXkhZcWelmfqE3Wuf9z8g3T4WXAKoRctLoAbTeUZeAnYu4J1aAEg5kB0NzAN1qfrQR7/r9+Z/xEgIAPMbw21zv0mkjg/cqFfYPAMlTRkZpR9/SnZs2BRvqbyS6Nk2nw/OxRPIlP+Re6wplGjU3MpKnpJ5O55iSOhOS2HSk92AWhbgdFkBETvyKSe2Ce8dm/x/zkri3Yxqo4PiVWKHUQwFPUxuTgz9hRePXevP+wvOM5vj4czvYji9fe6Yi+6M7Dj2h6+Me3oP4pvGUTvvGE7gfQOMc2DPOydz8xYMSYa4Y9XBpT0yjG1/HaX9F70gBkSwue13t8u61vaArSi0XUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=941kcKZhBhh+TxPpX85cVntgP0aJ0WJ8gW+fsaOfafE=;
 b=jGtivY4pW4yhp8LX2PmB5Kqm7Y75PNkGUR+iAAXs/gc5ijz9CUn4ak5OgvdhlybNjj1F/UFjz6Y2Mb7Arqd0Jhs+QjEJz4iWKv+3vbowvGAOrAVEfuwjXPeXA5NgrEJHvPHBoLKvRRMo2NufkYlq2ughScgQ/o1NSW51idReiHc=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB4267.namprd11.prod.outlook.com (52.132.248.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Mon, 6 Jan 2020 09:25:40 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 09:25:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sam@ravnborg.org>
CC:     <alexandre.belloni@bootlin.com>, <airlied@linux.ie>,
        <Nicolas.Ferre@microchip.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <boris.brezillon@bootlin.com>,
        <lee.jones@linaro.org>, <peda@axentia.se>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Topic: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Index: AQHVxHNCEp4Pw+8WakiQvTSsv/2xSA==
Date:   Mon, 6 Jan 2020 09:25:40 +0000
Message-ID: <4f8603b2-9ae6-97bf-73c0-1b204595dce1@microchip.com>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-6-git-send-email-claudiu.beznea@microchip.com>
 <20200102090848.GC29446@ravnborg.org> <20200104171205.GA8724@ravnborg.org>
In-Reply-To: <20200104171205.GA8724@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55449d4f-541d-4aff-3c1e-08d7928a65e0
x-ms-traffictypediagnostic: DM6PR11MB4267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4267CAF002B54096E337E269873C0@DM6PR11MB4267.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(966005)(6486002)(478600001)(31686004)(86362001)(6512007)(71200400001)(5660300002)(53546011)(6506007)(26005)(6916009)(2616005)(4326008)(76116006)(91956017)(36756003)(8936002)(316002)(66946007)(31696002)(66556008)(186003)(64756008)(2906002)(66476007)(81166006)(81156014)(8676002)(54906003)(66446008)(341764005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4267;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mg9wAwehj9k4lQ3q5Sa2hi30BY4zjMTg+FV8pnYYvkAXPypOeaN0bhZ/CxgF4p4PCgbSzuu3rz91Yjliu9dEviryWohOkZcn90S8Jjg26qs47Igjte37PywNBi02soxNKy00/j/8+yWlv7NDDkpKksaug7UyeBBPkgutrw9a63E+WdDIdX5GTrWPWhrvSNbOxnZxDSV4y9V8kQ04mg3gMnBSiPDjKYE8W5HKlPtiIzeu4DkwaBV1VynzfNv53gIHRQOQSPpw+oWr8dn0f6jnMC/KUSgdp7lBZP5ffObLalWtrqiE/rztaHDr+QznH9x1LH3DayP+SS+oV2NJ9MVlWE2ciQ06ZPI5U5HCY3ZVMsGyOYVcLUo8ElodXr+Q3lSBiMhNjxKApCHg/VnL/dSZoXh+sunLqsnjBhJpVw8w6QEWqTzynkFUiIZkGOasKt8bg2HdarofW59JTkb+1QUuFI8oz5C/YFXQ30MPG4jgb9JZO261K9fNpvxPvDNmkPPncr1Yf4T5fh3fhYqt47qnOfaaDW/NMb02AEpGxNt7/v0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5650812FEB10074894AA48B03B41578D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 55449d4f-541d-4aff-3c1e-08d7928a65e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 09:25:40.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3/RLpCCjpLGvIlmxC7sF6/A9f/zx5qircgyWlLzyYPHZrvDT7FS4WJVYRvy9orpWaoM0sf33f3NiZ3MMWekmmD49QB+uqbxhh2axsR6O7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA0LjAxLjIwMjAgMTk6MTIsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDbGF1ZGl1DQo+IA0KPiBPbiBUaHUs
IEphbiAwMiwgMjAyMCBhdCAxMDowODo0OEFNICswMTAwLCBTYW0gUmF2bmJvcmcgd3JvdGU6DQo+
PiBPbiBXZWQsIERlYyAxOCwgMjAxOSBhdCAwMjoyODoyOFBNICswMjAwLCBDbGF1ZGl1IEJlem5l
YSB3cm90ZToNCj4+PiBGcm9tOiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4+DQo+
Pj4gVGhlIGludGVudGlvbiB3YXMgdG8gb25seSBzZWxlY3QgYSBoaWdoZXIgcGl4ZWwtY2xvY2sg
cmF0ZSB0aGFuIHRoZQ0KPj4+IHJlcXVlc3RlZCwgaWYgYSBzbGlnaHQgb3ZlcmNsb2NraW5nIHdv
dWxkIHJlc3VsdCBpbiBhIHJhdGUgc2lnbmlmaWNhbnRseQ0KPj4+IGNsb3NlciB0byB0aGUgcmVx
dWVzdGVkIHJhdGUgdGhhbiBpZiB0aGUgY29uc2VydmF0aXZlIGxvd2VyIHBpeGVsLWNsb2NrDQo+
Pj4gcmF0ZSBpcyBzZWxlY3RlZC4gVGhlIGZpeGVkIHBhdGNoIGhhcyB0aGUgbG9naWMgdGhlIG90
aGVyIHdheSBhcm91bmQgYW5kDQo+Pj4gYWN0dWFsbHkgcHJlZmVycyB0aGUgaGlnaGVyIGZyZXF1
ZW5jeS4gRml4IHRoYXQuDQo+Pj4NCj4+PiBGaXhlczogZjZmN2FkMzIzNDYxICgiZHJtL2F0bWVs
LWhsY2RjOiBhbGxvdyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwtY2xvY2sgdGhhbiByZXF1ZXN0
ZWQiKQ0KPj4gVGhlIGlkIGlzIHdyb25nIGhlcmUgLSB0aGUgcmlnaHQgb25lIGlzOiA5OTQ2YTNh
OWRiZWRhYWFjZWY4YjdlOTRmNmFjMTQ0ZjFkYWFmMWRlDQo+PiBUaGUgd3JvbmcgaWQgYWJvdmUg
d2FzIHVzZWQgYmVmb3JlIC0gc28gSSB0aGluayBpdCBpcyBhIGNvcHknbidwYXN0ZQ0KPj4gdGhp
bmcuDQo+Pg0KPj4gSGludDogdHJ5ICJkaW0gZml4ZXMgOTk0NmEzYTlkYmVkYWFhY2VmOGI3ZTk0
ZjZhYzE0NGYxZGFhZjFkZSINCj4+DQo+PiBJZiBJIGdldCBhIHF1aWNrIHJlc3BvbnNlIGZyb20g
TGVlIEkgY2FuIGZpeCBpdCB1cCB3aGlsZSBhcHBseWluZy4NCj4+DQo+PiAgICAgICBTYW0NCj4+
DQo+Pj4gUmVwb3J0ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KPj4+IFRlc3RlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRp
YS5zZT4NCj4gDQo+IE9uZSBvdGhlciBkZXRhaWwuDQo+IFRoZSBwYXRjaCBoYXMgcGFzc2VkIHRo
cm91Z2ggeW91ciBoYW5kcywgc28geW91IGhhdmUgdG8gYWRkIHlvdXIgcy1vLWINCj4gdG8gZG9j
dW1lbnQgdGhpcy4NCj4gVGhlIGNoYWluIG9mIHMtby1iIHNoYWxsIGRvY3VtZW50IHRoZSBwYXRo
IHRoZSBwYXRjaCBoYXMgdGFrZW4gdG93YXJkcw0KPiB0aGUga2VybmVsLg0KPiANCj4gSW4gdGhp
cyBjYXNlOg0KPiBQZXRlciA9PiBDbGF1ZGl1ID0+IFNhbSA9PiBBcHBsaWVkLg0KPiANCj4gUGxl
YXNlIHJlc2VuZCBvciByZXBseSB3aGVyZSB5b3Ugc2F5IE9LIHRoYXQgSSBhZGQgeW91ciBzLW8t
Yi4NCg0KU3VyZSEgUGxlYXNlIGFkZCBteSBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmsgeW91LCBTYW0hDQoNCj4gDQo+
IFBTLiBBbmQgaGFwcHkgbmV3IHllYXIhDQo+IA0KPiAgICAgICAgIFNhbQ0KPiANCj4gDQo+Pj4g
LS0tDQo+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMg
fCA0ICsrLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMv
YXRtZWxfaGxjZGNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hs
Y2RjX2NydGMuYw0KPj4+IGluZGV4IDcyMWZhODhiZjcxZC4uMTA5ODUxMzRjZTBiIDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMN
Cj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5j
DQo+Pj4gQEAgLTEyMSw4ICsxMjEsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNkY19jcnRjX21v
ZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KPj4+ICAgICAgICAgICAgIGludCBkaXZf
bG93ID0gcHJhdGUgLyBtb2RlX3JhdGU7DQo+Pj4NCj4+PiAgICAgICAgICAgICBpZiAoZGl2X2xv
dyA+PSAyICYmDQo+Pj4gLSAgICAgICAgICAgICAgICgocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9y
YXRlKSA8DQo+Pj4gLSAgICAgICAgICAgICAgICAxMCAqIChtb2RlX3JhdGUgLSBwcmF0ZSAvIGRp
dikpKQ0KPj4+ICsgICAgICAgICAgICAgICAoMTAgKiAocHJhdGUgLyBkaXZfbG93IC0gbW9kZV9y
YXRlKSA8DQo+Pj4gKyAgICAgICAgICAgICAgICAobW9kZV9yYXRlIC0gcHJhdGUgLyBkaXYpKSkN
Cj4+PiAgICAgICAgICAgICAgICAgICAgIC8qDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgKiBB
dCBsZWFzdCAxMCB0aW1lcyBiZXR0ZXIgd2hlbiB1c2luZyBhIGhpZ2hlcg0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgICogZnJlcXVlbmN5IHRoYW4gcmVxdWVzdGVkLCBpbnN0ZWFkIG9mIGEgbG93
ZXIuDQo+Pj4gLS0NCj4+PiAyLjcuNA0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4+IGRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsDQo+IA==
