Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FCC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23644206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLWV7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:59:17 -0500
Received: from mga02.intel.com ([134.134.136.20]:7875 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfLWV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:59:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 13:59:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,349,1571727600"; 
   d="scan'208";a="207395090"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2019 13:59:15 -0800
Date:   Tue, 24 Dec 2019 05:59:14 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] mm/rmap.c: split huge pmd when it really is
Message-ID: <20191223215914.GA5156@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191223022435.30653-1-richardw.yang@linux.intel.com>
 <20191223171653.xy2ri52xymkwm3ov@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223171653.xy2ri52xymkwm3ov@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 08:16:53PM +0300, Kirill A. Shutemov wrote:
>On Mon, Dec 23, 2019 at 10:24:35AM +0800, Wei Yang wrote:
>> There are two cases to call try_to_unmap_one() with TTU_SPLIT_HUGE_PMD
>> set:
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
>> This patch checks the address to skip some hard work.
>
>Do you see some measurable performance improvement? rmap is heavy enough
>and I expect this kind of overhead to be within noise level.
>
>I don't have anything agains the check, but it complicates the picture.
>
>And if we are going this path, it worth also check if the vma is long
>enough to hold huge page.
>
>And I don't see why the check cannot be done inside split_huge_pmd_address().
>

Ok, let me put the check into split_huge_pmd_address().

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
