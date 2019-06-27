Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A7C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0821841
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561606554;
	bh=VbXYrl8hV0yD1BgA3FSNiW43CpbVpvSODNnRganJGDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SYwcUFeFA36yMKm4OElADXdoRuqYAs945t35GzKxVhXfx+4VFC0r4WczjEDT7LAXj
	 GTqHQsAdBYOkb5uLdKiJ1o6jV50c9InvSYIfqaEWG9q+mGaw2mPe1AnN9i0+t+HxUu
	 o5MjEwju0wWinKzBChLqiF6tqu2sB89p3nBQ9IzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfF0Dfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfF0Dfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:35:52 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C898C216E3;
        Thu, 27 Jun 2019 03:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561606552;
        bh=VbXYrl8hV0yD1BgA3FSNiW43CpbVpvSODNnRganJGDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJNVSV/gh5CVGeGNXpkcW2nF9iUxd1Sdk2X1TV3BnRqByggZqSGbDMq/6dRMBaEd6
         X2eUMCkVnjulZ29brgN5QAbJUKPSXyQbRJD2zzaU60IjlrKzh1AKlvGVn63QYi9OzC
         IK+TVy8Lf1kt5G+0QGXbfgv6unH4vFb+A9uGD3oE=
Date:   Wed, 26 Jun 2019 20:35:51 -0700
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
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Message-Id: <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
In-Reply-To: <20190626154532.GA3088@mellanox.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
        <20190626073533.GA24199@infradead.org>
        <20190626123139.GB20635@lakrids.cambridge.arm.com>
        <20190626153829.GA22138@infradead.org>
        <20190626154532.GA3088@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 15:45:47 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Wed, Jun 26, 2019 at 08:38:29AM -0700, Christoph Hellwig wrote:
> > On Wed, Jun 26, 2019 at 01:31:40PM +0100, Mark Rutland wrote:
> > > On Wed, Jun 26, 2019 at 12:35:33AM -0700, Christoph Hellwig wrote:
> > > > Robin, Andrew:
> > > 
> > > As a heads-up, Robin is currently on holiday, so this is all down to
> > > Andrew's preference.
> > > 
> > > > I have a series for the hmm tree, which touches the section size
> > > > bits, and remove device public memory support.
> > > > 
> > > > It might be best if we include this series in the hmm tree as well
> > > > to avoid conflicts.  Is it ok to include the rebase version of at least
> > > > the cleanup part (which looks like it is not required for the actual
> > > > arm64 support) in the hmm tree to avoid conflicts?
> > > 
> > > Per the cover letter, the arm64 patch has a build dependency on the
> > > others, so that might require a stable brnach for the common prefix.
> > 
> > I guess we'll just have to live with the merge errors then, as the
> > mm tree is a patch series and thus can't easily use a stable base
> > tree.  That is unlike Andrew wants to pull in the hmm tree as a prep
> > patch for the series.
> 
> It looks like the first three patches apply cleanly to hmm.git ..
> 
> So what we can do is base this 4 patch series off rc6 and pull the
> first 3 into hmm and the full 4 into arm.git. We use this workflow often
> with rdma and netdev.
> 
> Let me know and I can help orchestate this.

Well.  Whatever works.  In this situation I'd stage the patches after
linux-next and would merge them up after the prereq patches have been
merged into mainline.  Easy.

