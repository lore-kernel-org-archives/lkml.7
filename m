Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E39214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iW/dK8i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfHHIfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:35:48 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43644 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfHHIfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:35:46 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RY3q2Q80RNwYERE2vCW4rQcaEFq380jsKHF2eOkpCKwXhnFdIs7CMGcn3MkKJdJdCfvGTX4GNa
 84KvgoQ5tPKig0rbP4fi7valZ9srh+wwb+CVAwadGtSM8+n/wJvLoKTC0QeE8Nx3b6QOtNMkai
 Byb27KxFJ6ryXq9uloQJAPd1pIQaIwqoQDWcl7eVkNlmTB2z6Q88XG/anCByAqi5Q82rooMhwT
 SrTANv65yZcHNO1+UTkxC7hAoeJoqAlK5c6hbnKkbSvgniJQJXoQno5RjqgWWNjGzgQaKKJsvi
 0lA=
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="44412904"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Aug 2019 01:35:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Aug 2019 01:35:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 01:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS+dpHSD4lLXkWuvTeFdKLAgCwNQq7uXLUjbS1gyJcGxnbCX22ySGcoERSQKe7XApZgNos8gbIZN8RLIIwtFjLfdWirxRFXw5bwW1KzNJd+ALcwRzX7iGQFiqtwjGCYfaZW4zZKWbfvwxUwUivBzPi7ksTyDOL30LpWagxBeV7z4XLDtGyzDnrS0vSFVWKAHB6JWZ5izFY1T3mt/d9ud8G12ZNbJsOmGSJ3lZt9Tez/Jw/UBEVMbhzrS9/yLJ+oh4e7jzGU8BgqEQA2JfY5SMiyUc5riMMZ8K89G4KjLdemxrJY46bPJDDvrNDPnZOeOVc16FrSQTGeXB9WGSK1Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pseR9+6/5NTqfa/7+d7WpjGM1Wn3kcpn9G4zGNTt9r0=;
 b=BhZyUberdFyeQzeXwzb6YN1c1VWpIa7iP2GJdiAKF12uTFhXVvohBiGDQqjU65SKqhQTnYPtRYKcCw5f+n99guTdx3d1+HvxmCmiUVJuIjyhych+VDUUT34OdTfGXu0Dzf1Pog5zr5V7JxzkPDoH/7z6er7zWLma8T0MgJL9EhDBInp/4Zh3X7vzwpwsoBLu2IPuB8cpZwh7KPUilejsvx2Kpjmbjxmpsg5FQu6GzlFHt3Mr10V0gBxyO2wOSpdp1QMh1cH2QLLZFPc7cjQfn1iNg3Sv9fgPjpxPr3GniAYjqe/hl4QIkPgPe9pcoMlz8Ummjruf+TXrRGup0DflKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pseR9+6/5NTqfa/7+d7WpjGM1Wn3kcpn9G4zGNTt9r0=;
 b=iW/dK8i06zyXXoNRuGddCczG30iU0Xab3AELHBDqzCp3pUJ16DoxTlJY5mM6aIsNGitOnaq2vfS/2nwm8pL28XzDY9dibzjIBdkvXKAogLwSj3hs8jaNhPbAre19GE9u9mrUu0FHuO18AGEGtTPLTC+CJ5F0Di7Sn57Yx9hCsRA=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1545.namprd11.prod.outlook.com (10.172.36.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 08:35:43 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3%10]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 08:35:43 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc capabilities
 for SDMMC0
Thread-Topic: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc
 capabilities for SDMMC0
Thread-Index: AQHVTcREWHJkbws9ckOkZIu1sPO5NQ==
Date:   Thu, 8 Aug 2019 08:35:43 +0000
Message-ID: <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16521185-323f-4cc1-2632-08d71bdb666d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1545;
x-ms-traffictypediagnostic: DM5PR11MB1545:
x-microsoft-antispam-prvs: <DM5PR11MB1545F838BF905C8AE809F660E8D70@DM5PR11MB1545.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(26005)(66066001)(64756008)(66556008)(66476007)(66446008)(6116002)(3846002)(2501003)(2906002)(446003)(66946007)(11346002)(14454004)(256004)(36756003)(6486002)(2201001)(6436002)(86362001)(305945005)(7736002)(53936002)(81156014)(99286004)(81166006)(4326008)(478600001)(6512007)(76176011)(8676002)(316002)(52116002)(25786009)(486006)(2616005)(476003)(71200400001)(71190400001)(102836004)(107886003)(386003)(4744005)(50226002)(6506007)(186003)(5660300002)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1545;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u01LVk5+UmXthyMYPJGkwqT0hjHfsGrzrkcnZx6TQHi7yIGZZpxlkq4qzsLKCzfmYaNPvQ6vJxObFfCcmfsBXPAYbQRLV6wpn+MijFPfe1qtZcXCSXtyM/ywU20E5K99MiVjI9OgdPrss10z/DkdEn4IbBOXdPUy+lbXhZSINp/jG7O1XDQiqeq3dDnuSZTx/WclHbBpMtveG/wz88ONNxYQmE/mrGDcqQVAIWjkpjNdMPbQiBDeBVDJNB0eH36tCbiRaZq7G3n9EXR+g6hI5RfdLSj/j6sSvq1vJAJifCSEycTYSu6jSQGeZrodb7YjSssObBXul0D9HLBwQWQz0VP6FqwGr2x/UWyg8irG1U/JNmGjcuY6twps7ZqfblxRsEQBWK85TsNaYYQJ6/zEtCsxLFm7NY0y0z9jmj/bIFM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16521185-323f-4cc1-2632-08d71bdb666d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 08:35:43.1299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVfxCLiNiLFvo5r1vj2ojcupQWVSrJbfoHBkTvK/fbl3WbNR09p716FxBoOzIHZGQ+ElkLT97E5t4rZsiCBHJfQ1CIJnbWrCov7Q4yCXtic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add mmc capabilities for SDMMC0 for this board.
With this enabled, eMMC connected card is detected as:

mmc0: new DDR MMC card at address 0001

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 149e539..194b3a3 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -54,6 +54,7 @@
=20
 		sdmmc0: sdio-host@a0000000 {
 			bus-width =3D <8>;
+			mmc-ddr-3_3v;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&pinctrl_sdmmc0_default>;
 			status =3D "okay";
--=20
2.7.4

