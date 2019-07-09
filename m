Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1461CC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CEE21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GzifLgaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGIIWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:22:34 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:28357
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfGIIWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFFjx8Bfr95fqxYAYadzrFzzMV8DGJioJm9RQ/xO/pxzqRpJh617EOleAGGjjL9V1Stoqv8zbaTdIO8zE4/OXH6MebtLMuIuEcDY7uGVlDjIWAMlZNpafUYi1xQXQqSU11MU3bnxSejXu/Cbseexo7jtGSdiNWjxvaSTPYrAB0hu+7KhInjrRLKINUzUUe+caWFMa80EmOMJL8zkIw2nZz679ibn2RXZ+rYiC/KtvXKpYmd/5NcNSfZPJYzqCN72kqMAdXh3hrSkqSA4jKAiDnEbFeHzF1EGxyYoeFVXpcDu3VHdVKqA5LzJrfBreY6r0RgTd+ehBrkSMFbIGvFHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0VeOYnQJzd+/2ZaGMz39y9y70V69Y7YVJV+39rC1WU=;
 b=CmAzxd13ZyP/Bo7XcEueHl+dMo61VjdK6Oho2vDiU8DyAiDiRE6YNsXY+pNxBkZuxG9wSAwAp6DPP1eblJMyNj5Dn886suOlXoy0090MlWOH3DynWzx+y08eZBCe+fktMKGhbOhMIw3ofmsw7mFeHkUPvEZHmng5AGTUuPa6forofKYxUwugFlzWjJKzRvZhWtjcxNbfHizVmR/yHWL/xtdxDPeC8H4dhqz5eOgOlUilmcv1/t7GnDmmp8LwuPdMKgWYOGgVccqbu/xF5U8tpVXXApGX3ABP+NZY272woR6OqB160PSZm45PCtOQjjUeC6cjgSACHEpjNQmiCPtnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0VeOYnQJzd+/2ZaGMz39y9y70V69Y7YVJV+39rC1WU=;
 b=GzifLgaLwt+rSoT4WuEWTwgjCBp/ktWL/wPP2tyXjxHkMBJ+5VLi2rq96Zadlplh5RT6MsHnX95SuMjYyIgv/iirqIPrRhyITPtzN8aqP/i8zhts6p1/zAAiVt24SXVeW70nmHoG08W+RzduvzABv42RsMn+jRRcD81CDdk3NfE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6050.eurprd04.prod.outlook.com (20.179.32.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 9 Jul 2019 08:22:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::2023:c0e5:8a63:2e47%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 08:22:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Topic: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Index: AQHVNi9zmpVhxJk2Z0aPUBEkePn3cw==
Date:   Tue, 9 Jul 2019 08:22:30 +0000
Message-ID: <20190709083729.11135-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9121fe40-b778-47ae-ea76-08d7044695ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6050;
x-ms-traffictypediagnostic: AM0PR04MB6050:
x-microsoft-antispam-prvs: <AM0PR04MB605051BEAB92F04288000EDE88F10@AM0PR04MB6050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:194;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(478600001)(7736002)(50226002)(386003)(4326008)(5660300002)(6436002)(6506007)(4744005)(99286004)(2906002)(66066001)(52116002)(54906003)(6486002)(2501003)(8936002)(186003)(26005)(110136005)(14444005)(256004)(305945005)(316002)(102836004)(6512007)(81166006)(81156014)(486006)(25786009)(68736007)(86362001)(6116002)(3846002)(53936002)(8676002)(1076003)(476003)(44832011)(2616005)(73956011)(36756003)(66446008)(66476007)(66556008)(64756008)(71200400001)(14454004)(66946007)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6050;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gdfL97amVfYXLuvxiFtdG8YKtio0ybCCX44aY3h+w3W0ckmOmYG9WW5UBijEnmx7Qv3uJAik2y9m3zVAf3Dh49uYf8e2ax0+DPY7pixHax2DJR0TOq1p2Yk8Sz/kyRS40l0LCqMxvCbwuv3meeKaFKZ6iNxHNoSSjm1Fd5Rch/gDZvgrb39UXGc60D3GQRng2iHSpFALYtQHG6flwkZ9yF2KawuoTwR8I0Mu4foJBYoI8G1JVRnlX7GR/oNHgcKClzRRQzzKR0kkdEWSiVHHycKzECvLtd/a/oFFNHA8o15TvDNzgwc6vQBsv4TBIrMcvxCqkE36S3nLePywz/26Lm3x3Q5s1/eJDYsxKi8JaWh6z+e2FEy/B1kkCriNg4Spq9zpnehdo/RnRT103oqtK3Xkq0nrK304bkjPic/tyLs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9121fe40-b778-47ae-ea76-08d7044695ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 08:22:30.5672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 shares some code under arch/arm/xen, including mm.c.
However ZONE_DMA is removed by commit
ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
So to ARM64, need use __GFP_DMA32.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/xen/mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index e1d44b903dfc..a95e76d18bf9 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -27,7 +27,7 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int ord=
er)
=20
 	for_each_memblock(memory, reg) {
 		if (reg->base < (phys_addr_t)0xffffffff) {
-			flags |=3D __GFP_DMA;
+			flags |=3D __GFP_DMA | __GFP_DMA32;
 			break;
 		}
 	}
--=20
2.16.4

