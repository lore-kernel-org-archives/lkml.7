Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B10E2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="i+KNzgzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfGaMiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:06 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com ([40.107.0.139]:62301
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfGaMiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCl8zJNeoBAdLCOWzeSmXY6JQvhU7o830Om9pMAEQwsbC/G5cqVES+m3tto1Pp4yIjkl1zmMBxcTt8L6YukhvXVSnf7521jBjdXykNtcOfqEatV7/sJIe6G4jhJsF0n/u/vMZqFNCJtRIIc3HPaOsMY8RzsrsHQpioicxUVG10ceM5u4xSLofcygBuILw1Q3daZFFOeWoWm1V3cssn+qxhi4sTECu2aAOA5A6Sj5N5om7JyK7PcJlz7iJ5B5nEuTi8KSYjPZdkgTKggNq3bNjE/kKzSMaCZ45gmAY0+ZxAK4XK1Y4ygOiGzA3pursuvVENjjEdGPUZIAidOV4Os+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHEm+LOKeLrvYCN7RsDwfk1aXf6jnOP4V9fDiKY/rkU=;
 b=N99J+Tx6FqBU4badJgJJXSY3/BmRe82P+X6YXBZ9C7z2/VbJ6cEbtQfKs5pjFQThJcwPF219YjyJ1DDOi7+1agc5FPzh7tnwXS8Jrjv3cn1ORAXkTJVS3Wmz/W7aZxoSFd4oCLvExCy8dIJtU4p22r4BD+WJ2tF4c7uxifmBxorAYG1tk401wQ3c4gdvQsaf9qDyu74J+otpxokG3kRK7pl/6VsxGJNMz1RZEg1RSiejuqx5NhsQoEK6zwBdBs17TIs9GY9QT2/BoaqZPYoyAUGo/yngVNXxSnoHMT0RJXC6BPX4ZEmFT1IoXyyJFTBP0OikYGmrXY7VVaHCzSDwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHEm+LOKeLrvYCN7RsDwfk1aXf6jnOP4V9fDiKY/rkU=;
 b=i+KNzgzOWsuP0hmKxVfXy1IrsMn/xsM/20dXcdt/hDuKTjxCBSXGvQuMbZth0OFAgOP3YK7fG3VJDM+WVHYvxsWVAwlBCJVs1bUIK5BLpBt2YG3ZPJ5o7aduxxdrtfCtFksMPcHkZU8i5LUPr3QfZN12bHsOCW7Xfdh2nu2gOiY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:37:59 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:37:59 +0000
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
Subject: [PATCH v2 00/20] Common patches from downstream development
Thread-Topic: [PATCH v2 00/20] Common patches from downstream development
Thread-Index: AQHVR5zJQnJDf+SlSUKaCGGthm+ICA==
Date:   Wed, 31 Jul 2019 12:37:59 +0000
Message-ID: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63e66e0-bbe1-4e56-0e58-08d715b3ebca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB361545511E98C48542136BCBF4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(2616005)(14444005)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: luo8dK12L+LCtDT7VklScPG3rK+l6RaDEwxerHBvcNLXMDwuz9lZUJa3EARd2mSY+74cejMYoPJ8yHwPcTz6fsNtHbODMiXOC29b4oFXA2m2pmf4UletCJ/I+OXm7Vqc3UrtRDvaXsDeHqL4llEDq1wy4I7hjLsd8g3Ql0OvysjsLqoLcogK1t1n8uRoOUmy2tNKSBSflH0JT6feHO9UDCdcO2ERlMKkAMjxnhZ/rkebCngzbbWLYp1U0pH5adqqTBoH7eqraHbSaJbOUHjy0R1Kp3nAJ9DcT8+GDd83/WdzCz2A3Vwx0+QunqFj8+so/gwtg/6Epu1FytAq7yEYJNkm67xAM94biKl4MQIz6gD38EhumsKktcmb8sYQEfJkkvHYUPok1XfoV40fR0M5hVBPVCOcpDZEBFBTiMVzVHE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CBC9BD2EFA2D04A86C2C30573DA87B8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63e66e0-bbe1-4e56-0e58-08d715b3ebca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:37:59.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGhvbGRzIHNvbWUgY29tbW9uIGNoYW5nZXMgdGhhdCB3ZXJlIG5ldmVy
IHVwc3RyZWFtZWQuDQpXaXRoIGxhdGVzdCBkb3duc3RyZWFtIGtlcm5lbCB1cGdyYWRlLCBJIHRv
b2sgdGhlIGFwcm9hY2ggdG8gc2VsZWN0DQptYWlubGluZSBkZXZpY2V0cmVlcyBhbmQgYXRvbWlj
YWxseSBhZGQgbWlzc2luZyBzdHVmZiBmb3IgZG93bnN0cmVhbS4NCg0KVGhlc2UgcGF0Y2hlcyBJ
IHNlbmQgaGVyZSBhcmUgc2VwYXJhdGVkIG91dCB3aXRoIGNoYW5nZXMgdGhhdCBhbHNvDQpoYXZl
IGEgYmVuZml0IGZvciBtYWlubGluZS4NCg0KUGhpbGlwcGUNCg0KQ2hhbmdlcyBpbiB2MjoNCi0g
RGVsZXRlZCB0b3VjaHJldm9sdXRpb24gZG93bnN0cmVhbSBzdHVmZg0KLSBVc2UgZ2VuZXJpYyBu
b2RlIG5hbWUNCi0gQmV0dGVyIGNvbW1lbnQNCi0gQ2hhbmdlZCBjb21taXQgdGl0bGUgdG8gJy4u
LmlteDZxZGwtYXBhbGlzOi4uLicNCi0gRGVsZXRlZCB0b3VjaHJldm9sdXRpb24gZG93bnN0cmVh
bSBzdHVmZg0KLSBVc2UgZ2VuZXJpYyBub2RlIG5hbWUNCi0gUHV0IGEgYmV0dGVyIGNvbW1lbnQg
aW4gdGhlcmUNCi0gQ29tbWl0IHRpdGxlDQotIFJlbW92ZWQgZjA3MTBhLCB0aGF0IGlzIGRvd25z
dHJlYW0gb25seQ0KLSBDaGFuZ2VkIHRvIGdlbmVyaWMgbm9kZSBuYW1lDQotIEJldHRlciBjb21t
ZW50DQoNCk1hcmNlbCBaaXN3aWxlciAoMSk6DQogIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IG1h
a2Ugc3VyZSBtb2R1bGUgc3VwcGxpZXMgYXJlIGFsd2F5cyBvbg0KDQpNYXggS3J1bW1lbmFjaGVy
ICgyKToNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogcmVkdWNlIHZfYmF0dCBjdXJyZW50
IGluIHBvd2VyIG9mZg0KICBBUk06IGR0czogaW14NnVsbDogaW1wcm92ZSBjYW4gdGVtcGxhdGVz
DQoNCk9sZWtzYW5kciBTdXZvcm92ICgxKToNCiAgQVJNOiBkdHM6IGFkZCByZWNvdmVyeSBmb3Ig
STJDIGZvciBpTVg3DQoNClBoaWxpcHBlIFNjaGVua2VyICgxMyk6DQogIEFSTTogZHRzOiBpbXg3
LWNvbGlicmk6IHByZXBhcmUgbW9kdWxlIGRldmljZSB0cmVlIGZvciBGbGV4Q0FODQogIEFSTTog
ZHRzOiBpbXg3LWNvbGlicmk6IEFkZCBzbGVlcCBtb2RlIHRvIGV0aGVybmV0DQogIEFSTTogZHRz
OiBpbXg3LWNvbGlicmk6IEFkZCB0b3VjaCBjb250cm9sbGVycw0KICBBUk06IGR0czogaW14NnFk
bC1jb2xpYnJpOiBhZGQgcGh5IHRvIGZlYw0KICBBUk06IGR0czogaW14NnFkbC1jb2xpYnJpOiBB
ZGQgbWlzc2luZyBwaW4gZGVjbGFyYXRpb24gaW4gaW9tdXhjDQogIEFSTTogZHRzOiBpbXg2cWRs
LWFwYWxpczogQWRkIHNsZWVwIHN0YXRlIHRvIGNhbiBpbnRlcmZhY2VzDQogIEFSTTogZHRzOiBp
bXg2OiBBZGQgdG91Y2hzY3JlZW5zIHVzZWQgb24gVG9yYWRleCBldmFsIGJvYXJkcw0KICBBUk06
IGR0czogaW14Ni1jb2xpYnJpOiBBZGQgbWlzc2luZyBwaW5tdXhpbmcgdG8gVG9yYWRleCBldmFs
IGJvYXJkDQogIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IEFkZCBzbGVlcCBtb2RlIHRvIGZl
Yw0KICBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBBZGQgd2F0Y2hkb2cNCiAgQVJNOiBkdHM6
IGlteDZ1bGwtY29saWJyaTogQWRkIGdlbmVyYWwgd2FrZXVwIGtleSB1c2VkIG9uIENvbGlicmkN
CiAgQVJNOiBkdHM6IGlteDYvNy1jb2xpYnJpOiBzd2l0Y2ggZHJfbW9kZSB0byBvdGcNCiAgQVJN
OiBkdHM6IGlteDZ1bGwtY29saWJyaTogQWRkIHRvdWNoc2NyZWVuIHVzZWQgd2l0aCBFdmFsIEJv
YXJkDQoNClN0ZWZhbiBBZ25lciAoMyk6DQogIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IGRpc2Fi
bGUgSFM0MDANCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogYWRkIEdQSU8gd2FrZXVwIGtleQ0K
ICBBUk06IGR0czogaW14Ny1jb2xpYnJpOiBmaXggMS44Vi9VSFMgc3VwcG9ydA0KDQogYXJjaC9h
cm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMgIHwgIDM5ICsrKysrKw0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0cyAgICAgICB8ICAxMyArKw0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS12MS4xLmR0cyB8ICAxMyArKw0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5kdHMgICAgICB8ICAxMyArKw0KIGFy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kgICAgICAgICB8ICAyNyArKysrLQ0K
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpICAgICAgICB8ICAyNyArKysr
LQ0KIC4uLi9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8ICA1MCAr
KysrKysrKw0KIC4uLi9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRzaSB8
ICAgMiArLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS13aWZpLmR0c2kgICB8
ICAgMiArLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS5kdHNpICAgICAgICB8
ICA1MiArKysrKysrLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0
c2kgICB8ICAzOCArKysrKysNCiBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSAg
ICAgICAgICAgfCAxMTQgKysrKysrKysrKysrKysrKy0tDQogMTIgZmlsZXMgY2hhbmdlZCwgMzY0
IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjIuMA0KDQo=
