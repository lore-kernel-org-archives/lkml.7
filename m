Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CC5206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="e9LdZ+ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfJHJnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:43:03 -0400
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:23278
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729375AbfJHJnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZMurFxnZyrI1uurKQ/jocI81c4dDyJru/T0eR839MzETwS11H7MzvOZHIn2bDDWcvEeFBqnalIo8YVZHw5oXE9BbunbWPokvllubqFZOjkL3FQCTaI0TTcdGp4MDJZIPzphy7HrUhVFn8l7WS4aXTdmwK3z48VaIdOsFg/6bBxIbTJLngOyqEJMjDtz7AfkB15lhXnGBdVL6x0Tw8/od5kPvwzUsE2pkVth5EeIYmJ3e2UPa2IxaeJdbmE9ZPCelYS0H71apBNI9S6gUO+m/nR7t9cthj4giVSI2dBj6DM0yvzKvK64GRwLxDHnfIVhQoje9L4BJJu9Av4ntYiMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUqUmEftq2aZ6jfEJ5ZoRCPqYUOOwqLliTxtuEIUy5I=;
 b=U433cw5x8FtRf4Ip/S9qnwJW8jd/bDpRjUeH+rYglk4uvemLVCDOgEDyEXPAT7sNlaWqLSIc1tyt6xG1V95I0oHljlk85+H+fGRIhTxD92gRiI057UrKBO145qnc7q7+0MUdvrmrJ1MjP6A6/ssgm27OfKI9u20ydVVQDBSUOBmhBpywXRFCo58e7HSV0GfJYZeabOgLXWXlnIJd8ON9fBSRbXCKgX+PpBKt8SIWYAw5KPS98C0v9NLOFkKOdCUPvmJxja24KSaySRu/B5hqwLOqR+ZFel6f7kZW9Shb6E25ZixbVqMzOsBxw1wtTblesMvc6dIPFzCdccqecdvQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUqUmEftq2aZ6jfEJ5ZoRCPqYUOOwqLliTxtuEIUy5I=;
 b=e9LdZ+ZEGxiRSE0fkAl3oWcF+smIq29EHArXlKgZJR9JKTvWt/PEw7alwDxc5up1Hi4Zr0VyqcZDIm5hWrZRqrUwqgO6OFB9/bGxg1M7o3dzw2LSMsrdF8t+r5fsFlrVo3lJpvuV2cKSqPKpn1I3s7gQZvL/NL4twUyElmaPoGc=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4333.namprd11.prod.outlook.com (10.255.90.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 09:42:59 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 09:42:59 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/7] staging: wfx: simplify memory allocation in
 wfx_update_filtering()
Thread-Topic: [PATCH 1/7] staging: wfx: simplify memory allocation in
 wfx_update_filtering()
Thread-Index: AQHVfbzEpoJkh9PJ3UW4evVwGZrCfw==
Date:   Tue, 8 Oct 2019 09:42:58 +0000
Message-ID: <20191008094232.10014-2-Jerome.Pouiller@silabs.com>
References: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20191008094232.10014-1-Jerome.Pouiller@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e975099-acf4-49ed-dee5-08d74bd3e7a4
x-ms-traffictypediagnostic: MN2PR11MB4333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43334FE7D9BBEC7C28D02168939A0@MN2PR11MB4333.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39850400004)(199004)(189003)(54906003)(66574012)(1076003)(6436002)(6512007)(5640700003)(25786009)(305945005)(66066001)(316002)(7736002)(99286004)(76176011)(2351001)(6506007)(8936002)(86362001)(2501003)(71200400001)(71190400001)(102836004)(6486002)(14454004)(8676002)(6916009)(81166006)(81156014)(478600001)(1730700003)(4326008)(76116006)(26005)(446003)(14444005)(64756008)(66556008)(476003)(256004)(66476007)(66446008)(186003)(3846002)(66946007)(2616005)(6116002)(486006)(11346002)(2906002)(36756003)(91956017)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4333;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYb/Y5C2xJRu4/0mjvGR+WStYZrz865Vw2fGSEwXCbgVtQiCJeBEn2I5yU3fo7m5RUd5AsJNKsJl8WiQgs/9qdPS60oqIfavRQy5RYAziSAHOPK53ZYCWiyhk5fO2IybdWGPH+ukDeXDZtqQ4FbKHQAMoi1CgjKl/JqCJ0b/XJ9EWRobPxiW4AGT9QPKWdC8aOCU1MEEY9kucoI+YBi/0g15I6fPCoCPkIiRwZR3vutNtCRLwM+Ukh6sTj70dvBoF3CTMpknOgwNgY2F/zoCr724Kdpy4+O/QWJAw6Ec1jFzRa1Hq3NKHv5Ol28/iSKsd8nM6YpSMqQyHC2GY0kpllmzPaip8HqCfsXeZcmFUII5ku44eu0swi+J/F2av3LRoVAPCHwmwpwNOvlPS9Q6hG+PISQaqz5IY9DpaoVxWR8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D5759626EFD574DBC3E8886442F6F15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e975099-acf4-49ed-dee5-08d74bd3e7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:42:58.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71GgIrFi2+mtRuOI1NnOW9RMueUjcyM1R5dtc7DMx+h9kOckjzn8DhR9waMkmcPooZ0KE2vlrOS3ra3Ok3hqxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPg0KDQpP
cmlnaW5hbCBjb2RlIGRpZCBub3QgaGFuZGxlIGNhc2Ugd2hlcmUga21hbGxvYyBmYWlsZWQuIEJ5
IHRoZSB3YXksIGl0DQppcyBtb3JlIGNvbnZlbmllbnQgdG8gYWxsb2NhdGUgYW5kIGJ1aWxkIEhJ
RiBtZXNzYWdlIGluDQpoaWZfc2V0X2JlYWNvbl9maWx0ZXJfdGFibGUoKSBpbnN0ZWFkIG9mIHRv
IGFzayB0byBjYWxsZXIgZnVuY3Rpb24gdG8NCmJ1aWxkIGl0Lg0KDQpGaXhlczogNDAxMTViYmM0
MGUyICgic3RhZ2luZzogd2Z4OiBpbXBsZW1lbnQgdGhlIHJlc3Qgb2YgbWFjODAyMTEgQVBJIikN
ClJlcG9ydGVkLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2lsYWJzLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvc3RhZ2luZy93ZngvaGlmX3R4X21pYi5oIHwgMTkgKysrKysrKysrKysrKyst
LS0tLQ0KIGRyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmMgICAgICAgIHwgMTcgKysrKysrKy0tLS0t
LS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmggYi9kcml2
ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eF9taWIuaA0KaW5kZXggZjY2MjRhNDAzMDE2Li4xNjdjNWRl
YzAwOWYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3N0YWdpbmcvd2Z4L2hpZl90eF9taWIuaA0KKysr
IGIvZHJpdmVycy9zdGFnaW5nL3dmeC9oaWZfdHhfbWliLmgNCkBAIC04NiwxMyArODYsMjIgQEAg
c3RhdGljIGlubGluZSBpbnQgaGlmX3NldF9yeF9maWx0ZXIoc3RydWN0IHdmeF92aWYgKnd2aWYs
IGJvb2wgZmlsdGVyX2Jzc2lkLA0KIH0NCiANCiBzdGF0aWMgaW5saW5lIGludCBoaWZfc2V0X2Jl
YWNvbl9maWx0ZXJfdGFibGUoc3RydWN0IHdmeF92aWYgKnd2aWYsDQotCQkJCQkgICAgICBzdHJ1
Y3QgaGlmX21pYl9iY25fZmlsdGVyX3RhYmxlICpmdCkNCisJCQkJCSAgICAgIGludCB0YmxfbGVu
LA0KKwkJCQkJICAgICAgc3RydWN0IGhpZl9pZV90YWJsZV9lbnRyeSAqdGJsKQ0KIHsNCi0Jc2l6
ZV90IGJ1Zl9sZW4gPSBzdHJ1Y3Rfc2l6ZShmdCwgaWVfdGFibGUsIGZ0LT5udW1fb2ZfaW5mb19l
bG10cyk7DQorCWludCByZXQ7DQorCXN0cnVjdCBoaWZfbWliX2Jjbl9maWx0ZXJfdGFibGUgKnZh
bDsNCisJaW50IGJ1Zl9sZW4gPSBzdHJ1Y3Rfc2l6ZSh2YWwsIGllX3RhYmxlLCB0YmxfbGVuKTsN
CiANCi0JY3B1X3RvX2xlMzJzKCZmdC0+bnVtX29mX2luZm9fZWxtdHMpOw0KLQlyZXR1cm4gaGlm
X3dyaXRlX21pYih3dmlmLT53ZGV2LCB3dmlmLT5pZCwNCi0JCQkgICAgIEhJRl9NSUJfSURfQkVB
Q09OX0ZJTFRFUl9UQUJMRSwgZnQsIGJ1Zl9sZW4pOw0KKwl2YWwgPSBremFsbG9jKGJ1Zl9sZW4s
IEdGUF9LRVJORUwpOw0KKwlpZiAoIXZhbCkNCisJCXJldHVybiAtRU5PTUVNOw0KKwl2YWwtPm51
bV9vZl9pbmZvX2VsbXRzID0gY3B1X3RvX2xlMzIodGJsX2xlbik7DQorCW1lbWNweSh2YWwtPmll
X3RhYmxlLCB0YmwsIHRibF9sZW4gKiBzaXplb2YoKnRibCkpOw0KKwlyZXQgPSBoaWZfd3JpdGVf
bWliKHd2aWYtPndkZXYsIHd2aWYtPmlkLA0KKwkJCSAgICBISUZfTUlCX0lEX0JFQUNPTl9GSUxU
RVJfVEFCTEUsIHZhbCwgYnVmX2xlbik7DQorCWtmcmVlKHZhbCk7DQorCXJldHVybiByZXQ7DQog
fQ0KIA0KIHN0YXRpYyBpbmxpbmUgaW50IGhpZl9iZWFjb25fZmlsdGVyX2NvbnRyb2woc3RydWN0
IHdmeF92aWYgKnd2aWYsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYyBi
L2RyaXZlcnMvc3RhZ2luZy93Zngvc3RhLmMNCmluZGV4IDI4NTVkMTRhNzA5Yy4uMTIxOThiOGYz
Njg1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9zdGEuYw0KKysrIGIvZHJpdmVy
cy9zdGFnaW5nL3dmeC9zdGEuYw0KQEAgLTIxNywxNCArMjE3LDEzIEBAIHZvaWQgd2Z4X3VwZGF0
ZV9maWx0ZXJpbmcoc3RydWN0IHdmeF92aWYgKnd2aWYpDQogCWJvb2wgZmlsdGVyX2Jzc2lkID0g
d3ZpZi0+ZmlsdGVyX2Jzc2lkOw0KIAlib29sIGZ3ZF9wcm9iZV9yZXEgPSB3dmlmLT5md2RfcHJv
YmVfcmVxOw0KIAlzdHJ1Y3QgaGlmX21pYl9iY25fZmlsdGVyX2VuYWJsZSBiZl9jdHJsOw0KLQlz
dHJ1Y3QgaGlmX21pYl9iY25fZmlsdGVyX3RhYmxlICpiZl90Ymw7DQotCXN0cnVjdCBoaWZfaWVf
dGFibGVfZW50cnkgaWVfdGJsW10gPSB7DQorCXN0cnVjdCBoaWZfaWVfdGFibGVfZW50cnkgZmls
dGVyX2llc1tdID0gew0KIAkJew0KIAkJCS5pZV9pZCAgICAgICAgPSBXTEFOX0VJRF9WRU5ET1Jf
U1BFQ0lGSUMsDQogCQkJLmhhc19jaGFuZ2VkICA9IDEsDQogCQkJLm5vX2xvbmdlciAgICA9IDEs
DQogCQkJLmhhc19hcHBlYXJlZCA9IDEsDQotCQkJLm91aSAgICAgICAgID0geyAweDUwLCAweDZG
LCAweDlBfSwNCisJCQkub3VpICAgICAgICAgID0geyAweDUwLCAweDZGLCAweDlBIH0sDQogCQl9
LCB7DQogCQkJLmllX2lkICAgICAgICA9IFdMQU5fRUlEX0hUX09QRVJBVElPTiwNCiAJCQkuaGFz
X2NoYW5nZWQgID0gMSwNCkBAIC0yMzcsMzYgKzIzNiwzNCBAQCB2b2lkIHdmeF91cGRhdGVfZmls
dGVyaW5nKHN0cnVjdCB3ZnhfdmlmICp3dmlmKQ0KIAkJCS5oYXNfYXBwZWFyZWQgPSAxLA0KIAkJ
fQ0KIAl9Ow0KKwlpbnQgbl9maWx0ZXJfaWVzOw0KIA0KIAlpZiAod3ZpZi0+c3RhdGUgPT0gV0ZY
X1NUQVRFX1BBU1NJVkUpDQogCQlyZXR1cm47DQogDQotCWJmX3RibCA9IGttYWxsb2Moc2l6ZW9m
KHN0cnVjdCBoaWZfbWliX2Jjbl9maWx0ZXJfdGFibGUpICsgc2l6ZW9mKGllX3RibCksIEdGUF9L
RVJORUwpOw0KLQltZW1jcHkoYmZfdGJsLT5pZV90YWJsZSwgaWVfdGJsLCBzaXplb2YoaWVfdGJs
KSk7DQogCWlmICh3dmlmLT5kaXNhYmxlX2JlYWNvbl9maWx0ZXIpIHsNCiAJCWJmX2N0cmwuZW5h
YmxlID0gMDsNCiAJCWJmX2N0cmwuYmNuX2NvdW50ID0gMTsNCi0JCWJmX3RibC0+bnVtX29mX2lu
Zm9fZWxtdHMgPSAwOw0KKwkJbl9maWx0ZXJfaWVzID0gMDsNCiAJfSBlbHNlIGlmICghaXNfc3Rh
KSB7DQogCQliZl9jdHJsLmVuYWJsZSA9IEhJRl9CRUFDT05fRklMVEVSX0VOQUJMRSB8IEhJRl9C
RUFDT05fRklMVEVSX0FVVE9fRVJQOw0KIAkJYmZfY3RybC5iY25fY291bnQgPSAwOw0KLQkJYmZf
dGJsLT5udW1fb2ZfaW5mb19lbG10cyA9IDI7DQorCQluX2ZpbHRlcl9pZXMgPSAyOw0KIAl9IGVs
c2Ugew0KIAkJYmZfY3RybC5lbmFibGUgPSBISUZfQkVBQ09OX0ZJTFRFUl9FTkFCTEU7DQogCQli
Zl9jdHJsLmJjbl9jb3VudCA9IDA7DQotCQliZl90YmwtPm51bV9vZl9pbmZvX2VsbXRzID0gMzsN
CisJCW5fZmlsdGVyX2llcyA9IDM7DQogCX0NCiANCiAJcmV0ID0gaGlmX3NldF9yeF9maWx0ZXIo
d3ZpZiwgZmlsdGVyX2Jzc2lkLCBmd2RfcHJvYmVfcmVxKTsNCiAJaWYgKCFyZXQpDQotCQlyZXQg
PSBoaWZfc2V0X2JlYWNvbl9maWx0ZXJfdGFibGUod3ZpZiwgYmZfdGJsKTsNCisJCXJldCA9IGhp
Zl9zZXRfYmVhY29uX2ZpbHRlcl90YWJsZSh3dmlmLCBuX2ZpbHRlcl9pZXMsIGZpbHRlcl9pZXMp
Ow0KIAlpZiAoIXJldCkNCiAJCXJldCA9IGhpZl9iZWFjb25fZmlsdGVyX2NvbnRyb2wod3ZpZiwg
YmZfY3RybC5lbmFibGUsIGJmX2N0cmwuYmNuX2NvdW50KTsNCiAJaWYgKCFyZXQpDQogCQlyZXQg
PSB3Znhfc2V0X21jYXN0X2ZpbHRlcih3dmlmLCAmd3ZpZi0+bWNhc3RfZmlsdGVyKTsNCiAJaWYg
KHJldCkNCiAJCWRldl9lcnIod3ZpZi0+d2Rldi0+ZGV2LCAidXBkYXRlIGZpbHRlcmluZyBmYWls
ZWQ6ICVkXG4iLCByZXQpOw0KLQlrZnJlZShiZl90YmwpOw0KIH0NCiANCiB2b2lkIHdmeF91cGRh
dGVfZmlsdGVyaW5nX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KLS0gDQoyLjIwLjEN
Cg==
