Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F383C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718B8206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfFTMea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:34:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:31729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfFTMea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:34:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 05:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="183052550"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2019 05:34:26 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hdwGn-00005G-OX; Thu, 20 Jun 2019 15:34:25 +0300
Date:   Thu, 20 Jun 2019 15:34:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, zyan@redhat.com, sage@redhat.com,
        agruenba@redhat.com, joe@perches.com, pmladek@suse.com,
        rostedt@goodmis.org, geert+renesas@glider.be
Subject: Re: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Message-ID: <20190620123425.GZ9224@smile.fi.intel.com>
References: <20190619164528.31958-1-jlayton@kernel.org>
 <20190620102410.GT9224@smile.fi.intel.com>
 <7c12abe8a7e6cd3cfe9129a1e74d9c788ff2f1a9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c12abe8a7e6cd3cfe9129a1e74d9c788ff2f1a9.camel@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 07:41:06AM -0400, Jeff Layton wrote:
> On Thu, 2019-06-20 at 13:24 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 19, 2019 at 12:45:25PM -0400, Jeff Layton wrote:

> > So, then don't use snprintf() for this, simple memcpy() designed for that kind
> > of things.
> > 
> 
> memcpy from what? For many of these xattrs, we need to format integer
> data into strings. I could roll my own routine to do this formatting,
> but that's sort of what sprintf and its variants are for and I'd rather
> not reimplement all of it from scratch.

So, use bigger temporary buffer and decide what to do with data if it doesn't
fit the destination one.

String without nul is not considered as a string, thus, memcpy() the data.

> > > This patch makes ceph's virtual xattrs not include NULL termination
> > > when formatting their values. In order to handle this, a new
> > > snprintf_noterm function is added, and ceph is changed over to use
> > > this to populate the xattr value buffer.
> > 
> > In terms of vsnprintf(), and actually compiler point of view, it's not a string
> > anymore, it's a text-based data.
> > 
> > Personally, I don't see an advantage of a deep intrusion into vsnprintf().
> > The wrapper can be made to achieve this w/o touching the generic code. Thus,
> > you can quickly and cleanly fix the issue, while discussing this with wider
> > audience.
> > 
> 
> Sorry, if I'm being dense but I'm not sure I follow here.
> 
> Are you suggesting I should just copy/paste most of vsnprintf into a new
> function that just leaves off the termination at the end, and leave the
> original alone?

Yes. The data you are expecting is not a string anymore from these functions
point of view. Even GCC nowadays complains on strncpy() when nul doesn't fit
the destination buffer.

> That seems like a bit of a waste, but if that's the
> consensus then ok.

My personal view is not a consensus, let's wait for more opinions.

-- 
With Best Regards,
Andy Shevchenko


