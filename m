Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8807C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827922070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391501AbfIFVaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:30:19 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:14880 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732110AbfIFVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:30:19 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86LLWG7001882;
        Fri, 6 Sep 2019 21:29:53 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uukmh52pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 21:29:53 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id D92C366;
        Fri,  6 Sep 2019 21:29:52 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 512164C;
        Fri,  6 Sep 2019 21:29:50 +0000 (UTC)
Date:   Fri, 6 Sep 2019 16:29:50 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org
Cc:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid outside
 kernel area.
Message-ID: <20190906212950.GA7792@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_09:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909060217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our hardware (UV aka Superdome Flex) has address ranges marked
reserved by the BIOS. These ranges can cause the system to halt if
accessed.

During kernel initialization, the processor was speculating into
reserved memory causing system halts.  The processor speculation is
enabled because the reserved memory is being mapped by the kernel.

The page table level2_kernel_pgt is 1 GiB in size, and had all pages
initially marked as valid, and the kernel is placed anywhere in this
range depending on the virtual address selected by KASLR.  Later on in
the boot process, the valid area gets trimmed back to the space
occupied by the kernel.

But during the interval of time when the full 1 GiB space was marked
as valid, if the kernel physical address chosen by KASLR was close
enough to our reserved memory regions, the valid pages outside the
actual kernel space were allowing the processor to issue speculative
accesses to the reserved space, causing the system to halt.

This was encountered somewhat rarely on a normal system boot, and
somewhat more often when starting the crash kernel if
"crashkernel=512M,high" was specified on the command line (because
this heavily restricts the physical address of the crash kernel,
usually to within 1 GiB of our reserved space).

The answer is to invalidate the pages of this table outside the
address range occupied by the kernel before the page table is
activated.  This patch has been validated to fix this problem on our
hardware.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/head64.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29ffa495bd1c..31f89a5defa3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -225,10 +225,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
-	for (i = 0; i < PTRS_PER_PMD; i++) {
+	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	for (; i <= pmd_index((unsigned long)_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
-	}
+
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
 
 	/*
 	 * Fixup phys_base - remove the memory encryption mask to obtain
-- 
2.21.0


-- 
Steve Wahl, Hewlett Packard Enterprise
