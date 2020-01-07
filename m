Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A537AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377A32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gfvWz13N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgAGJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:19:42 -0500
Received: from mail-db8eur05on2116.outbound.protection.outlook.com ([40.107.20.116]:50496
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbgAGJTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlIU4V7z2BNC57qTWBXFe8ef+/s8iAHW53HuAr8HopMpKfkl4lVbVlGxKG4HabnEkD4DvFCOQ+o23CmCVsc0uPrYUYzyAw/5MYzEBQhBOZffC+BETVF/4sat4L/fwGIwC2r5wx9wnV2x2KDe7hlfNL5cQ4Yn9gN6YJQ+dbKHExgnJU6hY4TL0henUxbc8CSOCVBou6zpLfPAgunVmcDgspqLzluy1SBbGnv7DkMOFJN5ZWvtLk+H4viu4HMwy37JYZt2/PLEC86XSIt1aVlfnhPncqQBrmKU0yXGPY+KlPlJHDeW4L7Dgl9f5V1uddNw6n5P0ADsFcn6ypdpDzzjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KamLRbfPAE5S2P6S/JrOXq5DIFM5c2bHxAgFwc5QQE=;
 b=ab2wfbrNsEUd+Y3QQIYIkqdqOyUsIdJYx3s/FOh1LVEEuu+dNg1hPuL41wi5EynAsoNz3/7iOyNfSObl2k5pe5Fq6tFwmymMECSWXEB6hdG0fOvhYn+/LByENC4gkaUkAl4wG1PiP4B6Cy5YlADTrY5EuM9lQP3iNkolitq8OruiM9Fo6+AO/NXH5io3UPjzUMONUauPKVsamHumT3AcRhqq4cmuAz8ip24YNiql4t5V2W3UFiBTJLTp6/kIFi0YpENDl7YT6ggxD52e1Sw967irR3xDK57VpYFkE+t1wrWFvmOGvqyVC/Oqr6EzsR0DsKMZ5fNolnZLDDSyL4TvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KamLRbfPAE5S2P6S/JrOXq5DIFM5c2bHxAgFwc5QQE=;
 b=gfvWz13NawfEyZ+RBj6esG75ZQvygglSBokCYaGW88nn4a0RaIoL8BAtBZjNBY2tRyG/Kqc3ZiUQbYix+0xuaK56OBwz9ucH0gioH8/Yp4qZEscJ/fDQRb2A8O7cbF2phhYePH1l00i+j6YqHXYqEdTG+d1Ya2iqbV3foppttFU=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3305.eurprd02.prod.outlook.com (52.134.65.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 09:19:37 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::cd85:a8a5:da14:db13%7]) with mapi id 15.20.2602.015; Tue, 7 Jan 2020
 09:19:37 +0000
Received: from [192.168.13.3] (213.112.138.4) by HE1PR0402CA0051.eurprd04.prod.outlook.com (2603:10a6:7:7c::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 09:19:36 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Topic: [PATCH v3 5/6] drm: atmel-hlcdc: prefer a lower pixel-clock than
 requested
Thread-Index: AQHVtZ63IXD3UJn810+N2kokGKcMV6fXLT4AgAZN0QCAAZDZAA==
Date:   Tue, 7 Jan 2020 09:19:37 +0000
Message-ID: <6bd70a21-1dc1-6b78-1e86-8ca4704c944c@axentia.se>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <1576672109-22707-6-git-send-email-claudiu.beznea@microchip.com>
 <20200102090848.GC29446@ravnborg.org>
 <64902ae8-ef5a-a94a-8edf-05159699b72c@microchip.com>
In-Reply-To: <64902ae8-ef5a-a94a-8edf-05159699b72c@microchip.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
x-originating-ip: [213.112.138.4]
x-clientproxiedby: HE1PR0402CA0051.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::40) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1417f12c-a26c-4a33-6c76-08d79352b7a5
x-ms-traffictypediagnostic: DB3PR0202MB3305:
x-microsoft-antispam-prvs: <DB3PR0202MB3305B517AA4E96C0A5EBE00EBC3F0@DB3PR0202MB3305.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39830400003)(189003)(199004)(2616005)(956004)(53546011)(2906002)(71200400001)(16526019)(186003)(26005)(81156014)(81166006)(16576012)(316002)(8676002)(5660300002)(86362001)(54906003)(7416002)(8936002)(110136005)(31696002)(66946007)(64756008)(4744005)(52116002)(66556008)(66446008)(6486002)(508600001)(66476007)(36756003)(31686004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3305;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Abuzpg7ZUua82OVGdkiRQqUySxdB6ZxrwcmlCa2vhTCjv9a2n4G4K0LNVZLVluVQjIjDnbpTYOR72Y/tao/OYF6GAzb7L/DuFFIxbE5B4/1aPca9ADKmAn/zYQi5XFhi6XO9FjWrbuL9sqHp3Jw42McvjYXXNPG61MPpCzIeWdQm8jlmyy+JmQO5sj0cFIqXY/fVYtlByIWqUbBFKYCPAF47sBJHJR2VTmzaYQnj5LkblgJ95iEWmjoPJKGQm5Wtf2QnJvK2Dmjy31eb3wt5H53zYSy6W+qzjUqjNu62Sne2RHnlkiWiFfS18CwGs9zScF/DBD/S68Cn1a1rCSNIZnwc4ZvVGqEHEuV0mwsuuaEKAxDXW3jyjQQRDP5yqy+Qz4Oh+ABJhSuEtNW9Xi2IVk+RAWpcv2I7Hnu75VhMQSVh/vjE5Gd1CyYrFz/9Il3R
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <16F0484F01ABFD459032BAF727F998CA@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1417f12c-a26c-4a33-6c76-08d79352b7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 09:19:37.6356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn8Ljw25qL4Vj2/++JpdXAh90fmHK1DNdnkpgCBfHMzAayFKKTGbkDa2iqK2f2M0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC0wMS0wNiAxMDoyNCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gT24gMDIuMDEuMjAyMCAxMTowOCwgU2FtIFJhdm5ib3JnIHdyb3RlOg0KPj4gT24gV2VkLCBE
ZWMgMTgsIDIwMTkgYXQgMDI6Mjg6MjhQTSArMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+
Pj4gRnJvbTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+Pg0KPj4+IFRoZSBpbnRl
bnRpb24gd2FzIHRvIG9ubHkgc2VsZWN0IGEgaGlnaGVyIHBpeGVsLWNsb2NrIHJhdGUgdGhhbiB0
aGUNCj4+PiByZXF1ZXN0ZWQsIGlmIGEgc2xpZ2h0IG92ZXJjbG9ja2luZyB3b3VsZCByZXN1bHQg
aW4gYSByYXRlIHNpZ25pZmljYW50bHkNCj4+PiBjbG9zZXIgdG8gdGhlIHJlcXVlc3RlZCByYXRl
IHRoYW4gaWYgdGhlIGNvbnNlcnZhdGl2ZSBsb3dlciBwaXhlbC1jbG9jaw0KPj4+IHJhdGUgaXMg
c2VsZWN0ZWQuIFRoZSBmaXhlZCBwYXRjaCBoYXMgdGhlIGxvZ2ljIHRoZSBvdGhlciB3YXkgYXJv
dW5kIGFuZA0KPj4+IGFjdHVhbGx5IHByZWZlcnMgdGhlIGhpZ2hlciBmcmVxdWVuY3kuIEZpeCB0
aGF0Lg0KPj4+DQo+Pj4gRml4ZXM6IGY2ZjdhZDMyMzQ2MSAoImRybS9hdG1lbC1obGNkYzogYWxs
b3cgc2VsZWN0aW5nIGEgaGlnaGVyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVkIikNCj4+IFRo
ZSBpZCBpcyB3cm9uZyBoZXJlIC0gdGhlIHJpZ2h0IG9uZSBpczogOTk0NmEzYTlkYmVkYWFhY2Vm
OGI3ZTk0ZjZhYzE0NGYxZGFhZjFkZQ0KPiANCj4gUmlnaHQhIFNvcnJ5IGZvciB0aGlzIG9uZSEg
VGhhbmsgeW91IGZvciBmaXhpbmcgaXQgdXAuDQoNCkRpdG8uIFRoaXMgb25lIHdhcyBteSBmYXVs
dC4gSSB3b25kZXIgaG93IEkgY2FtZSB1cCB3aXRoIHRoZSB3cm9uZyBpZD8NClByb2JhYmx5IHNv
bWUgYmFja3BvcnQgYnJhbmNoIG9yIHNvbWV0aGluZywgYnV0IEknbSBub3QgZmluZGluZyBpdC4g
T2gNCndlbGwsIHNvcnJ5IGFnYWluLg0KDQpDaGVlcnMsDQpQZXRlcg0K
