Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB2AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30582087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfD2IMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2IMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:12:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6262A309265F;
        Mon, 29 Apr 2019 08:12:51 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12CA55786;
        Mon, 29 Apr 2019 08:12:49 +0000 (UTC)
Date:   Mon, 29 Apr 2019 16:12:46 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190429081246.GT3584@localhost.localdomain>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190422091045.GB3584@localhost.localdomain>
 <20190428185408.macoxstmy5awsago@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428185408.macoxstmy5awsago@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 08:12:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/19 at 09:54pm, Kirill A. Shutemov wrote:
> > @@ -109,6 +110,14 @@ void __init kernel_randomize_memory(void)
> >  	if (memory_tb < kaslr_regions[0].size_tb)
> >  		kaslr_regions[0].size_tb = memory_tb;
> >  
> > +	/**
> 
> Nit: that is weird style for inline comment.

Right, will fix.

Thanks a lot for reviewing.

> 
> > +	 * Calculate how many TB vmemmap region needs, and aligned to
> > +	 * 1TB boundary.
> > +	 */
> > +	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> > +		sizeof(struct page);
> 
> Hm. Don't we need to take into account alignment requirements for struct
> page here? I'm worried about some exotic debug kernel config where
> sizeof(struct page) doesn't satify __alignof__(struct page).

I know sizeof(struct page) has handled its own struct alignment and
padding. About __alignof__(struct page), will it conflict with below
code to convert pfn < -- > page? Not sure if I got your point.

#elif defined(CONFIG_SPARSEMEM_VMEMMAP)

/* memmap is virtually contiguous.  */
#define __pfn_to_page(pfn)      (vmemmap + (pfn))
#define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)

#elif...


> 
> > +	kaslr_regions[2].size_tb = DIV_ROUND_UP(vmemmap_size, 1UL << TB_SHIFT);
> > +
> >  	/* Calculate entropy available between regions */
> >  	remain_entropy = vaddr_end - vaddr_start;
> >  	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
> -- 
>  Kirill A. Shutemov
