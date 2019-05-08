Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C52173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EP1rvffi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEHKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:33:19 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:44415
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbfEHKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUTUrAHYajPM9Xn87PwkKcB4ngrl0zTZ1r2+w4ykDZE=;
 b=EP1rvffi4m9vNtHDVFJyx/xbI9RkDVlBEVGEJVg7/NURm1PPIVoGrd7uTdEGI0oCEmUyCeEFRh/RQKAz8oHIU1zl1vKE4Bz70kwMIKzPtVQxdkWAE26e+lyL4WlQy5kN/7zfo93IwP7K4ilndpXsb5DFBJtsT0DhFxdautriZJo=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.177.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:33:04 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:33:04 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>
Subject: RE: [v1] drm/arm/mali-dp: Add a loop around the second set CVAL and
 try 5 times
Thread-Topic: [v1] drm/arm/mali-dp: Add a loop around the second set CVAL and
 try 5 times
Thread-Index: AQHVBYHjcdB1eoEScEKX0puYnABClqZhB0vA
Date:   Wed, 8 May 2019 10:33:04 +0000
Message-ID: <AM0PR04MB4865B4CBDB98E704968D34F9E2320@AM0PR04MB4865.eurprd04.prod.outlook.com>
References: <20190508094049.21658-1-wen.he_1@nxp.com>
In-Reply-To: <20190508094049.21658-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14e03220-e129-4d27-b9c6-08d6d3a08dd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
x-microsoft-antispam-prvs: <AM0PR04MB49621A8769C91AA5B477788EE2320@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(13464003)(478600001)(14444005)(66946007)(186003)(476003)(53936002)(66556008)(74316002)(99286004)(4326008)(52536014)(66066001)(73956011)(76116006)(66446008)(64756008)(305945005)(316002)(7736002)(33656002)(2501003)(110136005)(76176011)(7696005)(53546011)(6506007)(256004)(2201001)(102836004)(86362001)(446003)(11346002)(66476007)(5660300002)(26005)(6246003)(6116002)(3846002)(14454004)(229853002)(2906002)(8936002)(71190400001)(71200400001)(486006)(6436002)(68736007)(25786009)(9686003)(8676002)(81166006)(81156014)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t5uzQn5NQWS3HQvm1nEuS/zinnOgskHwrIi7WDCLpthrwC/kQ0L74mGOatvxEHfB9Y9hOwVpIMnpASi4WT0wX8f4hf5/5lCQqDaVjPAnrEVFirtqPySOdH7KE5H4lUvng9F8ztOKNRiBsh7/zO0/EtgL8uSapPDhC32VhfmenjUieE/eEutUTiNIOXLJWBLd+gLE8lnTBDgqAdWx5juhD9nxcNppY0m0CXER1RdgrdgSaxr+9gut/71xe3l+QdyLutblXy1FGD8A0lJHcrhiXmCz3KUTJKSo9ombff9rtw7Rm/zdv20kq4upRCrKPilmmD4xqwgdO7Sab4yHqoKfpF8dbVzmnoAQchuD1mRIDM+7w4m8H+UXPYijlUWZi8TUFDEchoTBGUoruDNzIMfPCm7lg+xL5GUfT/yHjvYHp8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e03220-e129-4d27-b9c6-08d6d3a08dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:33:04.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2VuIEhlDQo+IFNlbnQ6
IDIwMTnlubQ15pyIOOaXpSAxNzozOQ0KPiBUbzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgbGl2aXUuZHVkYXVAYXJtLmNvbTsNCj4gYnJpYW4uc3RhcmtleUBhcm0uY29tDQo+IENj
OiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNvbT4N
Cj4gU3ViamVjdDogW3YxXSBkcm0vYXJtL21hbGktZHA6IEFkZCBhIGxvb3AgYXJvdW5kIHRoZSBz
ZWNvbmQgc2V0IENWQUwgYW5kIHRyeQ0KPiA1IHRpbWVzDQo+IA0KPiBUaGlzIHBhdGNoIHRyeWlu
ZyB0byBmaXggbW9uaXRvciBmcmVlemUgaXNzdWUgY2F1c2VkIGJ5IGRybSBlcnJvciAnZmxpcF9k
b25lDQo+IHRpbWVkIG91dCcgb24gTFMxMDI4QSBwbGF0Zm9ybS4gdGhpcyBzZXQgdHJ5IGlzIG1h
a2UgYSBsb29wIGFyb3VuZCB0aGUgc2Vjb25kDQo+IHNldHRpbmcgQ1ZBTCBhbmQgdHJ5IGxpa2Ug
NSB0aW1lcyBiZWZvcmUgZ2l2ZWluZyB1cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpdml1IDxs
aXZpdS5EdWRhdUBhcm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBXZW4gSGUgPHdlbi5oZV8xQG54
cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfZHJ2LmMgfCAxMyAr
KysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2Ry
di5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfZHJ2LmMNCj4gaW5kZXggMjE3MjVj
OWI5ZjVlLi4xOGNiN2YxMzRmNGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0v
bWFsaWRwX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX2Rydi5jDQo+
IEBAIC0xOTIsNiArMTkyLDcgQEAgc3RhdGljIHZvaWQgbWFsaWRwX2F0b21pY19jb21taXRfaHdf
ZG9uZShzdHJ1Y3QNCj4gZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpICB7DQo+ICAJc3RydWN0IGRy
bV9kZXZpY2UgKmRybSA9IHN0YXRlLT5kZXY7DQo+ICAJc3RydWN0IG1hbGlkcF9kcm0gKm1hbGlk
cCA9IGRybS0+ZGV2X3ByaXZhdGU7DQo+ICsJaW50IGxvb3AgPSA1Ow0KPiANCj4gIAltYWxpZHAt
PmV2ZW50ID0gbWFsaWRwLT5jcnRjLnN0YXRlLT5ldmVudDsNCj4gIAltYWxpZHAtPmNydGMuc3Rh
dGUtPmV2ZW50ID0gTlVMTDsNCj4gQEAgLTIwNiw4ICsyMDcsMTggQEAgc3RhdGljIHZvaWQgbWFs
aWRwX2F0b21pY19jb21taXRfaHdfZG9uZShzdHJ1Y3QNCj4gZHJtX2F0b21pY19zdGF0ZSAqc3Rh
dGUpDQo+ICAJCQlkcm1fY3J0Y192YmxhbmtfZ2V0KCZtYWxpZHAtPmNydGMpOw0KPiANCj4gIAkJ
Lyogb25seSBzZXQgY29uZmlnX3ZhbGlkIGlmIHRoZSBDUlRDIGlzIGVuYWJsZWQgKi8NCj4gLQkJ
aWYgKG1hbGlkcF9zZXRfYW5kX3dhaXRfY29uZmlnX3ZhbGlkKGRybSkgPCAwKQ0KPiArCQlpZiAo
bWFsaWRwX3NldF9hbmRfd2FpdF9jb25maWdfdmFsaWQoZHJtKSA8IDApIHsNCj4gKwkJCS8qDQo+
ICsJCQkgKiBtYWtlIGEgbG9vcCBhcm91bmQgdGhlIHNlY29uZCBDVkFMIHNldHRpbmcgYW5kDQo+
ICsJCQkgKiB0cnkgNSB0aW1lcyBiZWZvcmUgZ2l2aW5nIHVwLg0KPiArCQkJICovDQo+ICsJCQl3
aGlsZSAobG9vcC0tKSB7DQo+ICsJCQkJaWYgKCFtYWxpZHBfc2V0X2FuZF93YWl0X2NvbmZpZ192
YWxpZChkcm0pKQ0KPiArCQkJCQlicmVhazsNCj4gKwkJCX0NCj4gIAkJCURSTV9ERUJVR19EUklW
RVIoInRpbWVkIG91dCB3YWl0aW5nIGZvciB1cGRhdGVkDQo+IGNvbmZpZ3VyYXRpb25cbiIpOw0K
PiArCQl9DQo+ICsNCj4gIAl9IGVsc2UgaWYgKG1hbGlkcC0+ZXZlbnQpIHsNCj4gIAkJLyogQ1JU
QyBpbmFjdGl2ZSBtZWFucyB2YmxhbmsgSVJRIGlzIGRpc2FibGVkLCBzZW5kIGV2ZW50IGRpcmVj
dGx5ICovDQo+ICAJCXNwaW5fbG9ja19pcnEoJmRybS0+ZXZlbnRfbG9jayk7DQo+IC0tDQo+IDIu
MTcuMQ0KDQo=
