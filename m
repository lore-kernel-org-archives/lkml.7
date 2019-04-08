Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9981820857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HHoiIeQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDHUFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:05:52 -0400
Received: from mail-eopbgr810081.outbound.protection.outlook.com ([40.107.81.81]:28736
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfDHUFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sKqEH2JecqxziU9ZKJL0jPd5FIwVqm4apVu23/eG8w=;
 b=HHoiIeQuPPmHjSH1FnOfZelb7Zf0+XmuzGPaDaEaXxkx53VbvJYhsOmRuu8K7n5zFdceBixxNVROmjBlFvdSmiFaYW0xHbGH2L2fRnAQ4o/FAzXsO8aehTyqKXiV6b05LHm5+D6m9Mu98YyLXZAPpbHKIdKVueqsMcmUmdX6gLw=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6032.namprd05.prod.outlook.com (20.178.242.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.7; Mon, 8 Apr 2019 20:05:49 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Mon, 8 Apr 2019
 20:05:49 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Thread-Topic: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Thread-Index: AQHU7fmiB6y8RJSDbkO+jrn2WRu5saYysPWA
Date:   Mon, 8 Apr 2019 20:05:48 +0000
Message-ID: <88c0cd21b11a385b3b0130715a25673b71b57112.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
         <20190408105525.5493-2-hch@lst.de>
In-Reply-To: <20190408105525.5493-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8fd10e1-15ef-4af7-d454-08d6bc5d982e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6032;
x-ms-traffictypediagnostic: MN2PR05MB6032:
x-microsoft-antispam-prvs: <MN2PR05MB6032B2AFB0B00285DC8E4FDAA12C0@MN2PR05MB6032.namprd05.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8936002)(305945005)(316002)(54906003)(53936002)(105586002)(8676002)(110136005)(6246003)(118296001)(186003)(86362001)(76176011)(446003)(25786009)(81166006)(81156014)(256004)(2906002)(99286004)(106356001)(6512007)(66066001)(11346002)(6436002)(26005)(486006)(476003)(68736007)(6486002)(7736002)(2616005)(6116002)(478600001)(71190400001)(71200400001)(6506007)(229853002)(36756003)(14454004)(5660300002)(97736004)(102836004)(2501003)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6032;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kTuLcrh+rGjNpnfXCadAgpZkqf9vCamIfeBPZwMaN3GMIt2qrL8D5TaeG1FfcvkM1Ar9VCxCru43HomUuxmxBWRvMAvpLO4nzeyJasnvVrjIZGkIKIspKFDg0ASUJfcPYI1BdwVY1/5JLcmWXFYn9k94xNt+U00QKDbuhQoGTqo3+6JE2OBq6Ocybsantbi3/yeQqF2bkobZPKGaESTgd5I7dDp4cetIiUUN+NvP8p3/lveF3eAt2fsDuFQliFNAE3bFkE3BtKT9FTugqfW+uNLKuWDrs1lpH0CwOD7NiRKQCz9A4gXbEKCrgtCTYUMLBxPxV/06vvQlXvsJjbR18/+Q+dIlTH9CQX7n75Wr7tYKI6rCJ/g5iSxWd27xoBG6xOjPoW7VDaxO0HVhnmRkYUcO/2U2t6aYg/m0kiEX5tI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0151265B32F40043B252873E3BC44AB6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fd10e1-15ef-4af7-d454-08d6bc5d982e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 20:05:48.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTA4IGF0IDEyOjU1ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gVGhpcyByZXZlcnRzIGNvbW1pdCA5ZGRhYzczNGFhMzEwYzVmYmMwZWM5MzYwMjMzNWQy
YTM5MDkyNDUxLg0KDQpJTUhPLCByYXRoZXIgdGhhbiByZXZlcnRpbmcsIEknZCBsaWtlIHRvIHNl
ZSB0aGUgZG1hIEFQSSBwcm92aWRlIGENCmZ1bmN0aW9uIHRlbGxpbmcgdXMgd2hldGhlciBzdHJl
YW1pbmcgRE1BIG9wZXJhdGlvbnMgYXJlIGNvaGVyZW50IG9yDQpub3QuIA0KDQpXaXRoIHRoYXQg
d2UgY291bGQgZml4IGFsbCBkcml2ZXJzIHRoYXQgd291bGQgb3RoZXJ3aXNlIGp1c3QgYmxvdyB1
cCBpZg0Kc29tZWJvZHkgaGFwcGVuZWQgdG8gZW5hYmxlIHN3aW90bGIgd2l0aCBib3VuY2UgYnVm
ZmVycy4uLg0KDQovVGhvbWFzDQoNCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3Ztd2dm
eC92bXdnZnhfZHJ2LmMgfCAxOSArKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS92
bXdnZngvdm13Z2Z4X2Rydi5jDQo+IGluZGV4IDYxNjVmZTJjNDUwNC4uOTI5NGI3NmM4MDg0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuYw0KPiBAQCAtMjYsNyArMjYsNiBA
QA0KPiAgDQo+ICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKg0KPiAqKioqKi8NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+DQo+IC0jaW5jbHVkZSA8bGludXgv
ZG1hLW1hcHBpbmcuaD4NCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm1QLmg+DQo+ICAjaW5jbHVk
ZSAidm13Z2Z4X2Rydi5oIg0KPiBAQCAtMzUsNiArMzQsNyBAQA0KPiAgI2luY2x1ZGUgPGRybS90
dG0vdHRtX3BsYWNlbWVudC5oPg0KPiAgI2luY2x1ZGUgPGRybS90dG0vdHRtX2JvX2RyaXZlci5o
Pg0KPiAgI2luY2x1ZGUgPGRybS90dG0vdHRtX21vZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2ludGVsLWlvbW11Lmg+DQo+ICANCj4gICNkZWZpbmUgVk1XR0ZYX0RSSVZFUl9ERVNDICJMaW51
eCBkcm0gZHJpdmVyIGZvciBWTXdhcmUgZ3JhcGhpY3MNCj4gZGV2aWNlcyINCj4gICNkZWZpbmUg
Vk1XR0ZYX0NISVBfU1ZHQUlJIDANCj4gQEAgLTU0NSwyMSArNTQ1LDYgQEAgc3RhdGljIHZvaWQg
dm13X2dldF9pbml0aWFsX3NpemUoc3RydWN0DQo+IHZtd19wcml2YXRlICpkZXZfcHJpdikNCj4g
IAlkZXZfcHJpdi0+aW5pdGlhbF9oZWlnaHQgPSBoZWlnaHQ7DQo+ICB9DQo+ICANCj4gLS8qKg0K
PiAtICogdm13X2Fzc3VtZV9pb21tdSAtIEZpZ3VyZSBvdXQgd2hldGhlciBjb2hlcmVudCBkbWEt
cmVtYXBwaW5nDQo+IG1pZ2h0IGJlDQo+IC0gKiB0YWtpbmcgcGxhY2UuDQo+IC0gKiBAZGV2OiBQ
b2ludGVyIHRvIHRoZSBzdHJ1Y3QgZHJtX2RldmljZS4NCj4gLSAqDQo+IC0gKiBSZXR1cm46IHRy
dWUgaWYgaW9tbXUgcHJlc2VudCwgZmFsc2Ugb3RoZXJ3aXNlLg0KPiAtICovDQo+IC1zdGF0aWMg
Ym9vbCB2bXdfYXNzdW1lX2lvbW11KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpDQo+IC17DQo+IC0J
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpvcHMgPSBnZXRfZG1hX29wcyhkZXYtPmRldik7DQo+
IC0NCj4gLQlyZXR1cm4gIWRtYV9pc19kaXJlY3Qob3BzKSAmJiBvcHMgJiYNCj4gLQkJb3BzLT5t
YXBfcGFnZSAhPSBkbWFfZGlyZWN0X21hcF9wYWdlOw0KPiAtfQ0KPiAtDQo+ICAvKioNCj4gICAq
IHZtd19kbWFfc2VsZWN0X21vZGUgLSBEZXRlcm1pbmUgaG93IERNQSBtYXBwaW5ncyBzaG91bGQg
YmUgc2V0IHVwDQo+IGZvciB0aGlzDQo+ICAgKiBzeXN0ZW0uDQo+IEBAIC01ODMsNyArNTY4LDcg
QEAgc3RhdGljIGludCB2bXdfZG1hX3NlbGVjdF9tb2RlKHN0cnVjdCB2bXdfcHJpdmF0ZQ0KPiAq
ZGV2X3ByaXYpDQo+ICANCj4gIAlpZiAodm13X2ZvcmNlX2NvaGVyZW50KQ0KPiAgCQlkZXZfcHJp
di0+bWFwX21vZGUgPSB2bXdfZG1hX2FsbG9jX2NvaGVyZW50Ow0KPiAtCWVsc2UgaWYgKHZtd19h
c3N1bWVfaW9tbXUoZGV2X3ByaXYtPmRldikpDQo+ICsJZWxzZSBpZiAoaW50ZWxfaW9tbXVfZW5h
YmxlZCkNCj4gIAkJZGV2X3ByaXYtPm1hcF9tb2RlID0gdm13X2RtYV9tYXBfcG9wdWxhdGU7DQo+
ICAJZWxzZSBpZiAoIXZtd19mb3JjZV9pb21tdSkNCj4gIAkJZGV2X3ByaXYtPm1hcF9tb2RlID0g
dm13X2RtYV9waHlzOw0K
