Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9856C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A662184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gOnjispq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKKTb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:31:26 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:12842 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKTb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:31:26 -0500
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
IronPort-SDR: FEfGy5qTihuC4jlkDyUBdR+auqca+2EHWxBPhrfBPDQrILroIdSpBd/tQ+1CblZ2OvCOKPRkVj
 +p4xSxcKLt5ooEFtGEmXQiBfmsvx8kPvZfQbJWB/y9Mpxrl3hzdhAuUxx0ZOWcufj9uqeLw/62
 14uQZJu3afIJW7zGOkiy8ymcLk6qES4ED2QzUb6d1694ZQRKQbhyn0VvvpcdLWM7uHPNPY5bm3
 zyH/fJxVH3XDdp/vga4+6L11d++dDtDic2NtobRKlPXfxigcs47th6NdjJB97qQZ94bJRP/n+w
 jeg=
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="53780624"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2019 12:31:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Nov 2019 12:31:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 12:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atMcqY5HJB2gcBf1duuJt6CXoImVzh0TPlursD0dvKFjOOOKYCWR4AKV7+EqzX9u1xxcwS05/tGbQHwEtIGWvjW2nP9SGXZ3ZZUlmqxedxVgAbsYhtHOehIlShsVDkb848EBhL79xcAy4pxw/z4DBleiR71TZ8QdTVTuVLZWr3Dt+8jshyBKfm1hgVr2e/zkjTabdi7jQzq95jzMrgIkdKxoX0hguGZCERryQmvgZPEmXT95H6EMUsFHGRsn5F2t7p+SrQxcFA9uFu4irztgjxP8Sq5azjBHEwT4103L6YQTlnJsnY4Qp7XGf2rnEXS5045bd/Yu5s3frCDh3YU+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu7A3C6/rkD4IQ4w6cLmt9cxQoMeEbLnJco6IF3W4JM=;
 b=eRlJnjUbIQUhESNCfcPZEeEiCmh/WzJmyOO2tDXcaapneP67PVfPffGZxOsj7y8GAHO+XGDyVTFmrWTXZJ1TUWTTVX1rbNZuB7X8wWL1B5tpIWuN3JvplPaEF8ZjkV7Oi4ab/I/KXUj1wUdfar17QBRuelq50iEzK+/w5mjke1TAmACT5sUqF9YQJLP3y67CylElcpgeShd5V8JvLOcOECgOFC7uEx19LosGd7Kt2oWFFYsg9ptDQAbwAVypvSTmkjJD+8BAVtTJJk5RwjsjVusZ0ccwaYPgCkbsX7Kky6z13v1/q6lSh1/blx8WGC2FTw1tmzKwpEjJXgJt9ZCrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu7A3C6/rkD4IQ4w6cLmt9cxQoMeEbLnJco6IF3W4JM=;
 b=gOnjispq15ZcWRaMt4BXR9LWuRZSN1fB9oyCov/fBRGzYeMaG8PuKVqXAZ0OqlhsX8xile7G/MNOlOia1t67wy6gKa9ZOzsc0Ysst8yWHMvIWXmn2aVjm+WjUmhhUttL0sklqcu1tzVqWWRam3KbqVDt6aBiNn8sKmLQfmkWX0g=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4352.namprd11.prod.outlook.com (52.135.38.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 19:31:07 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 19:31:07 +0000
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
Thread-Index: AQHVjwDJaBck4npwFkmE20mgXgcXzqeGbxIA
Date:   Mon, 11 Nov 2019 19:31:06 +0000
Message-ID: <6beea8ea-ff6e-033b-8670-5da7529587b5@microchip.com>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.12.60.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39233312-8ab7-4a04-5a14-08d766ddb29e
x-ms-traffictypediagnostic: MN2PR11MB4352:
x-microsoft-antispam-prvs: <MN2PR11MB435245304B00AAF0E2F2BDB6F0740@MN2PR11MB4352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6512007)(446003)(11346002)(26005)(186003)(66066001)(6116002)(3846002)(2906002)(52116002)(102836004)(476003)(486006)(386003)(6506007)(53546011)(71200400001)(2201001)(66476007)(7416002)(4326008)(6246003)(31696002)(99286004)(14454004)(71190400001)(478600001)(76176011)(2501003)(86362001)(2616005)(66946007)(110136005)(229853002)(316002)(305945005)(8676002)(31686004)(7736002)(66446008)(36756003)(6436002)(8936002)(54906003)(4744005)(5660300002)(64756008)(66556008)(6486002)(14444005)(256004)(81166006)(81156014)(25786009)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4352;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ywyUxNQumyI5GZbgbd3VgcwILYtFolLXZuAVl6QNlgKbkKPBYYQ228HFkra1SeelSntNue8cYgShoZWg3XnDiFdBXVG7PFdBmQqvIro1NxQobBd0eh2juHA5MrISWAAcYfCzwHNnexGkfbQvDTB/+6C3IqmsiZ49tDJcL9xUMtUh7RYj3OGu7m22N8jNJu6nzaFjfrzJFOjiPOvqdxM62SFvGM/Pg+6umAoMLV5v7L1Qf2l0GLqJb11IG1ra9UDjC9hikgl1zzDP6RigLB9VQfI3Yd+PAOfQ94QTQDUF6yg+53x5309GygaSFXjnzhX+hQ0FB4wKVUHtvWW2HEoUizC3BrU3/deq+H6YQtTsr4Usk0sDVZztWkbbzJRbYvPbvdB4wjuGV+LA/oepzw0J0y0RIhE7Ik0mhOQ3WgMBgK4NAjIk7PgP0+1G1kAKGx3c
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <561E7C717FA13647BC7CA59001417AB8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 39233312-8ab7-4a04-5a14-08d766ddb29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 19:31:07.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9KxwLrI9kO5a7tz2k30Qkfuj4DANSDugONC/K/LAe/4cJpwvwAZVyrHkIKEGNboBYIv88Kp2EQRjJr1ndtgwJ5ZHav8pz2rnHW0UdSetUjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMwLzIwMTkgMTE6MDEgQU0sIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToN
Cj4gQWRkIE1URCBzdXBwb3J0IGZvciB3MjVxMjU2ancgU1BJIE5PUiBjaGlwIGZyb20gV2luYm9u
ZC4gVGhpcyBjaGlwDQo+IHN1cHBvcnRzIGR1YWwvcXVhZCBJL08gbW9kZSB3aXRoIDUxMiBibG9j
a3Mgb2YgbWVtb3J5IG9yZ2FuaXplZCBpbg0KPiA2NEtCIHNlY3RvcnMuIEluIGFkZGl0aW9uIHRv
IHRoaXMsIHRoZXJlIGlzIGFsc28gc21hbGwgNEtCIHNlY3RvcnMNCj4gYXZhaWxhYmxlIGZvciBm
bGV4aWJpbGl0eS4gVGhlIGRldmljZSBoYXMgYmVlbiB2YWxpZGF0ZWQgdXNpbmcgVGhvcjk2DQo+
IGJvYXJkLg0KPiANCj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+DQo+
IENjOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IENjOiBE
YXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+DQo+IENjOiBCcmlhbiBOb3JyaXMg
PGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT4NCj4gQ2M6IE1pcXVlbCBSYXluYWwgPG1pcXVl
bC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IENjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRA
bm9kLmF0Pg0KPiBDYzogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiBD
YzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogRGFyc2hh
ayBQYXRlbCA8ZGFyc2hhay5wYXRlbEBlaW5mb2NoaXBzLmNvbT4NCj4gW01hbmk6IGNsZWFuZWQg
dXAgZm9yIHVwc3RyZWFtXQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
PG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KDQpBcHBsaWVkIHRvIHNwaS1ub3IvbmV4dC4gVGhhbmtzLg0K
