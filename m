Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB269217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="P8oCOMkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfEUKLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:11:41 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:25134 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfEUKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:11:37 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,494,1549954800"; 
   d="scan'208";a="34203079"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 03:11:35 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 21 May 2019 03:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YkxIztY56b/9tK1PRdFq5XFUCnL1apSUZvuWww5L6Q=;
 b=P8oCOMkAsSYKmOMFHlGc6a5h6GkOyrhcVeD/Fzrm3aQGzbQqrsIbV/5/yP1ylLAbh6bSZaQK5yxVNEuRJbEAvupV6WdnTgkkMYW1eSkW60wVEr5p9tUsHwI4O1Fo/pajnf3ht9i8qefuiUAwou4Gm1xrpVOQIn5H82Vhm2MSZFU=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1949.namprd11.prod.outlook.com (10.175.54.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 10:11:33 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 10:11:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Topic: [PATCH v4 4/4] clk: at91: sckc: add support for SAM9X60
Thread-Index: AQHVD72Q4ne6wpY5kEOC3wMr7TLsAQ==
Date:   Tue, 21 May 2019 10:11:33 +0000
Message-ID: <1558433454-27971-5-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::26) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4527b401-93f8-43e9-1f5f-08d6ddd4b333
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1949;
x-ms-traffictypediagnostic: MWHPR11MB1949:
x-microsoft-antispam-prvs: <MWHPR11MB19496E2129F17653571686E987070@MWHPR11MB1949.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(66446008)(66556008)(81156014)(486006)(66476007)(102836004)(14454004)(2906002)(64756008)(316002)(73956011)(72206003)(26005)(476003)(446003)(68736007)(66066001)(2616005)(186003)(25786009)(99286004)(50226002)(66946007)(11346002)(52116002)(6636002)(2501003)(81166006)(8936002)(6436002)(86362001)(386003)(7736002)(4326008)(110136005)(54906003)(5660300002)(3846002)(6116002)(6506007)(6512007)(36756003)(107886003)(256004)(71200400001)(6486002)(478600001)(53936002)(305945005)(71190400001)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1949;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: peJE3NqtyJsKT+U3WRN2LcFaMb2HzHz+l+MJMvLsWO5jxShTnMEC63H3gn2QT6EZ8KIgXzsW8Hb7N2A/o5gteEr/oIJj4otJreaPWYnDJeG35pxrjGiXq/rXeNJ4VHBSrmqSTNB267lU9y1ZDHVHOQ3Yuds+FzQnKfQWt5rTpan75jz4O3br+TXxS8jgvBEZzQT7fZrTVg9EQOa0inQvrFL4ClVlSn4MsEUH8REFAujiGdHYAHVpSx3sJjYoSV+D1qAlxDB+O18y5/3nxS6iXgNo6bJdQMM+AZI4EnrYIgOTWKZeH12flQ9wMhPT10fZdwYYceCHc7DiJmM+/tDiH7BurcdI36auKCq/TLlBQ39zY8I3BRPltRTKw8SJc6t3YJURLu+5EWRbho/w18tDQZKF4oRnXjPQD8QiVcar944=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4527b401-93f8-43e9-1f5f-08d6ddd4b333
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 10:11:33.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1949
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBzdXBwb3J0IGZvciBTQU05WDYwJ3Mgc2xvdyBjbG9jay4NCg0KU2lnbmVkLW9mZi1ieTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpBY2tlZC1ieTogQWxl
eGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KLS0tDQogZHJp
dmVycy9jbGsvYXQ5MS9zY2tjLmMgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKykNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9z
Y2tjLmMNCmluZGV4IGFiMThiMWRhMjY5Zi4uMWYwZjFjZDA2Mzg3IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jbGsvYXQ5MS9zY2tjLmMNCisrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQpAQCAt
NDEwLDYgKzQxMCw4MCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgb2Zfc2FtYTVkM19zY2tjX3NldHVw
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQogQ0xLX09GX0RFQ0xBUkUoc2FtYTVkM19jbGtfc2Nr
YywgImF0bWVsLHNhbWE1ZDMtc2NrYyIsDQogCSAgICAgICBvZl9zYW1hNWQzX3Nja2Nfc2V0dXAp
Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX3Nsb3dfYml0cyBhdDkxc2FtOXg2MF9iaXRz
ID0gew0KKwkuY3Jfb3NjMzJlbiA9IEJJVCgxKSwNCisJLmNyX29zYzMyYnlwID0gQklUKDIpLA0K
KwkuY3Jfb3Njc2VsID0gQklUKDI0KSwNCit9Ow0KKw0KK3N0YXRpYyB2b2lkIF9faW5pdCBvZl9z
YW05eDYwX3Nja2Nfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkNCit7DQorCXZvaWQgX19p
b21lbSAqcmVnYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsNCisJc3RydWN0IGNsa19od19vbmVjZWxs
X2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgY2xrX2h3ICpzbG93X3JjLCAqc2xvd19vc2M7DQor
CWNvbnN0IGNoYXIgKnh0YWxfbmFtZTsNCisJY29uc3QgY2hhciAqcGFyZW50X25hbWVzWzJdID0g
eyAic2xvd19yY19vc2MiLCAic2xvd19vc2MiIH07DQorCWJvb2wgYnlwYXNzOw0KKwlpbnQgcmV0
Ow0KKw0KKwlpZiAoIXJlZ2Jhc2UpDQorCQlyZXR1cm47DQorDQorCXNsb3dfcmMgPSBjbGtfaHdf
cmVnaXN0ZXJfZml4ZWRfcmF0ZShOVUxMLCBwYXJlbnRfbmFtZXNbMF0sIE5VTEwsIDAsDQorCQkJ
CQkgICAgIDMyNzY4KTsNCisJaWYgKElTX0VSUihzbG93X3JjKSkNCisJCXJldHVybjsNCisNCisJ
eHRhbF9uYW1lID0gb2ZfY2xrX2dldF9wYXJlbnRfbmFtZShucCwgMCk7DQorCWlmICgheHRhbF9u
YW1lKQ0KKwkJZ290byB1bnJlZ2lzdGVyX3Nsb3dfcmM7DQorDQorCWJ5cGFzcyA9IG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChucCwgImF0bWVsLG9zYy1ieXBhc3MiKTsNCisJc2xvd19vc2MgPSBhdDkx
X2Nsa19yZWdpc3Rlcl9zbG93X29zYyhyZWdiYXNlLCBwYXJlbnRfbmFtZXNbMV0sDQorCQkJCQkg
ICAgICB4dGFsX25hbWUsIDUwMDAwMDAsIGJ5cGFzcywNCisJCQkJCSAgICAgICZhdDkxc2FtOXg2
MF9iaXRzKTsNCisJaWYgKElTX0VSUihzbG93X29zYykpDQorCQlnb3RvIHVucmVnaXN0ZXJfc2xv
d19yYzsNCisNCisJY2xrX2RhdGEgPSBremFsbG9jKHNpemVvZigqY2xrX2RhdGEpICsgKDIgKiBz
aXplb2Yoc3RydWN0IGNsa19odyAqKSksDQorCQkJICAgR0ZQX0tFUk5FTCk7DQorCWlmICghY2xr
X2RhdGEpDQorCQlnb3RvIHVucmVnaXN0ZXJfc2xvd19vc2M7DQorDQorCS8qIE1EX1NMQ0sgYW5k
IFREX1NMQ0suICovDQorCWNsa19kYXRhLT5udW0gPSAyOw0KKwljbGtfZGF0YS0+aHdzWzBdID0g
Y2xrX2h3X3JlZ2lzdGVyX2ZpeGVkX3JhdGUoTlVMTCwgIm1kX3NsY2siLA0KKwkJCQkJCSAgICAg
IHBhcmVudF9uYW1lc1swXSwNCisJCQkJCQkgICAgICAwLCAzMjc2OCk7DQorCWlmIChJU19FUlIo
Y2xrX2RhdGEtPmh3c1swXSkpDQorCQlnb3RvIGNsa19kYXRhX2ZyZWU7DQorDQorCWNsa19kYXRh
LT5od3NbMV0gPSBhdDkxX2Nsa19yZWdpc3Rlcl9zYW05eDVfc2xvdyhyZWdiYXNlLCAidGRfc2xj
ayIsDQorCQkJCQkJCSBwYXJlbnRfbmFtZXMsIDIsDQorCQkJCQkJCSAmYXQ5MXNhbTl4NjBfYml0
cyk7DQorCWlmIChJU19FUlIoY2xrX2RhdGEtPmh3c1sxXSkpDQorCQlnb3RvIHVucmVnaXN0ZXJf
bWRfc2xjazsNCisNCisJcmV0ID0gb2ZfY2xrX2FkZF9od19wcm92aWRlcihucCwgb2ZfY2xrX2h3
X29uZWNlbGxfZ2V0LCBjbGtfZGF0YSk7DQorCWlmIChXQVJOX09OKHJldCkpDQorCQlnb3RvIHVu
cmVnaXN0ZXJfdGRfc2xjazsNCisNCisJcmV0dXJuOw0KKw0KK3VucmVnaXN0ZXJfdGRfc2xjazoN
CisJY2xrX2h3X3VucmVnaXN0ZXIoY2xrX2RhdGEtPmh3c1sxXSk7DQordW5yZWdpc3Rlcl9tZF9z
bGNrOg0KKwljbGtfaHdfdW5yZWdpc3RlcihjbGtfZGF0YS0+aHdzWzBdKTsNCitjbGtfZGF0YV9m
cmVlOg0KKwlrZnJlZShjbGtfZGF0YSk7DQordW5yZWdpc3Rlcl9zbG93X29zYzoNCisJY2xrX2h3
X3VucmVnaXN0ZXIoc2xvd19vc2MpOw0KK3VucmVnaXN0ZXJfc2xvd19yYzoNCisJY2xrX2h3X3Vu
cmVnaXN0ZXIoc2xvd19yYyk7DQorfQ0KK0NMS19PRl9ERUNMQVJFKHNhbTl4NjBfY2xrX3Nja2Ms
ICJtaWNyb2NoaXAsc2FtOXg2MC1zY2tjIiwNCisJICAgICAgIG9mX3NhbTl4NjBfc2NrY19zZXR1
cCk7DQorDQogc3RhdGljIGludCBjbGtfc2FtYTVkNF9zbG93X29zY19wcmVwYXJlKHN0cnVjdCBj
bGtfaHcgKmh3KQ0KIHsNCiAJc3RydWN0IGNsa19zYW1hNWQ0X3Nsb3dfb3NjICpvc2MgPSB0b19j
bGtfc2FtYTVkNF9zbG93X29zYyhodyk7DQotLSANCjIuNy40DQoNCg==
