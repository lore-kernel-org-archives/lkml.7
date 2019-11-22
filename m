Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03807C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46B2205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKVQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:49:46 -0500
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:38207 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbfKVQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:49:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DD3195DE6;
        Fri, 22 Nov 2019 16:49:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hole56_37d7e5c41a81d
X-Filterd-Recvd-Size: 3502
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Nov 2019 16:49:43 +0000 (UTC)
Message-ID: <2ab69d678d82a37ac89ea8421bd7e93e356e7456.camel@perches.com>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Nov 2019 08:49:19 -0800
In-Reply-To: <1574441218.9585.26.camel@lca.pw>
References: <20191122025510.4319-1-cai@lca.pw>
         <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
         <1574434760.9585.18.camel@lca.pw>
         <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
         <1574441218.9585.26.camel@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-22 at 11:46 -0500, Qian Cai wrote:
> On Fri, 2019-11-22 at 08:28 -0800, Joe Perches wrote:
> > On Fri, 2019-11-22 at 09:59 -0500, Qian Cai wrote:
> > > On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> > > > On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > > > > When running heavy memory pressure workloads, this 5+ old system is
> > > > > throwing endless warnings below because disk IO is too slow to recover
> > > > > from swapping. Since the volume from alloc_iova_fast() could be large,
> > > > > once it calls printk(), it will trigger disk IO (writing to the log
> > > > > files) and pending softirqs which could cause an infinite loop and make
> > > > > no progress for days by the ongoimng memory reclaim. This is the counter
> > > > > part for Intel where the AMD part has already been merged. See the
> > > > > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > > > > pressure"). Since the allocation failure will be reported in
> > > > > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > > > > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> > > > 
> > > > []
> > > > > v2: use dev_err_ratelimited() and improve the commit messages.
> > > > 
> > > > []
> > > > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > > > 
> > > > []
> > > > > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> > > > >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> > > > >  				   IOVA_PFN(dma_mask), true);
> > > > >  	if (unlikely(!iova_pfn)) {
> > > > > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > > > > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > > > > +				    nrpages);
> > > > 
> > > > Trivia:
> > > > 
> > > > This should really have a \n termination on the format string
> > > > 
> > > > 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> > > > 
> > > > 
> > > 
> > > Why do you say so? It is right now printing with a newline added anyway.
> > > 
> > >  hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
> > 
> > If another process uses pr_cont at the same time,
> > it can be interleaved.
> 
> I lean towards fixing that in a separate patch if ever needed, as the origin
> dev_err() has no "\n" enclosed either.

Your choice.

I wrote trivia:, but touching the same line multiple times
is relatively pointless.



