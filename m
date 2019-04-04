Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF0420882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Je+1Lp8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfDDU07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:26:59 -0400
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:43567
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729701AbfDDU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyrKQ+mR8wuOK7DtLFhPuRD4Q0NitYUioJskM4/Tvig=;
 b=Je+1Lp8DKbygSz7ULDwGQSihUiXRBMol8UpqxwfiEKqHG6wVLr1SF3qWz5kt0IR8jbNZ+pxccor+1Di3U8ilU8R27AJeByNv9LdtUMG86jpq+JSxeYb9doOpHBuYi+hBmp1sVgeNHnG6M+M3h7ww/A9OVxLneIhStLCt3qJA118=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1753.namprd12.prod.outlook.com (10.175.89.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 20:26:56 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 20:26:56 +0000
From:   "Hook, Gary" <Gary.Hook@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME early
 boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWA==
Date:   Thu, 4 Apr 2019 20:26:55 +0000
Message-ID: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:805:3e::28) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d403c95f-f76c-4b6e-125a-08d6b93be166
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR12MB1753;
x-ms-traffictypediagnostic: DM5PR12MB1753:
x-microsoft-antispam-prvs: <DM5PR12MB175372A214F52D7334FA5DA9FD500@DM5PR12MB1753.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(366004)(376002)(39860400002)(189003)(199004)(2501003)(8676002)(305945005)(6506007)(5660300002)(106356001)(316002)(105586002)(486006)(476003)(8936002)(14444005)(386003)(2906002)(54906003)(256004)(6436002)(6486002)(2351001)(66066001)(53936002)(81166006)(6512007)(14454004)(26005)(71200400001)(103116003)(81156014)(102836004)(6116002)(86362001)(3846002)(6916009)(478600001)(72206003)(68736007)(71190400001)(99286004)(97736004)(5640700003)(7736002)(4326008)(25786009)(52116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1753;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /wxz8xR+TIxlcvqCu/1F+y206tEY+MssVBrd39ZBq14UCUtGRBanJuVDHbe2StcyZJBB84mmSdRUNkEdJcWVjWUdtNz7GxTbrb0VQTKtaZwEbKdCI4IpLMRAPa2UIONmopjCNJU1LI29F3/ml6g+AqiV8xSvloexUh7vvg55FBr7AYpm+HTXBYS3lSswTYGU5j3/RaADo/Ld1b6T/YgdOcPoIhtRGiQ+7Qj2OqeeyhngWeqD/kjtvz0kMpCtWt5r3uWxZkzvSu5kXLCinfinRa2TlorLf5UEER2Nro6EWsXfKeJO9176t0g9jUeIu0wvSUAJP9UcYjh1TZ2yKEvoj1M3JaeKo/uT0RrRWHwQCsYOr0itpU+4NPH3Yn4X9B4eq+LAuSIseJeMD08/NLolfQE7pTNmyRQnE8Bvi1uNRQ8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8480F80AD1BEB146BF3905F9F673A9FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d403c95f-f76c-4b6e-125a-08d6b93be166
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 20:26:55.8788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enablement of AMD's Secure Memory Encryption feature is determined
very early in the boot cycle. Part of this procedure involves scanning
the command line for the paramater 'mem_encrypt'.

To determine intended state, the function sme_enable() uses library
functions cmdline_find_option() and strncmp().  Their use occurs early
enough such that we can't assume that any instrumentation subsystem is
initialized. For example, making calls to a KASAN-instrumented
function before KASAN is set up will likely result in the use of
uninitialized memory and a boot failure.

Avoid instrumenting these dependent functions by:

1) Making a local, static, renamed copy of strncpy() for use solely in
mem_encrypt_identity.c. In this file we are able to vet its few uses
and avoid exposing the rest of the kernel to a ubiquitously used but
un-instrumented function.

2) Disable instrumention of arch/x86/lib/cmdline.c based on the
assumption that the needed function (cmdline_find_option()) is vetted
through its use to date, and contains no lurking flaws that have not
yet been found through instrumentation such as KASAN.

Fixes: aca20d546214  ("x86/mm: Add support to make use of Secure Memory Enc=
ryption")
Reported-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 arch/x86/lib/Makefile              |   13 +++++++++++++
 arch/x86/mm/mem_encrypt_identity.c |   26 ++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 140e61843a07..38182a64fa81 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,6 +6,19 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:=3D n
=20
+# SME early boot code checks the cmdline, so don't instrument
+KCOV_INSTRUMENT_cmdline.o              :=3D n
+
+KASAN_SANITIZE_cmdline.o               :=3D n
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_cmdline.o                        =3D -pg
+endif
+
+# No stack protector
+nostackp :=3D $(call cc-option, -fno-stack-protector)
+CFLAGS_cmdline.o               :=3D $(nostackp)
+
 inat_tables_script =3D $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps =3D $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables =3D GEN     $@
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_i=
dentity.c
index 4aa9b1480866..0a68d7ccb371 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -77,6 +77,28 @@ static char sme_cmdline_arg[] __initdata =3D "mem_encryp=
t";
 static char sme_cmdline_on[]  __initdata =3D "on";
 static char sme_cmdline_off[] __initdata =3D "off";
=20
+/*
+ * Local copy to avoid instrumentation
+ * Copied from lib/string.c and renamed to be unique.
+ * This file is early boot code, and we assume that instrumentation
+ * subsystems (e.g. KASAN) are not yet initialized.
+ */
+static int sme_strncmp(const char *cs, const char *ct, size_t count)
+{
+	unsigned char c1, c2;
+
+	while (count) {
+		c1 =3D *cs++;
+		c2 =3D *ct++;
+		if (c1 !=3D c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+		count--;
+	}
+	return 0;
+}
+
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -557,9 +579,9 @@ void __init sme_enable(struct boot_params *bp)
=20
 	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
=20
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
+	if (!sme_strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask =3D me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
+	else if (!sme_strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask =3D 0;
 	else
 		sme_me_mask =3D active_by_default ? me_mask : 0;

