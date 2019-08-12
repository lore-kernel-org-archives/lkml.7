Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132CEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C4320679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ROZShZGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfHLOVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:23 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:32224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbfHLOVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kepTLSFJ7N1dfmjVyA4f4VOMi8L4iUWrFxivsdMMxyQ2BY0TMw1wvY/MaAtum4ogAm7xS5lh4zEt7lMicLkTbZPdYrD+64if/SIXQwhIPOwoVm7IIlDDosfrtBn3Du/z1VV5XyMsZm17AUAZQmTLejLWcTBmuNFizYBhN7xW+0mwvrykIP2D4UDqo44+aSmakQxlQD2DqysfzjWPS+5F7WAErscL5YQGQV+CQOZEjq0G029la/wz/0N6ujadSPw+kdx2VV9KNjB2jAu/c/NIUKHRYbSBPZdPFkqpkH3wHToGNXEHoBTLz6ljfBOe7xzQbRk/qOrgbDvD94GZ1beuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mETswcJj2nioSqBApmx2JlF8Kg95tOlSieLqPldEsY=;
 b=JKpn3YqMaDXLfuSpNjcxuutDM88/GoVtYfYLtniOVvZzYtXL9VpoRiDiB1iWFmKOu2tPgFiW/ukKO63Id6Ij8DAZ/FVI+6Ib1IISq/xyvJw2odwdosflF6nbs42v3gGUOf68Ay9QlcYeqiBLjMo5brDNZaCEanfp3OBvtomEyKvsb+7Y7ApvBaaKHCPOvUSaHioVkvBzA4OPUs/fDCkmsOkCivs11Dv2pkmhhpD1JyRkxr7K/SBMkNWC6dxPlHLfMNZqCOGzt2z/W5Ghye/i7pAfD664/KHKpW0XDhFZj/OZokarzHoxHpZYo7nn9tfQBmVbgZJgmWY/fl8immNo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mETswcJj2nioSqBApmx2JlF8Kg95tOlSieLqPldEsY=;
 b=ROZShZGvOGC9egkfrbVph0W8O+HmiQyUSqjFwEz73f01UIDkmCxxSTosXV54de1HhOsGHnH2+dGjwq/Ni9Mv9T3Jddvdgfj7E15vOdbAZRWAZ5ym6Hvlq6mWkogXXSGbUSYbe9i6CfB0lu4O0SAvHJbaA33hh/vDAPFOK8NrFK8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:14 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:14 +0000
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
Subject: [PATCH v4 00/21] Common patches from downstream development
Thread-Topic: [PATCH v4 00/21] Common patches from downstream development
Thread-Index: AQHVURkykJ0hhEX+N0Cb4D81EmyxUA==
Date:   Mon, 12 Aug 2019 14:21:14 +0000
Message-ID: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceebd0f5-01e5-489e-d77d-08d71f305551
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942EC902E63A64EF421844BF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(561944003)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(476003)(2616005)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3+dDpIEbfBGXosI9nEtv78TLNfa3tnfYsDbA0MUzsMon/M3TnahUWXVunh4kd8O84gw7dp0oCejAit862kk1GTA7xr7iQ9T+aIpdPpKJgtQoVz1b7aV67h1d203b3mawbPLxcnphctqmX4Z3esMDkaWEDesSAvq3ER2x4b9Sd66IHWlTAeSn/An1F5U6Hv4zsbj9I73Z8aErBKylRUvT2WgX7feuMgkbdpPY2XjfaGSXzONWKji1heOp4er5ceYRorm554kNhv19Im+1YKEv/JA/ro7eS8eM2DAB6pnh35xAuzGISWH/4AcunluDs2bFU7eZnzJL11Qka844tt8GLVSri/lOsbr/9/T3Ko179XaM7HOccllNblPCxfujSQ0rQxyzlVqQBoaf9KROmc6kGNj+FHcI+JbLiK7wjdF/TPA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E326AA5A3EF414E96F3C86703355650@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceebd0f5-01e5-489e-d77d-08d71f305551
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:14.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCyKH43qFdfBaLf08h4a4O5T40yHUNXlnEHvq05lEpR6j82rYG6R2L4M0KXOXaAvdXr2230V6mABBPuOz1BKkAZEsf4JdxOd/sjTRI+GoQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGhvbGRzIHNvbWUgY29tbW9uIGNoYW5nZXMgdGhhdCB3ZXJlIG5ldmVy
IHVwc3RyZWFtZWQuDQpXaXRoIGxhdGVzdCBkb3duc3RyZWFtIGtlcm5lbCB1cGdyYWRlLCBJIHRv
b2sgdGhlIGFwcm9hY2ggdG8gc2VsZWN0DQptYWlubGluZSBkZXZpY2V0cmVlcyBhbmQgYXRvbWlj
YWxseSBhZGQgbWlzc2luZyBzdHVmZiBmb3IgZG93bnN0cmVhbS4NCg0KVGhlc2UgcGF0Y2hlcyBJ
IHNlbmQgaGVyZSBhcmUgc2VwYXJhdGVkIG91dCB3aXRoIGNoYW5nZXMgdGhhdCBhbHNvDQpoYXZl
IGEgYmVuZml0IGZvciBtYWlubGluZS4NCg0KUGhpbGlwcGUNCg0KQ2hhbmdlcyBpbiB2NDoNCi0g
QWRkZWQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQotIEFkZGVkIE1hcmNlbCBaaXN3aWxlcidzIEFj
aw0KLSBNYWtlIHNjbC1ncGlvcyBhbmQgc2RhLWdwaW9zIChHUElPX0FDVElWRV9ISUdIIHwgR1BJ
T19PUEVOX0RSQUlOKQ0KLSBDaGFuZ2UgY29tbWl0IHRpdGxlIHRvIE1pY2hhbCdzIHN1Z2dlc3Rp
b24NCi0gQWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0KLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3Mg
QWNrDQotIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBBY2sNCi0gQWRkIE1hcmNlbCBaaXN3aWxlcidz
IEFjaw0KLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQotIEFkZCBNYXJjZWwgWmlzd2lsZXIn
cyBBY2sNCi0gQWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0KLSBBZGQgTWFyY2VsIFppc3dpbGVy
J3MgQWNrDQotIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBBY2sNCi0gQWRkIE1hcmNlbCBaaXN3aWxl
cidzIEFjaw0KLSBBZGQgTWFyY2VsIFppc3dpbGVyJ3MgQWNrDQotIE1vdmUgY2FuIG5vZGVzIHRv
IG1vZHVsZSBkZXZpY2V0ZXJlZSBpbmNsdWRlIGlteDZ1bGwtY29saWJyaS5kdHNpDQotIEFkZCBN
YXJjZWwgWmlzd2lsZXIncyBBY2sNCi0gTmV3IHBhdGNoIGFzIG9mIHRoZSByZWNvbW1lbmRhdGlv
biBmcm9tIE1hcmNlbCBvbiBNTA0KDQpDaGFuZ2VzIGluIHYzOg0KLSBBZGQgbmV3IGNvbW1pdCBt
ZXNzYWdlIGZyb20gU3RlZmFuJ3MgcHJvcG9zYWwgb24gTUwNCi0gRml4IGNvbW1pdCBtZXNzYWdl
DQotIEZpeCBjb21taXQgdGl0bGUgdG8gIi4uLmlteDYtYXBhbGlzOi4uLiINCi0gTmV3IHBhdGNo
IHRvIG1ha2UgdXNlIG9mIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IGZpeCAxLjhWL1VIUyBzdXBw
b3J0DQoNCkNoYW5nZXMgaW4gdjI6DQotIERlbGV0ZWQgdG91Y2hyZXZvbHV0aW9uIGRvd25zdHJl
YW0gc3R1ZmYNCi0gVXNlIGdlbmVyaWMgbm9kZSBuYW1lDQotIEJldHRlciBjb21tZW50DQotIENo
YW5nZWQgY29tbWl0IHRpdGxlIHRvICcuLi5pbXg2cWRsLWFwYWxpczouLi4nDQotIERlbGV0ZWQg
dG91Y2hyZXZvbHV0aW9uIGRvd25zdHJlYW0gc3R1ZmYNCi0gVXNlIGdlbmVyaWMgbm9kZSBuYW1l
DQotIFB1dCBhIGJldHRlciBjb21tZW50IGluIHRoZXJlDQotIENvbW1pdCB0aXRsZQ0KLSBSZW1v
dmVkIGYwNzEwYSwgdGhhdCBpcyBkb3duc3RyZWFtIG9ubHkNCi0gQ2hhbmdlZCB0byBnZW5lcmlj
IG5vZGUgbmFtZQ0KLSBCZXR0ZXIgY29tbWVudA0KDQpJZ29yIE9wYW5pdWsgKDEpOg0KICBBUk06
IGR0czogaW14NnFkbC1jb2xpYnJpLmR0c2k6IFVIUy1JIHN1cHBvcnQgZm9yIHYxLjFhIGh3DQoN
Ck1hcmNlbCBaaXN3aWxlciAoMSk6DQogIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IG1ha2Ugc3Vy
ZSBtb2R1bGUgc3VwcGxpZXMgYXJlIGFsd2F5cyBvbg0KDQpNYXggS3J1bW1lbmFjaGVyICgyKToN
CiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogcmVkdWNlIHZfYmF0dCBjdXJyZW50IGluIHBv
d2VyIG9mZg0KICBBUk06IGR0czogaW14NnVsbDogaW1wcm92ZSBjYW4gdGVtcGxhdGVzDQoNCk9s
ZWtzYW5kciBTdXZvcm92ICgxKToNCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogYWRkIHJlY292
ZXJ5IGZvciBJMkMgZm9yIGlNWDcNCg0KUGhpbGlwcGUgU2NoZW5rZXIgKDEzKToNCiAgQVJNOiBk
dHM6IGlteDctY29saWJyaTogcHJlcGFyZSBtb2R1bGUgZGV2aWNlIHRyZWUgZm9yIEZsZXhDQU4N
CiAgQVJNOiBkdHM6IGlteDctY29saWJyaTogQWRkIHNsZWVwIG1vZGUgdG8gZXRoZXJuZXQNCiAg
QVJNOiBkdHM6IGlteDctY29saWJyaTogQWRkIHRvdWNoIGNvbnRyb2xsZXJzDQogIEFSTTogZHRz
OiBpbXg2cWRsLWNvbGlicmk6IGFkZCBwaHkgdG8gZmVjDQogIEFSTTogZHRzOiBpbXg2cWRsLWNv
bGlicmk6IEFkZCBtaXNzaW5nIHBpbiBkZWNsYXJhdGlvbiBpbiBpb211eGMNCiAgQVJNOiBkdHM6
IGlteDZxZGwtYXBhbGlzOiBBZGQgc2xlZXAgc3RhdGUgdG8gY2FuIGludGVyZmFjZXMNCiAgQVJN
OiBkdHM6IGlteDYtYXBhbGlzOiBBZGQgdG91Y2hzY3JlZW5zIHVzZWQgb24gVG9yYWRleCBldmFs
IGJvYXJkcw0KICBBUk06IGR0czogaW14Ni1jb2xpYnJpOiBBZGQgbWlzc2luZyBwaW5tdXhpbmcg
dG8gVG9yYWRleCBldmFsIGJvYXJkDQogIEFSTTogZHRzOiBpbXg2dWxsLWNvbGlicmk6IEFkZCBz
bGVlcCBtb2RlIHRvIGZlYw0KICBBUk06IGR0czogaW14NnVsbC1jb2xpYnJpOiBBZGQgd2F0Y2hk
b2cNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogQWRkIGdlbmVyYWwgd2FrZXVwIGtleSB1
c2VkIG9uIENvbGlicmkNCiAgQVJNOiBkdHM6IGlteDZ1bGwtY29saWJyaTogQWRkIHRvdWNoc2Ny
ZWVuIHVzZWQgd2l0aCBFdmFsIEJvYXJkDQogIEFSTTogZHRzOiBpbXg3LWNvbGlicmk6IEFkZCBV
SFMgc3VwcG9ydCB0byBldmFsIGJvYXJkDQoNClN0ZWZhbiBBZ25lciAoMyk6DQogIEFSTTogZHRz
OiBpbXg3LWNvbGlicmk6IGRpc2FibGUgSFM0MDANCiAgQVJNOiBkdHM6IGlteDctY29saWJyaTog
YWRkIEdQSU8gd2FrZXVwIGtleQ0KICBBUk06IGR0czogaW14Ny1jb2xpYnJpOiBmaXggMS44Vi9V
SFMgc3VwcG9ydA0KDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5k
dHMgIHwgIDM5ICsrKysrKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0
cyAgICAgICB8ICAxMyArKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS12
MS4xLmR0cyB8ICAxMyArKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5k
dHMgICAgICB8ICAxMyArKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kg
ICAgICAgICB8ICAyNyArKysrLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5k
dHNpICAgICAgICB8ICA2OCArKysrKysrKysrLQ0KIC4uLi9hcm0vYm9vdC9kdHMvaW14NnVsbC1j
b2xpYnJpLWV2YWwtdjMuZHRzaSB8ICAzOCArKysrKysNCiAuLi4vYXJtL2Jvb3QvZHRzL2lteDZ1
bGwtY29saWJyaS1ub253aWZpLmR0c2kgfCAgIDIgKy0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWxsLWNvbGlicmktd2lmaS5kdHNpICAgfCAgIDIgKy0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWxsLWNvbGlicmkuZHRzaSAgICAgICAgfCAgNjQgKysrKysrKysrLQ0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kgICB8ICA0OSArKysrKysrLQ0KIGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpICAgICAgICAgICB8IDExMiArKysrKysrKysrKysr
KysrLS0NCiAxMiBmaWxlcyBjaGFuZ2VkLCA0MTAgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi4yMi4wDQoNCg==
