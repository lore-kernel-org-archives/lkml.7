Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04A1C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C05521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QOWWx0w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfEUKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:11:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:3550 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:11:26 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,494,1549954800"; 
   d="scan'208";a="35521451"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 03:11:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 21 May 2019 03:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwgT6eZYUPDlhGYpBCynN5Q1QzyGCv+JPz1oxPWFsx8=;
 b=QOWWx0w394aXXpeIENXnO7RhuJA8Sb1x1EkN1Wer1aldxVGbIggSh/6IiFC2Zub91+pddvcaubm3uSBEPxPy0W5ovlnRebAJI6rWOFTe1DdKeaPFZ9+DN1fCZa6MH4+adb6fJkE1YZ/hxuZq/kIHBSJkUTNHmCdJbd/tbHez1N0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1949.namprd11.prod.outlook.com (10.175.54.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 10:11:22 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 10:11:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 1/4] clk: at91: sckc: sama5d4 has no bypass support
Thread-Topic: [PATCH v4 1/4] clk: at91: sckc: sama5d4 has no bypass support
Thread-Index: AQHVD72KmkcClWjzC0mXuPvf8FDVrA==
Date:   Tue, 21 May 2019 10:11:22 +0000
Message-ID: <1558433454-27971-2-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 4b174d7c-f739-4061-c3a3-08d6ddd4acdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1949;
x-ms-traffictypediagnostic: MWHPR11MB1949:
x-microsoft-antispam-prvs: <MWHPR11MB19494C27D6DD52DA9933215987070@MWHPR11MB1949.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:773;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(66446008)(66556008)(81156014)(486006)(66476007)(102836004)(14454004)(2906002)(64756008)(316002)(73956011)(72206003)(26005)(476003)(446003)(68736007)(66066001)(2616005)(186003)(25786009)(99286004)(50226002)(66946007)(11346002)(52116002)(6636002)(2501003)(81166006)(8936002)(6436002)(86362001)(386003)(7736002)(4326008)(110136005)(54906003)(5660300002)(3846002)(6116002)(6506007)(6512007)(36756003)(107886003)(256004)(71200400001)(6486002)(478600001)(53936002)(305945005)(71190400001)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1949;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c+ttUcHFRxGDfTREbd0RxXBq1h9f418b0cvnw2ff50BpUyv909e1+DVTGt/JeEyfpN5Ak8U0pCJcySWZFXa22GU+61//6Rdhcxs5u4YvrxGTmj6pCBAjJ3vQ81o/qy59Vz5kpfSIO8VLw1DYNEUrpL6qNbFrN9xa3F+5B0hpJ9zQzaVmW1tmRdOpA1jmmRkT3RJ//poaD0KjNYVUitVA52caMv/0OE0bLamj2fZgvfQlftEgtnKvh0dEpAd1CUbxZ/vDg40vUFi45KMJ/PVzjSo3rty/2S4dSQHnmk9LBtJWvSGaO81D84LcV6uQr4JLU2uPEqNNV7UWYziwXFVI5E7yx4m15LEn1+YPJfPWlkp6yR4qllE3x+HpeY9OBakq3IfC3lRqCaIGGZNrn2ZYdY5GvNKo08yfr0MjOdqD8Ho=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b174d7c-f739-4061-c3a3-08d6ddd4acdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 10:11:22.6075
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

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClRo
ZSBzbG93IGNsb2NrIG9mIFNBTUE1RDQgaGFzIG5vIGJ5cGFzcyBzdXBwb3J0IHRodXMgcmVtb3Zl
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWlj
cm9jaGlwLmNvbT4NCkFja2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxv
bmlAYm9vdGxpbi5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyB8IDYgLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9hdDkxL3Nja2MuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQppbmRleCBlNzZiMWQ2
NGU5MDUuLjZjNTVhN2E4NmY3OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5j
DQorKysgYi9kcml2ZXJzL2Nsay9hdDkxL3Nja2MuYw0KQEAgLTQyOSw3ICs0MjksNiBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgb2Zfc2FtYTVkNF9zY2tjX3NldHVwKHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnApDQogCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQ7DQogCWNvbnN0IGNoYXIgKnh0YWxfbmFt
ZTsNCiAJY29uc3QgY2hhciAqcGFyZW50X25hbWVzWzJdID0geyAic2xvd19yY19vc2MiLCAic2xv
d19vc2MiIH07DQotCWJvb2wgYnlwYXNzOw0KIAlpbnQgcmV0Ow0KIA0KIAlpZiAoIXJlZ2Jhc2Up
DQpAQCAtNDQzLDggKzQ0Miw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvZl9zYW1hNWQ0X3Nja2Nf
c2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkNCiANCiAJeHRhbF9uYW1lID0gb2ZfY2xrX2dl
dF9wYXJlbnRfbmFtZShucCwgMCk7DQogDQotCWJ5cGFzcyA9IG9mX3Byb3BlcnR5X3JlYWRfYm9v
bChucCwgImF0bWVsLG9zYy1ieXBhc3MiKTsNCi0NCiAJb3NjID0ga3phbGxvYyhzaXplb2YoKm9z
YyksIEdGUF9LRVJORUwpOw0KIAlpZiAoIW9zYykNCiAJCXJldHVybjsNCkBAIC00NTksOSArNDU2
LDYgQEAgc3RhdGljIHZvaWQgX19pbml0IG9mX3NhbWE1ZDRfc2NrY19zZXR1cChzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wKQ0KIAlvc2MtPnNja2NyID0gcmVnYmFzZTsNCiAJb3NjLT5zdGFydHVwX3Vz
ZWMgPSAxMjAwMDAwOw0KIA0KLQlpZiAoYnlwYXNzKQ0KLQkJd3JpdGVsKChyZWFkbChyZWdiYXNl
KSB8IEFUOTFfU0NLQ19PU0MzMkJZUCksIHJlZ2Jhc2UpOw0KLQ0KIAlodyA9ICZvc2MtPmh3Ow0K
IAlyZXQgPSBjbGtfaHdfcmVnaXN0ZXIoTlVMTCwgJm9zYy0+aHcpOw0KIAlpZiAocmV0KSB7DQot
LSANCjIuNy40DQoNCg==
