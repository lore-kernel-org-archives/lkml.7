Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99585C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A72175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DYuLNo2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCVUan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:30:43 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:40864
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbfCVUan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLrbVwWrkfbJsNp9A9+OiFYn9hxLO/eorHbIeXbdMKc=;
 b=DYuLNo2Pf8SjYeouB1XUYO4sze4MUgeZZBX4UTyxlfPbRAaAJvSsb45G8opzd9TDcg5QHW2yJaHhlY3CEW3DiwHzOUMttGe5DlqrBH/SAgFNhpKpeVpVMcAOcESLAX9jpxVzqkWxRkZ4OedHe89sUq6U+Sq5ZdT9AdtaJG2p9lI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2638.namprd12.prod.outlook.com (52.135.103.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:29:00 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 20:29:00 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on some
 Family 17h models
Thread-Topic: [PATCH v3 2/3] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4O3hzDnJGF9VdEO+XYSvilmDRg==
Date:   Fri, 22 Mar 2019 20:28:59 +0000
Message-ID: <20190322202848.20749-2-Yazen.Ghannam@amd.com>
References: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0017.prod.exchangelabs.com (2603:10b6:805:b6::30)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cff31d01-924f-43b0-0a19-08d6af0503ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2638;
x-ms-traffictypediagnostic: SN6PR12MB2638:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB26380A6363AEC94C4DD039A9F8430@SN6PR12MB2638.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(2906002)(478600001)(71190400001)(26005)(6506007)(4326008)(316002)(102836004)(97736004)(25786009)(99286004)(256004)(486006)(966005)(72206003)(446003)(14444005)(2616005)(2501003)(1076003)(14454004)(86362001)(476003)(11346002)(5660300002)(71200400001)(106356001)(186003)(105586002)(8676002)(2351001)(81156014)(53936002)(386003)(68736007)(81166006)(7736002)(6486002)(305945005)(52116002)(36756003)(76176011)(3846002)(54906003)(5640700003)(66066001)(6436002)(6916009)(6116002)(6306002)(8936002)(6512007)(50226002)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2638;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h2N+OkOvriIJVx0y/kv8l+OgJSuArMjWYLabGsTy529PHoBdN0RbLGxiX2NcpL6BgAc9dcYVOjTCkYTJAgPX6lpXy0PPVik2b4YO15FmDsJb0WfwT5yqIBDN5MckjdTSjcu9EWoliemDTLjRoiMQ6G3MscrU25jE2qoHWGoqMdUuMYzqdNOwtqIr/5chGs8FbwlQDYN0CvP5kbszcoVivwKlQTEEECE7nhqE7KxnIm0gVnFrIYBrJejhMusEFEnZvyM3SvXlWS0qYEn0vdS4CFUl1Lmv6NRteJFjO1PqptVZpmyVVPbk3+wVw06oZ1zeQValhHrMUMXk2oVh1vp6JXozMUMwfyaIxH9YqUfiJgtLnp4JvYXLWVoXuNRyw7IrtCvYiPj/TXkRjE1qzkJOrtF68gppKylTPPOg8pSJ0K0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff31d01-924f-43b0-0a19-08d6af0503ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:28:59.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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

Cc: <stable@vger.kernel.org> # 4.14.x: c95b323dcd35: x86/MCE/AMD: Turn off =
MC4_MISC thresholding on all family 0x15 models
Cc: <stable@vger.kernel.org> # 4.14.x: 30aa3d26edb0: x86/MCE/AMD: Carve out=
 the MC4_MISC thresholding quirk
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190321202505.5553-2-Yazen.Ghannam@amd.com

v2->v3:
* Define a simple AMD-specific filter function rather than a
  model-specific one.

v1->v2:
* Filter out the error earlier in MCE code rather than later in EDAC.

 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/mce/amd.c  | 54 ++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c |  3 ++
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ec5bf1cad217..50f76a7956cc 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -344,6 +344,7 @@ extern struct smca_bank smca_banks[MAX_NR_BANKS];
=20
 extern const char *smca_get_long_name(enum smca_bank_types t);
 extern bool amd_mce_is_memory_error(struct mce *m);
+extern bool filter_mce_amd(struct mce *m);
=20
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
@@ -353,6 +354,7 @@ extern int mce_threshold_remove_device(unsigned int cpu=
);
 static inline int mce_threshold_create_device(unsigned int cpu) { return 0=
; };
 static inline int mce_threshold_remove_device(unsigned int cpu) { return 0=
; };
 static inline bool amd_mce_is_memory_error(struct mce *m) { return false; =
};
+static inline bool filter_mce_amd(struct mce *m) { return false; };
=20
 #endif
=20
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e64de5149e50..819d5dd41925 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -563,22 +563,52 @@ prepare_threshold_block(unsigned int bank, unsigned i=
nt block, u32 addr,
 	return offset;
 }
=20
+bool filter_mce_amd(struct mce *m)
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
index 12d61b8f8154..ebc619a20c87 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1773,6 +1773,9 @@ static void __mcheck_cpu_init_timer(void)
=20
 bool filter_mce(struct mce *m)
 {
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		return filter_mce_amd(m);
+
 	return false;
 }
=20
--=20
2.17.1

