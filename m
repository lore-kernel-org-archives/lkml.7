Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfIJJP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:15:28 -0400
Received: from foss.arm.com ([217.140.110.172]:59534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfIJJP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:15:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4613D28;
        Tue, 10 Sep 2019 02:15:27 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2BB63F67D;
        Tue, 10 Sep 2019 02:15:23 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:15:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190910091515.GE14442@C02TF0J2HF1T.local>
References: <20190906135747.211836-1-justin.he@arm.com>
 <20190906145742.GX29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906145742.GX29434@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:57:42AM -0700, Matthew Wilcox wrote:
> On Fri, Sep 06, 2019 at 09:57:47PM +0800, Jia He wrote:
> >  		 * This really shouldn't fail, because the page is there
> >  		 * in the page tables. But it might just be unreadable,
> >  		 * in which case we just give up and fill the result with
> > -		 * zeroes.
> > +		 * zeroes. If PTE_AF is cleared on arm64, it might
> > +		 * cause double page fault. So makes pte young here
> 
> How about:
> 		 * zeroes. On architectures with software "accessed" bits,
> 		 * we would take a double page fault here, so mark it
> 		 * accessed here.
> 
> >  		 */
> > +		if (!pte_young(vmf->orig_pte)) {
> 
> Let's guard this with:
> 
> 		if (arch_sw_access_bit && !pte_young(vmf->orig_pte)) {
> 
> #define arch_sw_access_bit	0
> by default and have arm64 override it (either to a variable or a constant
> ... your choice).  Also, please somebody decide on a better name than
> arch_sw_access_bit.

I'm not good at names either (is arch_faults_on_old_pte any better?) but
I'd make this a 0 args call: arch_sw_access_bit(). This way we can make
it a static inline function on arm64 with some static label check.

-- 
Catalin
