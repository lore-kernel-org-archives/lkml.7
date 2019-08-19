Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F0C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0A92087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="NWm6Zfms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfHSL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:29:17 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:61984
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfHSL3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I52F4x8cVaSnG56F1vOeMJvU1z0+VUpXWk+OOoFL8p5BIBcYDEPBVxj3Ohkt7viWAJAyttyMBCJrbPr3p2/fxOc8DO2eTFukgH6DmciLPEatSi9BN7UkX4gnKx+rQCP4uQv2CpPfrbCFoI/0ka9VxGWRmiVV9TIs2uHJIkViAJQ9eVGT1RPsWTj1kMN/QXZ6t08AzLqID7FSI0/o62EswNQ7s1ZxgTdlsI3Ci+O2lhq21TSPjo+xgs8UYWfCpFHjqpGMx3QmXujv9rmvK5Y1pIKK+osjX8xXfmqKoW+7YoiuAtKPvlf2GjHNQ5uFhrgRboecDLk1+tNq6ohwGDtz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC2c3L5LPZhLtLOAjlnlg4PWalUTa000Vi2cQQ8LN+0=;
 b=mUkQzW0TKJr6EF9DK6oMeiEbIup9xXUXoer1vyw6UfDB7X/X03K0aSEQqS+oEYK5UFi3j3UTnPywx7NVAeJ0ZnCHxv003APT6aHCMvf3U77usCRT4huACyHxNzuQeiSmY1N2mqJfZDAsoyLvyLWqi4Syy3DR4ooddaxfp/tPgXX6CuEz4TlXdFs7ExIy+FGwq0AAUoQl1edU0ypl9P9nGNIJb/5kz2bpVp04vgBok0TC/Vf8Xf1YtkBycN/Rpu5WrNWa+qzfBPz9JSgChe4S0lwG/sqhjrWzCAtizN+cm5jvXNVVQcoD9lFJWd/BRIN1Y0xHq56J0zJE6YiHM4BtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC2c3L5LPZhLtLOAjlnlg4PWalUTa000Vi2cQQ8LN+0=;
 b=NWm6ZfmsNEP4b4xv2y0JLqnXQeI+UzFHYv2hTAY7gdp2dDSS1sZBN6HWMn1KLdoEIQp3rn+dTChAYBGYqCFjmsIHI8qb0svRQ8KL2gSiqOUmSRZ0tiYg6fCl94bA1w0yVwEjiQbKrhUihM1PJhRZL3/Z34h3KtlV8ELIgM80qHY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3528.namprd03.prod.outlook.com (52.135.213.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 11:29:02 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Mon, 19 Aug 2019
 11:29:02 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@suse.de>
Subject: [PATCH 3/3] arm64: use -fpatchable-function-entry if available
Thread-Topic: [PATCH 3/3] arm64: use -fpatchable-function-entry if available
Thread-Index: AQHVVoFN2Lv6AB17aEmGqsR7fljPbg==
Date:   Mon, 19 Aug 2019 11:29:02 +0000
Message-ID: <20190819191759.04bf63d7@xhacker.debian>
References: <20190819191530.0f47b9b1@xhacker.debian>
In-Reply-To: <20190819191530.0f47b9b1@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::25) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49ad5a23-9a7e-44a8-b7f7-08d724986f82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3528;
x-ms-traffictypediagnostic: BYAPR03MB3528:
x-microsoft-antispam-prvs: <BYAPR03MB3528774C8B183882CF23796CEDA80@BYAPR03MB3528.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(5660300002)(8936002)(50226002)(86362001)(81156014)(81166006)(71200400001)(71190400001)(25786009)(486006)(476003)(8676002)(11346002)(14444005)(446003)(66446008)(64756008)(66556008)(66476007)(66946007)(1076003)(6512007)(66066001)(9686003)(26005)(6486002)(305945005)(99286004)(186003)(102836004)(2906002)(52116002)(54906003)(53936002)(3846002)(6116002)(316002)(256004)(4326008)(76176011)(14454004)(6506007)(386003)(6436002)(7736002)(478600001)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3528;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X5+ScyQM29NkaeV6MUAuUsvbrHo77/hpyURwoFhQ96I88p4Dhj7ScUfCMo53TWW7dX+rbFpGt4KdtDsLAuEIiOZ5jJsjlwhLZaaNctMLjO3FjOVlMVGMdR7OzTWzYfPVhBtLGEMTA0ABMxW3BnevJP1Xfuk/++kV4MyL7EGpKqh9jaFxG5N+0Su/UkaHsifp4gBT0Cdt6ksJC0bkLRTWre9HGBQ8N7Sr1o/pUFZk7NwA7uCRMaSxOy5ufMQB2c59INldu0FvV7S2hfZGHHJDxROLet88IZrygWRMJfsmeCrWXU2YvpJn8RwTXHp40JLgnmcdh99AJAWHxacgauz7fhs8/QOk3g4RZmb8ESG+VmV1l852+5d44ZgoUecH5UXFWvs1EjGHhjvSEMqtPKiXLRgZAE0iieHTPHjXLMA/GWg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F564ED1F300CF54C8A10B682A5790DA0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ad5a23-9a7e-44a8-b7f7-08d724986f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 11:29:02.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bi20ZOJlBolHMJwL1632eUyaT0dc6YPGZWZAcfQ2TgKi2h81qFZZKwdgILn4uxRZBDYssz6dGf+owjlnR5Yo7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3528
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Torsten Duwe <duwe@suse.de>

Test whether gcc supports -fpatchable-function-entry and use it to promote
DYNAMIC_FTRACE to DYNAMIC_FTRACE_WITH_REGS. Amend support for the new
object section that holds the locations (__patchable_function_entries) and
define a proper "notrace" attribute to switch it off.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/arm64/Kconfig  | 2 ++
 arch/arm64/Makefile | 5 +++++
 kernel/module.c     | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..663392d1eae2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
+		if $(cc-option,-fpatchable-function-entry=3D2)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 61de992bbea3..e827ad0298ab 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -104,6 +104,11 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+=3D -T $(srctree)/arch/arm64/kernel/module.lds
 endif
=20
+ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
+  KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+  CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
+endif
+
 # Default value
 head-y		:=3D arch/arm64/kernel/head.o
=20
diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..0759f89adbd3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3136,7 +3136,12 @@ static int find_module_sections(struct module *mod, =
struct load_info *info)
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	/* sechdrs[0].sh_size is always zero */
-	mod->ftrace_callsites =3D section_objs(info, "__mcount_loc",
+	mod->ftrace_callsites =3D section_objs(info,
+#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+					     "__patchable_function_entries",
+#else
+					     "__mcount_loc",
+#endif
 					     sizeof(*mod->ftrace_callsites),
 					     &mod->num_ftrace_callsites);
 #endif
--=20
2.23.0.rc1

