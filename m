Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B697C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F9921925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xgSPojH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfCVU0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:41 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:13587
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727839AbfCVU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgQachq8VeiInYdzKF4eJJorRhyrfl2FDTiMgRAfLLg=;
 b=xgSPojH4jeGcGUBu8Eq9ucWkCWrR6apGWqyG4C23HevvPU7JaNDlF522aiiwpDxGfmW7EnHndBwvXk68UadL/0Mzsr8B3Bk1gDxLJwtieNKdaM02QG5Rz8uzo9TwYVuHLBInOyGPgeY87ZB2AdH62CMQVVmsyxgAedMX6lJmos8=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 20:26:08 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:26:08 +0000
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
Subject: [PATCH 3/6] acpi/cppc: Rework cppc_set_perf() to use cppc_regs index
Thread-Topic: [PATCH 3/6] acpi/cppc: Rework cppc_set_perf() to use cppc_regs
 index
Thread-Index: AQHU4O17a9va4LXrc0+ezVzya9jPUw==
Date:   Fri, 22 Mar 2019 20:26:08 +0000
Message-ID: <13617b46c2ed526ffa614c39d50cd32d58fc3c3b.1553285718.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: ead36795-c8b9-4390-935d-08d6af049db4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB2687FB6448557D4E7458897CE7430@SN6PR12MB2687.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(189003)(199004)(7736002)(11346002)(71190400001)(5660300002)(14454004)(71200400001)(478600001)(6436002)(446003)(72206003)(2616005)(476003)(305945005)(97736004)(68736007)(2501003)(6486002)(14444005)(256004)(105586002)(486006)(118296001)(54906003)(53936002)(110136005)(81166006)(2906002)(81156014)(25786009)(99286004)(6512007)(106356001)(8936002)(36756003)(50226002)(102836004)(4326008)(26005)(6116002)(2201001)(6506007)(66066001)(3846002)(76176011)(316002)(386003)(86362001)(52116002)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qNuRoeB3CeBwJfLpA1Fg1GvMFax2pncfrFR630rrfphNZ1pSiFuqE0sPV1Mcx39EHzWeUM58XfsyZ7hI15JULyUIDvt4vAlNGOCLktiFRHyIDiICoYXxdrvQYUfRgES9RWMpSfs+AvtZX2fodBaXP9KAxjq/4rGj2bB8NFMVU1e8b5xqa9kKmcvzAQ5AyIRfXqGz5DGX+PM4Ek1fssJNJKtzp9gVukFIXw4N/p/zKpVHA6NKmFfgdsYRJDMs5wNv+VuNHmB/G5iS5ku7A8U4Z2RwTEsdKQnhrOFgWmmeqDa51H3K6scsOF9c1BFpLCSYAhCRppT+rOnO+aSJEasxpFnXhrOZbZJDNJDeG+D0hNst1Ciw47LNqpYQe4R1f6bu2/rV0fKlG1eiLIFZmsTiodQ9vGEScBH4XB7DZF0tWVI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead36795-c8b9-4390-935d-08d6af049db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:26:08.2962
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

The cppc_set_perf() currently only works for DESIRED_PERF. To make it
generic, pass in the index of the register being accessed.

Also, rename cppc_set_perf() to cppc_set_reg(). This is in preparation
for it to be used for more than just the DESIRED_PERF register.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
 drivers/cpufreq/cppc_cpufreq.c |  6 +++---
 include/acpi/cppc_acpi.h       |  2 +-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9daeb0b034d5..e81c19316628 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -60,7 +60,7 @@ struct cppc_pcc_data {
 	/*
 	 * Lock to provide controlled access to the PCC channel.
 	 *
-	 * For performance critical usecases(currently cppc_set_perf)
+	 * For performance-critical usecases(currently cppc_set_reg)
 	 *	We need to take read_lock and check if channel belongs to OSPM
 	 * before reading or writing to PCC subspace
 	 *	We need to take write_lock before transferring the channel
@@ -1303,26 +1303,38 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf=
_fb_ctrs *perf_fb_ctrs)
 EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
=20
 /**
- * cppc_set_perf - Set a CPUs performance controls.
- * @cpu: CPU for which to set performance controls.
+ * cppc_set_reg - Set the CPUs control register.
+ * @cpu: CPU for which to set the register.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ * @reg_idx: Index of the register being accessed
  *
  * Return: 0 for success, -ERRNO otherwise.
  */
-int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls,
+		 enum cppc_regs reg_idx)
 {
 	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_reg;
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	struct cpc_register_resource *reg;
 	int ret =3D 0;
+	u32 value;
=20
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
=20
-	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	switch (reg_idx) {
+	case DESIRED_PERF:
+		value =3D perf_ctrls->desired_perf;
+		break;
+	default:
+		pr_debug("CPC register index #%d not writeable\n", reg_idx);
+		return -EINVAL;
+	}
+
+	reg =3D &cpc_desc->cpc_regs[reg_idx];
=20
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -1331,7 +1343,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1358,14 +1370,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *=
perf_ctrls)
 	 * Skip writing MIN/MAX until Linux knows how to come up with
 	 * useful values.
 	 */
-	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+	cpc_write(cpu, reg, value);
=20
-	if (CPC_IN_PCC(desired_reg))
+	if (CPC_IN_PCC(reg))
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
 	 *
-	 * Short Summary: Basically if we think of a group of cppc_set_perf
+	 * Short Summary: Basically if we think of a group of cppc_set_reg
 	 * requests that happened in short overlapping interval. The last CPU to
 	 * come out of Phase-I will enter Phase-II and ring the doorbell.
 	 *
@@ -1408,7 +1420,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(desired_reg)) {
+	if (CPC_IN_PCC(reg)) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
@@ -1424,7 +1436,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cppc_set_perf);
+EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.=
c
index 2ae978d27e61..420bd44f6958 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -211,7 +211,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_polic=
y *policy,
 	freqs.new =3D target_freq;
=20
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret =3D cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu->cpu, &cpu->perf_ctrls, DESIRED_PERF);
 	cpufreq_freq_transition_end(policy, &freqs, ret !=3D 0);
=20
 	if (ret)
@@ -235,7 +235,7 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy=
 *policy)
=20
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.lowest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
@@ -348,7 +348,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy =
*policy)
 					cpu->perf_caps.highest_perf);
 	cpu->perf_ctrls.desired_perf =3D cpu->perf_caps.highest_perf;
=20
-	ret =3D cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret =3D cppc_set_reg(cpu_num, &cpu->perf_ctrls, DESIRED_PERF);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 				cpu->perf_caps.highest_perf, cpu_num, ret);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index ba6fd7202775..ba3b3fb64572 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,7 +139,7 @@ struct cppc_cpudata {
=20
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
-extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1

