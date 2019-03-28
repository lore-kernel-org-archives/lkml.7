Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6288C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA742173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="x/FJUTLw";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="CR5wHFmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfC1Hmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:42:46 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49892 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfC1Hmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:42:45 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S7Yu6C017688;
        Thu, 28 Mar 2019 00:42:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=obAiuSO+7/eo9YNenzQjjodh6uD21XsZBcqidD22yGg=;
 b=x/FJUTLwVcIsyNFcrDHYtWtx8OuHB4+1r+GNb6mlV+CvMM7bp3cZCbFmw83HCzG/5Ut5
 Sw1b1frbBVdTUIdMuRFz/YNXBixnsGDDB5wDQNoSCazzH5q/SW6rdkxqbD89LISFHrIE
 B3atNGCFfC6IYzNlCds/aMnYhRqTkKc33Yk4aPyJisTNYRV4zgIR3PvwmoedOi0AKCex
 BJZRyqG0Hhf/qS8iPTq0vMU8klAL99K2HAc7yoZwyk6PTNueFftm87DfOjTT0/yAW9OH
 JuM1z6cMLJ8dVK4QEO6hSPey1muOc2ujG4q3V60UCpAMQeVXL8yr0aWDJ6rXcdWWYKjM jA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rgfn59t35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Mar 2019 00:42:22 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Mar
 2019 00:42:10 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.54) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Mar 2019 00:42:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obAiuSO+7/eo9YNenzQjjodh6uD21XsZBcqidD22yGg=;
 b=CR5wHFmoN+3/ok3PcAzvHYxDxnDaAnWJRV4MuAQiO/aqihE2U/E00J5luyMcC6V4q5RGlAa0kbHA3veGbsqJ7G+S70JFtR7Fs5XoN2g8SC+pSrxsYoOfl3B0TMn0fI0HRKK1rAZnc1Is883yGCiH42hQLlEbjv+Mt0NSUrWvwcA=
Received: from SN1PR18MB2320.namprd18.prod.outlook.com (52.132.199.158) by
 SN1PR18MB2272.namprd18.prod.outlook.com (52.132.199.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Thu, 28 Mar 2019 07:42:08 +0000
Received: from SN1PR18MB2320.namprd18.prod.outlook.com
 ([fe80::b547:18dc:b293:a852]) by SN1PR18MB2320.namprd18.prod.outlook.com
 ([fe80::b547:18dc:b293:a852%7]) with mapi id 15.20.1750.017; Thu, 28 Mar 2019
 07:42:08 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Marcin Benka <mbenka@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
 io64 and x86
Thread-Topic: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Index: AQHU3zDFNnKKbUDU3kuF2686cVhBGqYgtQWA
Date:   Thu, 28 Mar 2019 07:42:07 +0000
Message-ID: <20190328074150.10942-1-rrichter@marvell.com>
References: <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
In-Reply-To: <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0065.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::42) To SN1PR18MB2320.namprd18.prod.outlook.com
 (2603:10b6:802:2f::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [78.54.12.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fafecce1-a725-49b3-a731-08d6b350e05d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SN1PR18MB2272;
x-ms-traffictypediagnostic: SN1PR18MB2272:
x-microsoft-antispam-prvs: <SN1PR18MB22725CD41702B18CAAE50444D9590@SN1PR18MB2272.namprd18.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(486006)(53936002)(36756003)(446003)(26005)(6436002)(102836004)(2906002)(256004)(2616005)(8936002)(14454004)(11346002)(71200400001)(97736004)(7416002)(99286004)(86362001)(6512007)(478600001)(71190400001)(386003)(6506007)(66066001)(186003)(52116002)(5660300002)(476003)(6116002)(3846002)(54906003)(305945005)(110136005)(68736007)(2501003)(25786009)(316002)(7736002)(105586002)(50226002)(76176011)(1076003)(4326008)(81156014)(6486002)(81166006)(106356001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR18MB2272;H:SN1PR18MB2320.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w2QemjSv+1XzYGJypjaK2luhTlmFcyFlrPXoUFXMirjrUfLyPBUJyALQ/2BvUJpzQcqPpP5UINz9yFl0ELSRHw7JyC4asb756OXq0eCT/sMibDl7ixI1VwP70g8Blcmzi8qc52E/ElNry9jwnq9W4HfqlLoznf9Ecs5n8bBmWFiSb7QrefuTVR/s9Xocqkds1Y9HKqu5vTlKRkKNyTccC6M0SXq3yPZkdq8zxe7rU1A0oZzdyVW9IPEZz9W9B14mSpgWxpG239zq9G+U0R7G9NppULRIDyTSYjw+n2kgQPtqxW8F7arVDrM+DubOpr7T3q+fZrPFzJqfGoyD293q7eQOGSi1onb+T2/M+gkWHAVlZYdnidDABsxr1I/oHkmebwsVZ5XEc2nZePzsX0n7dng2EVo6TvnWxJXVPtLrfBE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fafecce1-a725-49b3-a731-08d6b350e05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 07:42:08.1897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2272
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures (arm/arm64, io64 and x86) do the same here, so unify
the code.

Note: We do not need to call dump_stack_set_arch_desc() in case of
!dmi_available. Both strings, dmi_ids_string and dump_stack_arch_
desc_str are initialized zero and thus nothing would change.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 arch/ia64/kernel/setup.c           |  4 +---
 arch/x86/kernel/setup.c            |  6 ++----
 drivers/firmware/dmi_scan.c        | 28 +++++++++++++++-------------
 drivers/firmware/efi/arm-runtime.c |  7 ++-----
 include/linux/dmi.h                |  8 ++------
 5 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 583a3746d70b..c9cfa760cd57 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -1058,9 +1058,7 @@ check_bugs (void)
=20
 static int __init run_dmi_scan(void)
 {
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	dmi_set_dump_stack_arch_desc();
+	dmi_setup();
 	return 0;
 }
 core_initcall(run_dmi_scan);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a527cd9..3773905cd2c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1005,13 +1005,11 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_init();
=20
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	dmi_set_dump_stack_arch_desc();
+	dmi_setup();
=20
 	/*
 	 * VMware detection requires dmi to be available, so this
-	 * needs to be done after dmi_scan_machine(), for the boot CPU.
+	 * needs to be done after dmi_setup(), for the boot CPU.
 	 */
 	init_hypervisor_platform();
=20
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 099d83e4e910..fae2d5c43314 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -416,11 +416,8 @@ static void __init save_mem_devices(const struct dmi_h=
eader *dm, void *v)
 	nr++;
 }
=20
-void __init dmi_memdev_walk(void)
+static void __init dmi_memdev_walk(void)
 {
-	if (!dmi_available)
-		return;
-
 	if (dmi_walk_early(count_mem_devices) =3D=3D 0 && dmi_memdev_nr) {
 		dmi_memdev =3D dmi_alloc(sizeof(*dmi_memdev) * dmi_memdev_nr);
 		if (dmi_memdev)
@@ -614,7 +611,7 @@ static int __init dmi_smbios3_present(const u8 *buf)
 	return 1;
 }
=20
-void __init dmi_scan_machine(void)
+static void __init dmi_scan_machine(void)
 {
 	char __iomem *p, *q;
 	char buf[32];
@@ -769,15 +766,20 @@ static int __init dmi_init(void)
 subsys_initcall(dmi_init);
=20
 /**
- * dmi_set_dump_stack_arch_desc - set arch description for dump_stack()
+ *	dmi_setup - scan and setup DMI system information
  *
- * Invoke dump_stack_set_arch_desc() with DMI system information so that
- * DMI identifiers are printed out on task dumps.  Arch boot code should
- * call this function after dmi_scan_machine() if it wants to print out DM=
I
- * identifiers on task dumps.
+ *	Scan the DMI system information. This setups DMI identifiers
+ *	(dmi_system_id) for printing it out on task dumps and prepares
+ *	DIMM entry information (dmi_memdev_info) from the SMBIOS table
+ *	for using this when reporting memory errors.
  */
-void __init dmi_set_dump_stack_arch_desc(void)
+void __init dmi_setup(void)
 {
+	dmi_scan_machine();
+	if (!dmi_available)
+		return;
+
+	dmi_memdev_walk();
 	dump_stack_set_arch_desc("%s", dmi_ids_string);
 }
=20
@@ -841,7 +843,7 @@ static bool dmi_is_end_of_table(const struct dmi_system=
_id *dmi)
  *	returns non zero or we hit the end. Callback function is called for
  *	each successful match. Returns the number of matches.
  *
- *	dmi_scan_machine must be called before this function is called.
+ *	dmi_setup must be called before this function is called.
  */
 int dmi_check_system(const struct dmi_system_id *list)
 {
@@ -871,7 +873,7 @@ EXPORT_SYMBOL(dmi_check_system);
  *	Walk the blacklist table until the first match is found.  Return the
  *	pointer to the matching entry or NULL if there's no match.
  *
- *	dmi_scan_machine must be called before this function is called.
+ *	dmi_setup must be called before this function is called.
  */
 const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *li=
st)
 {
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-=
runtime.c
index 4a0dfe4ab829..e2ac5fa5531b 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -162,14 +162,11 @@ void efi_virtmap_unload(void)
 static int __init arm_dmi_init(void)
 {
 	/*
-	 * On arm64/ARM, DMI depends on UEFI, and dmi_scan_machine() needs to
+	 * On arm64/ARM, DMI depends on UEFI, and dmi_setup() needs to
 	 * be called early because dmi_id_init(), which is an arch_initcall
 	 * itself, depends on dmi_scan_machine() having been called already.
 	 */
-	dmi_scan_machine();
-	dmi_memdev_walk();
-	if (dmi_available)
-		dmi_set_dump_stack_arch_desc();
+	dmi_setup();
 	return 0;
 }
 core_initcall(arm_dmi_init);
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index c46fdb36700b..8de8c4f15163 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -102,9 +102,7 @@ const struct dmi_system_id *dmi_first_match(const struc=
t dmi_system_id *list);
 extern const char * dmi_get_system_info(int field);
 extern const struct dmi_device * dmi_find_device(int type, const char *nam=
e,
 	const struct dmi_device *from);
-extern void dmi_scan_machine(void);
-extern void dmi_memdev_walk(void);
-extern void dmi_set_dump_stack_arch_desc(void);
+extern void dmi_setup(void);
 extern bool dmi_get_date(int field, int *yearp, int *monthp, int *dayp);
 extern int dmi_get_bios_year(void);
 extern int dmi_name_in_vendors(const char *str);
@@ -122,9 +120,7 @@ static inline int dmi_check_system(const struct dmi_sys=
tem_id *list) { return 0;
 static inline const char * dmi_get_system_info(int field) { return NULL; }
 static inline const struct dmi_device * dmi_find_device(int type, const ch=
ar *name,
 	const struct dmi_device *from) { return NULL; }
-static inline void dmi_scan_machine(void) { return; }
-static inline void dmi_memdev_walk(void) { }
-static inline void dmi_set_dump_stack_arch_desc(void) { }
+static inline void dmi_setup(void) { }
 static inline bool dmi_get_date(int field, int *yearp, int *monthp, int *d=
ayp)
 {
 	if (yearp)
--=20
2.20.1

