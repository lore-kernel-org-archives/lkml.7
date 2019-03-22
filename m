Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B2421841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GGrZzQNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfCVU0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:33 -0400
Received: from mail-eopbgr800072.outbound.protection.outlook.com ([40.107.80.72]:17312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727622AbfCVU0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/g4Y9hkjxzlcrTUIt5EFqbukjzqKWkMx0bOOGhdRgQ=;
 b=GGrZzQNz8kExPE8odO0Ndo4aYEwzj7MYWSucvbtgNZZyNFYDoKG2GAZDEuVfQ1NuX1p4qME9FuvVE4b8RQf3o/AZ2bkaaQTPfwiLbqCDgvSXNquKQItaLhRVPqXjLsNF+t93eggNseu6Sa3tjdnQgA//sn2N+LmzT3/BDign4rY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2622.namprd12.prod.outlook.com (52.135.103.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 20:26:11 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:26:10 +0000
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
Subject: [PATCH 4/6] acpi/cppc: Add macros to define a R/W sysfs entry for
 CPPC registers
Thread-Topic: [PATCH 4/6] acpi/cppc: Add macros to define a R/W sysfs entry
 for CPPC registers
Thread-Index: AQHU4O18kO2+2skZzkCsZd86zVVTZg==
Date:   Fri, 22 Mar 2019 20:26:10 +0000
Message-ID: <c0db0c87b76a8ef08c3ab33b3341cf73c9fa8d20.1553285718.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: a2adc2bb-55db-40d7-51cb-08d6af049eca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2622;
x-ms-traffictypediagnostic: SN6PR12MB2622:
x-microsoft-antispam-prvs: <SN6PR12MB2622BC9B862105809EDCD15DE7430@SN6PR12MB2622.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(256004)(14444005)(2906002)(2501003)(50226002)(53936002)(8936002)(68736007)(52116002)(99286004)(6506007)(102836004)(386003)(26005)(110136005)(6436002)(118296001)(6486002)(6512007)(316002)(76176011)(36756003)(97736004)(11346002)(446003)(5660300002)(186003)(486006)(476003)(2616005)(71200400001)(71190400001)(14454004)(54906003)(478600001)(72206003)(6116002)(106356001)(105586002)(25786009)(2201001)(86362001)(81156014)(81166006)(3846002)(8676002)(66066001)(305945005)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2622;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ik2m6RhSw/+7OjYUrUMxnSNg4HGExSbgusBoeZLoLgYavly/TOPOayMFGh6JK+ZUzbXgq0UfK0AbqmGPA8odgY1KB92/ZObVU6A8Uv+IEQ9XYicLUBgC9M96H8R79iv6W5HZBcGa8SYP2e6JHzjh7zOmpMk3WmqXE1gUDrBbQM+EFey5dMy49gmz16YkVI/RNQjZfUluVWy+4ybRdk4NR28pYguxiKe4WrTiJ8aNgdip0cEFUxDUXg4dRR6psRtixS7WU5XaAYwqa/8W3kgsaym8cQ92BfSf3RNFLyNPncMf05IS2grB5jv5NZbtUggRhFGKerx6Cwp8dU/39W34TJAsNksTmc2R6ah9IybPdgJVd5qEv12F302a4cIur33GpPhVLsaPGO18GTh9HjhodE3o8/i7AE6Rf1/h9iAqQwI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2adc2bb-55db-40d7-51cb-08d6af049eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:26:10.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

Some CPPC registers can be used to configure the platform. To enable this,
create macros to define the show, store routines and create sysfs entries
with R/W permission.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e81c19316628..7cb23b369fc7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -134,6 +134,10 @@ struct cppc_attr {
 static struct cppc_attr _name =3D			\
 __ATTR(_name, 0444, show_##_name, NULL)
=20
+#define define_one_cppc_rw(_name)		\
+static struct cppc_attr _name =3D			\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
=20
 #define show_cppc_data(access_fn, struct_name, member_name)		\
@@ -156,6 +160,33 @@ __ATTR(_name, 0444, show_##_name, NULL)
 	show_cppc_data(access_fn, struct_name, member_name)		\
 	define_one_cppc_ro(member_name)
=20
+#define store_cppc_data(struct_name, member_name, reg_idx)		\
+	static ssize_t store_##member_name(struct kobject *kobj,	\
+					   struct attribute *attr,	\
+					   const char *c, ssize_t count)\
+	{								\
+		struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);		\
+		struct struct_name st_name =3D {0};			\
+		u32 val;						\
+		int ret;						\
+									\
+		ret =3D kstrtou32(c, 0, &val);				\
+		if (ret)						\
+			return ret;					\
+									\
+		st_name.member_name =3D val;				\
+									\
+		ret =3D cppc_set_reg(cpc_ptr->cpu_id, &st_name, reg_idx);	\
+		if (ret)						\
+			return ret;					\
+									\
+		return count;						\
+	}								\
+
+#define store_cppc_data_rw(struct_name, member_name, reg_idx)		\
+	store_cppc_data(struct_name, member_name, reg_idx)		\
+	define_one_cppc_rw(member_name)
+
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
 show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
--=20
2.17.1

