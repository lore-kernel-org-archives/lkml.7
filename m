Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B57C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13E721883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 01:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="HVGCUZYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDBQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 21:16:00 -0400
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:55992
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfIDBP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 21:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4m3+zKbmIxiGw1eIJoRkhJ2WixwVYqkM8sMOkk/LJ/AN5JMriBBN+bG/oico7RvRUBS8gh7EXK9Z59uxTJ+8ErOQG1X9lRpZaE2HuXfmc409N7vVEt6hsgPglPjqGGCqLl/MojyN2zO/M4tqy6Lqg2qFAwm/CNxdHchkNATz/Vu4dC1VEp7phg3034TVDr4K6orH5F8qO9V1TTPybeF6e9uoVVZ+I1Y6Y4ZUngFB75Anyfz6VFNEqzURuB17oZsoDo4Wq8Et9AK0IWrs6Ict8Og+DmNdauubrBMJpvKw26DummJl/QPIRbMWeYeLA1ruOnmnR0W/vuZSHUbZiVkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3babSxIq1AkDW/tby+yaJXBIM7rOnActahUZ7Do/CEU=;
 b=l90r9olf9NX32HPJxiU0Tz5EwWcxiAZJARmlTHd3UpdIgmtnYYjy4JoM7i01b766jqhkzggbbdOpWdxFjA9o0pq2RpCGvEb0YcHNNJ4Vzs21eSSgjVXJqKAl9Dks0PR6D4YSCHDvUkidzQB/Y+SFZqSr4xjwbZBNYwfEF9EJb9oTinne/2auQQqlIEq9Ob1N/yRAG8ltYw1k2pqkLfS2Xmw6uaWpkWQeEDqE9Ph04AlTCDL8lDc6hzyvldm6TJGJN3zjGaaGWofEpMRsJr4fkt0WDpxMzs5fJ6VCKRje6zXTbq0TrEjRmer4wlG+z6TdUiCNR71NZELFsNzh8M1E2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3babSxIq1AkDW/tby+yaJXBIM7rOnActahUZ7Do/CEU=;
 b=HVGCUZYMzwbcr/8uMu09tXM3e+2YdUYKEr+8aCqwRISVVDJY8qqNOoeP1ZlZqmCN3vKTfDFb7dPdmFH+vSzej7pPX/9juo8Ba5ZZ6hRVTwlu0elZAN70blEBm4UR5bdlEd9tPBStD1LlOUaWGCoHhJQBD7VRvXt6S7yFMM7imsc=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2089.namprd11.prod.outlook.com (10.174.106.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 01:15:25 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42%6]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 01:15:25 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Enrico Weigelt <info@metux.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] mtd: spi-nor: intel-spi: add support for Intel Cannon
 Lake SPI flash
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Index: AQHVYr46w+9V00BKOEGkHvwLMfTVVQ==
Date:   Wed, 4 Sep 2019 01:15:24 +0000
Message-ID: <d62dec18-fed4-7ac5-35c8-25f1be2201a9@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.107.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 703ba343-f697-440b-4259-08d730d55d55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2089;
x-ms-traffictypediagnostic: DM5PR1101MB2089:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2089542C07D553CD6D31BC3EAAB80@DM5PR1101MB2089.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39840400004)(136003)(189003)(199004)(7736002)(25786009)(3846002)(14454004)(2906002)(6486002)(52116002)(5660300002)(6116002)(81166006)(81156014)(31696002)(8676002)(2201001)(508600001)(99286004)(966005)(86362001)(6436002)(8936002)(305945005)(316002)(66066001)(36756003)(31686004)(110136005)(6306002)(386003)(71190400001)(1250700005)(6506007)(71200400001)(6512007)(66476007)(66556008)(64756008)(66446008)(102836004)(7416002)(66946007)(53936002)(476003)(2616005)(486006)(256004)(2501003)(186003)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2089;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VajoxocxbQvxkhu3iHF1V8J+SZaGkolrd4G9Fpw1NM0ety56xYzhMPD3aIB1Bb247BoJ+dsFRXKnpCjg0BHZitK0KNUl2PNNpthbU6dTnme38BxJoTbG6CwRMpzkHRociSwPZGI8XJHbxtB8xPIqstaTzl7E7dIPsPAIIP/L0bMQHQmAyIackbGoEx+fst0bSX5C94imcdmAxfD+qPn+cQRtfVDJ0he0SqUB1tjkC6OaosRH/3MVLGwzvs9tTk8wwOohoaW9VZvC18LDxqgMFjS5653RWoMNJCNGHWAAAXB/xwjpuWYFA4pWRzhw8ss6V4sR3XxvHWIgca70oa8iZ+Q0JtJjL4PYMFKZOrwUO2nh3thc8gXY9F1LsMASULiyY6+j4Ab7TCWsTA8rUSVtDOXbnUSU7TZFDrt8B+zMMEQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C4A7B5C732A749BCA6F17301106DDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703ba343-f697-440b-4259-08d730d55d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 01:15:24.9439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ozv2EapNECiQhAjL4mawEoc3jG5TERRTVNm5GeJyPWEODDOuM98dMJTnZ2O1l1rcmlsbEKah6UlEc5/rERTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm93IHRoYXQgU1BJIGZsYXNoIGNvbnRyb2xsZXJzIHdpdGhvdXQgYSBzb2Z0d2FyZSBzZXF1ZW5j
ZXIgYXJlDQpzdXBwb3J0ZWQsIGl0J3MgdHJpdmlhbCB0byBhZGQgc3VwcG9ydCBmb3IgQ05MIGFu
ZCBpdHMgUENJIElELg0KDQpWYWx1ZXMgZnJvbSBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVu
dC9kYW0vd3d3L3B1YmxpYy91cy9lbi9kb2N1bWVudHMvZGF0YXNoZWV0cy8zMDAtc2VyaWVzLWNo
aXBzZXQtcGNoLWRhdGFzaGVldC12b2wtMi5wZGYNCg0KU2lnbmVkLW9mZi1ieTogSmV0aHJvIEJl
ZWttYW4gPGpldGhyb0Bmb3J0YW5peC5jb20+DQotLS0NCiBkcml2ZXJzL210ZC9zcGktbm9yL2lu
dGVsLXNwaS1wY2kuYyAgICAgfCAgNSArKysrKw0KIGRyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwt
c3BpLmMgICAgICAgICB8IDExICsrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9k
YXRhL2ludGVsLXNwaS5oIHwgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGktcGNpLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS1wY2kuYw0KaW5kZXggYjgzYzRhYjYuLjE5NWEw
OWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS1wY2kuYw0KKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGktcGNpLmMNCkBAIC0yMCw2ICsyMCwxMCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGludGVsX3NwaV9ib2FyZGluZm8gYnh0X2luZm8gPSB7DQog
CS50eXBlID0gSU5URUxfU1BJX0JYVCwNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW50
ZWxfc3BpX2JvYXJkaW5mbyBjbmxfaW5mbyA9IHsNCisJLnR5cGUgPSBJTlRFTF9TUElfQ05MLA0K
K307DQorDQogc3RhdGljIGludCBpbnRlbF9zcGlfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LA0KIAkJCSAgICAgICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpDQogew0KQEAg
LTY3LDYgKzcxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIGludGVsX3Nw
aV9wY2lfaWRzW10gPSB7DQogCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4NGIyNCksICh1bnNpZ25l
ZCBsb25nKSZieHRfaW5mbyB9LA0KIAl7IFBDSV9WREVWSUNFKElOVEVMLCAweGExYTQpLCAodW5z
aWduZWQgbG9uZykmYnh0X2luZm8gfSwNCiAJeyBQQ0lfVkRFVklDRShJTlRFTCwgMHhhMjI0KSwg
KHVuc2lnbmVkIGxvbmcpJmJ4dF9pbmZvIH0sDQorCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4YTMy
NCksICh1bnNpZ25lZCBsb25nKSZjbmxfaW5mbyB9LA0KIAl7IH0sDQogfTsNCiBNT0RVTEVfREVW
SUNFX1RBQkxFKHBjaSwgaW50ZWxfc3BpX3BjaV9pZHMpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvaW50ZWwtc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5j
DQppbmRleCAxOTVjZGNhLi45MWI3ODUxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9pbnRlbC1zcGkuYw0KKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGkuYw0KQEAg
LTEwOCw2ICsxMDgsMTAgQEANCiAjZGVmaW5lIEJYVF9GUkVHX05VTQkJCTEyDQogI2RlZmluZSBC
WFRfUFJfTlVNCQkJNg0KIA0KKyNkZWZpbmUgQ05MX1BSCQkJCTB4ODQNCisjZGVmaW5lIENOTF9G
UkVHX05VTQkJCTYNCisjZGVmaW5lIENOTF9QUl9OVU0JCQk1DQorDQogI2RlZmluZSBMVlNDQwkJ
CQkweGM0DQogI2RlZmluZSBVVlNDQwkJCQkweGM4DQogI2RlZmluZSBFUkFTRV9PUENPREVfU0hJ
RlQJCTgNCkBAIC0zNDQsNiArMzQ4LDEzIEBAIHN0YXRpYyBpbnQgaW50ZWxfc3BpX2luaXQoc3Ry
dWN0IGludGVsX3NwaSAqaXNwaSkNCiAJCWlzcGktPmVyYXNlXzY0ayA9IHRydWU7DQogCQlicmVh
azsNCiANCisJY2FzZSBJTlRFTF9TUElfQ05MOg0KKwkJaXNwaS0+c3JlZ3MgPSBOVUxMOw0KKwkJ
aXNwaS0+cHJlZ3MgPSBpc3BpLT5iYXNlICsgQ05MX1BSOw0KKwkJaXNwaS0+bnJlZ2lvbnMgPSBD
TkxfRlJFR19OVU07DQorCQlpc3BpLT5wcl9udW0gPSBDTkxfUFJfTlVNOw0KKwkJYnJlYWs7DQor
DQogCWRlZmF1bHQ6DQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJfQ0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9pbnRlbC1zcGkuaCBiL2luY2x1ZGUvbGludXgvcGxhdGZv
cm1fZGF0YS9pbnRlbC1zcGkuaA0KaW5kZXggZWJiNGYzMy4uN2Y1M2E1YyAxMDA2NDQNCi0tLSBh
L2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9pbnRlbC1zcGkuaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9kYXRhL2ludGVsLXNwaS5oDQpAQCAtMTMsNiArMTMsNyBAQCBlbnVtIGlu
dGVsX3NwaV90eXBlIHsNCiAJSU5URUxfU1BJX0JZVCA9IDEsDQogCUlOVEVMX1NQSV9MUFQsDQog
CUlOVEVMX1NQSV9CWFQsDQorCUlOVEVMX1NQSV9DTkwsDQogfTsNCiANCiAvKioNCi0tIA0KMi43
LjQNCg0K
