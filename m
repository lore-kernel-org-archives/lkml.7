Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C702175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3TRtS5Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEJLXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:23:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52183 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfEJLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:23:36 -0400
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
X-IronPort-AV: E=Sophos;i="5.60,453,1549954800"; 
   d="scan'208";a="29957191"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 May 2019 04:23:34 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 10 May 2019 04:23:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhzLPFKL7EX2qVbmmjOouuPSIsgHiLjDJzuK4nKfhT8=;
 b=3TRtS5ViEq/McXOPyicMBi0ofIU9zJeRNZ3GLDRQq4nGb4/chN5F6DdNZLao3glx+mOAvMvltOgzmbd5xF4TBl+sNI2DwDI7JJeloRsm6B+Rdz3QygEXm/wLb8A3l1OEyinsph/sbnYGGmc++9cU9AcZHfQrn1Jele4r6408LRo=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1935.namprd11.prod.outlook.com (10.175.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 11:23:28 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 11:23:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 1/4] clk: at91: sckc: sama5d4 has no bypass support
Thread-Topic: [PATCH v3 1/4] clk: at91: sckc: sama5d4 has no bypass support
Thread-Index: AQHVByLKa2gSxFp4V0Ki06xi/ey0wQ==
Date:   Fri, 10 May 2019 11:23:27 +0000
Message-ID: <1557487388-32098-2-git-send-email-claudiu.beznea@microchip.com>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0031.eurprd07.prod.outlook.com
 (2603:10a6:800:90::17) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc7a65d-b2c5-4b9b-a999-08d6d539ec34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1935;
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-microsoft-antispam-prvs: <MWHPR11MB19355B94F5B49A7601BD0C3F870C0@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(256004)(52116002)(478600001)(3846002)(99286004)(72206003)(68736007)(26005)(5660300002)(6116002)(66446008)(110136005)(107886003)(2906002)(4326008)(186003)(386003)(6506007)(66476007)(64756008)(66946007)(102836004)(66556008)(54906003)(2501003)(76176011)(14454004)(6512007)(73956011)(6436002)(2616005)(6486002)(7736002)(305945005)(53936002)(66066001)(25786009)(316002)(71200400001)(71190400001)(86362001)(11346002)(446003)(8676002)(81166006)(50226002)(36756003)(81156014)(476003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1935;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IcUCRqoqWZB8m0Ys5OuFsgm65cM9v0beMvKD82VB2j5uHYVmIljjEM7bUFqyqhEyE4eY0Q/IFTqCHFWarS5HWR/es5zINuWcJQh2G0up1bgu2egBWMoYaH5poiClq1guQ+GoKLM2zXa9LUFvCn8e1U9Y3jVQxaUymU8vCLSwL/Xaqmc/pNF1smfw2oLF0vc0Apku6598qWa3oKJ3/StpkgmctQXL+qJ/lbLh2d13sVcKy4vANaNfjAoTk+WzkKgfxDJuoC3LiorQryBfA03LS3PRGsqCMII+/0bY7Go2O6h2sQAiq16ywqASM+3iZGj00TlBXcfKd8K9Q1i6XQQeJ5o2bwdTBE7mOtTmKMUPm0sgVyEy9Tg8GYZCv90OQgfAJuQZCn3kKXx/bf5YLeX7FVGFJOcTfx4kC++fV083eOc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7a65d-b2c5-4b9b-a999-08d6d539ec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 11:23:27.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClRo
ZSBzbG93IGNsb2NrIG9mIFNBTUE1RDQgaGFzIG5vIGJ5cGFzcyBzdXBwb3J0IHRodXMgcmVtb3Zl
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIHwgNiAtLS0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2F0OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCmluZGV4IGU3NmIxZDY0ZTkw
NS4uNmM1NWE3YTg2Zjc5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCisr
KyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQpAQCAtNDI5LDcgKzQyOSw2IEBAIHN0YXRpYyB2
b2lkIF9faW5pdCBvZl9zYW1hNWQ0X3Nja2Nfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkN
CiAJc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdDsNCiAJY29uc3QgY2hhciAqeHRhbF9uYW1lOw0K
IAljb25zdCBjaGFyICpwYXJlbnRfbmFtZXNbMl0gPSB7ICJzbG93X3JjX29zYyIsICJzbG93X29z
YyIgfTsNCi0JYm9vbCBieXBhc3M7DQogCWludCByZXQ7DQogDQogCWlmICghcmVnYmFzZSkNCkBA
IC00NDMsOCArNDQyLDYgQEAgc3RhdGljIHZvaWQgX19pbml0IG9mX3NhbWE1ZDRfc2NrY19zZXR1
cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KIA0KIAl4dGFsX25hbWUgPSBvZl9jbGtfZ2V0X3Bh
cmVudF9uYW1lKG5wLCAwKTsNCiANCi0JYnlwYXNzID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5w
LCAiYXRtZWwsb3NjLWJ5cGFzcyIpOw0KLQ0KIAlvc2MgPSBremFsbG9jKHNpemVvZigqb3NjKSwg
R0ZQX0tFUk5FTCk7DQogCWlmICghb3NjKQ0KIAkJcmV0dXJuOw0KQEAgLTQ1OSw5ICs0NTYsNiBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgb2Zfc2FtYTVkNF9zY2tjX3NldHVwKHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnApDQogCW9zYy0+c2NrY3IgPSByZWdiYXNlOw0KIAlvc2MtPnN0YXJ0dXBfdXNlYyA9
IDEyMDAwMDA7DQogDQotCWlmIChieXBhc3MpDQotCQl3cml0ZWwoKHJlYWRsKHJlZ2Jhc2UpIHwg
QVQ5MV9TQ0tDX09TQzMyQllQKSwgcmVnYmFzZSk7DQotDQogCWh3ID0gJm9zYy0+aHc7DQogCXJl
dCA9IGNsa19od19yZWdpc3RlcihOVUxMLCAmb3NjLT5odyk7DQogCWlmIChyZXQpIHsNCi0tIA0K
Mi43LjQNCg0K
