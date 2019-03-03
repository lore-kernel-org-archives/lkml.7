Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3884C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14AA20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfCDA5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:57:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:50487 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCDA5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:57:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 16:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="137790581"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2019 16:57:31 -0800
Date:   Sun, 3 Mar 2019 08:55:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Artemy Kovalyov <artemyko@mellanox.com>
Cc:     "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error
 handling paths
Message-ID: <20190303165550.GB27123@iweiny-DESK2.sc.intel.com>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 11:52:41AM +0200, Artemy Kovalyov wrote:
> 
> 
> On 02/03/2019 21:44, Ira Weiny wrote:
> > 
> > On Sat, Mar 02, 2019 at 12:24:35PM -0800, john.hubbard@gmail.com wrote:
> > > From: John Hubbard <jhubbard@nvidia.com>
> > > 
> > > ...
> > > 3. Dead code removal: the check for (user_virt & ~page_mask)
> > > is checking for a condition that can never happen,
> > > because earlier:
> > > 
> > >      user_virt = user_virt & page_mask;
> > > 
> > > ...so, remove that entire phrase.
> > > 
> > >   		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
> > >   		mutex_lock(&umem_odp->umem_mutex);
> > >   		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
> > > -			if (user_virt & ~page_mask) {
> > > -				p += PAGE_SIZE;
> > > -				if (page_to_phys(local_page_list[j]) != p) {
> > > -					ret = -EFAULT;
> > > -					break;
> > > -				}
> > > -				put_page(local_page_list[j]);
> > > -				continue;
> > > -			}
> > > -
> > 
> > I think this is trying to account for compound pages. (ie page_mask could
> > represent more than PAGE_SIZE which is what user_virt is being incrimented by.)
> > But putting the page in that case seems to be the wrong thing to do?
> > 
> > Yes this was added by Artemy[1] now cc'ed.
> 
> Right, this is for huge pages, please keep it.
> put_page() needed to decrement refcount of the head page.

You mean decrement the refcount of the _non_-head pages?

Ira

> 
