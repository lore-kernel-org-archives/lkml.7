Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A31C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CC72175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfFMPO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:14:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:49413 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbfFMPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:14:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 08:14:22 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Jun 2019 08:14:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CC735159; Thu, 13 Jun 2019 18:14:17 +0300 (EEST)
Date:   Thu, 13 Jun 2019 18:14:17 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190613151417.7cjxwudjssl5h2pf@black.fi.intel.com>
References: <20190612220320.2223898-1-songliubraving@fb.com>
 <20190612220320.2223898-4-songliubraving@fb.com>
 <20190613125718.tgplv5iqkbfhn6vh@box>
 <5A80A2B9-51C3-49C4-97B6-33889CC47F08@fb.com>
 <20190613141615.yvmckzi3fac4qjag@box>
 <32E15B93-24B9-4DBB-BDD4-DDD8537C7CE0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32E15B93-24B9-4DBB-BDD4-DDD8537C7CE0@fb.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:03:01PM +0000, Song Liu wrote:
> 
> 
> > On Jun 13, 2019, at 7:16 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Thu, Jun 13, 2019 at 01:57:30PM +0000, Song Liu wrote:
> >>> And I'm not convinced that it belongs here at all. User requested PMD
> >>> split and it is done after split_huge_pmd(). The rest can be handled by
> >>> the caller as needed.
> >> 
> >> I put this part here because split_huge_pmd() for file-backed THP is
> >> not really done after split_huge_pmd(). And I would like it done before
> >> calling follow_page_pte() below. Maybe we can still do them here, just 
> >> for file-backed THPs?
> >> 
> >> If we would move it, shall we move to callers of follow_page_mask()? 
> >> In that case, we will probably end up with similar code in two places:
> >> __get_user_pages() and follow_page(). 
> >> 
> >> Did I get this right?
> > 
> > Would it be enough to replace pte_offset_map_lock() in follow_page_pte()
> > with pte_alloc_map_lock()?
> 
> This is similar to my previous version:
> 
> +		} else {  /* flags & FOLL_SPLIT_PMD */
> +			pte_t *pte;
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, address);
> +			pte = get_locked_pte(mm, address, &ptl);
> +			if (!pte)
> +				return no_page_table(vma, flags);
> +			spin_unlock(ptl);
> +			ret = 0;
> +		}
> 
> I think this is cleaner than use pte_alloc_map_lock() in follow_page_pte(). 
> What's your thought on these two versions (^^^ vs. pte_alloc_map_lock)?

It's additional lock-unlock cycle and few more lines of code...

> > This will leave bunch not populated PTE entries, but it is fine: they will
> > be populated on the next access to them.
> 
> We need to handle page fault during next access, right? Since we already
> allocated everything, we can just populate the PTE entries and saves a
> lot of page faults (assuming we will access them later). 

Not a lot due to faultaround and they may never happen, but you need to
tear down the mapping any way.

-- 
 Kirill A. Shutemov
