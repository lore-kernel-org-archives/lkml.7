Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E840C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0F229F9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="itwTJam/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfHGI0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:15 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbfHGI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOaFcvHq+7VLFc0kHFJAQlKCJxOvR/9NyFUTVhesvH/M+WUmW+6x8o7YzYrSLCtT684BW/F1R3VpSzTcQsncNO14GELq2USgBEwdz3GsZTrO0GF1bb5F6qpjUxJ7+8YPPI0CMNP6CQFeakS7Re0fd3VQtk1IzuQheLow+VuKQgb7PtVVc3t7RM41hAK4XHwQ2cCndWHn7Ns8IGeOoF1+Tu1yWIpT+y9U57EGezsLBtBl6bbCWPJ0rtrZWhMNHpuinvz6g+fjuMAWQltHoTyoZJG9WKL65oDccDd60cdUTERi3n9kpTWNc3nNMK2jGTqOr/MJHbY3w/zexSVp/cXD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+5jnwvCpHfiP2LSNlKCE7GDwa6vNliruYXUPs35SIg=;
 b=el1bmz6lNfCdZI1r0z0mqfOqs9fcGmtPbjHoWWHofxE5WRnX8PwgM7/8d4Tv8wioSN/e1zlW0M6v2PrdvKckJl1CVsrlz3FN1VT6X7vYV+xUOHZSydpZJ/Nbx+gUD2wZ/YCsWArBF3Q7jPbYDbi/J0RslWeLpQiDW6aLI/QzgIskoKI5vTrRx0pPExQ8oqstxlD1KFVuTzUG3sxOVTUrkVRQfk4nANoCZFiho3IFBsiLGkwNc3RulrbKWKRx53b0DmSlyVKurgI3heBOE76VxnR5ZoogihlHjTwGa56k1taQ/D4xt571R4ackHQzZrBQACuqAM6O7ywGNmZPxwewbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+5jnwvCpHfiP2LSNlKCE7GDwa6vNliruYXUPs35SIg=;
 b=itwTJam/JUzFeAnkUVPYfOJPq7Hi5g44eehghKKxHM9z1CTyzRhk3O0DGbqNEozUKuY7N3zZ9yWHBq0gIwf0NCds34phyNU6/m/jiO2hzBno2Ip0Nrd2u9k/Fyt08F+HwFe/S2vfRhu78d5/ZIFr1RSfWkJdnPvfdQR/x+QSLXs=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:06 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:06 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 00/21] Common patches from downstream development
Thread-Topic: [PATCH v3 00/21] Common patches from downstream development
Thread-Index: AQHVTPnB462n1EX0jUKSqsYCdq6Q9Q==
Date:   Wed, 7 Aug 2019 08:26:05 +0000
Message-ID: <20190807082556.5013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acfd2bac-00b8-496a-f925-08d71b10e422
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614AA3540A21CFE0FC89E41F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(561944003)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ejJjbB3FAn/9QJ3RfUNt2BuCzrZJ3yS1+V17yCCpBTf110xZ6MclBQxRlumXzcTUDEKLSuMg45/b1o2Z+Tx8kgbj327Z+rXL/m3nFrPovCDyxgkUkhMmYRBpVzCo1F+qn3OqviGeVeJJja+Ge884/5F6CaIh8qqcHROS7hXa9H+8qx1IxsjwGuZBybFGSvsRgoru1F8Z5JuJsZ+Uj+qSyeN4N8jah+FXtsn+iyHDsYdURrVLr48RNpSqg90JUjtbnxyzVD2wDs3kHaMNErCHjpsjEDCnOhuVOuFPXeC2ynsT5SCCOvQHEFHIuC3DMNk4DCeWmBTBrrWwNtmLWbTuAR6KA9+SsxpM1Wvob4xmT8ECS6U0bcBztaZczJ06m8Z37obm4lfEo9jGvtf1/euiXVHp8b1u0p31JOpEmgAr3Pw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCE9C65B249DB54BA44E3BB0E0E30CB6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfd2bac-00b8-496a-f925-08d71b10e422
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:05.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfuUGhs8wj/yOYcnZU+6J5qGsVtjQ+i+ix8AO75t7tOOujHWUaXllVE+pqSif3WupjyW4D+eHOgTaCrTsM8lg+0bre/Rpjg9XFBAH2hoCE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGhvbGRzIHNvbWUgY29tbW9uIGNoYW5nZXMgdGhhdCB3ZXJlIG5ldmVy
IHVwc3RyZWFtZWQuDQpXaXRoIGxhdGVzdCBkb3duc3RyZWFtIGtlcm5lbCB1cGdyYWRlLCBJIHRv
b2sgdGhlIGFwcm9hY2ggdG8gc2VsZWN0DQptYWlubGluZSBkZXZpY2V0cmVlcyBhbmQgYXRvbWlj
YWxseSBhZGQgbWlzc2luZyBzdHVmZiBmb3IgZG93bnN0cmVhbS4NCg0KVGhlc2UgcGF0Y2hlcyBJ
IHNlbmQgaGVyZSBhcmUgc2VwYXJhdGVkIG91dCB3aXRoIGNoYW5nZXMgdGhhdCBhbHNvDQpoYXZl
IGEgYmVuZml0IGZvciBtYWlubGluZS4NCg0KUGhpbGlwcGUNCg0KQ2hhbmdlcyBpbiB2MzoNCi0g
QWRkIG5ldyBjb21taXQgbWVzc2FnZSBmcm9tIFN0ZWZhbidzIHByb3Bvc2FsIG9uIE1MDQotIEZp
eCBjb21taXQgbWVzc2FnZQ0KLSBGaXggY29tbWl0IHRpdGxlIHRvICIuLi5pbXg2LWFwYWxpczou
Li4iDQotIE5ldyBwYXRjaCB0byBtYWtlIHVzZSBvZiBBUk06IGR0czogaW14Ny1jb2xpYnJpOiBm
aXggMS44Vi9VSFMgc3VwcG9ydA0KDQpDaGFuZ2VzIGluIHYyOg0KLSBEZWxldGVkIHRvdWNocmV2
b2x1dGlvbiBkb3duc3RyZWFtIHN0dWZmDQotIFVzZSBnZW5lcmljIG5vZGUgbmFtZQ0KLSBCZXR0
ZXIgY29tbWVudA0KLSBDaGFuZ2VkIGNvbW1pdCB0aXRsZSB0byAnLi4uaW14NnFkbC1hcGFsaXM6
Li4uJw0KLSBEZWxldGVkIHRvdWNocmV2b2x1dGlvbiBkb3duc3RyZWFtIHN0dWZmDQotIFVzZSBn
ZW5lcmljIG5vZGUgbmFtZQ0KLSBQdXQgYSBiZXR0ZXIgY29tbWVudCBpbiB0aGVyZQ0KLSBDb21t
aXQgdGl0bGUNCi0gUmVtb3ZlZCBmMDcxMGEsIHRoYXQgaXMgZG93bnN0cmVhbSBvbmx5DQotIENo
YW5nZWQgdG8gZ2VuZXJpYyBub2RlIG5hbWUNCi0gQmV0dGVyIGNvbW1lbnQNCg0KTWFyY2VsIFpp
c3dpbGVyICgxKToNCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogbWFrZSBzdXJlIG1vZHVsZSBz
dXBwbGllcyBhcmUgYWx3YXlzIG9uDQoNCk1heCBLcnVtbWVuYWNoZXIgKDIpOg0KICBBUk06IGR0
czogaW14NnVsbC1jb2xpYnJpOiByZWR1Y2Ugdl9iYXR0IGN1cnJlbnQgaW4gcG93ZXIgb2ZmDQog
IEFSTTogZHRzOiBpbXg2dWxsOiBpbXByb3ZlIGNhbiB0ZW1wbGF0ZXMNCg0KT2xla3NhbmRyIFN1
dm9yb3YgKDEpOg0KICBBUk06IGR0czogYWRkIHJlY292ZXJ5IGZvciBJMkMgZm9yIGlNWDcNCg0K
UGhpbGlwcGUgU2NoZW5rZXIgKDE0KToNCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogcHJlcGFy
ZSBtb2R1bGUgZGV2aWNlIHRyZWUgZm9yIEZsZXhDQU4NCiAgQVJNOiBkdHM6IGlteDctY29saWJy
aTogQWRkIHNsZWVwIG1vZGUgdG8gZXRoZXJuZXQNCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTog
QWRkIHRvdWNoIGNvbnRyb2xsZXJzDQogIEFSTTogZHRzOiBpbXg2cWRsLWNvbGlicmk6IGFkZCBw
aHkgdG8gZmVjDQogIEFSTTogZHRzOiBpbXg2cWRsLWNvbGlicmk6IEFkZCBtaXNzaW5nIHBpbiBk
ZWNsYXJhdGlvbiBpbiBpb211eGMNCiAgQVJNOiBkdHM6IGlteDZxZGwtYXBhbGlzOiBBZGQgc2xl
ZXAgc3RhdGUgdG8gY2FuIGludGVyZmFjZXMNCiAgQVJNOiBkdHM6IGlteDYtYXBhbGlzOiBBZGQg
dG91Y2hzY3JlZW5zIHVzZWQgb24gVG9yYWRleCBldmFsIGJvYXJkcw0KICBBUk06IGR0czogaW14
Ni1jb2xpYnJpOiBBZGQgbWlzc2luZyBwaW5tdXhpbmcgdG8gVG9yYWRleCBldmFsIGJvYXJkDQog
IEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IEFkZCBzbGVlcCBtb2RlIHRvIGZlYw0KICBBUk06
IGR0czogaW14NnVsbC1jb2xpYnJpOiBBZGQgd2F0Y2hkb2cNCiAgQVJNOiBkdHM6IGlteDZ1bGwt
Y29saWJyaTogQWRkIGdlbmVyYWwgd2FrZXVwIGtleSB1c2VkIG9uIENvbGlicmkNCiAgQVJNOiBk
dHM6IGlteDYvNy1jb2xpYnJpOiBzd2l0Y2ggZHJfbW9kZSB0byBvdGcNCiAgQVJNOiBkdHM6IGlt
eDZ1bGwtY29saWJyaTogQWRkIHRvdWNoc2NyZWVuIHVzZWQgd2l0aCBFdmFsIEJvYXJkDQogIEFS
TTogZHRzOiBpbXg3LWNvbGlicmk6IEFkZCBVSFMgc3VwcG9ydCB0byBldmFsIGJvYXJkDQoNClN0
ZWZhbiBBZ25lciAoMyk6DQogIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IGRpc2FibGUgSFM0MDAN
CiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogYWRkIEdQSU8gd2FrZXVwIGtleQ0KICBBUk06IGR0
czogaW14Ny1jb2xpYnJpOiBmaXggMS44Vi9VSFMgc3VwcG9ydA0KDQogYXJjaC9hcm0vYm9vdC9k
dHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMgIHwgIDM5ICsrKysrKw0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0cyAgICAgICB8ICAxMyArKw0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS12MS4xLmR0cyB8ICAxMyArKw0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5kdHMgICAgICB8ICAxMyArKw0KIGFyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kgICAgICAgICB8ICAyNyArKysrLQ0KIGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpICAgICAgICB8ICAyNyArKysrLQ0KIC4uLi9h
cm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8ICA1MCArKysrKysrKw0K
IC4uLi9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRzaSB8ICAgMiArLQ0K
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS13aWZpLmR0c2kgICB8ICAgMiArLQ0K
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICB8ICA1MiArKysr
KysrLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kgICB8ICA0
OSArKysrKysrLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpICAgICAgICAg
ICB8IDExNCArKysrKysrKysrKysrKysrLS0NCiAxMiBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0
aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMi4wDQoNCg==
