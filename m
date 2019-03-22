Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A63C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C7D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d8iaJqYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCVU02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:26:28 -0400
Received: from mail-eopbgr800072.outbound.protection.outlook.com ([40.107.80.72]:17312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbfCVU01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaQuMBa6XLXHy89VWDagjQPsQYQRTKSdqvrknx5rglQ=;
 b=d8iaJqYDkSwr2yTCajAU5Ip/XycmkApR9lTT/3gTi1COhvzQZGTQ/1xnWwlI5hHMK8wXoFgM3OHoUVuQiwaS3WCALJXDZzB51QLLDTVZO8Bz9fZLFpdobAtszkevHfIpQhI3VV1p5c33Fcs5mJzujEHLX7jCKNscbt/7VbOef8M=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2622.namprd12.prod.outlook.com (52.135.103.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 22 Mar 2019 20:26:11 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::9584:f1be:656e:b00b%5]) with mapi id 15.20.1709.015; Fri, 22 Mar 2019
 20:26:11 +0000
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
Subject: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Topic: [PATCH 5/6] acpi/cppc: Add support for optional CPPC registers
Thread-Index: AQHU4O191UcWlpu2CUepblWSsE7ChA==
Date:   Fri, 22 Mar 2019 20:26:11 +0000
Message-ID: <d16e973c3fa4343134f6d246cc424f29ff5d7dc9.1553285718.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 9f651e3c-4d92-4a0d-cdf3-08d6af049fa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2622;
x-ms-traffictypediagnostic: SN6PR12MB2622:
x-microsoft-antispam-prvs: <SN6PR12MB26221A380851A1B20CA84F22E7430@SN6PR12MB2622.namprd12.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(256004)(14444005)(2906002)(2501003)(50226002)(53936002)(8936002)(68736007)(52116002)(99286004)(6506007)(102836004)(386003)(26005)(110136005)(6436002)(118296001)(6486002)(6512007)(316002)(76176011)(36756003)(97736004)(11346002)(446003)(5660300002)(186003)(486006)(476003)(2616005)(71200400001)(71190400001)(14454004)(54906003)(478600001)(72206003)(6116002)(106356001)(105586002)(25786009)(2201001)(86362001)(81156014)(81166006)(3846002)(8676002)(66066001)(305945005)(7736002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2622;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4P/bpNzUsI4cZ00P1/Kr1PyeNq+eKPBLDjBqDHjbGj4MpRQSBnnGn6iZCbbIe+Ab1erMdbMUIPSKTwOsnvE+X/BxkwHKejZhDSBZprAhiXqL4nuwHanRJFrPQkQn/x844/C7Cl+fMT2DunApCK30YdswMXQdIrTX91g+WAD5ljbyuFpZDQT1uzJqo+06A5RJuHwCGEUVrA+G5hxxGk6hUX3Hgyn8iXP23SNZru5ybyTWEsGyfrqzWLXkXyj7/p3fEmpFEsIGlbOfT2ytttW4HsXO5JR2ONo90zd0pDJl5m9wsJhzvt7G1Gnhtg6OwYtoIwOxRnfF93tsbPf/m95r1BlLwtWFgFNYbTHmt0JGFH1LdyLssZcPPMfAFIntb9wk1IAZVzJ7f6hTpNFgIv22EAgOaBGM4JghxJS3tsopK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f651e3c-4d92-4a0d-cdf3-08d6af049fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 20:26:11.5534
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

Newer AMD processors support a subset of the optional CPPC registers.
Create show, store and helper routines for supported CPPC registers.

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ carved out into a patch, cleaned up, productized ]
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 119 ++++++++++++++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h |   3 +
 2 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7cb23b369fc7..f8827ba7015d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -196,6 +196,17 @@ show_cppc_data_ro(cppc_get_perf_caps, cppc_perf_caps, =
nominal_freq);
=20
 show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data_ro(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, desired_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, max_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, min_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, energy_perf);
+show_cppc_data(cppc_get_perf, cppc_perf_ctrls, auto_sel_enable);
+
+store_cppc_data_rw(cppc_perf_ctrls, desired_perf, DESIRED_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, max_perf, MAX_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, min_perf, MIN_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, energy_perf, ENERGY_PERF);
+store_cppc_data_rw(cppc_perf_ctrls, auto_sel_enable, AUTO_SEL_ENABLE);
=20
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct attribute *attr, char *buf)
@@ -768,6 +779,21 @@ int set_cppc_attrs(struct cpc_desc *cpc, int entries)
 		case CTR_WRAP_TIME:
 			cppc_attrs[attr_i++] =3D &wraparound_time.attr;
 			break;
+		case MAX_PERF:
+			cppc_attrs[attr_i++] =3D &max_perf.attr;
+			break;
+		case MIN_PERF:
+			cppc_attrs[attr_i++] =3D &min_perf.attr;
+			break;
+		case ENERGY_PERF:
+			cppc_attrs[attr_i++] =3D &energy_perf.attr;
+			break;
+		case AUTO_SEL_ENABLE:
+			cppc_attrs[attr_i++] =3D &auto_sel_enable.attr;
+			break;
+		case DESIRED_PERF:
+			cppc_attrs[attr_i++] =3D &desired_perf.attr;
+			break;
 		}
 	}
=20
@@ -1348,7 +1374,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data =3D NULL;
 	struct cpc_register_resource *reg;
-	int ret =3D 0;
+	int ret =3D 0, regs_in_pcc =3D 0;
 	u32 value;
=20
 	if (!cpc_desc) {
@@ -1360,6 +1386,18 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 	case DESIRED_PERF:
 		value =3D perf_ctrls->desired_perf;
 		break;
+	case MAX_PERF:
+		value =3D perf_ctrls->max_perf;
+		break;
+	case MIN_PERF:
+		value =3D perf_ctrls->min_perf;
+		break;
+	case ENERGY_PERF:
+		value =3D perf_ctrls->energy_perf;
+		break;
+	case AUTO_SEL_ENABLE:
+		value =3D perf_ctrls->auto_sel_enable;
+		break;
 	default:
 		pr_debug("CPC register index #%d not writeable\n", reg_idx);
 		return -EINVAL;
@@ -1375,6 +1413,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	 * achieve that goal here
 	 */
 	if (CPC_IN_PCC(reg)) {
+		regs_in_pcc =3D 1;
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1397,13 +1436,10 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *p=
erf_ctrls,
 		cpc_desc->write_cmd_status =3D 0;
 	}
=20
-	/*
-	 * Skip writing MIN/MAX until Linux knows how to come up with
-	 * useful values.
-	 */
-	cpc_write(cpu, reg, value);
+	if (CPC_SUPPORTED(reg))
+		cpc_write(cpu, reg, value);
=20
-	if (CPC_IN_PCC(reg))
+	if (regs_in_pcc)
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
@@ -1451,7 +1487,7 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *per=
f_ctrls,
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(reg)) {
+	if (regs_in_pcc) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
@@ -1469,6 +1505,73 @@ int cppc_set_reg(int cpu, struct cppc_perf_ctrls *pe=
rf_ctrls,
 }
 EXPORT_SYMBOL_GPL(cppc_set_reg);
=20
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg, *max_reg, *min_reg;
+	struct cpc_register_resource *energy_reg, *auto_sel_enable_reg;
+	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
+	u64 desired, max, min, energy, auto_sel_enable;
+	struct cppc_pcc_data *pcc_ss_data =3D NULL;
+	int ret =3D 0, regs_in_pcc =3D 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU: %d\n", cpu);
+		return -ENODEV;
+	}
+
+	desired_reg =3D &cpc_desc->cpc_regs[DESIRED_PERF];
+	max_reg =3D &cpc_desc->cpc_regs[MAX_PERF];
+	min_reg =3D &cpc_desc->cpc_regs[MIN_PERF];
+	energy_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
+	auto_sel_enable_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(max_reg) ||
+	    CPC_IN_PCC(min_reg) || CPC_IN_PCC(energy_reg) ||
+	    CPC_IN_PCC(auto_sel_enable_reg)) {
+		pcc_ss_data =3D pcc_data[pcc_ss_id];
+		down_write(&pcc_ss_data->pcc_lock);
+		regs_in_pcc =3D 1;
+
+		/*Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret =3D -EIO;
+			goto out_err;
+		}
+	}
+
+	/* desired_perf is the only mandatory value in perf_ctrls */
+	if (cpc_read(cpu, desired_reg, &desired))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(max_reg) && cpc_read(cpu, max_reg, &max))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(min_reg) && cpc_read(cpu, min_reg, &min))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(energy_reg) && cpc_read(cpu, energy_reg, &energy))
+		ret =3D -EFAULT;
+
+	if (CPC_SUPPORTED(auto_sel_enable_reg) &&
+	    cpc_read(cpu, auto_sel_enable_reg, &auto_sel_enable))
+		ret =3D -EFAULT;
+
+	if (!ret) {
+		perf_ctrls->desired_perf =3D desired;
+		perf_ctrls->max_perf =3D max;
+		perf_ctrls->min_perf =3D min;
+		perf_ctrls->energy_perf =3D energy;
+		perf_ctrls->auto_sel_enable =3D auto_sel_enable;
+	}
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in n=
s
  *
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index ba3b3fb64572..6f651235933c 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -117,6 +117,8 @@ struct cppc_perf_ctrls {
 	u32 max_perf;
 	u32 min_perf;
 	u32 desired_perf;
+	u32 auto_sel_enable;
+	u32 energy_perf;
 };
=20
 struct cppc_perf_fb_ctrs {
@@ -140,6 +142,7 @@ struct cppc_cpudata {
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_c=
trs);
 extern int cppc_set_reg(int cpu, struct cppc_perf_ctrls *perf_ctrls, enum =
cppc_regs reg_idx);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern int acpi_get_psd_map(struct cppc_cpudata **);
 extern unsigned int cppc_get_transition_latency(int cpu);
--=20
2.17.1

