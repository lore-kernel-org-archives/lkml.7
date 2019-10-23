Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC37CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1644C2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dAnP4hD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392744AbfJWXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:39:35 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:50180 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbfJWXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:39:35 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: jtrQPELkTf96hdPQFwQLLKv1VTH6hHSOmkYmgMdhioBFCtleChGC7Mr1K2U26WVkkW1mvgSohl
 m2x7AiZvv43+pCn/viZpvd+kbdtNZlI3T7zc1OFs4Ukno3o0mOogoon1nT7+K0PdpuUaqPjC6Q
 K4YGB9Fk2Br7eu4ew2jcehoIFqSWQ/+3fyrNpPslsrg1b2RPqpO8udiqLNyfF/mLtsyp9VnUOc
 EUGR9qpNhzpbKdSSCAp2jaJDUB8ktgxtHF6zCa4sO6j6MCIOevSa9HKk9p5qq16iVawWUcBCPY
 hpA=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="52734423"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 16:39:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 16:39:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 16:39:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShH+UuYM/KjZFDbapbMUZKA2mSHNblMXwfLFlUMcbiJRoheyYlqvnjIm5fuN+0/Z+yNcLB0Y4CsJRokd5U0bCpcteRcDWfQ1y4TdLLk45wWHsH5sSdgUVeb/qWcEpQDGh3Rx1G1JKEChnsmmLyaXElUlyhfQfhX4q/f4SQpFREWWrauQ33hK+nFIpNKQ/BQenZeNMN3Vk8MNTKnmOZKMzbodshJ0qDovDg/L50Sn4h4pwISowZ2VNTd+Xso4I2uc4DP98yuzyzAomrWn0cQUGNVyuErRlJ9V6soLbFiuk+aYA4CE7aygR79/maCuVSMqIbA1bXWS9WPEFpQhlExSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdmjXG7420KWh8/jN2HQjnhf2Q2MrKeJCkhOu4lVcFs=;
 b=n7009cbBfR3UBMiuxSqgvgOkY8nIHRq3rqsed9eGmXJbVXGcI0hoxU1SjCgVbdE+w4JfejQte/bkIO9FxxNwIwSyMFD7qogepJi58kgQbFWIWawBYEOpPN5MLHq7wGM6kDqaEWzCyRWDMQNVFzOXx8xvrf9H8l23kOKxOOkkCttq5avcDO1Pr2OFB37y+nbdNAWICHnk8KNgPABjiKIljhWSQ4sbQ0+cZ6R2YJ3sp24InnlE4Yf4k9VdYmMrgzPqP59K0SZYPuX6++DIiuYWRZtdLM5+1fNFonGBWKDRqn2zOWqrlLZLWt/6woLfACDi14Aejft6FV8JU7XY9lSLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdmjXG7420KWh8/jN2HQjnhf2Q2MrKeJCkhOu4lVcFs=;
 b=dAnP4hD29ZS6e+D/es3FgFoWbFkS08H6El/QGvMp17npYACmdPs7//Ih/qZu0R/grdONNzBCMnonuHmL75brTtGxV4IroF3AV1FKwHTR+TPCWVJnXOHu/9vPWdvew+w8fVZ+10LxcWUzGQcWWeAxsPN8a58lVYZs8jxitOUHlLs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3885.namprd11.prod.outlook.com (10.255.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 23:39:31 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 23:39:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <geert+renesas@glider.be>, <andrew@aj.id.au>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <marek.vasut@gmail.com>, <jonas@norrbonn.se>,
        <linux-mtd@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Topic: [PATCH v2 08/22] mtd: spi-nor: Rework write_enable/disable()
Thread-Index: AQHVcqwmGxayarzEFkyHj/sWgnNJNqdTkUSAgBV/k4A=
Date:   Wed, 23 Oct 2019 23:39:31 +0000
Message-ID: <34fbb0d7-ee8f-a6d7-4a3e-d64f2f8555ff@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-9-tudor.ambarus@microchip.com>
 <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20191010092117.4c5018a8@dhcp-172-31-174-146.wireless.concordia.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:800:90::31) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db2dfadd-4b5a-4438-19ac-08d75812407d
x-ms-traffictypediagnostic: MN2PR11MB3885:
x-microsoft-antispam-prvs: <MN2PR11MB38855D5FA398C4BCF80AE2F2F06B0@MN2PR11MB3885.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(486006)(476003)(316002)(71190400001)(71200400001)(5660300002)(6246003)(2616005)(11346002)(4326008)(186003)(76176011)(66556008)(53546011)(66066001)(6506007)(64756008)(66946007)(66476007)(52116002)(8936002)(6436002)(66446008)(386003)(3846002)(6116002)(2906002)(229853002)(14454004)(8676002)(6486002)(25786009)(99286004)(256004)(31686004)(7416002)(14444005)(478600001)(81156014)(81166006)(26005)(54906003)(305945005)(6916009)(6512007)(7736002)(86362001)(102836004)(31696002)(446003)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3885;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoF+qe9VXtq5vCez5ZjO0w2sNTfz/0qSw8msjJjS6KE+om8VBLPx0UzhyJVhJObHFHvbrzJQQeEFX+3mpu+pVR4pWn168uAY+rkCDC6qtcfuVO+F/Triufov8g2Y176D0H9AVniF092XlkJmICQeSfyu3KylZ6KgMtnlz8GApEBZPVPC6uLBMHnbvj0W/elDmahoxQkI8y0OFm5UVfdHgv7uYEi04fZSA/09x0BZ++zZGIWIet0cbZ9D+93vGBREAQgN7O1KKJOYfONcblYNlFQ0xQ3NwsUHsyueMOgciH0vCYoGbL/HzjoCTFk1PyVKKuCrME5qZQFM+3/eib6cBw4dwhX2Mgyyx/LQbwyW6ub2ZP976L/Xuuubfs02iVou76/mfs09og5Lp2ZRRaI1pyWTkdC0sh67znm3Yov37DM3C2/6JRa78dFg0Na/dArx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7DCA71C3CF6514FA144E9772E45EACA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db2dfadd-4b5a-4438-19ac-08d75812407d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 23:39:31.2479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcBQ6/P57dwA9YCpIDu0F6D7LeB/T0uBDkH+TDVGNGAHSrU8VO0t6b06anD+MY95WwXh6ebjK/UlifSsXQqd5vxJSLESR0V+E2feusfMsKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzEwLzIwMTkgMTA6MjEgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gVHVlLCAyNCBTZXAgMjAxOSAwNzo0NjoxOCArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gc3RhdGlj
IGludCB3cml0ZV9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+IHN0YXRpYyBpbnQgd3Jp
dGVfZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4gYmVjb21lDQo+PiBzdGF0aWMgaW50
IHNwaV9ub3Jfd3JpdGVfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiBzdGF0aWMgaW50
IHNwaV9ub3Jfd3JpdGVfZGlzYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPj4NCj4+IENoZWNr
IGZvciBlcnJvcnMgYWZ0ZXIgZWFjaCBjYWxsIHRvIHRoZW0uIE1vdmUgdGhlbSB1cCBpbiB0aGUN
Cj4+IGZpbGUgYXMgdGhlIGZpcnN0IFNQSSBOT1IgUmVnaXN0ZXIgT3BlcmF0aW9ucywgdG8gYXZv
aWQgZnVydGhlcg0KPj4gZm9yd2FyZCBkZWNsYXJhdGlvbnMuDQo+IA0KPiBTYW1lIGhlcmUsIHNw
bGl0IHRoYXQgaW4gMyBwYXRjaGVzIHBsZWFzZS4NCg0KOikNCg0KPiANCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDE3NSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIwIGlu
c2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+
PiBpbmRleCAwZmIxMjRiZDJlNzcuLjBhZWUwNjhhNTgzNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYw0KPj4gQEAgLTM4OSw2ICszODksNjQgQEAgc3RhdGljIHNzaXplX3Qgc3BpX25vcl93
cml0ZV9kYXRhKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCB0bywgc2l6ZV90IGxlbiwNCj4+
ICB9DQo+PiAgDQo+PiAgLyoqDQo+PiArICogc3BpX25vcl93cml0ZV9lbmFibGUoKSAtIFNldCB3
cml0ZSBlbmFibGUgbGF0Y2ggd2l0aCBXcml0ZSBFbmFibGUgY29tbWFuZC4NCj4+ICsgKiBAbm9y
OiAgICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InDQo+PiArICoNCj4+ICsgKiBSZXR1
cm46IDAgb24gc3VjY2VzcywgLWVycm5vIG90aGVyd2lzZS4NCj4+ICsgKi8NCj4+ICtzdGF0aWMg
aW50IHNwaV9ub3Jfd3JpdGVfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiArew0KPj4g
KwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlpZiAobm9yLT5zcGltZW0pIHsNCj4+ICsJCXN0cnVjdCBz
cGlfbWVtX29wIG9wID0NCj4+ICsJCQlTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9P
UF9XUkVOLCAxKSwNCj4+ICsJCQkJICAgU1BJX01FTV9PUF9OT19BRERSLA0KPj4gKwkJCQkgICBT
UElfTUVNX09QX05PX0RVTU1ZLA0KPj4gKwkJCQkgICBTUElfTUVNX09QX05PX0RBVEEpOw0KPj4g
Kw0KPj4gKwkJcmV0ID0gc3BpX21lbV9leGVjX29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPj4gKwl9
IGVsc2Ugew0KPj4gKwkJcmV0ID0gbm9yLT5jb250cm9sbGVyX29wcy0+d3JpdGVfcmVnKG5vciwg
U1BJTk9SX09QX1dSRU4sDQo+PiArCQkJCQkJICAgICBOVUxMLCAwKTsNCj4+ICsJfQ0KPj4gKw0K
Pj4gKwlpZiAocmV0KQ0KPj4gKwkJZGV2X2Vycihub3ItPmRldiwgImVycm9yICVkIG9uIFdyaXRl
IEVuYWJsZVxuIiwgcmV0KTsNCj4gDQo+IERvIHdlIHJlYWxseSBuZWVkIHRoZXNlIGVycm9yIG1l
c3NhZ2VzPyBJIG1lYW4sIGlmIHRoZXJlJ3MgYW4gZXJyb3IgaXQNCj4gc2hvdWxkIGJlIHByb3Bh
Z2F0ZWQgdG8gdGhlIHVwcGVyIGxheWVyLCBzbyBtYXliZSB3ZSBzaG91bGQgdXNlDQo+IGRldl9k
YmcoKSBoZXJlLg0KPiANCg0KSSBmaW5kIHRoZW0gdXNlZnVsLiBPbiBlcnJvciBjb25kaXRpb25z
LCBJIHdvdWxkIGxpa2UgdG8gc2VlIHdoYXQgd2VyZSB0aGUNCmRpZmZpY3VsdGllcyB3aGVuIGlu
dGVyYWN0aW5nIHdpdGggdGhlIGhhcmR3YXJlLg0KDQo=
