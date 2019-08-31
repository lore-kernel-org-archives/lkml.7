Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB004C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F3E2343A
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="ojbolD2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfHaFt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 01:49:59 -0400
Received: from mail-eopbgr710101.outbound.protection.outlook.com ([40.107.71.101]:9296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfHaFt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDXqQlpUaM2c52QAkgdaM26nxElG1KhepOYlIJrzZmLRqteLnr71O3yZ5hcKMho18ikquQc8do59oTb/7/RyCxbI9MdxNN/Qj6pN1y6Eyw6IALo7cWM+B/Igh5Ap15SDEBC+7Ww2gTFkpxhwmhR5XvDwSwCk9d7X5on1tSb0vCbfmnUDYltJhvIoCkvcZVxPedr/LB2aI1+VFoMNp3sf3sqRbtrIyVvNMAuYAV4WFmgbY6LHtzyWgk3aoldXsZNtnK8ptIqexL9KlvSk2C87+PQFzgrPiMacarQWvjwfPiiba7QKwwSIWIWPzqkUkji1dCQPFwhe226kXMUaqzijGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLFLpxUPfX1v0zDKfPb4hIKOLPutjcFK4izP5QDSkUY=;
 b=cf90VDZBFiv81tBOtHWLWfUpI2Av1abFC6L/ZUzEJojPfW5q22TBsAeA5WVznsjvybeOwpPnnVsR0pcHIIVAHOuH45o+Ohu2FVnmSty2sc+F3dluuCGPpNBT5lqaLHDr9NbK7o+frKtoTzuqhDRSlzUb8JLTDZ9y+WdKL+i+zgUK7bPWC/GhS2YlfpAIRiJgvRI7ly+7au/WJIrTpD6tGnGBWAFAHTZ1rs4bnaZLf4TiHVKSwFlqxWwVie1Zx+7aZbt3zVaMubX9/mwTqUk4v6nzoyzhRg0dWSV+l/4eKxN+EvpEGMwAoioWL+3GoHzMl3viAAczhBZEr+6+Hzsbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLFLpxUPfX1v0zDKfPb4hIKOLPutjcFK4izP5QDSkUY=;
 b=ojbolD2fHRdUFKoapqzt+FipgNAjABMBHwRoltna+OH8MjtfKLSr+rB4GT6+w0GciwNRKac+oKD3uiWufomCs25gbzVGSwkmbaVg72y5vVKuDP5rJ/405dTEI1VSo4N8JGVITXeE2e9a5JOzLVsToriQS+d/aezxk81yf8ZzH3k=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2283.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 31 Aug 2019 05:49:56 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410%6]) with mapi id 15.20.2199.021; Sat, 31 Aug 2019
 05:49:55 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jethro Beekman <jethro@fortanix.com>
Subject: [PATCH 1/2] mtd: spi-nor: intel-spi: support chips without software
 sequencer
Thread-Topic: [PATCH 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Index: AQHVX7/qHs3WRrvKbU6lbjtIdYhFxw==
Date:   Sat, 31 Aug 2019 05:49:55 +0000
Message-ID: <b4538dc6-4d48-1ec9-fe4f-586fbc93c1d1@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.236.28.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0a2ce7-e18c-479e-1d8e-08d72dd70ceb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2283;
x-ms-traffictypediagnostic: DM5PR1101MB2283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB22839C64BA8FCCB66749C359AABC0@DM5PR1101MB2283.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39830400003)(396003)(346002)(189003)(199004)(6436002)(31696002)(7736002)(86362001)(99286004)(6486002)(2201001)(5660300002)(81166006)(66556008)(14454004)(71190400001)(14444005)(64756008)(66476007)(486006)(476003)(478600001)(26005)(71200400001)(52116002)(66946007)(256004)(66446008)(81156014)(3846002)(31686004)(36756003)(8676002)(2501003)(316002)(6512007)(386003)(2616005)(25786009)(4326008)(186003)(107886003)(66066001)(53936002)(305945005)(102836004)(8936002)(110136005)(6506007)(6116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2283;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4dOsDDk3gJCw+iYAZit0Xv2Xxe7TYp5kZt6DODEQbgJBJVWmH5FKEV6thlQ8x/Zeq1iqbLhSYV+6CGKyQ5pi25CrxVF9nXoWDwxx5Sx8FydsneLm8i/iLjB/c8yJ3m4gBzEYYXvz0+20UD6MXgfc97ocZuS03iEx+rk8FaFod/u4zeR7Hf7IsCAwDr4+0bHMVks/FX1h2lL/D20ycU5s+oOW04ktF54H/YxsGk9BldnuEK+Vputm9fMs+1rzdF6yAIjFEEKH7UtMrKXt3Vbbz9OsnzuVaamfIs1WvEvsCSARQrVteE+xx+Y0v8Uc8wcEkqNdPXgkfGy2MYmwkifQuENULaz9BnjFR8P9hNExS2BD6ICht8GWZXUcnPMBQNvJPwTgwm8/8PMC2e84DnGQGB8+ss8N/1CkOAX4irZam58=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4E40AF52D22464AB42401EC2AC8FA02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a2ce7-e18c-479e-1d8e-08d72dd70ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 05:49:55.7786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czaPSsYww3VV8yaWbW/wvP5QpfIc5vwEiXvNwmNPspz/ZCt7xuFZe+IP/EE3oflykr8byUo4cqhBjenjlCRVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBmbGFzaCBjb250cm9sbGVycyBkb24ndCBoYXZlIGEgc29mdHdhcmUgc2VxdWVuY2VyLiBB
dm9pZA0KY29uZmlndXJpbmcgdGhlIHJlZ2lzdGVyIGFkZHJlc3NlcyBmb3IgaXQsIGFuZCBkb3Vi
bGUgY2hlY2sNCmV2ZXJ5d2hlcmUgdGhhdCBpdHMgbm90IGFjY2lkZW50YWxseSB0cnlpbmcgdG8g
YmUgdXNlZC4NCg0KRXZlcnkgdXNlIG9mIGBzcmVnc2AgaXMgbm93IGd1YXJkZWQgYnkgYSBjaGVj
ayBvZiBgc3JlZ3NgIG9yDQpgc3dzZXFfcmVnYC4gVGhlIGNoZWNrIG1pZ2h0IGJlIGRvbmUgaW4g
dGhlIGNhbGxpbmcgZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IEpldGhybyBCZWVrbWFuIDxq
ZXRocm9AZm9ydGFuaXguY29tPg0KLS0tDQogIGRyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3Bp
LmMgfCAyMyArKysrKysrKysrKysrKysrLS0tLS0tLQ0KICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvaW50ZWwtc3BpLmMgDQpiL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3BpLmMNCmlu
ZGV4IDFjY2YyM2YuLjE5NWNkY2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2lu
dGVsLXNwaS5jDQorKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jDQpAQCAtMTg3
LDEyICsxODcsMTYgQEAgc3RhdGljIHZvaWQgaW50ZWxfc3BpX2R1bXBfcmVncyhzdHJ1Y3QgaW50
ZWxfc3BpIA0KKmlzcGkpDQogIAkJZGV2X2RiZyhpc3BpLT5kZXYsICJQUiglZCk9MHglMDh4XG4i
LCBpLA0KICAJCQlyZWFkbChpc3BpLT5wcmVncyArIFBSKGkpKSk7DQogIC0JdmFsdWUgPSByZWFk
bChpc3BpLT5zcmVncyArIFNTRlNUU19DVEwpOw0KLQlkZXZfZGJnKGlzcGktPmRldiwgIlNTRlNU
U19DVEw9MHglMDh4XG4iLCB2YWx1ZSk7DQotCWRldl9kYmcoaXNwaS0+ZGV2LCAiUFJFT1BfT1BU
WVBFPTB4JTA4eFxuIiwNCi0JCXJlYWRsKGlzcGktPnNyZWdzICsgUFJFT1BfT1BUWVBFKSk7DQot
CWRldl9kYmcoaXNwaS0+ZGV2LCAiT1BNRU5VMD0weCUwOHhcbiIsIHJlYWRsKGlzcGktPnNyZWdz
ICsgT1BNRU5VMCkpOw0KLQlkZXZfZGJnKGlzcGktPmRldiwgIk9QTUVOVTE9MHglMDh4XG4iLCBy
ZWFkbChpc3BpLT5zcmVncyArIE9QTUVOVTEpKTsNCisJaWYgKGlzcGktPnNyZWdzKSB7DQorCQl2
YWx1ZSA9IHJlYWRsKGlzcGktPnNyZWdzICsgU1NGU1RTX0NUTCk7DQorCQlkZXZfZGJnKGlzcGkt
PmRldiwgIlNTRlNUU19DVEw9MHglMDh4XG4iLCB2YWx1ZSk7DQorCQlkZXZfZGJnKGlzcGktPmRl
diwgIlBSRU9QX09QVFlQRT0weCUwOHhcbiIsDQorCQkJcmVhZGwoaXNwaS0+c3JlZ3MgKyBQUkVP
UF9PUFRZUEUpKTsNCisJCWRldl9kYmcoaXNwaS0+ZGV2LCAiT1BNRU5VMD0weCUwOHhcbiIsDQor
CQkJcmVhZGwoaXNwaS0+c3JlZ3MgKyBPUE1FTlUwKSk7DQorCQlkZXZfZGJnKGlzcGktPmRldiwg
Ik9QTUVOVTE9MHglMDh4XG4iLA0KKwkJCXJlYWRsKGlzcGktPnNyZWdzICsgT1BNRU5VMSkpOw0K
Kwl9DQogICAJaWYgKGlzcGktPmluZm8tPnR5cGUgPT0gSU5URUxfU1BJX0JZVCkNCiAgCQlkZXZf
ZGJnKGlzcGktPmRldiwgIkJDUj0weCUwOHhcbiIsIHJlYWRsKGlzcGktPmJhc2UgKyBCWVRfQkNS
KSk7DQpAQCAtMzY3LDYgKzM3MSwxMSBAQCBzdGF0aWMgaW50IGludGVsX3NwaV9pbml0KHN0cnVj
dCBpbnRlbF9zcGkgKmlzcGkpDQogIAkJICAgICEodXZzY2MgJiBFUkFTRV82NEtfT1BDT0RFX01B
U0spKQ0KICAJCQlpc3BpLT5lcmFzZV82NGsgPSBmYWxzZTsNCiAgKwlpZiAoaXNwaS0+c3JlZ3Mg
PT0gTlVMTCAmJiAoaXNwaS0+c3dzZXFfcmVnIHx8IGlzcGktPnN3c2VxX2VyYXNlKSkgew0KKwkJ
ZGV2X2Vycihpc3BpLT5kZXYsICJzb2Z0d2FyZSBzZXF1ZW5jZXIgbm90IHN1cHBvcnRlZCwgYnV0
IHJlcXVpcmVkXG4iKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQogIAkvKg0KICAJICog
U29tZSBjb250cm9sbGVycyBjYW4gb25seSBkbyBiYXNpYyBvcGVyYXRpb25zIHVzaW5nIGhhcmR3
YXJlDQogIAkgKiBzZXF1ZW5jZXIuIEFsbCBvdGhlciBvcGVyYXRpb25zIGFyZSBzdXBwb3NlZCB0
byBiZSBjYXJyaWVkIG91dA0KQEAgLTM4Myw3ICszOTIsNyBAQCBzdGF0aWMgaW50IGludGVsX3Nw
aV9pbml0KHN0cnVjdCBpbnRlbF9zcGkgKmlzcGkpDQogIAl2YWwgPSByZWFkbChpc3BpLT5iYXNl
ICsgSFNGU1RTX0NUTCk7DQogIAlpc3BpLT5sb2NrZWQgPSAhISh2YWwgJiBIU0ZTVFNfQ1RMX0ZM
T0NLRE4pOw0KICAtCWlmIChpc3BpLT5sb2NrZWQpIHsNCisJaWYgKGlzcGktPmxvY2tlZCAmJiBp
c3BpLT5zcmVncykgew0KICAJCS8qDQogIAkJICogQklPUyBwcm9ncmFtcyBhbGxvd2VkIG9wY29k
ZXMgYW5kIHRoZW4gbG9ja3MgZG93biB0aGUNCiAgCQkgKiByZWdpc3Rlci4gU28gcmVhZCBiYWNr
IHdoYXQgb3Bjb2RlcyBpdCBkZWNpZGVkIHRvIHN1cHBvcnQuDQotLSANCjIuNy40DQoNCg==
