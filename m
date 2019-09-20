Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A7E20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hETyHfgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbfITPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:53:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404366AbfITPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ehfHqKGq02VDpyHgsdO6CgZKeSAkHux13i46LeTOUmM=; b=hETyHfglQKP6WR4B6RG5ZmaQD
        95C2f8tvVoss9pKS2CCwzh/44MR1IyzmMPxDliQc4yCQ4itL0mJex15dHhpw1ucGzyvOIO7o/jsr7
        jofX0RjUj16USAEJCkU3VblfmrZvkT5X3grzhzOtxns4zR2HeKwp0ROGCYgr/6BZWsnrt9hrMJC3U
        bETYi0g+1ASXehjzUWv0+6FhtyBB+Nw3ivPf83z/RYRa49ay5KeoJIdddaB1O9dxBB6XaaxuRiInX
        rHEQfzmMWnXGaWIFmspCPjhFUtiTIqXfCX4myMqxSQyzp0jeHAhd2Ls8a2bZrR+3pzmi6iObihOnT
        tQ1driPtQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBLDQ-0003vK-Bt; Fri, 20 Sep 2019 15:53:00 +0000
Date:   Fri, 20 Sep 2019 08:53:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190920155300.GC15392@bombadil.infradead.org>
References: <20190920135437.25622-1-justin.he@arm.com>
 <20190920135437.25622-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920135437.25622-4-justin.he@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:54:37PM +0800, Jia He wrote:
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline int cow_user_page(struct page *dst, struct page *src,
> +				struct vm_fault *vmf)
>  {

Can we talk about the return type here?

> +			} else {
> +				/* Other thread has already handled the fault
> +				 * and we don't need to do anything. If it's
> +				 * not the case, the fault will be triggered
> +				 * again on the same address.
> +				 */
> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				return -1;
...
> +	return 0;
>  }

So -1 for "try again" and 0 for "succeeded".

> +		if (cow_user_page(new_page, old_page, vmf)) {

Then we use it like a bool.  But it's kind of backwards from a bool because
false is success.

> +			/* COW failed, if the fault was solved by other,
> +			 * it's fine. If not, userspace would re-fault on
> +			 * the same address and we will handle the fault
> +			 * from the second attempt.
> +			 */
> +			put_page(new_page);
> +			if (old_page)
> +				put_page(old_page);
> +			return 0;

And we don't use the return value; in fact we invert it.

Would this make more sense:

static inline bool cow_user_page(struct page *dst, struct page *src,
					struct vm_fault *vmf)
...
				pte_unmap_unlock(vmf->pte, vmf->ptl);
				return false;
...
	return true;
...
		if (!cow_user_page(new_page, old_page, vmf)) {

That reads more sensibly for me.  We could also go with returning a
vm_fault_t, but that would be more complex than needed today, I think.
