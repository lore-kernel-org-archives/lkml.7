Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E579021841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N+tWpL2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCVU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:57 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:13587
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727622AbfCVU0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDBnmRyB6YcunDpJyxb2sjeaLzvnMtsbC/pqnZSrg0o=;
 b=N+tWpL2AIWvwWCG5tD5wIP+Ty6L95x58xy+GNw2P88H7YhM2HxzGRr1kLRwSMi8LG/CxKFmeVswIDnlriprihupheP+rvk8XSyGFkbZ6H16CBaxZSPHOpJn8dl0eyV9BTOhcBA/F2Xrw93aAWenG3x5+NcfczTZMCHt1irfXZ/k=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:26:00 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:26:00 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 2/6] acpi/cppc: Modify show_cppc_data macro
Thread-Topic: [PATCH 2/6] acpi/cppc: Modify show_cppc_data macro
Thread-Index: AQHU4O1279XO3Ni5CkWTaxJe5psZ4A==
Date:   Fri, 22 Mar 2019 20:26:00 +0000
Message-ID: <5b049c67394c96a21f561399e577ff5dbf1fa0a4.1553285718.git.Janakarajan.Natarajan@amd.com>
References: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1553285718.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d880b2e-954f-41ac-ee39-08d6af0498d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB268782ACE84DED59E6569C19E7430@SN6PR12MB2687.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(7736002)(11346002)(71190400001)(5660300002)(14454004)(71200400001)(478600001)(6436002)(446003)(72206003)(2616005)(476003)(305945005)(97736004)(68736007)(2501003)(6486002)(14444005)(256004)(105586002)(486006)(118296001)(54906003)(53936002)(110136005)(81166006)(2906002)(81156014)(25786009)(99286004)(6512007)(106356001)(8936002)(36756003)(50226002)(102836004)(4326008)(26005)(6116002)(2201001)(6506007)(66066001)(3846002)(76176011)(316002)(386003)(86362001)(52116002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vv/dmoG57YpzsbwBnb8CYfF827HeUnH6FpdX93/5MZHUOGiLwRaipZz+nhbcDtsP2eMx02/VE1nv3iWNY7mVxgM5sORT9v0m81IxsW+Ft0pC23K+XVcPVAALYXSM3o91/zgVuLdy/BcLkHlEik0Q58JoGwCBSiKugyNGAhWlP+lnJIFq+8K8fjN3kFfnXzVgSSyTBunTQaOeNeuYszX448T8QrsEfQ0/pTJbDM8ckSEfC/C/85LuW8SJa7pbneeZrUCNrIW3hd4MOtn0N1R5RfsZgFf6Q8zDTyTqvgTWmczNq2zm6sc+oqO2y/vRJ7c+RDk+qcTe2PzHZ7S3u8BfVxp/2OAqF/br1joX2gzIDur0IZlN25mWkUX5SUpyGROnkVqjML3+RoDhG8poP4RrdsN/6ZNWe6eTGsMt8WovPYM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d880b2e-954f-41ac-ee39-08d6af0498d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:26:00.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

The show_cppc_data macro implicity uses define_one_cppc_ro. This will
prevent the creation of an attribute with read and write permissions.

Create a separate macro that defines a show attribute and creates
a read-only sysfs entry. This is in preparation for adding a macro
to create sysfs entries with read+write permission.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 66fad270376c..9daeb0b034d5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -151,17 +151,20 @@ __ATTR(_name, 0444, show_##_name, NULL)
 		return scnprintf(buf, PAGE_SIZE, "%llu\n",		\
 				(u64)st_name.member_name);		\
 	}								\
+
+#define show_cppc_data_ro(access_fn, struct_name, member_name)		\
+	show_cppc_data(access_fn, struct_name, member_name)		\
 	define_one_cppc_ro(member_name)
=20
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
-show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_per=
f);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
+show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
=20
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
+show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
=20
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct attribute *attr, char *buf)
--=20
2.17.1

