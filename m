Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC1A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZGTSAy8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfB1PgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:36:17 -0500
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:33173
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731311AbfB1PgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23a6fCzD3KjDlWxVbDoaCOnljUCBm3NgT3Ap2fdDavg=;
 b=ZGTSAy8RvMkxkLALGOv5520WYZESDaaaI5rMHlG5WrCdreEAkXUmuUESvjnocDJwvcGYSbkdpxVxEkQ9x/3bFG7WVE8jkrzDTDNP92KBgquG8o8ltXOuD202G1WxToNqhH55gU9jnKPk6kyR3xcaw+BEegBqp4I+3cHcb9i6fTU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2765.namprd12.prod.outlook.com (52.135.107.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:36:11 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:36:11 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 2/6] EDAC/amd64: Use a macro for iterating over Unified
 Memory Controllers
Thread-Topic: [PATCH v3 2/6] EDAC/amd64: Use a macro for iterating over
 Unified Memory Controllers
Thread-Index: AQHUz3tUVSmGHbJk/EizNTHby3+Ohw==
Date:   Thu, 28 Feb 2019 15:36:10 +0000
Message-ID: <20190228153558.127292-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: e9aae43c-ec18-4549-f6f5-08d69d9276b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2765;20:FAqP5z2TPXS76rJarghj0DGZbrtmb+8+tJ2aB/oVCD97mT0kHS23f5vN1gtkCV3SrgMTZDUbBPvXScZ69hOLKG+fwF8T6+L+1duXrjsaoBI+foyTlP9IlHizIj010yzFaUw3DA2VWxqFSpeVAz8i37qaJNTfFTlMjuvCzglMGbPOUsJRMU9GbMzNvP5g8kjN2abI0hvR3nTYxgEZUspoK66COMe71JRVMfXWkMnVCP3JVDowkSG/nO/Hfg/UnRL5
x-microsoft-antispam-prvs: <SN6PR12MB2765F3604AEBB08B0F5B1182F8750@SN6PR12MB2765.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(3846002)(106356001)(2906002)(102836004)(26005)(25786009)(186003)(446003)(97736004)(316002)(68736007)(105586002)(6116002)(50226002)(4326008)(2351001)(7736002)(2501003)(81166006)(53936002)(81156014)(52116002)(305945005)(256004)(6486002)(99286004)(6436002)(76176011)(5640700003)(66066001)(71200400001)(71190400001)(5660300002)(8936002)(36756003)(2616005)(486006)(14444005)(11346002)(476003)(478600001)(966005)(54906003)(6506007)(6306002)(14454004)(1076003)(72206003)(386003)(8676002)(86362001)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FIUZQWSRSvkCYXQE1GOIFgmp1fuKYxS78bvD00yvwMIy6zukT1prVuEU2XObwpnQXOLi2m++r1v3R5O7r8Y+/4u+zEXuqB9nr3Jp/x+lkg1HhGP9DYo3CB33xz4v+wMP6aEllpzxW0QuGqU93o33ivFQEV3fUqBPEj49O7ht0B6Fx9bI4Iv97sLu3y2V60yZwJUrm8RhBdMasrWRE0UPf94BMsqsaInD4L6qfmhYkEimIJ0vkQjI2rl2YOlpnUXENQiNAWSfoMftO9ulPwjKMx/N4nsF6SkLRIEsfxncxJ5YzadKmGYkGYx0Ug6jPJeQNwSgOlXScMaWTQVhZbWMK2PWZ7YM8maIbfTw0Zo1S5BzMCk9mBSNjpAkDkqxaV3tr5Ki+79LDO8VXUc/lmV2CvN8VKT2pt6tHJxNiLzAxb8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aae43c-ec18-4549-f6f5-08d69d9276b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:36:10.4639
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

Define and use a macro for looping over the number of Unified Memory
Controllers.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190226172532.12924-3-Yazen.Ghannam@amd.com

v2->v3:
* Apply V2 Patch 3 before V2 Patch 2.

v1->v2:
* New in V2. Please see comment on Patch 2 V1 at link above.

 drivers/edac/amd64_edac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 98e8da9d9f5b..e4fd459d807a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -449,6 +449,9 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt,=
 int csrow, u8 dct,
 #define for_each_chip_select_mask(i, dct, pvt) \
 	for (i =3D 0; i < pvt->csels[dct].m_cnt; i++)
=20
+#define for_each_umc(i) \
+	for (i =3D 0; i < NUM_UMCS; i++)
+
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
  * csrow that input_addr maps to, or -1 on failure (no csrow claims input_=
addr).
@@ -722,7 +725,7 @@ static unsigned long determine_edac_cap(struct amd64_pv=
t *pvt)
 	if (pvt->umc) {
 		u8 i, umc_en_mask =3D 0, dimm_ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
@@ -811,7 +814,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
=20
@@ -1388,7 +1391,7 @@ static int f17_early_channel_count(struct amd64_pvt *=
pvt)
 	int i, channels =3D 0;
=20
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
-	for (i =3D 0; i < NUM_UMCS; i++)
+	for_each_umc(i)
 		channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
=20
 	amd64_info("MCT channel count: %d\n", channels);
@@ -2612,7 +2615,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pv=
t)
 	if (pvt->umc) {
 		u8 i;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for_each_umc(i) {
 			/* Check enabled channels only: */
 			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
 			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
@@ -2648,7 +2651,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	u32 i, umc_base;
=20
 	/* Read registers from each UMC */
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
=20
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
@@ -3061,7 +3064,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for_each_umc(i) {
 			u32 base =3D get_umc_base(i);
=20
 			/* Only check enabled UMCs. */
@@ -3114,7 +3117,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en =3D 1, cpk_en =3D 1;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
--=20
2.17.1

