Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0428C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB67206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 04:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfC0ExK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:53:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:11951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfC0ExK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 00:53:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 21:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="332379504"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2019 21:53:07 -0700
Date:   Wed, 27 Mar 2019 12:37:43 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190327043743.GA20968@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-4-git-send-email-hao.wu@intel.com>
 <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
 <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
 <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
 <580c6c604d3915c105f076fc7f22ab5da98598fc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580c6c604d3915c105f076fc7f22ab5da98598fc.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:22:34PM -0500, Scott Wood wrote:
> On Tue, 2019-03-26 at 14:33 -0500, Alan Tull wrote:
> > On Mon, Mar 25, 2019 at 5:58 PM Scott Wood <swood@redhat.com> wrote:
> > 
> > Hi Scott,
> > 
> > > On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > > > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > > > +
> > > > > +#include <asm/fpu/api.h>
> > > > > +
> > > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > > +{
> > > > > +   kernel_fpu_begin();
> > > > > +
> > > > > +   asm volatile("vmovdqu64 (%0), %%zmm0;"
> > > > > +                "vmovntdq %%zmm0, (%1);"
> > > > > +                :
> > > > > +                : "r"(src), "r"(dst));
> > > > > +
> > > > > +   kernel_fpu_end();
> > > > > +}
> > > > 
> > > > Shouldn't there be some sort of check that AVX512 is actually
> > > > supported
> > > > on the running system?
> > > > 
> > > > Also, src should be const, and the asm statement should have a memory
> > > > clobber.

Yes, I will fix this in the next version.

> > > > 
> > > > > +#else
> > > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > > +{
> > > > > +   WARN_ON_ONCE(1);
> > > > > +}
> > > > > +#endif
> > > > 
> > > > Likewise, this will be called if a revision 2 device is used on non-
> > > > x86
> > > > (or on x86 with an old binutils).  The driver should fall back to 32-
> > > > bit
> > > > in such cases.

Unfortunately revision 2 is only for integrated FPGA solution, and it doesn't
support any fallback solution (original 32bit data partial reconfiguration is
not supported any more), so driver has to WARN in such path.

> > > 
> > > Sorry, I missed the comment about revision 2 only being on integrated
> > > devices -- but will that always be the case?  Seems worthwhile to check
> > > for
> > > AVX512 support anyway.  And there's still the possibility of being built
> > > with an old binutils such that CONFIG_AS_AVX512 is not set, or running
> > > on a
> > > kernel where avx512 was disabled via a boot option.
> > 
> > The code checks for CONFIG_AS_AVX512 above.
> 
> That just indicates that binutils supports it.  Plus, the code does not
> check for CONFIG_AS_AVX512 when deciding whether to set pr_datawidth to 64
> (and thus call copy512), so you'll get a WARN_ON rather than falling back to
> 32-bit.
> 
> > What boot option are you referring to?
> 
> clearcpuid=304

Just tried it, my system was down after running above AVX512 with this option.

I agree that it needs to add some check code to make sure it's safe to run
such instructions. I will add some cpu_feature_enabled() check in the next
version.

Thanks a lot for the review and comments.

Hao

> 
> -Scott
> 
