Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9163820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfCDTGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:06:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:6293 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfCDTGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:06:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 11:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="128940141"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga008.fm.intel.com with ESMTP; 04 Mar 2019 11:06:37 -0800
Date:   Mon, 4 Mar 2019 11:06:37 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Steven Price <steven.price@arm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <Mark.Rutland@arm.com>,
        linux-ia64@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 08/34] ia64: mm: Add p?d_large() definitions
Message-ID: <20190304190637.GA13947@agluck-desk>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-9-steven.price@arm.com>
 <20190301215728.nk7466zohdlgelcb@kshutemo-mobl1>
 <15100043-26e4-2ee1-28fe-101e12f74926@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15100043-26e4-2ee1-28fe-101e12f74926@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 01:16:47PM +0000, Steven Price wrote:
> On 01/03/2019 21:57, Kirill A. Shutemov wrote:
> > On Wed, Feb 27, 2019 at 05:05:42PM +0000, Steven Price wrote:
> >> walk_page_range() is going to be allowed to walk page tables other than
> >> those of user space. For this it needs to know when it has reached a
> >> 'leaf' entry in the page tables. This information is provided by the
> >> p?d_large() functions/macros.
> >>
> >> For ia64 leaf entries are always at the lowest level, so implement
> >> stubs returning 0.
> > 
> > Are you sure about this? I see pte_mkhuge defined for ia64 and Kconfig
> > contains hugetlb references.
> > 
> 
> I'm not completely familiar with ia64, but my understanding is that it
> doesn't have the situation where a page table walk ends early - there is
> always the full depth of entries. The p?d_huge() functions always return 0.
> 
> However my understanding is that it does support huge TLB entries, so
> when populating the TLB a region larger than a standard page can be mapped.
> 
> I'd definitely welcome review by someone more familiar with ia64 to
> check my assumptions.

ia64 has several ways to manage page tables. The one
used by Linux has multi-level table walks like other
architectures, but we don't allow mixing of different
page sizes within a "region" (there are eight regions
selected by the high 3 bits of the virtual address).

Is the series in some GIT tree that I can pull, rather
than tracking down all 34 pieces?  I can try it out and
see if things work/break.

-Tony
