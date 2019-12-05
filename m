Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D11C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE5B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tSPQHjsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLEHoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:44:05 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:40962 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfLEHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:44:04 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: fqAolvmVVNxftTTn7QqxI/YpKASGBfjeOF1DNlvr+l/G+LzncX+Or5JJweDRLqeH2WgiP5Uycd
 +I7+Nk0SgVoUT0VeJoJl/VZi73RiZGtMFb/hH17Ova/h9fg7fwo9lR1cklohjKVUVDrgi1k5IN
 7o4WV/mCWmE8hhzjvOZo/s0cVyQjmtlnrce8jCSn73ERcr4JjZ7jW3IPNfOC/+PsDEUZ8wbYaW
 i42NEFgL+wHForsUtLMFiIngm8VoUYVnXnoboKAn+4RwMIALdXOaPmwxeDy2KLHpzwfunptGK9
 LHY=
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; 
   d="scan'208";a="57531256"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2019 00:44:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Dec 2019 00:44:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Dec 2019 00:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo+2Z4/fmfQwsw6/fHDY1xYDVDFH5FvOxneos326mB1FBC2e32fK5+MZ62TIL/PowjS0OSt9cSLWbK1ys+E+N3WBuuUkUvAQT53iBVEAPuFtqUpzRMYMNEKuRwQ/Gh7NHRSGBKL+XJuGjzWYJ4GzsW7E7LbC4jLlN/dRhv9V2yc+NHWhnfJPaE1qC1x1w2kT2rWvryx+VGQX5CJzRWOsCmqA/4IYEEA+YCfonkDx+I7Os+mlmtfm3a7aBrKYFdVnE76nehF6KFGn8XPK1AZfed3G8+zH1GLb0VoIjiiUQeQoeP9UQpIlLO5FvBdtxfkRHwK3sT8nEENDRekKPeDAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BY2OOvek2n0cROwi7zCbZlygB3Wzuw3zRVbP7xA2dw=;
 b=nD2iNJp/GCJBShWp8DJXFz3HaMvgi7uwFhHFY7nJIXPMdAjyyJwHcT+6PvN+ATPe16rVVfHPviefndBYSMgU1FntBavIVb+U5jo1ldlZkdaudDB+xgyPEkS6Vb1WYlC0jeieKa+MAuxFjV58F+1IcnACjyJcxK8Bv1f4DdIBriOPLeqxVByYdbJ/6ldXg7NskIw54rVrcuniyry/MFpaFGBomXJYDrdv+/VwhGXmYWO5U6sa0k9mSsNUHnjjcb5ezEPXPOuShW3Yc1tP3D5yGUbAjC4c+c+1JS19PEuS5BbMc68v1SWQLnY3zQP7AevEbo+y4dgNaLRMjrC6C3EEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BY2OOvek2n0cROwi7zCbZlygB3Wzuw3zRVbP7xA2dw=;
 b=tSPQHjsyP7dqqaNVOyaX1yMSUGLVOuG2JW6yTG6zONPro3NIAizc+ct2XjdmU/IGlXVrL4BRdG2uOcVEAHR14fOpTtvENGmorpiOMA7JLdeF4IEdl4SS1SYcUsDkUhIHXWW6aQEe/28a3oqAwjCvBo/tCVsseYsHos/ibU4l6NM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1979.namprd11.prod.outlook.com (10.175.87.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 07:44:00 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 07:44:00 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: sama5d27_som1_ek: add i2c filters
 properties
Thread-Topic: [PATCH v2] ARM: dts: at91: sama5d27_som1_ek: add i2c filters
 properties
Thread-Index: AQHVqz/BD+DgFrWFI0623R1669TGuQ==
Date:   Thu, 5 Dec 2019 07:43:59 +0000
Message-ID: <1575531818-21332-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0065.eurprd05.prod.outlook.com
 (2603:10a6:200:68::33) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 861c72ea-ad79-4905-24ff-08d77956e3fe
x-ms-traffictypediagnostic: DM5PR11MB1979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1979A799E97B9BE0CFF33286E85C0@DM5PR11MB1979.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(99286004)(478600001)(25786009)(66946007)(52116002)(4326008)(14454004)(102836004)(26005)(8676002)(6506007)(186003)(6436002)(316002)(2351001)(66446008)(5660300002)(66556008)(64756008)(54906003)(66476007)(71200400001)(2616005)(86362001)(81156014)(81166006)(36756003)(8936002)(305945005)(7736002)(6512007)(2906002)(107886003)(2501003)(3846002)(6486002)(6916009)(5640700003)(71190400001)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1979;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7RUP+Dz0pArgx0lGgggFMHvr0dGpkBEIGO2vJI8eXvFmt0k+5dL18RksUO89/lFrrCY5lZd75VV6/HrU/VSWW6W2KXQq5nfz3Wm2wsVWUug5WbtkonzS/Le+zNYfC1x/6FBxpZJZeSu0JZXFpTZWtgPB+IknrVps8dTd2F0pdfrqAMHWWQEyXTtv+pp01+SNRaM5d2pOVqFRUa7oouPoK9c05oXqF5SXwzFLp3YgiOBSf7Wc+Fik2VaVU3tdkuyP3yXOcmZFk5fkviEc86YqZE1M/Je1ppOttW4FYukVbh55v4TIhLEr8w98xS9+U2pZ9DzVrPUjRYK3ZJIoWyTjmI4d2OBBQopNslipaxZ8MLuexJO7N3oNPHJbqgnRl8dQIg/DsB2O0Ab1qDT76n63nWYTrNe5FC4JDGjKRwj/GG7CZ3UaLKgNtFayUxfzfY81
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 861c72ea-ad79-4905-24ff-08d77956e3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 07:43:59.9044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9XvXMQVywPY85M9FnbsQ0ijCKYzbIVaGEq3BOx/CZgwKhcscJjhN8XhLPR0VNa8R0WyAr918YGhAyFJoNcJ3OTsVufEez8q0oLDbBDcjpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add properties for i2c filters for i2c0 and i2c1 on sama5d27_som1_ek.
Noise is affecting communication on i2c for example when connecting i2c
camera sensors.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Changes in v2:
- properties were at the wrong node for i2c0, need to be at the i2c node
not the parent flexcom

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index fca5716..b0853bf 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -131,6 +131,9 @@
 					interrupts =3D <20 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas =3D <0>, <0>;
 					dma-names =3D "tx", "rx";
+					i2c-analog-filter;
+					i2c-digital-filter;
+					i2c-digital-filter-width-ns =3D <35>;
 					#address-cells =3D <1>;
 					#size-cells =3D <0>;
 					clocks =3D <&pmc PMC_TYPE_PERIPHERAL 20>;
@@ -246,6 +249,9 @@
=20
 			i2c1: i2c@fc028000 {
 				dmas =3D <0>, <0>;
+				i2c-analog-filter;
+				i2c-digital-filter;
+				i2c-digital-filter-width-ns =3D <35>;
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_i2c1_default>;
 				status =3D "okay";
--=20
2.7.4

