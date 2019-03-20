Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A506E2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mxi2q9sQ";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="cmDlnlY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCTPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:23:12 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39398 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbfCTPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:23:11 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KFK3Km003554;
        Wed, 20 Mar 2019 08:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Sg1KcUWXUWBmeCnNS1FNPdnXJ9GLIvkaZ593GoGOZBo=;
 b=Mxi2q9sQ3MUYzf6q3wszu8j5MJyNtppF1vdKY/RB3FhRqyBOCsWAdqHmmGkNegJirYN8
 NkOJn8w3Gqz8lTiNQIJDJqgynSBT4yOM+RiK9XoJd5iB79JhJIxNWwlsIkWE+Ra5/PmO
 9iLUBkz3ej2YRMMzjxQ4Pc1syV+Ijqvok3F9O64ESuvJBYdRHKlVOAB3thKp4I75nnS/
 ErlA5ZQ3XV7ptaDkuBVx8o1qHsjOUzdE09dLefH3Dw8nshpOoWJq+zGsT22zXqd57Vwl
 J9bdN4Ac4lh0ItzO93cxhi0jl4lT0b9/2dqUJwVut9TUAaQVOBiRoNtiRlGVXcab2TaO Xg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rbjvm12m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 08:22:55 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Mar
 2019 08:22:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Mar 2019 08:22:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg1KcUWXUWBmeCnNS1FNPdnXJ9GLIvkaZ593GoGOZBo=;
 b=cmDlnlY2gE1/6hpJDC+5tU8m7qyGLOdjpJQ2hItmkNIukQbuHyE78LdTb2AiSHjQ1aH2C8BvsE74hfukdNYoHKyZmGSjVKjhoCJV9LfhQfMwPA3jjYx0aDxfI11QqF1CUbkOONBs/j2rQ9z4SYTtv6jD7TsiyvAHPSuY+uvFb1E=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2243.namprd18.prod.outlook.com (52.132.30.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 15:22:47 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 15:22:46 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
 io64 and x86
Thread-Topic: [PATCH v2] efi: Unify dmi setup code over architectures
 arm/arm64, io64 and x86
Thread-Index: AQHU3zDFNnKKbUDU3kuF2686cVhBGg==
Date:   Wed, 20 Mar 2019 15:22:46 +0000
Message-ID: <20190320152240.2eun63wqkbqmuqkg@rric.localdomain>
References: <20190320130502.16667-1-rrichter@marvell.com>
 <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
In-Reply-To: <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::24) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.191.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6261ae80-d3fd-45cc-e6d1-08d6ad47e7c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2243;
x-ms-traffictypediagnostic: BL0PR18MB2243:
x-microsoft-antispam-prvs: <BL0PR18MB2243F7A996F4A56F302A2114D9410@BL0PR18MB2243.namprd18.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(478600001)(7736002)(99286004)(110136005)(14454004)(386003)(54906003)(2906002)(102836004)(97736004)(53546011)(6506007)(25786009)(26005)(105586002)(66066001)(68736007)(316002)(4326008)(186003)(8936002)(305945005)(6486002)(106356001)(86362001)(6116002)(53936002)(71190400001)(71200400001)(81166006)(256004)(8676002)(6512007)(81156014)(52116002)(6436002)(3846002)(446003)(11346002)(2501003)(76176011)(1076003)(476003)(486006)(7416002)(5660300002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2243;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IuEe9FE5/KW6qzfWEgt6BEtocHrGWHQfvFLrFYgtmA7p+CsA6sJFxvmrvBf4J9ALqWPQDD9Txy3IliSsMIgq1EEU5yVmeoHVOy1vF+EwIg6ZOWzjY/xg5K7WZ/cGnSeQZWUFyNciTIB6b1JwtjExc53yZKe3iR1zrOCN6H8Q2M9x5z+3wWG8jyYtlC+/pNrpYs/NUQN2zMIH1nenurzOFWadvTgQA3VRdeu9JhmC7joJVMm2ljvff2wtY8KcnYOtcuHFvhldLSPcMMUdQUcBoAltM3L0DvjMkS8eRXTKCfC+pRhHT5VIcvYGorjMl8irURdJcaduTfRqK77tr7SLMMJ5d6nLk+vRgTNTiEiwYZ2/ux/4Ah1HkNN4L8970jg0afOyY/LMbgxz6RqdOi/FTPfq24L2DE9EAk4r+oBW9DY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5F2D180CD368648B5A375EABE5AA1E9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6261ae80-d3fd-45cc-e6d1-08d6ad47e7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 15:22:46.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2243
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.19 14:16:07, Robert Richter wrote:
> On 20.03.19 13:05:37, Robert Richter wrote:
> > @@ -167,6 +167,7 @@ static int __init arm_dmi_init(void)
> >  	 * itself, depends on dmi_scan_machine() having been called already.
> >  	 */
> >  	dmi_scan_machine();
> > +	dmi_memdev_walk();
> >  	if (dmi_available)
> >  		dmi_set_dump_stack_arch_desc();
> >  	return 0;
>=20
> After
>=20
>  [PATCH] efi/arm: Show SMBIOS bank/device location in cper and
>   ghes error logs
>=20
> wents in for arm/arm64, we can unify the code. See patch below.

V2 with the fix in arm_dmi_init() below.

-Robert


-- >8 --
From: Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2] efi: Unify dmi setup code over architectures arm/arm64,
 io64 and x86

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

