Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F621726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="az1sO3aL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405550AbfHWPjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:39:45 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:36202 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbfHWPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:39:45 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BHOHHPOCbOIOCh6tCS1oerSD0plEvxRbKIIazbZ1EU2Kh39TD75wJoqc4Vyito7lE9n9WAg4Pj
 mycYsp9Fn4tvDnjhbvdebMac8gsNp/jOGGl+F571NeN1EybHbGp1Qa3Qqj5cXNWpTSpoAELx+6
 naiztAIU7BBHeq7pltf5DlGkDi/PsfLor/YThh7Ia7sCd6Yu4nwRS0LzQwI2AA+XF5+h6TFIxh
 4oXwNBP8Az5IHpyO0BT+LcwTgUQrKiV5Im89Hd9Bbk2NhStKP1phkPM28/VMCviqpyZrwoVcx8
 +UI=
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="46396281"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 08:39:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 08:39:39 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 23 Aug 2019 08:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eItSPnjQ/EncuLYpJNhugfxjJTUvJV3pt/Y5RACiygX6++FUt5KBlXtE/gUt0QGCLPkhpu/WPsLWqpZJKKvWpb43cOnq62pNUm3ku6BB63ffe0SD3NCdQHvAWVZsAyBJGFHnQiln3RHwr1muyRB+Ys7iWuN+KStsnQUuZctsukpNPiS7Icf7xeBTxN3Ybgc+QlcL0IIbm+UUFzgaDuoo/llZ0dUfrpwWULndhnonSV6V6O7RiP4F5XAjY7FvJdfAAJFN+XWpwK8Tfv+14hJo30z6b7cnxrbdkZdnjPzfRXHNwkH2B3Tq43/RHfwH5gELWZbkySv9H9BO+dtbCtJKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl9RZL02iDdm3Q6kyLd0i8Wz4yL+bKaudkFZFUJyMsw=;
 b=ZHRMWnOZJWPlecqNPQsjBgdR7KLL7jUHhu2OloJVE5lFcILGtqOQgx3DrZ4fnNXzdUcoqOSIGVVd1t1RTPQ+WRKtUdlbkpx9uNRbEYpkAUIpn61/51LeI/ZemdlmsUNx/dlVgMjMYQ4wALCU7esqq6zVSqnsLLE19mVkNeN63EcwG6zAlFLvHMyCrWdLHFG7OaPkh3QgmTNYwhtnFlOX9xszW22xe7iLxd4huIseSxfjlQ86ke7+iUyZIxIDr49AzVa0UA1426fkmMOHIvz9nOt7wIZ5jf5JeBwhfOnosbAyP1ydLhuSy0lo+1FmuHNt7P4UUHRlp0Tzld2XCVx8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl9RZL02iDdm3Q6kyLd0i8Wz4yL+bKaudkFZFUJyMsw=;
 b=az1sO3aL0Fdn0CGyX/Z7JmYeRC9usypiVRv+yv832s6cEdpeq2HK7V2zYumtYQgRyOQzqcrEtlXzBbWAnkWvI9PYDo9DaIn8BIFx9WsSwxxPiZJSWBC/HlG1gY7XO3yRp4dQIFuAtOfv2BcP3pbp4HUpUK0dkHDVFK8AJm4/q3g=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3790.namprd11.prod.outlook.com (20.178.253.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 15:39:38 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:39:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>, <trivial@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH trivial] mtd: nand: fix typo, s/erasablocks/eraseblocks
Thread-Topic: [PATCH trivial] mtd: nand: fix typo, s/erasablocks/eraseblocks
Thread-Index: AQHVWcj4FEswtLSxfUuTqMNPFMEnag==
Date:   Fri, 23 Aug 2019 15:39:37 +0000
Message-ID: <20190823153927.12805-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:803:118::22) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e06fd12b-876d-4793-d632-08d727e01acf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3790;
x-ms-traffictypediagnostic: MN2PR11MB3790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3790214BDBC9717978622477F0A40@MN2PR11MB3790.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(186003)(14454004)(71190400001)(52116002)(81166006)(6512007)(71200400001)(66556008)(66446008)(8936002)(64756008)(2616005)(1076003)(2906002)(486006)(25786009)(256004)(7736002)(14444005)(99286004)(6436002)(4326008)(4744005)(50226002)(305945005)(6116002)(3846002)(316002)(8676002)(6506007)(26005)(81156014)(66946007)(2201001)(478600001)(36756003)(107886003)(6486002)(476003)(110136005)(86362001)(53936002)(102836004)(5660300002)(2501003)(66476007)(386003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3790;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MX2p+tYRASu5QhLxACqkqvcemnRkwQVXBnBk3F1GsJIlc+WpoZ0cZAdBAEeoZHHUZTLf37fYt1jIqmWtYf3jmNnHdTu1JbM/2vFAqRUcsWi8q7oa1oxd8Jda3DO9b2q55Ij4+wID5poKJSKQSJTfJ9PiQcdAH3FvDCw5bjq2mRFVn7IeN1VXvIIZvk6AjXsSuqXtJxSbC5birBxe58TqkVucE19tVI/+SRbK4qPaOVdfu2UxjfF4L9gyYEg1UIqzgZJLyneKHtnxFF14VlTtRVoxWCARqOXBNxK8awZXrjjp8yrfTgewkDPSgU7aB/izTt/1aLMKPwISfB5+NI8QKraacOBPtJDnJn8vS/Psb2/tSQqXEAyZBfAwA7m10nGJ52kt5EnEbB0QxE9NKFwVCEzozo63knctbqWs/Iqd7DU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e06fd12b-876d-4793-d632-08d727e01acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:39:37.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VO0X2fHlw+FN1bbnz4rIu2pYat+6BpMIil/laSNN8i43AM11Jo4gGZoFXRAI3vk3BsQ/5fG/iOM4liFgrydTtJVp18WzzSq4j2VS8kcFiq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 include/linux/mtd/nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index cebc38b6d6f5..0c7483843a32 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -346,7 +346,7 @@ static inline unsigned int nanddev_ntargets(const struc=
t nand_device *nand)
 }
=20
 /**
- * nanddev_neraseblocks() - Get the total number of erasablocks
+ * nanddev_neraseblocks() - Get the total number of eraseblocks
  * @nand: NAND device
  *
  * Return: the total number of eraseblocks exposed by @nand.
--=20
2.9.5

