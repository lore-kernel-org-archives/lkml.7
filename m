Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A951FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1DE20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vQx4prsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCGV0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:26:11 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:64736
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfCGV0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5hxZY1tyJvonP9KNqVl0WmFr6ATP0phm0uEw/Awf7I=;
 b=vQx4prszwSGLDHjuKk7V7PVhHmlld7E5+fvv1k+9bOennuLa48AUyBl+WC3SGTiG3ufnGRJDdRJ6vvVuhumEwvA+QDMg1fjZFTV54nqBZTSnTvW+FySHIq8tsS/swD97+lkeHQYNBbZqZK0731Bs/Ozc6p/p2D+PvcB+mZkXF9E=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2719.namprd12.prod.outlook.com (52.135.103.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 21:26:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 21:26:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA errors
 on some Family 17h models
Thread-Topic: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA
 errors on some Family 17h models
Thread-Index: AQHU1Sxe2SqGGPluPUqDcNOn3/d2Lg==
Date:   Thu, 7 Mar 2019 21:26:04 +0000
Message-ID: <20190307212552.8865-2-Yazen.Ghannam@amd.com>
References: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0011.namprd08.prod.outlook.com
 (2603:10b6:803:29::21) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba3f5186-8f1a-48fd-463b-08d6a3438133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2719;
x-ms-traffictypediagnostic: SN6PR12MB2719:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2719;20:p9PR5HGIBdRmNXE2k+ZAqijaivZl8rNh2m8rPnDlSjHA3VKkWXv514ey3V89q01x/S6fz86MQjzPdfdJRXkRIbOaqr/IeDqW6++qT7FB2r4m9SWjKSBRNTcK7oYcPe34ryno5PP5m1tGVtoSVaStOcGNEcVitg2XbWBj2X5cnimQTGtEUll8jeuFS9CH0Z2Ingv0fMdNsgKVOaCDPu3BHT28VsUOGUESnyPdxZTtCz8H3bD6gESMsNPEytssPT4f
x-microsoft-antispam-prvs: <SN6PR12MB2719DC2FC57CFBB91C226D8BF84C0@SN6PR12MB2719.namprd12.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(71200400001)(305945005)(36756003)(6916009)(1076003)(68736007)(71190400001)(8936002)(5640700003)(6486002)(50226002)(2501003)(53936002)(99286004)(6506007)(76176011)(54906003)(386003)(316002)(7736002)(26005)(52116002)(102836004)(2906002)(5660300002)(66066001)(81156014)(8676002)(81166006)(25786009)(6436002)(4326008)(97736004)(105586002)(3846002)(6116002)(446003)(186003)(476003)(106356001)(6512007)(11346002)(86362001)(486006)(2616005)(72206003)(2351001)(14444005)(256004)(14454004)(478600001)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2719;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N/vBNTFmuVgUmCtFIVF5C9HUO9/O76twbkgB2RV7dzAmqM4O2E6rjC2Ee+bYer/3xKArN2dRQs0zkopElicRidnf4KoZpInmctRx1NcxUFDbijHR/ZQUEwXra0curfsTNaLY8y6UPPNKxIJd9MB8bLeL03GNTYlvxlmHz1RK44+gxbhQna1mHp9hHayqscVh7J8ue1nVMiANn/KO1b0pi11SaqI7SHJ1nmkoRzy4afmNzKVZXOSNVNuwexELPHH8n4MaqyiTIM+PCpvg7Zy9J/6/vXdO0GIjQdclmc06eozgASe3lBjMg15s824hu6WXmMK9W+Ar5EL7VXADvdagQOt/dJ9PTgBk8I9RDpC7W0Cj8XLMo09eDO11cvPFSqc/zHemetypuFUGJJEeeJvmr61RMx5C5YwqRdBGxsfz4eY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3f5186-8f1a-48fd-463b-08d6a3438133
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 21:26:04.8743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
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

Filter out this error signature in the AMD MCE decoder module.

Cc: <stable@vger.kernel.org> # 4.14.x: c95b323dcd35: x86/MCE/AMD: Turn off =
MC4_MISC thresholding on all family 0x15 models
Cc: <stable@vger.kernel.org> # 4.14.x: 30aa3d26edb0: x86/MCE/AMD: Carve out=
 the MC4_MISC thresholding quirk
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 36 +++++++++++++++++++++++------------
 drivers/edac/mce_amd.c        | 21 ++++++++++++++++++++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 041bb800cda8..810e37df5820 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -565,21 +565,33 @@ prepare_threshold_block(unsigned int bank, unsigned i=
nt block, u32 addr,
 }
=20
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
@@ -590,7 +602,7 @@ void disable_err_thresholding(struct cpuinfo_x86 *c)
 		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
=20
 	/* Clear CntP bit safely */
-	for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
+	for (i =3D 0; i < num_msrs; i++)
 		msr_clear_bit(msrs[i], 62);
=20
 	/* restore old settings */
@@ -605,12 +617,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
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
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 0a1814dad6cf..4f2bf8ecc513 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1001,6 +1001,24 @@ static inline void amd_decode_err_code(u16 ec)
 	pr_cont("\n");
 }
=20
+static bool smca_filter_mce(struct mce *m)
+{
+	enum smca_bank_types bank_type =3D smca_get_bank_type(m->bank);
+	struct cpuinfo_x86 *c =3D &boot_cpu_data;
+	u8 xec =3D XEC(m->status, xec_mask);
+
+	/*
+	 * Spurious errors of this type may be reported.
+	 * See Family 17h Models 10h-2Fh Erratum #1114.
+	 */
+	if (c->x86 =3D=3D 0x17 &&
+	    (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F) &&
+	    bank_type =3D=3D SMCA_IF && xec =3D=3D 10)
+		return true;
+
+	return false;
+}
+
 /*
  * Filter out unwanted MCE signatures here.
  */
@@ -1012,6 +1030,9 @@ static bool amd_filter_mce(struct mce *m)
 	if (m->bank =3D=3D 4 && XEC(m->status, 0x1f) =3D=3D 0x5 && !report_gart_e=
rrors)
 		return true;
=20
+	if (boot_cpu_has(X86_FEATURE_SMCA))
+		return smca_filter_mce(m);
+
 	return false;
 }
=20
--=20
2.17.1

