Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA8206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="GZ1ph2Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLCNFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:05:02 -0500
Received: from mail-eopbgr140132.outbound.protection.outlook.com ([40.107.14.132]:5774
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCNFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:05:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itiSklXH9YMNpPXmSVS+jPtpU1jIFWuvWyYurdVlGO6lWxrUG9+Sm1LNCyp58uOaMcKf1AE0fBzej1o8Y2+W1P/hO9FZVwVML0resZiwvrAN1JTlyjUZ5WVfhnSFNGRu8qC/IMPQ+zWroImQsxAzSPhIhdfVfAKGJNh8h6Y2c/BI1HEa9kifs1bTMb13yB6k07Ikai93pgd6jQysOXNJuI4RnScuy1V+2jRFfTDH158272FWhy0Os7/LLYejAHClaQeEjcTogjrPPDlHQBIyzOv53F2kiWVYlGV1m681fCgwG2oOBLNnhluRgCZRGCGliZ5SMK/LpkL3R01k/+a7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6H4RF7fl5CSFX/0j+TWyz1D3w/8Bk8M64RsIspG79Y=;
 b=PH4+LDDtYMAg7ZnPzOsI30yUXioCSkqSloAjub8Yyy00tbnGrAhEiSP5TN062QKsjG7dZVMpjFUyV7R4WPhX2CZQbLslN4FkET60z2oXSwaVn5ITC0lA8GTjYiVxBlpsisa5uSPDhJCy+ypL2yntltyOog7szG3eR4bfbIdb69lD7eilOzeOQvhlM60FKjPWtbQJktttKhGqOvVrgUK1otDfR5FpqkpwuvUtOZlsSjaBWtaDlI7eq7mVUzVs0lNasaJgHkPX20viGWD5jYrhnNvGEKUd3exH+DyAqknQjeAGdbTRxPj9/t03EqDy4cVTOu2gkfzBx5IxXNUPC3cf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6H4RF7fl5CSFX/0j+TWyz1D3w/8Bk8M64RsIspG79Y=;
 b=GZ1ph2Ws0sGreY8b6udkcp3pAaMdfQ0ebEuy7XlkuaqDuPKrotMNkdDjHY62mBRHESOQOHfeJV31wCL8tkmakUcvXxeawtBPNhivhvptLYyqFPez+cJQImVHWOd8W7jyrVOakmxgJWu/GNCk7Atxa2XsWPJgoc9KjNP9Gpa+aRs=
Received: from AM6PR0202MB3432.eurprd02.prod.outlook.com (52.133.11.29) by
 AM6PR0202MB3432.eurprd02.prod.outlook.com (52.133.11.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 13:04:57 +0000
Received: from AM6PR0202MB3432.eurprd02.prod.outlook.com
 ([fe80::dc43:ed2c:945a:cd5]) by AM6PR0202MB3432.eurprd02.prod.outlook.com
 ([fe80::dc43:ed2c:945a:cd5%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 13:04:56 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Ingo van Lil <inguin@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: Reenable UART TX pull-ups
Thread-Topic: [PATCH] ARM: dts: at91: Reenable UART TX pull-ups
Thread-Index: AQHVpdOvdUWDNvrpeU+UsNRoQGwGi6eoaNgA
Date:   Tue, 3 Dec 2019 13:04:56 +0000
Message-ID: <8e8dfc02-bdab-d6f1-f6e9-e1dba7e38bfd@axentia.se>
References: <20191128100629.10247-1-inguin@gmx.de>
In-Reply-To: <20191128100629.10247-1-inguin@gmx.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0501CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::28) To AM6PR0202MB3432.eurprd02.prod.outlook.com
 (2603:10a6:209:26::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7947a15e-1176-4e68-4c89-08d777f16542
x-ms-traffictypediagnostic: AM6PR0202MB3432:
x-microsoft-antispam-prvs: <AM6PR0202MB3432543D7F9A72DC1E7F2763BC420@AM6PR0202MB3432.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(136003)(366004)(346002)(396003)(189003)(199004)(229853002)(5660300002)(7736002)(305945005)(71190400001)(4326008)(110136005)(71200400001)(6436002)(508600001)(31696002)(25786009)(2201001)(8936002)(14444005)(186003)(316002)(99286004)(6486002)(4001150100001)(54906003)(6246003)(256004)(6512007)(2616005)(81166006)(2501003)(66946007)(66556008)(64756008)(58126008)(11346002)(66446008)(6506007)(446003)(81156014)(36756003)(65956001)(66476007)(3846002)(53546011)(2906002)(102836004)(6116002)(386003)(14454004)(4744005)(31686004)(8676002)(26005)(76176011)(86362001)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3432;H:AM6PR0202MB3432.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OW7JiUo2rj5SorxM8jmVHQ0LkOFQg5sbAHBz7EkHkjMJZxsWZhjtfZLxiuq99dLtuAU0XEn2KS7Sw4Fez8/RQZ1NkCQVwRF/a+IfQizPTDp6j43e/HI4Ck/n2UZgktdbV2xOhAL9GhdvTrFDjij8A1JgfyhDc+bNvtcySbXYbS04dYcVOkae3kN6d1lzKIQyGxbrBkz/EYXfgIfuhdeJLPLD7dQs9XRpbSuVEZE0rDCRaICXm7skuHENTXtRy2QLtwh4KKzQcal11HWwA0YiY0lS04trp+b1IP9gGqqIJONuuraOKKdavHDp4PEUrZ5VQh6G1lgVePvKUamhj4btyJ/PquTuofIjrDlO/qJXZAVHJ86fh4PSWSgbxpgT/9wt2Ue16Gv/s7qOzdWzBaytSL26sipzqU501N+/i1wGLGoJ3oF8DwpAqee1gScXOzZM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <67E14BFC18AD7247B2E9B05C77247FF9@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7947a15e-1176-4e68-4c89-08d777f16542
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 13:04:56.8200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BX7/dn1le8ArtHpHh8NeM4BRgis99HE5mKiuzWMmpPjk/OPpxiSBlesPU2CTn7+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMS0yOCAxMTowNiwgSW5nbyB2YW4gTGlsIHdyb3RlOg0KPiBQdWxsLXVwcyBmb3Ig
U0FNOSBVQVJUL1VTQVJUIFRYIGxpbmVzIHdlcmUgZGlzYWJsZWQgaW4gNWUwNDgyMmYuDQo+IEhv
d2V2ZXIsIHNldmVyYWwgY2hpcHMgaW4gdGhlIFNBTTkgZmFtaWx5IHJlcXVpcmUgcHVsbC11cHMg
dG8gcHJldmVudA0KPiB0aGUgVFggbGluZXMgZnJvbSBmYWxsaW5nIChhbmQgY2F1c2luZyBhbiBl
bmRsZXNzIGJyZWFrIGNvbmRpdGlvbikgd2hlbg0KPiB0aGUgdHJhbnNjZWl2ZXIgaXMgZGlzYWJs
ZWQuDQo+IA0KPiBGcm9tIHRoZSBTQU05RzIwIGRhdGFzaGVldCwgMzIuNS4xOiAiVG8gcHJldmVu
dCB0aGUgVFhEIGxpbmUgZnJvbQ0KPiBmYWxsaW5nIHdoZW4gdGhlIFVTQVJUIGlzIGRpc2FibGVk
LCB0aGUgdXNlIG9mIGFuIGludGVybmFsIHB1bGwgdXANCj4gaXMgbWFuZGF0b3J5LiIuIFRoaXMg
Y29tbWl0IHJlZW5hYmxlcyB0aGUgcHVsbC11cHMgZm9yIGFsbCBjaGlwcyBoYXZpbmcNCj4gdGhh
dCBzZW50ZW5jZSBpbiB0aGVpciBkYXRhc2hlZXRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSW5n
byB2YW4gTGlsIDxpbmd1aW5AZ214LmRlPg0KDQpTb3VuZHMgcmVhc29uYWJsZSwgYW5kIHNvcnJ5
IGZvciB0aGUgYnJlYWthZ2UuIEhvd2V2ZXIsIHBlcmhhcHMgYSBwcm9wZXINCmZpeGVzIHRhZyAo
d2l0aCB0aGUgcHJlc2NyaWJlZCBsZW5ndGggb2YgdGhlIGNvbW1pdCBoYXNoKSBzaG91bGQgYmUg
aW4NCnRoZXJlIHNvbWV3aGVyZT8NCg0KRml4ZXM6IDVlMDQ4MjJmN2RiNSAoIkFSTTogZHRzOiBh
dDkxOiBmaXhlcyB1YXJ0IHBpbmN0cmwsIHNldCBwdWxsdXAgb24gcngsIGNsZWFyIHB1bGx1cCBv
biB0eCIpDQoNCkFsc28sIEkgdGhpbmsgdGhlIHNhbWUga2luZCBvZiBjaGFuZ2Ugd2FzIG1hZGUg
dG8gdGhlIGJhcmVib3ggYm9vdGxvYWRlcg0KYXQgYWJvdXQgdGhlIHNhbWUgdGltZS4gSXMgdGhl
cmUgYSBmaXggZm9yIHRoYXQgcXVldWVkIHVwIGFzIHdlbGw/DQoNCkNoZWVycywNClBldGVyDQo=
