Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020B02077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567585688;
	bh=Ieny7as6pl0RL5pwaFI+L94/0q7qhrj5SY1vnZpjLrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fChapJJfuFnSP/ooo96ep8ofh4gwXKR348PTW/HwwQ8uR/iEYj6a9hCpshW+eWYSA
	 AwkzCQ1fqGIE83ytRLTbMdTYdp3TzLnTPhxZyRRLCFQihYrwyI4GTVcX0bI+b58YED
	 tHUZIWdhD7c++AxEU1m/2ZXDyIbbYEhE0509OU/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfIDI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:28:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfIDI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77B1EAE91;
        Wed,  4 Sep 2019 08:28:05 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:28:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
Message-ID: <20190904082805.GJ3838@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
 <20190903115748.GS14028@dhcp22.suse.cz>
 <68E123A9-22A8-40ED-B2ED-897FC02D7D75@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68E123A9-22A8-40ED-B2ED-897FC02D7D75@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-09-19 21:30:30, William Kucharski wrote:
> 
> 
> > On Sep 3, 2019, at 5:57 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Mon 02-09-19 03:23:40, William Kucharski wrote:
> >> Add an 'order' argument to __page_cache_alloc() and
> >> do_read_cache_page(). Ensure the allocated pages are compound pages.
> > 
> > Why do we need to touch all the existing callers and change them to use
> > order 0 when none is actually converted to a different order? This just
> > seem to add a lot of code churn without a good reason. If anything I
> > would simply add __page_cache_alloc_order and make __page_cache_alloc
> > call it with order 0 argument.
> 
> All the EXISTING code in patch [1/2] is changed to call it with an order
> of 0, as you would expect.
> 
> However, new code in part [2/2] of the patch calls it with an order of
> HPAGE_PMD_ORDER, as it seems cleaner to have those routines operate on
> a page, regardless of the order of the page desired.
> 
> I certainly can change this as you request, but once again the question
> is whether "page" should MEAN "page" regardless of the order desired,
> or whether the assumption will always be "page" means base PAGESIZE.
> 
> Either approach works, but what is the semantic we want going forward?

I do not have anything against handling page as compound, if that is the
question. All I was interested in whether adding a new helper to
_allocate_ the comound page wouldn't be easier than touching all
existing __page_cache_alloc users.
-- 
Michal Hocko
SUSE Labs
