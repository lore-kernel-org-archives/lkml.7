Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC07C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B021479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Dm0+vC4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfETNuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:50:14 -0400
Received: from mail-eopbgr760053.outbound.protection.outlook.com ([40.107.76.53]:59971
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731680AbfETNuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhHkYTpBK3+lU7Fk+rIuWDJwzh0ps9k52SW4uzjDH6I=;
 b=Dm0+vC4GK+GhGY80/qFfB5bC5HIaazvDQITgNSFAcTxNLybBQWJIhW1wS62JxeTybZ5mDWo5ZnwH/kb2jbitgBl857IR42+hOQVmwcVM3bHKp10cW9rWBauysCBoAINl9qeVfU1EIka0sPZe1qx9rG7Xe1XT5pvPLuSwM68dbS8=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6702.namprd05.prod.outlook.com (20.178.247.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.10; Mon, 20 May 2019 13:50:03 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::c19e:e8f8:b151:9ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::c19e:e8f8:b151:9ad%6]) with mapi id 15.20.1922.011; Mon, 20 May 2019
 13:50:03 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "murray.mcallister@gmail.com" <murray.mcallister@gmail.com>
CC:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH] drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader()
 leading to an invalid read
Thread-Topic: [PATCH] drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader()
 leading to an invalid read
Thread-Index: AQHVDvKlN/fpmZU6PEeeQapES7AzUqZ0B/IA
Date:   Mon, 20 May 2019 13:50:03 +0000
Message-ID: <03eb2b3900505c7aba39846b533abb04f9e5682c.camel@vmware.com>
References: <20190520095734.4655-1-murray.mcallister@gmail.com>
In-Reply-To: <20190520095734.4655-1-murray.mcallister@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c206fb-ebe7-4d8a-e19a-08d6dd2a0f7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6702;
x-ms-traffictypediagnostic: MN2PR05MB6702:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB670280D229C7C55A17967790A1060@MN2PR05MB6702.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(68736007)(256004)(1361003)(76176011)(14444005)(2351001)(102836004)(53936002)(6246003)(71200400001)(71190400001)(229853002)(316002)(6486002)(25786009)(6512007)(6436002)(5640700003)(64756008)(86362001)(66556008)(4326008)(6506007)(118296001)(7736002)(5660300002)(76116006)(54906003)(26005)(73956011)(186003)(91956017)(305945005)(66476007)(2906002)(6916009)(14454004)(66946007)(99286004)(36756003)(81166006)(81156014)(6116002)(8676002)(486006)(3846002)(446003)(11346002)(2616005)(478600001)(476003)(66066001)(8936002)(2501003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6702;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d6XXuCRag6W2IlwFhAFwSkL4znGFoTakvnhiixee9BG4cHyW41dvMwi709lg8xMavmYcsxfF6pxr7Zr9TECAFzwm6XFkJaMv1PeXzCS8bMAe9+08ox1Up1ifA5yR5mT6T4LcsPAw7Q4V8R92GqUGWON9oUDieKPZirf6KorCYWH5rJWR1BzjdPtIIZtClykd4KQYErG7Xtf7qYKdMil3QnA0ufKBs9eUtCGriJgX0IJpcbdFwXAa9pvrLpfILdgtbZ22I5LnRlerKCcQvX3mIzRpqz2eTaVcRQ5wJtfi3kWyndoRDL7VbwaoFc2xPgMCZNTDlYtAc/iTNhPh0agfa8onILyDh0VXQtqkEY+hFPzD/LXaUax5hvIToTFgpk2fnEPg903FkjWGr0auKFJ0MIQ7IsLgbK+HKgRmOXsaw3o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E31CDD1807F34981146390CAAE5CFE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c206fb-ebe7-4d8a-e19a-08d6dd2a0f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 13:50:03.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thellstrom@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLCBNdXJyYXksDQoNCkknbGwgaW5jbHVkZSBpbiB0aGUgbmV4dCB2bXdnZngtZml4ZXMg
cHVsbCByZXF1ZXN0Lg0KDQpPbiBNb24sIDIwMTktMDUtMjAgYXQgMjE6NTcgKzEyMDAsIE11cnJh
eSBNY0FsbGlzdGVyIHdyb3RlOg0KPiBJZiBTVkdBXzNEX0NNRF9EWF9TRVRfU0hBREVSIGlzIGNh
bGxlZCB3aXRoIGEgc2hhZGVyIElEDQo+IG9mIFNWR0EzRF9JTlZBTElEX0lELCBhbmQgYSBzaGFk
ZXIgdHlwZSBvZg0KPiBTVkdBM0RfU0hBREVSVFlQRV9JTlZBTElELCB0aGUgY2FsY3VsYXRlZCBi
aW5kaW5nLnNoYWRlcl9zbG90DQo+IHdpbGwgYmUgNDI5NDk2NzI5NSwgbGVhZGluZyB0byBhbiBv
dXQtb2YtYm91bmRzIHJlYWQgaW4NCj4gdm13X2JpbmRpbmdfbG9jKCkNCj4gd2hlbiB0aGUgb2Zm
c2V0IGlzIGNhbGN1bGF0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNdXJyYXkgTWNBbGxpc3Rl
ciA8bXVycmF5Lm1jYWxsaXN0ZXJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS92bXdnZngvdm13Z2Z4X2V4ZWNidWYuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3Ztd2dmeC92bXdnZnhfZXhlY2J1Zi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfZXhlY2J1Zi5jDQo+IGluZGV4IDJmZjdiYTA0ZDhjOC4uOWFlYjU0NDhjZmMxIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9leGVjYnVmLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZXhlY2J1Zi5jDQo+IEBAIC0yMTkz
LDcgKzIxOTMsOCBAQCBzdGF0aWMgaW50IHZtd19jbWRfZHhfc2V0X3NoYWRlcihzdHJ1Y3QNCj4g
dm13X3ByaXZhdGUgKmRldl9wcml2LA0KPiAgDQo+ICAJY21kID0gY29udGFpbmVyX29mKGhlYWRl
ciwgdHlwZW9mKCpjbWQpLCBoZWFkZXIpOw0KPiAgDQo+IC0JaWYgKGNtZC0+Ym9keS50eXBlID49
IFNWR0EzRF9TSEFERVJUWVBFX0RYMTBfTUFYKSB7DQo+ICsJaWYgKGNtZC0+Ym9keS50eXBlID49
IFNWR0EzRF9TSEFERVJUWVBFX0RYMTBfTUFYIHx8DQo+ICsJICAgIGNtZC0+Ym9keS50eXBlIDwg
U1ZHQTNEX1NIQURFUlRZUEVfTUlOKSB7DQo+ICAJCVZNV19ERUJVR19VU0VSKCJJbGxlZ2FsIHNo
YWRlciB0eXBlICV1LlxuIiwNCj4gIAkJCSAgICAgICAodW5zaWduZWQgaW50KSBjbWQtPmJvZHku
dHlwZSk7DQo+ICAJCXJldHVybiAtRUlOVkFMOw0K
