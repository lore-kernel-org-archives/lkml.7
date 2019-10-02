Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E624C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F4B21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPMlX+9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfJBNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:05:01 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:20989
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfJBNFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5NN9Qu7Ky6ZIPtycoaUdLxTM6yoxVZ+5Y7xnS4iv/bCjHUMxmO6ZZ/gD+weoM6qpGHNGR1r1b3JyYBMqoHZLMO7J97cx9h2Hb+Y6Yh8rszGqVuto/0ZymSMjcEx851jtggiRhT6BrSm3TZcFY5lqwaQa5bvnXrWWhqsvRGM7Pv1cIb5lELhmHCA2UpdAGWwOrI1doCfS7a6VSJrcY5iK6fXDjyd9Dim1FmgFVVv3hB2F+g21QLX7rEVkzyv9a8YCkFFbR1ejSWYtdd8JXsugyM7Xp/Q2HliNihQeVgVa/8JnbKQSycurhkonYcpS/dK2d9apyXRa45QtqKJ+cerYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDRbKsOFigBmVYBko0W+r9T3uEFtB6nFeU5C/rB+UAY=;
 b=n+KQodOz8sA2YAALGvWjoMVW6KBLhAyqqnxjuqhCV94SmXInutdNuMmIqoOTwhLMEQ7AjhuW3m/v0hrml5S+Oly4/iZjhEhsQWmym7byDvgO2KG3P0pF4oKMMTRKu9fMysu4zvVQbJPSmmcctlWjiSyVD+B2eUSYENEIle0mwipcSE6pFhIi9JNHrKfg8t/Dlwey5BarBKPVCjN+TS5e7wYZtPXECO0/vF8DRyREJ726Smdh81mX8as8eeifuoDlm731R0AoMdxYVY6AZ0VnPZkSgpU0ycXiTMEp+9k1Yo/flAAWJ3nJXwjNbyCKByRGgunF23gtNDJU8sxiZFbpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDRbKsOFigBmVYBko0W+r9T3uEFtB6nFeU5C/rB+UAY=;
 b=XPMlX+9RgFGwUvNoiHWqPyQrOy6Imy6FfZ1NMMirslJ4d8BR27nelC6k+b3fRP5zzr4JFW0KF9uUnmt6RE+TdgJaS2+XxA+ABDopM2J4hx5nq4gUSiHi5CPWjgmDF1IDfEADTdo9T6HgKmDUfzOTmyw9lvmtpZbq0vkql35eRCI=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (52.134.17.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 2 Oct 2019 13:04:41 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 13:04:41 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: [PATCH v5 2/5] arm64: Introduce config for S32
Thread-Topic: [PATCH v5 2/5] arm64: Introduce config for S32
Thread-Index: AQHVeSH0gYgaSbiD5UaSomdVgm1X0w==
Date:   Wed, 2 Oct 2019 13:04:41 +0000
Message-ID: <20191002130425.28905-3-stefan-gabriel.mirea@nxp.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: PR0P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::14) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c21a046-5b28-41aa-2275-08d747391678
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3918:|VI1PR0402MB3918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3918A4525A7FFEC4E841470ADF9C0@VI1PR0402MB3918.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(102836004)(2201001)(5660300002)(26005)(478600001)(76176011)(486006)(386003)(14454004)(50226002)(8676002)(8936002)(81156014)(305945005)(81166006)(6506007)(7736002)(7416002)(64756008)(6436002)(66556008)(66446008)(476003)(66066001)(2906002)(11346002)(2616005)(66476007)(6486002)(66946007)(25786009)(52116002)(2501003)(186003)(256004)(446003)(6512007)(6116002)(3846002)(36756003)(71190400001)(71200400001)(4744005)(4326008)(1076003)(86362001)(54906003)(99286004)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQeSlaIxYa5KHIyyZ4Nm0oT8JotShh3g43P9bjIWQTKD2TgOSOupnvB+JKkaJoPyKwxDNbGibC6mHsoAUJA00qg+Z/DBrkhn1abc4kkJXYX/OLiZHHRPvAF0Hj6pemc+kEstGszZeQzj3F8DvwKtoHwiN35D0B+lr9W3qeuShcNwBVd1xOsE/yYNuXEuyx+NsXc05tNBoEtKajuTfx7Bj/JuDVVNQWmEOLdIBoy27OUfQ3C1l/ZvlkJhZsYMCTVLrfv5tELZb8qYDEYTfr/hz/p0McpajkpUC3rLilSw+cD+Eig1M1hywVwX3czN5cJ7tsSaoQKUQ5KxQace+LAct5M+fqKj+1pjexIZfgmnq0taEHDdpaKdc0+eqwqeaCuf7sIV/21ILcjTZPXSjg1uaNLvbdPn+LbGVJYKYupeRGc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c21a046-5b28-41aa-2275-08d747391678
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:04:41.4043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUKCLDeCiPmP6bSQB4G9flHLA2kdIhTEk4GJEt6XOD+VFG2Lfgn31aqm7upSrufkBPTjVKzU69HQ97Ic4pwQ6W6GT2evk/tgfeZTaH24bLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
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
index 16d761475a86..17f1c34ec750 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -212,6 +212,11 @@ config ARCH_ROCKCHIP
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

