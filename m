Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC621871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfC2CuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:50:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:55571 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfC2CuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:50:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 19:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,283,1549958400"; 
   d="scan'208";a="131143137"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2019 19:50:13 -0700
Date:   Thu, 28 Mar 2019 11:49:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 06/11] mm/hmm: improve driver API to work and wait
 over a range v2
Message-ID: <20190328184906.GL31324@iweiny-DESK2.sc.intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-7-jglisse@redhat.com>
 <20190328161221.GE31324@iweiny-DESK2.sc.intel.com>
 <20190329005654.GA16680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329005654.GA16680@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:56:54PM -0400, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 09:12:21AM -0700, Ira Weiny wrote:
> > On Mon, Mar 25, 2019 at 10:40:06AM -0400, Jerome Glisse wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 

[snip]

> > > +/*
> > > + * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
> > > + *
> > > + * When waiting for mmu notifiers we need some kind of time out otherwise we
> > > + * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
> > > + * wait already.
> > > + */
> > > +#define HMM_RANGE_DEFAULT_TIMEOUT 1000
> > > +
> > >  /* This is a temporary helper to avoid merge conflict between trees. */
> > > +static inline bool hmm_vma_range_done(struct hmm_range *range)
> > > +{
> > > +	bool ret = hmm_range_valid(range);
> > > +
> > > +	hmm_range_unregister(range);
> > > +	return ret;
> > > +}
> > > +
> > >  static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> > >  {
> > > -	long ret = hmm_range_fault(range, block);
> > > -	if (ret == -EBUSY)
> > > -		ret = -EAGAIN;
> > > -	else if (ret == -EAGAIN)
> > > -		ret = -EBUSY;
> > > -	return ret < 0 ? ret : 0;
> > > +	long ret;
> > > +
> > > +	ret = hmm_range_register(range, range->vma->vm_mm,
> > > +				 range->start, range->end);
> > > +	if (ret)
> > > +		return (int)ret;
> > > +
> > > +	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> > > +		up_read(&range->vma->vm_mm->mmap_sem);
> > > +		return -EAGAIN;
> > > +	}
> > > +
> > > +	ret = hmm_range_fault(range, block);
> > > +	if (ret <= 0) {
> > > +		if (ret == -EBUSY || !ret) {
> > > +			up_read(&range->vma->vm_mm->mmap_sem);
> > > +			ret = -EBUSY;
> > > +		} else if (ret == -EAGAIN)
> > > +			ret = -EBUSY;
> > > +		hmm_range_unregister(range);
> > > +		return ret;
> > > +	}
> > > +	return 0;
> > 
> > Is hmm_vma_fault() also temporary to keep the nouveau driver working?  It looks
> > like it to me.
> > 
> > This and hmm_vma_range_done() above are part of the old interface which is in
> > the Documentation correct?  As stated above we should probably change that
> > documentation with this patch to ensure no new users of these 2 functions
> > appear.
> 
> Ok will update the documentation, note that i already posted patches to use
> this new API see the ODP RDMA link in the cover letter.
> 

Thanks,  Sorry for my previous email on this patch.  After looking more I see
that this is the old interface but this was not clear.  And I have not had time
to follow the previous threads.  I'm finding time to do this now...

Sorry,
Ira

