Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734C9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633517AbfIXVEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:04:12 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:4570 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633506AbfIXVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:04:12 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OKv2he024787;
        Tue, 24 Sep 2019 21:03:58 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 2v7qkdjy74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 21:03:58 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 13FBA59;
        Tue, 24 Sep 2019 21:03:57 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id DE0CE50;
        Tue, 24 Sep 2019 21:03:55 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:03:55 -0500
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
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: [PATCH v3 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <9c011ee51b081534a7a15065b1681d200298b530.1569358539.git.steve.wahl@hpe.com>
References: <cover.1569358538.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569358538.git.steve.wahl@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_10:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909240169
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
Changes since v2:
  * Added further inline comments.
 arch/x86/kernel/head64.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29ffa495bd1c..282054025dcf 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -222,13 +222,31 @@ unsigned long __head __startup_64(unsigned long physaddr,
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
+
+	/* invalidate pages before the kernel image */
+	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+		pmd[i] &= ~_PAGE_PRESENT;
+
+	/* fixup pages that are part of the kernel image */
+	for (; i <= pmd_index((unsigned long)_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
-	}
+
+	/* invalidate pages after the kernel image */
+	for (; i < PTRS_PER_PMD; i++)
+		pmd[i] &= ~_PAGE_PRESENT;
 
 	/*
 	 * Fixup phys_base - remove the memory encryption mask to obtain
-- 
2.21.0


-- 
Steve Wahl, Hewlett Packard Enterprise
