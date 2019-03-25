Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65181C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9F820989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EczsYYzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfCYQeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:34:44 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:19040
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729824AbfCYQel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X40kWhAaMS2Isfx6ZCfHHW6w1I3Ee3UyM0uoeX0hYs=;
 b=EczsYYzyLLN1cv5pyWQ4q7mRdbM8VcAQvbGYFRMF1zjz+WfT/eyNxBFO77IFRNeqoqNlOGm9psjpoOOejPe7itT9+Ink/d7HZlLgkXo2UEC1nuQE67WpT+06RCFMXo45UgbuxgdnBubaeyY3loLX/DQGfIqU/Y6uXm9KUgwOlXc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Mon, 25 Mar 2019 16:34:31 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 16:34:31 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v4 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on some
 Family 17h models
Thread-Topic: [PATCH v4 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4yiaHSy6/1YqPUO+ulrO2TpA1A==
Date:   Mon, 25 Mar 2019 16:34:22 +0000
Message-ID: <20190325163410.171021-2-Yazen.Ghannam@amd.com>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad6b94f2-5bbf-4aee-0d0a-08d6b13fbc8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2749C90DA866E15160E3B16EF85E0@SN6PR12MB2749.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(76176011)(81166006)(36756003)(54906003)(86362001)(7736002)(50226002)(476003)(81156014)(478600001)(8676002)(8936002)(305945005)(486006)(2501003)(71190400001)(71200400001)(105586002)(102836004)(26005)(2351001)(446003)(66066001)(106356001)(6916009)(4326008)(97736004)(11346002)(186003)(6666004)(386003)(2906002)(6306002)(6506007)(6436002)(72206003)(2616005)(68736007)(14444005)(53936002)(256004)(5640700003)(966005)(14454004)(5660300002)(6116002)(6512007)(316002)(3846002)(52116002)(99286004)(25786009)(6486002)(1076003)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6KX8VZMoYyaZBPQBZxPKusyY3UHJAS0ikRM3yUEw9T6Yzwn6/uzkpYUQFZkz4bxs+qpV+4haZhqoPnE3dPzNiT1DtEifSP2AkCoUemKZI/A5MHQFzGRN1OA43LteitFwiVEfB19/imEyKs+RjI89C1kgu5tgd8hUxK4vHTYQLEtvgqxR1rHgr/5Ca3kys05GEdh9gfM3epVHiGD1F9m2UbFSTGkgEypci6zV1ohtscZb8f1Htx8NNQP3la4olfubuXmbsrtedzVZhd2dWnEJOB6cntl/BKp9WBCAq0YHRa+QczMW9929y4uLSQ6I4d8CXx/6jk5qTFzo2eyOy055AHKY8yRW0eSXNjvskqzaDf6FIxAs5oOcfKQPxwL+VfLCG4A4ehoiYnvWf2IJl1rSkt56pTunfPezigiFG/i4GrU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6b94f2-5bbf-4aee-0d0a-08d6b13fbc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 16:34:22.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD Family 17h Models 10h-2Fh may report a high number of L1 BTB MCA
errors under certain conditions. The errors are benign and can safely be
ignored. However, the high error rate may cause the MCA threshold
counter to overflow causing a high rate of thresholding interrupts. In
addition, users may see the errors reported through the AMD MCE decoder
module, even with the interrupt disabled, due to MCA polling.

This error is reported through the Instruction Fetch bank.

Clear the "Counter Present" bit in the Instruction Fetch bank's
MCA_MISC0 register. This will prevent enabling MCA thresholding on this
bank which will prevent the high interrupt rate due to this error.

Define an AMD-specific function to filter these errors from the MCE
event pool.

Rename filter function in EDAC/mce_amd to avoid a naming conflict.

Cc: <stable@vger.kernel.org> # 5.0.x: c95b323dcd35: x86/MCE/AMD: Turn off M=
C4_MISC thresholding on all family 0x15 models
Cc: <stable@vger.kernel.org> # 5.0.x: 30aa3d26edb0: x86/MCE/AMD: Carve out =
the MC4_MISC thresholding quirk
Cc: <stable@vger.kernel.org> # 5.0.x: 9308fd407455: x86/MCE: Group AMD func=
tion prototypes in <asm/mce.h>
Cc: <stable@vger.kernel.org> # 5.0.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190322202848.20749-2-Yazen.Ghannam@amd.com

v3->v4:
* Rename filter function in EDAC/mce_amd to avoid naming conflict.

v2->v3:
* Define a simple AMD-specific filter function rather than a
  model-specific one.

v1->v2:
* Filter out the error earlier in MCE code rather than later in EDAC.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 54 ++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c |  3 ++
 drivers/edac/mce_amd.c         |  4 +--
 4 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 446919cb4ca8..09ac4ae9f362 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -334,6 +334,7 @@ extern struct smca_bank smca_banks[MAX_NR_BANKS];
=20
 extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
+extern bool amd_filter_mce(struct mce *m);
=20
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
@@ -349,6 +350,7 @@ static inline bool amd_mce_is_memory_error(struct mce *=
m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline int
 umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ r=
eturn -EINVAL; };
+static inline bool amd_filter_mce(struct mce *m)			{ return false; };
 #endif
=20
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return =
mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e64de5149e50..dd26f2c00ea4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -563,22 +563,52 @@ prepare_threshold_block(unsigned int bank, unsigned i=
nt block, u32 addr,
 	return offset;
 }
=20
+bool amd_filter_mce(struct mce *m)
+{
+	enum smca_bank_types bank_type =3D smca_get_bank_type(m->bank);
+	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+	u8 xec =3D (m->status >> 16) & 0x3F;
+
+	/*
+	 * Spurious errors of this type may be reported.
+	 * See Family 17h Models 10h-2Fh Erratum #1114.
+	 */
+	if (c->x86 =3D=3D 0x17 &&
+	    c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F &&
+	    bank_type =3D=3D SMCA_IF && xec =3D=3D 10)
+		return true;
+
+	return false;
+}
+
 /*
- * Turn off MC4_MISC thresholding banks on all family 0x15 models since
- * they're not supported there.
+ * Turn off thresholding banks for the following conditions:
+ * - MC4_MISC thresholding is not support on Family 0x15.
+ * - Prevent possible spurious interrupts from the IF bank on Family 0x17
+ *   Models 0x10-0x2F due to Erratum #1114.
  */
-void disable_err_thresholding(struct cpuinfo_x86 *c)
+void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 {
-	int i;
+	int i, num_msrs;
 	u64 hwcr;
 	bool need_toggle;
-	u32 msrs[] =3D {
-		0x00000413, /* MC4_MISC0 */
-		0xc0000408, /* MC4_MISC1 */
-	};
+	u32 msrs[NR_BLOCKS];
+
+	if (c->x86 =3D=3D 0x15 && bank =3D=3D 4) {
+		msrs[0] =3D 0x00000413; /* MC4_MISC0 */
+		msrs[1] =3D 0xc0000408; /* MC4_MISC1 */
+		num_msrs =3D 2;
+	} else if (c->x86 =3D=3D 0x17 &&
+		   (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F)) {
+
+		if (smca_get_bank_type(bank) !=3D SMCA_IF)
+			return;
=20
-	if (c->x86 !=3D 0x15)
+		msrs[0] =3D MSR_AMD64_SMCA_MCx_MISC(bank);
+		num_msrs =3D 1;
+	} else {
 		return;
+	}
=20
 	rdmsrl(MSR_K7_HWCR, hwcr);
=20
@@ -589,7 +619,7 @@ void disable_err_thresholding(struct cpuinfo_x86 *c)
 		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
=20
 	/* Clear CntP bit safely */
-	for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
+	for (i =3D 0; i < num_msrs; i++)
 		msr_clear_bit(msrs[i], 62);
=20
 	/* restore old settings */
@@ -604,12 +634,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu =3D smp_processor_id();
 	int offset =3D -1;
=20
-	disable_err_thresholding(c);
-
 	for (bank =3D 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
=20
+		disable_err_thresholding(c, bank);
+
 		for (block =3D 0; block < NR_BLOCKS; ++block) {
 			address =3D get_block_address(address, low, high, bank, block);
 			if (!address)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 12d61b8f8154..1a7084ba9a3b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1773,6 +1773,9 @@ static void __mcheck_cpu_init_timer(void)
=20
 bool filter_mce(struct mce *m)
 {
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		return amd_filter_mce(m);
+
 	return false;
 }
=20
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 0a1814dad6cf..bb0202ad7a13 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1004,7 +1004,7 @@ static inline void amd_decode_err_code(u16 ec)
 /*
  * Filter out unwanted MCE signatures here.
  */
-static bool amd_filter_mce(struct mce *m)
+static bool ignore_mce(struct mce *m)
 {
 	/*
 	 * NB GART TLB error reporting is disabled by default.
@@ -1038,7 +1038,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned lo=
ng val, void *data)
 	unsigned int fam =3D x86_family(m->cpuid);
 	int ecc;
=20
-	if (amd_filter_mce(m))
+	if (ignore_mce(m))
 		return NOTIFY_STOP;
=20
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
--=20
2.17.1

