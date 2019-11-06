Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B30C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609722173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MDEll9dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfKFId4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:33:56 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37502 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfKFId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:33:56 -0500
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
IronPort-SDR: OiXgMlX7YufWkTbhRTaKywoWJvYT1csv0K+ATz6h3HlhtBZSpqLFkiOhEA9gEdlB1PxrMlf7ow
 7Jh4NI4XYZHByHfTgUVKFgc7VPAD+5/nr/wYugz8YnlBXLmfT6blN0iBsE4YOE4ueXeqJNByJz
 2QiWCL5l6fU2twSAWrkkvsTD5bQ2UkdM3jIMwL11TaLCsvZw9QPcctGWWFx1VaMtA9OWnIgTzX
 EHaxAaTXlQAFwLciPpk6ZPAtJNRcYo1tOsd1GlX0CHpubDhfI4kGd2CmRg3RH0sC6790CdxFKI
 qy4=
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="55495022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2019 01:33:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 01:33:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 6 Nov 2019 01:33:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMoI8I/cSSe/aT+HqAPjngFXAOekhW8FxveQCClnDjjEwoG17b97Q+CuY1k7CRWauWkExjlM3CUoM2WTN+lkmVubV4MHpBwkymBSCPvr0tfmzz4+X3rS/JnyREWxUH48PKikV/L6Qn8hu9AYUwMVBn3U9/xpxyHEmn3yPlQWPFh77g8UXbtpdPITrEn8VmhEEtvwBSylqbUpXWFqVgOOQGG8LVFUVJwIMqf8tmiuIZhoE0RZB/Se7BzEvTWDCENBB7rYApKsXA0a3EM07UI3hc5SAby9Cmosvz8ESFPijKtfqfq7o3F3w+cbXfCPMgqNy3+9A0vSsIn4Taa4e5Yulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIF9Ne94AxEoD+tNXW/YYqWjt4VWxqJz8KTlw5HzWQM=;
 b=ePC5d4BT2VrgGc8qX7GFac7B9cm0pu47gr3MINVOh5Y2x3NMUpAH6ZZ4qN3BNrSE3dWAg6Y848T4e5p4L4ZK48pV3pqTSiLRfCnN8vH/S0wTjvg4C5NdC8n7lJ3qvc162FurAjtialCoaKsQgTg/4MmZ8M/rZXcYBeNNuAtzamGJ7e717J3tZ4UDEXan7kzklWY2Fcbki0hzxLdwPFJFZ5rmI02DnVOoJdGL72OolzZMAb+uTRxAKcoi5qwQk/U9dBdkGZ3A1ntJlz436fnWVPl6hi4jPk38zgqfmmYQ5c05tmnqwrkb1k8tIUCozzKgfXQHlpHxwgcX19+DjbN1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIF9Ne94AxEoD+tNXW/YYqWjt4VWxqJz8KTlw5HzWQM=;
 b=MDEll9dwhXs/Jiwl3jFspybUivVJKMTiEwFJ9JRP/SzC21WPtyUeEbB72oYhaUSfEIXCSDTdLZ+jeRM+5SenJ+pw10zla6Qg+Ul57CWM/wR35OBkiuUclKt6C/h9CCpWfjcZWEWCwLn3vzVL6U1J+HEhA56YJ/B8cXU1DROSFko=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 08:33:53 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 08:33:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 13/20] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Topic: [PATCH v4 13/20] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Index: AQHVkW/+ecEbRc4nfkO7skTHWA7uQqd81AsAgAEC2gA=
Date:   Wed, 6 Nov 2019 08:33:52 +0000
Message-ID: <af6fa950-495f-9e49-bcfe-09188e454b6d@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-14-tudor.ambarus@microchip.com>
 <14e9c474-1a92-b8be-12cf-56c7f6d0d696@ti.com>
In-Reply-To: <14e9c474-1a92-b8be-12cf-56c7f6d0d696@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0167.eurprd09.prod.outlook.com
 (2603:10a6:800:120::21) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ce2c41b-bb1f-48c0-538f-08d762940e08
x-ms-traffictypediagnostic: MN2PR11MB4063:
x-microsoft-antispam-prvs: <MN2PR11MB40636849779AE2A3DFCFD9C6F0790@MN2PR11MB4063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(6512007)(7736002)(2906002)(4326008)(26005)(66066001)(53546011)(6436002)(36756003)(11346002)(476003)(6506007)(8676002)(386003)(81156014)(76176011)(52116002)(81166006)(186003)(66946007)(8936002)(66476007)(66556008)(102836004)(6486002)(229853002)(31696002)(316002)(86362001)(110136005)(54906003)(3846002)(6116002)(305945005)(2501003)(31686004)(64756008)(486006)(66446008)(99286004)(14454004)(14444005)(71190400001)(71200400001)(5660300002)(256004)(25786009)(6246003)(478600001)(2616005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4063;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRRqQharBTXXXtd9PlsM1J/OX9f0ZUe8NPt2stcRgD1Hb0ablJ5qdX+mzG3cDbKWey0yApRRp0LUYuvm7zbQzzS3ZAD7VUvMa8s39T+RUaL4dxWYCEj6uxczv2KQ/xqBJI3aq92xVl1ZyQX1MCEZPrx7yFo47iemJV3rqD7aYErmGkA7pENfdSriq+s32UWfd+mVspLMFO8MzqZNBmCQQx0yUqT0JuAVmun17P2JkHXpTPIsU2otIl8kieoB3Cgz6hkWvsYp69o/pE9nwylsrl9R2FXgIsNuq5ONl5YvsVxxIJqGGQqQMugOd0UCEWOI5J2ruplwfDzCOtO60eK7GUSsXaw85+z9cVrI+VG7whU84hCvhwy5xKUy62rY1WqYk4lPxT1eEybDY4OXXZFRXr+rF0EbZTwSo/dNNJLS3Ji2TlzGqKXTl6vE6f6Wxz89
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <83047FBCF1568C4ABD2AFE824BF8CFCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce2c41b-bb1f-48c0-538f-08d762940e08
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:33:52.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3w/DOWlinz7t9fzDhDG4OWXpIM4igYmNxr+7U1mBLFrSxvk9Y6qVlnvIjg2BDqu87zVo1rgidQJZNVIBfwPnoGhL7lgGfkJ3a66djKpt5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA1LzIwMTkgMDc6MDcgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IE9uIDAyLU5vdi0xOSA0OjUzIFBNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6
DQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+
Pg0KPj4gTWFrZSBzdXJlIHRoYXQgd2hlbiBkb2luZyBhIGxvY2soKSBvciBhbiB1bmxvY2soKSBv
cGVyYXRpb24gd2UgZG9uJ3QgY2xlYXINCj4+IHRoZSBRRSBiaXQgZnJvbSBTdGF0dXMgUmVnaXN0
ZXIgMi4NCj4+DQo+PiBKRVNEMjE2IHJldkIgb3IgbGF0ZXIgb2ZmZXJzIGluZm9ybWF0aW9uIGFi
b3V0IHRoZSAqZGVmYXVsdCogU3RhdHVzDQo+PiBSZWdpc3RlciBjb21tYW5kcyB0byB1c2UgKHNl
ZSBCRlBUIERXT1JEU1sxNV0sIGJpdHMgMjI6MjApLiBJbiB0aGlzDQo+PiBzdGFuZGFyZCwgU3Rh
dHVzIFJlZ2lzdGVyIDEgcmVmZXJzIHRvIHRoZSBmaXJzdCBkYXRhIGJ5dGUgdHJhbnNmZXJyZWQg
b24gYQ0KPj4gUmVhZCBTdGF0dXMgKDA1aCkgb3IgV3JpdGUgU3RhdHVzICgwMWgpIGNvbW1hbmQu
IFN0YXR1cyByZWdpc3RlciAyIHJlZmVycw0KPj4gdG8gdGhlIGJ5dGUgcmVhZCB1c2luZyBpbnN0
cnVjdGlvbiAzNWguIFN0YXR1cyByZWdpc3RlciAyIGlzIHRoZSBzZWNvbmQNCj4+IGJ5dGUgdHJh
bnNmZXJyZWQgaW4gYSBXcml0ZSBTdGF0dXMgKDAxaCkgY29tbWFuZC4NCj4+DQo+PiBJbmR1c3Ry
eSBuYW1pbmcgYW5kIGRlZmluaXRpb25zIG9mIHRoZXNlIFN0YXR1cyBSZWdpc3RlcnMgbWF5IGRp
ZmZlci4NCj4+IFRoZSBkZWZpbml0aW9ucyBhcmUgZGVzY3JpYmVkIGluIEpFU0QyMTZCLCBCRlBU
IERXT1JEU1sxNV0sIGJpdHMgMjI6MjAuDQo+PiBUaGVyZSBhcmUgY2FzZXMgaW4gd2hpY2ggd3Jp
dGluZyBvbmx5IG9uZSBieXRlIHRvIHRoZSBTdGF0dXMgUmVnaXN0ZXIgMQ0KPj4gaGFzIHRoZSBz
aWRlLWVmZmVjdCBvZiBjbGVhcmluZyBTdGF0dXMgUmVnaXN0ZXIgMiBhbmQgaW1wbGljaXRseSB0
aGUgUXVhZA0KPj4gRW5hYmxlIGJpdC4gVGhpcyBzaWRlLWVmZmVjdCBpcyBoaXQganVzdCBieSB0
aGUNCj4+IEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDFfQlVHR1kgYW5kIEJGUFRfRFdPUkQxNV9R
RVJfU1IyX0JJVDEgY2FzZXMuDQo+Pg0KPiBCdXQgSSBzZWUgdGhhdCAxIGJ5dGUgU1IxIHdyaXRl
IHN0aWxsIGhhcHBlbnMgYXMgcGFydCBvZg0KPiBzcGlfbm9yX2NsZWFyX3NyX2JwKCkgdW50aWwg
cGF0Y2ggMjAvMjAuIFNvIGlzIHRoaXMgb25seSBhIHBhcnRpYWwgZml4Pw0KDQpGaXhpbmcgc3Bp
X25vcl9jbGVhcl9zcl9icCgpIHdvdWxkIG1lYW4gdG8gYWRkIGRlYWQgY29kZSB0aGF0IHdpbGwg
YmUgcmVtb3ZlZA0KYW55d2F5IHdpdGggcGF0Y2ggMjAvMjAuIFRoaXMgcGF0Y2ggZml4ZXMgdGhl
IGNsZWFyaW5nIG9mIHRoZSBRRSBiaXQsIHdoaWxlIGluDQoyMC8yMCB0aGUgUUUgYml0IGlzIGFs
cmVhZHkgemVybyB3aGVuIHRoZSBvbmUgYnl0ZSBTUjEgd3JpdGUgaXMgdXNlZCwgc28gdGhlDQpx
dWFkIG1vZGUgaXMgbm90IGFmZmVjdGVkLiAyMC8yMCBmaXhlcyBpbmRpcmVjdGx5IHRoZSBjbGVh
cmluZyBvZiBhbGwgdGhlIGJpdHMNCmZyb20gU1IyIGJ1dCBRRSBiaXQsIGJlY2F1c2UgaXQncyBh
bHJlYWR5IHplcm8uIEkgd291bGQgc2F5IGl0J3Mgbm90IGEgcGFydGlhbA0KZml4LCBidXQgYSBk
aWZmZXJlbnQgYnVnLg0KDQpUaGVyZSBhcmUgZGlmZmVyZW50IGFuZ2xlcyB0byBsb29rIGF0IHRo
aXMsIEkgY2hvc2UgdGhlIG1vZGlmeWluZyBvZiB0aGUgcXVhZA0KbW9kZSBhbmdsZS4gR2l2ZW4g
dGhlIHR3byBhcmd1bWVudHMgZnJvbSBhYm92ZSAoYXZvaWQgYWRkaW5nIGRlYWQgY29kZSBhbmQN
CmNoYW5naW5nIG9mIHF1YWQgbW9kZSBhcHByb2FjaCksIEkgd291bGQgcHJlZmVyIHRvIGtlZXAg
dGhpbmdzIGFzIHRoZXkgYXJlLiBCdXQNCkkgZ2V0IHlvdXIgYXBwcm9hY2ggdG9vLCBzbyBpZiB5
b3Ugc3RpbGwgd2FudCB5b3VycywgSSBjYW4gZG8gaXQuIFBsZWFzZSBsZXQgbWUNCmtub3cuDQoN
Cj4gU2hvdWxkIHRoaXMgcGF0Y2ggYmUgcmVhcnJhbmdlZCB0byBhcHBlYXIgYWxvbmcgd2l0aCAy
MC8yMD8NCg0KTm90IG5lY2Vzc2FyaWx5IChkaWZmZXJlbnQgYnVncykgYnV0IEkgY2FuIGJyaW5n
IDIwLzIwIGltbWVkaWF0ZWx5IGFmdGVyIHRoaXMNCm9uZSBpZiB5b3Ugd2FudC4NCg0KPiANCj4g
DQo+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxh
Ym9yYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3Iu
YyB8IDEyMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICBp
bmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggICB8ICAgMyArKw0KPj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTE4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGkt
bm9yLmMNCj4+IGluZGV4IDcyNWRhYjI0MTI3MS4uZjk2YmM4MGMwZWQxIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3BpLW5vci5jDQo+PiBAQCAtOTU5LDEyICs5NTksMTkgQEAgc3RhdGljIGludCBzcGlf
bm9yX3dyaXRlX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IHU4ICpzciwgc2l6ZV90IGxl
bikNCj4+ICAJcmV0dXJuIHNwaV9ub3Jfd2FpdF90aWxsX3JlYWR5KG5vcik7DQo+PiAgfQ0KPj4g
IA0KPiBbLi4uXQ0KPj4gKy8qKg0KPj4gICAqIHNwaV9ub3Jfd3JpdGVfc3IyKCkgLSBXcml0ZSB0
aGUgU3RhdHVzIFJlZ2lzdGVyIDIgdXNpbmcgdGhlDQo+PiAgICogU1BJTk9SX09QX1dSU1IyICgz
ZWgpIGNvbW1hbmQuDQo+PiAgICogQG5vcjoJcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InLg0K
Pj4gQEAgLTM2MzQsMTkgKzM3MjMsMzggQEAgc3RhdGljIGludCBzcGlfbm9yX3BhcnNlX2JmcHQo
c3RydWN0IHNwaV9ub3IgKm5vciwNCj4+ICAJCWJyZWFrOw0KPj4gIA0KPj4gIAljYXNlIEJGUFRf
RFdPUkQxNV9RRVJfU1IyX0JJVDFfQlVHR1k6DQo+PiArCQkvKg0KPj4gKwkJICogV3JpdGluZyBv
bmx5IG9uZSBieXRlIHRvIHRoZSBTdGF0dXMgUmVnaXN0ZXIgaGFzIHRoZQ0KPj4gKwkJICogc2lk
ZS1lZmZlY3Qgb2YgY2xlYXJpbmcgU3RhdHVzIFJlZ2lzdGVyIDIuDQo+PiArCQkgKi8NCj4+ICAJ
Y2FzZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX05PX1JEOg0KPj4gKwkJLyoNCj4+ICsJCSAq
IFJlYWQgQ29uZmlndXJhdGlvbiBSZWdpc3RlciAoMzVoKSBpbnN0cnVjdGlvbiBpcyBub3QNCj4+
ICsJCSAqIHN1cHBvcnRlZC4NCj4+ICsJCSAqLw0KPj4gKwkJbm9yLT5mbGFncyB8PSBTTk9SX0Zf
SEFTXzE2QklUX1NSIHwgU05PUl9GX05PX1JFQURfQ1I7DQo+IFNpbmNlIFNOT1JfRl9IQVNfMTZC
SVRfU1IgaXMgc2V0IGJ5IGRlZmF1bHQgaW4NCj4gc3BpX25vcl9pbmZvX2luaXRfcGFyYW1zKCks
IG5vIG5lZWQgdG8gc2V0IHRoZSBmbGFnIGhlcmUgYWdhaW4NCj4gDQoNCkkgZGlkIHRoaXMgb24g
cHVycG9zZS4gSSBzZXQgU05PUl9GX0hBU18xNkJJVF9TUiBoZXJlIGJhc2VkIG9uIFNGRFAgc3Rh
bmRhcmQsIEkNCndhbnQgdG8gaW5kaWNhdGUgd2hlcmUgdGhlIHN0YW5kYXJkIHJlcXVpcmVzIHRo
ZSAxNiBiaXQgU1Igd3JpdGUgLg0Kc3BpX25vcl9pbmZvX2luaXRfcGFyYW1zKCkgaW5pdGlhbGl6
ZXMgZGF0YSBiYXNlZCBvbiBpbmZvLCBidXQgdGhhdCBkYXRhIGNhbiBiZQ0Kb3ZlcndyaXR0ZW4g
KGV2ZW4gd2l0aCB0aGUgc2FtZSBkYXRhKSB3aGVuIHBhcnNpbmcgU0ZEUC4NCg0KVGhhbmtzLA0K
dGENCg==
