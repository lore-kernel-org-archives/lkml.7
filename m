Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD86DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D5420863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aAfmBPQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfCYQeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:34:36 -0400
Received: from mail-eopbgr700057.outbound.protection.outlook.com ([40.107.70.57]:26849
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729824AbfCYQed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCoWTXjpjzRli6KZQeHsUg8+5YdI3sAncaHV27c1AVc=;
 b=aAfmBPQRw5zyzHphEvL9is5D5wap/4UpNXxhYSFhRDjJucrTuqCZjFfYfwQO+U/0WNi0DEILI9nT7eF7Axqt19yxWTzQAN60OjV+cBlifWZgp/SG+ovl/EPVogWZWboMJH8KNLPncj0wWelWxdOPJs9yxw8HOUz9Wi9ZE8OmJgY=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Mon, 25 Mar 2019 16:34:22 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 16:34:22 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA errors
Thread-Topic: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Thread-Index: AQHU4yiZZ+0d48CL0U+6DDOUp4sfcA==
Date:   Mon, 25 Mar 2019 16:34:22 +0000
Message-ID: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: f62fec10-3d8f-4a22-f399-08d6b13fbc29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2749E45F546F6072F73BD8BDF85E0@SN6PR12MB2749.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(81166006)(36756003)(54906003)(86362001)(7736002)(50226002)(476003)(81156014)(478600001)(8676002)(8936002)(305945005)(486006)(2501003)(71190400001)(71200400001)(105586002)(102836004)(26005)(2351001)(66066001)(106356001)(6916009)(4326008)(97736004)(186003)(386003)(2906002)(6306002)(6506007)(6436002)(72206003)(2616005)(68736007)(14444005)(53936002)(256004)(5640700003)(966005)(14454004)(5660300002)(6116002)(6512007)(316002)(3846002)(52116002)(99286004)(25786009)(6486002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xqIWbAK8HghXll+GbmJoOAUIDbLXtyVErWJyd1yA5QIq1xHlLFOn/bD6wS3hi/dCxVTCIiBLLEpocjRq4ALQxm4WhrsQ2942j3ASaGAXv52RPecYX9pMLF/3BXnvD+yEp6apeMD960M2jod71qXnOkfBE33AyPYmedFo49lvedI+qrDC8NgtmImXs0etAjp+ePzPCtOyvsPIA41Bix9ez+cXlTuzww4V5zWt5Eot6ALileF4jJfxt8rbzuRrxrW98go4p1ToiWcVlGVTVjLmlXYevUPSBiegkxpveJ/xkP5eOaF6pbV+TdWu2DON+Ae3LlsyNi6B/KOOn9xMhJqv4OPeJRiC8/Mq0tm+iKqbaLoK4yT/MPA59ws+f3MwMhevugfQcJm0to0hljTIXgxdKOxYYyzepfS1htZ2A9D+zuQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62fec10-3d8f-4a22-f399-08d6b13fbc29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 16:34:22.0998
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

Some systems may report spurious MCA errors. In general, spurious MCA
errors may be disabled by clearing a particular bit in MCA_CTL. However,
clearing a bit in MCA_CTL may not be recommended for some errors, so the
only option is to ignore them.

An MCA error is printed and handled after it has been added to the MCE
event pool. So an MCA error can be ignored by not adding it to the pool.

Define a default function that does not filter any errors.

Check if an MCA error should be filtered out when adding it to the MCE
event pool.

Cc: <stable@vger.kernel.org> # 5.0.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190322202848.20749-1-Yazen.Ghannam@amd.com

v3->v4:
* No change.

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
index dc2d4b206ab7..446919cb4ca8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -243,6 +243,9 @@ extern void mce_disable_bank(int bank);
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

