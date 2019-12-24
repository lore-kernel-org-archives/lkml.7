Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34791C2D0C0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068E92070E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLXB4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:56:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:23701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfLXB4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:56:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 17:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,349,1571727600"; 
   d="scan'208";a="211727785"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2019 17:56:02 -0800
Date:   Tue, 24 Dec 2019 09:56:02 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20191224015602.GB7739@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20191223231120.GA31820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223231120.GA31820@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 03:11:20PM -0800, Matthew Wilcox wrote:
>On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
>> When page is not NULL, function is called by try_to_unmap_one() with
>> TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
>> with TTU_SPLIT_HUGE_PMD set:
>> 
>>   * unmap_page()
>>   * shrink_page_list()
>> 
>> In both case, the page passed to try_to_unmap_one() is PageHead() of the
>> THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
>> aligned, this means the THP is not mapped as PMD THP in this process.
>> This could happen when we do mremap() a PMD size range to an un-aligned
>> address.
>> 
>> Currently, this case is handled by following check in __split_huge_pmd()
>> luckily.
>> 
>>   page != pmd_page(*pmd)
>> 
>> This patch checks the address to skip some work.
>
>The description here is confusing to me.
>

Sorry for the confusion.

Below is my understanding, if not correct or proper, just let me know :-)

According to current comment in __split_huge_pmd(), we check pmd_page with
page for migration case. While actually, this check also helps in the
following two cases when page already split-ed:

   * page just split-ed in place
   * page split-ed and moved to non-PMD aligned address

In both cases, pmd_page() is pointing to the PTE level page table. That's why
we don't split one already split-ed THP page.

If current code really intend to cover these two cases, sorry for my poor
understanding.

>> +	/*
>> +	 * When page is not NULL, function is called by try_to_unmap_one()
>> +	 * with TTU_SPLIT_HUGE_PMD set. There are two places set
>> +	 * TTU_SPLIT_HUGE_PMD
>> +	 *
>> +	 *     unmap_page()
>> +	 *     shrink_page_list()
>> +	 *
>> +	 * In both cases, the "page" here is the PageHead() of a THP.
>> +	 *
>> +	 * If the page is not a PMD mapped huge page, e.g. after mremap(), it
>> +	 * is not necessary to split it.
>> +	 */
>> +	if (page && !IS_ALIGNED(address, HPAGE_PMD_SIZE))
>> +		return;
>
>Repeating 75% of it as comments doesn't make it any less confusing.  And
>it feels like we're digging a pothole for someone to fall into later.
>Why not make it make sense ...
>
>	if (page && !IS_ALIGNED(address, page_size(page))
>		return;

Hmm... Use HPAGE_PMD_SIZE here wants to emphasize we want the address to be
PMD aligned. If just use page_size() here, may confuse the audience?

-- 
Wei Yang
Help you, Help me
