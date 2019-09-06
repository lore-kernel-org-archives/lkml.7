Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF886C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A402067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jKDEyTee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392343AbfIFPGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:06:44 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:13114 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfIFPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:06:44 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ixPM9k0Xx6/kH1us/OW3ASE2Uskwm9Kf5abJYFWYL12SBglkG51JRtNnsWb8lTzSUHQnrkzU4P
 czuNiVZgULECL3gxGTrZI6soHfcW0xrPE59DGbDuc6WJlFIIqc9fYJJA+zVWCeP4rnvcGhjxjL
 beWAV34ecHpfXSkrXnXDqsVdfovV5UyCfxreBBBm6zN30dowHOa/NpJ5LuiThCKPj7ZwMzFi6f
 MdUxxY+SaDBnux/1xH99fTNgt8yPVgI8Eb6wfBTk2Vh4F8c9dqljxVQgzWvXGK03CScOIwVwAM
 1gM=
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="47979632"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2019 08:06:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Sep 2019 08:06:43 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 6 Sep 2019 08:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEMFTrHODMPgGeIgWU8RRj1Zd94a1wZjQafX6kXByd5WqvPU4EZjOUhZumhbRgAue5UgOSaQZWDu0yptqq22gsCjBs3m12CBKVwxqjdQMlWRiHLsr23/tBz8A5GDrXy7THjYpQsR6JXnid+VCPo6OkVKfZCvtwZ+l5RDDPr+rEHNs31Xs4sdg0iqHrGUhVt/cbWwiLxENrx1zQt+/+m29RT269QZKyNRvOU+AVxxuRSGNX8aDbekbVu9CRGpYBE7xvq8zoN2f8DP8XYCd+b6OYk8hYa09vWoshud35LTrxcmWdZTyJ8Xwm/KU+LYw85Bdl1IrhtFefWitxUfFepRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNfLd2utraeGL6ncv+dL8RQ6T3mhSs4DbZX0BDNyKYg=;
 b=lrOIGITW7xokWsMGL4qvC8BMlQrJwbZ6akmvvIgFpBMIOMBK8alUo67sxhOqbreFeQkmh0JbDi/QPxekkJX8V50qDeWs9zuRf31yfh/jzOKZ2eXijxxP6kvX4SNCuJv9fmG69X33D3dkUuYLBfRidTPUEQcqQRop27kdI7u5ktwd/SWQcp17adb3W5ugHx2QhNFa6xTQrP7vQRMBBB1LVxbX3NULvBapvuXHZ7Tfhu6ONqGuz+CYXGSWVXPLbfSg67ltOaKYE9XeIxZQ5z/kQ+Yzq3PbTET9zrQieu3K0tp3W+FGO4rzdA1J46NZ2CaAHvUtZJAbhQplATSu8kQM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNfLd2utraeGL6ncv+dL8RQ6T3mhSs4DbZX0BDNyKYg=;
 b=jKDEyTeeF8vyjynEp8so2k863RWkUFqmQmnUWkqtO2/JkOR2aajpU6BzJAQALihpilUmd0j1EdP14fcMB+dg36q61l2dBvpfiF0e4S+UJv0y3vd+aONfjNm0qA8p7diS8I718H5huzLomfvqaszgr6v1DUraedQzbjijkD/VY+g=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3567.namprd11.prod.outlook.com (20.178.251.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 6 Sep 2019 15:06:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2220.024; Fri, 6 Sep 2019
 15:06:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH] memory: atmel-ebi: move NUM_CS definition inside EBI
 driver
Thread-Topic: [RESEND PATCH] memory: atmel-ebi: move NUM_CS definition inside
 EBI driver
Thread-Index: AQHVZMSw199+5/MIRkK0XEZtFVsM3g==
Date:   Fri, 6 Sep 2019 15:06:41 +0000
Message-ID: <20190906150632.19039-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:802:2::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 665264df-f608-4ad9-312e-08d732dbd2c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3567;
x-ms-traffictypediagnostic: MN2PR11MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3567ADB83C2A58C996917725F0BA0@MN2PR11MB3567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(86362001)(6436002)(71190400001)(71200400001)(1076003)(305945005)(7736002)(14454004)(2201001)(478600001)(2906002)(25786009)(50226002)(81156014)(8676002)(81166006)(4326008)(6116002)(3846002)(6512007)(53936002)(2501003)(107886003)(8936002)(2616005)(486006)(66446008)(66946007)(64756008)(66476007)(66556008)(476003)(36756003)(26005)(66066001)(256004)(5660300002)(110136005)(102836004)(52116002)(386003)(99286004)(6506007)(6486002)(316002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3567;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MKMFtuDbjRPEC77v0zmCNPs3anxkiablxDBMOo7bUgcJIyiD28yq/8cBwOgyiiJsDTWbKlHycHIzv6kUERuMc8H8cK3RxefnJ5DXHXB3wRtuCxTw5b5jo/NGRiv8mZXPuzPyGTBANUb6vl9FHA/lss3+tjS357/60KOrtHbNvEvJ5wrVvLRThwvkCwIvntUL1dIyCEt45HFIJA0xyEip1eWhVbjifsPNItfDDSCH5jrCkF9Y9pEjbSgh6o4183fyVZ+FyyfwGtJLj9NKJEZGSQ5xgmw2sywdZ9yp2FFXk6Zo4c+HuTyHkEn3WFzIJVv4/+iTduPyM/juFzBLoWVslMuhLdM1kJh9kt80UgXXvYuE3aUnEYAEOISaScPGpynPrSl385e5l7QTIuvoX4oLxsRnJDWNHGRjF1iqFrVvpwU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 665264df-f608-4ad9-312e-08d732dbd2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 15:06:41.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP4KqWPFWSBJGHxLxjpwOUqa7zcVqtNzAhJBs0u6ikWlIbPSJYlc3wGvQJSMb4JRTE0uHHV2PUR+PfwPEdpgpnlRvxExWlaMYIZh+81yZtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The total number of EBI CS lines is described by the EBI controller
and not by the Matrix. Move the definition for the number of CS
inside EBI driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c              | 6 ++++--
 include/linux/mfd/syscon/atmel-matrix.h | 1 -
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index d0cd57aaebb4..111e09a5b4e9 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -19,6 +19,8 @@
 #include <linux/regmap.h>
 #include <soc/at91/atmel-sfr.h>
=20
+#define AT91_EBI_NUM_CS		8
+
 struct atmel_ebi_dev_config {
 	int cs;
 	struct atmel_smc_cs_conf smcconf;
@@ -314,7 +316,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 		if (ret)
 			return ret;
=20
-		if (cs >=3D AT91_MATRIX_EBI_NUM_CS ||
+		if (cs >=3D AT91_EBI_NUM_CS ||
 		    !(ebi->caps->available_cs & BIT(cs))) {
 			dev_err(dev, "invalid reg property in %pOF\n", np);
 			return -EINVAL;
@@ -345,7 +347,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, s=
truct device_node *np,
 		apply =3D true;
=20
 	i =3D 0;
-	for_each_set_bit(cs, &cslines, AT91_MATRIX_EBI_NUM_CS) {
+	for_each_set_bit(cs, &cslines, AT91_EBI_NUM_CS) {
 		ebid->configs[i].cs =3D cs;
=20
 		if (apply) {
diff --git a/include/linux/mfd/syscon/atmel-matrix.h b/include/linux/mfd/sy=
scon/atmel-matrix.h
index 8293c3e2a82a..1e2cd118e4e3 100644
--- a/include/linux/mfd/syscon/atmel-matrix.h
+++ b/include/linux/mfd/syscon/atmel-matrix.h
@@ -110,7 +110,6 @@
 #define AT91_MATRIX_DDR_IOSR			BIT(18)
 #define AT91_MATRIX_NFD0_SELECT			BIT(24)
 #define AT91_MATRIX_DDR_MP_EN			BIT(25)
-#define AT91_MATRIX_EBI_NUM_CS			8
=20
 #define AT91_MATRIX_USBPUCR_PUON		BIT(30)
=20
--=20
2.9.5

