Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C610C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048DC2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgAFLL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:11:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgAFLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:11:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006B2HRa146444
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jan 2020 06:11:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8ukeswf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 06:11:53 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Mon, 6 Jan 2020 11:11:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 11:11:47 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006BBkIE30933156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 11:11:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31ED052051;
        Mon,  6 Jan 2020 11:11:46 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.124.31.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9AC155204F;
        Mon,  6 Jan 2020 11:11:44 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        linuxram@us.ibm.com, psampat@linux.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v2 1/3] powerpc/powernv: Interface to define support and preference for a SPR
Date:   Mon,  6 Jan 2020 16:41:40 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578307288.git.psampat@linux.ibm.com>
References: <cover.1578307288.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010611-0016-0000-0000-000002DAD784
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010611-0017-0000-0000-0000333D4A6D
Message-Id: <a51cfdd45b90295fbffec8d89641501bbe0ccd68.1578307288.git.psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001060102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a bitmask interface to determine support for the Self Restore,
Self Save or both.

Also define an interface to determine the preference of that SPR to
be strictly saved or restored or encapsulated with an order of preference.

The preference bitmask is shown as below:
----------------------------
|... | 2nd pref | 1st pref |
----------------------------
MSB			  LSB

The preference from higher to lower is from LSB to MSB with a shift of 8
bits.
Example:
Prefer self save first, if not available then prefer self
restore
The preference mask for this scenario will be seen as below.
((SELF_RESTORE_STRICT << PREFERENCE_SHIFT) | SELF_SAVE_STRICT)
---------------------------------
|... | Self restore | Self save |
---------------------------------
MSB			        LSB

Finally, declare a list of preferred SPRs which encapsulate the bitmaks
for preferred and supported with defaults of both being set to support
legacy firmware.

This commit also implements using the above interface and retains the
legacy functionality of self restore.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 327 +++++++++++++++++++++-----
 1 file changed, 271 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 78599bca66c2..2f328403b0dc 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -32,9 +32,106 @@
 #define P9_STOP_SPR_MSR 2000
 #define P9_STOP_SPR_PSSCR      855
 
+/* Interface for the stop state supported and preference */
+#define SELF_RESTORE_TYPE    0
+#define SELF_SAVE_TYPE       1
+
+#define NR_PREFERENCES    2
+#define PREFERENCE_SHIFT  4
+#define PREFERENCE_MASK   0xf
+
+#define UNSUPPORTED         0x0
+#define SELF_RESTORE_STRICT 0x1
+#define SELF_SAVE_STRICT    0x2
+
+/*
+ * Bitmask defining the kind of preferences available.
+ * Note : The higher to lower preference is from LSB to MSB, with a shift of
+ * 4 bits.
+ * ----------------------------
+ * |    | 2nd pref | 1st pref |
+ * ----------------------------
+ * MSB			      LSB
+ */
+/* Prefer Restore if available, otherwise unsupported */
+#define PREFER_SELF_RESTORE_ONLY	SELF_RESTORE_STRICT
+/* Prefer Save if available, otherwise unsupported */
+#define PREFER_SELF_SAVE_ONLY		SELF_SAVE_STRICT
+/* Prefer Restore when available, otherwise prefer Save */
+#define PREFER_RESTORE_SAVE		((SELF_SAVE_STRICT << \
+					  PREFERENCE_SHIFT)\
+					  | SELF_RESTORE_STRICT)
+/* Prefer Save when available, otherwise prefer Restore*/
+#define PREFER_SAVE_RESTORE		((SELF_RESTORE_STRICT <<\
+					  PREFERENCE_SHIFT)\
+					  | SELF_SAVE_STRICT)
 static u32 supported_cpuidle_states;
 struct pnv_idle_states_t *pnv_idle_states;
 int nr_pnv_idle_states;
+/* Caching the lpcr & ptcr support to use later */
+static bool is_lpcr_self_save;
+static bool is_ptcr_self_save;
+
+struct preferred_sprs {
+	u64 spr;
+	u32 preferred_mode;
+	u32 supported_mode;
+};
+
+struct preferred_sprs preferred_sprs[] = {
+	{
+		.spr = SPRN_HSPRG0,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_LPCR,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_PTCR,
+		.preferred_mode = PREFER_SAVE_RESTORE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_HMEER,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_HID0,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = P9_STOP_SPR_MSR,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = P9_STOP_SPR_PSSCR,
+		.preferred_mode = PREFER_SAVE_RESTORE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_HID1,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_HID4,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	},
+	{
+		.spr = SPRN_HID5,
+		.preferred_mode = PREFER_RESTORE_SAVE,
+		.supported_mode = SELF_RESTORE_STRICT,
+	}
+};
+
+const int nr_preferred_sprs = ARRAY_SIZE(preferred_sprs);
 
 /*
  * The default stop state that will be used by ppc_md.power_save
@@ -61,78 +158,189 @@ static bool deepest_stop_found;
 
 static unsigned long power7_offline_type;
 
-static int pnv_save_sprs_for_deep_states(void)
+static int pnv_self_restore_sprs(u64 pir, int cpu, u64 spr)
 {
-	int cpu;
+	u64 reg_val;
 	int rc;
 
-	/*
-	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric across
-	 * all cpus at boot. Get these reg values of current cpu and use the
-	 * same across all cpus.
-	 */
-	uint64_t lpcr_val	= mfspr(SPRN_LPCR);
-	uint64_t hid0_val	= mfspr(SPRN_HID0);
-	uint64_t hid1_val	= mfspr(SPRN_HID1);
-	uint64_t hid4_val	= mfspr(SPRN_HID4);
-	uint64_t hid5_val	= mfspr(SPRN_HID5);
-	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
-	uint64_t msr_val = MSR_IDLE;
-	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
-
-	for_each_present_cpu(cpu) {
-		uint64_t pir = get_hard_smp_processor_id(cpu);
-		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
-
-		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
+	switch (spr) {
+	case SPRN_HSPRG0:
+		reg_val = (uint64_t)paca_ptrs[cpu];
+		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, reg_val);
 		if (rc != 0)
 			return rc;
-
-		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+		break;
+	case SPRN_LPCR:
+		reg_val = mfspr(SPRN_LPCR);
+		rc = opal_slw_set_reg(pir, SPRN_LPCR, reg_val);
 		if (rc != 0)
 			return rc;
-
+		break;
+	case P9_STOP_SPR_MSR:
+		reg_val = MSR_IDLE;
 		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-			rc = opal_slw_set_reg(pir, P9_STOP_SPR_MSR, msr_val);
+			rc = opal_slw_set_reg(pir, P9_STOP_SPR_MSR, reg_val);
 			if (rc)
 				return rc;
-
-			rc = opal_slw_set_reg(pir,
-					      P9_STOP_SPR_PSSCR, psscr_val);
-
+		}
+		break;
+	case P9_STOP_SPR_PSSCR:
+		reg_val = pnv_deepest_stop_psscr_val;
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, reg_val);
 			if (rc)
 				return rc;
 		}
-
-		/* HIDs are per core registers */
+		break;
+	case SPRN_HMEER:
+		reg_val = mfspr(SPRN_HMEER);
 		if (cpu_thread_in_core(cpu) == 0) {
-
-			rc = opal_slw_set_reg(pir, SPRN_HMEER, hmeer_val);
-			if (rc != 0)
+			rc = opal_slw_set_reg(pir, SPRN_HMEER, reg_val);
+			if (rc)
 				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID0, hid0_val);
-			if (rc != 0)
+		}
+		break;
+	case SPRN_HID0:
+		reg_val = mfspr(SPRN_HID0);
+		if (cpu_thread_in_core(cpu) == 0) {
+			rc = opal_slw_set_reg(pir, SPRN_HID0, reg_val);
+			if (rc)
 				return rc;
+		}
+		break;
+	case SPRN_HID1:
+		reg_val = mfspr(SPRN_HID1);
+		if (cpu_thread_in_core(cpu) == 0 &&
+		    !cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, SPRN_HID1, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	case SPRN_HID4:
+		reg_val = mfspr(SPRN_HID4);
+		if (cpu_thread_in_core(cpu) == 0 &&
+		    !cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, SPRN_HID4, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	case SPRN_HID5:
+		reg_val = mfspr(SPRN_HID5);
+		if (cpu_thread_in_core(cpu) == 0 &&
+		    !cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, SPRN_HID5, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
 
-			/* Only p8 needs to set extra HID regiters */
-			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
-
-				rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
-				if (rc != 0)
-					return rc;
+static int pnv_self_save_restore_sprs(void)
+{
+	int rc, index, cpu, k;
+	u64 pir;
+	struct preferred_sprs curr_spr;
+	bool is_initialized;
+	u32 preferred;
+
+	is_lpcr_self_save = false;
+	is_ptcr_self_save = false;
+	for_each_present_cpu(cpu) {
+		pir = get_hard_smp_processor_id(cpu);
+		for (index = 0; index < nr_preferred_sprs; index++) {
+			curr_spr = preferred_sprs[index];
+			is_initialized = false;
+			/*
+			 * Go through each of the preferences
+			 * Check if it is preferred as well as supported
+			 */
+			for (k = 0; k < NR_PREFERENCES; k++) {
+				preferred = curr_spr.preferred_mode
+						& PREFERENCE_MASK;
+				if (preferred & curr_spr.supported_mode
+				    & SELF_RESTORE_STRICT) {
+					is_initialized = true;
+					rc = pnv_self_restore_sprs(pir, cpu,
+								curr_spr.spr);
+					if (rc != 0)
+						return rc;
+					break;
+				} else if (preferred & curr_spr.supported_mode
+					   & SELF_SAVE_STRICT) {
+					is_initialized = true;
+					if (curr_spr.spr == SPRN_HMEER &&
+					    cpu_thread_in_core(cpu) != 0) {
+						continue;
+					}
+					rc = opal_slw_self_save_reg(pir,
+								curr_spr.spr);
+					if (rc != 0)
+						return rc;
+					switch (curr_spr.spr) {
+					case SPRN_LPCR:
+						is_lpcr_self_save = true;
+						break;
+					case SPRN_PTCR:
+						is_ptcr_self_save = true;
+						break;
+					}
+					break;
+				}
+				preferred_sprs[index].preferred_mode =
+					preferred_sprs[index].preferred_mode >>
+					PREFERENCE_SHIFT;
+				curr_spr = preferred_sprs[index];
+			}
+			if (!is_initialized) {
+				if (preferred_sprs[index].spr == SPRN_PTCR ||
+				    (cpu_has_feature(CPU_FTR_ARCH_300) &&
+				    (preferred_sprs[index].spr == SPRN_HID1 ||
+				     preferred_sprs[index].spr == SPRN_HID4 ||
+				     preferred_sprs[index].spr == SPRN_HID5)))
+					continue;
+				return OPAL_UNSUPPORTED;
+			}
+		}
+	}
+	return 0;
+}
 
-				rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
-				if (rc != 0)
-					return rc;
+static int pnv_save_sprs_for_deep_states(void)
+{
+	int rc;
+	int index;
 
-				rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
-				if (rc != 0)
-					return rc;
-			}
+	/*
+	 * Iterate over the preffered SPRs and if even one of them is
+	 * still unsupported We cut support for deep stop states
+	 */
+	for (index = 0; index < nr_preferred_sprs; index++) {
+		if (preferred_sprs[index].supported_mode == UNSUPPORTED) {
+			if (preferred_sprs[index].spr == SPRN_PTCR ||
+			    (cpu_has_feature(CPU_FTR_ARCH_300) &&
+			    (preferred_sprs[index].spr == SPRN_HID1 ||
+			     preferred_sprs[index].spr == SPRN_HID4 ||
+			     preferred_sprs[index].spr == SPRN_HID5)))
+				continue;
+			return OPAL_UNSUPPORTED;
 		}
 	}
 
+	/*
+	 * Try to self-restore the registers that can be self restored if self
+	 * restore is active, try the same for the registers that
+	 * can be self saved too.
+	 * Note : If both are supported, self restore is given more priority
+	 */
+	rc = pnv_self_save_restore_sprs();
+	if (rc != 0)
+		return rc;
 	return 0;
 }
 
@@ -658,7 +866,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 		mmcr0		= mfspr(SPRN_MMCR0);
 	}
 	if ((psscr & PSSCR_RL_MASK) >= pnv_first_spr_loss_level) {
-		sprs.lpcr	= mfspr(SPRN_LPCR);
+		if (!is_lpcr_self_save)
+			sprs.lpcr	= mfspr(SPRN_LPCR);
 		sprs.hfscr	= mfspr(SPRN_HFSCR);
 		sprs.fscr	= mfspr(SPRN_FSCR);
 		sprs.pid	= mfspr(SPRN_PID);
@@ -672,7 +881,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 		sprs.mmcr1	= mfspr(SPRN_MMCR1);
 		sprs.mmcr2	= mfspr(SPRN_MMCR2);
 
-		sprs.ptcr	= mfspr(SPRN_PTCR);
+		if (!is_ptcr_self_save)
+			sprs.ptcr	= mfspr(SPRN_PTCR);
 		sprs.rpr	= mfspr(SPRN_RPR);
 		sprs.tscr	= mfspr(SPRN_TSCR);
 		if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
@@ -756,7 +966,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 		goto core_woken;
 
 	/* Per-core SPRs */
-	mtspr(SPRN_PTCR,	sprs.ptcr);
+	if (!is_ptcr_self_save)
+		mtspr(SPRN_PTCR,	sprs.ptcr);
 	mtspr(SPRN_RPR,		sprs.rpr);
 	mtspr(SPRN_TSCR,	sprs.tscr);
 
@@ -777,7 +988,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 	atomic_unlock_and_stop_thread_idle();
 
 	/* Per-thread SPRs */
-	mtspr(SPRN_LPCR,	sprs.lpcr);
+	if (!is_lpcr_self_save)
+		mtspr(SPRN_LPCR,	sprs.lpcr);
 	mtspr(SPRN_HFSCR,	sprs.hfscr);
 	mtspr(SPRN_FSCR,	sprs.fscr);
 	mtspr(SPRN_PID,		sprs.pid);
@@ -956,8 +1168,11 @@ void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
 	 * Program the LPCR via stop-api only if the deepest stop state
 	 * can lose hypervisor context.
 	 */
-	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
-		opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT) {
+		if (!is_lpcr_self_save)
+			opal_slw_set_reg(pir, SPRN_LPCR,
+					 lpcr_val);
+	}
 }
 
 /*
-- 
2.24.1

