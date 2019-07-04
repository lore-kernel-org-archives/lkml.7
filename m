Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0025C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2A6218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562273616;
	bh=fHB5OlE7wI5HD4vTrIqKCfUtCNsXUfIwuF85zxThTaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mPmGNNowWSCeQqzAZAbxvrwGub5leweKfwWI3dOum5CFEUVHipRJAPnaWKF674pK5
	 zHqPqLcggfXsifsp7ocskKtynwbFjL0MyAJ1qpIDp3TVMPDf/GAvI2wQSxW/RTRuzC
	 C8t/Gi7FqQ42iRYKYEq4Lkch0PHdgAvbQt+SNqF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfGDUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfGDUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:53:35 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D2C02083B;
        Thu,  4 Jul 2019 20:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562273613;
        bh=fHB5OlE7wI5HD4vTrIqKCfUtCNsXUfIwuF85zxThTaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OQmQWxaH1tJEFpi4jbH2I0D8Oz0s8ym/oz7j+tkYDL6g7uXejsiAtUfU38+BcV/zG
         WtCh68hjwLBB9taaYo4e3bDMPmWrR9i+UT4qpOtAdX2eFfSmQP9IMd9eq3skgpik5y
         k6rJVQlxs70evg6Q6C0OlifqVvpdw/5LksGoBaQQ=
Date:   Thu, 4 Jul 2019 13:53:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-Id: <20190704135332.234891ac6ce641bf29913d06@linux-foundation.org>
In-Reply-To: <20190704195934.GA23542@mellanox.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
        <20190626073533.GA24199@infradead.org>
        <20190626123139.GB20635@lakrids.cambridge.arm.com>
        <20190626153829.GA22138@infradead.org>
        <20190626154532.GA3088@mellanox.com>
        <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
        <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
        <20190704195934.GA23542@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 19:59:38 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Thu, Jul 04, 2019 at 11:53:24AM -0700, Andrew Morton wrote:
> > On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > > Let me know and I can help orchestate this.
> > > 
> > > Well.  Whatever works.  In this situation I'd stage the patches after
> > > linux-next and would merge them up after the prereq patches have been
> > > merged into mainline.  Easy.
> > 
> > All right, what the hell just happened? 
> 
> Christoph's patch series for the devmap & hmm rework finally made it
> into linux-next

We're talking about "dev_pagemap related cleanups v4", yes?

I note that linux-next contains "mm: remove the HMM config option"
which was present in Christoph's v3 series but wasn't present in v4. 
Perhaps something has gone wrong here.

> sorry, it took quite a few iterations on the list to
> get all the reviews and tests, and figure out how to resolve some
> other conflicting things. So it just made it this week.
> 
> Recall, this is the patch series I asked you about routing a few weeks
> ago, as it really exceeded the small area that hmm.git was supposed to
> cover. I think we are both caught off guard how big the conflict is!

I guess I was distracted - I should have taken a look to see how
mergable it all was.

It's a large patchset and it appears to be mainly (entirely?) code
cleanups.  I don't think such material would be appropriate for a late
-rc7 merge even if it didn't conflict with lots of other higher
priority pending functional changes and fixes!

