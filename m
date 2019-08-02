Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA36C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F7F2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W93tUU2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406697AbfHBTrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:47:35 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:31662
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404902AbfHBTra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:47:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHSOMIr5XOfj2vspTQplFqLLBvr6YzAw9GC3GmaiNAcIIGiZQairKupT/ws9mAlp3tzIKxJ4Rq4Y0H0JtuYutGwsMM+rdN0wq2mDNQHY5ZRLiyQZoYNhF3HDQ5riDnmSJlHc9fmWinLiEDPAzw1b/l00UED85jZkfJ5vHaiR7EuZmvvQH7Sc8DXthKHbnIPp9xW6XBysvfNk6CEpM+O8EHFp2WDoo1y0kRaGmEPD14IPRpXazX2kqZ5/FZ0tLvlT2dK/yWMKxyltAUbG//PeSKPiK2vGCS61i+jw0MbiOADWVz3PFZ+2mqlkmeA6Hsot7HzWtv7xGjH/nja1doY/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v21CDJCD/8a9YgJtE9OOJDZ2FaNzN2uvWxpNJHK88wo=;
 b=d0+/lXip3VyxXE2+Tzw9biVf/SUIhP/4//BNHJtFEU9Rs4VfxyScsTyTGodnqVvG6pg8/jfsCqYo/7Nt2xFvnxl+v8nCJdw59EurGlgylmWUgOqonruCN1QgaF0OPosTRGbpvlEbjIubWUi8HluvVIAfXd8ElJwskJ5JO87tzFnr6DfWESyKycGrMWRP2eRA9jmsXiGAqHtJDOsyIomQaysNvJuvbpZTPNMOvrsZeCf6zgdQz//p7/v9HsKhrvDs+Eeelb+PBosyoStp6nv/MXJkjCkK0I4iKqtr7TGAbVPTKSc5E1BumAQtM0th7U2Oj59qr9OSQwxnYPZv//6THw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v21CDJCD/8a9YgJtE9OOJDZ2FaNzN2uvWxpNJHK88wo=;
 b=W93tUU2T7gPuEXLVFeaj+1qO9dp0J3PzCta8RDd1djU83iAu59yxk3R9A7fVIriOf6807B90k4k+SpKS4hwg1xjhW+OapmK/h88UJE4Bkuzci1UV8nCJ7+LaujID+OcI9rzZ25cEYfRGUjFXqG0lAmN07XMDdo4JELB5cn8EyhE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB2829.eurprd04.prod.outlook.com (10.175.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 19:47:18 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 19:47:18 +0000
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
Subject: [PATCH 2/6] arm64: Introduce config for S32
Thread-Topic: [PATCH 2/6] arm64: Introduce config for S32
Thread-Index: AQHVSWsXz0Pt2XfzzkillP+EFcmjQQ==
Date:   Fri, 2 Aug 2019 19:47:18 +0000
Message-ID: <20190802194702.30249-3-stefan-gabriel.mirea@nxp.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM6PR04CA0051.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::28) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20cb8aed-a644-42d6-aa67-08d7178239d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2829;
x-ms-traffictypediagnostic: VI1PR0402MB2829:
x-microsoft-antispam-prvs: <VI1PR0402MB28291A7FB2BDCC7BE0C31CB5DFD90@VI1PR0402MB2829.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(68736007)(446003)(8676002)(6486002)(54906003)(110136005)(3846002)(305945005)(4744005)(7416002)(1076003)(6116002)(66066001)(2906002)(2201001)(316002)(256004)(36756003)(6636002)(486006)(102836004)(14454004)(71200400001)(53936002)(26005)(66476007)(11346002)(81166006)(71190400001)(186003)(76176011)(66946007)(2616005)(64756008)(8936002)(66446008)(66556008)(99286004)(4326008)(386003)(6506007)(5660300002)(2501003)(52116002)(81156014)(50226002)(25786009)(476003)(478600001)(86362001)(7736002)(6512007)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2829;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wht4a8RZ/YM6hL9xfLIlhpd3PIUqbhPn9vttuy6WxmiCTebBlD/qP65pwTmqOURzmUExVBlhEmjIcfX6nPnbhlwq6Bh591zRHT2m2J56qaVlKcattsbs+66v8t1n+ofQXLtFU5iNUOCo/3pLQT9S2PttiMs2sQY2U0LLsaKfuIRO7HMh7cbX3GNO1H0WxdTA/ZAAk8mQZnjceEzHA09+ER35edAaIAw1FDWJemnyFEXhTQYl7nCcZenOC9Mb1D52ABhoJzduUphsMZyLLtpDkdyAQG3h5ZNY5DMq/ryq+tP+IKi2/lLzQdB9ri5WLB2pH3Ah6n4zSGb5Ybq5pV9smwf3lE8IzQJp6Sw5MVtCAlMHclDd6BLalm7tZI2ZLaXlhtAwMnZ32pnkn5LnocPnJnsKa8Lkwio2qLGGO16Frek=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cb8aed-a644-42d6-aa67-08d7178239d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 19:47:18.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stefan-gabriel.mirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mihaela Martinas <Mihaela.Martinas@freescale.com>

Add configuration option for the Freescale S32 platform family in
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
index 4778c775de1b..a9a6152d37eb 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -210,6 +210,11 @@ config ARCH_ROCKCHIP
 	  This enables support for the ARMv8 based Rockchip chipsets,
 	  like the RK3368.
=20
+config ARCH_S32
+	bool "Freescale S32 SoC Family"
+	help
+	  This enables support for the Freescale S32 family of processors.
+
 config ARCH_SEATTLE
 	bool "AMD Seattle SoC Family"
 	help
--=20
2.22.0

