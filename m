Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE48C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FED22CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfHTCOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:14:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729071AbfHTCOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:14:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7K2D4i3081047
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 22:14:28 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug2uu1tsc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 22:14:28 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 20 Aug 2019 03:14:28 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 03:14:24 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7K2ENfZ27328852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 02:14:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F5D5C6057;
        Tue, 20 Aug 2019 02:14:23 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B73FAC605A;
        Tue, 20 Aug 2019 02:14:19 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.85.220.248])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 02:14:19 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v4 10/16] powerpc/pseries/svm: Unshare all pages before kexecing a new kernel
Date:   Mon, 19 Aug 2019 23:13:20 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820021326.6884-1-bauerman@linux.ibm.com>
References: <20190820021326.6884-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082002-0012-0000-0000-0000175D2AA0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011621; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249321; UDB=6.00659504; IPR=6.01030858;
 MB=3.00028240; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-20 02:14:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082002-0013-0000-0000-0000588B06C1
Message-Id: <20190820021326.6884-11-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

A new kernel deserves a clean slate. Any pages shared with the hypervisor
is unshared before invoking the new kernel. However there are exceptions.
If the new kernel is invoked to dump the current kernel, or if there is a
explicit request to preserve the state of the current kernel, unsharing
of pages is skipped.

NOTE: While testing crashkernel, make sure at least 256M is reserved for
crashkernel. Otherwise SWIOTLB allocation will fail and crash kernel will
fail to boot.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/ultravisor-api.h | 1 +
 arch/powerpc/include/asm/ultravisor.h     | 5 +++++
 arch/powerpc/kernel/machine_kexec_64.c    | 9 +++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/ultravisor-api.h b/arch/powerpc/include/asm/ultravisor-api.h
index 142b0576b89f..7e69c364bde0 100644
--- a/arch/powerpc/include/asm/ultravisor-api.h
+++ b/arch/powerpc/include/asm/ultravisor-api.h
@@ -24,5 +24,6 @@
 #define UV_ESM				0xF110
 #define UV_SHARE_PAGE			0xF130
 #define UV_UNSHARE_PAGE			0xF134
+#define UV_UNSHARE_ALL_PAGES		0xF140
 
 #endif /* _ASM_POWERPC_ULTRAVISOR_API_H */
diff --git a/arch/powerpc/include/asm/ultravisor.h b/arch/powerpc/include/asm/ultravisor.h
index a930aec8c1e3..e6f8a2b96694 100644
--- a/arch/powerpc/include/asm/ultravisor.h
+++ b/arch/powerpc/include/asm/ultravisor.h
@@ -21,4 +21,9 @@ static inline int uv_unshare_page(u64 pfn, u64 npages)
 	return ucall_norets(UV_UNSHARE_PAGE, pfn, npages);
 }
 
+static inline int uv_unshare_all_pages(void)
+{
+	return ucall_norets(UV_UNSHARE_ALL_PAGES);
+}
+
 #endif	/* _ASM_POWERPC_ULTRAVISOR_H */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 18481b0e2788..04a7cba58eff 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -29,6 +29,8 @@
 #include <asm/smp.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/asm-prototypes.h>
+#include <asm/svm.h>
+#include <asm/ultravisor.h>
 
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -327,6 +329,13 @@ void default_machine_kexec(struct kimage *image)
 #ifdef CONFIG_PPC_PSERIES
 	kexec_paca.lppaca_ptr = NULL;
 #endif
+
+	if (is_secure_guest() && !(image->preserve_context ||
+				   image->type == KEXEC_TYPE_CRASH)) {
+		uv_unshare_all_pages();
+		printk("kexec: Unshared all shared pages.\n");
+	}
+
 	paca_ptrs[kexec_paca.paca_index] = &kexec_paca;
 
 	setup_paca(&kexec_paca);

