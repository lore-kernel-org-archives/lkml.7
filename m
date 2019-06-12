Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F0C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16440208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlKYE6/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438720AbfFLMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:14:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfFLMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MuB134CvZ+ahtWza/rg2L29zFcKfvY+JEgj2hbgZkKg=; b=SlKYE6/09sXEUzAquFUIC06H4
        msOpbvssFhXh6ebKsUighYE+VEdtmnZjrewFXkyiRYxSAQl/WcvFnZYa0b5FwldmGrKVenMSco9E1
        6FWfB+y0e40Bab9kX90noMMR2gFA5dR8H5FpHKzGw1Ltd5p5BvYCWVLY8ROHgcaghc3FGyacUrgO7
        iSHfyUeY0lSHgCslfC/lhjt4BByLi6AbKVYLux4inMb8UDigONXt70fjSU37Arnqpwi7dbv58VjEQ
        vH2hAYeAPbYyjpGX0Jqdl0Ni7A0BybKwlb0QiRCbr400bcOMxDtEOfDtTXiA/WIcNvTpfTxDT3UAR
        owMPzAq9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hb28a-00011T-SF; Wed, 12 Jun 2019 12:13:56 +0000
Date:   Wed, 12 Jun 2019 05:13:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thellstrom@vmwopensource.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v5 3/9] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20190612121356.GA719@infradead.org>
References: <20190612064243.55340-1-thellstrom@vmwopensource.org>
 <20190612064243.55340-4-thellstrom@vmwopensource.org>
 <20190612112349.GA20226@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612112349.GA20226@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 04:23:50AM -0700, Christoph Hellwig wrote:
> friends.  Also in general new core functionality like this should go
> along with the actual user, we don't need to repeat the hmm disaster.

Ok, I see you actually did that, it just got hidden by the awful
selective cc stuff a lot of people do at the moment.  Sorry for the
noise.
