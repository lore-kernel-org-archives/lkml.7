Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5692322CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tqkrqu4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfIEL64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:58:56 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:16451
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388280AbfIEL6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKAoDb2zCK7Q+bzXXcqOeTtYELoM9zyY0OBmTaVI1ymAl51JZzKb1/IPHtE2I5WNp/018V4LuBtbLZbzP9nOaBlNFqEUHF8H1M3y22nxbZ/jD1NXy4oFse2laMIyWP8CJEcA2E4IRyCL9wbaGJlnjunZl1iZ6ogR+U+OX/4vAeKArUQXygnYNIWzaLHaPyogxY26a+2jgGuue4XZTXrIkEn5rUNJUnbDp3mbPqIiUkWWzeRIEfJLlHfD6dspM/XxDxvSclLx0kdmtEyzwgrmRe3h6U6i8ZyaX+94uB8ydmfpJSG9gGkN3UcX4rMSIirLNbok2siyFFv2MadHQw2wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=RiDFctgqIYUCOM0NAqMrspLlcu0fS4GgrqkZaq3w/RQUFhxN5UK4D3ZjKxK6EBK4iSf/JYCOG/eawSsJlSnReaQ0WwD9YCJzkHtdms+/MZf9HO7f8gmvGZ0HR37aTFvlBgSLsFqj2seZ1/lPHpA9hm/17PxXn6IsnWffDZuwYuMLOuZQMut8nBC0iRcFWYidPo0PydRHepUJ8YEdvdXMEcrIjkxomcWvlyFNrfMZzbBd3hVqE7ACBf7OUojsrZln7lgh4k+3R5/jU/ogC80nBIC07qotpxgs/SyCgluN8SpxdIP8b/c8ecbWMk83d01eZqd0+u1r3+Lil9ghEuIluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAmLLcYxNc+vNg4VL0BrjM1fDO0l7UPG3LF2prGCGY=;
 b=Tqkrqu4rOsAEd5J1ezYDkXwvgxLUPExymw50TUmtBgVMh4kjKv2k2ndYq+776jm4TGSyRFasSSkJe/ppQUTN+r3CDL5Q3tEJrxOp782X9aI5kUYg48udTudLbEj45U5A6qEcnGavqG8edkj/gfKC5VVQxf4bXVmFquo5tpgpjLE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Thu, 5 Sep 2019 11:58:41 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::19cd:9f82:31ce:fbbb%8]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 11:58:41 +0000
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
Subject: [PATCH v4 6/6] arm64: defconfig: Enable configs for S32V234
Thread-Topic: [PATCH v4 6/6] arm64: defconfig: Enable configs for S32V234
Thread-Index: AQHVY+FC12rG9yn4iU2MzSxKohFhxg==
Date:   Thu, 5 Sep 2019 11:58:41 +0000
Message-ID: <20190905115803.19565-7-stefan-gabriel.mirea@nxp.com>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e9e927-a1d5-45cf-0cf4-08d731f8650b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3805;
x-ms-traffictypediagnostic: VI1PR0402MB3805:|VI1PR0402MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB38052310A176976C1AE777F8DFBB0@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(476003)(81156014)(81166006)(446003)(2616005)(486006)(71190400001)(11346002)(6436002)(1076003)(54906003)(71200400001)(110136005)(53936002)(8676002)(7416002)(102836004)(478600001)(36756003)(14454004)(6512007)(25786009)(2501003)(2201001)(86362001)(256004)(66556008)(64756008)(66446008)(186003)(66946007)(26005)(4326008)(4744005)(3846002)(7736002)(316002)(6506007)(52116002)(99286004)(8936002)(76176011)(2906002)(305945005)(6486002)(5660300002)(50226002)(66066001)(6116002)(66476007)(6636002)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3805;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P2/Ou2M7NRa69+jdpisdTjUDtNnjQhQZwee+CQ+3DhmyPHbsqQZ2jYVvx+uW7DrZateik+4GOLdgaAG+ixIbRehEKZYSNH/3VSqgTyevI17mJVY1oMoypbTXSQ42ZhOfbMTwQqr4ijStR6nyX5uy/q7yMU9XV3Jm2jnNpgeGFU9cvTRozMXYhhJdZu+wphb8n1vjfzHoUMV1N9/UYl7uR5h+GbmH/9T/TMXHsYRJ1qeTJ/ySdZeUeLYsbMRr1qXGi+mLSKFGYqV7kYjfSYdKHE0uDmzeivRmhF9m/tgTmmIwnAde097htu7/aXbwhhSOMcSlXg+KloThczCLXGJNViFnTtYpGNUNQh9l5cWn+USDAaFz4jj/MZMckHYu6jbjYRSqaSx7Gnyvl3xu7Peod4g8ctJu2WCU31h4Jy6MoHE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e9e927-a1d5-45cf-0cf4-08d731f8650b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 11:58:41.5936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5mWGBWRf+jmJM9z5sDNk/Rpm21pcY6qpcMUrrIKi46x4+3xOozdj8zvb9BF6wDGoh1eoSMa9ms/axi3R03KD48JWdeLX+uCVDZ+0PCqj1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Enable support for the S32V234 SoC, including the previously added UART
driver.

Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..bb5aa95a8455 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -48,6 +48,7 @@ CONFIG_ARCH_MXC=3Dy
 CONFIG_ARCH_QCOM=3Dy
 CONFIG_ARCH_RENESAS=3Dy
 CONFIG_ARCH_ROCKCHIP=3Dy
+CONFIG_ARCH_S32=3Dy
 CONFIG_ARCH_SEATTLE=3Dy
 CONFIG_ARCH_STRATIX10=3Dy
 CONFIG_ARCH_SYNQUACER=3Dy
@@ -347,6 +348,8 @@ CONFIG_SERIAL_XILINX_PS_UART=3Dy
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=3Dy
 CONFIG_SERIAL_FSL_LPUART=3Dy
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART=3Dy
+CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=3Dy
 CONFIG_SERIAL_MVEBU_UART=3Dy
 CONFIG_SERIAL_DEV_BUS=3Dy
 CONFIG_VIRTIO_CONSOLE=3Dy
--=20
2.22.0

