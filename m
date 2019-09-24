Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0056CC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85A620872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389660AbfIXQdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:33:14 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20946 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388583AbfIXQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:33:13 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OGLFif017394;
        Tue, 24 Sep 2019 16:32:39 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v7kskucdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 16:32:38 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id E48254F;
        Tue, 24 Sep 2019 16:32:37 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id B50194B;
        Tue, 24 Sep 2019 16:32:36 +0000 (UTC)
Date:   Tue, 24 Sep 2019 11:32:36 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     hpa@zytor.com
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/2] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190924163236.GA8138@swahl-linux>
References: <cover.1569004922.git.steve.wahl@hpe.com>
 <51b87d62e0cade3c46a69706b9be249190abc7bd.1569004923.git.steve.wahl@hpe.com>
 <75F03666-AB27-4C72-B3FF-67B1C7BE8575@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75F03666-AB27-4C72-B3FF-67B1C7BE8575@zytor.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_07:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=1 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909240148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:49:44AM -0700, hpa@zytor.com wrote:
> On September 23, 2019 11:15:20 AM PDT, Steve Wahl <steve.wahl@hpe.com> wrote:
> >Our hardware (UV aka Superdome Flex) has address ranges marked
> >reserved by the BIOS. Access to these ranges is caught as an error,
> >causing the BIOS to halt the system.
> >
> >Initial page tables mapped a large range of physical addresses that
> >were not checked against the list of BIOS reserved addresses, and
> >sometimes included reserved addresses in part of the mapped range.
> >Including the reserved range in the map allowed processor speculative
> >accesses to the reserved range, triggering a BIOS halt.
> >
> >Used early in booting, the page table level2_kernel_pgt addresses 1
> >GiB divided into 2 MiB pages, and it was set up to linearly map a full
> >1 GiB of physical addresses that included the physical address range
> >of the kernel image, as chosen by KASLR.  But this also included a
> >large range of unused addresses on either side of the kernel image.
> >And unlike the kernel image's physical address range, this extra
> >mapped space was not checked against the BIOS tables of usable RAM
> >addresses.  So there were times when the addresses chosen by KASLR
> >would result in processor accessible mappings of BIOS reserved
> >physical addresses.
> >
> >The kernel code did not directly access any of this extra mapped
> >space, but having it mapped allowed the processor to issue speculative
> >accesses into reserved memory, causing system halts.
> >
> >This was encountered somewhat rarely on a normal system boot, and much
> >more often when starting the crash kernel if "crashkernel=512M,high"
> >was specified on the command line (this heavily restricts the physical
> >address of the crash kernel, in our case usually within 1 GiB of
> >reserved space).
> >
> >The solution is to invalidate the pages of this table outside the
> >kernel image's space before the page table is activated.  This patch
> >has been validated to fix this problem on our hardware.
> >
> >Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> >Cc: stable@vger.kernel.org
> >---
> >Changes since v1:
> >  * Added comment.
> >  * Reworked changelog text.
> >
> > arch/x86/kernel/head64.c | 18 ++++++++++++++++--
> > 1 file changed, 16 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> >index 29ffa495bd1c..ee9d0e3e0c46 100644
> >--- a/arch/x86/kernel/head64.c
> >+++ b/arch/x86/kernel/head64.c
> >@@ -222,13 +222,27 @@ unsigned long __head __startup_64(unsigned long
> >physaddr,
> > 	 * we might write invalid pmds, when the kernel is relocated
> > 	 * cleanup_highmap() fixes this up along with the mappings
> > 	 * beyond _end.
> >+	 *
> >+	 * Only the region occupied by the kernel image has so far
> >+	 * been checked against the table of usable memory regions
> >+	 * provided by the firmware, so invalidate pages outside that
> >+	 * region.  A page table entry that maps to a reserved area of
> >+	 * memory would allow processor speculation into that area,
> >+	 * and on some hardware (particularly the UV platform) even
> >+	 * speculative access to some reserved areas is caught as an
> >+	 * error, causing the BIOS to halt the system.
> > 	 */
> > 
> > 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
> >-	for (i = 0; i < PTRS_PER_PMD; i++) {
> >+	for (i = 0; i < pmd_index((unsigned long)_text); i++)
> >+		pmd[i] &= ~_PAGE_PRESENT;
> >+
> >+	for (; i <= pmd_index((unsigned long)_end); i++)
> > 		if (pmd[i] & _PAGE_PRESENT)
> > 			pmd[i] += load_delta;
> >-	}
> >+
> >+	for (; i < PTRS_PER_PMD; i++)
> >+		pmd[i] &= ~_PAGE_PRESENT;
> > 
> > 	/*
> > 	 * Fixup phys_base - remove the memory encryption mask to obtain
> 
> What does your MTRR setup look like, and what memory map do you
> present, in exact detail?

We set the MTRR default to writeback cacheable, and then use variable
MTRRs to mark certain parts of the address map as uncacheable.  The
uncacheable regions are at the top of the address map (AEP mailboxes,
PCIe config segments other than segment zero, MMRs, 64-bit MMIO) and
from 2GB to 4GB.  There are also uncacheable ranges below 1MB
controlled by the fixed MTRRs.

Details from the e820 map:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000005efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000005f000-0x000000000005ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000060000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000072c4dfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000072c4e000-0x0000000073a2ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000073a30000-0x000000007445ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000074460000-0x000000007599ffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000759a0000-0x0000000075aecfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075aed000-0x0000000075aedfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000075aee000-0x0000000075b09fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075b0a000-0x0000000075d49fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000075d4a000-0x0000000079201fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079202000-0x0000000079202fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000079203000-0x000000007bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007c000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002f7fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000002f80000000-0x000000303fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x0000003040000000-0x0000005f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000005f7c000000-0x000000603fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x0000006040000000-0x0000008f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000008f7c000000-0x000000903fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x0000009040000000-0x000000bf7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000bf7c000000-0x000000c03fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x000000c040000000-0x000000ef7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000ef7c000000-0x000000f03fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x000000f040000000-0x0000011f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000011f7c000000-0x000001203fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x0000012040000000-0x0000014f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000014f7c000000-0x000001503fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x0000015040000000-0x0000017f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000017f7c000000-0x000001803fffffff] reserved *
[    0.000000] BIOS-e820: [mem 0x00000fff00000000-0x00000fff0fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff10000000-0x00000fff1fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff20000000-0x00000fff2fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff30000000-0x00000fff3fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff40000000-0x00000fff4fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff50000000-0x00000fff5fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff60000000-0x00000fff6fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fff70000000-0x00000fff7fefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffa0000000-0x00000fffa2ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffa4000000-0x00000fffa6ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffa8000000-0x00000fffaaffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffac000000-0x00000fffaeffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffb0000000-0x00000fffb2ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffb4000000-0x00000fffb6ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffb8000000-0x00000fffbaffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000fffbc000000-0x00000fffbeffffff] reserved

I've added asterisks after the entries that represent the reserved
areas that weren't being respected.  This map is from a relatively
small system.  The number of these reserved areas and their size vary
based on the number of NUMA nodes and, if I remember correctly, the
amount of memory in each node as well.

> The BIOS is normally expected to mark the relevant ranges as UC in
> the MTRRs (that is the remaining, legitimate usage of MTRRs.)

The MTRRs do not scale for this purpose; there are not enough of them
left over to handle a reserved area for each of the NUMA nodes in a
fully configured system.  Also, the pieces we reserve do not usually
follow the alignment requirements of the MTRRs, so using them would
require tossing out a good deal of usable memory.

> I'm somewhat sceptical that chopping off potentially several
> megabytes is a good thing.

I think you may be misreading what the patches do.  They do not change
any allocation of memory, only (1) reduce the valid area of the page
tables used for early mapping of the kernel image down to the
addresses actually occupied by the kernel image (to the granularity of
2MB PMD pages, anyway), and (2) ensure that KASLR doesn't place the
kernel image where the last 2MB page used to map it would also cross a
reserved space boundary (and therefore include some BIOS reserved space
in the mapped region).

If I missed something and I am actually chopping off a bunch of
memory, please let me know.

Later refinement of the page tables set up in early boot has not
changed.

> We also have the memory type interfaces which can be used to map
> these as UC in the page tables.

Those are set up much later, this problem is very early in booting. As
far as I have seen, all of the later code that sets up memory respects
the EFI and/or E820 tables the BIOS passes in.  This early boot code
did not, and left a small window where the reserved addresses get
mapped and cause problems.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
