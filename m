Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31733C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CEF2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jBmdxMS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfK2LSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:18:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZZSK5G9CmqUn+L9Snie2RndpxADqX46kgik9LLqsPOc=; b=jBmdxMS5hFi6GJwiX5wdoNSro
        qPx2pEgXbYVsCXQNiH4WiWd4MYkNVd8trSnyJmXyGD296jm0i9OvZF9NAUYL6SsTI85feR8owSKJr
        i8u91HLlyYkRYr2DHxmx/ARNpu7RV8L3jyDtSrWa9VR8oPl4akU3mowdZfcJsLnDgCRN9YTVofpGT
        fxsU4LJHOjBj1u5jxQrvRvBuOn8yw/oXrTOms3rPr83bV+nv7pJBaeIGRUFoQAFBCVjVjgVv+vkqH
        tdidYQx9htrcXTa9/zx5Ou4gXmro4VdCaIQQSWEoLk86x1G44+zQieIx9JdQus5WUOHtz5Gbuvuxr
        /CuPRpEyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaeHh-0006rY-83; Fri, 29 Nov 2019 11:18:01 +0000
Date:   Fri, 29 Nov 2019 03:18:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already
 guaranteed
Message-ID: <20191129111801.GH20752@bombadil.infradead.org>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128010321.21730-2-richardw.yang@linux.intel.com>
 <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
 <20191128210945.6gtt7wlygsvxip4n@master>
 <20191128223904.GG20752@bombadil.infradead.org>
 <20191129083002.GA1669@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129083002.GA1669@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 04:30:02PM +0800, Wei Yang wrote:
> On Thu, Nov 28, 2019 at 02:39:04PM -0800, Matthew Wilcox wrote:
> >On Thu, Nov 28, 2019 at 09:09:45PM +0000, Wei Yang wrote:
> >> On Thu, Nov 28, 2019 at 11:31:43AM +0300, Kirill A. Shutemov wrote:
> >> >On Thu, Nov 28, 2019 at 09:03:21AM +0800, Wei Yang wrote:
> >> >> The check here is to guarantee pvmw->address iteration is limited in one
> >> >> page table boundary. To be specific, here the address range should be in
> >> >> one PMD_SIZE.
> >> >> 
> >> >> If my understanding is correct, this check is already done in the above
> >> >> check:
> >> >> 
> >> >>     address >= __vma_address(page, vma) + PMD_SIZE
> >> >> 
> >> >> The boundary check here seems not necessary.
> >> >> 
> >> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> >
> >> >NAK.
> >> >
> >> >THP can be mapped with PTE not aligned to PMD_SIZE. Consider mremap().
> >> >
> >> 
> >> Hi, Kirill
> >> 
> >> Thanks for your comment during Thanks Giving Day. Happy holiday:-)
> >> 
> >> I didn't think about this case before, thanks for reminding. Then I tried to
> >> understand your concern.
> >> 
> >> mremap() would expand/shrink a memory mapping. In this case, probably shrink
> >> is in concern. Since pvmw->page and pvmw->vma are not changed in the loop, the
> >> case you mentioned maybe pvmw->page is the head of a THP but part of it is
> >> unmapped.
> >
> >mremap() can also move a mapping, see MREMAP_FIXED.
> 
> Hi, Matthew
> 
> Thanks for your comment.
> 
> I took a look into the MREMAP_FIXED case, but still not clear in which case it
> fall into the situation Kirill mentioned.
> 
> Per my understanding, move mapping is achieved in two steps:
> 
>     * unmap some range in old vma if old_len >= new_len
>     * move vma
> 
> If the length doesn't change, we are expecting to have the "copy" of old
> vma. This doesn't change the THP PMD mapping.
> 
> So the change still happens in the unmap step, if I am correct.
> 
> Would you mind giving me more hint on the case when we would have the
> situation as Kirill mentioned?

Set up a THP mapping.
Move it to an address which is no longer 2MB aligned.
Unmap it.

