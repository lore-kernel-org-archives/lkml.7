Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651F42067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MjS/Oqt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKLHT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:19:57 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:32007 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfKLHT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:19:56 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: UaoQ8Rb+LNeQhe4NOHZQIoUQUa1GPWBFS/9ARKoXziJc0VR0BE/SkwTJ7143sQxwBEBGwqAGpQ
 EqREUGE0TB36td3RLLX3XjxQWtniW6247+7l4QmEMYfpe778cl/ot0ffb2TjyLpCxvFtX6tY0e
 43D46IRxL0x144bHJLl1Wbah/B40rlKPQOs6OQik9YRUmW3mBS4xvJqXnEytFp0JNMXmuGfc7C
 vvSFJpU92R6YAi38gM7G0NNoWsUWFQu0VmW2A3Ddqh6EsXMNGvc/g8BygbgrFvoi/IhYg6PBAu
 jzo=
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="57943366"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Nov 2019 00:19:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 00:19:51 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 12 Nov 2019 00:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc/oFspdaZxFag9EuJUUjQoCUG22YZzKZA+3x3ct31z8v1yds/A3iezQK98qqFsy/upMPv5ZOWapNerTrtq1tr3vebfoGB7bMLvE/oSVWSenjWR3BZSz0npHXcBH1E9M7HPCVvgViu/eDVTdiYMAYdvrhL1e+o2MtKDp7CWfRsAnmYq/oNJHMI+tQOCZ9EMqME46j4nNcGxMphvL8/Coq2hfVpDqGhKTC5OSPT7lEyZcE1Zkan92keUuTJL9KsIMCBGUDPhBbos5YZon8UmCtmJ6gcwyb8Adpyd8ero+9eCHEHe/My6TEcUQiD7F+1EhYqHFLzVHksGXbTiWWi90Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oTYJu10/YtTgWeNvvHR9umVM+pfMcpH3W/H8ktjIU8=;
 b=kJ9wfkmr8jXPJPVewstbyviRMocfpi+birMMM1RpoFdm5ViQWxDLm33tLOOpnQ39rO4ElJ3Et1bI+P5F6fnAfX4CedtSJa6UEOtcGOPw8iEgqcArNg6VlAffTxOEsyzawEn9R+E5MSaaZ2934ss82LEaPzF9MLGbtpazmZSPiGxqyld0WRwR6XQNe1R4NLs5Lg1BcDe6PmHbs6w2niALMq7VI2u5TmOcPheFLYULprnUsQAXSd9/ueChmEdPjWmWvoV7tTIVDo4B88aQQ0FRRY9LU07p/IA2jznAaPs1ttIq6B5ZSsDSLCHHINe7p8WhJ/9sJWYcllfJfK/QqdRU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oTYJu10/YtTgWeNvvHR9umVM+pfMcpH3W/H8ktjIU8=;
 b=MjS/Oqt2+wENK1vlANG/w4eEGmizA2gA3EC1aSTq8c57ZjFZwkYo+DOgPiVDnUC0VsgphGZjtf9JnaAZUzAC1EwuymYQAHmG7Gofvay4xho2QfoeCP9cE7I708ZaPUevZe+TWC48meSdIE1iHyun2YM2Hwe5Kn5rpVp81vzzZyg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1323.namprd11.prod.outlook.com (10.168.108.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 07:19:49 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 07:19:49 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <razvan.stefanescu@microchip.com>
Subject: [PATCH 1/4] ARM: dts: at91: sama5d2: disable pwm0 by default
Thread-Topic: [PATCH 1/4] ARM: dts: at91: sama5d2: disable pwm0 by default
Thread-Index: AQHVmSmRK5rG1l9BvkGEY/vJDZT6pg==
Date:   Tue, 12 Nov 2019 07:19:48 +0000
Message-ID: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:208:15::26) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a7ea0d8-390e-46c1-1e15-08d76740b3b9
x-ms-traffictypediagnostic: DM5PR11MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB132341A87BCCF7B1165C1786E8770@DM5PR11MB1323.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(186003)(81156014)(8676002)(8936002)(81166006)(50226002)(4744005)(6116002)(3846002)(7736002)(2906002)(54906003)(36756003)(6636002)(478600001)(2501003)(110136005)(316002)(6436002)(71200400001)(71190400001)(86362001)(14454004)(25786009)(305945005)(486006)(2616005)(66946007)(5660300002)(52116002)(4326008)(26005)(476003)(386003)(6486002)(66066001)(102836004)(6506007)(66556008)(256004)(6512007)(64756008)(107886003)(99286004)(66476007)(14444005)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1323;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcaA39zKU6WQjwvfyYO4j9E1ZP/kOGumObBG57ma5R5G4259ofuKWVoM0c2HZIOmOe1Ks+lep3VfwhCqqFzXW2MwCvj5KK4H+IB+c52Vw/IglTVVQSJt1g70fCMG9jeNRiF9o01z9FuJ4zd+ooYQatF9lXrdwEUnrALKgefLjG/pk9fBYulFQRGUCuBER2eGCYEQEbL9rZnMxZ2e1vR8DHgTWBwZinxhzcZXytz62h7i8SrTXq/g7hvh6XUEsx+VvHANefRPJ7yAztgzCUzNsgyDI/bv6jKWCyHTfxnUjCPkcStddrJqM0Wo/BYkHgPjKlJR1SJ1+T303lq+cO5Dgy0+TyA6dirdIfpMSRDvr6UTipFlGkt98YY7Qnxous0ppO3qqLNz7DsApX+GZntg8/q8bghbziQL81YC/O+vfaQUUJ57EvEkoevXRxtzP9/S
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ea0d8-390e-46c1-1e15-08d76740b3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 07:19:49.1943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PeVwm4Dn+hbm2nXjKGXITilFgSJuwsCd1EnEkVLrLNxlC5ZwoSqFRsfEwBJkyi3sgLXNZJF55sepM0TrPhh1Mtj4llCbvnpwW/MIuD77KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

It will be enabled as needed by each board.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dts=
i
index 5652048..4d3ba6d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -615,6 +615,7 @@
 				interrupts =3D <38 IRQ_TYPE_LEVEL_HIGH 7>;
 				#pwm-cells =3D <3>;
 				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 38>;
+				status =3D "disabled";
 			};
=20
 			sfr: sfr@f8030000 {
--=20
2.7.4

