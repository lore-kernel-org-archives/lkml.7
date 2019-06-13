Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD68C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D911B2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XkCyM3c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfFMPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:31 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62584 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfFMPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:26 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="35722735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:22 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Jun 2019 08:37:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/LhzyoGC0VIbfJRUv11FcBTd5SrdUHDerFXQ+V+ojU=;
 b=XkCyM3c5ns3SlCx2nO1STkjny+00oyLLpE6Hwd3wb8O+WDM9GG5VySJvhlI9XMOByQaHoOOhfU9zqH5SWQZHO025in98WxcBAVZ4/7QmtZHWb1I5iJ5xRzW/62sYGBrsMFQe3qKY2pQj5PkRog8dM7dK4RW8vkXqzujTKzrqEc8=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 15:37:22 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 5/7] clk: at91: sckc: remove unnecessary line
Thread-Topic: [PATCH 5/7] clk: at91: sckc: remove unnecessary line
Thread-Index: AQHVIf3k5XX35ZQo/kiB0AIpNJbNOw==
Date:   Thu, 13 Jun 2019 15:37:22 +0000
Message-ID: <1560440205-4604-6-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: c8e8d7ad-07a4-4d3c-9057-08d6f01506ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB1822C48C2666EDF69F05FC9387EF0@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(14454004)(478600001)(110136005)(54906003)(14444005)(256004)(68736007)(2906002)(72206003)(316002)(71200400001)(71190400001)(2501003)(36756003)(50226002)(4326008)(107886003)(25786009)(6512007)(8676002)(8936002)(81156014)(2616005)(476003)(446003)(11346002)(6436002)(6486002)(81166006)(5660300002)(66066001)(99286004)(305945005)(4744005)(53936002)(7736002)(52116002)(76176011)(66946007)(3846002)(6116002)(86362001)(486006)(66446008)(66556008)(186003)(26005)(6506007)(73956011)(386003)(102836004)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vTw9PF0CuSM9WgJPNp9MOwR0eM2MNDwrNiZvxwa8+t+Df3jbFwXJR2DeYgjv+q2eyEqS3c5BEOUu2HeRI7uWnjpYkxkOG67fsbz4Y2lBQSGqHRkzANKc5mq81RaxvN2ovhR2VhA98ziUEGsUcyUJGqACEM+dDIvdMelid9p4xJqSzURHhXyVe8S3CPE7poiTjaPdFHqjmi6VWjXmVEgVZyKJmeyIwTwiCtByguFXOUnSCofgnFAEbMfU4gBTHkbIyF92vJlxTMytQSn9oDFbi+EPSKQIXMI0OZRduPhtTS8A5BD/xT8j+bebm5A9WH7rEs6AwIJ/EqDx3PkjJ6e+kBC9U8DtUpTXO/+04pxDJ39AYqCKxFTancdpIdq+7eItr4UHSo1Q8bSiM1PCpOc0A8VHnUZUAcLTIYeVc2SNaXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e8d7ad-07a4-4d3c-9057-08d6f01506ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:22.3127
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

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJl
bW92ZSB1bm5lY2Vzc2FyeSBsaW5lLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2F0OTEvc2Nr
Yy5jIHwgMSAtDQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCmluZGV4
IGEyYjkwNWM5MTA4NS4uYzYxYjZjOWRkYjk0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvYXQ5
MS9zY2tjLmMNCisrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQpAQCAtNjAxLDcgKzYwMSw2
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9zYW1hNWQ0X3Nja2Nfc2V0dXAoc3RydWN0IGRldmlj
ZV9ub2RlICpucCkNCiAJb3NjLT5zdGFydHVwX3VzZWMgPSAxMjAwMDAwOw0KIAlvc2MtPmJpdHMg
PSAmYXQ5MXNhbWE1ZDRfYml0czsNCiANCi0JaHcgPSAmb3NjLT5odzsNCiAJcmV0ID0gY2xrX2h3
X3JlZ2lzdGVyKE5VTEwsICZvc2MtPmh3KTsNCiAJaWYgKHJldCkgew0KIAkJa2ZyZWUob3NjKTsN
Ci0tIA0KMi43LjQNCg0K
