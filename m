Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585D6218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kkGnI0mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfB1PgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:36:20 -0500
Received: from mail-eopbgr730088.outbound.protection.outlook.com ([40.107.73.88]:33173
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387426AbfB1PgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAM9oNye+SJuCkT2PJNAA1RzaGruW633qg/BG+th6zQ=;
 b=kkGnI0mfD8AUlarsVD3IicxoCdqCzoonOJttBuI0TlybwZAdmgvhKDdDisQS3X7wXA6fUCp3KfTXXDr6XjdhXUDpDTBpF2i3+q9+lWWvROJIMnqvWfOLPN0cLaf8m0OPEwvV/6X1pCocjP+9J1wfAHTEeB4T5tKVOKEk8Xvy6hU=
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
Subject: [PATCH v3 4/6] EDAC/amd64: Recognize x16 Symbol Size
Thread-Topic: [PATCH v3 4/6] EDAC/amd64: Recognize x16 Symbol Size
Thread-Index: AQHUz3tUDyW6tMumlEKUlvl10iOwRw==
Date:   Thu, 28 Feb 2019 15:36:11 +0000
Message-ID: <20190228153558.127292-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 20697c63-4b2c-4e28-8f90-08d69d92773f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2765;
x-ms-traffictypediagnostic: SN6PR12MB2765:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2765;20:urh/VgnmcrMp8Ttb6j/wxlDv1orr0femLsK3L5Zx8sqHS8Ld0gwrWmWb8VOokt+sRbfM/JDB2MGNR4bvbPp5Zf/cYPNEwx41UdLU9Z0IiD1Z+g+5mYpxdrYlMpPFvvImrGUz8VJkjFf3o7NmgvDJdFnyuN5wCP88ArWkmRcs+obe90yZnSwsI8vIJ6QlBLGYKGBJew1OZ0D8yD6D81Oqd2aoa8Omwh9dn6HitqnT/w7NS77sjpxAOQhKLN2E8Dss
x-microsoft-antispam-prvs: <SN6PR12MB2765E6FFBE0CBADBD18EC87EF8750@SN6PR12MB2765.namprd12.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(3846002)(106356001)(2906002)(102836004)(26005)(25786009)(186003)(446003)(97736004)(316002)(68736007)(105586002)(6116002)(50226002)(4326008)(2351001)(7736002)(2501003)(81166006)(53936002)(81156014)(52116002)(305945005)(256004)(6486002)(99286004)(6436002)(76176011)(5640700003)(66066001)(71200400001)(71190400001)(5660300002)(8936002)(36756003)(2616005)(486006)(11346002)(476003)(478600001)(966005)(54906003)(6506007)(6306002)(14454004)(1076003)(72206003)(386003)(8676002)(86362001)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2765;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XICXl3vAnLToM1BkfxsBOXPCaUyaAOKbYB4iWRvGES/GKapNwSgpqCgMrEUGKKlkBuyktNlsPZl6+VuoNzhrt6scrggtKkoepJ/nMy+QeFFMiok/tSCM8GdEKB2CH5Pf0eN99cZQFYCHxuMKMQ/FxZ3bEriMp9rnNeuvoVWqBHtsovNaQRqZFCWLATTlovmuGeuetYcKZfibqmVy4QUqlx55aERBI07xwToKwhbuVpBiHgOlolcLJs+nv85c79oLMV8I92B9tIY69BJaLeVgaruPZ6Hqz0jpZ7bW59yPSW6GEAuRqVLwT6MrW9pka5J1W17hri2dHzUGZCwExfba2jLbhhLsenW2QkRL67UafSRFgMjh1g1s1c6bfIp/n6YGWsSwIZfpr/bgtHXi2ZMJ4KVScnu8PERpS/v4rV6mvbs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20697c63-4b2c-4e28-8f90-08d69d92773f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:36:11.5187
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

Future AMD systems may support x16 symbol sizes.

Recognize if a system is using x16 symbol size. Also, simplify the print
statement.

Note that a x16 syndrome vector table is not necessary like with x4 or
x8. This is because systems that support x16 symbol sizes will be SMCA
systems. In which case, the syndrome can be directly extracted from the
MCA_SYND[Syndrome] field.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190226172532.12924-4-Yazen.Ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* Apply Boris' fixup.

 drivers/edac/amd64_edac.c | 21 ++++++++++-----------
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 25416c608908..2da69010ea8e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -897,8 +897,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
=20
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
=20
-	amd64_info("using %s syndromes.\n",
-			((pvt->ecc_sym_sz =3D=3D 8) ? "x8" : "x4"));
+	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
=20
 /*
@@ -2609,17 +2608,17 @@ static void determine_ecc_sym_sz(struct amd64_pvt *=
pvt)
=20
 		for_each_umc(i) {
 			/* Check enabled channels only: */
-			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
-			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
-				pvt->ecc_sym_sz =3D 8;
-				break;
+			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
+				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
+					pvt->ecc_sym_sz =3D 16;
+					return;
+				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
+					pvt->ecc_sym_sz =3D 8;
+					return;
+				}
 			}
 		}
-
-		return;
-	}
-
-	if (pvt->fam >=3D 0x10) {
+	} else if (pvt->fam >=3D 0x10) {
 		u32 tmp;
=20
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 40e63cea2d81..44d81eccfe0a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -370,7 +370,7 @@ struct amd64_pvt {
 	u32 dct_sel_hi;		/* DRAM Controller Select High */
 	u32 online_spare;	/* On-Line spare Reg */
=20
-	/* x4 or x8 syndromes in use */
+	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
=20
 	/* place to store error injection parameters prior to issue */
--=20
2.17.1

