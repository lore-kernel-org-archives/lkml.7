Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB49C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE8021841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WJV1rQFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfCVU0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:38 -0400
Received: from mail-eopbgr800072.outbound.protection.outlook.com ([40.107.80.72]:17312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbfCVU0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgOkF34Nf8D4ZXXUJ+6mo6tkYV54TSiFfP8iAHpWq1Q=;
 b=WJV1rQFIH6y8eWZ6ZrSJjkuLKshlVTQ4kb52FTeHOic9yNeczmHOlGWxUNgsToXobYH5IKbAjE1KF9W605sSJa5YdzyfkFaVlM9poyPtrR/b0XlyDjOgg3YlF+wwrIVv0mf5+oXmSyDfnnkQBkwqyaPGqlfsgtgFu4BROsMt07Y=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2622.namprd12.prod.outlook.com (52.135.103.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 20:26:13 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:26:13 +0000
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
Subject: [PATCH 6/6] acpi/cppc: Add support for CPPC Enable register
Thread-Topic: [PATCH 6/6] acpi/cppc: Add support for CPPC Enable register
Thread-Index: AQHU4O1+ZZ1rK3k8pk25gNdSxHOghw==
Date:   Fri, 22 Mar 2019 20:26:13 +0000
Message-ID: <7e20fe2349bff1dc14c477c5bb456b8b1cde2994.1553285718.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: d3638d4c-5296-4a31-f483-08d6af04a0cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2622;
x-ms-traffictypediagnostic: SN6PR12MB2622:
x-microsoft-antispam-prvs: <SN6PR12MB26228E1685D9F289F0DC006FE7430@SN6PR12MB2622.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(256004)(14444005)(2906002)(2501003)(50226002)(53936002)(8936002)(68736007)(52116002)(99286004)(6506007)(102836004)(386003)(26005)(110136005)(6436002)(118296001)(6486002)(6512007)(316002)(76176011)(36756003)(97736004)(11346002)(446003)(5660300002)(186003)(486006)(476003)(2616005)(71200400001)(71190400001)(14454004)(54906003)(478600001)(72206003)(6116002)(106356001)(105586002)(25786009)(2201001)(86362001)(81156014)(81166006)(3846002)(8676002)(66066001)(305945005)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2622;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: orpD4nw41RS7d13v3D6qbMBPni3ofo9DqZBboX1+tdumvxWTdmFRhYhkDQgs0ZzAhHOx2eb/u/3oPyCrns4aEAyHabwrh9RvqyclSbKZEoXec4R823Ers8IqZJNy85NT7pp+9wOikuQc3nlMzmbGCoK3Lm78em8Bf8Jkw0qXz4TKZkUrDVk3sBIizbWeinCq3Ms+LvQWDdO26DJBAI/osgaX2YZI2psdIcSwpPVZg45ha42jkiNvprUJ65ZnbQBbO0fVAGtj6oIqaUNgpKKlPPaUrOxywfDb+JRuHoIO8B3gXLAqrxd7y4zDYbK6EH3LmyQbBkfnXZZiE0eXv8T4fI31f1/ncNUVcuQMzHO79ia2v0PU85afFzmoujh/AxiaotCBQfti88BWRZpm76HxacTh7Hz4BGd4vbnsKEYLF8M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3638d4c-5296-4a31-f483-08d6af04a0cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:26:13.4817
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

To enable CPPC on a processor, the OS should write a value "1" to the
CPPC Enable register. Add support for this register.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 96 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 97 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f8827ba7015d..8c6804976bb8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -224,6 +224,43 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj=
,
 }
 define_one_cppc_ro(feedback_ctrs);
=20
+/* Used to move ENABLE register value between userspace and platform */
+static bool cppc_cpu_enable;
+
+static ssize_t show_enable(struct kobject *kobj,
+			   struct attribute *attr,
+			   char *buf)
+{
+	struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);
+	int ret;
+
+	ret =3D cppc_get_enable(cpc_ptr->cpu_id);
+	if (ret)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", cppc_cpu_enable);
+}
+
+static ssize_t store_enable(struct kobject *kobj,
+			    struct attribute *attr,
+			    const char *c, ssize_t count)
+{
+	struct cpc_desc *cpc_ptr =3D to_cpc_desc(kobj);
+	int ret;
+
+	ret =3D kstrtobool(c, &cppc_cpu_enable);
+	if (ret)
+		return ret;
+
+	ret =3D cppc_set_reg(cpc_ptr->cpu_id, NULL, ENABLE);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+define_one_cppc_rw(enable);
+
 static struct kobj_type cppc_ktype =3D {
 	.sysfs_ops =3D &kobj_sysfs_ops,
 };
@@ -794,6 +831,9 @@ int set_cppc_attrs(struct cpc_desc *cpc, int entries)
 		case DESIRED_PERF:
 			cppc_attrs[attr_i++] =3D &desired_perf.attr;
 			break;
+		case ENABLE:
+			cppc_attrs[attr_i++] =3D &enable.attr;
+			break;
 		}
 	}
=20
@@ -1383,6 +1423,9 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	}
=20
 	switch (reg_idx) {
+	case ENABLE:
+		value =3D cppc_cpu_enable;
+		break;
 	case DESIRED_PERF:
 		value =3D perf_ctrls->desired_perf;
 		break;
@@ -1572,6 +1615,59 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf);
=20
+/**
+ * cppc_get_enable - Read a CPUs enable register.
+ * @cpu: CPU from which to read control values.
+ *
+ * Return: 0 for success.
+ */
+int cppc_get_enable(int cpu)
+{
+	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cpc_register_resource *enable_reg;
+	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	int ret =3D 0, regs_in_pcc =3D 0;
+	u64 enable;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU: %d\n", cpu);
+		return -ENODEV;
+	}
+
+	enable_reg =3D &cpc_desc->cpc_regs[ENABLE];
+
+	if (!CPC_SUPPORTED(enable_reg)) {
+		pr_warn("CPC ENABLE register not supported.\n");
+		return -ENOTSUPP;
+	}
+
+	if (CPC_IN_PCC(enable_reg)) {
+		pcc_ss_data =3D pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc =3D 1;
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret =3D -EIO;
+			goto out_err;
+		}
+	}
+
+	if (cpc_read(cpu, enable_reg, &enable)) {
+		ret =3D -EFAULT;
+		goto out_err;
+	}
+
+	cppc_cpu_enable =3D enable;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_enable);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
  *
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 6f651235933c..fcdedff8e6bd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,6 +139,7 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
=20
+extern int cppc_get_enable(int cpu);
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
 extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
--=20
2.17.1

