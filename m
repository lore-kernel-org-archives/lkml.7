Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E841420675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLDJdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:33:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726632AbfLDJdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:33:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB49VrMo134776
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 04:33:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wkrj6pu9r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 04:33:41 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Wed, 4 Dec 2019 09:33:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Dec 2019 09:33:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB49X5Xv27918376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 09:33:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7616A4064;
        Wed,  4 Dec 2019 09:33:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE422A405B;
        Wed,  4 Dec 2019 09:33:02 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.83.83])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 09:33:02 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        linuxram@us.ibm.com, psampat@linux.ibm.com,
        pratik.sampat@in.ibm.com
Subject: [RFC 2/3] powerpc/powernv: Introduce Self save support
Date:   Wed,  4 Dec 2019 15:02:54 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191204093255.11849-1-psampat@linux.ibm.com>
References: <20191204093255.11849-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120409-0008-0000-0000-0000033CDDC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120409-0009-0000-0000-00004A5BFC48
Message-Id: <20191204093255.11849-3-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_02:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=909 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces and leverages the Self save API which OPAL now
supports.

Add the new Self Save OPAL API call in the list of OPAL calls.
Implement the self saving of the SPRs based on the support populated
while respecting it's preferences.

This implementation allows mixing of support for the SPRs, which
means that a SPR can be self restored while another SPR be self saved if
they support and prefer it to be so.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h        | 3 ++-
 arch/powerpc/include/asm/opal.h            | 1 +
 arch/powerpc/platforms/powernv/idle.c      | 2 ++
 arch/powerpc/platforms/powernv/opal-call.c | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index c1f25a760eb1..89b7c44124e6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -214,7 +214,8 @@
 #define OPAL_SECVAR_GET				176
 #define OPAL_SECVAR_GET_NEXT			177
 #define OPAL_SECVAR_ENQUEUE_UPDATE		178
-#define OPAL_LAST				178
+#define OPAL_SLW_SELF_SAVE_REG			179
+#define OPAL_LAST				179
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9986ac34b8e2..389a85b63805 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -203,6 +203,7 @@ int64_t opal_handle_hmi(void);
 int64_t opal_handle_hmi2(__be64 *out_flags);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
+int64_t opal_slw_self_save_reg(uint64_t cpu_pir, uint64_t sprn);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
 int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
 int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index d38b8b6dcbce..e33bb3fd88ac 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -1170,6 +1170,8 @@ void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
 		if (!is_lpcr_self_save)
 			opal_slw_set_reg(pir, SPRN_LPCR,
 					 lpcr_val);
+		else
+			opal_slw_self_save_reg(pir, SPRN_LPCR);
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 5cd0f52d258f..11e0ceb90de0 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -223,6 +223,7 @@ OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
 OPAL_CALL(opal_handle_hmi2,			OPAL_HANDLE_HMI2);
 OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
+OPAL_CALL(opal_slw_self_save_reg,		OPAL_SLW_SELF_SAVE_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
 OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
-- 
2.21.0

