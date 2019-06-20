Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA12082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfFTXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:15:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:54442 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTXPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:15:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 16:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="186977287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2019 16:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7438114B; Fri, 21 Jun 2019 02:15:47 +0300 (EEST)
Date:   Fri, 21 Jun 2019 02:15:47 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20190620231547.dkefu73blzte32wq@black.fi.intel.com>
References: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
 <4ecd0603-e847-1cae-bafa-e892d79b7259@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ecd0603-e847-1cae-bafa-e892d79b7259@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:42:55PM +0000, Dave Hansen wrote:
> On 6/20/19 4:22 AM, Kirill A. Shutemov wrote:
> > The commit relaxes KASLR alignment requirements and it can lead to
> > mismatch bentween 'i' and 'p4d_index(vaddr)' inside the loop in
> > phys_p4d_init(). The mismatch in its turn leads to clearing wrong p4d
> > entry and eventually to the oops.
> 
> Just curious, but what does it relax the requirement to and from?
> 
> I'm just not clearly spotting the actual bug.

Before the commit PAGE_OFFSET is always aligned to P4D_SIZE if we boot in
5-level paging mode. But now only PUD_SIZE alignment is guaranteed.

For phys_p4d_init() it means that paddr_next after the first iteration
can belong to the same p4d entry.

In the case I was able to reproduce the vaddr on the first iteration is
0xff4228027fe00000 and paddr is 0x33fe00000. On the second iteration vaddr
becomes 0xff42287f40000000 and paddr is 0x8000000000. The vaddr in both
cases bolong to the same p4d entry.

It screws up 'i' count: we miss the last entry in the page table
completely.  And it confuses the branch under 'paddr >= paddr_end'
condition: the p4d entry can be cleared where must not to.

The patch makes phys_p4d_init() work like __kernel_physical_mapping_init()
which deals with phys-virt mismatch already.

I hope this explanation makes any sense :P

-- 
 Kirill A. Shutemov
