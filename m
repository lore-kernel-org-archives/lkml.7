Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A8E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QoxDvO9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfDBM4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:56:22 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:9779 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:56:21 -0400
X-IronPort-AV: E=Sophos;i="5.60,300,1549954800"; 
   d="scan'208";a="29305566"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 Apr 2019 05:56:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 2 Apr 2019 05:56:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7uzM7XVbU/TWlqewEl/Ab72vAyQTu7V7od1m2XaJno=;
 b=QoxDvO9+vKGNgClZILY6V5ceCnFncxRtn0FdPbbryKcT4K08Yu8YnpXvVB6JDtanGF9gMcD9WEj+J0cvsWvF+I0cdfLAdz6j4tgOhMU7OdWpIg6LiLQyLJysNk6iBr+iv8nf+UK/eMsS9Yfah5Sc2d6zOlWa7kiAIsnSdKPxmjs=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0043.namprd11.prod.outlook.com (10.164.155.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 12:56:18 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e8b6:2ae9:9b9c:2ca8%3]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 12:56:18 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <Nicolas.Ferre@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH RESEND] can: m_can: implement errata "Needless activation of
 MRAF irq"
Thread-Topic: [PATCH RESEND] can: m_can: implement errata "Needless activation
 of MRAF irq"
Thread-Index: AQHU6VN26GhpB23BUk+qk1eaBs8P4g==
Date:   Tue, 2 Apr 2019 12:56:18 +0000
Message-ID: <1554209445-19879-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7774154-0e05-4af3-7635-08d6b76a98f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR11MB0043;
x-ms-traffictypediagnostic: DM5PR11MB0043:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR11MB0043F5A5038D71CF92F450B5E8560@DM5PR11MB0043.namprd11.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(6486002)(36756003)(478600001)(4326008)(26005)(6506007)(99286004)(14454004)(68736007)(386003)(186003)(6306002)(71190400001)(486006)(6512007)(966005)(102836004)(2501003)(110136005)(5660300002)(72206003)(66066001)(86362001)(97736004)(53936002)(316002)(54906003)(2906002)(105586002)(106356001)(81166006)(25786009)(3846002)(8936002)(81156014)(2201001)(107886003)(6436002)(14444005)(476003)(6116002)(305945005)(2616005)(7736002)(71200400001)(8676002)(52116002)(50226002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0043;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bFUfWRqKNPiP5W+UNlVLPDHXR167KjvXAMWMPuUdD04l+OO7ZQMBFtKznnDs65PNY5mn5vqBq+G8JnGl0PDNAD+KJO6wZ0VnYxFFJ0F4BzMBaXdfFSknzwUh/xYxVs4IEaD5jo5+9oJ/EnGoCKOAkUbzBKKBSUIJQe0IZcX0HfTEJFGoRJN6PPccZ8u6LfdafV1FGaL796ILK/LfiSD2Dr8BhtYruAs8eA3Bpmyvjd+VC6alw9JaQ/j4sdABOcMQRvo1r/sPTDUOwsn3nTp0cx0P0TwFm8j7pk+fllyx5lv8srHZ4Om/XWBkgURMtD0vpa1zuWhnFU3k7Wq9Sj1giKtg/hGqPr+ttbhqVlHmHhRB4z8scRC8jbWE5tcWSBXaESoKLJFN2mtS8o6D8SrKa02bfIVwRSPDz8Vsi4kHPpw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91BD978EDD9B304FB76BE35694252BD2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7774154-0e05-4af3-7635-08d6b76a98f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 12:56:18.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0043
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
