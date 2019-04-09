Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E752084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfDIPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:21:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:40140 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfDIPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:21:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 08:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="335205951"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 08:21:31 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDsZ0-0004gu-6p; Tue, 09 Apr 2019 18:21:30 +0300
Date:   Tue, 9 Apr 2019 18:21:30 +0300
From:   Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Message-ID: <20190409152130.GS9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100049.GC9224@smile.fi.intel.com>
 <20190409100436.GA28683@infradead.org>
 <20190409103030.GK9224@smile.fi.intel.com>
 <20190409145308.GZ14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409145308.GZ14111@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 07:53:08AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 09, 2019 at 01:30:30PM +0300, Andriy Shevchenko wrote:
> > On Tue, Apr 09, 2019 at 03:04:36AM -0700, Christoph Hellwig wrote:
> > > On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> > > > I think it makes sense to add a helper macro to rcupdate.h
> > > > (and we have several cases in kernel that can utilize it)
> > > > 
> > > > #define kfree_non_null_rcu(ptr, rcu_head)		\
> > > > 	do {						\
> > > > 		if (ptr)				\
> > > > 			kfree_rcu(ptr, rcu_head);	\
> > > > 	} while (0)
> > > > 
> > > > as a more common pattern for resource deallocators.
> > > 
> > > I think that should move straight into kfree_rcu.  
> > 
> > Possible. I didn't dare to offer this due to lack of knowledge how it's used in
> > other places.
> > 
> > > In general
> > > we expect *free* to deal with NULL pointers transparently, so we
> > > should do so here as well.
> > 
> > Exactly my point, thanks.
> 
> As shown below?

Looks pretty much good to me, thanks!
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> And now that you mention it, it is a bit surprising that no one has
> complained before.  ;-)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 23ad938244968e9d2a8001a1c52887c113b182f6
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Tue Apr 9 07:48:18 2019 -0700
> 
>     rcu: Make kfree_rcu() ignore NULL pointers
>     
>     This commit makes the kfree_rcu() macro's semantics be consistent
>     with the likes of kfree() by adding a check for NULL pointers, so
>     that kfree_rcu(NULL, ...) is a no-op.
>     
>     Reported-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
>     Reported-by: Christoph Hellwig <hch@infradead.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 922bb6848813..c68649b9bcec 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -828,9 +828,13 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>   * checks are done in macros here.
>   */
> -#define kfree_rcu(ptr, rcu_head)					\
> -	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
> -
> +#define kfree_rcu(ptr, rhf)						\
> +do {									\
> +	typeof (ptr) ___p = (ptr);					\
> +									\
> +	if (___p)							\
> +		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
> +} while (0)
>  
>  /*
>   * Place this after a lock-acquisition primitive to guarantee that
> 

-- 
With Best Regards,
Andy Shevchenko


