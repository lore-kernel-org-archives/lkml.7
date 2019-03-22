Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE18C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47C021841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Mf/49jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfCVU0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:43 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:57856
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfCVU0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypHsmOzKoO8CbtlP60gaGkfz+t4ohUU+fEsdKDjkjAE=;
 b=1Mf/49jvNxe1xlryohx96QjGlzd6wtu2MBqGnULysOHEgpy5L0F8YrMJCVkPAj8rwICNzZNbnRAPdr94WrQXsCeHFx+DCXtNqw/5Qz+Ff4YRj+YRESc6leVKzV+JInXhuWDhvvdSnGWvseD6dwOqDVNpcQDYazf9PnxVkcDSg7o=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:25:58 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:25:58 +0000
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
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH 1/6] acpi/cppc: Ensure only supported CPPC sysfs entries are
 created
Thread-Topic: [PATCH 1/6] acpi/cppc: Ensure only supported CPPC sysfs entries
 are created
Thread-Index: AQHU4O113BSSNkgmEEC187+8w8GSwQ==
Date:   Fri, 22 Mar 2019 20:25:58 +0000
Message-ID: <c7fe67527a77fed160a09939b1f11dbc417f4287.1553285718.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 9fbdd0c2-848e-404d-60a9-08d6af0497b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB26879DA506098F17174AFD37E7430@SN6PR12MB2687.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(7736002)(11346002)(71190400001)(5660300002)(14454004)(71200400001)(478600001)(6436002)(446003)(72206003)(2616005)(476003)(305945005)(97736004)(68736007)(2501003)(6486002)(256004)(105586002)(486006)(118296001)(54906003)(53936002)(110136005)(81166006)(2906002)(81156014)(25786009)(99286004)(6512007)(106356001)(8936002)(36756003)(50226002)(102836004)(4326008)(26005)(6116002)(2201001)(6506007)(66066001)(3846002)(76176011)(316002)(386003)(86362001)(52116002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Duckk0lyZt/Yc4po6656TX3h2XSloemvdd8vsmqGGDpB8st6Z0JQTKDZcCg+H0ynm1+qI84BTi2MO0bqR6MVC/9A5JpPxTS6R9rmkpHR3VclgtoaOOfq8NuCZXxfv64A5keVR4d/i9IUhikJCwUvc5I7T+Bt2F8G7BvLluVfeyHcmEzCzcwLh6lVWg2QLpsZyfue2x+lgeacPo6ZBnGIX8A2GooJ1VNA0xHbGkfjHmpL7vR46jxE0ffpZAqCu0iW/sqmlOeklK2wZ2gyo4w0/0FB/g8ZjwVncWHx6SueEPLEFqk8QKY2d/4s6FpQ7udilKPw2a0KEAqwV5vCtq4lPSjcIiWyz/h3c+FEuGw2txsFx6CZ6nkmBVWVLyraBMpVjl6MtyfnCo/u2igaLkV8joJZwjh6mw+LftQpL/YIfCg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbdd0c2-848e-404d-60a9-08d6af0497b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:25:58.4617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add attributes for registers that are supported by the platform. This preve=
nts
unsupported optional registers from having sysfs entries created.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 70 ++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1b207fca1420..66fad270376c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -179,22 +179,8 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj=
,
 }
 define_one_cppc_ro(feedback_ctrs);
=20
-static struct attribute *cppc_attrs[] =3D {
-	&feedback_ctrs.attr,
-	&reference_perf.attr,
-	&wraparound_time.attr,
-	&highest_perf.attr,
-	&lowest_perf.attr,
-	&lowest_nonlinear_perf.attr,
-	&nominal_perf.attr,
-	&nominal_freq.attr,
-	&lowest_freq.attr,
-	NULL
-};
-
 static struct kobj_type cppc_ktype =3D {
 	.sysfs_ops =3D &kobj_sysfs_ops,
-	.default_attrs =3D cppc_attrs,
 };
=20
 static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
@@ -709,6 +695,57 @@ static bool is_cppc_supported(int revision, int num_en=
t)
  *	}
  */
=20
+int set_cppc_attrs(struct cpc_desc *cpc, int entries)
+{
+	static struct attribute **cppc_attrs;
+	int i, attr_i =3D 0;
+
+	/* Extra for feedback_ctrs to be exposed via sysfs */
+	cppc_attrs =3D kcalloc(entries + 1, sizeof(*cppc_attrs), GFP_KERNEL);
+	if (!cppc_attrs)
+		return -ENOMEM;
+
+	for (i =3D 0; i < MAX_CPC_REG_ENT && attr_i < entries; i++) {
+		if (!CPC_SUPPORTED(&cpc->cpc_regs[i]))
+			continue;
+
+		switch (i) {
+		case HIGHEST_PERF:
+			cppc_attrs[attr_i++] =3D &highest_perf.attr;
+			break;
+		case NOMINAL_PERF:
+			cppc_attrs[attr_i++] =3D &nominal_perf.attr;
+			break;
+		case LOW_NON_LINEAR_PERF:
+			cppc_attrs[attr_i++] =3D &lowest_nonlinear_perf.attr;
+			break;
+		case LOWEST_PERF:
+			cppc_attrs[attr_i++] =3D &lowest_perf.attr;
+			break;
+		case NOMINAL_FREQ:
+			cppc_attrs[attr_i++] =3D &nominal_freq.attr;
+			break;
+		case LOWEST_FREQ:
+			cppc_attrs[attr_i++] =3D &lowest_freq.attr;
+			break;
+		case REFERENCE_PERF:
+			cppc_attrs[attr_i++] =3D &reference_perf.attr;
+			break;
+		case CTR_WRAP_TIME:
+			cppc_attrs[attr_i++] =3D &wraparound_time.attr;
+			break;
+		}
+	}
+
+	/* Set feedback_ctr sysfs entry */
+	cppc_attrs[attr_i] =3D &feedback_ctrs.attr;
+
+	/* Set kobj_type member */
+	cppc_ktype.default_attrs =3D cppc_attrs;
+
+	return 0;
+}
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPUs logical Id.
@@ -863,6 +900,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *p=
r)
 	/* Plug PSD data into this CPUs CPC descriptor. */
 	per_cpu(cpc_desc_ptr, pr->id) =3D cpc_ptr;
=20
+	ret =3D set_cppc_attrs(cpc_ptr, num_ent - 2);
+	if (ret)
+		goto out_free;
+
 	ret =3D kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
 			"acpi_cppc");
 	if (ret) {
@@ -924,6 +965,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr=
)
 			iounmap(addr);
 	}
=20
+	kfree(cppc_ktype.default_attrs);
 	kobject_put(&cpc_ptr->kobj);
 	kfree(cpc_ptr);
 }
--=20
2.17.1

