Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB02C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229920815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="m+8ON23s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfCDOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:44:17 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62705 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:44:16 -0500
X-IronPort-AV: E=Sophos;i="5.58,440,1544511600"; 
   d="scan'208";a="24775298"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Mar 2019 07:44:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Mar 2019 07:44:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7uzM7XVbU/TWlqewEl/Ab72vAyQTu7V7od1m2XaJno=;
 b=m+8ON23sMEiQcc37MHVx6RlT35cPUEPWYtIuTEZfgfs72cESEYolBJE9mez4j/pdnjpASt8WP+92zQEivJ8iPX5MKWWI9rMTSUQmVaYrqgnKyQWtUwBrHO4HNEiS4OH1F98TxcO3hwrr+S0M1MCBrxe4wCLdHc44p4nsj/ihryc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0028.namprd11.prod.outlook.com (10.164.155.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 14:44:14 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e831:aee7:13c0:96b1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e831:aee7:13c0:96b1%8]) with mapi id 15.20.1665.020; Mon, 4 Mar 2019
 14:44:13 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH] can: m_can: implement errata "Needless activation of MRAF
 irq"
Thread-Topic: [PATCH] can: m_can: implement errata "Needless activation of
 MRAF irq"
Thread-Index: AQHU0pi87hthOFAuCkyLM7QzIhPMZA==
Date:   Mon, 4 Mar 2019 14:44:13 +0000
Message-ID: <1551710357-20215-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::48) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef52e8af-d222-4cc3-0c2a-08d6a0afde93
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0028;
x-ms-traffictypediagnostic: DM5PR11MB0028:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjExTUIwMDI4OzIzOitqKy93Yjg3UXUxeC9zZ3NyU2FydmMxUTh2?=
 =?utf-8?B?MWJPRnFvYmQ1UnVGVkFLOGdmY1F2RVRVNjJHWFRRTzVTbDhEc0V4NEI2TXFR?=
 =?utf-8?B?ZC9QOUtOTUNRSThnOSswM2xuNTVEVHpDcCtVbHFMSDlEZ1VxQjY4bms1VDN5?=
 =?utf-8?B?QUc2WW9VOGt6anc1MmlyREJ5NXhOd1k0TFA2NDMrVjZNeSs3Q0EzWjJXZytE?=
 =?utf-8?B?aVBGVm42aGx4cUNiWVhRRkY3SE12UkV3cE43TUFwSnV0UTJmU0RzZ1FNQXBt?=
 =?utf-8?B?VDhwVy9VZk1NWjhjUm5FOVhObWtOaEkya0xQa2VnN2tod0VWV09sa1pJWitF?=
 =?utf-8?B?VEdWL3dpQ3pmUDM0bExhRjRjektQNjBBK2hFVUk3eDI5TzIxMjBsb3laZmFj?=
 =?utf-8?B?MG9wQjRlVEpvNElCVzVrSWkwdGZuME5TN3lVM3luZE9CU3VJbFlQUWxwVGt0?=
 =?utf-8?B?bWwvUXc4Wnh6Uk0xOE10K2JDWE5yTzQ2Mm8yZkNyTnpEeWdSUUVhU045bzY2?=
 =?utf-8?B?T0NSRWdzMDhEY2dwRHVTR2ZrbHJnTkl2cGxtSGxXWXF3SUNRRjFxM05oeE5R?=
 =?utf-8?B?T3pXMWtkTlNtVUZrbWhrTGRBWXJpMjZIZlRlbWtZTW1pL0RVbDhGV0podTZX?=
 =?utf-8?B?dWRKa3M3K2h5UjRHQjk1YVlraHpPc3hTQnd6NTNGUk1zMndaK0F2bmhkODZI?=
 =?utf-8?B?MzFoOGdlNFljWE1qWnpoSmYreTJib3NHQ3dFZHRpeTY4am5OUXZwVHdva3pp?=
 =?utf-8?B?dnJxM2FoTWxjVWRkeEpPekxCZzlqV1NuR0pNMW45QWlVQTM1WUFmTnA0VjJK?=
 =?utf-8?B?aStLZUMxcmdSN2Y5ZVFGMzlmRk5FUWpoZ0VqMVcycm9LOVpLNnlrL2FnbWFu?=
 =?utf-8?B?V1BtVVlrU1lGdFpOYUtkSmEzMmRiWGVPYXVyZzl0dEZYcEpqTlRLOWUzRTBn?=
 =?utf-8?B?YTJhSlhZUFEvbWpxZjBpUlBRRDBWRE9xZHlKQmpVdWhGcTc3YkkxNy9sWGlE?=
 =?utf-8?B?dmUrQXR2bzFkSXNDNzk0alJIckhjdExLRHh5ajVtOFYzNU1IWXdua2ZlTnRp?=
 =?utf-8?B?YnptUlFHUGlHZ1cxQzlPblVVSHZMWFQ4SlpudXorZ0RyYk1PUE5MZzVOMlBD?=
 =?utf-8?B?aHArVkh4NU1lL2ZOdjZyL3ZmMEU3VUw3THptZUdPb09KbURSajNkdnl1TFdO?=
 =?utf-8?B?Qm0rVUNzWTJhR3JGR05tUy9TKzgvQUNWeUhuRGdnMzZOUXBrTGtMUVlhaXA4?=
 =?utf-8?B?dzV1emQ2YnNTTHZYZ0RlUkJTRDdHNnpxNndjQjRiZzN1NUFWdElwSEg3VjZK?=
 =?utf-8?B?a0toTUR0aU1IYlp1QzE2TlloVmorTGd3NnNtNk9EWTZ3YWlWSWZtUEY0dlBN?=
 =?utf-8?B?ZTE5Vml6OURFTmNMSmVtaGRvb0w4QmxRTVpRVEQvREZ4NG14S3VidUNicmtj?=
 =?utf-8?B?TUsxWXZjeWRwV25TalBYcmZlWUJScnM4Q3BsL2QzQ3RLdkhBdTkzdVJ1TE1w?=
 =?utf-8?B?T3UxVDhEK0tRSm1YTlo5YmI4dkswcWhHVm5YZDhQT2VPZ29YU1ZlbXhJdnNL?=
 =?utf-8?B?QU1ibzdVNUxHS3BZeE15NHdLR1F1eTgvcTdCMGlMMjF0YmNGMjNmYzROdlJl?=
 =?utf-8?B?dkY1Vjk0cDBsSmNYU3IwZmZyTGxFTnp1YmppM2Rwd3d4YjB2L2VMemxNWnBG?=
 =?utf-8?Q?oqwro3g6Lfaaa8Sk2bA9CAKOplUHsN74NM/oGJI?=
x-microsoft-antispam-prvs: <DM5PR11MB0028DF9B57A4803EF0CBAE6CE8710@DM5PR11MB0028.namprd11.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(189003)(199004)(25786009)(8936002)(486006)(3846002)(53936002)(6306002)(2501003)(6512007)(4326008)(50226002)(5660300002)(2906002)(102836004)(107886003)(52116002)(97736004)(305945005)(99286004)(7736002)(71200400001)(54906003)(71190400001)(26005)(110136005)(186003)(6486002)(386003)(106356001)(6506007)(72206003)(14454004)(966005)(316002)(68736007)(66066001)(478600001)(86362001)(105586002)(256004)(81156014)(81166006)(2201001)(8676002)(36756003)(476003)(6116002)(6436002)(2616005)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0028;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mHoWwUhBs5zaKL9oJBdBRu5+a0lHv5DkM/noE8xWbed8k8Jx7RT5aL4cjljS9eMVIMjl04lHAdWOQvJOm7sRqIpY7ILXGwdDErClxU1UXUQX+JnwcgVV43x+6wGtz/jaRBUk81QEK6cSyI34kzDTI3jYwWVlNTWq1/wkASkxR8HOSJRT51rWxFj0Ry0EO7n9DPhI5CqGyrj9O6lNuZ/3JlYCKMEq23oMT6XNhcNK4GPUStKkYMpwkkefcAAvBpjLDcf8M5mRd3XFBqFiFAsZ9MwpZ74CkYWqcykcYo33nnycub/U1VJOC7qj3dlLMFZOCn2WSS1p1zuim9CU4BrEysyFoWnl4CVFZ86tW37TuYEra96BC5y+YJRxa2bOJBu/QNLEXJ8DOtT+b/VrhDCV+oP/jsi9bSpxWR+7E4PhgmQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F48573B33CB414D827C8D5FF4FAA52E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ef52e8af-d222-4cc3-0c2a-08d6a0afde93
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 14:44:13.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0028
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpEdXJp
bmcgZnJhbWUgcmVjZXB0aW9uIHdoaWxlIHRoZSBNQ0FOIGlzIGluIEVycm9yIFBhc3NpdmUgc3Rh
dGUNCmFuZCB0aGUgUmVjZWl2ZSBFcnJvciBDb3VudGVyIGhhcyB0aGV2YWx1ZSBNQ0FOX0VDUi5S
RUMgPSAxMjcsIGl0IG1heSBoYXBwZW4NCnRoYXQgTUNBTl9JUi5NUkFGIGlzIHNldCBhbHRob3Vn
aCB0aGVyZSB3YXMgbm8gTWVzc2FnZSBSQU0gYWNjZXNzIGZhaWx1cmUuDQpJZiBNQ0FOX0lSLk1S
QUYgaXMgZW5hYmxlZCwgYW4gaW50ZXJydXB0IHRvIHRoZSBIb3N0IENQVSBpcyBnZW5lcmF0ZWQu
DQpXb3JrIGFyb3VuZDoNClRoZSBNZXNzYWdlIFJBTSBBY2Nlc3MgRmFpbHVyZSBpbnRlcnJ1cHQg
cm91dGluZSBuZWVkcyB0byBjaGVjayB3aGV0aGVyDQogTUNBTl9FQ1IuUlAgPSAnMScgYW5kIE1D
QU5fRUNSLlJFQyA9ICcxMjcnLg0KSW4gdGhpcyBjYXNlLCByZXNldCBNQ0FOX0lSLk1SQUYuIE5v
IGZ1cnRoZXIgYWN0aW9uIGlzIHJlcXVpcmVkLg0KVGhpcyBhZmZlY3RzIHZlcnNpb25zIG9sZGVy
IHRoYW4gMy4yLjANCg0KRXJyYXRhIGV4cGxhaW5lZCBvbiBTYW1hNWQyIFNvQyB3aGljaCBpbmNs
dWRlcyB0aGlzIGhhcmR3YXJlIGJsb2NrOg0KaHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25s
b2Fkcy9lbi9EZXZpY2VEb2MvU0FNQTVEMi1GYW1pbHktU2lsaWNvbi1FcnJhdGEtYW5kLURhdGEt
U2hlZXQtQ2xhcmlmaWNhdGlvbi1EUzgwMDAwODAzQi5wZGYgY2hhcHRlciA2LjINCg0KUmVwcm9k
dWNpYmlsaXR5OiBJZiAyIGRldmljZXMgd2l0aCBtX2NhbiBhcmUgY29ubmVjdGVkIGJhY2sgdG8g
YmFjaywNCmNvbmZpZ3VyaW5nIGRpZmZlcmVudCBiaXRyYXRlIG9uIHRoZW0gd2lsbCBsZWFkIHRv
IGludGVycnVwdCBzdG9ybSBvbiB0aGUNCnJlY2VpdmluZyBzaWRlLCB3aXRoIGVycm9yICJNZXNz
YWdlIFJBTSBhY2Nlc3MgZmFpbHVyZSBvY2N1cnJlZCIuDQpBbm90aGVyIHdheSBpcyB0byBoYXZl
IGEgYmFkIGhhcmR3YXJlIGNvbm5lY3Rpb24uIEJhZCB3aXJlIGNvbm5lY3Rpb24gY2FuIGxlYWQN
CnRvIHRoaXMgaXNzdWUgYXMgd2VsbC4NCg0KVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYWNj
b3JkaW5nIHRvIHByb3ZpZGVkIHdvcmthcm91bmQuDQoNClNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhy
aXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L2Nh
bi9tX2Nhbi9tX2Nhbi5jIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nh
bi9tX2Nhbi5jIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCmluZGV4IDliNDQ5NDAu
LmRlYjI3NGEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYw0KKysr
IGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCkBAIC04MjIsNiArODIyLDI3IEBAIHN0
YXRpYyBpbnQgbV9jYW5fcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBxdW90YSkN
CiAJaWYgKCFpcnFzdGF0dXMpDQogCQlnb3RvIGVuZDsNCiANCisJLyogRXJyYXRhIHdvcmthcm91
bmQgZm9yIGlzc3VlICJOZWVkbGVzcyBhY3RpdmF0aW9uIG9mIE1SQUYgaXJxIg0KKwkgKiBEdXJp
bmcgZnJhbWUgcmVjZXB0aW9uIHdoaWxlIHRoZSBNQ0FOIGlzIGluIEVycm9yIFBhc3NpdmUgc3Rh
dGUNCisJICogYW5kIHRoZSBSZWNlaXZlIEVycm9yIENvdW50ZXIgaGFzIHRoZSB2YWx1ZSBNQ0FO
X0VDUi5SRUMgPSAxMjcsDQorCSAqIGl0IG1heSBoYXBwZW4gdGhhdCBNQ0FOX0lSLk1SQUYgaXMg
c2V0IGFsdGhvdWdoIHRoZXJlIHdhcyBubw0KKwkgKiBNZXNzYWdlIFJBTSBhY2Nlc3MgZmFpbHVy
ZS4NCisJICogSWYgTUNBTl9JUi5NUkFGIGlzIGVuYWJsZWQsIGFuIGludGVycnVwdCB0byB0aGUg
SG9zdCBDUFUgaXMgZ2VuZXJhdGVkDQorCSAqIFRoZSBNZXNzYWdlIFJBTSBBY2Nlc3MgRmFpbHVy
ZSBpbnRlcnJ1cHQgcm91dGluZSBuZWVkcyB0byBjaGVjaw0KKwkgKiB3aGV0aGVyIE1DQU5fRUNS
LlJQID0g4oCZMeKAmSBhbmQgTUNBTl9FQ1IuUkVDID0gMTI3Lg0KKwkgKiBJbiB0aGlzIGNhc2Us
IHJlc2V0IE1DQU5fSVIuTVJBRi4gTm8gZnVydGhlciBhY3Rpb24gaXMgcmVxdWlyZWQuDQorCSAq
Lw0KKwlpZiAoKHByaXYtPnZlcnNpb24gPD0gMzEpICYmIChpcnFzdGF0dXMgJiBJUl9NUkFGKSAm
Jg0KKwkgICAgKG1fY2FuX3JlYWQocHJpdiwgTV9DQU5fRUNSKSAmIEVDUl9SUCkpIHsNCisJCXN0
cnVjdCBjYW5fYmVycl9jb3VudGVyIGJlYzsNCisNCisJCV9fbV9jYW5fZ2V0X2JlcnJfY291bnRl
cihkZXYsICZiZWMpOw0KKwkJaWYgKGJlYy5yeGVyciA9PSAxMjcpIHsNCisJCQltX2Nhbl93cml0
ZShwcml2LCBNX0NBTl9JUiwgSVJfTVJBRik7DQorCQkJaXJxc3RhdHVzICY9IH5JUl9NUkFGOw0K
KwkJfQ0KKwl9DQorDQogCXBzciA9IG1fY2FuX3JlYWQocHJpdiwgTV9DQU5fUFNSKTsNCiAJaWYg
KGlycXN0YXR1cyAmIElSX0VSUl9TVEFURSkNCiAJCXdvcmtfZG9uZSArPSBtX2Nhbl9oYW5kbGVf
c3RhdGVfZXJyb3JzKGRldiwgcHNyKTsNCi0tIA0KMi43LjQNCg0K
