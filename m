Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272C206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440403AbfIWSQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:16:22 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:22210 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440382AbfIWSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:16:22 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8NI1nWv022787;
        Mon, 23 Sep 2019 18:15:57 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v6q0rkuxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 18:15:57 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 683E54F;
        Mon, 23 Sep 2019 18:15:56 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 997D147;
        Mon, 23 Sep 2019 18:15:55 +0000 (UTC)
Date:   Mon, 23 Sep 2019 13:15:55 -0500
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
Subject: [PATCH v2 2/2] x86/boot/64: round memory hole size up to next PMD
 page.
Message-ID: <b0c6487fdd8ca33daa2ac1604b60fac8ed5b020f.1569004923.git.steve.wahl@hpe.com>
References: <cover.1569004922.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569004922.git.steve.wahl@hpe.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-23_05:2019-09-23,2019-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=2 spamscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909230158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel image map is created using PMD pages, which can include
some extra space beyond what's actually needed.  Round the size of the
memory hole we search for up to the next PMD boundary, to be certain
all of the space to be mapped is usable RAM and includes no reserved
areas.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
  * This patch is completely new to this verison.

 arch/x86/boot/compressed/misc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 53ac0cb2396d..9652d5c2afda 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -345,6 +345,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	unsigned long needed_size;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -379,26 +380,38 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	free_mem_ptr     = heap;	/* Heap */
 	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
 
+	/*
+	 * The memory hole needed for the kernel is the larger of either
+	 * the entire decompressed kernel plus relocation table, or the
+	 * entire decompressed kernel plus .bss and .brk sections.
+	 *
+	 * On X86_64, the memory is mapped with PMD pages. Round the
+	 * size up so that the full extent of PMD pages mapped is
+	 * included in the check against the valid memory table
+	 * entries. This ensures the full mapped area is usable RAM
+	 * and doesn't include any reserved areas.
+	 */
+	needed_size = max(output_len, kernel_total_size);
+#ifdef CONFIG_X86_64
+	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
+#endif
+
 	/* Report initial kernel position details. */
 	debug_putaddr(input_data);
 	debug_putaddr(input_len);
 	debug_putaddr(output);
 	debug_putaddr(output_len);
 	debug_putaddr(kernel_total_size);
+	debug_putaddr(needed_size);
 
 #ifdef CONFIG_X86_64
 	/* Report address of 32-bit trampoline */
 	debug_putaddr(trampoline_32bit);
 #endif
 
-	/*
-	 * The memory hole needed for the kernel is the larger of either
-	 * the entire decompressed kernel plus relocation table, or the
-	 * entire decompressed kernel plus .bss and .brk sections.
-	 */
 	choose_random_location((unsigned long)input_data, input_len,
 				(unsigned long *)&output,
-				max(output_len, kernel_total_size),
+				needed_size,
 				&virt_addr);
 
 	/* Validate memory location choices. */
-- 
2.21.0


-- 
Steve Wahl, Hewlett Packard Enterprise
