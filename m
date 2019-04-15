Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0311C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56C2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iIapJ1AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDOOOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:14:10 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38782 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfDOOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:14:09 -0400
X-IronPort-AV: E=Sophos;i="5.60,353,1549954800"; 
   d="scan'208";a="29944501"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Apr 2019 07:14:03 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 15 Apr 2019 07:14:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeWisu9ZOtbYQD09rL1XpJ8RNP1uLmqyLYVbBQSW+Sc=;
 b=iIapJ1AEMzMJFfBGPR+BeAdqwFjGE49Inz6md18PWQ2L2AjDZa965TT8j0nGtvKI/n8ZxC/DomP76rfAvKxVbmeELKaVXZdtADfC1YztEJ5mv/I+IQTVYLjDd/X6GepYaXpEKMSPQLEIcrsPa6/1tXP+PNyo/4nU3ccB0Pkhx3A=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1548.namprd11.prod.outlook.com (10.172.38.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 14:13:56 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 14:13:56 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <mchehab@kernel.org>,
        <ksloat@aampglobal.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 4/4] media: atmel: atmel-isc: make try_fmt error less
 verbose
Thread-Topic: [PATCH v2 4/4] media: atmel: atmel-isc: make try_fmt error less
 verbose
Thread-Index: AQHU85V2f59JdX2VPUWzEumzCPs+5w==
Date:   Mon, 15 Apr 2019 14:13:56 +0000
Message-ID: <1555337305-13767-5-git-send-email-eugen.hristev@microchip.com>
References: <1555337305-13767-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1555337305-13767-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:803:104::18) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f708bb4f-8572-46d8-02c6-08d6c1ac98ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB1548;
x-ms-traffictypediagnostic: DM5PR11MB1548:
x-microsoft-antispam-prvs: <DM5PR11MB154898318B62166B95C43A54E82B0@DM5PR11MB1548.namprd11.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(76176011)(99286004)(5660300002)(52116002)(7736002)(305945005)(486006)(54906003)(110136005)(316002)(478600001)(86362001)(11346002)(256004)(476003)(2616005)(186003)(14454004)(72206003)(71190400001)(446003)(106356001)(36756003)(105586002)(14444005)(71200400001)(26005)(6486002)(102836004)(386003)(2906002)(81156014)(4326008)(81166006)(6436002)(25786009)(68736007)(6512007)(53936002)(107886003)(6116002)(66066001)(2501003)(3846002)(2201001)(50226002)(8936002)(97736004)(6506007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1548;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U7o4GK/YrNywqpG1qP+CH+neEoazy4oqPGda9AuK3Et7h7TLKtnbehf/g2oun5sD9XsFkSgil4mVi73mLG5wpfjVCsFI14PdN+wuqmprCCNU00pici/5+DCbJ66We2mGk85p4ev7x9CAzXQTzFTgHYPXVJXz1PNI+OEIxrAUFmQg8vQwDbaBTbFAxvg6twvMxDIXETgtBKU7hzfPwbbRBij2uSe2iSFg1KRcipStjcxFZVU68fdjLdlOlutpI51CF8yp9UexyipJN2RsagjtvEzPvEJeY8+qZ7bZQ55au43piwnjYMUVK0mcBfXSP3+bjhJP1skkXDA5SoRRtk62Fe3DOD1jsHqKyqEh+TvXuCj5tYuYCP/Xeq2y3YlBCXJcCGEjcilM4JGavpzrSC7PO4bnb3eabJ3wIQppdo0UAcY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f708bb4f-8572-46d8-02c6-08d6c1ac98ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 14:13:56.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1548
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpJbiBj
YXNlIHRoZSBzZW5zb3IgcmVmdXNlcyB0byBzZXQgdGhlIGZvcm1hdCwgYXZvaWQgcHJpbnRpbmcg
dGhlIGVycm9yDQptZXNzYWdlIHRoYXQgbm8gY29tcGF0aWJsZSBmb3JtYXQgd2FzIGZvdW5kLg0K
VGhpcyBtZWFucyB0aGF0IHRoZSB0cnlfZm10IHdpbGwgYmUgbGVzcyB2ZXJib3NlLg0KVGhlIGVy
cm9yIHdpbGwgYmUgcHJpbnRlZCBvbmx5IGlmIHJlYWxseSBhIGZvcm1hdCBjYW5ub3QgYmUgZm91
bmQuDQpTb21lIGFwcGxpY2F0aW9uIHRyeSBhbGwgcG9zc2libGUgZm9ybWF0cyBpbiBhIHJvdyAo
Z3N0cmVhbWVyIGUuZy4pDQp3aGljaCB3aWxsIGZsb29kIHRoZSBjb25zb2xlIHdpdGggZXJyb3Ig
bWVzc2FnZXMgdW50aWwgYSB3b3JraW5nIG9uZSBpcyBmb3VuZC4NCg0KU2lnbmVkLW9mZi1ieTog
RXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KLS0tDQogZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYyB8IDMgKystDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vYXRtZWwvYXRtZWwtaXNjLmMNCmluZGV4IDc3N2UyN2YuLmRhM2I0NDEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQorKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQpAQCAtMTQ4Nyw3ICsxNDg3LDcgQEAg
c3RhdGljIGludCBpc2NfdHJ5X2ZtdChzdHJ1Y3QgaXNjX2RldmljZSAqaXNjLCBzdHJ1Y3QgdjRs
Ml9mb3JtYXQgKmYsDQogCXJldCA9IHY0bDJfc3ViZGV2X2NhbGwoaXNjLT5jdXJyZW50X3N1YmRl
di0+c2QsIHBhZCwgc2V0X2ZtdCwNCiAJCQkgICAgICAgJnBhZF9jZmcsICZmb3JtYXQpOw0KIAlp
ZiAocmV0IDwgMCkNCi0JCWdvdG8gaXNjX3RyeV9mbXRfZXJyOw0KKwkJZ290byBpc2NfdHJ5X2Zt
dF9zdWJkZXZfZXJyOw0KIA0KIAl2NGwyX2ZpbGxfcGl4X2Zvcm1hdChwaXhmbXQsICZmb3JtYXQu
Zm9ybWF0KTsNCiANCkBAIC0xNTAyLDYgKzE1MDIsNyBAQCBzdGF0aWMgaW50IGlzY190cnlfZm10
KHN0cnVjdCBpc2NfZGV2aWNlICppc2MsIHN0cnVjdCB2NGwyX2Zvcm1hdCAqZiwNCiANCiBpc2Nf
dHJ5X2ZtdF9lcnI6DQogCXY0bDJfZXJyKCZpc2MtPnY0bDJfZGV2LCAiQ291bGQgbm90IGZpbmQg
YW55IHBvc3NpYmxlIGZvcm1hdCBmb3IgYSB3b3JraW5nIHBpcGVsaW5lXG4iKTsNCitpc2NfdHJ5
X2ZtdF9zdWJkZXZfZXJyOg0KIAltZW1zZXQoJmlzYy0+dHJ5X2NvbmZpZywgMCwgc2l6ZW9mKGlz
Yy0+dHJ5X2NvbmZpZykpOw0KIA0KIAlyZXR1cm4gcmV0Ow0KLS0gDQoyLjcuNA0KDQo=
