Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29784C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3042206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 03:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfGaDDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 23:03:02 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:44731 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbfGaDDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:03:02 -0400
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 23:03:00 EDT
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 31 Jul 2019 03:02:58 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 31 Jul 2019 02:45:53 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 31 Jul 2019 02:45:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOg0yy8+JULczx+L/wgzuIIf8bEdcIjAStVRSgiKZfXM3X9kOHgoId3fQzDjTXqxJxiJ7wnKv5WiHG0tl9/dncOqg4gsK+0m0JHaiEETSa3+dzhhCtpb2BX+pfDaq+ttOIVZkxIHHgE1oM6mLHfPxjzod6jCstSJxOWvTJtzXYeq2RiRL+DPE7mFqzCHvg7hEvfgPeqyxNzVX6pBHu+Pvdoribl5jwuUHliEOCjTvSdwvcYnZx2KdyBWyVVn+o2pxmIZX9sfOFIkq/obxLjRSOuMKZ43YJp2J5InjB0wL0Sh0VudBIb+gJYJ+e0IJKnca+LiYgrUDeNzOiSD02tlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjKsPUyjcirra1gaaKssqEnEgBqJxYZy3f8SEQr2sfI=;
 b=NnnbYtv71odp/wDWi4a+mM3o4pQG/akgpP1kiXO/IN8DIZw7Li9H6gu84RESGrTCTFcZsRe/kCXYtguwMs2fHJawrIUVTymq5TTqhuO2l3wK4Zyi7rKYlXgCJfrtoeuO+FtMqPTWtxLj/e+S07RIMpwvkQSHltYL3r4XOdpxgZfqvBxH24IBNBCwJxsGXZ4XHuTs1Qr9imUEixT+nRq7SjBWs7ePmQe3dOI8xT5vXz14DksgcGDqOMF/xsT6JxULgHtNMVbb3BG5ti6A//IOWROthveMjodnGlh80ZB14gSMB8u9MPKJehJNUUHz1GE+STmbcqbs1IH8gxWdDsZxWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from CY4PR18MB1653.namprd18.prod.outlook.com (10.173.65.15) by
 CY4PR18MB1638.namprd18.prod.outlook.com (10.173.60.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 31 Jul 2019 02:45:51 +0000
Received: from CY4PR18MB1653.namprd18.prod.outlook.com
 ([fe80::6047:e37f:8f23:ea01]) by CY4PR18MB1653.namprd18.prod.outlook.com
 ([fe80::6047:e37f:8f23:ea01%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 02:45:51 +0000
From:   Al Cho <ACho@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5.3-rc2] Bluetooth: hci_uart: check for missing tty
 operations
Thread-Topic: [PATCH v5.3-rc2] Bluetooth: hci_uart: check for missing tty
 operations
Thread-Index: AQHVRrnuVrFk1jGsnU2Z72iVZ9P4FabkBp+A
Date:   Wed, 31 Jul 2019 02:45:51 +0000
Message-ID: <34aba865d86e104362e21a2f8b1116e864893859.camel@suse.com>
References: <20190730093345.25573-1-marcel@holtmann.org>
In-Reply-To: <20190730093345.25573-1-marcel@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0167.eurprd07.prod.outlook.com
 (2603:10a6:6:43::21) To CY4PR18MB1653.namprd18.prod.outlook.com
 (2603:10b6:903:14e::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=ACho@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81262c3d-a15f-4e7e-ceb4-08d7156132eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR18MB1638;
x-ms-traffictypediagnostic: CY4PR18MB1638:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR18MB16381D01CCCCBB84AC1FBE08A0DF0@CY4PR18MB1638.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(36756003)(110136005)(53936002)(52116002)(256004)(26005)(6246003)(14444005)(6306002)(76176011)(54906003)(476003)(229853002)(186003)(86362001)(6116002)(66066001)(486006)(2616005)(118296001)(3846002)(446003)(25786009)(2501003)(2906002)(11346002)(99286004)(305945005)(5660300002)(8676002)(64756008)(66556008)(6506007)(66446008)(6486002)(71200400001)(81166006)(68736007)(4326008)(66946007)(66476007)(6512007)(966005)(102836004)(8936002)(7736002)(6436002)(80792005)(14454004)(478600001)(316002)(71190400001)(386003)(81156014)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR18MB1638;H:CY4PR18MB1653.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZEblncdSTfCe51ZSYdjpPqGZHsMZrben0ieAper/McJQjP+wyXA+CDp7eRm4vQpLBcAoh7TGvH8q/BSoVly0IOjsiSQsBRrEjzZW6QhvL5M7Dipx4uRty4bZMels2eupfTbbQ6WfakUbcDndWTOE5bzztAlHfvnszA9u44pPjLkjhsgaukvO7iufYeRHB9L45bAbJieQ80H0iYrj53uz+fQPJgBF4ZHH4orwORgg+v72HPYtq7CIYA8SVUcU1mOZk0Da5KDa8YPSKWmfF5TSGzrwG7fFy2yboC8oYd3Mq9ulTbwTx6mf5+/Mz0M3MRUy5uRVuTAGfMq/3d+scG8SK5v7wqOUtfVSOux7lCzPotW2hDhNyjwK6MjGLax5kzBMsGRSbSl5edSbNqYe+maaBq3VcQU2vSYUhwC1mWyvNps=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE5F25C246523439FA9B4EB7E227CBF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81262c3d-a15f-4e7e-ceb4-08d7156132eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 02:45:51.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACho@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1638
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA3LTMwIGF0IDExOjMzICswMjAwLCBNYXJjZWwgSG9sdG1hbm4gd3JvdGU6
DQo+IEZyb206IFZsYWRpcyBEcm9ub3YgPHZkcm9ub3ZAcmVkaGF0LmNvbT4NCj4gDQo+IENlcnRh
aW4gdHR5cyBvcGVyYXRpb25zIChwdHlfdW5peDk4X29wcykgbGFjayB0aW9jbWdldCgpIGFuZA0K
PiB0aW9jbXNldCgpDQo+IGZ1bmN0aW9ucyB3aGljaCBhcmUgY2FsbGVkIGJ5IHRoZSBjZXJ0YWlu
IEhDSSBVQVJUIHByb3RvY29scw0KPiAoaGNpX2F0aCwNCj4gaGNpX2JjbSwgaGNpX2ludGVsLCBo
Y2lfbXJ2bCwgaGNpX3FjYSkgdmlhDQo+IGhjaV91YXJ0X3NldF9mbG93X2NvbnRyb2woKQ0KPiBv
ciBkaXJlY3RseS4gVGhpcyBsZWFkcyB0byBhbiBleGVjdXRpb24gYXQgTlVMTCBhbmQgY2FuIGJl
IHRyaWdnZXJlZA0KPiBieQ0KPiBhbiB1bnByaXZpbGVnZWQgdXNlci4gRml4IHRoaXMgYnkgYWRk
aW5nIGEgaGVscGVyIGZ1bmN0aW9uIGFuZCBhDQo+IGNoZWNrDQo+IGZvciB0aGUgbWlzc2luZyB0
dHkgb3BlcmF0aW9ucyBpbiB0aGUgcHJvdG9jb2xzIGNvZGUuDQo+IA0KPiBUaGlzIGZpeGVzIENW
RS0yMDE5LTEwMjA3LiBUaGUgRml4ZXM6IGxpbmVzIGxpc3QgY29tbWl0cyB3aGVyZSBjYWxscw0K
PiB0bw0KPiB0aW9jbVtnc11ldCgpIG9yIGhjaV91YXJ0X3NldF9mbG93X2NvbnRyb2woKSB3ZXJl
IGFkZGVkIHRvIHRoZSBIQ0kNCj4gVUFSVA0KPiBwcm90b2NvbHMuDQo+IA0KPiBMaW5rOiANCj4g
aHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2lkPTFiNDJmYWEyODQ4OTYzNTY0YTVi
MWI3ZjhjODM3ZWE3YjU1ZmZhNTANCj4gUmVwb3J0ZWQtYnk6IHN5emJvdCs3OTMzN2I1MDFkNmFh
OTc0ZDBmNkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnICMgdjIuNi4zNisNCj4gRml4ZXM6IGIzMTkwZGY2Mjg2MSAoIkJsdWV0b290aDogU3Vw
cG9ydCBmb3IgQXRoZXJvcyBBUjMwMHggc2VyaWFsDQo+IGNoaXAiKQ0KPiBGaXhlczogMTE4NjEy
ZmI5MTY1ICgiQmx1ZXRvb3RoOiBoY2lfYmNtOiBBZGQgc3VzcGVuZC9yZXN1bWUgUE0NCj4gZnVu
Y3Rpb25zIikNCj4gRml4ZXM6IGZmMjg5NTU5MmYwZiAoIkJsdWV0b290aDogaGNpX2ludGVsOiBB
ZGQgSW50ZWwgYmF1ZHJhdGUNCj4gY29uZmlndXJhdGlvbiBzdXBwb3J0IikNCj4gRml4ZXM6IDE2
MmY4MTJmMjNiYSAoIkJsdWV0b290aDogaGNpX3VhcnQ6IEFkZCBNYXJ2ZWxsIHN1cHBvcnQiKQ0K
PiBGaXhlczogZmE5YWQ4NzZiOGUwICgiQmx1ZXRvb3RoOiBoY2lfcWNhOiBBZGQgc3VwcG9ydCBm
b3IgUXVhbGNvbW0NCj4gQmx1ZXRvb3RoIGNoaXAgd2NuMzk5MCIpDQo+IFNpZ25lZC1vZmYtYnk6
IFZsYWRpcyBEcm9ub3YgPHZkcm9ub3ZAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFy
Y2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KDQpSZXZpZXdlZC1ieTogWXUtQ2hl
biwgQ2hvIDxhY2hvQHN1c2UuY29tPg0KVGVzdGVkLWJ5OiBZdS1DaGVuLCBDaG8gPGFjaG9Ac3Vz
ZS5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2JsdWV0b290aC9oY2lfYXRoLmMgICB8ICAzICsr
Kw0KPiAgZHJpdmVycy9ibHVldG9vdGgvaGNpX2JjbS5jICAgfCAgMyArKysNCj4gIGRyaXZlcnMv
Ymx1ZXRvb3RoL2hjaV9pbnRlbC5jIHwgIDMgKysrDQo+ICBkcml2ZXJzL2JsdWV0b290aC9oY2lf
bGRpc2MuYyB8IDEzICsrKysrKysrKysrKysNCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9tcnZs
LmMgIHwgIDMgKysrDQo+ICBkcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMgICB8ICAzICsrKw0K
PiAgZHJpdmVycy9ibHVldG9vdGgvaGNpX3VhcnQuaCAgfCAgMSArDQo+ICA3IGZpbGVzIGNoYW5n
ZWQsIDI5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290
aC9oY2lfYXRoLmMNCj4gYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYXRoLmMNCj4gaW5kZXggYTU1
YmUyMDViOTFhLi5kYmZlMzQ2NjQ2MzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2hjaV9hdGguYw0KPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYXRoLmMNCj4gQEAgLTk4
LDYgKzk4LDkgQEAgc3RhdGljIGludCBhdGhfb3BlbihzdHJ1Y3QgaGNpX3VhcnQgKmh1KQ0KPiAg
DQo+ICAJQlRfREJHKCJodSAlcCIsIGh1KTsNCj4gIA0KPiArCWlmICghaGNpX3VhcnRfaGFzX2Zs
b3dfY29udHJvbChodSkpDQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiAgCWF0aCA9
IGt6YWxsb2Moc2l6ZW9mKCphdGgpLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIWF0aCkNCj4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNt
LmMNCj4gYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtLmMNCj4gaW5kZXggODkwNWFkMmVkZGU3
Li5hZTI2MjRmY2U5MTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9iY20u
Yw0KPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfYmNtLmMNCj4gQEAgLTQwNiw2ICs0MDYs
OSBAQCBzdGF0aWMgaW50IGJjbV9vcGVuKHN0cnVjdCBoY2lfdWFydCAqaHUpDQo+ICANCj4gIAli
dF9kZXZfZGJnKGh1LT5oZGV2LCAiaHUgJXAiLCBodSk7DQo+ICANCj4gKwlpZiAoIWhjaV91YXJ0
X2hhc19mbG93X2NvbnRyb2woaHUpKQ0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsNCj4g
IAliY20gPSBremFsbG9jKHNpemVvZigqYmNtKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFiY20p
DQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
aGNpX2ludGVsLmMNCj4gYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfaW50ZWwuYw0KPiBpbmRleCAy
MDdiYWU1ZTBkNDYuLjMxZjI1MTUzMDg3ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibHVldG9v
dGgvaGNpX2ludGVsLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2ludGVsLmMNCj4g
QEAgLTM5MSw2ICszOTEsOSBAQCBzdGF0aWMgaW50IGludGVsX29wZW4oc3RydWN0IGhjaV91YXJ0
ICpodSkNCj4gIA0KPiAgCUJUX0RCRygiaHUgJXAiLCBodSk7DQo+ICANCj4gKwlpZiAoIWhjaV91
YXJ0X2hhc19mbG93X2NvbnRyb2woaHUpKQ0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsN
Cj4gIAlpbnRlbCA9IGt6YWxsb2Moc2l6ZW9mKCppbnRlbCksIEdGUF9LRVJORUwpOw0KPiAgCWlm
ICghaW50ZWwpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bHVldG9vdGgvaGNpX2xkaXNjLmMNCj4gYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfbGRpc2MuYw0K
PiBpbmRleCA4OTUwZTA3ODg5ZmUuLjg1YTMwZmI5MTc3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ibHVldG9vdGgvaGNpX2xkaXNjLmMNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xk
aXNjLmMNCj4gQEAgLTI5Miw2ICsyOTIsMTkgQEAgc3RhdGljIGludCBoY2lfdWFydF9zZW5kX2Zy
YW1lKHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiAgCXJl
dHVybiAwOw0KPiAgfQ0KPiAgDQo+ICsvKiBDaGVjayB0aGUgdW5kZXJseWluZyBkZXZpY2Ugb3Ig
dHR5IGhhcyBmbG93IGNvbnRyb2wgc3VwcG9ydCAqLw0KPiArYm9vbCBoY2lfdWFydF9oYXNfZmxv
d19jb250cm9sKHN0cnVjdCBoY2lfdWFydCAqaHUpDQo+ICt7DQo+ICsJLyogc2VyZGV2IG5vZGVz
IGNoZWNrIGlmIHRoZSBuZWVkZWQgb3BlcmF0aW9ucyBhcmUgcHJlc2VudCAqLw0KPiArCWlmICho
dS0+c2VyZGV2KQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCWlmIChodS0+dHR5LT5kcml2
ZXItPm9wcy0+dGlvY21nZXQgJiYgaHUtPnR0eS0+ZHJpdmVyLT5vcHMtDQo+ID50aW9jbXNldCkN
Cj4gKwkJcmV0dXJuIHRydWU7DQo+ICsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4g
IC8qIEZsb3cgY29udHJvbCBvciB1bi1mbG93IGNvbnRyb2wgdGhlIGRldmljZSAqLw0KPiAgdm9p
ZCBoY2lfdWFydF9zZXRfZmxvd19jb250cm9sKHN0cnVjdCBoY2lfdWFydCAqaHUsIGJvb2wgZW5h
YmxlKQ0KPiAgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvaGNpX21ydmwuYw0K
PiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9tcnZsLmMNCj4gaW5kZXggZjk4ZTVjYzM0M2IyLi5m
YmMzZjdjM2E1YzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9tcnZsLmMN
Cj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX21ydmwuYw0KPiBAQCAtNTksNiArNTksOSBA
QCBzdGF0aWMgaW50IG1ydmxfb3BlbihzdHJ1Y3QgaGNpX3VhcnQgKmh1KQ0KPiAgDQo+ICAJQlRf
REJHKCJodSAlcCIsIGh1KTsNCj4gIA0KPiArCWlmICghaGNpX3VhcnRfaGFzX2Zsb3dfY29udHJv
bChodSkpDQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiAgCW1ydmwgPSBremFsbG9j
KHNpemVvZigqbXJ2bCksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghbXJ2bCkNCj4gIAkJcmV0dXJu
IC1FTk9NRU07DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMNCj4g
Yi9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMNCj4gaW5kZXggOWE1YzljMWY5NDg0Li44MmEw
YTM2OTFhNjMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9xY2EuYw0KPiAr
KysgYi9kcml2ZXJzL2JsdWV0b290aC9oY2lfcWNhLmMNCj4gQEAgLTQ3Myw2ICs0NzMsOSBAQCBz
dGF0aWMgaW50IHFjYV9vcGVuKHN0cnVjdCBoY2lfdWFydCAqaHUpDQo+ICANCj4gIAlCVF9EQkco
Imh1ICVwIHFjYV9vcGVuIiwgaHUpOw0KPiAgDQo+ICsJaWYgKCFoY2lfdWFydF9oYXNfZmxvd19j
b250cm9sKGh1KSkNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArDQo+ICAJcWNhID0ga3ph
bGxvYyhzaXplb2Yoc3RydWN0IHFjYV9kYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFxY2Ep
DQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
aGNpX3VhcnQuaA0KPiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV91YXJ0LmgNCj4gaW5kZXggZjEx
YWYzOTEyY2U2Li42YWI2MzExMDEwMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3Ro
L2hjaV91YXJ0LmgNCj4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX3VhcnQuaA0KPiBAQCAt
MTA0LDYgKzEwNCw3IEBAIGludCBoY2lfdWFydF93YWl0X3VudGlsX3NlbnQoc3RydWN0IGhjaV91
YXJ0DQo+ICpodSk7DQo+ICBpbnQgaGNpX3VhcnRfaW5pdF9yZWFkeShzdHJ1Y3QgaGNpX3VhcnQg
Kmh1KTsNCj4gIHZvaWQgaGNpX3VhcnRfaW5pdF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29y
ayk7DQo+ICB2b2lkIGhjaV91YXJ0X3NldF9iYXVkcmF0ZShzdHJ1Y3QgaGNpX3VhcnQgKmh1LCB1
bnNpZ25lZCBpbnQgc3BlZWQpOw0KPiArYm9vbCBoY2lfdWFydF9oYXNfZmxvd19jb250cm9sKHN0
cnVjdCBoY2lfdWFydCAqaHUpOw0KPiAgdm9pZCBoY2lfdWFydF9zZXRfZmxvd19jb250cm9sKHN0
cnVjdCBoY2lfdWFydCAqaHUsIGJvb2wgZW5hYmxlKTsNCj4gIHZvaWQgaGNpX3VhcnRfc2V0X3Nw
ZWVkcyhzdHJ1Y3QgaGNpX3VhcnQgKmh1LCB1bnNpZ25lZCBpbnQNCj4gaW5pdF9zcGVlZCwNCj4g
IAkJCSB1bnNpZ25lZCBpbnQgb3Blcl9zcGVlZCk7DQoNCg==
