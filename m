Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DC82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfC0F0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:26:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:44911 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfC0F0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:26:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 22:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="156141349"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 26 Mar 2019 22:26:04 -0700
Date:   Wed, 27 Mar 2019 13:10:40 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190327051040.GB20968@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-4-git-send-email-hao.wu@intel.com>
 <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
 <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:58:36PM -0500, Scott Wood wrote:
> On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > In early partial reconfiguration private feature, it only
> > > supports 32bit data width when writing data to hardware for
> > > PR. 512bit data width PR support is an important optimization
> > > for some specific solutions (e.g. XEON with FPGA integrated),
> > > it allows driver to use AVX512 instruction to improve the
> > > performance of partial reconfiguration. e.g. programming one
> > > 100MB bitstream image via this 512bit data width PR hardware
> > > only takes ~300ms, but 32bit revision requires ~3s per test
> > > result.
> > > 
> > > Please note now this optimization is only done on revision 2
> > > of this PR private feature which is only used in integrated
> > > solution that AVX512 is always supported.
> > > 
> > > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > ---
> > >  drivers/fpga/dfl-fme-main.c |  3 ++
> > >  drivers/fpga/dfl-fme-mgr.c  | 75 +++++++++++++++++++++++++++++++++++++-
> > > --
> > > -----
> > >  drivers/fpga/dfl-fme-pr.c   | 45 ++++++++++++++++-----------
> > >  drivers/fpga/dfl-fme.h      |  2 ++
> > >  drivers/fpga/dfl.h          |  5 +++
> > >  5 files changed, 99 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > > index 086ad24..076d74f 100644
> > > --- a/drivers/fpga/dfl-fme-main.c
> > > +++ b/drivers/fpga/dfl-fme-main.c
> > > @@ -21,6 +21,8 @@
> > >  #include "dfl.h"
> > >  #include "dfl-fme.h"
> > >  
> > > +#define DRV_VERSION	"0.8"
> > 
> > What is this going to be used for?  Under what circumstances will the
> > driver version be bumped?  What does it have to do with 512-bit writes?

This patchset adds more features to this driver, so i would like to add
a DRV_VERSION there as an initial one. In the future, if some new features
or extensions for existing features (e.g. new revision of a private feature)
are added we need to bump this version.

> > 
> > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > +
> > > +#include <asm/fpu/api.h>
> > > +
> > > +static inline void copy512(void *src, void __iomem *dst)
> > > +{
> > > +	kernel_fpu_begin();
> > > +
> > > +	asm volatile("vmovdqu64 (%0), %%zmm0;"
> > > +		     "vmovntdq %%zmm0, (%1);"
> > > +		     :
> > > +		     : "r"(src), "r"(dst));
> > > +
> > > +	kernel_fpu_end();
> > > +}
> > 
> > Shouldn't there be some sort of check that AVX512 is actually supported
> > on the running system?
> > 
> > Also, src should be const, and the asm statement should have a memory
> > clobber.
> > 
> > > +#else
> > > +static inline void copy512(void *src, void __iomem *dst)
> > > +{
> > > +	WARN_ON_ONCE(1);
> > > +}
> > > +#endif
> > 
> > Likewise, this will be called if a revision 2 device is used on non-x86
> > (or on x86 with an old binutils).  The driver should fall back to 32-bit
> > in such cases.
> 
> Sorry, I missed the comment about revision 2 only being on integrated
> devices -- but will that always be the case?  Seems worthwhile to check for
> AVX512 support anyway.  And there's still the possibility of being built
> with an old binutils such that CONFIG_AS_AVX512 is not set, or running on a
> kernel where avx512 was disabled via a boot option.
> 
> What about future revisions >= 2?  Currently the driver will treat them as
> if they were revision < 2.  Is that intended?

Yes, it's intended. Currently we don't have any hardware with revisions > 2,
and support new revisions may need new code. :)  e.g. currently revision is
used to tell 32bit vs 512bit PR, but in future revisions, it may have new
capability registers for this purpose.

Thanks
Hao

> 
> -Scott
> 
