Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691DAC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6A322C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564047047;
	bh=YLT7mc7uWZHnVWRAOXEA35kXHXVmPx8BUd1T5sThOCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJ4TenSREyjpcMMsbgbFA49usKsnZoI3NVe+aArx2yd+p+nu2SSARYyOZQRkMssSM
	 rzQWCagrGLWsZ00/qWdNk+Gtlu+njF3wH0kRuVqu19jM5ysnKOZOC7jMaTfTId/YVL
	 FOY8FB6enaxn0b6OWBylCc4oJXxTZDZMhIYo5TU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfGYJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfGYJap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:30:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925062238C;
        Thu, 25 Jul 2019 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564047044;
        bh=YLT7mc7uWZHnVWRAOXEA35kXHXVmPx8BUd1T5sThOCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rypn7it8Rf260lh0cGgrtQiQ283OFmqpG1lxyuto4Y7QYQbzn6ruYk8uV6NiK7D/f
         hnNYlr/9QmLq6CPAhKWzSsjmkJC+PNqJTbRH4mEjG8OcRYMPfYeyOTSoxzgJPBd94M
         9AMwOACsNIfinxPFc3YYJSq3Hk2TY45ShQWw/bTk=
Date:   Thu, 25 Jul 2019 10:30:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v9 00/21] Generic page walk and ptdump
Message-ID: <20190725093036.dzn6uulcihhkohm2@willie-the-truck>
References: <20190722154210.42799-1-steven.price@arm.com>
 <835a0f2e-328d-7f7f-e52a-b754137789f9@arm.com>
 <c9d2042f-c731-4705-4148-b38deccf7963@arm.com>
 <6f59521e-1f3e-6765-9a6f-c8eca4c0c154@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f59521e-1f3e-6765-9a6f-c8eca4c0c154@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 02:39:22PM +0530, Anshuman Khandual wrote:
> On 07/24/2019 07:05 PM, Steven Price wrote:
> > There isn't any problem as such with using p?d_large macros. However the
> > name "large" has caused confusion in the past. In particular there are
> > two types of "large" page:
> > 
> > 1. leaf entries at high levels than normal ('sections' on Arm, for 4K
> > pages this gives you 2MB and 1GB pages).
> > 
> > 2. sets of contiguous entries that can share a TLB entry (the
> > 'Contiguous bit' on Arm - which for 4K pages gives you 16 entries = 64
> > KB 'pages').
> 
> This is arm64 specific and AFAIK there are no other architectures where there
> will be any confusion wrt p?d_large() not meaning a single entry.
> 
> As you have noted before if we are printing individual entries with PTE_CONT
> then they need not be identified as p??d_large(). In which case p?d_large()
> can just safely point to p?d_sect() identifying regular huge leaf entries.

Steven's stuck in the middle of things here, but I do object to p?d_large()
because I find it bonkers to have p?d_large() and p?d_huge() mean completely
different things when they are synonyms in the English language.

Yes, p?d_leaf() matches the terminology used by the Arm architecture, but
given that most page table structures are arranged as a 'tree', then it's
not completely unreasonable, in my opinion. If you have a more descriptive
name, we could use that instead. We could also paint it blue.

> > In many cases both give the same effect (reduce pressure on TLBs and
> > requires contiguous and aligned physical addresses). But for this case
> > we only care about the 'leaf' case (because the contiguous bit makes no
> > difference to walking the page tables).
> 
> Right and we can just safely identify section entries with it. What will be
> the problem with that ? Again this is only arm64 specific.
> 
> > 
> > As far as I'm aware p?d_large() currently implements the first and
> > p?d_(trans_)huge() implements either 1 or 2 depending on the architecture.
> 
> AFAIK option 2 exists only on arm6 platform. IIUC generic MM requires two
> different huge page dentition from platform. HugeTLB identifies large entries
> at PGD|PUD|PMD after converting it's content into PTE first. So there is no
> need for direct large page definitions for other levels.
> 
> 1. THP		- pmd_trans_huge()
> 2. HugeTLB	- pte_huge()	   CONFIG_ARCH_WANT_GENERAL_HUGETLB is set
> 
> A simple check for p?d_large() on mm/ and include/linux shows that there are
> no existing usage for these in generic MM. Hence it is available.

Alternatively, it means we have a good opportunity to give it a better name
before it spreads into the core code.

> IMHO the new addition of p?d_leaf() can be avoided and p?d_large() should be
> cleaned up (if required) in platforms and used in generic functions.

Again, I disagree and think p?d_large() should be confined to arch code
if it sticks around at all.

I don't usually care much about naming, but in this case I really find
the status quo needlessly confusing.

Will
