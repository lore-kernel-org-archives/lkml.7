Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C2C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B59D26E80
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWMR4OOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfEaToG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:44:06 -0400
Received: from mail-eopbgr680052.outbound.protection.outlook.com ([40.107.68.52]:8675
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfEaToF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peXPuXIMzv/q0uFyXCBYLeAuBHyDk0uF9ImQFg7TUH8=;
 b=yWMR4OOaENBs6PvsiHZGVdfZcWFlRqirlEI6suyYxr7BuxGg9i93ktEonn+I69ne065QwUh1fSIcRLv2BsrAkWQsVXUAUECNV2+ibi6ZEKIijIfLrbQWMYL3z6iE+I6fyVDWFCw11WaISa6fJiYOWeoK7aEJiBO7HjE87cvsevM=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1338.namprd12.prod.outlook.com (10.168.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Fri, 31 May 2019 19:43:55 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::34ed:dc98:e87d:50c4%7]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 19:43:55 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Thread-Topic: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Thread-Index: AQHVF+ku9NvxfnAiEUWf7KotYW4OlA==
Date:   Fri, 31 May 2019 19:43:55 +0000
Message-ID: <155933183362.4916.15727271006977576552.stgit@sosrh3.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:0:57::25) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305309c6-ebd5-4d77-3ea9-08d6e60050e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1338;
x-ms-traffictypediagnostic: DM5PR12MB1338:
x-microsoft-antispam-prvs: <DM5PR12MB1338A8F5BD4397B225B10D61FD190@DM5PR12MB1338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(71190400001)(71200400001)(6506007)(102836004)(2501003)(5660300002)(68736007)(186003)(386003)(99286004)(52116002)(26005)(8936002)(66446008)(476003)(64756008)(316002)(66556008)(103116003)(73956011)(66476007)(66946007)(7736002)(66066001)(6116002)(53936002)(305945005)(110136005)(81166006)(6436002)(2906002)(478600001)(8676002)(3846002)(25786009)(6486002)(14454004)(6512007)(72206003)(14444005)(81156014)(256004)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1338;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KhHhk6UPlqqMVAxtfM1miAzkIp1K1SwD2XyW+hhkNPzC0eGdIkDWXpysmj0xSxypY47tYiF7xtUvj9uCyZ264ySdxns26AqHqiCCajG2Amvkcl0JjrKDPSBbt+hDmKUBU+T+a1wbvhkiP7V2w6xb+x2liB2ceAZvrGOx/22wJOGMgMKkOLCKDyVQUYGdvPsYi+gjGxj4dCD8EILrGRQdJQwKmHJo0+chRy6m7EWQyuOIqodswiM8yF9lhCvarT/+T820LRkuaFJPw/lY7JhcG94snlHoH9bVmbMFJAoX4ma8SIkBIWG9q0SxlszGw0zl5btWlzorlJ8VBDUXTE2mL4d6dL1rfFTJSz1gnoxpMt/aHtxdl4DsTuf0hcwfgrG01DvYoCGnhmfPGtbm06pzKx51ysA4psLzPe3fQoxjBWc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E135CD3961EC5E4EAD3D78F48664EBF0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305309c6-ebd5-4d77-3ea9-08d6e60050e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 19:43:55.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghook@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRtYXRlc3QgbW9kdWxlIHBhcmFtZXRlciAndGltZW91dCcgaXMgZG9jdW1lbnRlZCBhcyBh
Y2NlcHRpbmcgYQ0KLTEgdG8gbWVhbiAiaW5maW5pdGUgdGltZW91dCIuIENoYW5nZSB0aGUgcGFy
YW1ldGVyIHRvIHRvIHNpZ25lZA0KaW50ZWdlciwgYW5kIGNoZWNrIHRoZSB2YWx1ZSB0byBjYWxs
IHRoZSBhcHByb3ByaWF0ZSB3YWl0X2V2ZW50KCkNCmZ1bmN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5
OiBHYXJ5IFIgSG9vayA8Z2FyeS5ob29rQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9kbWF0
ZXN0LmMgfCAgIDExICsrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2RtYXRlc3QuYyBi
L2RyaXZlcnMvZG1hL2RtYXRlc3QuYw0KaW5kZXggYjk2ODE0YTdkY2ViLi4yOGEyMzc2ODY1Nzgg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9kbWF0ZXN0LmMNCisrKyBiL2RyaXZlcnMvZG1hL2Rt
YXRlc3QuYw0KQEAgLTYzLDcgKzYzLDcgQEAgTU9EVUxFX1BBUk1fREVTQyhwcV9zb3VyY2VzLA0K
IAkJIk51bWJlciBvZiBwK3Egc291cmNlIGJ1ZmZlcnMgKGRlZmF1bHQ6IDMpIik7DQogDQogc3Rh
dGljIGludCB0aW1lb3V0ID0gMzAwMDsNCi1tb2R1bGVfcGFyYW0odGltZW91dCwgdWludCwgU19J
UlVHTyB8IFNfSVdVU1IpOw0KK21vZHVsZV9wYXJhbSh0aW1lb3V0LCBpbnQsIFNfSVJVR08gfCBT
X0lXVVNSKTsNCiBNT0RVTEVfUEFSTV9ERVNDKHRpbWVvdXQsICJUcmFuc2ZlciBUaW1lb3V0IGlu
IG1zZWMgKGRlZmF1bHQ6IDMwMDApLCAiDQogCQkgIlBhc3MgLTEgZm9yIGluZmluaXRlIHRpbWVv
dXQiKTsNCiANCkBAIC03OTUsOCArNzk1LDEzIEBAIHN0YXRpYyBpbnQgZG1hdGVzdF9mdW5jKHZv
aWQgKmRhdGEpDQogCQl9DQogCQlkbWFfYXN5bmNfaXNzdWVfcGVuZGluZyhjaGFuKTsNCiANCi0J
CXdhaXRfZXZlbnRfZnJlZXphYmxlX3RpbWVvdXQodGhyZWFkLT5kb25lX3dhaXQsIGRvbmUtPmRv
bmUsDQotCQkJCQkgICAgIG1zZWNzX3RvX2ppZmZpZXMocGFyYW1zLT50aW1lb3V0KSk7DQorCQkv
KiBBIHRpbWVvdXQgdmFsdWUgb2YgLTEgbWVhbnMgaW5maW5pdGUgd2FpdCAqLw0KKwkJaWYgKHRp
bWVvdXQgPT0gLTEpDQorCQkJd2FpdF9ldmVudF9mcmVlemFibGUodGhyZWFkLT5kb25lX3dhaXQs
IGRvbmUtPmRvbmUpOw0KKwkJZWxzZQ0KKwkJCXdhaXRfZXZlbnRfZnJlZXphYmxlX3RpbWVvdXQo
dGhyZWFkLT5kb25lX3dhaXQsDQorCQkJCQlkb25lLT5kb25lLA0KKwkJCQkJbXNlY3NfdG9famlm
ZmllcyhwYXJhbXMtPnRpbWVvdXQpKTsNCiANCiAJCXN0YXR1cyA9IGRtYV9hc3luY19pc190eF9j
b21wbGV0ZShjaGFuLCBjb29raWUsIE5VTEwsIE5VTEwpOw0KIA0KDQo=
