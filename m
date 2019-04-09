Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDEC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149720883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDIPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:39:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:56593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIPjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:39:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 08:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="141357461"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2019 08:39:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDsqc-0004q6-Us; Tue, 09 Apr 2019 18:39:42 +0300
Date:   Tue, 9 Apr 2019 18:39:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <20190409153942.GW9224@smile.fi.intel.com>
References: <20190408130212.0a41f2a8@canb.auug.org.au>
 <20190408091458.00004e48@huawei.com>
 <20190408100121.GH9224@smile.fi.intel.com>
 <20190408111439.000049bc@huawei.com>
 <20190408103437.GK9224@smile.fi.intel.com>
 <20190408130151.0000278a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408130151.0000278a@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 01:01:51PM +0100, Jonathan Cameron wrote:
> On Mon, 8 Apr 2019 13:34:37 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 08, 2019 at 11:14:39AM +0100, Jonathan Cameron wrote:
> > > On Mon, 8 Apr 2019 13:01:21 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > > On Mon, Apr 08, 2019 at 09:14:58AM +0100, Jonathan Cameron wrote:  
> > > > > On Mon, 8 Apr 2019 13:02:12 +1000
> > > > > Stephen Rothwell <sfr@canb.auug.org.au> wrote:  

> > > > > That is the correct resolution.    
> > > > 
> > > > I think it still misses the following fix:  
> > 
> > > Is that actually a problem given it's copied over from buffer->scan_mask just after allocation?
> > > The two masks are the same length so I don't think we have a problem with this one.
> > > Am I missing something?  
> > 
> > Hmm... I didn't get why the commit 20ea39ef9f2f fixes anything.
> > 
> Good point.  I'm don't think it ever did.  
> 
> Alex, any thoughts?

I have a thought that it might be possible that somewhere code is still broken,
i.e. accessing bitmap behind the size (for example, iterating by unsigned long
without bitmap size being aligned to size of unsigned long).

If this is a case, the mentioned patch has a symptomatic healing and not fixing
a root cause.

-- 
With Best Regards,
Andy Shevchenko


