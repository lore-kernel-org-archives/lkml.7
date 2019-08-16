Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58395C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4D220644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="pWqpcoia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHPGom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:44:42 -0400
Received: from mail-eopbgr50122.outbound.protection.outlook.com ([40.107.5.122]:16152
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHPGol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:44:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWV5DzU13A8QVw+92UpfoQZ3yAAKXcKl1VtTpsj7w10lh2ECdYRWdhjHsja0SdxcgKNXDOKl3FCpaaKmbpyzfHU9hdzLKsaRwBA0HMxtrjeLJWFKcFp+yCWWsufBghB115dZK52YgJBuPAaTBahNlbRxHzbTsWzmIMR4/iXSxMrwJ1PKNDV9Ad7+FH/4doCZx0DY7Vw3XLqJxjTmqW0a9FgRO2PA/M5YXeKxZ20bFiQq/Kt1F6cPhHKI4yEaSZA2rUmQeKNN220G0mf6/A1oPzvJZgCrCKJD0FDVtsmf66KxNEbfJxz8t/7gyfcDOoryTxQynocb+8WUIRYk3zz5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JZbsLPVjmsVZG3xXfbbHlNI0UcjX61p4f+tlVzKlrM=;
 b=R4tztcqLEHjcoEBKliuLydatyO1eSJgOc1HPrmfyCXqZYV9TZn6+zvx0K4/W5IenYUxG11V90ADr8aP+hezahvpcN1+N3vtdQ/669ONWExFZ1HlHbhnXv0UKsCT5f9NIzAUeJC96lwgEFlb0S/686nAJBgpM965vplQqu5SvuGovBpS5KLMsK2sE/Ehjcf+v7ajXaf3mkwkfKGpabFzoaocbERjgIc8BY6qyh30KQ7MHEWKXIF01Nu/SD87KFtFqCXcTecrZSL5vKM+eCY2q/GVfXbN9haIY7Vuw29u0NaMBTYU6NxsEdjOhTQOxBQ0jt6ZMzPLAGQ7xassXa7Vs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JZbsLPVjmsVZG3xXfbbHlNI0UcjX61p4f+tlVzKlrM=;
 b=pWqpcoiajZgjnYNUj+xUsTNZyUL1Zi3tlDOzUSyt813MbU5ulvH3bXkz9aUtZWmneBDq0DRj5wNUZXGrcx4+qiOXZv69+Ff60WOr6PVyETGheGQzmuROF4dJdF8GEPYK/qXerd0bUzMYp3IsgyUsWL1LSX02U2x8mzbuTVnmXTg=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3695.eurprd05.prod.outlook.com (52.134.8.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 06:44:35 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 06:44:35 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 20/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Topic: [PATCH v4 20/21] ARM: dts: imx7-colibri: Add UHS support to eval
 board
Thread-Index: AQHVURlFnRbeofYGyEy6mLRVDRVbVKb9We4A
Date:   Fri, 16 Aug 2019 06:44:35 +0000
Message-ID: <eda215fd7db7509ddfbe12d83e9ae70674ef1ba4.camel@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
         <20190812142105.1995-21-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-21-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b856f5b-3077-4ce0-204a-08d7221533a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3695;
x-ms-traffictypediagnostic: VI1PR0502MB3695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB36956974E0F2EE23C2F51312F4AF0@VI1PR0502MB3695.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(189003)(199004)(86362001)(2201001)(2501003)(36756003)(66066001)(118296001)(53936002)(81156014)(476003)(8936002)(8676002)(6246003)(44832011)(14444005)(256004)(14454004)(4326008)(11346002)(486006)(2616005)(5660300002)(2906002)(7736002)(66556008)(66446008)(91956017)(76116006)(66946007)(305945005)(66476007)(7416002)(64756008)(25786009)(446003)(3846002)(6116002)(54906003)(110136005)(81166006)(316002)(76176011)(99286004)(6486002)(6436002)(186003)(229853002)(478600001)(26005)(71200400001)(71190400001)(6512007)(6506007)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3695;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 51p+/DylqLjFqzdDJugVWXkq4tKWxX/7JgsGd5IX148BX2ii+uVNQXGzaui0jeA4BkK4ggNhAbzW70VC9G7d3LZ7tteeQRxIHXLq1RnobMQSt926W32eLwkIUUDkpyv/Fk7uMWOTTg/1qZIgr19IzrCs1NKZVIOb2g6G7T0r1aa1m0aEKRCpy0zC9YiCVS3v5OMra0RYsBOamZgjl6IkDlhpFhRqYcFKPiaZX7EDkkb6y3z4h8fisC/DsWSDVKWqAudEiaJQ/CCq4InPEv4+gAz02AugDHOlqETWQLPsAxLVwbag7BluyVwtR0EursN682nFW4KCRZVDRMa04/Yr97s4L35CPzUEPD908YhjbJ7i1WC/MvpacLTvsqdMqBVMutd2oK7yZ1GxGt23vP9XHYUzaFpiPtvZ8shWAEQhPbU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1BF490E43A2434C980DAF8C2479961D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b856f5b-3077-4ce0-204a-08d7221533a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 06:44:35.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TC7PLEITQDOAG2W5K3FAYWm45PPjdgWxB1tKxJJaK08/o8W5YVIS0Hbu/049b58EN5cw3baVHL+JBKdYGkBH+1tlFnu5MYNyiklBOrXWfRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTEyIGF0IDE0OjIxICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gVGhpcyBjb21taXQgYWRkcyBVSFMgY2FwYWJpbGl0eSB0byBUb3JhZGV4IEV2YWwgQm9h
cmRzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2No
ZW5rZXJAdG9yYWRleC5jb20+DQoNClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4gVGhlcmUgd2Fz
IGEgbWlzdW5kZXJzdGFuZGluZyBhbmQgdGhpcyBvbmUNCnNob3VsZG4ndCBnbyBpbnRvIG1haW5s
aW5lLiBTb3JyeSBmb3IgdGhhdCENCj4gDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2NDogTm9u
ZQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIE5ldyBwYXRjaCB0byBtYWtlIHVzZSBvZiBBUk06IGR0
czogaW14Ny1jb2xpYnJpOiBmaXggMS44Vi9VSFMNCj4gc3VwcG9ydA0KPiANCj4gQ2hhbmdlcyBp
biB2MjogTm9uZQ0KPiANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYz
LmR0c2kgfCAxMSArKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xp
YnJpLWV2YWwtdjMuZHRzaQ0KPiBpbmRleCA1NzZkZWM5ZmY4MWMuLjkwMTIxZmJlNTYxZiAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0K
PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+IEBA
IC0yMTAsOSArMjEwLDE2IEBADQo+ICB9Ow0KPiAgDQo+ICAmdXNkaGMxIHsNCj4gLQlrZWVwLXBv
d2VyLWluLXN1c3BlbmQ7DQo+IC0Jd2FrZXVwLXNvdXJjZTsNCj4gKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiLCAic3RhdGVfMTAwbWh6IiwgInN0YXRlXzIwMG1oeiI7DQo+ICsJcGluY3RybC0w
ID0gPCZwaW5jdHJsX3VzZGhjMSAmcGluY3RybF9jZF91c2RoYzE+Ow0KPiArCXBpbmN0cmwtMSA9
IDwmcGluY3RybF91c2RoYzFfMTAwbWh6ICZwaW5jdHJsX2NkX3VzZGhjMT47DQo+ICsJcGluY3Ry
bC0yID0gPCZwaW5jdHJsX3VzZGhjMV8yMDBtaHogJnBpbmN0cmxfY2RfdXNkaGMxPjsNCj4gIAl2
bW1jLXN1cHBseSA9IDwmcmVnXzN2Mz47DQo+ICsJdnFtbWMtc3VwcGx5ID0gPCZyZWdfTERPMj47
DQo+ICsJY2QtZ3Bpb3MgPSA8JmdwaW8xIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gKwlkaXNhYmxl
LXdwOw0KPiArCWVuYWJsZS1zZGlvLXdha2V1cDsNCj4gKwlrZWVwLXBvd2VyLWluLXN1c3BlbmQ7
DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gIA0K
