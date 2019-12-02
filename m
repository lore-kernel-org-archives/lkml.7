Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E65C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F80220833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLBGx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:53:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:37220 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfLBGx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:53:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 22:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="212943124"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 01 Dec 2019 22:53:54 -0800
Date:   Mon, 2 Dec 2019 14:53:47 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already
 guaranteed
Message-ID: <20191202065347.GA22786@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128010321.21730-2-richardw.yang@linux.intel.com>
 <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
 <20191128210945.6gtt7wlygsvxip4n@master>
 <20191128223904.GG20752@bombadil.infradead.org>
 <20191129083002.GA1669@richard>
 <20191129111801.GH20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129111801.GH20752@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 03:18:01AM -0800, Matthew Wilcox wrote:
>On Fri, Nov 29, 2019 at 04:30:02PM +0800, Wei Yang wrote:
>> On Thu, Nov 28, 2019 at 02:39:04PM -0800, Matthew Wilcox wrote:
>> >On Thu, Nov 28, 2019 at 09:09:45PM +0000, Wei Yang wrote:
>> >> On Thu, Nov 28, 2019 at 11:31:43AM +0300, Kirill A. Shutemov wrote:
>> >> >On Thu, Nov 28, 2019 at 09:03:21AM +0800, Wei Yang wrote:
>> >> >> The check here is to guarantee pvmw->address iteration is limited in one
>> >> >> page table boundary. To be specific, here the address range should be in
>> >> >> one PMD_SIZE.
>> >> >> 
>> >> >> If my understanding is correct, this check is already done in the above
>> >> >> check:
>> >> >> 
>> >> >>     address >= __vma_address(page, vma) + PMD_SIZE
>> >> >> 
>> >> >> The boundary check here seems not necessary.
>> >> >> 
>> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> >
>> >> >NAK.
>> >> >
>> >> >THP can be mapped with PTE not aligned to PMD_SIZE. Consider mremap().
>> >> >
>> >> 
>> >> Hi, Kirill
>> >> 
>> >> Thanks for your comment during Thanks Giving Day. Happy holiday:-)
>> >> 
>> >> I didn't think about this case before, thanks for reminding. Then I tried to
>> >> understand your concern.
>> >> 
>> >> mremap() would expand/shrink a memory mapping. In this case, probably shrink
>> >> is in concern. Since pvmw->page and pvmw->vma are not changed in the loop, the
>> >> case you mentioned maybe pvmw->page is the head of a THP but part of it is
>> >> unmapped.
>> >
>> >mremap() can also move a mapping, see MREMAP_FIXED.
>> 
>> Hi, Matthew
>> 
>> Thanks for your comment.
>> 
>> I took a look into the MREMAP_FIXED case, but still not clear in which case it
>> fall into the situation Kirill mentioned.
>> 
>> Per my understanding, move mapping is achieved in two steps:
>> 
>>     * unmap some range in old vma if old_len >= new_len
>>     * move vma
>> 
>> If the length doesn't change, we are expecting to have the "copy" of old
>> vma. This doesn't change the THP PMD mapping.
>> 
>> So the change still happens in the unmap step, if I am correct.
>> 
>> Would you mind giving me more hint on the case when we would have the
>> situation as Kirill mentioned?
>
>Set up a THP mapping.
>Move it to an address which is no longer 2MB aligned.
>Unmap it.

Thanks Matthew

I got the point, thanks a lot :-)

-- 
Wei Yang
Help you, Help me
