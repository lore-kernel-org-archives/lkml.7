Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D41C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63A6224D5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="joIP6ld+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfDYM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:28:38 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:37382 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDYM2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:28:36 -0400
X-IronPort-AV: E=Sophos;i="5.60,393,1549954800"; 
   d="scan'208";a="30826542"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Apr 2019 05:28:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 25 Apr 2019 05:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9h/MMmFj42db5+5+C/Tcm3AI4/TTM1N7XpbaMOTN1M=;
 b=joIP6ld+5f5PZx+3CFO2dspHSeKeRemZA8W5rjmC/T6KXIPbENfrGdvEohYbXAv1YaYP5HYNgUieZlG3rU98OHLkpfVTHW1QiR3Eplt+J8RvmfmorhRkkGVHYVaepxZRgGrQIlAf3EjdqIdhgQBR/qDkfX99yMm5Ww0GV8biZ2w=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1470.namprd11.prod.outlook.com (10.172.53.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Thu, 25 Apr 2019 12:28:34 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 12:28:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/6] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's
 PWM
Thread-Topic: [PATCH v3 3/6] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Thread-Index: AQHU+2JmpwWXDC5OaUSjnobMSRPNlQ==
Date:   Thu, 25 Apr 2019 12:28:33 +0000
Message-ID: <1556195285-10687-4-git-send-email-claudiu.beznea@microchip.com>
References: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1556195285-10687-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a7c6b4-4c83-4fb6-da21-08d6c979883e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1470;
x-ms-traffictypediagnostic: MWHPR11MB1470:
x-microsoft-antispam-prvs: <MWHPR11MB147021054AAA4911D74D5D1F873D0@MWHPR11MB1470.namprd11.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(66476007)(7736002)(81156014)(305945005)(66556008)(64756008)(66446008)(8936002)(68736007)(8676002)(73956011)(66946007)(81166006)(5660300002)(6486002)(3846002)(6116002)(6506007)(2501003)(386003)(76176011)(2201001)(102836004)(50226002)(99286004)(86362001)(36756003)(52116002)(4326008)(110136005)(54906003)(107886003)(66066001)(186003)(256004)(26005)(71190400001)(71200400001)(53936002)(25786009)(486006)(478600001)(72206003)(476003)(446003)(11346002)(4744005)(2616005)(2906002)(97736004)(316002)(6436002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1470;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z8WqwlxMXKkSfFubZjYulS6rx/+G5bBCkP6D/IumIl3vsG+VsehshkBPT3fOVnj4G4R/sguSG2GI4JG/oduU2re5ZX4/OqHq5A6o8ldNT+x3h5ozwkdU8tIPhNDmHF3QtCRSQ853+FikbDnwXsH74D/6lv3RI/xnRw8G8otgIRqMJu4AFtBbtOWK249GqNLedZV+qjQr/IyABGpK6zbZI7jqAA5PzGrCF8TxEIRyCDD2DYJWE6sg3gagzqQUuaDZl9V+Cbj6rH3s//KsDhQCqwi+N66wTW31EUMbkZLUJtZbe9LDXwQJc9+oRbEF+3jOmeCtauzXgUa9kRaqntkUeNOaZWNfEktF4mgPBZQULEmnZuWPxTyKzo9XjE9ej6hrzdy+eNBX0vH4ZGElpBLSmlMTTRi6Whgb2mZjpjjzFto=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a7c6b4-4c83-4fb6-da21-08d6c979883e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 12:28:33.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1470
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgU0FNOVg2MCBITENEQydzIFBXTS4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpBY2tl
ZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYyBi
L2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQppbmRleCA1NGM2NjMzZDliNWQuLjZiZmJl
MWE5MDJmYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC1obGNkYy5jDQorKysg
Yi9kcml2ZXJzL3B3bS9wd20tYXRtZWwtaGxjZGMuYw0KQEAgLTI0Niw2ICsyNDYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhdG1lbF9obGNkY19kdF9pZHNbXSA9IHsNCiAJ
CS5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDQtaGxjZGMiLA0KIAkJLmRhdGEgPSAmYXRtZWxf
aGxjZGNfcHdtX3NhbWE1ZDNfZXJyYXRhLA0KIAl9LA0KKwl7IAkuY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAsc2FtOXg2MC1obGNkYyIsIH0sDQogCXsgLyogc2VudGluZWwgKi8gfSwNCiB9Ow0KIE1P
RFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX2hsY2RjX2R0X2lkcyk7DQotLSANCjIuNy40DQoN
Cg==
