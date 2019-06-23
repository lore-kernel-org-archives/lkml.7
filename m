Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB1C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BABE204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFWL2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:28:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:28:08 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf0ez-0008GA-S6; Sun, 23 Jun 2019 13:27:50 +0200
Date:   Sun, 23 Jun 2019 13:27:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Kyle Pelton <kyle.d.pelton@intel.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/mm: Handle physical-virtual alignment mismatch in
 phys_p4d_init()
In-Reply-To: <20190620231547.dkefu73blzte32wq@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.1906231322020.32342@nanos.tec.linutronix.de>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com> <4ecd0603-e847-1cae-bafa-e892d79b7259@intel.com> <20190620231547.dkefu73blzte32wq@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Kirill A. Shutemov wrote:
> On Thu, Jun 20, 2019 at 02:42:55PM +0000, Dave Hansen wrote:
> > On 6/20/19 4:22 AM, Kirill A. Shutemov wrote:
> > > The commit relaxes KASLR alignment requirements and it can lead to
> > > mismatch bentween 'i' and 'p4d_index(vaddr)' inside the loop in
> > > phys_p4d_init(). The mismatch in its turn leads to clearing wrong p4d
> > > entry and eventually to the oops.
> > 
> > Just curious, but what does it relax the requirement to and from?
> > 
> > I'm just not clearly spotting the actual bug.
> 
> Before the commit PAGE_OFFSET is always aligned to P4D_SIZE if we boot in
> 5-level paging mode. But now only PUD_SIZE alignment is guaranteed.
> 
> For phys_p4d_init() it means that paddr_next after the first iteration
> can belong to the same p4d entry.
> 
> In the case I was able to reproduce the vaddr on the first iteration is
> 0xff4228027fe00000 and paddr is 0x33fe00000. On the second iteration vaddr
> becomes 0xff42287f40000000 and paddr is 0x8000000000. The vaddr in both
> cases bolong to the same p4d entry.
> 
> It screws up 'i' count: we miss the last entry in the page table
> completely.  And it confuses the branch under 'paddr >= paddr_end'
> condition: the p4d entry can be cleared where must not to.
> 
> The patch makes phys_p4d_init() work like __kernel_physical_mapping_init()
> which deals with phys-virt mismatch already.
> 
> I hope this explanation makes any sense :P

Yes, and it should have been in the changelog right away. It's much more
useful than the 63 lines of untrimmed backtrace noise, which should be
condensed to the real valuable information:

  WARNING: CPU: 0 PID: 0 at arch/x86/mm/init_64.c:87 phys_p4d_init+0x1d4/0x1ea
  RIP: 0010:phys_p4d_init+0x1d4/0x1ea
  Call Trace:
   __kernel_physical_mapping_init+0x10a/0x35c
   kernel_physical_mapping_init+0xe/0x10
   init_memory_mapping+0x1aa/0x3b0
   init_range_memory_mapping+0xc8/0x116
   init_mem_mapping+0x225/0x2eb
   setup_arch+0x6ff/0xcf5
   start_kernel+0x64/0x53b
   ? copy_bootdata+0x1f/0xce
   x86_64_start_reservations+0x24/0x26
   x86_64_start_kernel+0x8a/0x8d
   secondary_startup_64+0xb6/0xc0

which causes later:

  BUG: unable to handle page fault for address: ff484d019580eff8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  BAD
  Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:fill_pud+0x13/0x130
  Call Trace:
   set_pte_vaddr_p4d+0x2e/0x50
   set_pte_vaddr+0x6f/0xb0
   __native_set_fixmap+0x28/0x40
   native_set_fixmap+0x39/0x70
   register_lapic_address+0x49/0xb6
   early_acpi_boot_init+0xa5/0xde
   setup_arch+0x944/0xcf5
   start_kernel+0x64/0x53b

Hmm?

Thanks,

	tglx

