Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED579C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE9B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KPs3dziB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PEADqODB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfB1Wdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:33:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16519 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1Wdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551393219; x=1582929219;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bXpyXhM1VPuRHSexgylDEMjcyOv6HeY7jkwJ4oVaicY=;
  b=KPs3dziBMGXTny9vBsZ0kiMPRkTPZbZn/HZu+SXqTlBQmBV07SRSY0jg
   WZDkx36limhvByVYOalJetFNtA1Hke/sirCBd5ckz8tZC0EZDfhDktqML
   iQ/XMG7jKmjYk9BWsjvXJ+69XjYgPmeRQfZGEP5xBa5ilXnR4GlPksbbl
   xB84fU5/1FogTy7uu7vTNMOxdeHeCqEKVg/Pqq3GomCOKCbAtFP6Ld2Eq
   yr/XCfwdl2DPcNQwosuESW23aH6Td+Y6Va/Ktisz+u+IsB/XPPjodtAzW
   kjJQm05jfmBoS8xopMJxVz99fx9PROZHKKcXcfcixWtG7IqlaOImw0hCD
   g==;
X-IronPort-AV: E=Sophos;i="5.58,424,1544457600"; 
   d="scan'208";a="102407957"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2019 06:33:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIES9tNj1tIvCcdZ5Go0OTE34muBCYmtLiuUTWVFeNQ=;
 b=PEADqODBdGEsNibd3PcsXRhrjfVi1wsvTlj0iaob4ECMsYeNMfNL+rea2EP7AFAPlU1tYZu4vKv4r7BzVPAM8yiVfNUI/fk5HAlHnEFXEGEuQf6A0d0fVXk/c7sSKvhrjPldXojhwEY6bEhhP3LIATSU9UE+gAtrs4KFq/swBsA=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0240.namprd04.prod.outlook.com (10.169.202.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 22:33:36 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::f55c:272b:6401:1b8c]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::f55c:272b:6401:1b8c%10]) with mapi id 15.20.1643.022; Thu, 28 Feb
 2019 22:33:36 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] Revert "of/device: Really only set bus DMA mask when
 appropriate"
Thread-Topic: [PATCH] Revert "of/device: Really only set bus DMA mask when
 appropriate"
Thread-Index: AQHUz7Wk3BuHftC4ukm45CM/91p02w==
Date:   Thu, 28 Feb 2019 22:33:36 +0000
Message-ID: <20190228223257.6189-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To MWHPR04MB0401.namprd04.prod.outlook.com
 (2603:10b6:300:70::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.45.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7e9b99-2d32-4015-e389-08d69dccc732
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0240;
x-ms-traffictypediagnostic: MWHPR04MB0240:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR04MB0240;23:WHr7pfR2xHwZpYAYID3p9iglvCElOyW4odlRbwo?=
 =?iso-8859-1?Q?4Lv79vjICqm7ZE134SfptRFF8ucw0fTuU7oVfkkcsBzuIFtIXcZAn23IZ/?=
 =?iso-8859-1?Q?lvqz1h+cRvD3pv0u1Z66LcM0IpGtt6xK3/WYGB/2VKEF9/P6NxERw3KkbO?=
 =?iso-8859-1?Q?BKOrZgJKsN3w7waJqDXMzwI8bxXEf8ezm8TOCYTIU9OWvqDmQb2spdpMiE?=
 =?iso-8859-1?Q?ZNvAUeyAW6iUXdDC0WxfpUBT27HZdR8Tg23XOp56YYV3AVHj3/W/Ejn8ZM?=
 =?iso-8859-1?Q?Y9LDmJqhntUN+z7fh1HpUJEO4GnTGGLFlMw+tLLwLdf83lRB5rWKlJIgat?=
 =?iso-8859-1?Q?TzLpT0fvlVsTLEj6J+oabESWqCnDv6fTsYzS2AnoUmUe9odN6szAtvucLF?=
 =?iso-8859-1?Q?/FMdMZs9yTjhTMg/sLvXJexB6HZ3oesKv41MCwb2DsEpf0Crd20Gvl/KlN?=
 =?iso-8859-1?Q?38U84fc0dYWl0HlLO/NH0OJ82iZ5EnJtenSOJSWzbaZwtNTLD0E0LT1fW5?=
 =?iso-8859-1?Q?SwWGlWs88blpk2uEsSu3SiKWIEbVkba4P9Gor+6ONS77/19sTQQUxXVQLX?=
 =?iso-8859-1?Q?7h6TphReU36aJs88X/ctCqFXWMKfNrR7ZEmmE6SBxIdvFy43pFjRGwvnXp?=
 =?iso-8859-1?Q?bW90WzWT//oV/1WbsZDjyI36N7Ybjxqcr6ZLncahKSjc9knMpp7slVWD6V?=
 =?iso-8859-1?Q?eDcdDoMyv6LhKQ9qyrvyJFKHHpnyfTdnM3Lw3Jnu16TZ18X1Tc2fyZ2/c4?=
 =?iso-8859-1?Q?4+qo3ikEQe9tDY/PA0X9TpbrFX46wgRuYFaYbPew9R2+HElMrGaurzj/Lh?=
 =?iso-8859-1?Q?UnIOugg6jWe+3Hhp+Hu9PyofAkwoPC8pwnV5cN4ash/1r5FsAqryS68Jgk?=
 =?iso-8859-1?Q?WBfmAAj9BBBsiMIIsO7ni8wyG1BaF7kBE8+nTfcdJNI2WoN3rXxSAnj6Nw?=
 =?iso-8859-1?Q?TaB+HyNMfz0jzSkCH+sM3+qmNg+3emjsnNYwIzb5QYeewEQSpTSNO30CEn?=
 =?iso-8859-1?Q?Djx43e+HFyfhfBG8o/SexlFbBd8cGNQ5pawFPpxAIPqnC40do8zmikEWN8?=
 =?iso-8859-1?Q?I21RoaCQ0AaZ0oTu8w+AqP//engOtsX0j1uo9yvnSvtBkR29hrT7vD29nQ?=
 =?iso-8859-1?Q?pLrk4jEgQHcJrWHdbAlWpVHsX2xWglbCVl+3Pj7GhPA5QFd7fHTg+QHwtL?=
 =?iso-8859-1?Q?ICFo6czu2pGQ+khIjIMlTpj7ypwGn/wvcgG67bYjwIcf6IKLH5+m7IYl7K?=
 =?iso-8859-1?Q?bpPa9ObImDd8WPP2/uqCeFHRqXrOckbzyOZQly4H9bw8+sUUeWgXCsa2cI?=
 =?iso-8859-1?Q?QxcJKEr4Z8SxfdPQnk9poID?=
x-microsoft-antispam-prvs: <MWHPR04MB0240F1D2B107D4FCFC269B4590750@MWHPR04MB0240.namprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(26005)(97736004)(2906002)(2501003)(71190400001)(71200400001)(53936002)(6512007)(36756003)(14454004)(3846002)(6116002)(86362001)(2201001)(14444005)(256004)(5024004)(4326008)(66066001)(305945005)(7736002)(102836004)(52116002)(486006)(2616005)(81166006)(81156014)(6506007)(8936002)(68736007)(8676002)(105586002)(106356001)(99286004)(1076003)(50226002)(186003)(6436002)(386003)(476003)(316002)(478600001)(54906003)(5660300002)(72206003)(6486002)(44832011)(25786009)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0240;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yOHWkxqf9+/XEcuTGSSfZH7d59NfqL8itD4MFAk6nru5gLdnBiSODnWd0zqjCvhLRbjgVmgdOx2espTbBu0JvUjAUT/h/M5h+e7sX9hzZkBKh1vH8+eCDYVGh6pCecnbMtDzVQKzUC3KRn5y4iPTCM3e798hYmNW6CDi0i2fYBEiRR7KCSJecIodXf7Sws4cBuSokuNOw7sf0QuLVtFe4jk1GgSfKQ+BQ4fDY1vznt87AusRCABA0UqCGvjyveMlNdDyzUp7XqYvnds8rGfOhSAmOJHaFznny1bX4B/Ib7kTrpwA3dbvH2dYY+6D8uKEcOdf2C6kPbzDq7KnBfy5tNWqVoco8a3uK0pN+BX2GkvzmqVq+SRT7AZZ2W4T1PzUhyQJOUZciaiCDZjWguTwPakFIR1xPCbJurA4hekQzfE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e9b99-2d32-4015-e389-08d69dccc732
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 22:33:35.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6778be4e520959659b27a441c06a84c9cb009085.

Reverting the commit fixes these error messages and an non-functioning
USB bus when attaching a USB to PCIe card to a RISC-V board:
    xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 micros=
econds.
    xhci_hcd 0000:03:00.0: startup error -19
    xhci_hcd 0000:03:00.0: USB bus 2 deregistered
    xhci_hcd 0000:03:00.0: WARNING: Host System Error
    xhci_hcd 0000:03:00.0: remove, state 1

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
I'm not sure if this is the correct fix, it's possible something else is
wrong, but I wanted to get some feedback.

drivers/of/device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a20d0d..8299f8055da7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,11 +149,9 @@ int of_dma_configure(struct device *dev, struct device=
_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask =3D DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
+	dev->bus_dma_mask =3D mask;
 	dev->coherent_dma_mask &=3D mask;
 	*dev->dma_mask &=3D mask;
-	/* ...but only set bus mask if we found valid dma-ranges earlier */
-	if (!ret)
-		dev->bus_dma_mask =3D mask;
=20
 	coherent =3D of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
--=20
2.20.1

