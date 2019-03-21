Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F2218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k1vNqxvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfCUUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:25:27 -0400
Received: from mail-eopbgr810088.outbound.protection.outlook.com ([40.107.81.88]:29732
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfCUUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4obxn2514Mi/5yHKK0FLcKNgFi5ElX3slNbaQ5MQEc=;
 b=k1vNqxvrg5B+37xBNdkSBprosi64xbjvmB69f84ekFLx7mDX+IopDrqJAkeBymQs4130OlYROY54enJaeQ4dyJ4NxntxdDClzHe599XtckXEM5meGp98Vzu9omTjwWODUU5J49p4vtoiL8Sja50aveh22bmdihNewzsB8bZK5X8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2685.namprd12.prod.outlook.com (52.135.103.26) with Microsoft SMTP
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
Subject: [PATCH v2 1/2] x86/MCE: Add function to allow filtering of MCA errors
Thread-Topic: [PATCH v2 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Index: AQHU4CQyTsE/SKvH9kGTin5rcQxftA==
Date:   Thu, 21 Mar 2019 20:25:17 +0000
Message-ID: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 4af0cc7f-2f27-4934-5dc0-08d6ae3b554e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2685;
x-ms-traffictypediagnostic: SN6PR12MB2685:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2685C36BD269A619628C0DABF8420@SN6PR12MB2685.namprd12.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(66066001)(71190400001)(966005)(36756003)(71200400001)(316002)(81156014)(81166006)(72206003)(14454004)(8676002)(2906002)(6486002)(50226002)(53936002)(6512007)(6116002)(478600001)(105586002)(106356001)(6436002)(8936002)(5640700003)(3846002)(54906003)(2351001)(14444005)(305945005)(102836004)(6506007)(386003)(476003)(1076003)(486006)(2501003)(26005)(186003)(97736004)(86362001)(6306002)(25786009)(99286004)(52116002)(256004)(6916009)(2616005)(5660300002)(4326008)(68736007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oGdg8PzeJPXBYJbB1Tm701ztR07fnn39TIe68rQN81ZSOsp39+xUEixwPCiB02be2MZ3gVoXi3J32CfEQhVFTidNrju1/ZiJ+0rsX3yFRjaevMZDvfr8DtP+lM0oi89QrmkMDBH/CQ4n3KdKpdFCZcugTpezXkhWzhV8QL9D5kYY25MF/XpC6/OTqyksUtfjhHmWVK5+ETgtikDfAK/qbQklIjZY/SNgtwRDf91Sa7j9JVbsfenV7hsn+10HCoJAsin+RsK5zPaaCNOB5uPgZphEHt2AQxNPVzIt7b2DW/h0hDhQ5r6eckGDPRQnsn0cD4lysejOAaCMrFQm84R3hyKeUMnCpVcXSQNLjOZZhXf/raw7dyRafrPYX7ogNKZOg7Yjr0CYbpqciTpt7pjiDyUkXFsktLdM2py1XIYs+wU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af0cc7f-2f27-4934-5dc0-08d6ae3b554e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 20:25:17.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
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

Create a function pointer to filter MCA errors and use this when adding
an error to the MCE event pool.

Install a default function that does not filter any errors.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190307212552.8865-1-Yazen.Ghannam@amd.com

v1->v2:
* This is a new patch replacing V1 Patch 1 which is no longer needed.

 arch/x86/include/asm/mce.h        | 3 +++
 arch/x86/kernel/cpu/mce/core.c    | 6 ++++++
 arch/x86/kernel/cpu/mce/genpool.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 22d05e3835f0..0b0b797a959c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -253,6 +253,9 @@ extern void mce_disable_bank(int bank);
 extern void (*machine_check_vector)(struct pt_regs *, long error_code);
 void do_machine_check(struct pt_regs *, long);
=20
+/* Filter MCEs from the decoder chain. */
+extern bool (*filter_mce)(struct mce *m);
+
 /*
  * Threshold handler
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index b7fb541a4873..effb40581f08 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1771,6 +1771,12 @@ static void __mcheck_cpu_init_timer(void)
 	mce_start_timer(t);
 }
=20
+/*
+ * Don't filter MCEs by default. Install a system-specific function, if ne=
eded.
+ */
+static bool default_filter_mce(struct mce *m) { return false; }
+bool (*filter_mce)(struct mce *) =3D default_filter_mce;
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

