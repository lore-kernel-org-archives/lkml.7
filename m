Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215642133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dbYsqryZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfB1Pgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:36:45 -0500
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:33173
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbfB1PgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzHQ9cPMxSp9QhioyPVQrVnV2dx3fU+i4OgN64b/2EI=;
 b=dbYsqryZ+bmSYcXgNPs97GX3KC7adj9ISeG8OcYUJEC50HmSNLGmB3/mIowuXpsvRqZRta2cWqoief39e80GO2FqxZM+aYKtcpnoWnEibVfs2NfxUKeqC5dpeEK/xWJ7F7AT05glyPkeUuqzOJSMeu6nOCdVYpjVeTktCPHSU6c=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2765.namprd12.prod.outlook.com (52.135.107.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:36:12 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:36:12 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 3/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Topic: [PATCH v3 3/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Index: AQHUz3tUScjw79nRdk2YLwwHsenigQ==
Date:   Thu, 28 Feb 2019 15:36:10 +0000
Message-ID: <20190228153558.127292-3-Yazen.Ghannam@amd.com>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:805:8e::41) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e1ef8c-8b95-46e5-5bcb-08d69d9276fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2765;20:ob1YMwax5AMHqF0rnYmjPI0nClArONKAO42heO0ST+mer1NxBEsNt2rTmKMy5VE/AtQqqYXrppqX1k04KJZ9clBH94drdMn29CmVZ2/XiQwftgXSwDecxynLfZUKQFtUigbovPVPEJrrjEPk2s3V8mUuPKK9BmcccgSRxolHo/NF47zPjlygHPa/nIwslfErVvX09OgCCFUSBvGbCVHTk0ud2mEzYVbYCg7sBCV9/nKO2hcq7jaQk3fy7hgi9s1P
x-microsoft-antispam-prvs: <SN6PR12MB2765EFADE9DC0B1161AB5A57F8750@SN6PR12MB2765.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(3846002)(106356001)(2906002)(102836004)(26005)(25786009)(186003)(446003)(97736004)(316002)(68736007)(114624004)(105586002)(6116002)(50226002)(4326008)(2351001)(7736002)(2501003)(81166006)(53936002)(81156014)(52116002)(305945005)(256004)(6486002)(99286004)(6436002)(76176011)(5640700003)(66066001)(71200400001)(71190400001)(5660300002)(8936002)(36756003)(2616005)(486006)(14444005)(11346002)(476003)(478600001)(966005)(54906003)(6506007)(6306002)(14454004)(1076003)(72206003)(386003)(8676002)(86362001)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X0Flf7H22daicuCskuBOoRINfgX4S4OQiCVOwdU+5oIHzQaz2qWFnqh1SHECAXPNnonpMkfSkYBNuscLm/hQEpuuToKIMknE0lgynL4Zb0cUSRIHesO59iadknHGGaM4Z9aJvh79tRzCHTBP0Hp+9H3LYTE7G9Mzp1QFCHtxbHRp4Yse5A4VmGofn0WUJ/wmcBX/nv44ePElcxI7+kSf07a4Ogqqzj1GCXw9MMxzQyDsq55v9Fe7pMbT8XNQOzHcyOxfrEMTqftOpiXQ9QF8O1BNjqAs61rqwtQxGJrR4cq2f7/XjJ5qLAcIv+LK1eVum4dLGNlt+spFYbxoQB2o0LHSXgGWizVHJoAJqCbySvsc70jBq9vtMC3NSOUxGy0WuqcbWJ9393E2ESrsaKD3Cbz++6zGcyEC9dqs49toHr8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e1ef8c-8b95-46e5-5bcb-08d69d9276fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:36:10.8912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The first few models of Family 17h all had 2 Unified Memory Controllers
per Die, so this was treated as a fixed value. However, future systems
may have more Unified Memory Controllers per Die.

Related to this, the channel number and base address of a Unified Memory
Controller were found by matching on fixed, known values. However,
current and future systems follow this pattern for the channel number
and base address of a Unified Memory Controller: 0xYXXXXX, where Y is
the channel number. So matching on hardcoded values is not necessary.

Set the number of Unified Memory Controllers at driver init time based
on the Family/Model. Also, update the functions that find the channel
number and base address of a Unified Memory Controller to support more
than two.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190226172532.12924-2-Yazen.Ghannam@amd.com

v2->v3:
* Apply V2 Patch 3 before V2 Patch 2.

v1->v2:
* Fix tone in commit message.
* Clarify pattern used for finding channel numbers.
* Remove macro for looping over number of UMCs.
* Move function to find number of UMCs to single driver init function.
* Rename function that finds the number of UMCs.
* Add comments for new variables and functions.
* Move function to find number of UMCs out of header.

 drivers/edac/amd64_edac.c | 44 ++++++++++++++++++++++++---------------
 drivers/edac/amd64_edac.h | 10 ++++++---
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e4fd459d807a..25416c608908 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -450,7 +450,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt,=
 int csrow, u8 dct,
 	for (i =3D 0; i < pvt->csels[dct].m_cnt; i++)
=20
 #define for_each_umc(i) \
-	for (i =3D 0; i < NUM_UMCS; i++)
+	for (i =3D 0; i < num_umcs; i++)
=20
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
@@ -2476,18 +2476,14 @@ static inline void decode_bus_error(int node_id, st=
ruct mce *m)
  * To find the UMC channel represented by this bank we need to match on it=
s
  * instance_id. The instance_id of a bank is held in the lower 32 bits of =
its
  * IPID.
+ *
+ * Currently, we can derive the channel number by looking at the 6th nibbl=
e in
+ * the instance_id. For example, instance_id=3D0xYXXXXX where Y is the cha=
nnel
+ * number.
  */
-static int find_umc_channel(struct amd64_pvt *pvt, struct mce *m)
+static int find_umc_channel(struct mce *m)
 {
-	u32 umc_instance_id[] =3D {0x50f00, 0x150f00};
-	u32 instance_id =3D m->ipid & GENMASK(31, 0);
-	int i, channel =3D -1;
-
-	for (i =3D 0; i < ARRAY_SIZE(umc_instance_id); i++)
-		if (umc_instance_id[i] =3D=3D instance_id)
-			channel =3D i;
-
-	return channel;
+	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
=20
 static void decode_umc_error(int node_id, struct mce *m)
@@ -2509,11 +2505,7 @@ static void decode_umc_error(int node_id, struct mce=
 *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type =3D 3;
=20
-	err.channel =3D find_umc_channel(pvt, m);
-	if (err.channel < 0) {
-		err.err_code =3D ERR_CHANNEL;
-		goto log_error;
-	}
+	err.channel =3D find_umc_channel(m);
=20
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_a=
ddr)) {
 		err.err_code =3D ERR_NORM_ADDR;
@@ -3252,6 +3244,22 @@ static const struct attribute_group *amd64_edac_attr=
_groups[] =3D {
 	NULL
 };
=20
+/* Set the number of Unified Memory Controllers in the system. */
+static void compute_num_umcs(void)
+{
+	u8 model =3D boot_cpu_data.x86_model;
+
+	if (boot_cpu_data.x86 < 0x17)
+		return;
+
+	if (model >=3D 0x30 && model <=3D 0x3f)
+		num_umcs =3D 8;
+	else
+		num_umcs =3D 2;
+
+	edac_dbg(1, "Number of UMCs: %x", num_umcs);
+}
+
 static int init_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
@@ -3276,7 +3284,7 @@ static int init_one_instance(unsigned int nid)
 		goto err_free;
=20
 	if (pvt->fam >=3D 0x17) {
-		pvt->umc =3D kcalloc(NUM_UMCS, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
 			goto err_free;
@@ -3497,6 +3505,8 @@ static int __init amd64_edac_init(void)
 	if (!msrs)
 		goto err_free;
=20
+	compute_num_umcs();
+
 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
 		if (err) {
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index de8dbb0b42b5..40e63cea2d81 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -274,7 +274,11 @@
=20
 #define UMC_SDP_INIT			BIT(31)
=20
-#define NUM_UMCS			2
+/*
+ * Number of Unified Memory Controllers
+ * Set during driver init based on family/model.
+ */
+static u8 num_umcs;
=20
 enum amd_families {
 	K8_CPUS =3D 0,
@@ -399,8 +403,8 @@ struct err_info {
=20
 static inline u32 get_umc_base(u8 channel)
 {
-	/* ch0: 0x50000, ch1: 0x150000 */
-	return 0x50000 + (!!channel << 20);
+	/* chY: 0xY50000 */
+	return 0x50000 + (channel << 20);
 }
=20
 static inline u64 get_dram_base(struct amd64_pvt *pvt, u8 i)
--=20
2.17.1

