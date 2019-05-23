Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E77C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD3121019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lWBtdeG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfEWFvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:51:10 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:61664
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEWFvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLK6J4oxrIr5ZhYuaEdROLR+w74RnHB147OWCWDCdao=;
 b=lWBtdeG0rgcsWyvFLqKIaixGk1eTr+Mh+ZKJfwMYLKx+hj10zYY5w+NmmXzY/tLmLkrq03bXcXpb3//rcRlZQQxAhEGqu2f4vkflvdtWTxMmX3zGtnd7Eg+pDVFcjRyR/WAZlMrvw/3DSxmXZyyF3ZZjk68aWlXk8h6yPWdAR4c=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3956.eurprd04.prod.outlook.com (52.134.93.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 05:51:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 05:51:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVESuByCLdCQE1i0W9lURWmZ2DUQ==
Date:   Thu, 23 May 2019 05:51:02 +0000
Message-ID: <20190523060437.11059-3-peng.fan@nxp.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
In-Reply-To: <20190523060437.11059-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c06b37c-4476-495f-b629-08d6df42a3a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3956;
x-ms-traffictypediagnostic: AM0PR04MB3956:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB39567B3621DA5712781E761188010@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(2201001)(86362001)(6512007)(256004)(6436002)(6306002)(44832011)(486006)(2501003)(2906002)(2616005)(476003)(6116002)(3846002)(81166006)(8676002)(25786009)(6486002)(305945005)(81156014)(8936002)(50226002)(4326008)(53936002)(11346002)(15650500001)(7736002)(316002)(446003)(186003)(26005)(14454004)(66066001)(68736007)(1076003)(36756003)(71200400001)(71190400001)(102836004)(5660300002)(966005)(386003)(54906003)(110136005)(76176011)(6506007)(99286004)(66556008)(66446008)(66476007)(7416002)(66946007)(478600001)(73956011)(52116002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3956;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xEIak1FsGsOKUrHVuEcMgkyDAl5EMvmyjyFSLqQ3lWqfnL7oiWp8OneiEZ2bmttZxNue/HyBf97iOAYKVKd9FDsIBZFXk38P/nswJLLRT66VjHmK+opCWEniYLw0dDVLJ8kNC4ZrT73XHCNKHtsnbKOBjbahurXHjiwmy52TUqS+i1tiyj62bRxL1EtsjlouVa24a4M3vRFX3nXJ4q8rsbZ1AqAcafhE1QbljfOl8aSSsA/U+IGUpO/09H0RtEgf5TnrhqdHqZMLImtmupqfUqx6SfAF/EJ//8PorI62k7KX6UEXlGj8/depNOXkSOxZ9aIXZ/r9O+/U7DiqjeX3fuUlHO7nORW1GhRcrI2tSmw+pXVZKvvU/39pVh1jIFDOcolUlTMYt2pT7mbQWJ+b222kTykUuZY7ebof47rtM74=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c06b37c-4476-495f-b629-08d6df42a3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 05:51:02.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBtYWlsYm94IGRyaXZlciBpbXBsZW1lbnRzIGEgbWFpbGJveCB3aGljaCBzaWduYWxzIHRy
YW5zbWl0dGVkIGRhdGEKdmlhIGFuIEFSTSBzbWMgKHNlY3VyZSBtb25pdG9yIGNhbGwpIGluc3Ry
dWN0aW9uLiBUaGUgbWFpbGJveCByZWNlaXZlcgppcyBpbXBsZW1lbnRlZCBpbiBmaXJtd2FyZSBh
bmQgY2FuIHN5bmNocm9ub3VzbHkgcmV0dXJuIGRhdGEgd2hlbiBpdApyZXR1cm5zIGV4ZWN1dGlv
biB0byB0aGUgbm9uLXNlY3VyZSB3b3JsZCBhZ2Fpbi4KQW4gYXN5bmNocm9ub3VzIHJlY2VpdmUg
cGF0aCBpcyBub3QgaW1wbGVtZW50ZWQuClRoaXMgYWxsb3dzIHRoZSB1c2FnZSBvZiBhIG1haWxi
b3ggdG8gdHJpZ2dlciBmaXJtd2FyZSBhY3Rpb25zIG9uIFNvQ3MKd2hpY2ggZWl0aGVyIGRvbid0
IGhhdmUgYSBzZXBhcmF0ZSBtYW5hZ2VtZW50IHByb2Nlc3NvciBvciBvbiB3aGljaCBzdWNoCmEg
Y29yZSBpcyBub3QgYXZhaWxhYmxlLiBBIHVzZXIgb2YgdGhpcyBtYWlsYm94IGNvdWxkIGJlIHRo
ZSBTQ1AKaW50ZXJmYWNlLgoKTW9kaWZpZWQgZnJvbSBBbmRyZSBQcnp5d2FyYSdzIHYyIHBhdGNo
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC84MTI5OTkvCgpDYzogQW5k
cmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+ClNpZ25lZC1vZmYtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPgotLS0KIGRyaXZlcnMvbWFpbGJveC9LY29uZmlnICAgICAg
ICAgICAgICAgICB8ICAgNyArKwogZHJpdmVycy9tYWlsYm94L01ha2VmaWxlICAgICAgICAgICAg
ICAgIHwgICAyICsKIGRyaXZlcnMvbWFpbGJveC9hcm0tc21jLW1haWxib3guYyAgICAgICB8IDE1
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9tYWlsYm94
L2FybS1zbWMtbWFpbGJveC5oIHwgIDEwICsrKwogNCBmaWxlcyBjaGFuZ2VkLCAxNzMgaW5zZXJ0
aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWFpbGJveC9hcm0tc21jLW1haWxi
b3guYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWFpbGJveC9hcm0tc21jLW1h
aWxib3guaAoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9LY29uZmlnIGIvZHJpdmVycy9t
YWlsYm94L0tjb25maWcKaW5kZXggNTk1NTQyYmZhZTg1Li5jM2JkMGYxZGRjZDggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbWFpbGJveC9LY29uZmlnCisrKyBiL2RyaXZlcnMvbWFpbGJveC9LY29uZmln
CkBAIC0xNSw2ICsxNSwxMyBAQCBjb25maWcgQVJNX01IVQogCSAgVGhlIGNvbnRyb2xsZXIgaGFz
IDMgbWFpbGJveCBjaGFubmVscywgdGhlIGxhc3Qgb2Ygd2hpY2ggY2FuIGJlCiAJICB1c2VkIGlu
IFNlY3VyZSBtb2RlIG9ubHkuCiAKK2NvbmZpZyBBUk1fU01DX01CT1gKKwl0cmlzdGF0ZSAiR2Vu
ZXJpYyBBUk0gc21jIG1haWxib3giCisJZGVwZW5kcyBvbiBPRiAmJiBIQVZFX0FSTV9TTUNDQwor
CWhlbHAKKwkgIEdlbmVyaWMgbWFpbGJveCBkcml2ZXIgd2hpY2ggdXNlcyBBUk0gc21jIGNhbGxz
IHRvIGNhbGwgaW50bworCSAgZmlybXdhcmUgZm9yIHRyaWdnZXJpbmcgbWFpbGJveGVzLgorCiBj
b25maWcgSU1YX01CT1gKIAl0cmlzdGF0ZSAiaS5NWCBNYWlsYm94IgogCWRlcGVuZHMgb24gQVJD
SF9NWEMgfHwgQ09NUElMRV9URVNUCmRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvTWFrZWZp
bGUgYi9kcml2ZXJzL21haWxib3gvTWFrZWZpbGUKaW5kZXggYzIyZmFkNmY2OTZiLi45MzkxOGE4
NGM5MWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWFpbGJveC9NYWtlZmlsZQorKysgYi9kcml2ZXJz
L21haWxib3gvTWFrZWZpbGUKQEAgLTcsNiArNyw4IEBAIG9iai0kKENPTkZJR19NQUlMQk9YX1RF
U1QpCSs9IG1haWxib3gtdGVzdC5vCiAKIG9iai0kKENPTkZJR19BUk1fTUhVKQkrPSBhcm1fbWh1
Lm8KIAorb2JqLSQoQ09ORklHX0FSTV9TTUNfTUJPWCkJKz0gYXJtLXNtYy1tYWlsYm94Lm8KKwog
b2JqLSQoQ09ORklHX0lNWF9NQk9YKQkrPSBpbXgtbWFpbGJveC5vCiAKIG9iai0kKENPTkZJR19B
Uk1BREFfMzdYWF9SV1RNX01CT1gpCSs9IGFybWFkYS0zN3h4LXJ3dG0tbWFpbGJveC5vCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21haWxib3gvYXJtLXNtYy1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxi
b3gvYXJtLXNtYy1tYWlsYm94LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAw
MDAwLi5mNGRhMTA2MWY3ZjAKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL21haWxib3gvYXJt
LXNtYy1tYWlsYm94LmMKQEAgLTAsMCArMSwxNTQgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wCisvKgorICogQ29weXJpZ2h0IChDKSAyMDE2LDIwMTcgQVJNIEx0ZC4KKyAq
IENvcHlyaWdodCAyMDE5IE5YUAorICovCisKKyNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4K
KyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNp
bmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4KKyNpbmNsdWRlIDxsaW51eC9tYWls
Ym94L2FybS1zbWMtbWFpbGJveC5oPgorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1
ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorCisjZGVmaW5lIEFSTV9TTUNfTUJPWF9VU0Vf
SFZDCUJJVCgwKQorCitzdHJ1Y3QgYXJtX3NtY19jaGFuX2RhdGEgeworCXUzMiBmdW5jdGlvbl9p
ZDsKKwl1MzIgZmxhZ3M7Cit9OworCitzdGF0aWMgaW50IGFybV9zbWNfc2VuZF9kYXRhKHN0cnVj
dCBtYm94X2NoYW4gKmxpbmssIHZvaWQgKmRhdGEpCit7CisJc3RydWN0IGFybV9zbWNfY2hhbl9k
YXRhICpjaGFuX2RhdGEgPSBsaW5rLT5jb25fcHJpdjsKKwlzdHJ1Y3QgYXJtX3NtY2NjX21ib3hf
Y21kICpjbWQgPSBkYXRhOworCXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsKKwl1MzIgZnVuY3Rp
b25faWQ7CisKKwlpZiAoY2hhbl9kYXRhLT5mdW5jdGlvbl9pZCAhPSBVSU5UX01BWCkKKwkJZnVu
Y3Rpb25faWQgPSBjaGFuX2RhdGEtPmZ1bmN0aW9uX2lkOworCWVsc2UKKwkJZnVuY3Rpb25faWQg
PSBjbWQtPmEwOworCisJaWYgKGNoYW5fZGF0YS0+ZmxhZ3MgJiBBUk1fU01DX01CT1hfVVNFX0hW
QykKKwkJYXJtX3NtY2NjX2h2YyhmdW5jdGlvbl9pZCwgY21kLT5hMSwgY21kLT5hMiwgY21kLT5h
MywgY21kLT5hNCwKKwkJCSAgICAgIGNtZC0+YTUsIGNtZC0+YTYsIGNtZC0+YTcsICZyZXMpOwor
CWVsc2UKKwkJYXJtX3NtY2NjX3NtYyhmdW5jdGlvbl9pZCwgY21kLT5hMSwgY21kLT5hMiwgY21k
LT5hMywgY21kLT5hNCwKKwkJCSAgICAgIGNtZC0+YTUsIGNtZC0+YTYsIGNtZC0+YTcsICZyZXMp
OworCisJbWJveF9jaGFuX3JlY2VpdmVkX2RhdGEobGluaywgKHZvaWQgKilyZXMuYTApOworCisJ
cmV0dXJuIDA7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBhcm1fc21j
X21ib3hfY2hhbl9vcHMgPSB7CisJLnNlbmRfZGF0YQk9IGFybV9zbWNfc2VuZF9kYXRhLAorfTsK
Kworc3RhdGljIGludCBhcm1fc21jX21ib3hfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKK3sKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2OworCXN0cnVjdCBtYm94
X2NvbnRyb2xsZXIgKm1ib3g7CisJc3RydWN0IGFybV9zbWNfY2hhbl9kYXRhICpjaGFuX2RhdGE7
CisJY29uc3QgY2hhciAqbWV0aG9kOworCWJvb2wgdXNlX2h2YyA9IGZhbHNlOworCWludCByZXQs
IGk7CisJdTMyIHZhbDsKKworCWlmICghb2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2LT5vZl9ub2Rl
LCAiYXJtLG51bS1jaGFucyIsICZ2YWwpKSB7CisJCWlmICh2YWwgPCAxIHx8IHZhbCA+IElOVF9N
QVgpIHsKKwkJCWRldl9lcnIoZGV2LCAiaW52YWxpZCBhcm0sbnVtLWNoYW5zIHZhbHVlICV1IG9m
ICVwT0ZuXG4iLCB2YWwsIHBkZXYtPmRldi5vZl9ub2RlKTsKKwkJCXJldHVybiAtRUlOVkFMOwor
CQl9CisJfQorCisJaWYgKCFvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYtPm9mX25vZGUsICJt
ZXRob2QiLCAmbWV0aG9kKSkgeworCQlpZiAoIXN0cmNtcCgiaHZjIiwgbWV0aG9kKSkgeworCQkJ
dXNlX2h2YyA9IHRydWU7CisJCX0gZWxzZSBpZiAoIXN0cmNtcCgic21jIiwgbWV0aG9kKSkgewor
CQkJdXNlX2h2YyA9IGZhbHNlOworCQl9IGVsc2UgeworCQkJZGV2X3dhcm4oZGV2LCAiaW52YWxp
ZCBcIm1ldGhvZFwiIHByb3BlcnR5OiAlc1xuIiwKKwkJCQkgbWV0aG9kKTsKKworCQkJcmV0dXJu
IC1FSU5WQUw7CisJCX0KKwl9CisKKwltYm94ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpt
Ym94KSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFtYm94KQorCQlyZXR1cm4gLUVOT01FTTsKKworCW1i
b3gtPm51bV9jaGFucyA9IHZhbDsKKwltYm94LT5jaGFucyA9IGRldm1fa2NhbGxvYyhkZXYsIG1i
b3gtPm51bV9jaGFucywgc2l6ZW9mKCptYm94LT5jaGFucyksCisJCQkJICAgR0ZQX0tFUk5FTCk7
CisJaWYgKCFtYm94LT5jaGFucykKKwkJcmV0dXJuIC1FTk9NRU07CisKKwljaGFuX2RhdGEgPSBk
ZXZtX2tjYWxsb2MoZGV2LCBtYm94LT5udW1fY2hhbnMsIHNpemVvZigqY2hhbl9kYXRhKSwKKwkJ
CQkgR0ZQX0tFUk5FTCk7CisJaWYgKCFjaGFuX2RhdGEpCisJCXJldHVybiAtRU5PTUVNOworCisJ
Zm9yIChpID0gMDsgaSA8IG1ib3gtPm51bV9jaGFuczsgaSsrKSB7CisJCXUzMiBmdW5jdGlvbl9p
ZDsKKworCQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsCisJ
CQkJCQkgImFybSxmdW5jLWlkcyIsIGksCisJCQkJCQkgJmZ1bmN0aW9uX2lkKTsKKwkJaWYgKHJl
dCkKKwkJCWNoYW5fZGF0YVtpXS5mdW5jdGlvbl9pZCA9IFVJTlRfTUFYOworCisJCWVsc2UKKwkJ
CWNoYW5fZGF0YVtpXS5mdW5jdGlvbl9pZCA9IGZ1bmN0aW9uX2lkOworCisJCWlmICh1c2VfaHZj
KQorCQkJY2hhbl9kYXRhW2ldLmZsYWdzIHw9IEFSTV9TTUNfTUJPWF9VU0VfSFZDOworCQltYm94
LT5jaGFuc1tpXS5jb25fcHJpdiA9ICZjaGFuX2RhdGFbaV07CisJfQorCisJbWJveC0+dHhkb25l
X3BvbGwgPSBmYWxzZTsKKwltYm94LT50eGRvbmVfaXJxID0gZmFsc2U7CisJbWJveC0+b3BzID0g
JmFybV9zbWNfbWJveF9jaGFuX29wczsKKwltYm94LT5kZXYgPSBkZXY7CisKKwlyZXQgPSBtYm94
X2NvbnRyb2xsZXJfcmVnaXN0ZXIobWJveCk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1ib3gpOworCWRldl9pbmZvKGRldiwgIkFSTSBT
TUMgbWFpbGJveCBlbmFibGVkIHdpdGggJWQgY2hhbiVzLlxuIiwKKwkJIG1ib3gtPm51bV9jaGFu
cywgbWJveC0+bnVtX2NoYW5zID09IDEgPyAiIiA6ICJzIik7CisKKwlyZXR1cm4gcmV0OworfQor
CitzdGF0aWMgaW50IGFybV9zbWNfbWJveF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikKK3sKKwlzdHJ1Y3QgbWJveF9jb250cm9sbGVyICptYm94ID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEocGRldik7CisKKwltYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcihtYm94KTsKKwlyZXR1
cm4gMDsKK30KKworc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXJtX3NtY19tYm94
X29mX21hdGNoW10gPSB7CisJeyAuY29tcGF0aWJsZSA9ICJhcm0sc21jLW1ib3giLCB9LAorCXt9
LAorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFybV9zbWNfbWJveF9vZl9tYXRjaCk7CisK
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGFybV9zbWNfbWJveF9kcml2ZXIgPSB7CisJ
LmRyaXZlciA9IHsKKwkJLm5hbWUgPSAiYXJtLXNtYy1tYm94IiwKKwkJLm9mX21hdGNoX3RhYmxl
ID0gYXJtX3NtY19tYm94X29mX21hdGNoLAorCX0sCisJLnByb2JlCQk9IGFybV9zbWNfbWJveF9w
cm9iZSwKKwkucmVtb3ZlCQk9IGFybV9zbWNfbWJveF9yZW1vdmUsCit9OworbW9kdWxlX3BsYXRm
b3JtX2RyaXZlcihhcm1fc21jX21ib3hfZHJpdmVyKTsKKworTU9EVUxFX0FVVEhPUigiQW5kcmUg
UHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFybS5jb20+Iik7CitNT0RVTEVfREVTQ1JJUFRJT04o
IkdlbmVyaWMgQVJNIHNtYyBtYWlsYm94IGRyaXZlciIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCB2
MiIpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L2FybS1zbWMtbWFpbGJveC5o
IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L2FybS1zbWMtbWFpbGJveC5oCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uY2EzNjZmZTQ5MWMzCi0tLSAvZGV2L251bGwKKysr
IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L2FybS1zbWMtbWFpbGJveC5oCkBAIC0wLDAgKzEsMTAg
QEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCisKKyNpZm5kZWYgX0xJ
TlVYX0FSTV9TTUNfTUFJTEJPWF9IXworI2RlZmluZSBfTElOVVhfQVJNX1NNQ19NQUlMQk9YX0hf
CisKK3N0cnVjdCBhcm1fc21jY2NfbWJveF9jbWQgeworCXVuc2lnbmVkIGxvbmcgYTAsIGExLCBh
MiwgYTMsIGE0LCBhNSwgYTYsIGE3OworfTsKKworI2VuZGlmIC8qIF9MSU5VWF9BUk1fU01DX01B
SUxCT1hfSF8gKi8KLS0gCjIuMTYuNAoK
