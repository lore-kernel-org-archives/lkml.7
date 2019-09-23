Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12846C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AE520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440315AbfIWSPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:15:41 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:23926 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394280AbfIWSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:15:40 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8NI1klJ006535;
        Mon, 23 Sep 2019 18:15:22 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2v72ny8fux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 18:15:22 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 322709A;
        Mon, 23 Sep 2019 18:15:21 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 67BEF4E;
        Mon, 23 Sep 2019 18:15:20 +0000 (UTC)
Date:   Mon, 23 Sep 2019 13:15:20 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: [PATCH v2 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <51b87d62e0cade3c46a69706b9be249190abc7bd.1569004923.git.steve.wahl@hpe.com>
References: <cover.1569004922.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569004922.git.steve.wahl@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-23_05:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909230158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our hardware (UV aka Superdome Flex) has address ranges marked
reserved by the BIOS. Access to these ranges is caught as an error,
causing the BIOS to halt the system.

Initial page tables mapped a large range of physical addresses that
were not checked against the list of BIOS reserved addresses, and
sometimes included reserved addresses in part of the mapped range.
Including the reserved range in the map allowed processor speculative
accesses to the reserved range, triggering a BIOS halt.

Used early in booting, the page table level2_kernel_pgt addresses 1
GiB divided into 2 MiB pages, and it was set up to linearly map a full
1 GiB of physical addresses that included the physical address range
of the kernel image, as chosen by KASLR.  But this also included a
large range of unused addresses on either side of the kernel image.
And unlike the kernel image's physical address range, this extra
mapped space was not checked against the BIOS tables of usable RAM
addresses.  So there were times when the addresses chosen by KASLR
would result in processor accessible mappings of BIOS reserved
physical addresses.

The kernel code did not directly access any of this extra mapped
space, but having it mapped allowed the processor to issue speculative
accesses into reserved memory, causing system halts.

This was encountered somewhat rarely on a normal system boot, and much
more often when starting the crash kernel if "crashkernel=512M,high"
was specified on the command line (this heavily restricts the physical
address of the crash kernel, in our case usually within 1 GiB of
reserved space).

The solution is to invalidate the pages of this table outside the
kernel image's space before the page table is activated.  This patch
has been validated to fix this problem on our hardware.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
  * Added comment.
  * Reworked changelog text.

 arch/x86/kernel/head64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29ffa495bd1c..ee9d0e3e0c46 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -222,13 +222,27 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * we might write invalid pmds, when the kernel is relocated
 	 * cleanup_highmap() fixes this up along with the mappings
 	 * beyond _end.
+	 *
+	 * Only the region occupied by the kernel image has so far
+	 * been checked against the table of usable memory regions
+	 * provided by the firmware, so invalidate pages outside that
+	 * region.  A page table entry that maps to a reserved area of
+	 * memory would allow processor speculation into that area,
+	 * and on some hardware (particularly the UV platform) even
+	 * speculative access to some reserved areas is caught as an
+	 * error, causing the BIOS to halt the system.
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
