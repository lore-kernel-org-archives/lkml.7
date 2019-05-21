Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A004C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B6E217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PosRD/8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfEUKLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:11:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18712 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfEUKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:11:35 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,494,1549954800"; 
   d="scan'208";a="33811489"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2019 03:11:34 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 21 May 2019 03:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/vLzv4gVFNHiU2aA7nmcpwSDi7OtKOIt6Sq3VU4E+I=;
 b=PosRD/8ZKwP/bc2klQfv+m+fw+yTgWsGFVOWsTM9PPdAKc0cTe69DOJNNizNv0EglDFicve/qfP1Hfa6ZJg3gkOfkCRh35izz/ovGcrKEm/hXSheBHeTuN6Yc+Rfi0zrs1bjYp1HIYYsQKFRcxww19mSVWkS10yVSOQKgoI6FrQ=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1949.namprd11.prod.outlook.com (10.175.54.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 10:11:29 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::f01a:9325:7a65:cdb4%4]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 10:11:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v4 3/4] dt-bindings: clk: at91: add bindings for SAM9X60's
 slow clock controller
Thread-Topic: [PATCH v4 3/4] dt-bindings: clk: at91: add bindings for
 SAM9X60's slow clock controller
Thread-Index: AQHVD72OvoOiK2frq02fKTgpDNgYOg==
Date:   Tue, 21 May 2019 10:11:29 +0000
Message-ID: <1558433454-27971-4-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b8494592-4db9-4ead-596b-08d6ddd4b10d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR11MB1949;
x-ms-traffictypediagnostic: MWHPR11MB1949:
x-microsoft-antispam-prvs: <MWHPR11MB1949B6E3CEEAA4EE5556F92D87070@MWHPR11MB1949.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(66446008)(66556008)(81156014)(486006)(66476007)(102836004)(14454004)(2906002)(64756008)(316002)(73956011)(72206003)(26005)(476003)(446003)(68736007)(66066001)(2616005)(186003)(25786009)(99286004)(50226002)(66946007)(11346002)(52116002)(6636002)(2501003)(81166006)(8936002)(6436002)(86362001)(386003)(7736002)(4326008)(110136005)(54906003)(5660300002)(3846002)(6116002)(6506007)(6512007)(36756003)(107886003)(256004)(71200400001)(6486002)(478600001)(53936002)(305945005)(71190400001)(8676002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1949;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n4kE2YXmQ48+o9DLOZJ6WCWpSbDM+kggCBjTE6H3sJJYGIWBICqIy6kdQzSl2GEF2xg0t8G+hmCQuCwU7o9rqlQhV2Rr2TLyDsseOW+5ipbZadePsGtl0k0kgYgxczIWaNGFzxwrQo67idwBWw2c0veOPvxisOXmseyGdnbc7kHwawA5PJ21RsXAtj+LR+YAQAgkYOvxF1ubglgtUp03QvpBgxTSVYB48KDHI/qwHrVTtFyyMiMS6zordkc+n7fWvwHVMKlTA0I0JUhS6qzfTiKfQBj8kcPoZLM9EK44ml4fXIDXiBsQrnnfx7wHMCniuBbOlTIr8h5l1MSH/xeQ3fNxb1utypNIcxeCSTpuOhXP4ImOQcVX67LcZCKZJL1NBdFKfaXJS8iano7Kt3kM8b2sfx4DjQTuAAIJZYKjy5k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b8494592-4db9-4ead-596b-08d6ddd4b10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 10:11:29.6414
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
ZCBiaW5kaW5ncyBmb3IgU0FNOVg2MCdzIHNsb3cgY2xvY2sgY29udHJvbGxlci4NCg0KU2lnbmVk
LW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpS
ZXZpZXdlZC1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4u
Y29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1jbG9jay50eHQgfCA3
ICsrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L2F0OTEtY2xvY2sudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L2F0OTEtY2xvY2sudHh0DQppbmRleCBiNTIwMjgwZTMzZmYuLjEzZjQ1ZGIzYjY2ZCAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2Nr
LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0OTEt
Y2xvY2sudHh0DQpAQCAtOSwxMCArOSwxMSBAQCBTbG93IENsb2NrIGNvbnRyb2xsZXI6DQogUmVx
dWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGUgOiBzaGFsbCBiZSBvbmUgb2YgdGhlIGZv
bGxvd2luZzoNCiAJImF0bWVsLGF0OTFzYW05eDUtc2NrYyIsDQotCSJhdG1lbCxzYW1hNWQzLXNj
a2MiIG9yDQotCSJhdG1lbCxzYW1hNWQ0LXNja2MiOg0KKwkiYXRtZWwsc2FtYTVkMy1zY2tjIiwN
CisJImF0bWVsLHNhbWE1ZDQtc2NrYyIgb3INCisJIm1pY3JvY2hpcCxzYW05eDYwLXNja2MiOg0K
IAkJYXQ5MSBTQ0tDIChTbG93IENsb2NrIENvbnRyb2xsZXIpDQotLSAjY2xvY2stY2VsbHMgOiBz
aGFsbCBiZSAwLg0KKy0gI2Nsb2NrLWNlbGxzIDogc2hhbGwgYmUgMSBmb3IgIm1pY3JvY2hpcCxz
YW05eDYwLXNja2MiIG90aGVyd2lzZSBzaGFsbCBiZSAwLg0KIC0gY2xvY2tzIDogc2hhbGwgYmUg
dGhlIGlucHV0IHBhcmVudCBjbG9jayBwaGFuZGxlIGZvciB0aGUgY2xvY2suDQogDQogT3B0aW9u
YWwgcHJvcGVydGllczoNCi0tIA0KMi43LjQNCg0K
