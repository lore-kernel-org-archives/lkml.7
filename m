Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B460C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED920850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l2sd2uZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406084AbfHWTLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:11:51 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:31678
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405030AbfHWTLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOQ8sA9HIealBV4GQh92D1O4LPW4evUfplXTLVEIwNOu4hWLQlJIJxr2ebWNbIPENVFssqDqEsQ+J2+5+ruMYeQBo3fgG287vrIfNqO36a75JypVo5z0NrKANMmsl/EWzu/ZQGy6w/CTD6SFZHDWc2zj+nL3bMBvzNugsbjSrmliIVxxy5zYX9qR/7MbWRqV2/UPh5lHt6TaxSSEPD7lK7ZvNEOXyTlbyj+AVr1Pp7VWVHkgUenHn8g6/Td3m0A7N5/ix/WRPfpJ823kZE9H+3gEKsauNa9ygP6UfMShxe0ZBYO1VSygYqYK/GYWsz2qEfB9d4raiiJsvPlqb3TN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe33SIbYB88KZ1InOfVAGswqJd5chZSXWAxNGDHRk5M=;
 b=JaLqvWRUN+Yij6/fmEI+egzUHQHL2Aks8hMgMkUDSYQ1iUeKmB5EYchZ8kOvLryVx8aTNyI20yhzaui6NY4qa9v3dvrMbQJVPp9I5HMhgIwyWsxPJaVQ3ZW/8fVwThiPuneyALqGRF/H0A9RXG+PBP0bWzSduDw0lDeHXRLUENfbYLxjMFUrvNKAnOtOXVJXFw2/Ef4/a3IJJTIeVnqUV8Q6gLOVfxKoz+KbHj3er1EzM9mOJf5M/S65v+EKZhcs/SnXw+IOOPbJdyenWIfUBzFOu9NzfFZk7x8a8Ts54TRUaBHz4qK84zXYNV4Vka1oLL2E77gEFIK8o1T4Gg0OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe33SIbYB88KZ1InOfVAGswqJd5chZSXWAxNGDHRk5M=;
 b=l2sd2uZ84hOp9pOFMZ4T4O3R8NbaK4Db9+iwTSSmKyhOHYKh0A3s1+ho0GjazE5MEVnNWBaQ8WXnk7ZRRHcL9UVEcN7PidYhgKDtoaVAgaXRM541Wp8YRKn028JC662U3t1VmTCLICB/nrxiPM6Zz0JsP5oAgcgvDxfrvDs85jw=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 19:11:33 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 19:11:33 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH v3 2/7] arm64: Introduce config for S32
Thread-Topic: [PATCH v3 2/7] arm64: Introduce config for S32
Thread-Index: AQHVWeaUeu8ClIZIZ02ntuPRrU2pWg==
Date:   Fri, 23 Aug 2019 19:11:33 +0000
Message-ID: <20190823191115.18490-3-stefan-gabriel.mirea@nxp.com>
References: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190823191115.18490-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:203:90::17) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a02c3a0-3361-4816-724e-08d727fdb65f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2717;
x-ms-traffictypediagnostic: VI1PR0402MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2717A8A2E191B39B753028A2DFA40@VI1PR0402MB2717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(446003)(476003)(2501003)(66446008)(76176011)(6436002)(6486002)(386003)(6506007)(50226002)(81156014)(256004)(86362001)(66946007)(64756008)(66556008)(66476007)(66066001)(186003)(8936002)(6512007)(25786009)(81166006)(36756003)(478600001)(52116002)(8676002)(14454004)(102836004)(6116002)(5660300002)(486006)(26005)(2201001)(71200400001)(53936002)(71190400001)(1076003)(316002)(110136005)(7416002)(54906003)(4326008)(99286004)(7736002)(305945005)(6636002)(3846002)(11346002)(2616005)(4744005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2717;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GWD3IOsrk4sHW+qE0pyovaqW3bgYKDeZJZBiq+VGjAStQPKOJKZJb3EANeFNfKVAWmZ+DKy9G+x5V/dTzM6XW9bhV2DMTvSInsJZ2h1NsUKnN1iNbPjQPvNk8XDRsWgGn5KT3IKGbxD5Uo6t1pd4iNOoULLk13ziBhWWk7Td933WipktbWIV7ONOqJYZPDGpCn50gA0KMVmWO3Ukp3xtTBoV62QY6Chex5aXzt5I3E0OujPAfk9tNJNxvWpHnps9H3ZQU7tIwr8x6FCRcaZbZR0gUv03sMBkHUPIMMAbSsE0s7AgJ+2MUU0KuPvjZzppld+8oX+qgskQrrXbOYNuRiaRNPoEeaBPC1M586kqt+xWaO6HZ1/deBSb4HK/nqHNImjlSdsC1/I+Btn04Z9VIo+QxKROVHHzFhHfyxm6HhU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a02c3a0-3361-4816-724e-08d727fdb65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:11:33.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zS9a0F0iyEkxYw4lUr61USq4cr8zGGm0zk9n0fUVA6fjqhXmfDRtQEc078y9HdvlM4hbhlSq6o1RliusO5fKad1LzCyonMA2hyYF1mecMks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Add configuration option for the NXP S32 platform family in
Kconfig.platforms. For starters, the only SoC supported will be Treerunner
(S32V234), with a single execution target: the S32V234-EVB (rev 29288)
board.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c775de1b..64bbe2d0b04f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -210,6 +210,11 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
=20
+config ARCH_S32
+	bool "NXP S32 SoC Family"
+	help
+	  This enables support for the NXP S32 family of processors.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
--=20
2.22.0

