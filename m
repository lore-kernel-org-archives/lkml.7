Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435A7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B54E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rwCRj8mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406071AbfHWTLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:11:45 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:31678
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731649AbfHWTLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqdGCt5s+1G+DaKHDzXvMVS3H/SfniygChwwyEh0e1q7PjJGaeC0DcFP+PksgICWblLihJDzxumv29K8yQyzh9tD/DFBy3qqJOTbZcPxeWzslzynmx+g0z1KuF8CKINoIAkHZRoPHE8CjvUMDfGVrAZ8c/La9p8jOHJVAXV+lyJz7o06lAedMlv/VOPzFXETJuwB2ryFzdEav9L+zR78viz9fDmHzM9zNRNf9SSh19iNKdwNN4DOzDv5BFbWsj4A7bvkSoD0Z03yV9zB+/9aS7lk2i9o/hVfXxZegQmWkpO5MSD8sOoQGM51HjHz/FKOn9mKv43YKSyWRS8/TpRmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKiaDvtX3uc9OfHB2O953KVbPXggDj8tZAZWAUvyDtc=;
 b=n0oq5ed2IHezu+24rdjvIDwiCB0VRYIZarR+EDVTz5SerRvzjbWocF41joG0ELScxUO0U2K6PLk9tctk8dgxKXLVpq1QHLVhK+TfY6VjQ/TH/JIvYbbSve+IKfsbso9t5LtCCbXiGHFWJV5nU/Md/GOvXOUucwXmYiW+NXaqvmh2ZJCohKgNTDGFaFA4NQWGa5++jf61Buk6h71Ektb48TlJANJf/b404yropiER9+z28Na+45+TwU3/7j78NC7wyZ0wzZAZCFFK5faqczZuPyxmASdg1ePQz3/yXSd+Gxx90r8DSiiTvTkYWoT8Te2LIWy7W7s61ApzZnOWY67t4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKiaDvtX3uc9OfHB2O953KVbPXggDj8tZAZWAUvyDtc=;
 b=rwCRj8mjpBU8Y6ZaSNb71xdYzpUBnpVsMQNvujZ3k/DSq3SK7BwVixMMugi5VHRVvkLj82lEwOXlpTpyW6AoiGlkwXxjBtIJrlMhtAb/QXyF04X8Q1nNSr2a0xyU9IDi2XaCmMSHi+gMrDE9n7eRepoXWsiEWHUHcMxw7CnAiRY=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 19:11:32 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 19:11:32 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: [PATCH v3 1/7] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Topic: [PATCH v3 1/7] dt-bindings: arm: fsl: Add the S32V234-EVB board
Thread-Index: AQHVWeaTEtYyWxMnckudXC/xs5O+aw==
Date:   Fri, 23 Aug 2019 19:11:32 +0000
Message-ID: <20190823191115.18490-2-stefan-gabriel.mirea@nxp.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:203:90::17) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97155e5a-a8f8-4444-2d81-08d727fdb563
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2717;
x-ms-traffictypediagnostic: VI1PR0402MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB271781D0E64B5578C9ABA035DFA40@VI1PR0402MB2717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(446003)(476003)(2501003)(66446008)(76176011)(6436002)(6486002)(386003)(6506007)(50226002)(81156014)(256004)(86362001)(66946007)(64756008)(66556008)(66476007)(66066001)(186003)(8936002)(6512007)(25786009)(81166006)(36756003)(478600001)(52116002)(8676002)(14454004)(102836004)(6116002)(5660300002)(486006)(26005)(2201001)(71200400001)(53936002)(71190400001)(1076003)(316002)(110136005)(7416002)(54906003)(4326008)(99286004)(7736002)(305945005)(6636002)(3846002)(11346002)(2616005)(4744005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2717;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 68cNtxQAbrexGZ9oYrtYBIkeVKOGFTVhHtB1sEqg5bp+tqRIe2fEBRAWt2Gz2gnNe3hMY5xmnek3U5kK9Xxk490Fw8icdoP7TFISIS3AtdhxOIzUg8SiG6iOVz3Hljc4Rn9NAs397jkr1TVzrqqbve9xl0lR7uFKZmYQSFB+NWhb3th2WoynBXH5KEPuMY7Fpbi1Qj5Rsyn7RPJjwTN0KW3DmMeO2dfnPhhdxX7vBOSFMpCRE6sOsD1YJvNEXQQui+usg5deAHYjKZ9lKlAPR+4tco1n4rNWVL/rlFsVWEZSuBpbwqz+io6aBUdLDTPjnJc0mLfHKG52j8kzQPAqzDrrsD27Vo+UxN+0YKX0GH+X29+vQw4aN+I4Cto3KBt8Qsa/lE0yx0chHafN7ys6eRsy40JyVoq5haly/oFNcA4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D9A638E4AE604589785D13B9E6137A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97155e5a-a8f8-4444-2d81-08d727fdb563
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:11:32.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvxjdSZr5AkOQRQorWYmhG4tcU/6RwRrCD0+BGqdAv1aoNsjORIwDNBpJjxwsP2fet3CuVrRq+PqOepPV+e/UFpxYBGRqIKuFvWn7oon0oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRWRkeSBQZXRyaciZb3IgPGVkZHkucGV0cmlzb3JAbnhwLmNvbT4NCg0KQWRkIGVudHJ5
IGZvciB0aGUgTlhQIFMzMlYyMzQgQ3VzdG9tZXIgRXZhbHVhdGlvbiBCb2FyZCB0byB0aGUgYm9h
cmQvU29DDQpiaW5kaW5ncy4NCg0KU2lnbmVkLW9mZi1ieTogRWRkeSBQZXRyaciZb3IgPGVkZHku
cGV0cmlzb3JAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0ZWZhbi1HYWJyaWVsIE1pcmVhIDxz
dGVmYW4tZ2FicmllbC5taXJlYUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zz
bC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0K
aW5kZXggNzI5NGFjMzZmNGMwLi41OTdjNTYzYmRlYzkgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQpAQCAtMzA5LDQgKzMwOSwxMCBAQCBw
cm9wZXJ0aWVzOg0KICAgICAgICAgICAgICAgLSBmc2wsbHMyMDg4YS1yZGINCiAgICAgICAgICAg
LSBjb25zdDogZnNsLGxzMjA4OGENCiANCisgICAgICAtIGRlc2NyaXB0aW9uOiBTMzJWMjM0IGJh
c2VkIEJvYXJkcw0KKyAgICAgICAgaXRlbXM6DQorICAgICAgICAgIC0gZW51bToNCisgICAgICAg
ICAgICAgIC0gZnNsLHMzMnYyMzQtZXZiICAgICAgICAgICAjIFMzMlYyMzQtRVZCMiBDdXN0b21l
ciBFdmFsdWF0aW9uIEJvYXJkDQorICAgICAgICAgIC0gY29uc3Q6IGZzbCxzMzJ2MjM0DQorDQog
Li4uDQotLSANCjIuMjIuMA0KDQo=
