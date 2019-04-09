Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBF220830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJQGwgGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDICoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:44:02 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:3920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfDICoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvZrYX159TT+OWojpeg1NAxRgGNjUxgZWeWBrQcZdTo=;
 b=AJQGwgGGZ+Jsvb3is2XUXdb9u/yD/ZCLDwBbUggxG9H3DSa1UF1nuiOTw7XMi/rbEZTpqAoH+dq/iHxDsYwbeRNUo8M5I+R8kFqv5ei3+w/1U+mIMMFY9Y86EtkqobKrYni3XersJARK4tc9bFOK2maVE5+ROumbtUOEkn1rU8Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Tue, 9 Apr 2019 02:43:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:43:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 2/4] firmware: imx: enable imx scu general irq function
Thread-Topic: [PATCH V6 2/4] firmware: imx: enable imx scu general irq
 function
Thread-Index: AQHU7n3820Y16VlDTkmIKJKC3R5bhA==
Date:   Tue, 9 Apr 2019 02:43:17 +0000
Message-ID: <1554777487-31075-2-git-send-email-Anson.Huang@nxp.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2813bdad-7377-4353-72a6-08d6bc951ee2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB3929A7942723DC0719533DBEF52D0@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(6512007)(53936002)(102836004)(478600001)(14454004)(6116002)(3846002)(7416002)(99286004)(97736004)(386003)(6506007)(305945005)(186003)(110136005)(4326008)(7736002)(316002)(256004)(25786009)(26005)(14444005)(446003)(2616005)(11346002)(5660300002)(105586002)(2501003)(106356001)(486006)(6436002)(6486002)(2906002)(476003)(68736007)(71190400001)(8936002)(81166006)(81156014)(50226002)(2201001)(86362001)(76176011)(52116002)(71200400001)(36756003)(8676002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BLl8ydw8fAK4s5KOBUbQOyrVI30R99Qf23aJNWehcAk7ebAuc6huC97m9/jYfRV+3a/aSEKhJeS+N+l3Xecb4/Lxt4ctXUrfBhAjRfLW5OJpGK2e5Zny5/Y6SQlYPsz0rVmNZmMbb+w7GYuC8jkUlbni2EzH98T6WYnmQvhKkl/0lJOTtNh8eOwncAin9N/DU6MDMKu3O+8HhrSyeWsV4wBTZdZEzF1rTl3UOISchsvKaBF+Y3BQXv78+HsNOp/u8tjZpFZkt9WYfLVxmsfXxWypVOHFQlr7SxJJv7U67PbbDMgWr0lMaoEUo3OKvlfyNG6pmrF91A5LVy0UCfclLm9ZXYluiTAKG5WeYDE4W2TWfWCNmhSza7diatpMw2rwTB4GJwY/kOGv83lIS7CPuAbmhlMxpuyk8NBE11CUC+A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2813bdad-7377-4353-72a6-08d6bc951ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:43:17.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFN5c3RlbSBDb250cm9sbGVyIEZpcm13YXJlIChTQ0ZXKSBjb250cm9scyBSVEMsIHRoZXJt
YWwNCmFuZCBXRE9HIGV0Yy4sIHRoZXNlIHJlc291cmNlcycgaW50ZXJydXB0IGZ1bmN0aW9uIGFy
ZSBtYW5hZ2VkDQpieSBTQ1UuIFdoZW4gYW55IElSUSBwZW5kaW5nLCBTQ1Ugd2lsbCBub3RpZnkg
TGludXggdmlhIE1VIGdlbmVyYWwNCmludGVycnVwdCBjaGFubmVsICMzLCBhbmQgTGludXgga2Vy
bmVsIG5lZWRzIHRvIGNhbGwgU0NVIEFQSXMNCnRvIGdldCBJUlEgc3RhdHVzIGFuZCBub3RpZnkg
ZWFjaCBtb2R1bGUgdG8gaGFuZGxlIHRoZSBpbnRlcnJ1cHQuDQoNClNpbmNlIHRoZXJlIGlzIG5v
IGRhdGEgdHJhbnNtaXNzaW9uIGZvciBTQ1UgSVJRIG5vdGlmaWNhdGlvbiwgc28NCmRvb3JiZWxs
IG1vZGUgaXMgdXNlZCBmb3IgdGhpcyBNVSBjaGFubmVsLCBhbmQgU0NVIGRyaXZlciB3aWxsDQp1
c2Ugbm90aWZpZXIgbWVjaGFuaXNtIHRvIGJyb2FkY2FzdCB0byBldmVyeSBtb2R1bGUgd2hpY2gg
cmVnaXN0ZXJzDQp0aGUgU0NVIGJsb2NrIG5vdGlmaWVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNv
biBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KQ2hhbmdlcyBzaW5jZSBWNToNCgkt
IHVzZSBBVE9NSUNfTk9USUZJRVIgaW5zdGVhZCBvZiBCTE9DS0lOR19OT1RJRklFUiBmb3IgaXJx
IG5vdGlmaWNhdGlvbjsNCgktIGFkZCBtZW1vcnkgZnJlZSBmb3IgZmFpbGVkIGNhc2UgdG8gYXZv
aWQgbWVtb3J5IGxlYWs7DQoJLSBhZGQgbmV3IEFQSSBpbXhfc2N1X2lycV9lbmFibGUoKSBmb3Ig
bW9kdWxlcyB0byBlbmFibGUvZGlzYWJsZSB0aGVpciBvd24gaXJxcy4NCi0tLQ0KIGRyaXZlcnMv
ZmlybXdhcmUvaW14L01ha2VmaWxlICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL2Zpcm13YXJlL2lt
eC9pbXgtc2N1LWlycS5jIHwgMTY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiBkcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMgICAgIHwgICA2ICsrDQogaW5jbHVk
ZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmggICB8ICAgNSArKw0KIDQgZmlsZXMgY2hhbmdlZCwg
MTc4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9m
aXJtd2FyZS9pbXgvTWFrZWZpbGUgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0KaW5k
ZXggMWIyZTE1Yi4uODAyYzRhZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L01h
a2VmaWxlDQorKysgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0KQEAgLTEsMyArMSwz
IEBADQogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KLW9iai0kKENPTkZJR19J
TVhfU0NVKQkJKz0gaW14LXNjdS5vIG1pc2Mubw0KK29iai0kKENPTkZJR19JTVhfU0NVKQkJKz0g
aW14LXNjdS5vIG1pc2MubyBpbXgtc2N1LWlycS5vDQogb2JqLSQoQ09ORklHX0lNWF9TQ1VfUEQp
CSs9IHNjdS1wZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1p
cnEuYyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQppbmRleCAwMDAwMDAwLi40MDAwYzYzDQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2
ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQpAQCAtMCwwICsxLDE2NiBAQA0KKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qDQorICogQ29weXJpZ2h0IDIwMTkg
TlhQDQorICoNCisgKiBJbXBsZW1lbnRhdGlvbiBvZiB0aGUgU0NVIElSUSBmdW5jdGlvbnMgdXNp
bmcgTVUuDQorICoNCisgKi8NCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14
L3JzcmMuaD4NCisjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L2lwYy5oPg0KKyNpbmNsdWRl
IDxsaW51eC9tYWlsYm94X2NsaWVudC5oPg0KKw0KKyNkZWZpbmUgSU1YX1NDX0lSUV9GVU5DX0VO
QUJMRQkxDQorI2RlZmluZSBJTVhfU0NfSVJRX0ZVTkNfU1RBVFVTCTINCisjZGVmaW5lIElNWF9T
Q19JUlFfTlVNX0dST1VQCTQNCisNCitzdGF0aWMgdTMyIG11X3Jlc291cmNlX2lkOw0KKw0KK3N0
cnVjdCBpbXhfc2NfbXNnX2lycV9nZXRfc3RhdHVzIHsNCisJc3RydWN0IGlteF9zY19ycGNfbXNn
IGhkcjsNCisJdW5pb24gew0KKwkJc3RydWN0IHsNCisJCQl1MTYgcmVzb3VyY2U7DQorCQkJdTgg
Z3JvdXA7DQorCQkJdTggcmVzZXJ2ZWQ7DQorCQl9IF9fcGFja2VkIHJlcTsNCisJCXN0cnVjdCB7
DQorCQkJdTMyIHN0YXR1czsNCisJCX0gcmVzcDsNCisJfSBkYXRhOw0KK307DQorDQorc3RydWN0
IGlteF9zY19tc2dfaXJxX2VuYWJsZSB7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQor
CXUzMiBtYXNrOw0KKwl1MTYgcmVzb3VyY2U7DQorCXU4IGdyb3VwOw0KKwl1OCBlbmFibGU7DQor
fSBfX3BhY2tlZDsNCisNCitzdGF0aWMgc3RydWN0IGlteF9zY19pcGMgKmlteF9zY19pcnFfaXBj
X2hhbmRsZTsNCitzdGF0aWMgc3RydWN0IHdvcmtfc3RydWN0IGlteF9zY19pcnFfd29yazsNCitz
dGF0aWMgQVRPTUlDX05PVElGSUVSX0hFQUQoaW14X3NjdV9pcnFfbm90aWZpZXJfY2hhaW4pOw0K
Kw0KK2ludCBpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKm5iKQ0KK3sNCisJcmV0dXJuIGF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcigNCisJ
CSZpbXhfc2N1X2lycV9ub3RpZmllcl9jaGFpbiwgbmIpOw0KK30NCitFWFBPUlRfU1lNQk9MKGlt
eF9zY3VfaXJxX3JlZ2lzdGVyX25vdGlmaWVyKTsNCisNCitpbnQgaW14X3NjdV9pcnFfdW5yZWdp
c3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKQ0KK3sNCisJcmV0dXJuIGF0
b21pY19ub3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKA0KKwkJJmlteF9zY3VfaXJxX25vdGlmaWVy
X2NoYWluLCBuYik7DQorfQ0KK0VYUE9SVF9TWU1CT0woaW14X3NjdV9pcnFfdW5yZWdpc3Rlcl9u
b3RpZmllcik7DQorDQorc3RhdGljIGludCBpbXhfc2N1X2lycV9ub3RpZmllcl9jYWxsX2NoYWlu
KHVuc2lnbmVkIGxvbmcgc3RhdHVzLCB1OCAqZ3JvdXApDQorew0KKwlyZXR1cm4gYXRvbWljX25v
dGlmaWVyX2NhbGxfY2hhaW4oJmlteF9zY3VfaXJxX25vdGlmaWVyX2NoYWluLA0KKwkJc3RhdHVz
LCAodm9pZCAqKWdyb3VwKTsNCit9DQorDQorc3RhdGljIHZvaWQgaW14X3NjdV9pcnFfd29ya19o
YW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCit7DQorCXN0cnVjdCBpbXhfc2NfbXNn
X2lycV9nZXRfc3RhdHVzIG1zZzsNCisJc3RydWN0IGlteF9zY19ycGNfbXNnICpoZHIgPSAmbXNn
LmhkcjsNCisJdTMyIGlycV9zdGF0dXM7DQorCWludCByZXQ7DQorCXU4IGk7DQorDQorCWZvciAo
aSA9IDA7IGkgPCBJTVhfU0NfSVJRX05VTV9HUk9VUDsgaSsrKSB7DQorCQloZHItPnZlciA9IElN
WF9TQ19SUENfVkVSU0lPTjsNCisJCWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNfSVJROw0KKwkJ
aGRyLT5mdW5jID0gSU1YX1NDX0lSUV9GVU5DX1NUQVRVUzsNCisJCWhkci0+c2l6ZSA9IDI7DQor
DQorCQltc2cuZGF0YS5yZXEucmVzb3VyY2UgPSBtdV9yZXNvdXJjZV9pZDsNCisJCW1zZy5kYXRh
LnJlcS5ncm91cCA9IGk7DQorDQorCQlyZXQgPSBpbXhfc2N1X2NhbGxfcnBjKGlteF9zY19pcnFf
aXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7DQorCQlpZiAocmV0KSB7DQorCQkJcHJfZXJyKCJnZXQg
aXJxIGdyb3VwICVkIHN0YXR1cyBmYWlsZWQsIHJldCAlZFxuIiwNCisJCQkgICAgICAgaSwgcmV0
KTsNCisJCQlyZXR1cm47DQorCQl9DQorDQorCQlpcnFfc3RhdHVzID0gbXNnLmRhdGEucmVzcC5z
dGF0dXM7DQorCQlpZiAoIWlycV9zdGF0dXMpDQorCQkJY29udGludWU7DQorDQorCQlpbXhfc2N1
X2lycV9ub3RpZmllcl9jYWxsX2NoYWluKGlycV9zdGF0dXMsICZpKTsNCisJfQ0KK30NCisNCit2
b2lkIGlteF9zY3VfaXJxX2VuYWJsZSh1OCBncm91cCwgdTMyIG1hc2ssIHU4IGVuYWJsZSkNCit7
DQorCXN0cnVjdCBpbXhfc2NfbXNnX2lycV9lbmFibGUgbXNnOw0KKwlzdHJ1Y3QgaW14X3NjX3Jw
Y19tc2cgKmhkciA9ICZtc2cuaGRyOw0KKwlpbnQgcmV0Ow0KKw0KKwloZHItPnZlciA9IElNWF9T
Q19SUENfVkVSU0lPTjsNCisJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19JUlE7DQorCWhkci0+
ZnVuYyA9IElNWF9TQ19JUlFfRlVOQ19FTkFCTEU7DQorCWhkci0+c2l6ZSA9IDM7DQorDQorCW1z
Zy5yZXNvdXJjZSA9IG11X3Jlc291cmNlX2lkOw0KKwltc2cuZ3JvdXAgPSBncm91cDsNCisJbXNn
Lm1hc2sgPSBtYXNrOw0KKwltc2cuZW5hYmxlID0gZW5hYmxlOw0KKw0KKwlyZXQgPSBpbXhfc2N1
X2NhbGxfcnBjKGlteF9zY19pcnFfaXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7DQorCWlmIChyZXQp
DQorCQlwcl9lcnIoImVuYWJsZSBpcnEgZmFpbGVkLCBncm91cCAlZCwgbWFzayAlZCwgcmV0ICVk
XG4iLA0KKwkJCWdyb3VwLCBtYXNrLCByZXQpOw0KK30NCitFWFBPUlRfU1lNQk9MKGlteF9zY3Vf
aXJxX2VuYWJsZSk7DQorDQorc3RhdGljIHZvaWQgaW14X3NjdV9pcnFfY2FsbGJhY2soc3RydWN0
IG1ib3hfY2xpZW50ICpjLCB2b2lkICptc2cpDQorew0KKwlzY2hlZHVsZV93b3JrKCZpbXhfc2Nf
aXJxX3dvcmspOw0KK30NCisNCitpbnQgaW14X3NjdV9lbmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5l
bChzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIHNwZWM7
DQorCXN0cnVjdCBtYm94X2NsaWVudCAqY2w7DQorCXN0cnVjdCBtYm94X2NoYW4gKmNoOw0KKwlp
bnQgcmV0ID0gMCwgaSA9IDA7DQorDQorCXJldCA9IGlteF9zY3VfZ2V0X2hhbmRsZSgmaW14X3Nj
X2lycV9pcGNfaGFuZGxlKTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQorCWNsID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpjbCksIEdGUF9LRVJORUwpOw0KKwlpZiAoIWNsKQ0K
KwkJcmV0dXJuIC1FTk9NRU07DQorDQorCWNsLT5kZXYgPSBkZXY7DQorCWNsLT5yeF9jYWxsYmFj
ayA9IGlteF9zY3VfaXJxX2NhbGxiYWNrOw0KKw0KKwkvKiBTQ1UgZ2VuZXJhbCBJUlEgdXNlcyBn
ZW5lcmFsIGludGVycnVwdCBjaGFubmVsIDMgKi8NCisJY2ggPSBtYm94X3JlcXVlc3RfY2hhbm5l
bF9ieW5hbWUoY2wsICJnaXAzIik7DQorCWlmIChJU19FUlIoY2gpKSB7DQorCQlyZXQgPSBQVFJf
RVJSKGNoKTsNCisJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgbWJveCBjaGFuIGdp
cDMsIHJldCAlZFxuIiwgcmV0KTsNCisJCWRldm1fa2ZyZWUoZGV2LCBjbCk7DQorCQlyZXR1cm4g
cmV0Ow0KKwl9DQorDQorCUlOSVRfV09SSygmaW14X3NjX2lycV93b3JrLCBpbXhfc2N1X2lycV93
b3JrX2hhbmRsZXIpOw0KKw0KKwlpZiAoIW9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKGRldi0+
b2Zfbm9kZSwgIm1ib3hlcyIsDQorCQkJCSAgICAgICAiI21ib3gtY2VsbHMiLCAwLCAmc3BlYykp
DQorCQlpID0gb2ZfYWxpYXNfZ2V0X2lkKHNwZWMubnAsICJtdSIpOw0KKw0KKwkvKiB1c2UgbXUx
IGFzIGdlbmVyYWwgbXUgaXJxIGNoYW5uZWwgaWYgZmFpbGVkICovDQorCWlmIChpIDwgMCkNCisJ
CWkgPSAxOw0KKw0KKwltdV9yZXNvdXJjZV9pZCA9IElNWF9TQ19SX01VXzBBICsgaTsNCisNCisJ
cmV0dXJuIHJldDsNCit9DQorRVhQT1JUX1NZTUJPTChpbXhfc2N1X2VuYWJsZV9nZW5lcmFsX2ly
cV9jaGFubmVsKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMg
Yi9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCmluZGV4IDJiYjFhMTkuLjA0YTI0YTgg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCisrKyBiL2RyaXZl
cnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KQEAgLTEwLDYgKzEwLDcgQEANCiAjaW5jbHVkZSA8
bGludXgvZXJyLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC90eXBlcy5oPg0KICNp
bmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvaXBjLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Zpcm13
YXJlL2lteC9zY2kuaD4NCiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQogI2luY2x1ZGUg
PGxpbnV4L2lycS5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCkBAIC0yNDYsNiArMjQ3
LDExIEBAIHN0YXRpYyBpbnQgaW14X3NjdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIA0KIAlpbXhfc2NfaXBjX2hhbmRsZSA9IHNjX2lwYzsNCiANCisJcmV0ID0gaW14X3Nj
dV9lbmFibGVfZ2VuZXJhbF9pcnFfY2hhbm5lbChkZXYpOw0KKwlpZiAocmV0KQ0KKwkJZGV2X3dh
cm4oZGV2LA0KKwkJCSJmYWlsZWQgdG8gZW5hYmxlIGdlbmVyYWwgaXJxIGNoYW5uZWw6ICVkXG4i
LCByZXQpOw0KKw0KIAlkZXZfaW5mbyhkZXYsICJOWFAgaS5NWCBTQ1UgSW5pdGlhbGl6ZWRcbiIp
Ow0KIA0KIAlyZXR1cm4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZShkZXYpOw0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3NjaS5oIGIvaW5jbHVkZS9saW51eC9maXJt
d2FyZS9pbXgvc2NpLmgNCmluZGV4IGViYzU1MDkuLjQxMDBiZTcgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaA0KKysrIGIvaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9pbXgvc2NpLmgNCkBAIC0xNSw0ICsxNSw5IEBADQogDQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13
YXJlL2lteC9zdmMvbWlzYy5oPg0KICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3Bt
Lmg+DQorDQoraW50IGlteF9zY3VfZW5hYmxlX2dlbmVyYWxfaXJxX2NoYW5uZWwoc3RydWN0IGRl
dmljZSAqZGV2KTsNCitpbnQgaW14X3NjdV9pcnFfcmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IG5v
dGlmaWVyX2Jsb2NrICpuYik7DQoraW50IGlteF9zY3VfaXJxX3VucmVnaXN0ZXJfbm90aWZpZXIo
c3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7DQordm9pZCBpbXhfc2N1X2lycV9lbmFibGUodTgg
Z3JvdXAsIHUzMiBtYXNrLCB1OCBlbmFibGUpOw0KICNlbmRpZiAvKiBfU0NfU0NJX0ggKi8NCi0t
IA0KMi43LjQNCg0K
