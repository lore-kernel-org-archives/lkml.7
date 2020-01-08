Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E00C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598962075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgAHAg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:36:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:39303 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHAgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:36:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 16:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="215785978"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2020 16:36:53 -0800
Date:   Wed, 8 Jan 2020 08:36:56 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20200108003656.GB13943@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20200103071846.GA16057@richard>
 <20200103130554.GA20078@richard>
 <20200103132650.jlyd37k6fcvycmy7@box>
 <20200103140128.GA26268@richard>
 <20200107120333.ncvds3atyfiilxi3@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107120333.ncvds3atyfiilxi3@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 03:03:33PM +0300, Kirill A. Shutemov wrote:
>On Fri, Jan 03, 2020 at 10:01:28PM +0800, Wei Yang wrote:
>> On Fri, Jan 03, 2020 at 04:26:50PM +0300, Kirill A. Shutemov wrote:
>> >On Fri, Jan 03, 2020 at 09:05:54PM +0800, Wei Yang wrote:
>> >> On Fri, Jan 03, 2020 at 03:18:46PM +0800, Wei Yang wrote:
>> >> >On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
>> >> >>When page is not NULL, function is called by try_to_unmap_one() with
>> >> >>TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
>> >> >>with TTU_SPLIT_HUGE_PMD set:
>> >> >>
>> >> >>  * unmap_page()
>> >> >>  * shrink_page_list()
>> >> >>
>> >> >>In both case, the page passed to try_to_unmap_one() is PageHead() of the
>> >> >>THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
>> >> >>aligned, this means the THP is not mapped as PMD THP in this process.
>> >> >>This could happen when we do mremap() a PMD size range to an un-aligned
>> >> >>address.
>> >> >>
>> >> >>Currently, this case is handled by following check in __split_huge_pmd()
>> >> >>luckily.
>> >> >>
>> >> >>  page != pmd_page(*pmd)
>> >> >>
>> >> >>This patch checks the address to skip some work.
>> >> >
>> >> >I am sorry to forget address Kirill's comment in 1st version.
>> >> >
>> >> >The first one is the performance difference after this change for a PTE
>> >> >mappged THP.
>> >> >
>> >> >Here is the result:(in cycle)
>> >> >
>> >> >        Before     Patched
>> >> >
>> >> >        963        195
>> >> >        988        40
>> >> >        895        78
>> >> >
>> >> >Average 948        104
>> >> >
>> >> >So the change reduced 90% time for function split_huge_pmd_address().
>> >
>> >Right.
>> >
>> >But do we have a scenario, where the performance of
>> >split_huge_pmd_address() matters? I mean, it it called as part of rmap
>> >walk, attempt to split huge PMD where we don't have huge PMD should be
>> >within noise.
>> 
>> Sorry for my poor English.
>> 
>> I don't catch the meaning of the last sentence. "within noise" here means
>> non-huge PMD is an expected scenario and we could tolerate this? 
>
>Basically, I doubt that this change would bring any measurable perfromance
>benefits on a real workload.
>

Ok, let's leave it now.

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
