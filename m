Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FD2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X5STHjDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCVU3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:29:02 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:40864
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfCVU3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vn4+xJ2RZ49wd2Dr2gs7KF0HoJZpT/MlG40arnWBxcw=;
 b=X5STHjDxQwkg7+ARZ1nTwDOWrZpewMd9tdOs+UKHFCouMwLUYkNkI60XvFqvzh1Tq626BtolhV1G58TiMQMDtPyPpAzb82lKlW0OF1RRfhcHs2UIfjjiZOdHI9C8u2P4DyUTrB/KrmF5Db753G5W6hp3c2+dmsiBYNqcYPobIpE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2638.namprd12.prod.outlook.com (52.135.103.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:28:59 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 20:28:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v3 1/3] x86/MCE: Add function to allow filtering of MCA errors
Thread-Topic: [PATCH v3 1/3] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Index: AQHU4O3hm/U3jCqL2k+qa++ChHw2sw==
Date:   Fri, 22 Mar 2019 20:28:59 +0000
Message-ID: <20190322202848.20749-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 5acc2889-6cb6-43e3-82e3-08d6af050384
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2638;
x-ms-traffictypediagnostic: SN6PR12MB2638:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2638B4976B9B9EEAD374375BF8430@SN6PR12MB2638.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(2906002)(478600001)(71190400001)(26005)(6506007)(4326008)(316002)(102836004)(97736004)(25786009)(99286004)(256004)(486006)(966005)(72206003)(14444005)(2616005)(2501003)(1076003)(14454004)(86362001)(476003)(5660300002)(71200400001)(106356001)(186003)(105586002)(8676002)(2351001)(81156014)(53936002)(386003)(68736007)(81166006)(7736002)(6486002)(305945005)(52116002)(36756003)(3846002)(54906003)(5640700003)(66066001)(6436002)(6916009)(6116002)(6306002)(8936002)(6512007)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2638;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J5EYQAr4OlBQ3m0QBJAOR79SLh81uWB3BpXs7ubGQZ/dV+aIoi1LwJ7jUNDBlk0LmV3VNAkcjT/qn2pQXaByrykmJNl3Lr/dou1S3/foBO6ZwzEdtinfKBUVNTjvPQaV/yRYmxfhgkJet7n5LjSrAJ3RpybKvaGD+KByGdASV0v1EeQcmFcnnMsTkYASPAMroslKGI9yR9rl/2UZFXhL6bEbztB2fD3SYsMIzF3Rijcyn1Nu2ClOLzmFx48dXxX1EnCPQ8YZ7NY2YSo2Rspp1rgq9uZCKSG57a5zsRxWoL/Nh5TyQX24JQQf1hsy6NlWqczTEh7EXUnSel4zzXShlx/i/VwKKEcsZABRaJLWPMNiW0tC/FiPMamN56IkG4BTMpDqePiINXN0SOHhvvOCeolh50uUXC1dBDhZbNrO52Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acc2889-6cb6-43e3-82e3-08d6af050384
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:28:59.2139
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

Some systems may report spurious MCA errors. In general, spurious MCA
errors may be disabled by clearing a particular bit in MCA_CTL. However,
clearing a bit in MCA_CTL may not be recommended for some errors, so the
only option is to ignore them.

An MCA error is printed and handled after it has been added to the MCE
event pool. So an MCA error can be ignored by not adding it to the pool.

Define a default function that does not filter any errors.

Check if an MCA error should be filtered out when adding it to the MCE
event pool.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190321202505.5553-1-Yazen.Ghannam@amd.com

v2->v3:
* Define a regular function rather than function pointer.
* Update comment in header file.

v1->v2:
* This is a new patch replacing V1 Patch 1 which is no longer needed.

 arch/x86/include/asm/mce.h        | 3 +++
 arch/x86/kernel/cpu/mce/core.c    | 5 +++++
 arch/x86/kernel/cpu/mce/genpool.c | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 22d05e3835f0..ec5bf1cad217 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -253,6 +253,9 @@ extern void mce_disable_bank(int bank);
 extern void (*machine_check_vector)(struct pt_regs *, long error_code);
 void do_machine_check(struct pt_regs *, long);
=20
+/* Decide whether to add MCE record to MCE event pool or filter it out. */
+extern bool filter_mce(struct mce *m);
+
 /*
  * Threshold handler
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index b7fb541a4873..12d61b8f8154 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1771,6 +1771,11 @@ static void __mcheck_cpu_init_timer(void)
 	mce_start_timer(t);
 }
=20
+bool filter_mce(struct mce *m)
+{
+	return false;
+}
+
 /* Handle unconfigured int18 (should never happen) */
 static void unexpected_machine_check(struct pt_regs *regs, long error_code=
)
 {
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/ge=
npool.c
index 3395549c51d3..64d1d5a00f39 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -99,6 +99,9 @@ int mce_gen_pool_add(struct mce *mce)
 {
 	struct mce_evt_llist *node;
=20
+	if (filter_mce(mce))
+		return -EINVAL;
+
 	if (!mce_evt_pool)
 		return -EINVAL;
=20
--=20
2.17.1

