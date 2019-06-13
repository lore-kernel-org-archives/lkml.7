Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45720206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wYaoVH0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfFMPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:27 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42030 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbfFMPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:25 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="34303728"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:11 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDgx4uCGYQkKKeHB7KQ5MPlVeAV+jSpW5hHmcuJNdbI=;
 b=wYaoVH0deuISVPqwyKvOwDu0Z9m6ZVBFAsKAAIxIOdBxZluj1bTWenxaarXAYt/NDltQGm9G54skpouw4H4utRWRngniV7KcOI5ZDILq4jiTQQD+/SGKEApfOFLavWCV7KSdNu1QzXsyCANM8JD9MxzU0wdQ/z81SBxp8OGcKiI=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 15:37:09 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/7] clk: at91: sckc: add support to free slow oscillator
Thread-Topic: [PATCH 1/7] clk: at91: sckc: add support to free slow oscillator
Thread-Index: AQHVIf3dsJR4RY5xVUCiuUb1j2UkzA==
Date:   Thu, 13 Jun 2019 15:37:09 +0000
Message-ID: <1560440205-4604-2-git-send-email-claudiu.beznea@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac75f9b-719b-4b4a-ebf8-08d6f014ff3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB1822A0C6BCE955586B6D5A5587EF0@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(14454004)(478600001)(110136005)(54906003)(256004)(68736007)(2906002)(72206003)(316002)(71200400001)(71190400001)(2501003)(36756003)(50226002)(4326008)(107886003)(25786009)(6512007)(8676002)(8936002)(81156014)(2616005)(476003)(446003)(11346002)(6436002)(6486002)(81166006)(5660300002)(66066001)(99286004)(305945005)(4744005)(53936002)(7736002)(52116002)(76176011)(66946007)(3846002)(6116002)(86362001)(486006)(66446008)(66556008)(186003)(26005)(6506007)(73956011)(386003)(102836004)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSHMecGmpUy7hy/YOGIsBpzh2ezcQSwCa1kfzjK0kvx2NSHYwH1xJpYv3ZyTPk5xVxWC7wyrYrmX0h3ADgpig7XWeZBEV7y4652ptucScClQU5UQMW7jsITZqYUK03v2pYuZmZg+Ec9OQ5ZPsbrH916E+55LATUEibks/NP2j0RlXPk3x2+UAhUzVg9ihCLnuYRSyPP/ARYb0IOp0h5VXJAgsNQ9NkLJzMs9Qs9Rc5UUg3oQ5lij1WtJ4DDAyM2bzmvfYRp5o1K99kLsBVJg0YAPHddt71YBva1Pwl+sF1utkSnVlLcGex3M5Ci2UOUsmgSc/WOOtBk7V6Vg/xO2wyTcfH+A0Clp2juuFxf8qrFcV0GbrbQhj/I/zmCxMvFP7D2SCmT4JGQ9zSWUY/9Hx1gfppsNAaw+7poDCGmn3ng=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eac75f9b-719b-4b4a-ebf8-08d6f014ff3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:09.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBzdXBwb3J0IHRvIGZyZWUgc2xvdyBvc2NpbGxhdG9yIHJlc291cmNlcy4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQotLS0N
CiBkcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyBi
L2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQppbmRleCAyYzQxMGY0MWI0MTMuLmMxZDdlZGQzMzQx
NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQorKysgYi9kcml2ZXJzL2Ns
ay9hdDkxL3Nja2MuYw0KQEAgLTE2Niw2ICsxNjYsMTQgQEAgYXQ5MV9jbGtfcmVnaXN0ZXJfc2xv
d19vc2Modm9pZCBfX2lvbWVtICpzY2tjciwNCiAJcmV0dXJuIGh3Ow0KIH0NCiANCitzdGF0aWMg
dm9pZCBhdDkxX2Nsa191bnJlZ2lzdGVyX3Nsb3dfb3NjKHN0cnVjdCBjbGtfaHcgKmh3KQ0KK3sN
CisJc3RydWN0IGNsa19zbG93X29zYyAqb3NjID0gdG9fY2xrX3Nsb3dfb3NjKGh3KTsNCisNCisJ
Y2xrX2h3X3VucmVnaXN0ZXIoaHcpOw0KKwlrZnJlZShvc2MpOw0KK30NCisNCiBzdGF0aWMgdW5z
aWduZWQgbG9uZyBjbGtfc2xvd19yY19vc2NfcmVjYWxjX3JhdGUoc3RydWN0IGNsa19odyAqaHcs
DQogCQkJCQkJIHVuc2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpDQogew0KLS0gDQoyLjcuNA0KDQo=
