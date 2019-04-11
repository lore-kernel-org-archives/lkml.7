Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95964C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6227A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MBy5TwwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDKCTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:19:55 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:11748
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfDKCTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf2XIByzY8NYYvG28nCwEnTxaT9EC44JTtjyYXXMSZE=;
 b=MBy5TwwTjCw0NZ5BV2GaAQUScfCW5cz7sVI8LmLHzW3V3D9apC9xtzb7fPPjeG12woi8ivyYJ/CeERHQOPS0v3inkSCXoUBk9lRqWT0VfpsY+XUYcO+CFlDlZHJImLcX9tCX9k5dqboAK5qYnLuNsNdZQOy8JDxAjrXYdkJNsBI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 02:19:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 02:19:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code
Thread-Topic: [PATCH] rtc: mxc_v2: use dev_pm_set_wake_irq() to simplify code
Thread-Index: AQHU8A0J0UP/j9Q4o0GQI21MjlYhWQ==
Date:   Thu, 11 Apr 2019 02:19:48 +0000
Message-ID: <1554948890-21635-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fd8ffae-3bd5-474f-600c-08d6be242bde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-microsoft-antispam-prvs: <DB3PR0402MB3836D17BF1AC7D99F713F231F52F0@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(2906002)(8936002)(81166006)(36756003)(6436002)(50226002)(256004)(4326008)(316002)(14444005)(97736004)(53936002)(386003)(81156014)(7736002)(305945005)(186003)(25786009)(68736007)(5660300002)(6116002)(105586002)(106356001)(486006)(99286004)(2501003)(6506007)(102836004)(3846002)(66066001)(508600001)(26005)(52116002)(14454004)(71200400001)(86362001)(6512007)(71190400001)(2201001)(2616005)(476003)(8676002)(110136005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iICVZGI9ECzFsc7DclkDeF3owbQmjBl/lJK0e35d2bzHEYO3TwOPhtbh683KgmA2rZRtXo70YXqG1MtW7QL/PUJHdbbC/qvYnE+qf+Jddo6I4Jj0iChYBBzdRFUv1YDOLhcoqwlKlalLL2tm1GJbeYxNX223Qu5ONauW4Q3SQIYfZUo7LafO+7LUdBUpChbyeqjb9wp6wx4+AUOb4kK8LKcHIDb4swl44Uh8KftYkSJ8LHIHofeepHDWCBEZHN9KpkeIFfrfyTgQxPGQuphZxQQ/XZWqpG/OtlnvOrhOgOCtXRXyOafCAiRH+Xeod2DodFGTLeRepzcJfhzvUT0YN0+uyZBXWDhYFZ7Sqa8eO3wHgaqMpzP0aH4htWl75V5VIg+jQ5KEOmgRLZHBibKMEQbcoVZ6/RGLhWtEQNRg7UY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd8ffae-3bd5-474f-600c-08d6be242bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 02:19:48.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBjYWxsaW5nIGRldl9wbV9zZXRfd2FrZV9pcnEoKSB0byBzZXQgTVhDX1YyIFJUQyBhcyB3
YWtldXAgc291cmNlDQpmb3Igc3VzcGVuZCwgZ2VuZXJpYyB3YWtlIGlycSBtZWNoYW5pc20gd2ls
bCBhdXRvbWF0aWNhbGx5IGVuYWJsZQ0KaXQgYXMgd2FrZXVwIHNvdXJjZSB3aGVuIHN1c3BlbmQs
IHRoZW4gdGhlIHN1c3BlbmQvcmVzdW1lIGNhbGxiYWNrDQp3aGljaCBhcmUgT05MWSBmb3IgZW5h
YmxpbmcvZGlzYWJsaW5nIGlycSB3YWtlIGNhbiBiZSByZW1vdmVkLCBpdA0Kc2ltcGxpZmllcyB0
aGUgY29kZS4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtbXhjX3YyLmMgfCAyOSArKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDI1IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW14Y192Mi5jIGIvZHJpdmVy
cy9ydGMvcnRjLW14Y192Mi5jDQppbmRleCAwMDc4NzlhLi41Yjk3MGE4IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ydGMvcnRjLW14Y192Mi5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtbXhjX3YyLmMN
CkBAIC0xMCw2ICsxMCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRl
IDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BtX3dha2VpcnEuaD4NCiAjaW5jbHVkZSA8bGludXgv
cnRjLmg+DQogDQogI2RlZmluZSBTUlRDX0xQUERSX0lOSVQgICAgICAgMHg0MTczNjE2NgkvKiBp
bml0IGZvciBnbGl0Y2ggZGV0ZWN0ICovDQpAQCAtMzA1LDYgKzMwNiw5IEBAIHN0YXRpYyBpbnQg
bXhjX3J0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIHBk
YXRhLT5pcnE7DQogDQogCWRldmljZV9pbml0X3dha2V1cCgmcGRldi0+ZGV2LCAxKTsNCisJcmV0
ID0gZGV2X3BtX3NldF93YWtlX2lycSgmcGRldi0+ZGV2LCBwZGF0YS0+aXJxKTsNCisJaWYgKHJl
dCkNCisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBlbmFibGUgaXJxIHdha2VcbiIp
Ow0KIA0KIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUocGRhdGEtPmNsayk7DQogCWlmIChyZXQp
DQpAQCAtMzY3LDMwICszNzEsNiBAQCBzdGF0aWMgaW50IG14Y19ydGNfcmVtb3ZlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJldHVybiAwOw0KIH0NCiANCi0jaWZkZWYgQ09ORklH
X1BNX1NMRUVQDQotc3RhdGljIGludCBteGNfcnRjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KLXsNCi0Jc3RydWN0IG14Y19ydGNfZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCi0NCi0JaWYgKGRldmljZV9tYXlfd2FrZXVwKGRldikpDQotCQllbmFibGVfaXJxX3dha2Uo
cGRhdGEtPmlycSk7DQotDQotCXJldHVybiAwOw0KLX0NCi0NCi1zdGF0aWMgaW50IG14Y19ydGNf
cmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCi17DQotCXN0cnVjdCBteGNfcnRjX2RhdGEgKnBk
YXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQotDQotCWlmIChkZXZpY2VfbWF5X3dha2V1cChk
ZXYpKQ0KLQkJZGlzYWJsZV9pcnFfd2FrZShwZGF0YS0+aXJxKTsNCi0NCi0JcmV0dXJuIDA7DQot
fQ0KLSNlbmRpZg0KLQ0KLXN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhteGNfcnRjX3BtX29wcywg
bXhjX3J0Y19zdXNwZW5kLCBteGNfcnRjX3Jlc3VtZSk7DQotDQogc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXhjX2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg1
My1ydGMiLCB9LA0KIAl7fQ0KQEAgLTQwMCw3ICszODAsNiBAQCBzdGF0aWMgc3RydWN0IHBsYXRm
b3JtX2RyaXZlciBteGNfcnRjX2RyaXZlciA9IHsNCiAJLmRyaXZlciA9IHsNCiAJCS5uYW1lID0g
Im14Y19ydGNfdjIiLA0KIAkJLm9mX21hdGNoX3RhYmxlID0gbXhjX2lkcywNCi0JCS5wbSA9ICZt
eGNfcnRjX3BtX29wcywNCiAJfSwNCiAJLnByb2JlID0gbXhjX3J0Y19wcm9iZSwNCiAJLnJlbW92
ZSA9IG14Y19ydGNfcmVtb3ZlLA0KLS0gDQoyLjcuNA0KDQo=
