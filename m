Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N2i+yD8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfCUUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:25:24 -0400
Received: from mail-eopbgr810054.outbound.protection.outlook.com ([40.107.81.54]:65072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfCUUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBU+YSjoU90q3fdK4a2NhtGI1CCkFLixDmvkL2951/8=;
 b=N2i+yD8EUOu59uBwDPyrd7dl8WB2RHHTaBSNe9k1t5W+Iao2Ka+xFq6QSo9WPZXgGqdBkUkZUUyFqPuOYqBkrYorqVTP3FI/RMdjFnyVMI1UE1d9YT8drnaxUeMt+2CDtJ4ANvjOw94KKIXaOqIXU1A4MtQoxwgWZ+TEwCjITq8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 20:25:18 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 20:25:18 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on some
 Family 17h models
Thread-Topic: [PATCH v2 2/2] x86/MCE/AMD: Don't report L1 BTB MCA errors on
 some Family 17h models
Thread-Index: AQHU4CQzOwE6EEZAWEC91l7umX/fDg==
Date:   Thu, 21 Mar 2019 20:25:18 +0000
Message-ID: <20190321202505.5553-2-Yazen.Ghannam@amd.com>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:805:3e::42) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4b58612-d31a-4d30-6d8a-08d6ae3b55ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2816;
x-ms-traffictypediagnostic: SN6PR12MB2816:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB281691100C0B8EBCE1827FAAF8420@SN6PR12MB2816.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(386003)(26005)(6506007)(102836004)(446003)(50226002)(97736004)(7736002)(186003)(53936002)(72206003)(476003)(486006)(305945005)(2616005)(11346002)(6512007)(478600001)(8936002)(2501003)(5660300002)(66066001)(54906003)(52116002)(316002)(99286004)(76176011)(5640700003)(4326008)(1076003)(71190400001)(2351001)(71200400001)(6116002)(86362001)(3846002)(106356001)(105586002)(14444005)(6486002)(256004)(25786009)(68736007)(6436002)(2906002)(8676002)(6916009)(14454004)(6306002)(81156014)(966005)(81166006)(36756003)(170073001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tIyK3hXtLWD1uanWBQydUFk3JQt0w58reI+VenHCwd7IqY+ho2CPVhY3+Tyxi7WxkQ1gqnXQI5LuD4YSJ/pAE8SFCUdGGRRsylKmyjcndFDcfdm0PyZ3RZfKfdaeUtkW1DuBxrqXyvhBpBtWPuQuD9U1gwzehULriYaeuCNtTD7M+yJLTBYT8z9jbbcT70jlnaIvQJpyV3FMuaMvfhY4raEjnmpJhsnn/4gtNXrJAsR217pGbNtU3kD+bIBuvVVVmUip/CIS3iT1og6m8KL1OMgD9n9iQRHXqP6KarOgN+IzDDsBcPPH1wjheUdAS2j2D5Til0vQDz4dW92HvQb0USjXJSd2KVsqltm5vtrHLjFUrgLGFnZJbPOUzf001oVtZjO/kPrqJWMHePhr9C2VVUMt9MFL3hPEzPXp7+SXgiE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b58612-d31a-4d30-6d8a-08d6ae3b55ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 20:25:18.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
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

Define a function to filter these errors from the MCE event pool.
Install this function during AMD vendor init. The MCA banks are enabled
after vendor init, so the filter function will be installed before the
spurious errors will be reported.

Cc: <stable@vger.kernel.org> # 4.14.x: c95b323dcd35: x86/MCE/AMD: Turn off =
MC4_MISC thresholding on all family 0x15 models
Cc: <stable@vger.kernel.org> # 4.14.x: 30aa3d26edb0: x86/MCE/AMD: Carve out=
 the MC4_MISC thresholding quirk
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190307212552.8865-2-Yazen.Ghannam@amd.com

v1->v2:
* Filter out the error earlier in MCE code rather than later in EDAC.

 arch/x86/kernel/cpu/mce/amd.c | 57 ++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e64de5149e50..2db85f65b41e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -563,22 +563,55 @@ prepare_threshold_block(unsigned int bank, unsigned i=
nt block, u32 addr,
 	return offset;
 }
=20
+bool filter_mce_rv(struct mce *m)
+{
+	enum smca_bank_types bank_type =3D smca_get_bank_type(m->bank);
+	u8 xec =3D (m->status >> 16) & 0x3F;
+
+	/*
+	 * Spurious errors of this type may be reported.
+	 * See Family 17h Models 10h-2Fh Erratum #1114.
+	 */
+	if (bank_type =3D=3D SMCA_IF && xec =3D=3D 10)
+		return true;
+
+	return false;
+}
+
+static void filter_mce_check(struct cpuinfo_x86 *c)
+{
+	if (c->x86 =3D=3D 0x17 && (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x=
2F))
+		filter_mce =3D filter_mce_rv;
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
=20
-	if (c->x86 !=3D 0x15)
+	if (c->x86 =3D=3D 0x15 && bank =3D=3D 4) {
+		msrs[0] =3D 0x00000413; /* MC4_MISC0 */
+		msrs[1] =3D 0xc0000408; /* MC4_MISC1 */
+		num_msrs =3D 2;
+	} else if (c->x86 =3D=3D 0x17 &&
+		   (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x2F)) {
+
+		if (smca_get_bank_type(bank) !=3D SMCA_IF)
+			return;
+
+		msrs[0] =3D MSR_AMD64_SMCA_MCx_MISC(bank);
+		num_msrs =3D 1;
+	} else {
 		return;
+	}
=20
 	rdmsrl(MSR_K7_HWCR, hwcr);
=20
@@ -589,7 +622,7 @@ void disable_err_thresholding(struct cpuinfo_x86 *c)
 		wrmsrl(MSR_K7_HWCR, hwcr | BIT(18));
=20
 	/* Clear CntP bit safely */
-	for (i =3D 0; i < ARRAY_SIZE(msrs); i++)
+	for (i =3D 0; i < num_msrs; i++)
 		msr_clear_bit(msrs[i], 62);
=20
 	/* restore old settings */
@@ -604,12 +637,14 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	unsigned int bank, block, cpu =3D smp_processor_id();
 	int offset =3D -1;
=20
-	disable_err_thresholding(c);
+	filter_mce_check(c);
=20
 	for (bank =3D 0; bank < mca_cfg.banks; ++bank) {
 		if (mce_flags.smca)
 			smca_configure(bank, cpu);
=20
+		disable_err_thresholding(c, bank);
+
 		for (block =3D 0; block < NR_BLOCKS; ++block) {
 			address =3D get_block_address(address, low, high, bank, block);
 			if (!address)
--=20
2.17.1

