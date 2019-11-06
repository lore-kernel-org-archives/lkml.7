Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B50C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DCB2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mfaBymZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfKFMsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:48:54 -0500
Received: from mail-eopbgr790087.outbound.protection.outlook.com ([40.107.79.87]:41568
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727652AbfKFMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:48:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaExPfdbMe4Gv/sLmYJkrKW+4Ub4se9SdkR42zW3S9RVKPPEvJKLg97FYPANicBYsjfp3QIK1ldo35EIKcgSqxIgg7MeJZmCy3whVyCcqUuHxIMuex5eFR1dDMZNF475RsUOVcx64vgEdPSnGAa9LMWDKa7bdZwV01iS2cMi7p+BkPDIAjA7PCEIdavsdYRE1TU4DR0vFez/g2mPMR9W897IVS2L+yIrnPb2BHheFCXmPR/m+Z4CCx8uuf5PV5I60t8rL9tANZOUjCweODhTmELbg6lsZE3hLITp20Pr09ZrISpNT2KTESr9k5Ldmwn+oFzI/0oh7uvBzEF4qmFOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od8KBj3MzNk3Ucv4kkjbKzDw9ggfyKz7b5isW0xbpOI=;
 b=I8X21e0eT/0Ad+BkCnE4mEg6QSCHuEBUw90GT+CGHb1nAUTH5MTWJLy3146hElVW9td2sAKBsLbHYId+ZMXgdhAvg6Oo3ha9ZoYj5JcvwwpinNXrweC2uWqQb/4KimXNmiXAYwLIqIgZ0WZtdYvhLaTbPFLv0164pNwnK1rrIRUxRkUigrSnFFF8fPuLij3158Kyk/xe/giFWyB/5qe9iHQy5Elmg6Sf9rTHFHs3Q7qP7QrX7GK1J3q6z1xvUY9LcTjxz9ODjd+l9/cslP3UcogNMRcO98/aRgXNQUGEB20JdwLuecX6h0X62ljVTZ6orYJgx3uJ3W1v2+2si2by7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od8KBj3MzNk3Ucv4kkjbKzDw9ggfyKz7b5isW0xbpOI=;
 b=mfaBymZFPT1gwv+z0pnUlQQe4AqnoI6S76popyQh5ywLszPRqSlNifjEGvLDwdC/Y28yZNHhAhePZzv6tZRxA8+V9m8op2WbIgDWRJHqKN/jiC4B4bP9/MfWK5qemLzjeNfvm9FO25LDBcgdR9oQPxSJw9T6IQW+/AnT+FP5imc=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1436.namprd12.prod.outlook.com (10.168.239.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 12:48:50 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 12:48:50 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Pan Bian <bianpan2016@163.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix double reference dropping
Thread-Topic: [PATCH v2] drm/amdgpu: fix double reference dropping
Thread-Index: AQHVlJZhAqqXd9EDSE2RM2o2stZmZKd+F92A
Date:   Wed, 6 Nov 2019 12:48:50 +0000
Message-ID: <a3b2cc0c-2c0a-fcae-3750-9e51da46b872@amd.com>
References: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM3PR05CA0118.eurprd05.prod.outlook.com
 (2603:10a6:207:2::20) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7b48a8f-c1d2-4562-b3df-08d762b7abac
x-ms-traffictypediagnostic: DM5PR12MB1436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1436A1278849A6A90D3C89F483790@DM5PR12MB1436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(6116002)(6486002)(5660300002)(6512007)(6246003)(66946007)(446003)(31696002)(2616005)(11346002)(102836004)(71190400001)(256004)(71200400001)(486006)(186003)(7736002)(65806001)(65956001)(305945005)(54906003)(476003)(229853002)(6436002)(31686004)(110136005)(4326008)(46003)(316002)(66556008)(76176011)(86362001)(64756008)(36756003)(386003)(8936002)(58126008)(81166006)(6506007)(25786009)(99286004)(81156014)(2906002)(52116002)(8676002)(66446008)(478600001)(66476007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1436;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E65KMsfz4LyVjzme1dglLeZHCzT3Igex9GCrkXi3bykciRzi32ZYb8ssbrbpSCAeyQR77suz2JQGJ6aAe6zbermsBwx+cRiEMDayEJ2MX5LMJlFZ2VOMIHYxp6PN66KGOgKQSxJ37Cm/A04leOgAFRz9nivBlOxNp6dgrG7ydvE6XDCGDBoArOeeXZOs1VUENqe6Welab8Dz/7QXdyBCOw3FPZs5ljv8Jy+43zJ5LjWYHfCsyg/VaEkVV5PW31JSJoGlVuaZJ3o3WykcxmmdC814qF3QNGn9PBwAzSqXXNBjmyiOQnePsT/Ri6vZm+Gbm0ERvw/B4RAQFEu/2JVxt4oJf/4PuojSEIiX7xBPXhf3TKlz69uQTSTjen1M88/dM2mJKfBXrg0RUgaETdcby7+SW7ne0jPSR1WrFGRIr+kIEFYAABu8uorQRrRK135L
Content-Type: text/plain; charset="utf-8"
Content-ID: <026E5862D456C941BCB66D0A9CA1C5BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b48a8f-c1d2-4562-b3df-08d762b7abac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 12:48:50.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4wkmag1mQkFH0MpF1F8gFn91tvjrq3X3UkNT4NrovNJT8JpeetPVa5L0lIjlqYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDYuMTEuMTkgdW0gMTI6MzUgc2NocmllYiBQYW4gQmlhbjoNCj4gVGhlIHJlZmVyZW5jZSB0
byBvYmplY3QgZmVuY2UgaXMgZHJvcHBlZCBhdCB0aGUgZW5kIG9mIHRoZSBsb29wLg0KPiBIb3dl
dmVyLCBpdCBpcyBkcm9wcGVkIGFnYWluIG91dHNpZGUgdGhlIGxvb3AuIFRoZSByZWZlcmVuY2Ug
Y2FuIGJlDQo+IGRyb3BwZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgY2FsbGluZyBkbWFfZmVuY2Vfd2Fp
dCgpIGluIHRoZSBsb29wIGFuZA0KPiB0aHVzIHRoZSBkcm9wcGluZyBvcGVyYXRpb24gb3V0c2lk
ZSB0aGUgbG9vcCBjYW4gYmUgcmVtb3ZlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogUGFuIEJpYW4g
PGJpYW5wYW4yMDE2QDE2My5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+IHYyOiBmaXggdGhlIGJ1ZyBpbiBh
IG1vcmUgY29uY2lzZSB3YXkNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2JlbmNobWFyay5jIHwgNiArKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2JlbmNobWFyay5jDQo+IGluZGV4IDY0OWU2OGM0NDc5Yi4uZDE0OTVlMWM5
Mjg5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVu
Y2htYXJrLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNo
bWFyay5jDQo+IEBAIC0zMyw3ICszMyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2JlbmNobWFya19k
b19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBzaXplLA0KPiAgIHsN
Cj4gICAJdW5zaWduZWQgbG9uZyBzdGFydF9qaWZmaWVzOw0KPiAgIAl1bnNpZ25lZCBsb25nIGVu
ZF9qaWZmaWVzOw0KPiAtCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsNCj4gKwlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCj4gICAJaW50IGksIHI7DQo+ICAgDQo+ICAgCXN0YXJ0X2pp
ZmZpZXMgPSBqaWZmaWVzOw0KPiBAQCAtNDQsMTYgKzQ0LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2JlbmNobWFya19kb19tb3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBz
aXplLA0KPiAgIAkJaWYgKHIpDQo+ICAgCQkJZ290byBleGl0X2RvX21vdmU7DQo+ICAgCQlyID0g
ZG1hX2ZlbmNlX3dhaXQoZmVuY2UsIGZhbHNlKTsNCj4gKwkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7
DQo+ICAgCQlpZiAocikNCj4gICAJCQlnb3RvIGV4aXRfZG9fbW92ZTsNCj4gLQkJZG1hX2ZlbmNl
X3B1dChmZW5jZSk7DQo+ICAgCX0NCj4gICAJZW5kX2ppZmZpZXMgPSBqaWZmaWVzOw0KPiAgIAly
ID0gamlmZmllc190b19tc2VjcyhlbmRfamlmZmllcyAtIHN0YXJ0X2ppZmZpZXMpOw0KPiAgIA0K
PiAgIGV4aXRfZG9fbW92ZToNCj4gLQlpZiAoZmVuY2UpDQo+IC0JCWRtYV9mZW5jZV9wdXQoZmVu
Y2UpOw0KPiAgIAlyZXR1cm4gcjsNCj4gICB9DQo+ICAgDQoNCg==
